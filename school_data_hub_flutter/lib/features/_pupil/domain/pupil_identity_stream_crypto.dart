import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';

const _identityKeyStorageKey = 'pupil_identity_identity_key';
const _hkdfInfoStreamId = 'pupil_identity_private_stream_v1';
const _hkdfInfoAesKey = 'pupil_identity_aes_key_v1';

final _log = Logger('PupilIdentityStreamCrypto');

/// Result of a successful handshake: private stream id and encrypt/decrypt.
class PupilIdentitySession {
  PupilIdentitySession({
    required this.privateStreamId,
    required SecretKey secretKey,
    required AesGcm aesGcm,
  }) : _secretKey = secretKey,
       _aesGcm = aesGcm {
    _log.info(
      'Private stream session created: streamId=${privateStreamId.substring(0, privateStreamId.length > 12 ? 12 : privateStreamId.length)}...',
    );
  }

  final String privateStreamId;
  final SecretKey _secretKey;
  final AesGcm _aesGcm;

  Future<String> encryptValueAsync(String plain) async {
    _log.fine(
      'Private stream encrypt (streamId=${privateStreamId.substring(0, privateStreamId.length > 8 ? 8 : privateStreamId.length)}..., length=${plain.length})',
    );
    final secretBox = await _aesGcm.encrypt(
      utf8.encode(plain),
      secretKey: _secretKey,
    );
    return base64.encode(secretBox.concatenation());
  }

  Future<String?> decryptValueAsync(String cipherBase64) async {
    _log.fine(
      'Private stream decrypt (streamId=${privateStreamId.substring(0, privateStreamId.length > 8 ? 8 : privateStreamId.length)}..., cipherLength=${cipherBase64.length})',
    );
    try {
      final bytes = base64.decode(cipherBase64);
      final secretBox = SecretBox.fromConcatenation(
        bytes,
        nonceLength: _aesGcm.nonceLength,
        macLength: _aesGcm.macAlgorithm.macLength,
      );
      final decrypted = await _aesGcm.decrypt(secretBox, secretKey: _secretKey);
      return utf8.decode(decrypted);
    } catch (e) {
      _log.warning('Decrypt failed: $e');
      return null;
    }
  }
}

/// Handshake message for public stream (signaling).
class HandshakeMessage {
  HandshakeMessage({
    required this.type,
    required this.pubKeyBase64,
    this.identityPubKeyBase64,
    required this.signatureBase64,
    required this.timestampMillis,
  });

  final String type; // 'handshake_init' | 'handshake_response'
  final String pubKeyBase64; // X25519 ephemeral public key
  final String?
  identityPubKeyBase64; // Ed25519 identity public key (for verification)
  final String signatureBase64;
  final int timestampMillis;

  String toJson() => jsonEncode({
    'type': type,
    'pubKey': pubKeyBase64,
    if (identityPubKeyBase64 != null) 'identityPubKey': identityPubKeyBase64,
    'signature': signatureBase64,
    'ts': timestampMillis,
  });

  static HandshakeMessage? fromJson(String jsonString) {
    try {
      final m = jsonDecode(jsonString) as Map<String, dynamic>;
      final type = m['type'] as String?;
      final pubKey = m['pubKey'] as String?;
      final signature = m['signature'] as String?;
      final ts = m['ts'] as int?;
      if (type == null || pubKey == null || signature == null || ts == null) {
        return null;
      }
      return HandshakeMessage(
        type: type,
        pubKeyBase64: pubKey,
        identityPubKeyBase64: m['identityPubKey'] as String?,
        signatureBase64: signature,
        timestampMillis: (ts as num).round(),
      );
    } catch (_) {
      return null;
    }
  }
}

/// Result of creating handshake_init or handshake_response: message + ephemeral key bytes for completeSession.
class HandshakeResult {
  HandshakeResult({
    required this.message,
    required this.myEphemeralPrivateBytes,
    required this.myEphemeralPublicBytes,
  });

  final HandshakeMessage message;
  final List<int> myEphemeralPrivateBytes;
  final List<int> myEphemeralPublicBytes;
}

/// Crypto for pupil identity stream: identity key (Ed25519), session (X25519),
/// HKDF derivation, and AesGcm for the private stream.
class PupilIdentityStreamCrypto {
  final Ed25519 _ed25519 = Ed25519();
  final X25519 _x25519 = X25519();
  final AesGcm _aesGcm = AesGcm.with256bits();
  final Hkdf _hkdf = Hkdf(hmac: Hmac.sha256(), outputLength: 32);

  /// Ensures identity key exists; returns the public key bytes (for fingerprint or handshake).
  Future<List<int>> ensureIdentityKey() async {
    final keyPair = await _loadIdentityKeyPair();
    final pub = await keyPair.extractPublicKey();
    _log.info(
      'Pupil identity stream crypto: identity key ensured (public key length=${pub.bytes.length})',
    );
    return pub.bytes;
  }

  /// Creates handshake_init payload (sender). Returns message and ephemeral key bytes for completeSession.
  Future<HandshakeResult> createHandshakeInit(String channelName) async {
    _log.info('PupilIdentityStreamCrypto: createHandshakeInit started (channel=$channelName)');
    final identityKeyPair = await _loadIdentityKeyPair();
    final identityPub = await identityKeyPair.extractPublicKey();
    final ephemeralKeyPair = await _x25519.newKeyPair();
    final ephemeralPub = await ephemeralKeyPair.extractPublicKey();
    final ephemeralPriv = await ephemeralKeyPair.extractPrivateKeyBytes();
    final ts = DateTime.now().millisecondsSinceEpoch;
    final payload = '$channelName|${base64.encode(ephemeralPub.bytes)}|$ts';
    final signature = await _ed25519.sign(
      utf8.encode(payload),
      keyPair: identityKeyPair,
    );
    _log.info(
      'Pupil identity stream crypto: created handshake_init for channel=$channelName',
    );
    return HandshakeResult(
      message: HandshakeMessage(
        type: 'handshake_init',
        pubKeyBase64: base64.encode(ephemeralPub.bytes),
        identityPubKeyBase64: base64.encode(identityPub.bytes),
        signatureBase64: base64.encode(signature.bytes),
        timestampMillis: ts,
      ),
      myEphemeralPrivateBytes: ephemeralPriv,
      myEphemeralPublicBytes: ephemeralPub.bytes,
    );
  }

  /// Creates handshake_response payload (receiver). Returns message and ephemeral key bytes for completeSession.
  Future<HandshakeResult> createHandshakeResponse(
    String channelName,
    HandshakeMessage initFromSender,
  ) async {
    _log.info('PupilIdentityStreamCrypto: createHandshakeResponse started (channel=$channelName)');
    if (initFromSender.type != 'handshake_init') {
      throw ArgumentError('Expected handshake_init');
    }
    final identityKeyPair = await _loadIdentityKeyPair();
    final identityPub = await identityKeyPair.extractPublicKey();
    final ephemeralKeyPair = await _x25519.newKeyPair();
    final ephemeralPub = await ephemeralKeyPair.extractPublicKey();
    final ephemeralPriv = await ephemeralKeyPair.extractPrivateKeyBytes();
    final ts = DateTime.now().millisecondsSinceEpoch;
    final payload = '$channelName|${base64.encode(ephemeralPub.bytes)}|$ts';
    final signature = await _ed25519.sign(
      utf8.encode(payload),
      keyPair: identityKeyPair,
    );
    _log.info(
      'Pupil identity stream crypto: created handshake_response for channel=$channelName',
    );
    return HandshakeResult(
      message: HandshakeMessage(
        type: 'handshake_response',
        pubKeyBase64: base64.encode(ephemeralPub.bytes),
        identityPubKeyBase64: base64.encode(identityPub.bytes),
        signatureBase64: base64.encode(signature.bytes),
        timestampMillis: ts,
      ),
      myEphemeralPrivateBytes: ephemeralPriv,
      myEphemeralPublicBytes: ephemeralPub.bytes,
    );
  }

  /// Verifies the other party's handshake (signature over channelName|pubKey|ts with their identity key).
  /// The identity key is taken from the handshake message (TOFU). Stronger assurance would require
  /// pre-shared or server-pinned identity keys.
  /// Rejects if timestamp is older than 2 minutes (replay protection).
  Future<bool> verifyHandshake(
    String channelName,
    HandshakeMessage message,
    List<int> theirIdentityPublicKeyBytes,
  ) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    if ((now - message.timestampMillis).abs() > 120000) {
      _log.warning(
        'Pupil identity stream crypto: verifyHandshake rejected (timestamp stale, type=${message.type})',
      );
      return false;
    }
    final payload =
        '$channelName|${message.pubKeyBase64}|${message.timestampMillis}';
    final signature = Signature(
      base64.decode(message.signatureBase64),
      publicKey: SimplePublicKey(
        theirIdentityPublicKeyBytes,
        type: _ed25519.keyPairType,
      ),
    );
    final ok = await _ed25519.verify(
      utf8.encode(payload),
      signature: signature,
    );
    _log.info(
      'Pupil identity stream crypto: verifyHandshake ${ok ? "OK" : "FAILED"} (type=${message.type}, channel=$channelName)',
    );
    return ok;
  }

  /// Completes session: ECDH + HKDF, returns session with encrypt/decrypt.
  Future<PupilIdentitySession> completeSession(
    List<int> myEphemeralPrivateKeyBytes,
    List<int> myEphemeralPublicKeyBytes,
    String theirEphemeralPubKeyBase64,
  ) async {
    final theirPubBytes = base64.decode(theirEphemeralPubKeyBase64);
    final myKeyPair = SimpleKeyPairData(
      myEphemeralPrivateKeyBytes,
      publicKey: SimplePublicKey(
        myEphemeralPublicKeyBytes,
        type: _x25519.keyPairType,
      ),
      type: _x25519.keyPairType,
    );
    final sharedSecret = await _x25519.sharedSecretKey(
      keyPair: myKeyPair,
      remotePublicKey: SimplePublicKey(
        theirPubBytes,
        type: _x25519.keyPairType,
      ),
    );
    final sharedSecretBytes = await sharedSecret.extractBytes();
    final secretKeyInput = SecretKey(sharedSecretBytes);

    final streamIdKey = await _hkdf.deriveKey(
      secretKey: secretKeyInput,
      nonce: utf8.encode(_hkdfInfoStreamId),
      info: [],
    );
    final streamIdBytes = await streamIdKey.extractBytes();
    final privateStreamId = base64Url.encode(streamIdBytes);

    final aesKeyResult = await _hkdf.deriveKey(
      secretKey: secretKeyInput,
      nonce: utf8.encode(_hkdfInfoAesKey),
      info: [],
    );
    final aesKeyBytes = await aesKeyResult.extractBytes();
    final sessionKey = SecretKey(aesKeyBytes);

    _log.info(
      'Pupil identity stream crypto: completeSession -> privateStreamId=${privateStreamId.substring(0, privateStreamId.length > 16 ? 16 : privateStreamId.length)}...',
    );
    return PupilIdentitySession(
      privateStreamId: privateStreamId,
      secretKey: sessionKey,
      aesGcm: _aesGcm,
    );
  }

  /// Loads or creates the Ed25519 identity key pair from secure storage.
  /// If the key is re-generated (e.g. after corruption), previous handshakes
  /// with peers are no longer verifiable until identity public keys are re-exchanged.
  Future<SimpleKeyPair> _loadIdentityKeyPair() async {
    final storage = HubSecureStorage();
    final stored = await storage.getString(_identityKeyStorageKey);
    if (stored == null || stored.isEmpty) {
      _log.info('Pupil identity stream crypto: identity key created (new)');
      final k = await _ed25519.newKeyPair();
      final pub = await k.extractPublicKey();
      final priv = await k.extractPrivateKeyBytes();
      await storage.setString(
        _identityKeyStorageKey,
        '${base64.encode(priv)}|${base64.encode(pub.bytes)}',
      );
      return k;
    }
    final parts = stored.split('|');
    if (parts.length < 2) {
      _log.info(
        'Pupil identity stream crypto: identity key created (re-generated after invalid storage)',
      );
      final k = await _ed25519.newKeyPair();
      final pub = await k.extractPublicKey();
      final priv = await k.extractPrivateKeyBytes();
      await storage.setString(
        _identityKeyStorageKey,
        '${base64.encode(priv)}|${base64.encode(pub.bytes)}',
      );
      return k;
    }
    _log.fine('Pupil identity stream crypto: identity key loaded from storage');
    final privBytes = base64.decode(parts[0]);
    final pubBytes = base64.decode(parts[1]);
    return SimpleKeyPairData(
      privBytes,
      publicKey: SimplePublicKey(pubBytes, type: _ed25519.keyPairType),
      type: _ed25519.keyPairType,
    );
  }
}

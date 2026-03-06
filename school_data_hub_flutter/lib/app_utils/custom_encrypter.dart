import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pointycastle/export.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';

// --- Top-level isolate-safe decryption (no GetIt/EnvManager) ---

Uint8List _normalizeKeyTopLevel(Uint8List keyBytes) {
  if (keyBytes.length == 16) return keyBytes;
  if (keyBytes.length == 32) return keyBytes;
  if (keyBytes.length < 32) {
    final k = Uint8List(32);
    for (int i = 0; i < keyBytes.length; i++) k[i] = keyBytes[i];
    return k;
  }
  return Uint8List.fromList(keyBytes.sublist(0, 32));
}

Uint8List _decryptCbcTopLevel(
  Uint8List iv,
  Uint8List ciphertext,
  Uint8List key,
) {
  final cipher = CBCBlockCipher(AESEngine())
    ..init(false, ParametersWithIV(KeyParameter(key), iv));
  final padded = Uint8List(ciphertext.length);
  for (int i = 0; i < ciphertext.length; i += 16) {
    cipher.processBlock(ciphertext, i, padded, i);
  }
  return padded;
}

/// Top-level decryption for use in [compute] isolates. Does not use GetIt/EnvManager.
/// [args]: [Uint8List encryptedBytes, Uint8List keyBytes] for new format (IV prepended),
/// or [Uint8List ciphertextOnly, Uint8List keyBytes, Uint8List fixedIv] for legacy (encrypt package).
Uint8List decryptBytesWithKey(List<dynamic> args) {
  final keyBytes = args[1] as Uint8List;
  final Uint8List iv;
  final Uint8List ciphertext;
  if (args.length >= 3 && args[2] != null) {
    // Legacy format: entire blob is ciphertext, IV passed separately (old encrypt package).
    ciphertext = args[0] as Uint8List;
    iv = args[2] as Uint8List;
  } else {
    // New format: first 16 bytes = IV, rest = ciphertext.
    final encryptedBytes = args[0] as Uint8List;
    if (encryptedBytes.length <= 16) return encryptedBytes;
    iv = encryptedBytes.sublist(0, 16);
    ciphertext = encryptedBytes.sublist(16);
  }
  if (ciphertext.isEmpty || ciphertext.length % 16 != 0) {
    return args[0] as Uint8List;
  }
  final key = _normalizeKeyTopLevel(keyBytes);
  final padded = _decryptCbcTopLevel(iv, ciphertext, key);
  final padLen = padded[padded.length - 1];
  if (padLen < 1 || padLen > 16) return padded;
  return padded.sublist(0, padded.length - padLen);
}

/// Returns true if [bytes] look like a PNG or JPEG (magic bytes).
bool _looksLikeImage(Uint8List bytes) {
  if (bytes.length < 3) return false;
  return (bytes[0] == 0x89 && bytes[1] == 0x50 && bytes[2] == 0x4E) || // PNG
      (bytes[0] == 0xFF && bytes[1] == 0xD8); // JPEG
}

// --- CustomEncrypter (uses EnvManager on main isolate only) ---

final customEncrypter = CustomEncrypter();

typedef EncryptedString = String;

/// AES-CBC encryption using [pointycastle], matching the previous [encrypt] package
/// behavior (IV + ciphertext, PKCS7 padding) for full backward compatibility.
class CustomEncrypter {
  List<int> get _keyBytes => utf8.encode(di<EnvManager>().activeEnv!.key!);

  List<int> get _ivBytes => utf8.encode(di<EnvManager>().activeEnv!.iv!);

  /// 16 or 32 bytes for AES-128 or AES-256; pad or truncate if needed.
  List<int> _normalizeKey(List<int> keyBytes) {
    if (keyBytes.length == 16) return Uint8List.fromList(keyBytes);
    if (keyBytes.length == 32) return Uint8List.fromList(keyBytes);
    if (keyBytes.length < 32) {
      final k = Uint8List(32);
      for (int i = 0; i < keyBytes.length; i++) k[i] = keyBytes[i];
      return k;
    }
    return Uint8List.fromList(keyBytes.sublist(0, 32));
  }

  Uint8List _fixedIv() => Uint8List.fromList(
    _ivBytes.length >= 16 ? _ivBytes.sublist(0, 16) : _pad16(_ivBytes),
  );

  Uint8List _pad16(List<int> b) {
    final out = Uint8List(16);
    for (int i = 0; i < b.length && i < 16; i++) out[i] = b[i];
    return out;
  }

  List<int> _randomNonce16() {
    final r = Random.secure();
    return List<int>.generate(16, (_) => r.nextInt(256));
  }

  Uint8List _decryptCbc(
    Uint8List iv,
    Uint8List ciphertext,
    List<int> keyBytes,
  ) {
    final key = _normalizeKey(keyBytes);
    final cipher = CBCBlockCipher(
      AESEngine(),
    )..init(false, ParametersWithIV(KeyParameter(Uint8List.fromList(key)), iv));
    final padded = Uint8List(ciphertext.length);
    for (int i = 0; i < ciphertext.length; i += 16) {
      cipher.processBlock(ciphertext, i, padded, i);
    }
    final padLen = padded[padded.length - 1];
    if (padLen < 1 || padLen > 16) return padded;
    return padded.sublist(0, padded.length - padLen);
  }

  Uint8List _padPkcs7(List<int> data, int blockSize) {
    final pad = blockSize - (data.length % blockSize);
    return Uint8List.fromList([...data, ...List.filled(pad, pad)]);
  }

  Uint8List _encryptCbc(List<int> plain, List<int> keyBytes, List<int> iv) {
    final key = _normalizeKey(keyBytes);
    final cipher = CBCBlockCipher(AESEngine())
      ..init(
        true,
        ParametersWithIV(
          KeyParameter(Uint8List.fromList(key)),
          Uint8List.fromList(iv),
        ),
      );
    final padded = _padPkcs7(plain, 16);
    final out = Uint8List(padded.length);
    for (int i = 0; i < padded.length; i += 16) {
      cipher.processBlock(padded, i, out, i);
    }
    return out;
  }

  // ---------- Main encrypter (env key + fixed IV) ----------

  EncryptedString encryptString(String nonEncryptedString) {
    final iv = _fixedIv();
    final encrypted = _encryptCbc(
      utf8.encode(nonEncryptedString),
      _keyBytes,
      iv,
    );
    return base64.encode([...iv, ...encrypted]);
  }

  String decryptString(EncryptedString encryptedString) {
    final bytes = base64.decode(encryptedString) as Uint8List;
    if (bytes.length <= 16) return '';
    final iv = bytes.sublist(0, 16);
    return utf8.decode(_decryptCbc(iv, bytes.sublist(16), _keyBytes));
  }

  /// Generates: [Base64(IV1+Cipher1)]*[Base64(IV2+Cipher2)]
  String encryptAndPackageCredentials(String username, String password) {
    const String separator = '*';
    final keyBytes = utf8.encode(di<MatrixPolicyManager>().encryptionKey);
    String encryptPart(String plainText) {
      final iv = _randomNonce16();
      final encrypted = _encryptCbc(utf8.encode(plainText), keyBytes, iv);
      return base64.encode([...iv, ...encrypted]);
    }

    return '${encryptPart(username)}$separator${encryptPart(password)}';
  }

  String encryptMatrixString(String nonEncryptedString) {
    final keyBytes = utf8.encode(di<MatrixPolicyManager>().encryptionKey);
    final iv = _randomNonce16();
    final encrypted = _encryptCbc(
      utf8.encode(nonEncryptedString),
      keyBytes,
      iv,
    );
    return base64.encode([...iv, ...encrypted]);
  }

  String decryptMatrixString(String combinedBase64) {
    final bytes = base64.decode(combinedBase64) as Uint8List;
    if (bytes.length <= 16) return '';
    final iv = bytes.sublist(0, 16);
    final keyBytes = utf8.encode(di<MatrixPolicyManager>().encryptionKey);
    return utf8.decode(_decryptCbc(iv, bytes.sublist(16), keyBytes));
  }

  String _encryptWithInternalIv(String plainText) {
    final keyBytes = utf8.encode(di<MatrixPolicyManager>().encryptionKey);
    final iv = _randomNonce16();
    final encrypted = _encryptCbc(utf8.encode(plainText), keyBytes, iv);
    return base64.encode([...iv, ...encrypted]);
  }

  String generatePayload(String partOne, String partTwo, String separator) {
    return '${_encryptWithInternalIv(partOne)}$separator${_encryptWithInternalIv(partTwo)}';
  }

  Future<File> encryptFile(File file) async {
    final List<int> fileBytes = await file.readAsBytes();
    final iv = _fixedIv();
    final encrypted = _encryptCbc(fileBytes, _keyBytes, iv);
    final Directory tempDir = await getTemporaryDirectory();
    final Uri uri = Uri.parse(file.path);
    final String extension = uri.pathSegments.last.split('.').last;
    final File tempFile = File(
      p.join(tempDir.path, 'encrypted_file.$extension'),
    );
    await tempFile.writeAsBytes([...iv, ...encrypted]);
    return tempFile;
  }

  Future<Image> decryptEncryptedImage(File file) async {
    final encryptedBytes = await file.readAsBytes();
    final decryptedBytes = await decryptTheseBytesAsync(encryptedBytes);
    return Image.memory(decryptedBytes);
  }

  /// Synchronous decryption on the main isolate only (uses [EnvManager]).
  /// Supports both new format (IV + ciphertext) and legacy encrypt-package format (ciphertext only, fixed IV).
  Uint8List decryptTheseBytes(Uint8List encryptedBytes) {
    if (encryptedBytes.length <= 16) return encryptedBytes;
    // Try new format first (IV prepended).
    final iv = encryptedBytes.sublist(0, 16);
    final ciphertext = encryptedBytes.sublist(16);
    final newResult =
        Uint8List.fromList(_decryptCbc(iv, ciphertext, _keyBytes));
    if (_looksLikeImage(newResult)) return newResult;
    // Legacy format: entire blob is ciphertext, fixed IV from env (old encrypt package).
    if (encryptedBytes.length % 16 != 0) return newResult;
    final fixedIv = _fixedIv();
    return Uint8List.fromList(
      _decryptCbc(fixedIv, encryptedBytes, _keyBytes),
    );
  }

  /// Async decryption: resolves key on main isolate and runs CBC in [compute] when in release/profile.
  /// Supports both new format (IV + ciphertext) and legacy encrypt-package format (ciphertext only, fixed IV).
  Future<Uint8List> decryptTheseBytesAsync(Uint8List encryptedBytes) async {
    if (encryptedBytes.length <= 16) return encryptedBytes;
    final keyBytes =
        Uint8List.fromList(utf8.encode(di<EnvManager>().activeEnv!.key!));
    if (kReleaseMode || kProfileMode) {
      // Try new format first.
      Uint8List result = await compute(
        decryptBytesWithKey,
        <dynamic>[encryptedBytes, keyBytes],
      );
      if (_looksLikeImage(result)) return result;
      // Legacy format: ciphertext-only with fixed IV (old encrypt package).
      if (encryptedBytes.length % 16 != 0) return result;
      final fixedIv = _fixedIv();
      return compute(
        decryptBytesWithKey,
        <dynamic>[encryptedBytes, keyBytes, fixedIv],
      );
    }
    return decryptTheseBytes(encryptedBytes);
  }

  Uint8List encryptTheseBytes(Uint8List bytes) {
    final iv = _fixedIv();
    final encrypted = _encryptCbc(bytes, _keyBytes, iv);
    return Uint8List.fromList([...iv, ...encrypted]);
  }
}

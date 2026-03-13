import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:pointycastle/export.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';

/// Encrypt [plain] with AES-CBC using [key] and [iv], with PKCS7 padding,
/// matching the production encrypt path.
Uint8List _encryptCbc(Uint8List plain, Uint8List key, Uint8List iv) {
  final padLen = 16 - (plain.length % 16);
  final padded = Uint8List.fromList([...plain, ...List.filled(padLen, padLen)]);
  final cipher = CBCBlockCipher(AESEngine())
    ..init(true, ParametersWithIV(KeyParameter(key), iv));
  final out = Uint8List(padded.length);
  for (int i = 0; i < padded.length; i += 16) {
    cipher.processBlock(padded, i, out, i);
  }
  return out;
}

void main() {
  group('decryptBytesWithKey (top-level, isolate-safe)', () {
    test('returns input unchanged when <= 16 bytes (new format)', () {
      final tiny = Uint8List.fromList([1, 2, 3]);
      final result = decryptBytesWithKey([tiny, Uint8List(16)]);
      expect(result, tiny);
    });

    test('returns input unchanged when ciphertext not block-aligned', () {
      // 17 bytes: 16 for IV + 1 for ciphertext — not block-aligned
      final data = Uint8List(17);
      final key = Uint8List(16);
      final result = decryptBytesWithKey([data, key]);
      expect(result, data);
    });

    test('round-trip: encrypt then decrypt with new format (IV prepended)',
        () {
      final plainText = 'Hello, World! This is a test.';
      final plainBytes = Uint8List.fromList(plainText.codeUnits);
      final key = Uint8List.fromList('sixteen_byte_key'.codeUnits);
      final iv = Uint8List(16); // zero IV for deterministic test

      final ciphertext = _encryptCbc(plainBytes, key, iv);
      // New format: IV prepended to ciphertext
      final encrypted = Uint8List.fromList([...iv, ...ciphertext]);

      final decrypted = decryptBytesWithKey([encrypted, key]);
      expect(decrypted, plainBytes);
    });

    test('round-trip with legacy format (separate IV in args[2])', () {
      final plainText = 'Legacy format test data!!';
      final plainBytes = Uint8List.fromList(plainText.codeUnits);
      final key = Uint8List.fromList('another_16b_key!'.codeUnits);
      final iv = Uint8List.fromList('fixed_iv_16bytes'.codeUnits);

      final ciphertext = _encryptCbc(plainBytes, key, iv);

      // Legacy format: ciphertext only, IV passed as third argument
      final decrypted = decryptBytesWithKey([ciphertext, key, iv]);
      expect(decrypted, plainBytes);
    });

    test('key normalization: short key is zero-padded to 32 bytes', () {
      final plainBytes = Uint8List.fromList('test'.codeUnits);
      // Use a 32-byte zero-padded key for encryption to match what decrypt does
      final shortKey = Uint8List.fromList([1, 2, 3]);
      final normalizedKey = Uint8List(32);
      for (int i = 0; i < shortKey.length; i++) {
        normalizedKey[i] = shortKey[i];
      }
      final iv = Uint8List(16);
      final ciphertext = _encryptCbc(plainBytes, normalizedKey, iv);
      final encrypted = Uint8List.fromList([...iv, ...ciphertext]);

      // Decrypt with the short key — should normalize internally
      final decrypted = decryptBytesWithKey([encrypted, shortKey]);
      expect(decrypted, plainBytes);
    });

    test('key normalization: long key is truncated to 32 bytes', () {
      final plainBytes = Uint8List.fromList('truncation test!'.codeUnits);
      final longKey = Uint8List(64);
      for (int i = 0; i < 64; i++) {
        longKey[i] = i;
      }
      // Production truncates to first 32 bytes
      final truncatedKey = Uint8List.fromList(longKey.sublist(0, 32));
      final iv = Uint8List(16);
      final ciphertext = _encryptCbc(plainBytes, truncatedKey, iv);
      final encrypted = Uint8List.fromList([...iv, ...ciphertext]);

      final decrypted = decryptBytesWithKey([encrypted, longKey]);
      expect(decrypted, plainBytes);
    });

    test('16-byte key is used as-is (AES-128)', () {
      final plainBytes = Uint8List.fromList('AES-128 test msg'.codeUnits);
      final key = Uint8List.fromList('exact16byte_key!'.codeUnits);
      final iv = Uint8List(16);
      final ciphertext = _encryptCbc(plainBytes, key, iv);
      final encrypted = Uint8List.fromList([...iv, ...ciphertext]);

      final decrypted = decryptBytesWithKey([encrypted, key]);
      expect(decrypted, plainBytes);
    });

    test('32-byte key is used as-is (AES-256)', () {
      final plainBytes = Uint8List.fromList('AES-256 test msg'.codeUnits);
      final key =
          Uint8List.fromList('this_is_a_32_byte_key_for_aes!!'.codeUnits);
      // Pad to exactly 32
      final key32 = Uint8List(32);
      for (int i = 0; i < key.length && i < 32; i++) {
        key32[i] = key[i];
      }
      final iv = Uint8List(16);
      final ciphertext = _encryptCbc(plainBytes, key32, iv);
      final encrypted = Uint8List.fromList([...iv, ...ciphertext]);

      final decrypted = decryptBytesWithKey([encrypted, key32]);
      expect(decrypted, plainBytes);
    });
  });
}

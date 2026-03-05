import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';

final customEncrypter = CustomEncrypter();

typedef EncryptedString = String;

class CustomEncrypter {
  final encrypter = enc.Encrypter(
    enc.AES(
      enc.Key.fromUtf8(di<EnvManager>().activeEnv!.key!),
      mode: enc.AESMode.cbc,
    ),
  );

  // Lazy initialization for matrix encrypter
  enc.Encrypter? _matrixCredentialsEncrypter;

  enc.Encrypter get matrixCredentialsEncrypter {
    _matrixCredentialsEncrypter ??= enc.Encrypter(
      enc.AES(
        enc.Key.fromUtf8(di<MatrixPolicyManager>().encryptionKey),
        mode: enc.AESMode.cbc,
      ),
    );
    return _matrixCredentialsEncrypter!;
  }

  final iv = enc.IV.fromUtf8(di<EnvManager>().activeEnv!.iv!);

  /// Generates: [Base64(IV1+Cipher1)]*[Base64(IV2+Cipher2)]
  String encryptAndPackageCredentials(String username, String password) {
    const String separator = '*';

    String encryptPart(String plainText) {
      // Generate a fresh 16-byte IV for every part
      final iv = enc.IV.fromSecureRandom(16);

      // Encrypt the string
      final encrypted = matrixCredentialsEncrypter.encrypt(plainText, iv: iv);

      // Combine IV (16 bytes) + Ciphertext (N bytes)
      final combined = Uint8List.fromList(iv.bytes + encrypted.bytes);

      // Convert the combined bytes to a safe Base64 string
      return base64.encode(combined);
    }

    final encryptedUser = encryptPart(username);
    final encryptedPass = encryptPart(password);

    return '$encryptedUser$separator$encryptedPass';
  }

  String encryptMatrixString(String nonEncryptedString) {
    // 1. Generate a random IV for every encryption
    final iv = enc.IV.fromSecureRandom(16);

    // 2. Encrypt using the random IV
    final encrypted = matrixCredentialsEncrypter.encrypt(
      nonEncryptedString,
      iv: iv,
    );

    // 3. Combine IV bytes + Ciphertext bytes
    final combinedBytes = Uint8List.fromList(iv.bytes + encrypted.bytes);

    // 4. Return as a single Base64 string
    return base64.encode(combinedBytes);
  }

  // EncryptedString encryptMatrixString(String nonEncryptedString) {
  //   final encryptedString = matrixCredentialsEncrypter
  //       .encrypt(nonEncryptedString, iv: matrixIv)
  //       .base64;
  //   return encryptedString;
  // }

  String decryptMatrixString(String combinedBase64) {
    final bytes = base64.decode(combinedBase64);

    // Extract the first 16 bytes as the IV
    final ivBytes = bytes.sublist(0, 16);
    final iv = enc.IV(ivBytes);

    // The rest is the actual encrypted data
    final ciphertextBytes = bytes.sublist(16);
    final encrypted = enc.Encrypted(ciphertextBytes);

    return matrixCredentialsEncrypter.decrypt(encrypted, iv: iv);
  }

  String _encryptWithInternalIv(String plainText) {
    // 1. Generate a fresh IV for this specific piece of data
    final iv = enc.IV.fromSecureRandom(16);

    // 2. Encrypt
    final encrypted = matrixCredentialsEncrypter.encrypt(plainText, iv: iv);

    // 3. Combine: [16 bytes of IV] + [N bytes of Ciphertext]
    final combined = Uint8List.fromList(iv.bytes + encrypted.bytes);

    // 4. Return as Base64 (Safe for transmission)
    return base64.encode(combined);
  }

  String generatePayload(String partOne, String partTwo, String separator) {
    final enc1 = _encryptWithInternalIv(partOne);
    final enc2 = _encryptWithInternalIv(partTwo);

    // Example result: "Base64(IV1+Data1)#Base64(IV2+Data2)"
    return "$enc1$separator$enc2";
  }

  // String decryptMatrixString(EncryptedString encryptedString) {
  //   final thisEncryptedString = enc.Encrypted.fromBase64(encryptedString);
  //   final decryptedString = matrixCredentialsEncrypter.decrypt(
  //     thisEncryptedString,
  //     iv: matrixIv,
  //   );
  //   return decryptedString;
  // }

  EncryptedString encryptString(String nonEncryptedString) {
    final encryptedString = encrypter
        .encrypt(nonEncryptedString, iv: iv)
        .base64;
    return encryptedString;
  }

  String decryptString(EncryptedString encryptedString) {
    final thisEncryptedString = enc.Encrypted.fromBase64(encryptedString);
    final decryptedString = encrypter.decrypt(thisEncryptedString, iv: iv);
    return decryptedString;
  }

  Future<File> encryptFile(File file) async {
    final List<int> fileBytes = await file.readAsBytes();
    final encrypted = encrypter.encryptBytes(fileBytes, iv: iv);
    final Directory tempDir = await getTemporaryDirectory();
    final Uri uri = Uri.parse(file.path);
    final String extension = uri.pathSegments.last.split('.').last;
    final File tempFile = File(
      p.join(tempDir.path, 'encrypted_file.$extension'),
    );
    await tempFile.writeAsBytes(encrypted.bytes);
    return tempFile;
  }

  Future<Image> decryptEncryptedImage(File file) async {
    // Read the encrypted file as bytes
    final encryptedBytes = await file.readAsBytes();

    // Decrypt the bytes
    final decryptedBytes = (kReleaseMode || kProfileMode)
        ? await compute(customEncrypter.decryptTheseBytes, encryptedBytes)
        : customEncrypter.decryptTheseBytes(encryptedBytes);
    return Image.memory(decryptedBytes);
  }

  Uint8List decryptTheseBytes(Uint8List encryptedBytes) {
    final List<int> decrypted = encrypter.decryptBytes(
      enc.Encrypted(encryptedBytes),
      iv: iv,
    );

    final Uint8List decryptedBytes = Uint8List.fromList(decrypted);
    return decryptedBytes;
  }

  Uint8List encryptTheseBytes(Uint8List bytes) {
    return encrypter.encryptBytes(bytes, iv: iv).bytes;
  }
}

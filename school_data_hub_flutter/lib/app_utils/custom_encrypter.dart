import 'dart:async';
import 'dart:io';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:watch_it/watch_it.dart';

final customEncrypter = CustomEncrypter();
final _envManager = di<EnvManager>();

class CustomEncrypter {
  final encrypter = enc.Encrypter(enc.AES(
      enc.Key.fromUtf8(_envManager.activeEnv!.key),
      mode: enc.AESMode.cbc));

  final iv = enc.IV.fromUtf8(_envManager.activeEnv!.iv);

  String encryptString(String nonEncryptedString) {
    final encryptedString =
        encrypter.encrypt(nonEncryptedString, iv: iv).base64;
    return encryptedString;
  }

  String decryptString(String encryptedString) {
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
    final File tempFile = File('${tempDir.path}/encrypted_file.$extension');
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
    final List<int> decrypted =
        encrypter.decryptBytes(enc.Encrypted(encryptedBytes), iv: iv);

    final Uint8List decryptedBytes = Uint8List.fromList(decrypted);
    return decryptedBytes;
  }

  Uint8List encryptTheseBytes(Uint8List bytes) {
    return encrypter.encryptBytes(bytes, iv: iv).bytes;
  }
}

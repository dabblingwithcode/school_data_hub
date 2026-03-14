import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:path/path.dart' as p;
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';

DefaultCacheManager get _cacheManager => di<DefaultCacheManager>();
NotificationManager get _notificationService => di<NotificationManager>();

Future<File?> downloadAndDecryptFile({
  required String documentId,
  required bool decrypt,
}) async {
  // Check cache
  final fileInfo = await _cacheManager.getFileFromCache(documentId);

  if (fileInfo != null && await fileInfo.file.exists()) {
    if (!decrypt) {
      return fileInfo.file;
    }

    final fileBytes = await fileInfo.file.readAsBytes();
    final (:bytes, :wasLegacy) = await customEncrypter.decryptFileBytesAsync(
      fileBytes,
    );

    if (wasLegacy) {
      _migrateToNewFormat(documentId, bytes);
    }

    final tempDir = await Directory.systemTemp.createTemp();
    final extension = p.extension(documentId);
    final tempFile = File(
      '${tempDir.path}/decrypted_${documentId.hashCode}$extension',
    );
    await tempFile.writeAsBytes(bytes);
    return tempFile;
  }

  // Download
  _notificationService.apiRunning(true);
  final ByteData? byteData = await di<Client>().files.getImage(documentId);
  _notificationService.apiRunning(false);

  if (byteData == null) {
    _notificationService.showSnackBar(
      NotificationType.error,
      'Fehler beim Laden der Datei',
    );
    return null;
  }

  Uint8List fileBytes = byteData.buffer.asUint8List();
  // Cache it
  await _cacheManager.putFile(documentId, fileBytes);

  if (!decrypt) {
    final tempDir = await Directory.systemTemp.createTemp();
    final extension = p.extension(documentId);
    final tempFile = File('${tempDir.path}/${documentId.hashCode}$extension');
    await tempFile.writeAsBytes(fileBytes);
    return tempFile;
  }

  final (:bytes, :wasLegacy) = await customEncrypter.decryptFileBytesAsync(
    fileBytes,
  );

  if (wasLegacy) {
    _migrateToNewFormat(documentId, bytes);
  }

  final tempDir = await Directory.systemTemp.createTemp();
  final extension = p.extension(documentId);
  final tempFile = File(
    '${tempDir.path}/decrypted_${documentId.hashCode}$extension',
  );
  await tempFile.writeAsBytes(bytes);
  return tempFile;
}

/// Fire-and-forget: re-encrypt [plainBytes] in the new format, update the
/// server file, and refresh the local cache — all without blocking the caller.
void _migrateToNewFormat(String documentId, Uint8List plainBytes) {
  Future(() async {
    try {
      final newEncrypted = customEncrypter.encryptTheseBytes(plainBytes);
      final byteData = ByteData.sublistView(newEncrypted);
      final ok = await di<Client>().files.replaceEncryptedFileBytes(
        documentId,
        byteData,
      );
      if (ok) {
        await _cacheManager.putFile(documentId, newEncrypted);
      }
    } catch (_) {
      // Migration is best-effort; silently ignore failures.
    }
  });
}

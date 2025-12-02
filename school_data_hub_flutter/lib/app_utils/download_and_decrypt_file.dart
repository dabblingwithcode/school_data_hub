import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart' as p;
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:watch_it/watch_it.dart';

Future<File?> downloadAndDecryptFile({
  required String documentId,
  required bool decrypt,
}) async {
  final cacheManager = di<DefaultCacheManager>();
  final notificationService = di<NotificationService>();

  // Check cache
  final fileInfo = await cacheManager.getFileFromCache(documentId);

  if (fileInfo != null && await fileInfo.file.exists()) {
    if (!decrypt) {
      return fileInfo.file;
    }
    
    final fileBytes = await fileInfo.file.readAsBytes();
    final decryptedBytes = (kReleaseMode || kProfileMode)
        ? await compute(customEncrypter.decryptTheseBytes, fileBytes)
        : customEncrypter.decryptTheseBytes(fileBytes);

    final tempDir = await Directory.systemTemp.createTemp();
    final extension = p.extension(documentId);
    final tempFile =
        File('${tempDir.path}/decrypted_${documentId.hashCode}$extension');
    await tempFile.writeAsBytes(decryptedBytes);
    return tempFile;
  }

  // Download
  notificationService.apiRunning(true);
  final ByteData? byteData = await di<Client>().files.getImage(documentId);
  notificationService.apiRunning(false);

  if (byteData == null) {
    notificationService.showSnackBar(
      NotificationType.error,
      'Fehler beim Laden der Datei',
    );
    return null;
  }

  Uint8List fileBytes = byteData.buffer.asUint8List();
  // Cache it
  await cacheManager.putFile(documentId, fileBytes);

  if (!decrypt) {
    final tempDir = await Directory.systemTemp.createTemp();
    final extension = p.extension(documentId);
    final tempFile = File('${tempDir.path}/${documentId.hashCode}$extension');
    await tempFile.writeAsBytes(fileBytes);
    return tempFile;
  }

  final decryptedBytes = (kReleaseMode || kProfileMode)
      ? await compute(customEncrypter.decryptTheseBytes, fileBytes)
      : customEncrypter.decryptTheseBytes(fileBytes);

  final tempDir = await Directory.systemTemp.createTemp();
  final extension = p.extension(documentId);
  final tempFile =
      File('${tempDir.path}/decrypted_${documentId.hashCode}$extension');
  await tempFile.writeAsBytes(decryptedBytes);
  return tempFile;
}


import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';

Future<Image> getImageCachedOrDownload({
  required String documentId,
  required bool decrypt,
}) async {
  // First look for the image in the cache
  final cacheManager = di<DefaultCacheManager>();
  final notificationService = di<NotificationManager>();
  final fileInfo = await cacheManager.getFileFromCache(documentId);

  if (fileInfo != null && await fileInfo.file.exists()) {
    // File is already cached, if necessary, decrypt it before using
    if (!decrypt) {
      final fileBytes = await fileInfo.file.readAsBytes();
      return Image.memory(fileBytes);
    }
    final decryptedImage = await customEncrypter.decryptEncryptedImage(
      fileInfo.file,
    );
    return decryptedImage;
  }
  // The image is not in the cache, so we need to download it
  notificationService.apiRunning(true);
  final ByteData? byteData = await di<Client>().files.getImage(documentId);
  notificationService.apiRunning(false);

  if (byteData == null) {
    notificationService.showSnackBar(
      NotificationType.error,
      'Fehler beim Laden des Bildes',
    );
    return Image.asset('assets/dummy-profile-pic.png');
  }
  Uint8List imageBytes = byteData.buffer.asUint8List();
  // Cache the image for future use
  await cacheManager.putFile(documentId, imageBytes);
  if (!decrypt) {
    return Image.memory(imageBytes);
  }
  // The image is encrypted - decrypt the bytes before returning
  final decryptedBytes = await customEncrypter.decryptTheseBytesAsync(
    imageBytes,
  );
  return Image.memory(decryptedBytes);
}

Future<Image> cachedPublicImageOrDownloadPublicImage({
  required String path,
  required String cacheKey,
}) async {
  // First look for the image in the cache
  final cacheManager = di<DefaultCacheManager>();
  final notificationService = di<NotificationManager>();
  final client = di<Client>();
  final fileInfo = await cacheManager.getFileFromCache(cacheKey);

  if (fileInfo != null && await fileInfo.file.exists()) {
    // File is already cached, if necessary, decrypt it before using

    final fileBytes = await fileInfo.file.readAsBytes();
    return Image.memory(fileBytes);
  }
  // The image is not in the cache, so we need to download it
  notificationService.apiRunning(true);
  final ByteData? byteData = await client.files.getUnencryptedImage(path);
  notificationService.apiRunning(false);

  if (byteData == null) {
    notificationService.showSnackBar(
      NotificationType.error,
      'Fehler beim Laden des Bildes',
    );
    return Image.asset('assets/dummy-profile-pic.png');
  }
  Uint8List imageBytes = byteData.buffer.asUint8List();
  // Cache the image for future use
  await cacheManager.putFile(cacheKey, imageBytes);

  return Image.memory(imageBytes);

  // The image is encrypted - decrypt the bytes before returning
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:watch_it/watch_it.dart';

final _client = di<Client>();
final _notificationService = di<NotificationService>();

Future<Image> cachedImageOrDownloadImage(
    {required String documentId, required bool decrypt}) async {
  final cacheManager = di<DefaultCacheManager>();

  // First look for the image in the cache
  final fileInfo = await cacheManager.getFileFromCache(documentId);

  if (fileInfo != null && await fileInfo.file.exists()) {
    // File is already cached, if necessary, decrypt it before using
    if (!decrypt) {
      final fileBytes = await fileInfo.file.readAsBytes();
      return Image.memory(fileBytes);
    }
    final decryptedImage =
        await customEncrypter.decryptEncryptedImage(fileInfo.file);
    return decryptedImage;
  }
  // The image is not in the cache, so we need to download it
  _notificationService.apiRunning(true);
  final ByteData? byteData = await _client.files.getImage(documentId);
  _notificationService.apiRunning(false);

  if (byteData == null) {
    di<NotificationService>()
        .showSnackBar(NotificationType.error, 'Fehler beim Laden des Bildes');
    return Image.asset('assets/dummy-profile-pic.png');
  }

  final encryptedBytes = byteData.buffer.asUint8List();

  // Cache the encrypted bytes
  await cacheManager.putFile(documentId, encryptedBytes);
  // Decrypt the bytes before returning
  //- TODO: Check this isolate use
  //- This is because isolate performance is horrible in debug mode
  final decryptedBytes = (kReleaseMode || kProfileMode)
      ? await compute(customEncrypter.decryptTheseBytes, encryptedBytes)
      : customEncrypter.decryptTheseBytes(encryptedBytes);
  return Image.memory(decryptedBytes);
}

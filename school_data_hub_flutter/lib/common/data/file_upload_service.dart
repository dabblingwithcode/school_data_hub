import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:watch_it/watch_it.dart';

final _client = di<Client>();
final _notificationService = di<NotificationService>();
final _log = Logger('FileUploadService');

class FileUploadService {
  FileUploadService.__internal();
  static final _instance = FileUploadService.__internal();
  factory FileUploadService() => _instance;

  // TODO: consider exceptions here
  static Future<({String? path, bool success})> uploadFile(
      File file, ServerStorageFolder folder) async {
    final documentId = Uuid().v4();
    final path = p.join(folder.name, '$documentId.jpg');
    final uploadDescription =
        await _client.files.getUploadDescription(StorageId.private.name, path);
    if (uploadDescription != null) {
      // Create an uploader
      final uploader = FileUploader(uploadDescription);

      // Upload the file
      final fileStream = file.openRead();

      final fileLength = await file.length();
      _notificationService.apiRunning(true);
      await uploader.upload(fileStream, fileLength);
      _notificationService.apiRunning(false);

      // Verify the upload
      try {
        final success =
            await _client.files.verifyUpload(StorageId.private.name, path);
        return (path: path, success: success);
      } catch (e) {
        _log.severe('Upload failed for $path: $e');
        _notificationService.showSnackBar(
            NotificationType.error, 'Upload failed for $path: $e');
        return (path: null, success: false);
      }
    }
    _log.severe('Upload description is null for $path');
    return (path: null, success: false);
  }
}

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('FileUploadService');

class ClientFileUpload {
  ClientFileUpload.__internal();
  static final _instance = ClientFileUpload.__internal();
  factory ClientFileUpload() => _instance;

  static Future<({String? path, bool success, bool cancelled})> uploadFile({
    File? file,
    required StorageId storageId,
    required ServerStorageFolder folder,
  }) async {
    File? fileToUpload = file;
    if (fileToUpload == null) {
      final pickedFile = await FilePicker.platform.pickFiles();
      if (pickedFile == null ||
          pickedFile.files.isEmpty ||
          pickedFile.files.single.path == null) {
        return (path: null, success: false, cancelled: true);
      }
      fileToUpload = File(pickedFile.files.single.path!);
    }
    final documentId = const Uuid().v4();
    final path = p.join(
      folder.name,
      '$documentId${p.extension(fileToUpload.path)}',
    );
    try {
      final uploadDescription = await di<Client>().files.getUploadDescription(
        StorageId.private.name,
        path,
      );
      _log.info('Upload description received for $path');
      _log.fine('Upload description: $uploadDescription');

      if (uploadDescription != null) {
        // Create an uploader
        final uploader = FileUploader(uploadDescription);

        // Upload the file
        final fileStream = fileToUpload.openRead();

        final fileLength = await fileToUpload.length();
        di<NotificationService>().apiRunning(true);
        await uploader.upload(fileStream, fileLength);
        di<NotificationService>().apiRunning(false);

        // Verify the upload
        try {
          final success = await di<Client>().files.verifyUpload(
            StorageId.private.name,
            path,
          );
          return (path: path, success: success, cancelled: false);
        } catch (e) {
          _log.severe('Upload failed for $path: $e');
          di<NotificationService>().showSnackBar(
            NotificationType.error,
            'Upload failed for $path: $e',
          );
          return (path: null, success: false, cancelled: false);
        }
      }
    } catch (e) {
      _log.severe('Failed to get upload description for $path: $e');
      di<NotificationService>().showSnackBar(
        NotificationType.error,
        'Failed to get upload description for $path: $e',
      );
      return (path: null, success: false, cancelled: false);
    }

    _log.severe('Upload description is null for $path');
    return (path: null, success: false, cancelled: false);
  }
}

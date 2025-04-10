// code copyrhight by the author(s)
// from https://github.com/serverpod/serverpod/issues/3081

import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as path;
import 'package:serverpod/serverpod.dart';

enum LocalStorageId {
  public('public'),
  private('private');

  final String storageId;

  const LocalStorageId(
    this.storageId,
  );
}

class LocalStorage extends DatabaseCloudStorage {
  final String? publicStorageUrl;
  final String pathPrefix;

  LocalStorage({
    required LocalStorageId storageId,
    required this.pathPrefix,
    this.publicStorageUrl,
  }) : super(storageId.storageId);

  File _getFileByPath(String filePath) {
    final fileName = path.basename(filePath);
    final parentDirectoryPath = path.dirname(filePath);
    final directoryPath = path.join(pathPrefix, parentDirectoryPath);
    final directory = Directory(directoryPath);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    return File(path.join(directoryPath, fileName));
  }

  @override
  Future<void> deleteFile({
    required Session session,
    required String path,
  }) async {
    final file = _getFileByPath(path);
    if (!file.existsSync()) {
      session.log('File not found: $path', level: LogLevel.warning);
      // throw LocalizedError(
      //   message: LocalizedMessage(en: 'File not found'),
      //   statusCode: 404,
      // );
      return;
    }
    file.deleteSync();
  }

  @override
  Future<bool> fileExists({
    required Session session,
    required String path,
  }) async {
    print('Checking if file exists at $path');
    final file = _getFileByPath(path);
    return file.existsSync();
  }

  @override
  Future<Uri?> getPublicUrl({
    required Session session,
    required String path,
  }) async {
    final prefix = publicStorageUrl;
    if (prefix == null) {
      session.log(
          'Public storage URL is allowed for LocalStorage with id $storageId',
          level: LogLevel.warning);
    }

    final file = _getFileByPath(path);
    if (!file.existsSync()) {
      session.log('File not found: $path', level: LogLevel.warning);
      // throw LocalizedError(
      //   message: LocalizedMessage(en: 'File not found'),
      //   statusCode: 404,
      // );
      return null;
    }
    if (prefix!.startsWith('http')) {
      return Uri.parse('$prefix$path');
    }
    return Uri.file('$prefix$path');
  }

  @override
  Future<ByteData?> retrieveFile({
    required Session session,
    required String path,
  }) async {
    final file = _getFileByPath(path);
    if (!file.existsSync()) {
      session.log('File not found: $path', level: LogLevel.warning);
      // throw LocalizedError(
      //   message: LocalizedMessage(en: 'File not found'),
      //   statusCode: 404,
      // );
      return null;
    }
    final data = file.readAsBytesSync();
    return ByteData.view(data.buffer);
  }

  @override
  Future<void> storeFile({
    required Session session,
    required String path,
    required ByteData byteData,
    DateTime? expiration,
    bool verified = true,
  }) async {
    final file = _getFileByPath(path);
    final data = byteData.buffer.asUint8List();
    file.writeAsBytesSync(data);
  }

  @override
  Future<bool> verifyDirectFileUpload(
      {required Session session, required String path}) async {
    final file = _getFileByPath(path);
    return file.existsSync();
  }
}

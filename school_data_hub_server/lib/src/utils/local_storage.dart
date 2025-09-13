// code copyrhight by the author(s)
// from https://github.com/serverpod/serverpod/issues/3081

import 'dart:io';
import 'dart:typed_data';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:serverpod/serverpod.dart';

enum LocalStorageId {
  public('public'),
  private('private');

  final String storageId;

  const LocalStorageId(
    this.storageId,
  );
}

final _log = Logger('LocalStorage');

class LocalStorage extends DatabaseCloudStorage {
  // Static instances for each storage type
  // static final Map<String, LocalStorage> _instances = {};
  //final String? publicStorageUrl;
  final String pathPrefix;

  LocalStorage({
    required String storageId,
    required this.pathPrefix,
    // this.publicStorageUrl,
  }) : super(storageId);

  // We sanitize the path for different platforms
  File _getFileByPath(String path) => File(p.join(pathPrefix, path));

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
    _log.info('Checking if file exists at $path');

    final file = _getFileByPath(path);
    if (!file.existsSync()) {
      _log.warning('File not found: $path');
    } else {
      _log.info('File exists: $path');
    }
    return file.existsSync();
  }

  @override
  Future<Uri?> getPublicUrl({
    required Session session,
    required String path,
  }) async {
    //  final prefix = '$storageUrl/public';

    final file = _getFileByPath(path);
    if (!file.existsSync()) {
      session.log('File not found: $path', level: LogLevel.warning);
      // throw LocalizedError(
      //   message: LocalizedMessage(en: 'File not found'),
      //   statusCode: 404,
      // );
      return null;
    }
    // if (prefix!.startsWith('http')) {
    //   return Uri.parse('$prefix$path');
    // }
    return Uri.file(path);
    //  return Uri.file('$prefix$path');
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

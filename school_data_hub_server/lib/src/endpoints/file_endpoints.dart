import 'package:serverpod/serverpod.dart';

class FilesEndpoint extends Endpoint {
  Future<String?> getUploadDescription(
      Session session, String storageId, String path) async {
    return await session.storage.createDirectFileUploadDescription(
      storageId: storageId,
      path: path,
    );
  }

  Future<bool> verifyUpload(
      Session session, String storageId, String path) async {
    return await session.storage.verifyDirectFileUpload(
      storageId: storageId,
      path: path,
    );
  }
}

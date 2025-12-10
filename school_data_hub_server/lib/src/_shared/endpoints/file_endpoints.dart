import 'dart:typed_data';

import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class FilesEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// [getUploadDescription]
  /// as described in https://docs.serverpod.dev/concepts/file-uploads#client-side-code
  Future<String?> getUploadDescription(
      Session session, String storageId, String path) async {
    if (await session.storage.fileExists(
      storageId: storageId,
      path: path,
    )) {
      await session.storage.deleteFile(
        storageId: storageId,
        path: path,
      );
    }

    return await session.storage.createDirectFileUploadDescription(
      storageId: storageId,
      path: path,
    );
  }

  /// [verifyUpload]
  /// as described in https://docs.serverpod.dev/concepts/file-uploads#client-side-code
  Future<bool> verifyUpload(
      Session session, String storageId, String path) async {
    final result = await session.storage.verifyDirectFileUpload(
      storageId: storageId,
      path: path,
    );
    return result;
  }

  /// As described in https://docs.serverpod.dev/concepts/file-uploads#client-side-code
  Future<ByteData?> getImage(Session session, String documentId) async {
    final HubDocument? document = await HubDocument.db
        .findFirstRow(session, where: (t) => t.documentId.equals(documentId));
    if (document == null) {
      return null;
    }
    final path = document.documentPath!;
    var exists = await session.storage.fileExists(
      storageId: 'private',
      path: path,
    );
    if (!exists) {
      return null;
    }
    return await session.storage.retrieveFile(
      storageId: 'private',
      path: path,
    );
  }

  Future<ByteData?> getUnencryptedImage(Session session, String path) async {
    var exists = await session.storage.fileExists(
      storageId: 'public',
      path: path,
    );
    if (!exists) {
      return null;
    }
    return await session.storage.retrieveFile(
      storageId: 'public',
      path: path,
    );
  }
}

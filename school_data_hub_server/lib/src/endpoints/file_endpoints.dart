import 'dart:typed_data';

import 'package:school_data_hub_server/src/generated/protocol.dart';
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
      storageId: 'public',
      path: path,
    );
  }
}

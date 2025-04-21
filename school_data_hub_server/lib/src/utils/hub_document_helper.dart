import 'package:logging/logging.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

final _log = Logger('HubDocumentHelper');

class HubDocumentHelper {
  static Future<HubDocument> createHubDocumentObject({
    required Session session,
    required String createdBy,
    required String path,
  }) async {
    final documentId = Uuid().v4();

    // Create a HubDocument with the file path
    final document = HubDocument(
      documentId: documentId,
      documentPath: path, // Store the path in the HubDocument
      createdBy: createdBy,
      createdAt: DateTime.now(),
    );

    return document;
  }

  static Future<bool> deleteHubDocument({
    required Session session,
    required String documentId,
  }) async {
    // Find the HubDocument in the database
    final hubDocument = await HubDocument.db.findFirstRow(
      session,
      where: (t) => t.documentId.equals(documentId),
    );

    if (hubDocument == null) {
      return false; // Document not found
    }
    _log.info('Deleting file with path: ${hubDocument.documentPath}');
    // Delete the file from cloud storage
    await session.storage.deleteFile(
      storageId: 'private',
      path: hubDocument.documentPath!,
    );

    return true; // Document deleted successfully
  }

  static Future<HubDocument?> getHubDocument({
    required Session session,
    required String documentId,
  }) async {
    // Find the HubDocument in the database
    final hubDocument = await HubDocument.db.findFirstRow(
      session,
      where: (t) => t.documentId.equals(documentId),
    );

    return hubDocument; // Return the HubDocument or null if not found
  }
}

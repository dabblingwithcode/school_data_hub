import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class HubDocumentHelper {
  static Future<HubDocument> createHubDocument({
    required Session session,
    required String createdBy,
    required String path,
  }) async {
    final documentId = Uuid().v4();

    // Store the file in cloud storage

    // Create a HubDocument with the file path
    final document = HubDocument(
      documentId: documentId,
      documentPath: path, // Store the path in the HubDocument
      createdBy: createdBy,
      createdAt: DateTime.now(),
    );

    // Save the document to the database
    await HubDocument.db.insertRow(session, document);

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

    // Delete the file from cloud storage
    await session.storage.deleteFile(
      storageId: 'private',
      path: hubDocument.documentPath!,
    );

    // Delete the HubDocument from the database
    await HubDocument.db.deleteRow(session, hubDocument);

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

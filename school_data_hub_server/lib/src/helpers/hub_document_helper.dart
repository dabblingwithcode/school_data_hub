import 'package:logging/logging.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

final _log = Logger('HubDocumentHelper');

class HubDocumentHelper {
  // Create a singleton constructor
  HubDocumentHelper._privateConstructor();
  static final HubDocumentHelper _instance =
      HubDocumentHelper._privateConstructor();
  factory HubDocumentHelper() {
    return _instance;
  }
  HubDocument createHubDocumentObject({
    required Session session,
    required String createdBy,
    required String path,
  }) {
    final documentId = Uuid().v4();

    // Create a HubDocument with the file path
    final document = HubDocument(
      documentId: documentId,
      documentPath: path, // Store the path in the HubDocument
      createdBy: createdBy,
      createdAt: DateTime.now().toUtc(),
    );

    return document;
  }

  Future<bool> deleteHubDocumentAndFile({
    required Session session,
    required String documentId,
    Transaction? transaction,
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
    await HubDocument.db
        .deleteRow(session, hubDocument, transaction: transaction);

    return true; // Document deleted successfully
  }

  Future<HubDocument?> getHubDocument({
    required Session session,
    required String documentId,
    Transaction? transaction,
  }) async {
    // Find the HubDocument in the database
    final hubDocument = await HubDocument.db.findFirstRow(
      session,
      where: (t) => t.documentId.equals(documentId),
      transaction: transaction,
    );

    return hubDocument; // Return the HubDocument or null if not found
  }
}

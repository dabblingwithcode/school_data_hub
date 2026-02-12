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
    final fileExtension = path.split('.').last;
    // If the file is an audio file, we sent the duration in the file name as a prefix
    // Example: 00-00_1234567890.m4a
    // We need to extract the duration from the file name
    // and use it as a prefix for the document ID
    // so that we can access the value later in the client
    // without having to initialize the document object
    String? duration;
    if (fileExtension == 'm4a') {
      duration = path.split('/').last.split('_').first;
    }
    final documentId = duration != null
        ? '${duration}_${Uuid().v4()}.$fileExtension'
        : '${Uuid().v4()}.$fileExtension';

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
    await HubDocument.db.deleteRow(
      session,
      hubDocument,
      transaction: transaction,
    );

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

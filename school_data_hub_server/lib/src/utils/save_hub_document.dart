import 'dart:typed_data';

import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

Future<HubDocument> createHubDocument({
  required Session session,
  required String createdBy,
  required ByteData fileData,
}) async {
  final documentId = Uuid().v4();
  // Generate a unique path for the file
  final path = 'documents/$documentId}';

  // Store the file in cloud storage
  await session.storage.storeFile(
    storageId: 'private', // or 'private' depending on your needs
    path: path,
    byteData: fileData,
  );

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

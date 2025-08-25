import 'dart:convert';

import 'package:serverpod/serverpod.dart';

Future<String> convertFileToContentString(
    Session session, String filePath) async {
  var exists = await session.storage.fileExists(
    storageId: 'private',
    path: filePath,
  );
  if (!exists) {
    throw Exception('File not found: $filePath');
  }
  final fileBytes = await session.storage.retrieveFile(
    storageId: 'private',
    path: filePath,
  );

  final buffer = fileBytes!.buffer;
  final uint8List =
      buffer.asUint8List(fileBytes.offsetInBytes, fileBytes.lengthInBytes);

  // Decode bytes to string (UTF-8 is common, but you can use other encodings)
  final content = utf8.decode(uint8List);
  return content;
}

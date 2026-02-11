import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/document_audio.dart';

/// Displays an encrypted audio document with playback controls.
/// This is the audio counterpart to [EncryptedDocumentImage].
class EncryptedDocumentAudio extends StatelessWidget {
  const EncryptedDocumentAudio({
    super.key,
    required this.documentId,
  });

  final String documentId;

  @override
  Widget build(BuildContext context) {
    return DocumentAudio(
      documentId: documentId,
      decrypt: true,
    );
  }
}

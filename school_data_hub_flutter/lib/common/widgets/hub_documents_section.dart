import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/audio/audio.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/encrypted_document_image.dart';
import 'package:school_data_hub_flutter/common/widgets/media_capture_buttons.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';

/// A reusable widget for displaying and managing document collections.
///
/// Supports both image and audio documents, with optional metadata display
/// (creation date and creator) and admin-controlled deletion.
class HubDocumentsSection extends StatelessWidget {
  /// The list of documents to display.
  final List<HubDocument>? documents;

  /// Callback when a file is captured (photo/video).
  final Future<void> Function(File? file) onFileCaptured;

  /// Callback when a file is recorded (audio).
  final Future<void> Function(File? file, Map<String, dynamic>? fileInfo)?
  onFileRecorded;

  /// Callback when a document should be removed.
  final Future<void> Function(String documentId) onDeleteDocument;

  /// Maximum number of documents allowed (default: 4).
  final int maxDocuments;

  /// Wether ro have a spacer between domuments and buttons
  final bool withSpacer;

  /// Whether to show metadata (date, creator) under each document.
  final bool showMetadata;

  /// Optional title to display above the documents section.
  final String? title;

  /// Optional padding for the MediaCaptureButtons.
  final EdgeInsets? captureButtonPadding;

  /// Optional background color for MediaCaptureButtons.
  final Color? captureButtonBackgroundColor;

  /// Optional icon color for MediaCaptureButtons.
  final Color? captureButtonIconColor;

  const HubDocumentsSection({
    required this.documents,
    required this.withSpacer,
    required this.onFileCaptured,
    required this.onDeleteDocument,
    this.onFileRecorded,
    this.maxDocuments = 4,
    this.showMetadata = true,
    this.title,
    this.captureButtonPadding,
    this.captureButtonBackgroundColor,
    this.captureButtonIconColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final files = documents;
    final isAdmin = di<HubSessionManager>().isAdmin;
    final imageFiles = files?.where((f) => !_isAudioDocument(f)).toList() ?? [];
    final audioFiles = files?.where((f) => _isAudioDocument(f)).toList() ?? [];
    final totalCount = (files?.length ?? 0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(title!, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Gap(4),
        ],
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final file in imageFiles) ...[
              _DocumentItem(
                file: file,
                isAdmin: isAdmin,
                showMetadata: showMetadata,
                onDelete: () => onDeleteDocument(file.documentId),
              ),
              const Gap(10),
            ],
            for (final file in audioFiles) ...[
              _AudioDocumentItem(
                file: file,
                showMetadata: showMetadata,
                onDelete: () => onDeleteDocument(file.documentId),
              ),
              const Gap(10),
            ],
            if (totalCount < maxDocuments) ...[
              if (withSpacer) const Spacer(),
              MediaCaptureButtons(
                onFileCaptured: onFileCaptured,
                onFileRecorded: (file, fileInfo) {
                  onFileRecorded?.call(
                    file,
                    fileInfo != null ? {'info': fileInfo} : null,
                  );
                },
                iconSize: 20,
                padding: captureButtonPadding ?? const EdgeInsets.all(11),
                backgroundColor:
                    captureButtonBackgroundColor ?? AppColors.backgroundColor,
                iconColor: captureButtonIconColor ?? Colors.white,
              ),
            ],
          ],
        ),
      ],
    );
  }

  /// Whether [doc] represents an audio file based on its extension.
  static bool _isAudioDocument(HubDocument doc) {
    return isAudioDocument(doc.documentId);
  }
}

/// Displays a single image document with optional metadata.
class _DocumentItem extends StatelessWidget {
  final HubDocument file;
  final bool isAdmin;
  final bool showMetadata;
  final VoidCallback onDelete;

  const _DocumentItem({
    required this.file,
    required this.isAdmin,
    required this.showMetadata,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showMetadata)
          Text(
            file.createdAt.formatDateForUser(),
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
          ),
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                    maxHeight: 800,
                  ),
                  child: EncryptedDocumentImage(
                    documentId: file.documentId,
                    size: 400,
                  ),
                ),
              ),
            );
          },
          onLongPress: () async {
            if (!isAdmin) {
              di<NotificationService>().showSnackBar(
                NotificationType.error,
                'Nur Admins können Dokumente löschen',
              );
              return;
            }
            final confirm = await confirmationDialog(
              context: context,
              title: 'Dokument löschen',
              message: 'Dokument wirklich löschen?',
            );
            if (confirm != true) return;

            onDelete();
          },
          child: EncryptedDocumentImage(documentId: file.documentId, size: 70),
        ),
        if (showMetadata)
          Text(
            file.createdBy,
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
          ),
      ],
    );
  }
}

/// Displays a single audio document with optional metadata.
class _AudioDocumentItem extends StatelessWidget {
  final HubDocument file;
  final bool showMetadata;
  final VoidCallback onDelete;

  const _AudioDocumentItem({
    required this.file,
    required this.showMetadata,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showMetadata)
          Text(
            file.createdAt.formatDateForUser(),
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
          ),
        AudioButton(file: file, onDelete: (file) async => onDelete()),
        if (showMetadata)
          Text(
            file.createdBy,
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
          ),
      ],
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/audio/audio.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/buttons_switches/media_capture_buttons.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/hub_document/encrypted_document_image.dart';
import 'package:school_data_hub_flutter/core/auth/auth_clearance_helper.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';

/// A reusable widget for displaying and managing document collections.
///
/// Supports both image and audio documents, with optional metadata display
/// (creation date and creator) and admin-controlled deletion.
class HubDocumentsSectionWidget extends StatelessWidget {
  /// The list of documents to display.
  final List<HubDocument>? documents;

  /// Callback when an image file is captured.
  final Future<void> Function(File? file) onImageFileCaptured;

  /// Callback when a file is recorded (audio).
  final Future<void> Function(File? file, String? fileInfo)?
  onAudioFileRecorded;

  /// Callback when a document should be removed.
  final Future<void> Function(String documentId) onDeleteDocument;

  /// Maximum number of documents allowed (default: 4).
  final int maxDocuments;

  /// Wether to have a spacer between domuments and buttons
  final bool withSpacerToButtons;

  /// Whether to show metadata (date, creator) under each document.
  final bool showMetadata;

  /// Optional title to display above the documents section.
  final String? title;

  /// Optional padding for the MediaCaptureButtons.
  final EdgeInsets? captureButtonPadding;

  /// Optional background color for MediaCaptureButtons.
  final Color? buttonsBackgroundColor;

  /// Optional icon color for MediaCaptureButtons.
  final Color? buttonsIconColor;

  const HubDocumentsSectionWidget({
    required this.documents,
    required this.withSpacerToButtons,
    required this.onImageFileCaptured,
    required this.onDeleteDocument,
    this.onAudioFileRecorded,
    this.maxDocuments = 4,
    this.showMetadata = true,
    this.title,
    this.captureButtonPadding,
    this.buttonsBackgroundColor,
    this.buttonsIconColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final files = documents;

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
            if (totalCount == 0)
              SizedBox(
                height: 70,
                width: (21 / 30) * 70,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 221, 221, 221),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      'Keine\nDokumente',
                      style: TextStyle(
                        fontSize: 8,
                        color: Color.fromARGB(255, 110, 110, 110),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            for (final file in imageFiles) ...[
              _DocumentItem(
                file: file,
                isAuthorizedToDelete: AuthClearanceHelper.isCreatorOrAdmin(
                  file.createdBy,
                ),
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
              withSpacerToButtons ? const Spacer() : const Gap(15),
              MediaCaptureButtons(
                onFileCaptured: onImageFileCaptured,
                onFileRecorded: (file, fileInfo) {
                  onAudioFileRecorded?.call(file, fileInfo);
                },
                iconSize: 20,
                padding: captureButtonPadding ?? const EdgeInsets.all(11),
                backgroundColor:
                    buttonsBackgroundColor ?? AppColors.backgroundColor,
                iconColor: buttonsIconColor ?? Colors.white,
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
  final bool isAuthorizedToDelete;
  final bool showMetadata;
  final VoidCallback onDelete;

  const _DocumentItem({
    required this.file,
    required this.isAuthorizedToDelete,
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
            // TODO: Thie needs to be used with ZoomWidget
            showDialog<void>(
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
            if (!isAuthorizedToDelete) {
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

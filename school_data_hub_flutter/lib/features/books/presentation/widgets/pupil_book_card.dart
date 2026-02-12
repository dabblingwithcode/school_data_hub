import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:path/path.dart' as p;
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/create_and_crop_image_file.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/app_utils/record_audio_file.dart';
import 'package:school_data_hub_flutter/common/audio/audio.dart';
import 'package:school_data_hub_flutter/common/data/file_upload_service.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/encrypted_document_image.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/common/widgets/unencrypted_image_in_card.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_manager.dart';

class PupilBookLendingCard extends StatelessWidget {
  const PupilBookLendingCard({
    required this.pupilBookLending,
    required this.pupilId,
    super.key,
  });
  final PupilBookLending pupilBookLending;
  final int pupilId;

  @override
  Widget build(BuildContext context) {
    final LibraryBookProxy book = di<BookManager>().getLibraryBookById(
      pupilBookLending.libraryBookId,
    )!;
    void updatePupilBookRating(int rating) {
      di<PupilProxyManager>().updatePupilBookLending(
        pupilBookLending: pupilBookLending,
        score: (value: rating),
      );
    }

    void updateBookScore(int? score) {
      di<PupilProxyManager>().updatePupilBookLending(
        pupilBookLending: pupilBookLending,
        bookScore: (value: score),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
        color: AppColors.cardInCardColor,
        child: InkWell(
          onLongPress: () async {
            final isAuthorized =
                di<HubSessionManager>().isAdmin ||
                di<HubSessionManager>().userName == pupilBookLending.lentBy;

            if (!isAuthorized) {
              informationDialog(
                context,
                'Keine Berechtigung',
                'Ausleihen können nur von der eintragenden Person bearbeitet werden!',
              );
              return;
            }
            final bool? result = await confirmationDialog(
              context: context,
              title: 'Ausleihe löschen',
              message: 'Ausleihe von "${book.title}" wirklich löschen?',
            );
            if (result == true) {
              di<PupilProxyManager>().deletePupilBook(
                lendingId: pupilBookLending.lendingId,
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 5,
              left: 10,
              right: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          book.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                  ],
                ),
                const Gap(10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        UnencryptedImageInCard(
                          cacheKey: book.isbn.toString(),
                          path: book.imagePath,
                          size: 80,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(5),
                            Text('Bucherei-Id: ${book.libraryId}'),
                            const Gap(5),
                            Row(
                              children: [
                                Text(
                                  pupilBookLending.lentBy,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Gap(2),
                                const Icon(
                                  Icons.arrow_circle_right_rounded,
                                  color: Colors.orange,
                                ),
                                const Gap(2),
                                Text(
                                  pupilBookLending.lentAt
                                      .toLocal()
                                      .formatDateForUser(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            if (pupilBookLending.returnedAt != null)
                              Row(
                                children: [
                                  Text(
                                    pupilBookLending.receivedBy!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Gap(2),
                                  const Icon(
                                    Icons.arrow_circle_left_rounded,
                                    color: Colors.green,
                                  ),
                                  const Gap(2),
                                  Text(
                                    pupilBookLending.returnedAt!
                                        .formatDateForUser(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            const Gap(10),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GrowthDropdown(
                          dropdownValue: pupilBookLending.score,
                          onChangedFunction: updatePupilBookRating,
                        ),
                      ],
                    ),
                  ],
                ),
                _BookScoreDisplay(
                  bookScore: pupilBookLending.bookScore,
                  onChanged: updateBookScore,
                ),
                const Gap(10),
                const Text(
                  'Beobachtungen:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () async {
                    final result = await longTextFieldDialog(
                      title: 'Status',
                      labelText: 'Status',
                      initialValue: pupilBookLending.status ?? '',
                      parentContext: context,
                    );
                    if (result == null ||
                        result.value == pupilBookLending.status) {
                      return;
                    }
                    await di<PupilProxyManager>().updatePupilBookLending(
                      pupilBookLending: pupilBookLending,
                      status: (value: result.value),
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.interactiveColor.withValues(
                          alpha: 0.3,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      (pupilBookLending.status == null ||
                              pupilBookLending.status == '')
                          ? 'Kein Eintrag - Tippen zum Bearbeiten'
                          : pupilBookLending.status!,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.interactiveColor,
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                _DocumentsSection(
                  pupilBookLending: pupilBookLending,
                  pupilId: pupilId,
                ),
                const Gap(10),
                if (pupilBookLending.returnedAt == null) ...[
                  const Gap(5),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                            bottom: 8,
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              final result = await confirmationDialog(
                                context: context,
                                title: 'Buch zurückgeben',
                                message:
                                    'Buch "${book.title}" wirklich zurückgeben?',
                              );
                              if (result!) {
                                di<PupilProxyManager>().returnLibraryBook(
                                  pupilBookLending: pupilBookLending,
                                );
                              }
                            },
                            style: AppStyles.successButtonStyle,
                            child: const Text(
                              'BUCH ZURÜCKGEBEN',
                              style: AppStyles.buttonTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Displays the current bookScore as a tappable row that opens a slider dialog.
class _BookScoreDisplay extends StatelessWidget {
  const _BookScoreDisplay({required this.bookScore, required this.onChanged});

  final int? bookScore;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result = await _showBookScoreDialog(
          context: context,
          initialScore: bookScore,
        );
        if (result != null && result != bookScore) {
          onChanged(result);
        }
      },
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          const Text(
            'Buchbewertung:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Gap(8),
          Text(
            bookScore != null ? '$bookScore / 10' : 'Nicht bewertet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: bookScore != null
                  ? _bookScoreColor(bookScore!)
                  : Colors.grey,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.edit,
            size: 18,
            color: AppColors.interactiveColor.withValues(alpha: 0.6),
          ),
        ],
      ),
    );
  }
}

/// Shows a dialog with a slider to pick a bookScore from 0 to 10.
/// Returns the selected score or null if cancelled.
Future<int?> _showBookScoreDialog({
  required BuildContext context,
  required int? initialScore,
}) {
  return showDialog<int>(
    context: context,
    builder: (context) => _BookScoreDialog(initialScore: initialScore),
  );
}

class _BookScoreDialog extends StatefulWidget {
  const _BookScoreDialog({required this.initialScore});

  final int? initialScore;

  @override
  State<_BookScoreDialog> createState() => _BookScoreDialogState();
}

class _BookScoreDialogState extends State<_BookScoreDialog> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = (widget.initialScore ?? 0).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final score = _currentValue.round();
    return AlertDialog(
      title: const Text('Buchbewertung'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$score',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: _bookScoreColor(score),
            ),
          ),
          const Gap(4),
          Text(
            _bookScoreLabel(score),
            style: TextStyle(fontSize: 14, color: _bookScoreColor(score)),
          ),
          const Gap(16),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: _bookScoreColor(score),
              inactiveTrackColor: Colors.grey.shade300,
              thumbColor: _bookScoreColor(score),
              overlayColor: _bookScoreColor(score).withValues(alpha: 0.2),
              trackHeight: 6,
            ),
            child: Slider(
              value: _currentValue,
              min: 0,
              max: 10,
              divisions: 10,
              label: score.toString(),
              onChanged: (value) {
                setState(() {
                  _currentValue = value;
                });
              },
            ),
          ),
          const Gap(4),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('0', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('5', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('10', style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Abbrechen'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(score),
          child: const Text('Speichern'),
        ),
      ],
    );
  }
}

/// Returns a color representing the score from red (0) to green (10).
Color _bookScoreColor(int score) {
  if (score <= 3) return Colors.red.shade400;
  if (score <= 5) return Colors.orange;
  if (score <= 7) return Colors.amber;
  return Colors.green;
}

/// Returns a descriptive label for the score.
String _bookScoreLabel(int score) {
  if (score == 0) return 'Nicht bewertet';
  if (score <= 2) return 'Schlecht';
  if (score <= 4) return 'Unterdurchschnittlich';
  if (score <= 6) return 'Durchschnittlich';
  if (score <= 8) return 'Gut';
  return 'Ausgezeichnet';
}

/// Whether [doc] represents an audio file based on its extension.
bool _isAudioDocument(HubDocument doc) {
  return isAudioDocument(doc.documentId);
}

/// Displays existing documents/audio and buttons to add new ones.
class _DocumentsSection extends StatelessWidget {
  const _DocumentsSection({
    required this.pupilBookLending,
    required this.pupilId,
  });

  final PupilBookLending pupilBookLending;
  final int pupilId;

  @override
  Widget build(BuildContext context) {
    final files = pupilBookLending.pupilBookLendingFiles;
    final isAdmin = di<HubSessionManager>().isAdmin;
    final imageFiles = files?.where((f) => !_isAudioDocument(f)).toList() ?? [];
    final audioFiles = files?.where((f) => _isAudioDocument(f)).toList() ?? [];
    final totalCount = (files?.length ?? 0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Dokumente:', style: TextStyle(fontWeight: FontWeight.bold)),
        const Gap(4),
        Row(
          children: [
            for (final file in imageFiles) ...[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    file.createdAt.formatDateForUser(),
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
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
                      if (!isAdmin ||
                          file.createdBy != di<HubSessionManager>().userName) {
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

                      await _removeFile(file);
                    },
                    child: EncryptedDocumentImage(
                      documentId: file.documentId,
                      size: 70,
                    ),
                  ),
                  Text(
                    file.createdBy,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Gap(10),
            ],
            for (final file in audioFiles) ...[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    file.createdAt.formatDateForUser(),
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AudioButton(
                    file: file,
                    onDelete: _removeFile,
                  ),
                  Text(
                    file.createdBy,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Gap(10),
            ],
            if (totalCount < 4) ...[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      final File? file = await createAndCropImageFile(context);
                      if (file == null) return;

                      await _uploadFile(file);
                    },
                    child: SizedBox(
                      height: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset('assets/document_camera.png'),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      final ({File? file, String? fileInfo})? result =
                          await recordAudioFile(context);
                      if (result == null) return;

                      await _uploadFile(
                        result.file!,
                        fileInfo: result.fileInfo,
                      );
                    },
                    child: SizedBox(
                      height: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset('assets/document_mic.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ],
    );
  }

  Future<void> _uploadFile(File file, {String? fileInfo}) async {
    final client = di<Client>();
    final notificationService = di<NotificationService>();
    final hubSessionManager = di<HubSessionManager>();
    final pupilManager = di<PupilProxyManager>();

    try {
      final encryptedFile = await customEncrypter.encryptFile(file);
      final fileResponse = await ClientFileUpload.uploadFile(
        file: encryptedFile,
        storageId: StorageId.private,
        folder: ServerStorageFolder.documents,
        fileInfo: fileInfo,
      );

      if (!fileResponse.success) {
        notificationService.showSnackBar(
          NotificationType.error,
          'Die Datei konnte nicht hochgeladen werden!',
        );
        return;
      }

      final updatedPupil = await ClientHelper.apiCall(
        call: () => client.pupilBookLending.addFileToPupilBookLending(
          pupilBookLending.lendingId,
          fileResponse.path!,
          hubSessionManager.userName!,
        ),
        errorMessage: 'Fehler beim Hinzufügen der Datei zur Ausleihe',
      );

      if (updatedPupil != null) {
        await pupilManager.updatePupilData(pupilId);
        notificationService.showSnackBar(
          NotificationType.success,
          'Datei zur Ausleihe hinzugefügt',
        );
      }
    } catch (e) {
      notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Hochladen der Datei: $e',
      );
    }
  }

  Future<void> _removeFile(HubDocument file) async {
    final client = di<Client>();
    final notificationService = di<NotificationService>();
    final pupilManager = di<PupilProxyManager>();

    try {
      final success = await ClientHelper.apiCall(
        call: () => client.pupilBookLending.removeFileFromPupilBookLending(
          pupilBookLending.lendingId,
          file.documentId,
        ),
        errorMessage: 'Fehler beim Entfernen der Datei von der Ausleihe',
      );

      if (success == true) {
        await pupilManager.updatePupilData(pupilId);
        notificationService.showSnackBar(
          NotificationType.success,
          'Datei von der Ausleihe entfernt',
        );
      }
    } catch (e) {
      notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Löschen der Datei: $e',
      );
    }
  }
}


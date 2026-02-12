import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:path/path.dart' as p;
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/create_and_crop_image_file.dart';
import 'package:school_data_hub_flutter/app_utils/record_audio_file.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/document_audio.dart';
import 'package:school_data_hub_flutter/common/widgets/encrypted_document_image.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_list_learning_page/widgets/pupil_competence_goals/new_competence_goal_page.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

class CompetenceGoalCard extends StatelessWidget {
  final CompetenceGoal pupilGoal;
  final PupilProxy pupil;
  const CompetenceGoalCard({
    required this.pupilGoal,
    required this.pupil,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25.0),
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    NewCompetenceGoalPage(existingGoal: pupilGoal),
              ),
            );
          },
          onLongPress: () async {
            final isAuthorized =
                di<HubSessionManager>().isAdmin ||
                di<HubSessionManager>().userName == pupilGoal.createdBy;

            if (!isAuthorized) {
              informationDialog(
                context,
                'Keine Berechtigung',
                'Lernziele können nur von der erstellenden Person bearbeitet werden!',
              );
              return;
            }
            final bool? result = await confirmationDialog(
              context: context,
              title: 'Lernziel löschen',
              message: 'Lernziel wirklich löschen?',
            );
            if (result == true) {
              di<CompetenceManager>().deleteCompetenceGoal(pupilGoal.publicId);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: CompetenceHelper.getCompetenceColor(
                      pupilGoal.competenceId,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          di<CompetenceManager>()
                              .findRootCompetenceById(pupilGoal.competenceId)
                              .name,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(5),
                Row(
                  children: [
                    GrowthDropdown(
                      dropdownValue: pupilGoal.score ?? 0,
                      onChangedFunction: (value) {
                        di<CompetenceManager>().updateCompetenceGoal(
                          publicId: pupilGoal.publicId,
                          score: (value: value),
                        );
                      },
                    ),
                    const Gap(10),
                    Flexible(
                      child: Text(
                        di<CompetenceManager>()
                            .findCompetenceById(pupilGoal.competenceId)
                            .name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                Row(
                  children: [
                    const Text('Ziel:'),
                    const Gap(10),
                    Flexible(
                      child: Text(
                        pupilGoal.description,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                if (pupilGoal.strategies != null &&
                    pupilGoal.strategies!.isNotEmpty) ...[
                  const Gap(5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Strategien:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const Gap(10),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (
                              int i = 0;
                              i < pupilGoal.strategies!.length;
                              i++
                            )
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '• ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        pupilGoal.strategies![i],
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
                const Gap(10),
                Row(
                  children: [
                    const Text('Erstellt von:'),
                    const Gap(10),
                    Text(
                      pupilGoal.createdBy,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Gap(15),
                    const Text('am'),
                    const Gap(10),
                    Text(
                      pupilGoal.createdAt.formatDateForUser(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Gap(5),
                _AchievedAtRow(pupilGoal: pupilGoal),
                const Gap(10),
                _GoalDocumentsSection(pupilGoal: pupilGoal),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Displays the achieved-at date with a tappable date picker.
class _AchievedAtRow extends StatelessWidget {
  const _AchievedAtRow({required this.pupilGoal});

  final CompetenceGoal pupilGoal;

  bool get _isAchieved {
    // A "zero" date (year <= 1) means not yet achieved
    return pupilGoal.achievedAt != null;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: _isAchieved ? pupilGoal.achievedAt : DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (picked == null) return;

        di<CompetenceManager>().updateCompetenceGoal(
          publicId: pupilGoal.publicId,
          achievedAt: (value: picked),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          Icon(
            _isAchieved ? Icons.check_circle : Icons.radio_button_unchecked,
            color: _isAchieved ? Colors.green : Colors.grey,
            size: 22,
          ),
          const Gap(8),
          if (_isAchieved) const Text('Erreicht am:'),
          const Gap(10),
          Text(
            _isAchieved
                ? pupilGoal.achievedAt!.formatDateForUser()
                : 'Als erreicht markieren',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _isAchieved ? Colors.green : AppColors.interactiveColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// Whether [doc] represents an audio file based on its extension.
bool _isAudioDocument(HubDocument doc) {
  final ext = p.extension(doc.documentId).toLowerCase();
  return {'.m4a', '.aac', '.wav', '.mp3', '.ogg'}.contains(ext);
}

/// Displays existing documents/audio and buttons to add new ones for a
/// competence goal.
class _GoalDocumentsSection extends StatelessWidget {
  const _GoalDocumentsSection({required this.pupilGoal});

  final CompetenceGoal pupilGoal;

  @override
  Widget build(BuildContext context) {
    final files = pupilGoal.documents;
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

                      await di<CompetenceManager>()
                          .removeFileFromCompetenceGoal(
                            publicId: pupilGoal.publicId,
                            documentId: file.documentId,
                          );
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
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            _AudioPlayerDialog(document: file),
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
                        title: 'Audio löschen',
                        message: 'Audioaufnahme wirklich löschen?',
                      );
                      if (confirm != true) return;

                      await di<CompetenceManager>()
                          .removeFileFromCompetenceGoal(
                            publicId: pupilGoal.publicId,
                            documentId: file.documentId,
                          );
                    },
                    child: _AudioThumbnail(documentId: file.documentId),
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

                      await di<CompetenceManager>().addFileToCompetenceGoal(
                        publicId: pupilGoal.publicId,
                        file: file,
                      );
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

                      await di<CompetenceManager>().addFileToCompetenceGoal(
                        publicId: pupilGoal.publicId,
                        file: result.file!,
                        fileInfo: result.fileInfo!,
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
}

/// A dialog that hosts a [DocumentAudio] player and ensures the player is
/// fully shut down before the dialog is removed from the widget tree.
class _AudioPlayerDialog extends StatefulWidget {
  const _AudioPlayerDialog({required this.document});

  final HubDocument document;

  @override
  State<_AudioPlayerDialog> createState() => _AudioPlayerDialogState();
}

class _AudioPlayerDialogState extends State<_AudioPlayerDialog> {
  final _audioKey = GlobalKey<DocumentAudioState>();
  bool _closing = false;

  Future<void> _close() async {
    if (_closing) return;
    _closing = true;

    // Shut down the native audio player before popping.
    await _audioKey.currentState?.shutdown();

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          _close();
        }
      },
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Audioaufnahme',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Gap(4),
              Text(
                '${widget.document.createdBy}, ${widget.document.createdAt.formatDateForUser()}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const Gap(16),
              DocumentAudio(
                key: _audioKey,
                documentId: widget.document.documentId,
                decrypt: true,
              ),
              const Gap(16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _close,
                  child: const Text('Schließen'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A small thumbnail for audio files that parses the duration from the
/// documentId and displays it below the audio icon.
class _AudioThumbnail extends StatelessWidget {
  const _AudioThumbnail({required this.documentId});

  final String documentId;

  /// Parses duration from documentId format: "00-01_839400e1-12c2-4d3a-894f-a715eac9b1ee.m4a"
  /// Returns null if parsing fails.
  static Duration? _parseDuration(String documentId) {
    try {
      final match = RegExp(r'^(\d{2})-(\d{2})_').firstMatch(documentId);
      if (match != null) {
        final minutes = int.parse(match.group(1)!);
        final seconds = int.parse(match.group(2)!);
        return Duration(minutes: minutes, seconds: seconds);
      }
    } catch (_) {}
    return null;
  }

  static String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final duration = _parseDuration(documentId);

    return SizedBox(
      height: 70,
      width: (21 / 30) * 70,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.interactiveColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: AppColors.interactiveColor.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.audiotrack, size: 30, color: AppColors.interactiveColor),
            const SizedBox(height: 2),
            if (duration != null)
              Text(
                _formatDuration(duration),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.interactiveColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

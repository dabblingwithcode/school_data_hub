import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/common/widgets/hub_document/hub_documents_section.dart';
import 'package:school_data_hub_flutter/common/widgets/unencrypted_image_in_card.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';
import 'package:school_data_hub_flutter/features/books/domain/pupil_book_lending_manager.dart';

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
      di<PupilBookLendingManager>().updatePupilBookLending(
        pupilBookLending: pupilBookLending,
        score: (value: rating),
      );
    }

    void updateBookScore(int? score) {
      di<PupilBookLendingManager>().updatePupilBookLending(
        pupilBookLending: pupilBookLending,
        bookScore: (value: score),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
        color: AppColors.cardInCardColor,
        child: InkWell(
          mouseCursor: SystemMouseCursors.click,
          focusColor: AppColors.cardInCardColor,
          hoverColor: AppColors.cardInCardColor.withValues(alpha: 0.5),
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
              di<PupilBookLendingManager>().deletePupilBookLending(
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
                    await di<PupilBookLendingManager>().updatePupilBookLending(
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
                HubDocumentsSectionWidget(
                  title: 'Dokumente:',
                  documents: pupilBookLending.pupilBookLendingFiles,
                  withSpacerToButtons: true,
                  showMetadata: true,
                  onImageFileCaptured: (file) async {
                    if (file == null) return;
                    await di<PupilBookLendingManager>().addPupilBookLendingFile(
                      file,
                      pupilBookLending: pupilBookLending,
                    );
                  },
                  onAudioFileRecorded: (file, fileInfo) async {
                    if (file == null) return;
                    await di<PupilBookLendingManager>().addPupilBookLendingFile(
                      file,
                      pupilBookLending: pupilBookLending,
                      fileInfo: fileInfo,
                    );
                  },
                  onDeleteDocument: (documentId) async {
                    await di<PupilBookLendingManager>()
                        .deletePupilBookLendingFile(
                          pupilBookLending: pupilBookLending,
                          fileId: documentId,
                        );
                  },
                  buttonsBackgroundColor: AppColors.backgroundColor,
                  buttonsIconColor: Colors.white,
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
                                di<PupilBookLendingManager>().returnLibraryBook(
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
          bookScore != null
              ? _buildStarRow(bookScore!)
              : const Text(
                  'Nicht bewertet',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
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
          _buildClickableStarRow(
            score: score,
            onStarTapped: (newScore) {
              setState(() {
                _currentValue = newScore.toDouble();
              });
            },
          ),
          const Gap(12),
          Text(
            _bookScoreLabel(score),
            style: const TextStyle(fontSize: 14, color: Colors.amber),
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

/// Returns a descriptive label for the score.
String _bookScoreLabel(int score) {
  switch (score) {
    case 0:
      return 'Nicht bewertet';
    case 1:
      return 'Schlecht';
    case 2:
      return 'Nicht empfohlen';
    case 3:
      return 'Durchschnittlich';
    case 4:
      return 'Gut';
    case 5:
      return 'Ausgezeichnet';
    default:
      return '';
  }
}

/// Builds a row of 5 stars with yellow stars for achieved and grey for unachieved.
Widget _buildStarRow(int score) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(5, (index) {
      final isAchieved = index < score;
      return Icon(
        isAchieved ? Icons.star : Icons.star_outline,
        color: isAchieved ? Colors.amber : Colors.grey,
        size: 20,
      );
    }),
  );
}

/// Builds a clickable row of 5 stars for the dialog.
Widget _buildClickableStarRow({
  required int score,
  required ValueChanged<int> onStarTapped,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(5, (index) {
      final starNumber = index + 1;
      final isAchieved = index < score;
      return GestureDetector(
        onTap: () => onStarTapped(starNumber),
        child: Icon(
          isAchieved ? Icons.star : Icons.star_outline,
          color: isAchieved ? Colors.amber : Colors.grey,
          size: 48,
        ),
      );
    }),
  );
}

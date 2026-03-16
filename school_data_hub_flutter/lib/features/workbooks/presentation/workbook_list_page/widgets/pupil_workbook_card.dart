import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/create_and_crop_image_file.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/common/widgets/unencrypted_image_in_card.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/widgets/competence_grades_widget.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/pupil_workbook_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_enums.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/new_workbook_page/new_workbook_page.dart';

class PupilWorkbookCard extends WatchingWidget {
  const PupilWorkbookCard({
    required this.pupilWorkbook,
    required this.pupilId,
    super.key,
  });
  final PupilWorkbook pupilWorkbook;
  final int pupilId;

  @override
  Widget build(BuildContext context) {
    final Workbook workbook = pupilWorkbook.workbook!;
    final manager = di<PupilWorkbookManager>();
    final pupilWorkbooks = watchPropertyValue(
      (value) => manager.getPupilWorkbooks(pupilId),
      target: manager,
    );
    final PupilWorkbook thisPupilWorkbook = pupilWorkbooks.firstWhere(
      (pupilWorkbook) => pupilWorkbook.id == this.pupilWorkbook.id,
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
        color: AppColors.cardInCardColor,
        child: InkWell(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          canRequestFocus: false,
          onLongPress: () async {
            if (thisPupilWorkbook.createdBy !=
                    di<HubSessionManager>().userName ||
                !di<HubSessionManager>().isAdmin) {
              informationDialog(
                context,
                'Keine Berechtigung',
                'Arbeitshefte können nur von der eintragenden Person bearbeitet werden!',
              );
              return;
            }
            final bool? result = await confirmationDialog(
              context: context,
              title: 'Arbeitsheft löschen',
              message: 'Arbeitsheft "${workbook.name}" wirklich löschen?',
            );
            if (result == true) {
              di<PupilWorkbookManager>().deletePupilWorkbook(
                pupilId,
                pupilWorkbook.id!,
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {
                            final File? file = await createAndCropImageFile(
                              context,
                            );
                            if (file == null) return;
                            await di<WorkbookManager>().postWorkbookFile(
                              file,
                              workbook.isbn,
                            );
                          },
                          onLongPress: () async {
                            final bool? result = await confirmationDialog(
                              context: context,
                              title: 'Bild löschen',
                              message: 'Bild löschen?',
                            );
                            if (result != true) return;
                            await di<WorkbookManager>().deleteWorkbookFile(
                              workbook.isbn,
                            );
                          },
                          child: UnencryptedImageInCard(
                            cacheKey: pupilWorkbook.isbn.toString(),
                            path: thisPupilWorkbook.workbook!.imageUrl,
                            size: 100,
                          ),
                        ),

                        const Gap(10),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onLongPress: () {
                                      //navigate to edit workbook page
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (context) => NewWorkbookPage(
                                            isbn: workbook.isbn,
                                            isEdit: true,
                                            workbook: workbook,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      workbook.name,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                const Gap(10),
                              ],
                            ),
                            const Gap(5),
                            // Row(
                            //   children: [
                            //     const Text('ISBN:'),
                            //     const Gap(10),
                            //     Text(
                            //       workbook.isbn.toString(),
                            //       style: const TextStyle(
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // const Gap(5),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            workbook.subject != null
                                                ? SubjectEnum.values
                                                          .firstWhereOrNull(
                                                            (element) =>
                                                                element.name ==
                                                                workbook
                                                                    .subject,
                                                          )
                                                          ?.imagePath ??
                                                      'assets/images/learning_icons/unknown.png'
                                                : 'assets/images/learning_icons/unknown.png',
                                            width: 25,
                                            height: 25,
                                          ),

                                          const Gap(5),
                                          workbook.level != null
                                              ? GradesWidget(
                                                  stringWithGrades:
                                                      workbook.level!,
                                                )
                                              : const Text('nicht vorhanden'),
                                        ],
                                      ),
                                      const Gap(5),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              if (!(di<HubSessionManager>()
                                                          .userName ==
                                                      thisPupilWorkbook
                                                          .createdBy) ||
                                                  di<HubSessionManager>()
                                                      .isAdmin) {
                                                informationDialog(
                                                  context,
                                                  'Keine Berechtigung',
                                                  'Arbeitshefte können nur von der eingetragenen Person oder von einem Admin bearbeitet werden!',
                                                );
                                                return;
                                              }
                                              final createdBy =
                                                  await shortTextfieldDialog(
                                                    context: context,
                                                    title: 'Betreuer:in ändern',
                                                    labelText:
                                                        'Betreuer:in eintragen',
                                                    hintText:
                                                        'Wer soll das Arbeitsheft betreuen?',
                                                  );
                                              if (createdBy == null) return;
                                              di<PupilWorkbookManager>()
                                                  .updatePupilWorkbook(
                                                    pupilWorkbook:
                                                        thisPupilWorkbook,
                                                    createdBy: createdBy,
                                                  );
                                            },
                                            child: Text(
                                              thisPupilWorkbook.createdBy,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const Gap(2),
                                          const Icon(
                                            Icons.arrow_circle_right_rounded,
                                            color: Colors.orange,
                                          ),
                                          const Gap(2),
                                          Text(
                                            thisPupilWorkbook.createdAt
                                                .formatDateForUser(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Gap(5),

                                      const Gap(10),
                                    ],
                                  ),
                                ),
                                const Gap(10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap:
                                          () {}, // Absorb tap to prevent parent InkWell activation
                                      child: GrowthDropdown(
                                        dropdownValue: thisPupilWorkbook.score,
                                        onChangedFunction: (value) {
                                          manager.updatePupilWorkbook(
                                            pupilWorkbook: thisPupilWorkbook,
                                            score: value,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            _FinishedAtRow(pupilWorkbook: thisPupilWorkbook),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                InkWell(
                  onTap: () async {
                    final result = await longTextFieldDialog(
                      title: 'Kommentar',
                      initialValue: thisPupilWorkbook.comment ?? '',
                      labelText: 'Kommentar eintragen',
                      parentContext: context,
                    );
                    if (result == null ||
                        result.value == thisPupilWorkbook.comment) {
                      return;
                    }
                    di<PupilWorkbookManager>().updatePupilWorkbook(
                      pupilWorkbook: thisPupilWorkbook,
                      comment: (value: result.value),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                        textAlign: TextAlign.left,
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Kommentar: ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  (thisPupilWorkbook.comment == null ||
                                      thisPupilWorkbook.comment!.isEmpty)
                                  ? 'Kein Kommentar'
                                  : thisPupilWorkbook.comment!,
                            ),
                          ],
                        ),
                        softWrap: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Displays the finished-at date with a tappable date picker.
class _FinishedAtRow extends StatelessWidget {
  const _FinishedAtRow({required this.pupilWorkbook});

  final PupilWorkbook pupilWorkbook;

  bool get _isFinished =>
      pupilWorkbook.finishedAt != null && pupilWorkbook.finishedAt!.year > 1;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: _isFinished ? pupilWorkbook.finishedAt! : DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (picked == null) return;

        di<PupilWorkbookManager>().updatePupilWorkbook(
          pupilWorkbook: pupilWorkbook,
          finishedAt: (value: picked),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          Icon(
            _isFinished ? Icons.check_circle : Icons.radio_button_unchecked,
            color: _isFinished ? Colors.green : Colors.grey,
            size: 22,
          ),
          const Gap(8),
          if (_isFinished) const Text('Abgeschlossen am:'),
          const Gap(10),
          Text(
            _isFinished
                ? pupilWorkbook.finishedAt!.formatDateForUser()
                : 'Als abgeschlossen markieren',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _isFinished ? Colors.green : AppColors.interactiveColor,
            ),
          ),
          if (_isFinished) ...[
            const Gap(20),
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.red, size: 20),
              tooltip: 'Datum entfernen',
              onPressed: () {
                di<PupilWorkbookManager>().updatePupilWorkbook(
                  pupilWorkbook: pupilWorkbook,
                  finishedAt: (value: null),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/common/widgets/unencrypted_image_in_card.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/widgets/competence_grades_widget.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/pupil_workbook_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_enums.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/new_workbook_screen/new_workbook_screen.dart';

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
    final style = Style.of(context);
    final Workbook workbook = pupilWorkbook.workbook!;
    final manager = di<PupilWorkbookManager>();
    final pupilWorkbooks = watchPropertyValue(
      (value) => manager.getPupilWorkbooks(pupilId),
      target: manager,
    );
    final PupilWorkbook thisPupilWorkbook = pupilWorkbooks.firstWhere(
      (pupilWorkbook) => pupilWorkbook.id == this.pupilWorkbook.id,
    );
    return CardBox(
      variant: CardBoxVariant.filled,
      padding: EdgeInsets.all(Style.spacing.sm),
      onTap: null,
      child: GestureDetector(
        onLongPress: () async {
          if (thisPupilWorkbook.createdBy != di<HubSessionManager>().userName ||
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(Style.spacing.xs),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    UnencryptedImageInCard(
                      cacheKey: pupilWorkbook.isbn.toString(),
                      path: thisPupilWorkbook.workbook!.imageUrl,
                      type: UnencryptedImageType.workbook,
                      size: 100,
                    ),
                    Gap(Style.spacing.sm),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Style.spacing.sm + 2,
                      bottom: Style.spacing.sm,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onLongPress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (context) => NewWorkbookScreen(
                                        isbn: workbook.isbn,
                                        isEdit: true,
                                        workbook: workbook,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  workbook.name,
                                  style: context.typography.title.withColor(
                                    style.colors.foreground,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Gap(Style.spacing.sm),
                          ],
                        ),
                        Gap(Style.spacing.xs),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        workbook.subject != null
                                            ? SubjectEnum.values
                                                      .firstWhereOrNull(
                                                        (element) =>
                                                            element.name ==
                                                            workbook.subject,
                                                      )
                                                      ?.imagePath ??
                                                  'assets/images/learning_icons/unknown.png'
                                            : 'assets/images/learning_icons/unknown.png',
                                        width: 25,
                                        height: 25,
                                      ),
                                      Gap(Style.spacing.xs),
                                      workbook.level != null
                                          ? GradesWidget(
                                              stringWithGrades: workbook.level!,
                                            )
                                          : Text(
                                              'nicht vorhanden',
                                              style: context.typography.body,
                                            ),
                                    ],
                                  ),
                                  Gap(Style.spacing.xs),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          if (!(di<HubSessionManager>()
                                                      .userName ==
                                                  thisPupilWorkbook
                                                      .createdBy) ||
                                              di<HubSessionManager>().isAdmin) {
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
                                          style: context.typography.body.bold,
                                        ),
                                      ),
                                      const Gap(2),
                                      Icon(
                                        Icons.arrow_circle_right_rounded,
                                        color: style.colors.warning,
                                      ),
                                      const Gap(2),
                                      Text(
                                        thisPupilWorkbook.createdAt
                                            .formatDateForUser(),
                                        style: context.typography.body.bold,
                                      ),
                                    ],
                                  ),
                                  Gap(Style.spacing.xs),
                                  Gap(Style.spacing.sm),
                                ],
                              ),
                            ),
                            Gap(Style.spacing.sm),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {},
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
            Gap(Style.spacing.sm),
            GestureDetector(
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
                padding: EdgeInsets.only(left: Style.spacing.sm + 2),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    textAlign: TextAlign.left,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Kommentar: ',
                          style: context.typography.subtitle,
                        ),
                        TextSpan(
                          text:
                              (thisPupilWorkbook.comment == null ||
                                  thisPupilWorkbook.comment!.isEmpty)
                              ? 'Kein Kommentar'
                              : thisPupilWorkbook.comment!,
                          style: context.typography.body,
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
    final style = Style.of(context);
    return GestureDetector(
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
      child: Row(
        children: [
          Icon(
            _isFinished ? Icons.check_circle : Icons.radio_button_unchecked,
            color: _isFinished
                ? style.colors.success
                : style.colors.mutedForeground,
            size: 22,
          ),
          Gap(Style.spacing.sm),
          if (_isFinished)
            Text('Abgeschlossen am:', style: context.typography.body),
          Gap(Style.spacing.sm),
          Text(
            _isFinished
                ? pupilWorkbook.finishedAt!.formatDateForUser()
                : 'Als abgeschlossen markieren',
            style: context.typography.body.bold.withColor(
              _isFinished ? style.colors.success : style.colors.interactive,
            ),
          ),
          if (_isFinished) ...[
            Gap(Style.spacing.xl),
            TappableIcon(
              icon: Icon(Icons.clear, color: style.colors.error, size: 20),
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

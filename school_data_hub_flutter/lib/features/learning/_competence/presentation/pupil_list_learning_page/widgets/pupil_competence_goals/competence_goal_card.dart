import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/common/widgets/hub_document/hub_documents_section.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/pupil_list_learning_page/widgets/pupil_competence_goals/new_competence_goal_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

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
    final style = Style.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(Style.radii.large),
      child: CardBox(
        padding: EdgeInsets.all(Style.spacing.sm),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) =>
                  NewCompetenceGoalPage(existingGoal: pupilGoal),
            ),
          );
        },
        child: GestureDetector(
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
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Style.spacing.xs),
                  color: CompetenceHelper.getCompetenceColor(
                    pupilGoal.competenceId,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Style.spacing.xs),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        di<CompetenceManager>()
                            .findRootCompetenceById(pupilGoal.competenceId)
                            .name,
                        style: context.typography.title.withColor(
                          style.colors.background,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(Style.spacing.xs),
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
                  Gap(Style.spacing.md),
                  Flexible(
                    child: Text(
                      di<CompetenceManager>()
                          .findCompetenceById(pupilGoal.competenceId)
                          .name,
                      style: context.typography.subtitle.bold,
                    ),
                  ),
                ],
              ),
              Gap(Style.spacing.xs),
              Row(
                children: [
                  const Text('Ziel:'),
                  Gap(Style.spacing.md),
                  Flexible(
                    child: Text(
                      pupilGoal.description,
                      style: context.typography.subtitle.bold,
                    ),
                  ),
                ],
              ),
              if (pupilGoal.strategies != null &&
                  pupilGoal.strategies!.isNotEmpty) ...[
                Gap(Style.spacing.xs),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Strategien:',
                      style: context.typography.body.w500,
                    ),
                    Gap(Style.spacing.md),
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
                              padding: EdgeInsets.only(bottom: Style.spacing.xs),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '• ',
                                    style: context.typography.subtitle.bold,
                                  ),
                                  Expanded(
                                    child: Text(
                                      pupilGoal.strategies![i],
                                      style: context.typography.body,
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
              Gap(Style.spacing.md),
              Row(
                children: [
                  const Text('Erstellt von:'),
                  Gap(Style.spacing.md),
                  Text(
                    pupilGoal.createdBy,
                    style: context.typography.body.bold,
                  ),
                  Gap(Style.spacing.lg),
                  const Text('am'),
                  Gap(Style.spacing.md),
                  Text(
                    pupilGoal.createdAt.formatDateForUser(),
                    style: context.typography.body.bold,
                  ),
                ],
              ),
              Gap(Style.spacing.xs),
              _AchievedAtRow(pupilGoal: pupilGoal),
              Gap(Style.spacing.md),
              HubDocumentsSectionWidget(
                documents: pupilGoal.documents,
                withSpacerToButtons: true,
                title: 'Dokumente:',
                onImageFileCaptured: (file) async {
                  if (file == null) return;
                  await di<CompetenceManager>().addFileToCompetenceGoal(
                    publicId: pupilGoal.publicId,
                    file: file,
                  );
                },
                onAudioFileRecorded: (file, fileInfo) async {
                  if (file == null) return;
                  await di<CompetenceManager>().addFileToCompetenceGoal(
                    publicId: pupilGoal.publicId,
                    file: file,
                    fileInfo: fileInfo,
                  );
                },
                onDeleteDocument: (documentId) async {
                  await di<CompetenceManager>().removeFileFromCompetenceGoal(
                    publicId: pupilGoal.publicId,
                    documentId: documentId,
                  );
                },
              ),
            ],
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
    final style = Style.of(context);
    return GestureDetector(
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
      child: Row(
        children: [
          Icon(
            _isAchieved ? Icons.check_circle : Icons.radio_button_unchecked,
            color: _isAchieved ? style.colors.success : style.colors.mutedForeground,
            size: 22,
          ),
          Gap(Style.spacing.sm),
          if (_isAchieved) const Text('Erreicht am:'),
          Gap(Style.spacing.md),
          Text(
            _isAchieved
                ? pupilGoal.achievedAt!.formatDateForUser()
                : 'Als erreicht markieren',
            style: context.typography.body.bold.withColor(
              _isAchieved ? style.colors.success : style.colors.interactive,
            ),
          ),
        ],
      ),
    );
  }
}

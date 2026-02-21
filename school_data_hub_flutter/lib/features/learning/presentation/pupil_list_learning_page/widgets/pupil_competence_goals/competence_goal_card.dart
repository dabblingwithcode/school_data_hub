import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/growth_score_dropdown.dart';
import 'package:school_data_hub_flutter/common/widgets/hub_document/hub_documents_section.dart';
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

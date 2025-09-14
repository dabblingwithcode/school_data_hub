import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_competence_list_page/widgets/pupil_competence_checks/pupil_competence_card.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_competence_list_page/widgets/pupil_competence_checks/competence_check_card.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:watch_it/watch_it.dart';

List<Widget> buildPupilCompetenceStatusTree({
  required PupilProxy pupil,
  int? parentId,
  required double indentation,
  required Color? passedBackGroundColor,
  required BuildContext context,
}) {
  // This is the list of widgets that will be returned
  List<Widget> competenceWidgets = [];
  // Get all competences that are allowed for this pupil
  final competences = CompetenceHelper.getAllowedCompetencesForThisPupil(pupil);
  // Get the competence checks of the pupil as a map
  final Map<int, List<CompetenceCheck>> pupilCompetenceChecksMap =
      CompetenceHelper.getCompetenceChecksMappedTopublicIdsForThisPupil(
        pupil.pupilId,
      );

  Color competenceBackgroundColor = AppColors.backgroundColor;
  for (Competence competence in competences) {
    if (passedBackGroundColor == null) {
      competenceBackgroundColor = CompetenceHelper.getCompetenceColor(
        competence.publicId,
      );
    } else {
      competenceBackgroundColor = passedBackGroundColor;
    }
    double? averageCompetenceStatus;
    if (pupilCompetenceChecksMap.containsKey(competence.publicId)) {
      final filteredChecks =
          pupilCompetenceChecksMap[competence.publicId]!
              .where((check) => check.score != 0)
              .toList();

      if (filteredChecks.isNotEmpty) {
        final totalStatus = filteredChecks
            .map((check) => check.score)
            .reduce((a, b) => a + b);
        averageCompetenceStatus = totalStatus / filteredChecks.length;
      }
    }

    if (competence.parentCompetence == parentId) {
      final isReport =
          !di<CompetenceManager>().isCompetenceWithChildren(competence);
      final children = buildPupilCompetenceStatusTree(
        pupil: pupil,
        parentId: competence.publicId,
        indentation: indentation,
        passedBackGroundColor: competenceBackgroundColor,
        context: context,
      );

      competenceWidgets.add(
        Padding(
          padding: EdgeInsets.only(left: indentation),
          child:
              children.isNotEmpty ||
                      pupilCompetenceChecksMap.containsKey(competence.publicId)
                  ? Wrap(
                    children: [
                      PupilCompetenceCard(
                        backgroundColor: competenceBackgroundColor,
                        competence: competence,
                        pupil: pupil,
                        isReport: isReport,
                        competenceChecks:
                            pupilCompetenceChecksMap.containsKey(
                                  competence.publicId,
                                )
                                ? [
                                  ...pupilCompetenceChecksMap[competence
                                          .publicId]!
                                      .map((check) {
                                        return CompetenceCheckCard(
                                          competenceCheck: check,
                                        );
                                      }),
                                ]
                                : [],
                        checksAverageValue: averageCompetenceStatus,
                        children: children,
                      ),
                    ],
                  )
                  : PupilCompetenceCard(
                    backgroundColor: competenceBackgroundColor,
                    isReport: isReport,
                    competence: competence,
                    pupil: pupil,
                    competenceChecks: const [],
                    checksAverageValue: averageCompetenceStatus,
                    children: children,
                  ),
        ),
      );
    }
  }

  return competenceWidgets;
}

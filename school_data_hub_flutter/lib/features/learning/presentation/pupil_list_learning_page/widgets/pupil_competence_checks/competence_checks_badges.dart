import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/domain/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:watch_it/watch_it.dart';

String getRootCompetenceShortName(int competenceId) {
  final competence = di<CompetenceManager>().findCompetenceById(competenceId);
  final type = RootCompetenceType.stringToValue[competence.name];
  switch (type) {
    case RootCompetenceType.math:
      return 'MA';
    case RootCompetenceType.german:
      return 'DE';
    case RootCompetenceType.science:
      return 'SU';
    case RootCompetenceType.english:
      return 'EN';
    case RootCompetenceType.art:
      return 'KU';
    case RootCompetenceType.music:
      return 'MU';
    case RootCompetenceType.sport:
      return 'SP';
    case RootCompetenceType.religion:
      return 'RE';
    case RootCompetenceType.socialAndWorkSkills:
      return 'AV';
    case RootCompetenceType.motherLanguage:
      return 'SV';
    case RootCompetenceType.daz:
      return 'DaZ';
    default:
      return competence.name;
  }
}

class CompetenceChecksBadges extends StatelessWidget {
  final PupilProxy pupil;
  const CompetenceChecksBadges({super.key, required this.pupil});

  @override
  Widget build(BuildContext context) {
    List<CompetenceCheck> competenceChecks = pupil.competenceChecks ?? [];
    List<Widget> widgetList = [];
    Map<int, int> competenceCounts = {};
    Set<int> countedCompetenceIds = {};
    Map<int, int> rootCompetences = di<CompetenceManager>().rootCompetencesMap;
    for (int competenceId in rootCompetences.keys) {
      if (rootCompetences[competenceId] == competenceId) {
        competenceCounts[competenceId] = 0;
      }
    }
    // Calculate counts
    for (CompetenceCheck competenceCheck in competenceChecks) {
      if (countedCompetenceIds.contains(competenceCheck.competenceId)) {
        continue;
      }
      countedCompetenceIds.add(competenceCheck.competenceId);
      int rootCompetenceId = di<CompetenceManager>()
          .findRootCompetenceById(competenceCheck.competenceId)
          .publicId;
      if (competenceCounts.containsKey(rootCompetenceId)) {
        competenceCounts[rootCompetenceId] =
            competenceCounts[rootCompetenceId]! + 1;
      } else {
        competenceCounts[rootCompetenceId] = 1;
      }
    }

    competenceCounts.forEach((competenceId, count) {
      Color competenceColor = CompetenceHelper.getCompetenceColor(competenceId);
      widgetList.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                getRootCompetenceShortName(competenceId),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(2),
              Container(
                width: 21.0,
                height: 21.0,
                decoration: BoxDecoration(
                  color: competenceColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    count.toString(),
                    style: TextStyle(
                      color: AppColors.bestContrastCompetenceFontColor(
                        competenceColor,
                      ),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      widgetList.add(const Gap(5));
    });
    return Wrap(
      spacing: 5,
      direction: Axis.horizontal,
      alignment: WrapAlignment.end,
      children: [...widgetList],
    );
  }
}

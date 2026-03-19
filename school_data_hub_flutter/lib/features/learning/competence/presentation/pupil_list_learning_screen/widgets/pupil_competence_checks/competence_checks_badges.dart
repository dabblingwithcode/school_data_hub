import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/enums.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/pupil_proxy_competence_ext.dart';

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
    // Use cached competenceBadgeCounts from PupilProxy
    final competenceCounts = pupil.competenceBadgeCounts;
    List<Widget> widgetList = [];

    competenceCounts.forEach((competenceId, count) {
      Color competenceColor = CompetenceHelper.getCompetenceColor(competenceId);
      widgetList.add(
        Padding(
          padding: EdgeInsets.only(bottom: Style.spacing.xs),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                getRootCompetenceShortName(competenceId),
                style: context.typography.caption.bold.withColor(
                  Style.of(context).colors.foreground,
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
                    style: context.typography.body.bold.withColor(
                      AppColors.bestContrastCompetenceFontColor(
                        competenceColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      widgetList.add(Gap(Style.spacing.xs));
    });
    return Wrap(
      spacing: Style.spacing.xs,
      direction: Axis.horizontal,
      alignment: WrapAlignment.end,
      children: [...widgetList],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/enums.dart';

class LearningGoalsOverview extends WatchingWidget {
  final PupilProxy pupil;
  const LearningGoalsOverview({super.key, required this.pupil});

  String _getShortName(int rootCompetenceId) {
    final competence = di<CompetenceManager>().findCompetenceById(
      rootCompetenceId,
    );
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

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final competenceManager = di<CompetenceManager>();
    callOnce((_) => competenceManager.fetchGoalsForPupil(pupil.pupilId));
    final goalsProxy = competenceManager.getPupilCompetenceGoalsProxy(
      pupil.pupilId,
    );
    watch(goalsProxy);
    final competenceGoals = goalsProxy.competenceGoals;
    final Map<int, int> counts = {};

    for (final goal in competenceGoals) {
      final rootCompetence = di<CompetenceManager>().findRootCompetenceById(
        goal.competenceId,
      );
      final rootId = rootCompetence.publicId;
      counts[rootId] = (counts[rootId] ?? 0) + 1;
    }

    final List<Widget> widgetList = [];
    counts.forEach((rootId, count) {
      final Color competenceColor = CompetenceHelper.getCompetenceColor(rootId);
      widgetList.add(
        Padding(
          padding: EdgeInsets.only(bottom: Style.spacing.xs),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _getShortName(rootId),
                style: context.typography.caption.bold.withColor(
                  style.colors.foreground,
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

    if (widgetList.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: Style.spacing.lg,
          right: Style.spacing.md,
        ),
        child: Text(
          'keine Lernziele erfasst',
          style: context.typography.body
              .withColor(style.colors.mutedForeground)
              .copyWith(fontStyle: FontStyle.italic),
        ),
      );
    }

    return Wrap(
      spacing: Style.spacing.xs,
      direction: Axis.horizontal,
      alignment: WrapAlignment.end,
      children: widgetList,
    );
  }
}

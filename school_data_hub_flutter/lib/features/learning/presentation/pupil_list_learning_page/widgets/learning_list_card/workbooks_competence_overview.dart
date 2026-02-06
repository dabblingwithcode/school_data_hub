import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/domain/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

class WorkbooksCompetenceOverview extends StatelessWidget {
  final PupilProxy pupil;
  const WorkbooksCompetenceOverview({super.key, required this.pupil});

  String _getShortName(RootCompetenceType type) {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final pupilWorkbooks = pupil.pupilWorkbooks ?? [];
    final Map<RootCompetenceType, int> counts = {};

    for (final pw in pupilWorkbooks) {
      final subject = pw.workbook?.subject;
      if (subject == null) continue;

      final type = RootCompetenceType.stringToValue[subject];
      if (type != null) {
        counts[type] = (counts[type] ?? 0) + 1;
      }
    }

    final List<Widget> widgetList = [];
    counts.forEach((type, count) {
      final Color competenceColor = CompetenceHelper.getRootCompetenceColor(
        rootCompetenceType: type,
      );
      widgetList.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _getShortName(type),
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

    if (widgetList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15.0, right: 10),
        child: Text(
          'keine Arbeitshefte erfasst',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.withValues(alpha: 0.7),
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }

    return Wrap(
      spacing: 5,
      direction: Axis.horizontal,
      alignment: WrapAlignment.end,
      children: widgetList,
    );
  }
}

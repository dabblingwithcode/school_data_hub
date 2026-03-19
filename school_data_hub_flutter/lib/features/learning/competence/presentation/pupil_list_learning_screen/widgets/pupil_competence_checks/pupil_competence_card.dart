import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/widgets/competence_check_symbols.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/widgets/dialogues/new_competence_check_dialog.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

class PupilCompetenceCard extends WatchingWidget {
  final Color backgroundColor;
  final bool isReport;
  final Competence competence;
  final PupilProxy pupil;

  final List<Widget> children;
  final List<Widget> competenceChecks;
  final double? checksAverageValue;

  const PupilCompetenceCard({
    super.key,
    required this.backgroundColor,
    required this.isReport,
    required this.competence,
    required this.pupil,
    required this.children,
    required this.competenceChecks,
    required this.checksAverageValue,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final competenceManager = di<CompetenceManager>();
    final competenceColor = CompetenceHelper.getCompetenceColor(
      competence.publicId,
    );
    return Padding(
      padding: isReport
          ? EdgeInsets.symmetric(
              vertical: Style.spacing.xs,
              horizontal: Style.spacing.xs,
            )
          : EdgeInsets.symmetric(
              vertical: competence.parentCompetence == null ? 3 : 0,
            ),
      child: Column(
        children: [
          Gap(Style.spacing.md),
          Row(
            children: [
              Gap(Style.spacing.lg),
              Text(
                competence.name,
                style: context.typography.subtitle.bold.withColor(
                  AppColors.readableOnWhiteBackgroungColor(competenceColor),
                ),
              ),
              Gap(Style.spacing.md),
              Container(
                width: 23.0,
                height: 23.0,
                decoration: BoxDecoration(
                  color: competenceColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    competenceChecks.length.toString(),
                    textAlign: TextAlign.center,
                    style: context.typography.body.bold.withColor(
                      AppColors.bestContrastCompetenceFontColor(
                        competenceColor,
                      ),
                    ),
                  ),
                ),
              ),
              Gap(Style.spacing.md),
              Text(
                'Ø',
                style: context.typography.title.withColor(
                  style.colors.foreground,
                ),
              ),
              Gap(Style.spacing.xs),
              if (checksAverageValue != null)
                Text(
                  checksAverageValue!.toStringAsFixed(1),
                  style: context.typography.subtitle.bold.withColor(
                    style.colors.foreground,
                  ),
                ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  await competenceManager.postCompetenceCheck(
                    pupilId: pupil.pupilId,
                    competenceId: competence.publicId,
                    score: 0,
                    competenceComment: null,
                    groupId: null,
                  );
                },
                child: Icon(
                  Icons.add_circle_rounded,
                  color: isReport
                      ? style.colors.accent
                      : style.colors.interactive,
                ),
              ),
              Gap(Style.spacing.md),
              if (isReport) ...<Widget>[
                const Spacer(),
                GestureDetector(
                  onLongPress: () {
                    newCompetenceCheckDialog(
                      pupil: pupil,
                      competenceId: competence.publicId,
                      isReport: true,
                      parentContext: context,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(Style.spacing.sm),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: style.colors.interactive,
                    ),
                    child: _CompetenceReportCheckSymbolWidget(
                      pupil: pupil,
                      competenceId: competence.publicId,
                    ),
                  ),
                ),
              ],
            ],
          ),
          Gap(Style.spacing.xs),
          if (competenceChecks.isNotEmpty || isReport) ...competenceChecks,
          ...children,
        ],
      ),
    );
  }
}

/// Rebuilds only when [pupil.competenceChecks] changes.
class _CompetenceReportCheckSymbolWidget extends WatchingWidget {
  final PupilProxy pupil;
  final int competenceId;

  const _CompetenceReportCheckSymbolWidget({
    required this.pupil,
    required this.competenceId,
  });

  @override
  Widget build(BuildContext context) {
    watchPropertyValue((m) => m.competenceChecks, target: pupil);
    return getCompetenceReportCheckSymbol(pupil, competenceId);
  }
}

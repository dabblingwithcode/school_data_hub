import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/widgets/competence_check_symbols.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/widgets/dialogues/new_competence_check_dialog.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

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
    final competenceManager = di<CompetenceManager>();
    watch(pupil);
    final competenceColor = CompetenceHelper.getCompetenceColor(
      competence.publicId,
    );
    return Padding(
      padding: isReport
          ? const EdgeInsets.symmetric(vertical: 4, horizontal: 4)
          : EdgeInsets.symmetric(
              vertical: competence.parentCompetence == null ? 3 : 0,
            ),
      child: Column(
        children: [
          const Gap(10),
          Row(
            children: [
              const Gap(15),
              Text(
                competence.name,
                style: TextStyle(
                  color: competenceColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Gap(5),
          if (competenceChecks.isNotEmpty || isReport)
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 23.0,
                    height: 23.0,
                    decoration: BoxDecoration(
                      color: isReport ? Colors.white : competenceColor,
                      shape: BoxShape.circle,
                      // border: Border.all(
                      //   color: Colors.white,
                      //   width: 2.0,
                      // ),
                    ),
                    child: Center(
                      child: Text(
                        competenceChecks.length.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  const Text(
                    'Ø',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  const Gap(5),
                  if (checksAverageValue != null)
                    Text(
                      checksAverageValue!.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  const Spacer(),
                  InkWell(
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
                      Icons.add_task_rounded,
                      color: isReport
                          ? AppColors.backgroundColor
                          : AppColors.interactiveColor,
                    ),
                  ),
                  const Gap(10),
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
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.interactiveColor,
                        ),
                        child: InkWell(
                          child: getCompetenceReportCheckSymbol(
                            pupil,
                            competence.publicId,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ...competenceChecks,
          ...children,
        ],
      ),
    );
  }
}

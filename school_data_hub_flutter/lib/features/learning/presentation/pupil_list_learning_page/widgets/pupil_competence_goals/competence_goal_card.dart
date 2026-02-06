import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:watch_it/watch_it.dart';

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
                  CompetenceHelper.getCompetenceCheckSymbol(
                    status: pupilGoal.score ?? 0,
                    size: 50,
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
                          for (int i = 0; i < pupilGoal.strategies!.length; i++)
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
            ],
          ),
        ),
      ),
    );
  }
}

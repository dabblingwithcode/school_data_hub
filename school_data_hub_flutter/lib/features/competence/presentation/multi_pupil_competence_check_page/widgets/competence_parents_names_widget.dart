import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/competence/domain/competence_manager.dart';
import 'package:watch_it/watch_it.dart';

List<Widget> competenceTreeAncestorsNames(
    {required int competenceId, required Color categoryColor}) {
  // Create an empty list to store ancestors
  List<Widget> ancestors = [];

  // Use a recursive helper function to collect ancestors
  void collectAncestors(int currentCompetenceId) {
    final Competence currentCompetence =
        di<CompetenceManager>().findCompetenceById(currentCompetenceId);

    // Check if parent category exists before recursion
    if (currentCompetence.parentCompetence != null) {
      collectAncestors(currentCompetence.parentCompetence!);
    }

    if (currentCompetence.publicId ==
        di<CompetenceManager>().findRootCompetenceById(competenceId).publicId) {
      ancestors.add(
        Row(
          children: [
            const Gap(10),
            Flexible(
              child: Text(
                  di<CompetenceManager>()
                      .findRootCompetenceById(competenceId)
                      .name,
                  style: const TextStyle(
                    overflow: TextOverflow.fade,
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const Gap(10),
          ],
        ),
      );
    }
    // Add current category name to the list after recursion
    if (currentCompetence.publicId !=
        di<CompetenceManager>().findRootCompetenceById(competenceId).publicId) {
      if (currentCompetence.publicId != competenceId) {
        ancestors.add(
          Row(
            children: [
              const Gap(10),
              Flexible(
                child: Text(
                  currentCompetence.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const Gap(10),
            ],
          ),
        );
      }
    }
  }

  // Start the recursion from the input category
  collectAncestors(competenceId);

  // Add the current category at the end
  final Competence currentCompetence =
      di<CompetenceManager>().findCompetenceById(competenceId);
  ancestors.add(
    Row(
      children: [
        const Gap(10),
        Flexible(
          child: Text(
            currentCompetence.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
        const Gap(10),
      ],
    ),
  );

  ancestors.add(const Gap(5));
  return ancestors;
}

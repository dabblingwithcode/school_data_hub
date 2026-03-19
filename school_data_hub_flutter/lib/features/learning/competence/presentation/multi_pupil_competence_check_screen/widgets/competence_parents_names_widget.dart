import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_manager.dart';
import 'package:flutter_it/flutter_it.dart';

List<Widget> competenceTreeAncestorsNames({
  required BuildContext context,
  required int competenceId,
  required Color categoryColor,
}) {
  final style = Style.of(context);
  // Create an empty list to store ancestors
  List<Widget> ancestors = [];

  // Use a recursive helper function to collect ancestors
  void collectAncestors(int currentCompetenceId) {
    final Competence currentCompetence = di<CompetenceManager>()
        .findCompetenceById(currentCompetenceId);

    // Check if parent category exists before recursion
    if (currentCompetence.parentCompetence != null) {
      collectAncestors(currentCompetence.parentCompetence!);
    }

    if (currentCompetence.publicId ==
        di<CompetenceManager>().findRootCompetenceById(competenceId).publicId) {
      ancestors.add(
        Row(
          children: [
            Gap(Style.spacing.md),
            Flexible(
              child: Text(
                di<CompetenceManager>()
                    .findRootCompetenceById(competenceId)
                    .name,
                style: context.typography.body.bold
                    .withColor(style.colors.background)
                    .copyWith(overflow: TextOverflow.fade),
              ),
            ),
            Gap(Style.spacing.md),
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
              Gap(Style.spacing.md),
              Flexible(
                child: Text(
                  currentCompetence.name,
                  style: context.typography.body.bold.withColor(
                    style.colors.background,
                  ),
                ),
              ),
              Gap(Style.spacing.md),
            ],
          ),
        );
      }
    }
  }

  // Start the recursion from the input category
  collectAncestors(competenceId);

  // Add the current category at the end
  final Competence currentCompetence = di<CompetenceManager>()
      .findCompetenceById(competenceId);
  ancestors.add(
    Row(
      children: [
        Gap(Style.spacing.md),
        Flexible(
          child: Text(
            currentCompetence.name,
            style: context.typography.subtitle.bold.withColor(
              style.colors.background,
            ),
          ),
        ),
        Gap(Style.spacing.md),
      ],
    ),
  );

  ancestors.add(Gap(Style.spacing.xs));
  return ancestors;
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

Widget getCompetenceCheckComment(PupilProxy pupil, int competenceId) {
  if (pupil.competenceChecks!.isNotEmpty) {
    final CompetenceCheck? competenceCheck =
        CompetenceHelper.getLastCompetenceCheckOfCompetence(
          pupil,
          competenceId,
        );
    if (competenceCheck != null) {
      return Builder(
        builder: (context) {
          final style = Style.of(context);
          return Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      competenceCheck.comment ?? 'Kein Kommentar vorhanden',
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      style: context.typography.body.withColor(
                        style.colors.background,
                      ),
                    ),
                  ],
                ),
                Gap(Style.spacing.xs),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'eingetragen von ',
                      style: context.typography.bodySmall.withColor(
                        style.colors.background,
                      ),
                    ),
                    Text(
                      competenceCheck.createdBy,
                      style: context.typography.bodySmall.bold.withColor(
                        style.colors.background,
                      ),
                    ),
                    Gap(Style.spacing.xs),
                    Text(
                      'am',
                      style: context.typography.bodySmall.withColor(
                        style.colors.background,
                      ),
                    ),
                    Gap(Style.spacing.xs),
                    Text(
                      competenceCheck.createdAt.toLocal().formatDateForUser(),
                      style: context.typography.bodySmall.bold.withColor(
                        style.colors.background,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }
    return const SizedBox.shrink();
  }
  return const SizedBox.shrink();
}

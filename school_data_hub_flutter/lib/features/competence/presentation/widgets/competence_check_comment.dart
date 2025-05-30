import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/features/competence/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

Widget getCompetenceCheckComment(PupilProxy pupil, int competenceId) {
  if (pupil.competenceChecks!.isNotEmpty) {
    final CompetenceCheck? competenceCheck =
        CompetenceHelper.getLastCompetenceCheckOfCompetence(
            pupil, competenceId);
    if (competenceCheck != null) {
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const Gap(5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'eingetragen von ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                Text(
                  competenceCheck.createdBy,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                const Gap(5),
                const Text(
                  'am',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                const Gap(5),
                Text(
                  competenceCheck.createdAt.toLocal().formatForUser(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }
  return const SizedBox.shrink();
}

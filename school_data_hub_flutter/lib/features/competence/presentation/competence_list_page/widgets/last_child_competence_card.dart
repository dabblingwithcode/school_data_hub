import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/grades_widget.dart';

class LastChildCompetenceCard extends StatelessWidget {
  final Competence competence;
  final Function({int? competenceId, Competence? competence})
      navigateToNewOrPatchCompetencePage;
  const LastChildCompetenceCard(
      {required this.competence,
      required this.navigateToNewOrPatchCompetencePage,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: InkWell(
                    onTap: () => navigateToNewOrPatchCompetencePage(
                        competence: competence),
                    onLongPress: () => navigateToNewOrPatchCompetencePage(
                        competenceId: competence.publicId),
                    child: Text(
                      competence.name,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(10),
            if (competence.indicators != null &&
                competence.indicators!.isNotEmpty) ...[
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Indikatoren:',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
              const Gap(5),
              Text(
                competence.indicators!.join(),
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ],
            competence.level != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: GradesWidget(
                                stringWithGrades: competence.level!.join())),
                        const Gap(10),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

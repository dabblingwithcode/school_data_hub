import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/grades_widget.dart';

class LastChildCompetenceCardSortable extends StatelessWidget {
  final Competence competence;
  final Function({int? competenceId, Competence? competence})
  navigateToNewOrPatchCompetencePage;
  const LastChildCompetenceCardSortable({
    required this.competence,
    required this.navigateToNewOrPatchCompetencePage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: InkWell(
                    onTap: () => navigateToNewOrPatchCompetencePage(
                      competence: competence,
                    ),
                    onLongPress: () => navigateToNewOrPatchCompetencePage(
                      competenceId: competence.publicId,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              competence.name,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        if (competence.level != null) ...[
                          const Gap(5),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 5.0,
                              bottom: 8,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GradesWidget(
                                  stringWithGrades: competence.level!.join(
                                    ', ',
                                  ),
                                ),
                                const Gap(10),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}

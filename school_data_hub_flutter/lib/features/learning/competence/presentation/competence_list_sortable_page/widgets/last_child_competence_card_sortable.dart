import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/widgets/competence_grades_widget.dart';

class LastChildCompetenceCardSortable extends StatelessWidget {
  final Competence competence;
  final int index;
  final Function({int? competenceId, Competence? competence})
      navigateToNewOrPatchCompetencePage;

  const LastChildCompetenceCardSortable({
    required this.competence,
    required this.index,
    required this.navigateToNewOrPatchCompetencePage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 2.0, bottom: 2.0),
        child: Row(
          children: [
            Expanded(
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
                    Text(
                      competence.name,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (competence.level != null) ...[
                      const Gap(5),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5.0,
                          bottom: 8,
                        ),
                        child: GradesWidget(
                          stringWithGrades: competence.level!.join(', '),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            ReorderableDragStartListener(
              index: index,
              child: const Icon(Icons.drag_handle, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

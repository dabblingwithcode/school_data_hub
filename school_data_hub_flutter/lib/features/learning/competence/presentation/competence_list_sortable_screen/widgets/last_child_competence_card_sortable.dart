import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/widgets/competence_grades_widget.dart';

class LastChildCompetenceCardSortable extends StatelessWidget {
  final Competence competence;
  final int index;
  final void Function({int? competenceId, Competence? competence})
  navigateToNewOrPatchCompetencePage;

  const LastChildCompetenceCardSortable({
    required this.competence,
    required this.index,
    required this.navigateToNewOrPatchCompetencePage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return CardBox(
      padding: EdgeInsets.only(left: Style.spacing.sm, top: 2.0, bottom: 2.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () =>
                  navigateToNewOrPatchCompetencePage(competence: competence),
              onLongPress: () => navigateToNewOrPatchCompetencePage(
                competenceId: competence.publicId,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    competence.name,
                    textAlign: TextAlign.start,
                    style: context.typography.body.bold.withColor(
                      style.colors.foreground,
                    ),
                  ),
                  if (competence.level != null) ...[
                    Gap(Style.spacing.xs),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Style.spacing.xs,
                        bottom: Style.spacing.sm,
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
            child: Icon(Icons.drag_handle, color: style.colors.mutedForeground),
          ),
        ],
      ),
    );
  }
}

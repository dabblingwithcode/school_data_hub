import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/widgets/competence_grades_widget.dart';

class LastChildCompetenceCard extends StatelessWidget {
  final Competence competence;
  final void Function({int? competenceId, Competence? competence})
  navigateToNewOrPatchCompetencePage;
  const LastChildCompetenceCard({
    required this.competence,
    required this.navigateToNewOrPatchCompetencePage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Style.spacing.xs),
      child: CardBox(
        padding: EdgeInsets.all(Style.spacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () => navigateToNewOrPatchCompetencePage(
                      competence: competence,
                    ),
                    onLongPress: () => navigateToNewOrPatchCompetencePage(
                      competenceId: competence.publicId,
                    ),
                    child: Text(
                      competence.name,
                      textAlign: TextAlign.start,
                      style: context.typography.subtitle.bold.withColor(
                        style.colors.foreground,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gap(Style.spacing.sm),
            if (competence.indicators != null &&
                competence.indicators!.isNotEmpty) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Indikatoren:',
                    style: context.typography.body.bold.copyWith(
                      fontStyle: FontStyle.italic,
                      color: style.colors.foreground,
                    ),
                  ),
                ],
              ),
              Gap(Style.spacing.xs),
              Text(
                competence.indicators!.join(),
                textAlign: TextAlign.start,
                style: context.typography.body.withColor(
                  style.colors.foreground,
                ),
              ),
            ],
            competence.level != null
                ? Padding(
                    padding: EdgeInsets.only(
                      top: Style.spacing.sm,
                      bottom: Style.spacing.sm,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: GradesWidget(
                            stringWithGrades: competence.level!.join(),
                          ),
                        ),
                        Gap(Style.spacing.sm),
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

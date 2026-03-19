import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/widgets/competence_grades_widget.dart';

class LastChildReportItemCard extends StatelessWidget {
  final CompetenceReportItem item;
  final void Function({int? parentItemId, CompetenceReportItem? item})
  navigateToPostOrPatch;

  const LastChildReportItemCard({
    required this.item,
    required this.navigateToPostOrPatch,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);

    return CardBox(
      padding: EdgeInsets.all(Style.spacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: GestureDetector(
                  onTap: () => navigateToPostOrPatch(item: item),
                  onLongPress: () =>
                      navigateToPostOrPatch(parentItemId: item.publicId),
                  child: Text(
                    item.name,
                    textAlign: TextAlign.start,
                    style: context.typography.subtitle.bold.withColor(
                      style.colors.foreground,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (item.level != null && item.level!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(
                top: Style.spacing.md,
                bottom: Style.spacing.sm,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: GradesWidget(
                      stringWithGrades: item.level!.join(","),
                    ),
                  ),
                  Gap(Style.spacing.md),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

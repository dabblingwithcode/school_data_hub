import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/widgets/competence_grades_widget.dart';

class ReportItemLeafCardSortable extends StatelessWidget {
  final CompetenceReportItem item;
  final int index;
  final void Function({int? parentItemId, CompetenceReportItem? item})
  navigateToPostOrPatch;

  const ReportItemLeafCardSortable({
    required this.item,
    required this.index,
    required this.navigateToPostOrPatch,
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
              onTap: () => navigateToPostOrPatch(item: item),
              onLongPress: () =>
                  navigateToPostOrPatch(parentItemId: item.publicId),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    textAlign: TextAlign.start,
                    style: context.typography.body.bold.withColor(style.colors.foreground),
                  ),
                  if (item.level != null && item.level!.isNotEmpty) ...[
                    Gap(Style.spacing.xs),
                    Padding(
                      padding: EdgeInsets.only(left: Style.spacing.xs, bottom: Style.spacing.sm),
                      child: GradesWidget(
                        stringWithGrades: item.level!.join(', '),
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

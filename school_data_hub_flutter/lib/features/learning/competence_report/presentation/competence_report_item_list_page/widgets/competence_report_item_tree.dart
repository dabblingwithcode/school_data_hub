import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/competence_report_item_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/competence_report_item_list_page/widgets/common_report_item_card.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/competence_report_item_list_page/widgets/last_child_report_item_card.dart';

class ReportItemTree extends StatelessWidget {
  final List<CompetenceReportItem> items;
  final int? parentId;
  final void Function({int? parentItemId, CompetenceReportItem? item})
  navigateToPostOrPatch;

  const ReportItemTree({
    required this.items,
    required this.parentId,
    required this.navigateToPostOrPatch,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final children = items.where((i) => i.parentItem == parentId).toList()
      ..sort((a, b) {
        if (a.order != null && b.order != null) {
          return a.order!.compareTo(b.order!);
        }
        if (a.order != null) return -1;
        if (b.order != null) return 1;
        return a.publicId.compareTo(b.publicId);
      });

    return Column(
      children: [
        for (final item in children)
          _ReportItemNode(
            item: item,
            allItems: items,
            navigateToPostOrPatch: navigateToPostOrPatch,
          ),
      ],
    );
  }
}

class _ReportItemNode extends StatelessWidget {
  final CompetenceReportItem item;
  final List<CompetenceReportItem> allItems;
  final void Function({int? parentItemId, CompetenceReportItem? item})
  navigateToPostOrPatch;

  const _ReportItemNode({
    required this.item,
    required this.allItems,
    required this.navigateToPostOrPatch,
  });

  @override
  Widget build(BuildContext context) {
    final hasChildren = allItems.any((i) => i.parentItem == item.publicId);

    if (hasChildren) {
      return CommonReportItemCard(
        item: item,
        navigateToPostOrPatch: navigateToPostOrPatch,
        children: [
          ReportItemTree(
            items: allItems,
            parentId: item.publicId,
            navigateToPostOrPatch: navigateToPostOrPatch,
          ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: InkWell(
        onLongPress: () async {
          final confirm = await confirmationDialog(
            context: context,
            title: 'Zeugniskompetenz löschen',
            message: 'Sind Sie sicher?',
          );
          if (confirm!) {
            di<CompetenceReportItemManager>().deleteItem(item.publicId);
          }
        },
        child: LastChildReportItemCard(
          item: item,
          navigateToPostOrPatch: navigateToPostOrPatch,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_reorderable_list_view.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/competence_report_item_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/competence_report_items_sortable_list_page/widgets/report_item_card_sortable.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/competence_report_items_sortable_list_page/widgets/report_item_leaf_card_sortable.dart';

class ReportItemTreeSortable extends StatefulWidget {
  final List<CompetenceReportItem> items;
  final Function({int? parentItemId, CompetenceReportItem? item})
  navigateToPostOrPatch;

  const ReportItemTreeSortable({
    super.key,
    required this.items,
    required this.navigateToPostOrPatch,
  });

  @override
  State<ReportItemTreeSortable> createState() => _ReportItemTreeSortableState();
}

class _ReportItemTreeSortableState extends State<ReportItemTreeSortable> {
  late List<int> _rootOrder;

  @override
  void initState() {
    super.initState();
    _rootOrder = _buildRootOrder();
  }

  @override
  void didUpdateWidget(ReportItemTreeSortable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items != oldWidget.items) {
      _rootOrder = _buildRootOrder();
    }
  }

  List<int> _buildRootOrder() {
    final roots = widget.items.where((i) => i.parentItem == null).toList()
      ..sort((a, b) {
        if (a.order != null && b.order != null) {
          return a.order!.compareTo(b.order!);
        }
        if (a.order != null) return -1;
        if (b.order != null) return 1;
        return a.publicId.compareTo(b.publicId);
      });
    return roots.map((i) => i.publicId).toList();
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final id = _rootOrder.removeAt(oldIndex);
      _rootOrder.insert(newIndex, id);

      for (int i = 0; i < _rootOrder.length; i++) {
        final item = di<CompetenceReportItemManager>().findItemById(
          _rootOrder[i],
        );
        if (item.order != i) {
          di<CompetenceReportItemManager>().updateItemOrder(
            publicId: _rootOrder[i],
            order: i,
          );
        }
      }
    });
  }

  Widget _buildRootItem(int index, int publicId) {
    final item = widget.items.firstWhere((i) => i.publicId == publicId);
    final hasChildren = widget.items.any((i) => i.parentItem == publicId);

    if (hasChildren) {
      return ReportItemCardSortable(
        key: ValueKey(publicId),
        index: index,
        item: item,
        allItems: widget.items,
        navigateToPostOrPatch: widget.navigateToPostOrPatch,
      );
    } else {
      return Padding(
        key: ValueKey(publicId),
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: ReportItemLeafCardSortable(
          index: index,
          item: item,
          navigateToPostOrPatch: widget.navigateToPostOrPatch,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GenericReorderableListView(
      onReorder: _onReorder,
      children: [
        for (int i = 0; i < _rootOrder.length; i++)
          _buildRootItem(i, _rootOrder[i]),
      ],
    );
  }
}

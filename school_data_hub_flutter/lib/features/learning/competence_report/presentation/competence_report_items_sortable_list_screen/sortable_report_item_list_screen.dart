import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/competence_report_item_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/competence_report_items_sortable_list_screen/widgets/report_item_tree_sortable.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/post_or_patch_report_item_screen/post_or_patch_report_item_screen.dart';

class SortableReportItemListScreen extends WatchingWidget {
  const SortableReportItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToPostOrPatch({
      int? parentItemId,
      CompetenceReportItem? item,
    }) {
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
          builder: (ctx) =>
              PostOrPatchReportItemScreen(parentItem: parentItemId, item: item),
        ),
      );
    }

    final List<CompetenceReportItem> items = watchValue(
      (CompetenceReportItemManager m) => m.items,
    );

    onDispose(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        di<CompetenceReportItemManager>().sortAndNotifyItems();
      });
    });

    return Scaffold(
      backgroundColor: Style.of(context).colors.canvas,
      appBar: const AppHeader(
        iconData: Icons.assignment,
        title: 'Zeugniskompetenzreihenfolge ändern',
      ),
      body: RefreshIndicator(
        onRefresh: () async => di<CompetenceReportItemManager>().fetchItems(),
        child: Padding(
          padding: EdgeInsets.only(
            top: Style.spacing.sm,
            left: Style.spacing.md,
            right: Style.spacing.md,
            bottom: Style.spacing.md,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ReportItemTreeSortable(
                  items: items,
                  navigateToPostOrPatch: navigateToPostOrPatch,
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const ActionBar(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/bottom_nav_bar/generic_bottom_nav_bar_no_filter.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/competence_report_item_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/competence_report_items_sortable_list_page/widgets/report_item_tree_sortable.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/post_or_patch_report_item_page/post_or_patch_report_item_page.dart';

class SortableReportItemListPage extends WatchingWidget {
  const SortableReportItemListPage({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToPostOrPatch({
      int? parentItemId,
      CompetenceReportItem? item,
    }) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => PostOrPatchReportItemPage(
            parentItem: parentItemId,
            item: item,
          ),
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
      appBar: const GenericAppBar(
        iconData: Icons.assignment,
        title: 'Zeugniskompetenzreihenfolge ändern',
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            di<CompetenceReportItemManager>().fetchItems(),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            left: 10,
            right: 10,
            bottom: 10,
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
      bottomNavigationBar: const GenericBottomNavBarNoFilter(),
    );
  }
}

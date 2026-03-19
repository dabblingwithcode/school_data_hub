import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/competence_report_item_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/competence_report_item_list_screen/widgets/competence_report_item_tree.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/post_or_patch_report_item_screen/post_or_patch_report_item_screen.dart';

class CompetenceReportItemListScreen extends WatchingWidget {
  const CompetenceReportItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = di<CompetenceReportItemManager>();
    final items = watchValue((CompetenceReportItemManager x) => x.items);

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

    return Scaffold(
      backgroundColor: Style.of(context).colors.canvas,
      appBar: const AppHeader(
        iconData: Icons.assignment,
        title: 'Zeugniskompetenzen',
      ),
      body: RefreshIndicator(
        onRefresh: () async => manager.fetchItems(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                child: ReportItemTree(
                  items: items,
                  parentId: null,
                  navigateToPostOrPatch: navigateToPostOrPatch,
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: ActionBar(
        actions: [
          TappableIcon(
            tooltip: 'Bearbeiten',
            icon: const Icon(Icons.edit, size: 30),
            onPressed: () {
              context.push(RoutePaths.learningCompetenceReportSortable);
            },
          ),
        ],
      ),
    );
  }
}

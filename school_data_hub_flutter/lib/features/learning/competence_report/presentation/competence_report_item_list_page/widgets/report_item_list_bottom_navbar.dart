import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/competence_report_item_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/competence_report_items_sortable_list_page/sortable_report_item_list_page.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/post_or_patch_report_item_page/post_or_patch_report_item_page.dart';

class ReportItemListBottomNavBar extends StatelessWidget {
  const ReportItemListBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        height: 60,
        padding: const EdgeInsets.all(10),
        shape: null,
        color: AppColors.backgroundColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: [
              const Spacer(),
              IconButton(
                tooltip: 'zurück',
                icon: const Icon(Icons.arrow_back, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Gap(30),
              IconButton(
                tooltip: 'Neue Zeugniskompetenz',
                icon: const Icon(Icons.add, size: 30),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const PostOrPatchReportItemPage(),
                    ),
                  );
                },
              ),
              const Gap(30),
              IconButton(
                tooltip: 'Reihenfolge ändern',
                icon: const Icon(Icons.sort_rounded),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) =>
                          const SortableReportItemListPage(),
                    ),
                  );
                },
              ),
              const Gap(30),
              IconButton(
                tooltip: 'aktualisieren',
                icon: const Icon(Icons.update_rounded),
                onPressed: () {
                  di<CompetenceReportItemManager>().fetchItems();
                },
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}

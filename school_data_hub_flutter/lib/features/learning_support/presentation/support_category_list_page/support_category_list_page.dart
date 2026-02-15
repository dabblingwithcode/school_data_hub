import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_page/controller/category_list_controller.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_page/widgets/support_category_tree.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_support_category_page/new_support_category_page.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_sortable_page/sortable_support_category_list_page.dart';

class CategoryListPage extends WatchingWidget {
  final CategoryListController controller;
  const CategoryListPage(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    // Watch supportCategories so the page rebuilds when order/parent changes
    watchValue((SupportCategoryManager m) => m.supportCategories);
    return Scaffold(
      appBar: const GenericAppBar(
        iconData: Icons.category,
        title: 'Förderkategorien',
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
              child: const SupportCategoryTree(
                parentId: null,
                indentation: 0,
                backGroundColor: null,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarLayout(
        bottomNavBar: BottomAppBar(
          height: 60,
          padding: const EdgeInsets.all(10),
          shape: null,
          color: AppColors.backgroundColor,
          child: IconTheme(
            data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
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
                    tooltip: 'Neue Kategorie',
                    icon: const Icon(Icons.add, size: 30),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) =>
                              const NewSupportCategoryPage(),
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
                              const SortableSupportCategoryListPage(),
                        ),
                      );
                    },
                  ),
                  const Gap(15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/post_or_patch_support_category_page/post_or_patch_support_category_page.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_page/widgets/support_category_tree.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_sortable_page/sortable_support_category_list_page.dart';

class CategoryListScreen extends WatchingWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch supportCategories so the page rebuilds when order/parent changes
    watchValue((SupportCategoryManager m) => m.supportCategories);
    return Scaffold(
      appBar: const AppHeader(
        iconData: Icons.category,
        title: 'Förderkategorien',
      ),
      body: SingleChildScrollView(
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
              child: const SupportCategoryTree(
                parentId: null,
                indentation: 0,
                backGroundColor: null,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: ActionBar(
        actions: [
          TappableIcon(
            icon: const Icon(Icons.add, size: 30),
            tooltip: 'Neue Kategorie',
            onPressed: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute<void>(
                  builder: (ctx) => const PostOrPatchSupportCategoryScreen(
                    category: null,
                    parentCategoryId: null,
                  ),
                ),
              );
            },
          ),
          TappableIcon(
            icon: const Icon(Icons.edit_rounded, size: 30),
            tooltip: 'Reihenfolge ändern',
            onPressed: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute<void>(
                  builder: (ctx) => const SortableSupportCategoryListScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

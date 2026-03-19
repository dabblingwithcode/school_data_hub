import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/post_or_patch_support_category_page/post_or_patch_support_category_page.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_sortable_page/select_parent_category_page.dart';

class SupportCategoryLeafCardSortable extends StatelessWidget {
  final SupportCategory category;
  final int index;

  const SupportCategoryLeafCardSortable({
    required this.category,
    required this.index,
    super.key,
  });

  Future<void> _navigateToSelectParent(BuildContext context) async {
    final result = await Navigator.of(context).push<int>(
      MaterialPageRoute<int>(
        builder: (ctx) =>
            SelectParentCategoryScreen(movingCategoryId: category.categoryId),
      ),
    );
    if (result != null && context.mounted) {
      final newParent = result == SelectParentCategoryScreen.rootSentinel
          ? null
          : result;
      await di<SupportCategoryManager>().updateSupportCategoryParent(
        categoryId: category.categoryId,
        parentCategory: newParent,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return CardBox(
      padding: EdgeInsets.only(left: Style.spacing.sm, top: Style.spacing.xs, bottom: Style.spacing.xs),
      child: Row(
        children: [
          Gap(Style.spacing.xs),
          Expanded(
            child: GestureDetector(
              onLongPress: () => _navigateToSelectParent(context),
              child: Text(
                category.name,
                textAlign: TextAlign.start,
                style: context.typography.body.bold.withColor(style.colors.foreground),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, color: style.colors.mutedForeground, size: 22),
            onPressed: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute<void>(
                  builder: (ctx) => PostOrPatchSupportCategoryScreen(
                    category: category,
                  ),
                ),
              );
            },
            tooltip: 'Kategorie bearbeiten',
          ),
          Checkbox(
            value: category.printable ?? false,
            onChanged: (value) {
              di<SupportCategoryManager>().updateSupportCategoryPrintable(
                categoryId: category.categoryId,
                printable: value ?? false,
              );
            },
          ),
          ReorderableDragStartListener(
            index: index,
            child: Icon(Icons.drag_handle, color: style.colors.mutedForeground),
          ),
          Gap(Style.spacing.md),
        ],
      ),
    );
  }
}

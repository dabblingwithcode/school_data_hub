import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
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
      MaterialPageRoute(
        builder: (ctx) => SelectParentCategoryPage(
          movingCategoryId: category.categoryId,
        ),
      ),
    );
    if (result != null && context.mounted) {
      final newParent = result == SelectParentCategoryPage.rootSentinel
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
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 2.0, bottom: 2.0),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onLongPress: () => _navigateToSelectParent(context),
                child: Text(
                  category.name,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
              child: const Icon(Icons.drag_handle, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

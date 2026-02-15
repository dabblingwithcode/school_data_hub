import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_sortable_page/widgets/selectable_parent_category_tree.dart';

/// A page for selecting a new parent category when reparenting a category.
///
/// Displays the full category tree with radio buttons. The category being
/// moved and its descendants are excluded to prevent circular references.
/// A "root" option is provided at the top to make the category a top-level
/// category.
///
/// Returns the selected parent category ID (or a sentinel value for root)
/// via [Navigator.pop].
class SelectParentCategoryPage extends WatchingWidget {
  /// The categoryId of the category being moved.
  final int movingCategoryId;

  /// Sentinel value returned when "root" (no parent) is selected.
  static const int rootSentinel = -1;

  const SelectParentCategoryPage({required this.movingCategoryId, super.key});

  @override
  Widget build(BuildContext context) {
    final selectedParentId = createOnce(() => ValueNotifier<int?>(null));
    final selectedValue = watch(selectedParentId);

    final excludedIds = di<SupportCategoryManager>().getDescendantCategoryIds(
      movingCategoryId,
    );

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: const Text(
          'Übergeordnete Kategorie wählen',
          style: AppStyles.appBarTextStyle,
        ),
      ),
      body: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Neue übergeordnete Kategorie auswählen:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Root option
                  Card(
                    color: AppColors.backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ValueListenableBuilder<int?>(
                            valueListenable: selectedParentId,
                            builder: (context, selected, _) {
                              return Radio<int?>(
                                value: rootSentinel,
                                groupValue: selected,
                                onChanged: (value) {
                                  selectedParentId.value = value;
                                },
                                fillColor: WidgetStateProperty.all(
                                  Colors.white,
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                selectedParentId.value = rootSentinel;
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Keine (Hauptkategorie)',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Category tree
                  SelectableParentCategoryTree(
                    excludedCategoryIds: excludedIds,
                    selectedParentId: selectedParentId,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: selectedValue != null
          ? FloatingActionButton(
              backgroundColor: AppColors.backgroundColor,
              child: const Icon(Icons.check, color: Colors.white, size: 35),
              onPressed: () {
                Navigator.of(context).pop(selectedParentId.value);
              },
            )
          : const SizedBox.shrink(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
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
class SelectParentCategoryScreen extends WatchingWidget {
  /// The categoryId of the category being moved.
  final int movingCategoryId;

  /// Sentinel value returned when "root" (no parent) is selected.
  static const int rootSentinel = -1;

  const SelectParentCategoryScreen({required this.movingCategoryId, super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final selectedParentId = createOnce(() => ValueNotifier<int?>(null));

    final excludedIds = di<SupportCategoryManager>().getDescendantCategoryIds(
      movingCategoryId,
    );

    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: AppBar(
        foregroundColor: style.colors.background,
        centerTitle: true,
        backgroundColor: style.colors.accent,
        title: Text(
          'Übergeordnete Kategorie wählen',
          style: context.typography.title.withColor(style.colors.background),
        ),
      ),
      body: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Style.spacing.sm),
              child: ValueListenableBuilder<int?>(
                valueListenable: selectedParentId,
                builder: (context, selected, _) {
                  return RadioGroup<int?>(
                    groupValue: selected,
                    onChanged: (value) {
                      selectedParentId.value = value;
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(Style.spacing.sm),
                          child: Text(
                            'Neue übergeordnete Kategorie auswählen:',
                            style: context.typography.title,
                          ),
                        ),
                        // Root option
                        Container(
                          decoration: BoxDecoration(
                            color: style.colors.accent,
                            borderRadius: BorderRadius.circular(Style.radii.medium),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(Style.spacing.sm),
                            child: Row(
                              children: [
                                Radio<int?>(
                                  value: rootSentinel,
                                  fillColor: WidgetStateProperty.all(
                                    style.colors.background,
                                  ),
                                ),
                                SizedBox(width: Style.spacing.xs),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      selectedParentId.value = rootSentinel;
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: Style.spacing.sm),
                                      child: Text(
                                        'Keine (Hauptkategorie)',
                                        style: context.typography.subtitle.bold.withColor(style.colors.background),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Style.spacing.xs),
                        // Category tree
                        SelectableParentCategoryTree(
                          excludedCategoryIds: excludedIds,
                          selectedParentId: selectedParentId,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: style.colors.accent,
        child: Icon(Icons.check, color: style.colors.background, size: 35),
        onPressed: () {
          Navigator.of(context).pop(selectedParentId.value);
        },
      ),
    );
  }
}

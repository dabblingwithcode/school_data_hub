import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:flutter_it/flutter_it.dart';

class ScopeNamesSelector extends WatchingWidget {
  final ValueNotifier<List<String>> scopeNames;

  const ScopeNamesSelector({super.key, required this.scopeNames});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final watchedScopeNames = watch(scopeNames).value;
    final TextEditingController newScopeNameController = createOnce(
      () => TextEditingController(),
    );

    void addScopeName() {
      final newScopeName =
          'SchooldayEventsManagement.${newScopeNameController.text.trim()}';
      if (newScopeName.isNotEmpty &&
          !watchedScopeNames.contains(newScopeName)) {
        scopeNames.value = [...watchedScopeNames, newScopeName];
        newScopeNameController.clear();
      }
    }

    void removeScopeName(String scopeName) {
      scopeNames.value = watchedScopeNames
          .where((element) => element != scopeName)
          .toList();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Scope Names:',
          style: context.typography.subtitle.bold,
        ),
        const Gap(5),
        Row(
          children: [
            Expanded(
              child: TextField(
                minLines: 1,
                maxLines: 1,
                controller: newScopeNameController,
                decoration: AppStyles.textFieldDecoration(
                  labelText: 'Neue Scope Name hinzufügen',
                ),
                onSubmitted: (_) => addScopeName(),
              ),
            ),
            const Gap(10),
            Button.small(
              onPressed: addScopeName,
              label: 'HINZUFÜGEN',
            ),
          ],
        ),
        if (watchedScopeNames.isNotEmpty) ...[
          const Gap(10),
          Container(
            constraints: const BoxConstraints(maxHeight: 200),
            decoration: BoxDecoration(
              border: Border.all(color: style.colors.border, width: 1),
              borderRadius: BorderRadius.circular(Style.radii.small),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(Style.spacing.sm),
              itemCount: watchedScopeNames.length,
              itemBuilder: (context, index) {
                final scopeName = watchedScopeNames[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: Style.spacing.xs),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Style.spacing.md,
                            vertical: Style.spacing.sm,
                          ),
                          decoration: BoxDecoration(
                            color: style.colors.surfaceContainer,
                            borderRadius:
                                BorderRadius.circular(Style.radii.small),
                          ),
                          child: Text(
                            scopeName,
                            style: context.typography.body.w500,
                          ),
                        ),
                      ),
                      const Gap(8),
                      TappableIcon(
                        icon: Icon(
                          Icons.close,
                          size: 18,
                          color: style.colors.error,
                        ),
                        onPressed: () => removeScopeName(scopeName),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}

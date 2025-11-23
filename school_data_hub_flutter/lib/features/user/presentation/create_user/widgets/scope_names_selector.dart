import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:watch_it/watch_it.dart';

class ScopeNamesSelector extends WatchingWidget {
  final ValueNotifier<List<String>> scopeNames;

  const ScopeNamesSelector({super.key, required this.scopeNames});

  @override
  Widget build(BuildContext context) {
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
        const Text(
          'Scope Names:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
            ElevatedButton(
              style: AppStyles.actionButtonStyle.copyWith(
                minimumSize: WidgetStateProperty.all(const Size(0, 50)),
              ),
              onPressed: addScopeName,
              child: const Text('HINZUFÜGEN', style: AppStyles.buttonTextStyle),
            ),
          ],
        ),
        if (watchedScopeNames.isNotEmpty) ...[
          const Gap(10),
          Container(
            constraints: const BoxConstraints(maxHeight: 200),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: watchedScopeNames.length,
              itemBuilder: (context, index) {
                final scopeName = watchedScopeNames[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            scopeName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const Gap(8),
                      InkWell(
                        onTap: () => removeScopeName(scopeName),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 18,
                            color: Colors.red,
                          ),
                        ),
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

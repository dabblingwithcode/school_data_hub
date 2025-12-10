import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:watch_it/watch_it.dart';

class SelectBookTagsPage extends WatchingWidget {
  final List<BookTag> initialSelectedTags;

  const SelectBookTagsPage({super.key, this.initialSelectedTags = const []});

  @override
  Widget build(BuildContext context) {
    final selectedTags = createOnce<ValueNotifier<List<BookTag>>>(
      () => ValueNotifier<List<BookTag>>(List.from(initialSelectedTags)),
    );
    final bookTags = watchValue((BookManager bm) => bm.bookTags);
    watch(selectedTags).value;
    final currentSelectedTags = selectedTags.value;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text('Schlagwörter auswählen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(selectedTags.value);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(selectedTags.value);
            },
            child: Text(
              'Fertig',
              style: TextStyle(
                color: AppColors.interactiveColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verfügbare Schlagwörter',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Gap(16),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (bookTags.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.label_outline,
                            size: 64,
                            color: Colors.grey,
                          ),
                          Gap(16),
                          Text(
                            'Keine Schlagwörter verfügbar',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }

                  // Sort tags alphabetically
                  final sortedTags = List<BookTag>.from(bookTags)
                    ..sort((a, b) => a.name.compareTo(b.name));

                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        sortedTags.map((tag) {
                          final isSelected = currentSelectedTags.any(
                            (selectedTag) => selectedTag.id == tag.id,
                          );

                          return FilterChip(
                            label: Text(
                              tag.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            selected: isSelected,
                            onSelected: (bool selected) {
                              if (selected) {
                                selectedTags.value = [
                                  ...currentSelectedTags,
                                  tag,
                                ];
                              } else {
                                selectedTags.value =
                                    currentSelectedTags
                                        .where(
                                          (selectedTag) =>
                                              selectedTag.id != tag.id,
                                        )
                                        .toList();
                              }
                            },
                            selectedColor: AppColors.interactiveColor
                                .withValues(alpha: 0.2),
                            checkmarkColor: AppColors.interactiveColor,
                                avatar:
                                isSelected
                                    ? Icon(
                                      Icons.check,
                                      color: AppColors.successButtonColor,
                                      size: 18,
                                    )
                                    : const SizedBox.shrink(),
                          );
                        }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pop(selectedTags.value);
        },
        backgroundColor: AppColors.interactiveColor,
        icon: const Icon(Icons.check, color: Colors.white),
        label: const Text(
          'Fertig',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

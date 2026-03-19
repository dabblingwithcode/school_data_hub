import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';

class SelectBookTagsScreen extends WatchingWidget {
  final List<BookTag> initialSelectedTags;

  const SelectBookTagsScreen({super.key, this.initialSelectedTags = const []});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final selectedTags = createOnce<ValueNotifier<List<BookTag>>>(
      () => ValueNotifier<List<BookTag>>(List.from(initialSelectedTags)),
    );
    final bookTags = watchValue((BookManager bm) => bm.bookTags);
    watch(selectedTags).value;
    final currentSelectedTags = selectedTags.value;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: style.colors.accent,
        title: const Text('Schlagwörter auswählen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(selectedTags.value);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Button.small(
              label: 'Fertig',
              variant: ButtonVariant.ghost,
              onPressed: () {
                Navigator.of(context).pop(selectedTags.value);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(Style.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verfügbare Schlagwörter',
              style: context.typography.subtitle,
            ),
            const Gap(16),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (bookTags.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.label_outline,
                            size: 64,
                            color: style.colors.mutedForeground,
                          ),
                          const Gap(16),
                          Text(
                            'Keine Schlagwörter verfügbar',
                            style: context.typography.body.muted(context),
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
                    children: sortedTags.map((tag) {
                      final isSelected = currentSelectedTags.any(
                        (selectedTag) => selectedTag.id == tag.id,
                      );

                      return ThemedFilterChip(
                        label: tag.name,
                        selected: isSelected,
                        onSelected: (bool selected) {
                          if (selected) {
                            selectedTags.value = [...currentSelectedTags, tag];
                          } else {
                            selectedTags.value = currentSelectedTags
                                .where(
                                  (selectedTag) => selectedTag.id != tag.id,
                                )
                                .toList();
                          }
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Button.small(
        onPressed: () {
          Navigator.of(context).pop(selectedTags.value);
        },
        label: 'Fertig',
        icon: const Icon(Icons.check),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';

class BookTagSelectionPage extends StatefulWidget {
  final List<BookTag> allTags;
  final Set<int> selectedTagIds;

  const BookTagSelectionPage({
    super.key,
    required this.allTags,
    required this.selectedTagIds,
  });

  @override
  State<BookTagSelectionPage> createState() => _BookTagSelectionPageState();
}

class _BookTagSelectionPageState extends State<BookTagSelectionPage> {
  late List<BookTag> allTags;
  late Set<int> selectedTagIds;

  @override
  void initState() {
    super.initState();
    allTags = List.of(widget.allTags);
    selectedTagIds = Set.of(widget.selectedTagIds);
  }

  Future<void> _createNewTag() async {
    final String? newTagName = await shortTextfieldDialog(
      context: context,
      title: 'Neues Schlagwort erstellen',
      labelText: 'Schlagwort',
      hintText: 'Schlagwort eingeben',
    );

    if (newTagName != null && newTagName.trim().isNotEmpty) {
      await di<BookManager>().postBookTag(newTagName.trim());
      final refreshedTags = di<BookManager>().bookTags.value;
      setState(() {
        allTags = refreshedTags;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedCount = selectedTagIds.length;

    return Scaffold(
      appBar: const GenericAppBar(
        iconData: Icons.bookmark,
        title: 'Schlagwörter zuweisen',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verfügbare Schlagwörter ($selectedCount ausgewählt)',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Gap(16),
            Expanded(
              child: allTags.isEmpty
                  ? const Center(
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
                            'Keine Schlagwörter vorhanden',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: allTags.map((tag) {
                          final isSelected = selectedTagIds.contains(tag.id);
                          return ThemedFilterChip(
                            label: tag.name,
                            selected: isSelected,
                            onSelected: (bool selected) {
                              setState(() {
                                if (selected) {
                                  selectedTagIds.add(tag.id!);
                                } else {
                                  selectedTagIds.remove(tag.id);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarLayout(
        bottomNavBar: BottomAppBar(
          height: 60,
          padding: const EdgeInsets.all(9),
          shape: null,
          color: AppColors.backgroundColor,
          child: IconTheme(
            data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            child: Row(
              children: [
                const Spacer(),
                IconButton(
                  tooltip: 'Abbrechen',
                  icon: const Icon(Icons.close, size: 35),
                  onPressed: () => Navigator.pop(context),
                ),
                const Gap(15),
                IconButton(
                  tooltip: 'Neues Schlagwort erstellen',
                  icon: const Icon(Icons.add, size: 35),
                  onPressed: _createNewTag,
                ),
                const Gap(15),
                IconButton(
                  tooltip: 'Übernehmen',
                  icon: const Icon(Icons.check, size: 35),
                  onPressed: () => Navigator.pop(context, selectedTagIds),
                ),
                const Gap(15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_tag_management_page/book_tag_management_page.dart';
import 'package:watch_it/watch_it.dart';

class BookTagManagement extends WatchingStatefulWidget {
  const BookTagManagement({super.key});

  @override
  BookTagManagementController createState() => BookTagManagementController();
}

class BookTagManagementController extends State<BookTagManagement> {
  final BookManager _bookManager = di<BookManager>();
  final NotificationService _notificationService = di<NotificationService>();

  @override
  void initState() {
    super.initState();
    _loadBookTags();
  }

  Future<void> _loadBookTags() async {
    await _bookManager.fetchBookTags();
  }

  Future<void> createNewTag(BuildContext context) async {
    final String? newTagName = await shortTextfieldDialog(
      context: context,
      title: 'Neues Buch-Tag erstellen',
      labelText: 'Tag-Name',
      hintText: 'Name des neuen Tags eingeben',
    );

    if (newTagName != null && newTagName.trim().isNotEmpty) {
      await _bookManager.postBookTag(newTagName.trim());
      _notificationService.showSnackBar(
        NotificationType.success,
        'Tag "$newTagName" wurde erfolgreich erstellt',
      );
    }
  }

  Future<void> editTag(BuildContext context, BookTag tag) async {
    final String? editedTagName = await shortTextfieldDialog(
      context: context,
      title: 'Buch-Tag bearbeiten',
      labelText: 'Tag-Name',
      hintText: 'Neuen Namen eingeben',
      textinField: tag.name,
    );

    if (editedTagName != null && editedTagName.trim().isNotEmpty) {
      final updatedTag = tag.copyWith(name: editedTagName.trim());
      await _bookManager.updateBookTag(updatedTag);
      _notificationService.showSnackBar(
        NotificationType.success,
        'Tag wurde erfolgreich aktualisiert',
      );
    }
  }

  Future<void> deleteTag(BuildContext context, BookTag tag) async {
    final bool? shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tag löschen'),
          content: Text(
            'Möchten Sie das Tag "${tag.name}" wirklich löschen?\n\n'
            'Diese Aktion kann nicht rückgängig gemacht werden.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Abbrechen'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Löschen'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      await _bookManager.deleteBookTag(tag);
      _notificationService.showSnackBar(
        NotificationType.success,
        'Tag "${tag.name}" wurde gelöscht',
      );
    }
  }

  Widget watchBookTags(BuildContext context) {
    return ValueListenableBuilder<List<BookTag>>(
      valueListenable: _bookManager.bookTags,
      builder: (context, bookTags, child) {
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
                SizedBox(height: 16),
                Text(
                  'Keine Buch-Tags vorhanden',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Tippen Sie auf das + Symbol, um ein neues Tag zu erstellen',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: bookTags.length,
          itemBuilder: (context, index) {
            final tag = bookTags[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8.0),
              child: ListTile(
                leading: const Icon(
                  Icons.label,
                  color: AppColors.interactiveColor,
                ),
                title: Text(
                  tag.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'edit':
                        editTag(context, tag);
                        break;
                      case 'delete':
                        deleteTag(context, tag);
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem<String>(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          SizedBox(width: 8),
                          Text('Bearbeiten'),
                        ],
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text(
                            'Löschen',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BookTagManagementPage(this);
  }
}

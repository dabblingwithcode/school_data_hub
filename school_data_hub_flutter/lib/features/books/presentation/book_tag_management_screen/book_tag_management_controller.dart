import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/confirmation_popup.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tag.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_tag_management_screen/book_tag_management_screen.dart';

class BookTagManagement extends WatchingStatefulWidget {
  const BookTagManagement({super.key});

  @override
  BookTagManagementController createState() => BookTagManagementController();
}

class BookTagManagementController extends State<BookTagManagement> {
  final BookManager _bookManager = di<BookManager>();
  final NotificationManager _notificationService = di<NotificationManager>();

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
      title: 'Neues Schlagwort erstellen',
      labelText: 'Schlagwort',
      hintText: 'Schlagwort eingeben',
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
    ConfirmationPopup.show(
      context: context,
      title: 'Tag löschen',
      description:
          'Möchten Sie das Tag "${tag.name}" wirklich löschen?\n\n'
          'Diese Aktion kann nicht rückgängig gemacht werden.',
      confirmLabel: 'Löschen',
      cancelLabel: 'Abbrechen',
      destructive: true,
      onConfirm: () async {
        await _bookManager.deleteBookTag(tag);
        _notificationService.showSnackBar(
          NotificationType.success,
          'Tag "${tag.name}" wurde gelöscht',
        );
      },
    );
  }

  Widget buildBookTags(BuildContext context, List<BookTag> bookTags) {
    final style = Style.of(context);
    if (bookTags.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.label_outline, size: 64, color: style.colors.mutedForeground),
            const SizedBox(height: 16),
            Text(
              'Keine Buch-Tags vorhanden',
              style: context.typography.body.muted(context),
            ),
            const SizedBox(height: 8),
            Text(
              'Tippen Sie auf das + Symbol, um ein neues Tag zu erstellen',
              style: context.typography.body.muted(context),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: bookTags.map((tag) {
          return _BookTagChip(
            tag: tag,
            onShowOptions: (offset) => _showTagOptions(context, tag, offset),
          );
        }).toList(),
      ),
    );
  }

  Future<void> _showTagOptions(
    BuildContext context,
    BookTag tag,
    Offset globalPosition,
  ) async {
    final style = Style.of(context);
    final position = RelativeRect.fromLTRB(
      globalPosition.dx,
      globalPosition.dy,
      globalPosition.dx,
      globalPosition.dy,
    );

    final result = await showMenu<String>(
      context: context,
      position: position,
      items: [
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
        PopupMenuItem<String>(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete, color: style.colors.error),
              const SizedBox(width: 8),
              Text('Löschen', style: TextStyle(color: style.colors.error)),
            ],
          ),
        ),
      ],
    );

    if (result != null) {
      switch (result) {
        case 'edit':
          if (context.mounted) await editTag(context, tag);
          break;
        case 'delete':
          if (context.mounted) await deleteTag(context, tag);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookTags = watchValue((BookManager x) => x.bookTags);
    return BookTagManagementScreen(this, bookTags: bookTags);
  }
}

class _BookTagChip extends StatelessWidget {
  final BookTag tag;
  final ValueChanged<Offset> onShowOptions;

  const _BookTagChip({required this.tag, required this.onShowOptions});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return GestureDetector(
      onLongPressStart: (details) {
        onShowOptions(details.globalPosition);
      },
      onSecondaryTapUp: (details) {
        onShowOptions(details.globalPosition);
      },
      child: Tag(
        label: tag.name,
        color: style.colors.accent,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class ClassroomListCard extends StatelessWidget {
  final Classroom classroom;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ClassroomListCard({
    super.key,
    required this.classroom,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return CardBox(
      padding: EdgeInsets.all(Style.spacing.sm),
      onTap: onEdit,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text(
            classroom.roomCode.isNotEmpty
                ? classroom.roomCode[0].toUpperCase()
                : '?',
            style: TextStyle(
              color: style.colors.background,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          '${classroom.roomCode} - ${classroom.roomName}',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          'Raumcode: ${classroom.roomCode}',
          style: TextStyle(color: style.colors.mutedForeground),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: style.colors.accent),
              onPressed: onEdit,
              tooltip: 'Bearbeiten',
            ),
            IconButton(
              icon: Icon(Icons.delete, color: style.colors.error),
              onPressed: onDelete,
              tooltip: 'Löschen',
            ),
          ],
        ),
      ),
    );
  }
}

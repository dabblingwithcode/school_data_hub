import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

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
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text(
            classroom.roomCode.isNotEmpty
                ? classroom.roomCode[0].toUpperCase()
                : '?',
            style: const TextStyle(
              color: Colors.white,
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
          style: TextStyle(color: Colors.grey.shade600),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
              tooltip: 'Bearbeiten',
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
              tooltip: 'Löschen',
            ),
          ],
        ),
        onTap: onEdit,
      ),
    );
  }
}

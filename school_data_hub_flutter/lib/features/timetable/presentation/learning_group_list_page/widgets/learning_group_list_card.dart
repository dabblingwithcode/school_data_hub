import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/widgets/timetable_utils.dart';

class LearningGroupListCard extends StatelessWidget {
  final LessonGroup lessonGroup;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const LearningGroupListCard({
    super.key,
    required this.lessonGroup,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              lessonGroup.color != null
                  ? TimetableUtils.parseColor(lessonGroup.color!)
                  : Theme.of(context).colorScheme.primary,
          child: Text(
            lessonGroup.name.isNotEmpty
                ? lessonGroup.name[0].toUpperCase()
                : '?',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          lessonGroup.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          'Farbe: ${lessonGroup.color ?? 'Standard'}',
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

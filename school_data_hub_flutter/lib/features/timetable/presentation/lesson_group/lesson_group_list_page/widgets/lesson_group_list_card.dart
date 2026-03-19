import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_utils.dart';

class LessonGroupListCard extends StatelessWidget {
  final LessonGroup lessonGroup;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const LessonGroupListCard({
    super.key,
    required this.lessonGroup,
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
          backgroundColor: lessonGroup.color != null
              ? TimetableUtils.parseColor(lessonGroup.color!)
              : Theme.of(context).colorScheme.primary,
          child: Text(
            lessonGroup.name.isNotEmpty
                ? lessonGroup.name[0].toUpperCase()
                : '?',
            style: TextStyle(
              color: style.colors.background,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          lessonGroup.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          'Mitglieder: ${lessonGroup.memberships?.length ?? 0}',
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

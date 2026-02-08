import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';

class SchoolSemesterListCard extends StatelessWidget {
  final SchoolSemester semester;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool isCurrentSemester;

  const SchoolSemesterListCard({
    super.key,
    required this.semester,
    required this.onEdit,
    required this.onDelete,
    this.isCurrentSemester = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: isCurrentSemester ? 3 : 1,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isCurrentSemester
              ? Colors.green
              : Theme.of(context).colorScheme.primary,
          child: Text(
            semester.isFirst ? '1' : '2',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        title: Row(
          children: [
            Text(
              semester.schoolYear,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: semester.isFirst
                    ? Colors.blue.shade100
                    : Colors.orange.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                semester.isFirst ? '1. Halbjahr' : '2. Halbjahr',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: semester.isFirst
                      ? Colors.blue.shade900
                      : Colors.orange.shade900,
                ),
              ),
            ),
            if (isCurrentSemester) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Aktuell',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.green.shade900,
                  ),
                ),
              ),
            ],
          ],
        ),
        subtitle: Text(
          '${semester.startDate.formatDateForUser()} - ${semester.endDate.formatDateForUser()}',
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

import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/widgets/timetable_utils.dart';
import 'package:watch_it/watch_it.dart';

/// Dropdown widget for selecting a subject
class SubjectDropdown extends WatchingWidget {
  final Subject? selectedSubject;
  final ValueChanged<Subject?> onSubjectChanged;

  const SubjectDropdown({
    super.key,
    required this.selectedSubject,
    required this.onSubjectChanged,
  });

  @override
  Widget build(BuildContext context) {
    final subjects = watchValue((TimetableManager m) => m.subjects);

    return DropdownButtonFormField<Subject>(
      value: selectedSubject,
      decoration: const InputDecoration(
        labelText: 'Fach *',
        border: OutlineInputBorder(),
      ),
      items:
          subjects.map((subject) {
            return DropdownMenuItem<Subject>(
              value: subject,
              child: Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: TimetableUtils.parseColor(subject.color ?? ''),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(subject.name),
                ],
              ),
            );
          }).toList(),
      onChanged: onSubjectChanged,
      validator: (value) {
        if (value == null) {
          return 'Bitte wählen Sie ein Fach aus';
        }
        return null;
      },
    );
  }
}

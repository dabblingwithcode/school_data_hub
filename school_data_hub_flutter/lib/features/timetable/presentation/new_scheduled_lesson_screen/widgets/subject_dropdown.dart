import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_subject_screen/new_subject_screen.dart';

import 'package:school_data_hub_flutter/features/timetable/domain/timetable_utils.dart';

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
    final style = Style.of(context);
    final subjects = watchValue((TimetableManager m) => m.data.subjects);

    // Map the selected subject (possibly from a different instance) to the
    // concrete instance used in the items list so DropdownButtonFormField
    // sees exactly one matching value.
    final initialValue = selectedSubject == null
        ? null
        : subjects.firstWhere(
            (subject) => subject.id == selectedSubject!.id,
            orElse: () => selectedSubject!,
          );

    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<Subject>(
            initialValue: initialValue,
            decoration: const InputDecoration(
              labelText: 'Fach *',
              border: OutlineInputBorder(),
            ),
            items: subjects.map((subject) {
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
                    SizedBox(width: Style.spacing.sm),
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
          ),
        ),
        SizedBox(width: Style.spacing.md),
        GestureDetector(
          onTap: () async {
            final result = await Navigator.of(context).push<Subject>(
              MaterialPageRoute<Subject>(
                builder: (context) => const NewSubjectScreen(),
              ),
            );

            if (result != null && context.mounted) {
              onSubjectChanged(result);
            }
          },
          child: Icon(Icons.add, color: style.colors.accent),
        ),
      ],
    );
  }
}

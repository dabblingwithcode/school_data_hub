import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

class SchoolSemesterDropdown extends StatelessWidget {
  final ValueNotifier<SchoolSemester?> selectedSemester;
  final List<SchoolSemester> schoolSemesters;

  const SchoolSemesterDropdown({
    super.key,
    required this.selectedSemester,
    required this.schoolSemesters,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<SchoolSemester>(
      value: selectedSemester.value,
      decoration: AppStyles.textFieldDecoration(labelText: 'Schulsemester'),
      items:
          schoolSemesters.map((semester) {
            return DropdownMenuItem<SchoolSemester>(
              value: semester,
              child: Text(
                '${semester.schoolYear} ${semester.isFirst ? "1. Halbjahr" : "2. Halbjahr"} (${_formatDate(semester.startDate)} - ${_formatDate(semester.endDate)})',
              ),
            );
          }).toList(),
      onChanged: (SchoolSemester? newValue) {
        selectedSemester.value = newValue;
      },
      validator: (value) {
        if (value == null) {
          return 'Bitte wählen Sie ein Schulsemester aus';
        }
        return null;
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}

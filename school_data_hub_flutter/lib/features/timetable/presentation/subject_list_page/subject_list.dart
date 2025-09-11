import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/subject_list_page/widgets/subject_list_card.dart';

class SubjectList extends StatelessWidget {
  final List<Subject> subjects;
  final Function(Subject) onSubjectTap;

  const SubjectList({
    super.key,
    required this.subjects,
    required this.onSubjectTap,
  });

  @override
  Widget build(BuildContext context) {
    if (subjects.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.subject, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Keine Fächer verfügbar',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Erstellen Sie ein neues Fach',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SubjectListCard(
            subject: subject,
            onTap: () => onSubjectTap(subject),
          ),
        );
      },
    );
  }
}

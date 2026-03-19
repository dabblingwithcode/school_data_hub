import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/subject/subject_list_page/widgets/subject_list_card.dart';

class SubjectList extends StatelessWidget {
  final List<Subject> subjects;
  final void Function(Subject) onSubjectTap;

  const SubjectList({
    super.key,
    required this.subjects,
    required this.onSubjectTap,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);

    if (subjects.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.subject, size: 64, color: style.colors.mutedForeground),
            Gap(Style.spacing.lg),
            Text(
              'Keine Fächer verfügbar',
              style: context.typography.title
                  .withColor(style.colors.mutedForeground),
            ),
            Gap(Style.spacing.sm),
            Text(
              'Erstellen Sie ein neues Fach',
              style: context.typography.body
                  .withColor(style.colors.mutedForeground),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(Style.spacing.lg),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];
        return Padding(
          padding: EdgeInsets.only(bottom: Style.spacing.sm),
          child: SubjectListCard(
            subject: subject,
            onTap: () => onSubjectTap(subject),
          ),
        );
      },
    );
  }
}

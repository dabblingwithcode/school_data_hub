import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_enums.dart'
    as workbook_enum;

class WorkbooksOverview extends StatelessWidget {
  final PupilProxy pupil;
  const WorkbooksOverview({super.key, required this.pupil});

  workbook_enum.SubjectEnum? _resolveSubject(String subjectName) {
    for (final subject in workbook_enum.SubjectEnum.values) {
      if (subject.name == subjectName) {
        return subject;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final pupilWorkbooks = pupil.pupilWorkbooks ?? [];
    final Map<workbook_enum.SubjectEnum, int> counts = {};

    for (final pw in pupilWorkbooks) {
      final subjectName = pw.workbook?.subject;
      if (subjectName == null) continue;

      final workbookSubject = _resolveSubject(subjectName);
      if (workbookSubject != null) {
        counts[workbookSubject] = (counts[workbookSubject] ?? 0) + 1;
      }
    }

    final List<Widget> widgetList = [];
    counts.forEach((subject, count) {
      final imagePath = subject.imagePath;
      widgetList.add(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (imagePath != null)
              SizedBox(
                width: 30,
                height: 30,
                child: Image.asset(imagePath, fit: BoxFit.contain),
              )
            else
              const Icon(Icons.menu_book_rounded, size: 20),
            const Gap(4),
            Text(
              count.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
      widgetList.add(const Gap(10));
    });

    if (widgetList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15.0, right: 10),
        child: Text(
          'keine Arbeitshefte erfasst',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.withValues(alpha: 0.7),
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: widgetList),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/pupil_workbook_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_enums.dart'
    as workbook_enum;

class WorkbooksOverview extends WatchingWidget {
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
    final style = Style.of(context);
    watch(di<PupilWorkbookManager>());
    final pupilWorkbooks = di<PupilWorkbookManager>().getPupilWorkbooks(
      pupil.pupilId,
    );
    final Map<workbook_enum.SubjectEnum?, int> counts = {};

    for (final pw in pupilWorkbooks) {
      final subjectName = pw.workbook?.subject;
      final workbookSubject =
          subjectName != null ? _resolveSubject(subjectName) : null;
      counts[workbookSubject] = (counts[workbookSubject] ?? 0) + 1;
    }

    final List<Widget> widgetList = [];
    counts.forEach((subject, count) {
      final imagePath = subject?.imagePath;
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
            Gap(Style.spacing.xs),
            Text(
              count.toString(),
              style: context.typography.body.bold.withColor(style.colors.foreground),
            ),
          ],
        ),
      );
      widgetList.add(Gap(Style.spacing.md));
    });

    if (widgetList.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(bottom: Style.spacing.lg, right: Style.spacing.md),
        child: Text(
          'keine Arbeitshefte erfasst',
          style: context.typography.body.withColor(
            style.colors.mutedForeground,
          ).copyWith(fontStyle: FontStyle.italic),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: widgetList,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/pupil_workbook_helper.dart';

class PupilWorkbooksInfos extends WatchingWidget {
  const PupilWorkbooksInfos({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final pupils = watchValue((PupilsFilter m) => m.filteredPupils);
    final stats = PupilWorkbookHelper.countCompletedWorkbooks(pupils);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.people_alt_rounded, color: style.colors.accent),
        Gap(Style.spacing.md),
        Text(
          pupils.length.toString(),
          style: context.typography.title,
        ),
        Gap(Style.spacing.lg),
        Text(
          'Arbeitshefte: ',
          style: context.typography.bodySmall.withColor(style.colors.foreground),
        ),
        Gap(Style.spacing.xs),
        Text(
          (stats.totalWorkbooks).toString(),
          style: context.typography.title,
        ),
        Gap(Style.spacing.lg),
        Text(
          'offen: ',
          style: context.typography.bodySmall.withColor(style.colors.foreground),
        ),
        Gap(Style.spacing.xs),
        Text(
          (stats.openWorkbooks).toString(),
          style: context.typography.title,
        ),
        Gap(Style.spacing.lg),
        Text(
          'abgeschlossen: ',
          style: context.typography.bodySmall.withColor(style.colors.foreground),
        ),
        Gap(Style.spacing.xs),
        Text(
          (stats.finishedWorkbooks).toString(),
          style: context.typography.title,
        ),
      ],
    );
  }
}

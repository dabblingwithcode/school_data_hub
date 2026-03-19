import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_helper.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';

class PupilBookLendingsInfos extends WatchingWidget {
  const PupilBookLendingsInfos({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final pupils = watchValue((PupilsFilter m) => m.filteredPupils);

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
          'gelesen: ',
          style: context.typography.bodySmall.withColor(style.colors.foreground),
        ),
        Gap(Style.spacing.xs),
        Text(
          (BookHelpers.totalPupilBookLendings()).toString(),
          style: context.typography.title,
        ),
        Gap(Style.spacing.lg),
        Text(
          'ausgeliehen: ',
          style: context.typography.bodySmall.withColor(style.colors.foreground),
        ),
        Gap(Style.spacing.xs),
        Text(
          (BookHelpers.totalOpenPupilBookLendings()).toString(),
          style: context.typography.title,
        ),
      ],
    );
  }
}

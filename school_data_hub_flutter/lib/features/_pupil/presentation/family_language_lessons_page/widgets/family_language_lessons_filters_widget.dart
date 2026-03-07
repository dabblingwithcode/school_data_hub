import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';

class FamilyLanguageLessonsFiltersWidget extends WatchingWidget {
  const FamilyLanguageLessonsFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final familyLanguageFilters = di<PupilsFilter>().familyLanguageFilters;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [Text('Familiensprache', style: AppStyles.subtitle)],
        ),
        const Gap(5),
        Wrap(
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            for (final familyLanguageFilter in familyLanguageFilters)
              ThemedFilterChip(
                label: familyLanguageFilter.displayName,
                selected: watch(familyLanguageFilter).isActive,
                onSelected: (val) {
                  familyLanguageFilter.toggle(val);
                },
              ),
          ],
        ),
      ],
    );
  }
}

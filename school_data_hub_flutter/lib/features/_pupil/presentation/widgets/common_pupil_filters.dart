import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';

// Re-export so existing imports of FilterHeading from this file still work
export 'package:school_data_hub_flutter/common/widgets/generic_components/filter_heading.dart';

class CommonPupilFiltersWidget extends WatchingWidget {
  const CommonPupilFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final schoolGradeFilters = di<PupilsFilter>().schoolGradeFilters;
    final groupFilters = di<PupilsFilter>().groupFilters;

    final genderFilters = di<PupilsFilter>().genderFilters;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: CardBox(
        child: Column(
          children: [
            Row(
              children: [
                Text('Jahrgang', style: context.typography.subtitle),
              ],
            ),
            const Gap(4),
            Wrap(
              spacing: 5,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                for (final schoolGradeFilter in schoolGradeFilters)
                  ThemedFilterChip(
                    label: schoolGradeFilter.displayName,
                    selected: watch(schoolGradeFilter).isActive,
                    onSelected: (val) {
                      schoolGradeFilter.toggle(val);
                    },
                  ),
              ],
            ),
            Row(
              children: [
                Text('Klasse', style: context.typography.subtitle),
              ],
            ),
            const Gap(4),
            Wrap(
              spacing: 5,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                for (final groupFilter in groupFilters)
                  ThemedFilterChip(
                    label: groupFilter.displayName,
                    selected: watch(groupFilter).isActive,
                    onSelected: (val) {
                      groupFilter.toggle(val);
                    },
                  ),
              ],
            ),
            const Gap(4),
            Wrap(
              spacing: 5,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                for (final genderFilter in genderFilters)
                  ThemedFilterChip(
                    label: genderFilter.name,
                    selected: watch(genderFilter).isActive,
                    onSelected: (val) {
                      genderFilter.toggle(val);
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

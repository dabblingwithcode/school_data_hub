import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:watch_it/watch_it.dart';

class ReligionFilterBottomSheet extends WatchingWidget {
  const ReligionFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CommonPupilFiltersWidget(),
        Gap(10),
        ReligionFiltersSection(),
      ],
    );
  }
}

class ReligionFiltersSection extends WatchingWidget {
  const ReligionFiltersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final religionCourseFilters = di<PupilsFilter>().religionCourseFilters;

    return Column(
      children: [
        const Row(
          children: [
            Text(
              'Religion',
              style: AppStyles.subtitle,
            )
          ],
        ),
        const Gap(5),
        Wrap(
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            for (final religionFilter in religionCourseFilters)
              ThemedFilterChip(
                label: religionFilter.displayName,
                selected: watch(religionFilter).isActive,
                onSelected: (val) {
                  religionFilter.toggle(val);
                },
              ),
          ],
        ),
      ],
    );
  }
}


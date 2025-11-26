import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:watch_it/watch_it.dart';

class FilterHeading extends StatelessWidget {
  const FilterHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Filter', style: AppStyles.title),
        const Spacer(),
        IconButton(
          iconSize: 35,
          color: AppColors.interactiveColor,
          onPressed: () {
            di<FiltersStateManager>().resetFilters();
            //Navigator.pop(context);
          },
          icon: const Icon(
            Icons.delete_forever_rounded,
            size: 35,
            color: AppColors.accentColor,
          ),
        ),
      ],
    );
  }
}

class CommonPupilFiltersWidget extends WatchingWidget {
  const CommonPupilFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final schoolGradeFilters = di<PupilsFilter>().schoolGradeFilters;
    final groupFilters = di<PupilsFilter>().groupFilters;

    final genderFilters = di<PupilsFilter>().genderFilters;

    return Column(
      children: [
        const Row(children: [Text('Jahrgang', style: AppStyles.subtitle)]),
        const Gap(5),
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
        const Row(children: [Text('Klasse', style: AppStyles.subtitle)]),
        const Gap(5),
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
        const Gap(5),
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:watch_it/watch_it.dart';

final _pupilsFilter = di<PupilsFilter>();

class FamilyLanguageLessonsListPageBottomNavBar extends WatchingWidget {
  const FamilyLanguageLessonsListPageBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final filtersOn = watchValue((FiltersStateManager x) => x.filtersActive);
    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        height: 60,
        padding: const EdgeInsets.all(10),
        shape: null,
        color: AppColors.backgroundColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: <Widget>[
              const Spacer(),
              IconButton(
                tooltip: 'zurück',
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Gap(30),
              InkWell(
                onTap: () =>
                    showGenericFilterBottomSheet(context: context, filterList: [
                  const CommonPupilFiltersWidget(),
                  const Gap(10),
                  const FamilyLanguageFiltersSection(),
                ]),
                onLongPress: () => _pupilsFilter.resetFilters(),
                child: Icon(
                  Icons.filter_list,
                  color: filtersOn ? Colors.deepOrange : Colors.white,
                  size: 30,
                ),
              ),
              const Gap(15)
            ],
          ),
        ),
      ),
    );
  }
}

class FamilyLanguageFiltersSection extends WatchingWidget {
  const FamilyLanguageFiltersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final familyLanguageFilters = di<PupilsFilter>().familyLanguageFilters;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              'Familiensprache',
              style: AppStyles.subtitle,
            ),
          ],
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


import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/select_pupils_list_page/widgets/select_pupils_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/pupil_search_text_field.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';
import 'package:watch_it/watch_it.dart';

final _pupilsFilter = di<PupilsFilter>();

class SelectPupilsSearchBar extends WatchingWidget {
  final List<PupilProxy> selectablePupils;
  final List<PupilProxy>? selectedPupils;
  const SelectPupilsSearchBar({
    required this.selectablePupils,
    this.selectedPupils,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    bool filtersOn = watchValue((FiltersStateManager x) => x.filtersActive);

    // Get active filters
    final schoolGradeFilters = _pupilsFilter.schoolGradeFilters;
    final groupFilters = _pupilsFilter.groupFilters;
    final genderFilters = _pupilsFilter.genderFilters;

    // Collect all active filters
    final activeFilters = <Filter>[];
    activeFilters.addAll(
      schoolGradeFilters.where((filter) => watch(filter).isActive),
    );
    activeFilters.addAll(
      groupFilters.where((filter) => watch(filter).isActive),
    );
    activeFilters.addAll(
      genderFilters.where((filter) => watch(filter).isActive),
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.canvasColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: [
          const Gap(5),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  locale.shown,
                  style: const TextStyle(color: Colors.black, fontSize: 13),
                ),
                const Gap(10),
                Text(
                  selectablePupils.length.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const Gap(15),
                Text(
                  locale.selected,
                  style: const TextStyle(color: Colors.black, fontSize: 13),
                ),
                const Gap(5),
                Text(
                  selectedPupils == null
                      ? '0'
                      : selectedPupils!.length.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          // Active filter chips
          if (activeFilters.isNotEmpty) ...[
            const Gap(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: activeFilters.map((filter) {
                  return Chip(
                    label: Text(
                      filter.displayName,
                      style: const TextStyle(fontSize: 12),
                    ),
                    backgroundColor: AppColors.interactiveColor,
                    labelStyle: const TextStyle(color: Colors.white),
                    deleteIcon: const Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.white,
                    ),
                    onDeleted: () {
                      filter.toggle(false);
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  );
                }).toList(),
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: PupilSearchTextField(
                    searchType: SearchType.pupil,
                    hintText: 'Schüler/in suchen',
                    refreshFunction: _pupilsFilter.refreshs,
                  ),
                ),
                InkWell(
                  onTap: () => showSelectPupilsFilterBottomSheet(context),
                  onLongPress: () => _pupilsFilter.resetFilters(),
                  // onPressed: () => showBottomSheetFilters(context),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.filter_list,
                      color: filtersOn ? Colors.deepOrange : Colors.grey,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

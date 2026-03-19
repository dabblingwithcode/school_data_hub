import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/select_pupils_list_screen/widgets/select_pupils_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_search_text_field.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';
import 'package:flutter_it/flutter_it.dart';

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
    final style = Style.of(context);
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
        color: style.colors.canvas,
        borderRadius: BorderRadius.circular(Style.radii.small),
      ),
      child: Column(
        children: [
          const Gap(4),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(locale.shown, style: context.typography.bodySmall),
                const Gap(12),
                Text(
                  selectablePupils.length.toString(),
                  style: context.typography.title,
                ),
                const Gap(16),
                Text(locale.selected, style: context.typography.bodySmall),
                const Gap(4),
                Text(
                  selectedPupils == null
                      ? '0'
                      : selectedPupils!.length.toString(),
                  style: context.typography.title,
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
                      style: context.typography.bodySmall,
                    ),
                    backgroundColor: style.colors.interactive,
                    labelStyle: TextStyle(color: style.colors.background),
                    deleteIcon: Icon(
                      Icons.close,
                      size: 16,
                      color: style.colors.background,
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
                  child: GenericSearchTextField(
                    searchType: SearchType.pupil,
                    hintText: 'Schüler/in suchen',
                    refreshFunction: _pupilsFilter.refresh,
                    onChanged: (value) =>
                        _pupilsFilter.textFilter.setFilterText(value),
                    searchTextSource: _pupilsFilter.textFilter,
                    filtersActive: di<FiltersStateManager>().filtersActive,
                    onResetFilters: _pupilsFilter.resetFilters,
                  ),
                ),
                GestureDetector(
                  onTap: () => showSelectPupilsFilterBottomSheet(context),
                  onLongPress: () => _pupilsFilter.resetFilters(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.filter_list,
                      color: filtersOn
                          ? Colors.deepOrange
                          : style.colors.mutedForeground,
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

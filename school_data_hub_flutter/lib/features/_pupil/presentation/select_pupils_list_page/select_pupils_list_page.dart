import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/filter_button.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/content_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/sliver_search_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/select_pupils_list_page/widgets/select_pupils_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/select_pupils_list_page/widgets/select_pupils_list_card.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/select_pupils_list_page/widgets/select_pupils_search_bar.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';

class SelectPupilsListScreen extends WatchingStatefulWidget {
  final List<PupilProxy>? selectablePupils;

  const SelectPupilsListScreen({required this.selectablePupils, super.key});

  @override
  State<SelectPupilsListScreen> createState() => _SelectPupilsListScreenState();
}

class _SelectPupilsListScreenState extends State<SelectPupilsListScreen> {
  List<PupilProxy>? pupils;
  final _selectablePupilsListenable = ValueNotifier<List<PupilProxy>>([]);

  List<int> selectedPupilIds = [];
  bool isSelectAllMode = false;
  bool isSelectMode = false;

  PupilProxyManager get _pupilManager => di<PupilProxyManager>();

  @override
  void dispose() {
    _selectablePupilsListenable.dispose();
    super.dispose();
  }

  void cancelSelect() {
    setState(() {
      selectedPupilIds.clear();
      isSelectMode = false;
    });
  }

  void onCardPress(int pupilId) {
    if (selectedPupilIds.contains(pupilId)) {
      setState(() {
        selectedPupilIds.remove(pupilId);
        if (selectedPupilIds.isEmpty) {
          isSelectMode = false;
        }
      });
    } else {
      setState(() {
        selectedPupilIds.add(pupilId);
        isSelectMode = true;
      });
    }
  }

  void clearAll() {
    setState(() {
      isSelectMode = false;
      selectedPupilIds.clear();
    });
  }

  void toggleSelectAll(List<PupilProxy> selectablePupils) {
    setState(() {
      isSelectAllMode = !isSelectAllMode;
      if (isSelectAllMode) {
        isSelectMode = true;
        selectedPupilIds = selectablePupils
            .map((pupil) => pupil.pupilId)
            .toList();
      } else {
        isSelectMode = false;
        selectedPupilIds.clear();
      }
    });
  }

  List<int> getSelectedPupilIds() {
    return selectedPupilIds.toList();
  }

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final locale = AppLocalizations.of(context)!;
    final List<PupilProxy> filteredPupils = watchValue(
      (PupilsFilter x) => x.filteredPupils,
    );

    final List<PupilProxy> selectablePupils = filteredPupils
        .where((pupil) => widget.selectablePupils!.contains(pupil))
        .toList();
    _selectablePupilsListenable.value = selectablePupils;

    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: AppHeader(
        title: locale.selectPupils,
        iconData: Icons.group_add_rounded,
      ),
      body: RefreshIndicator(
        onRefresh: () async => _pupilManager.fetchAllPupils(),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: CustomScrollView(
              slivers: [
                const SliverGap(5),
                SliverSearchBar(
                  height: 110,
                  searchWidgetWithStatsRow: SelectPupilsSearchBar(
                    selectablePupils: selectablePupils,
                    selectedPupils: _pupilManager.getPupilsFromPupilIds(
                      selectedPupilIds,
                    ),
                  ),
                ),
                ContentSliverList(
                  itemsListenable: _selectablePupilsListenable,
                  itemBuilder: (_, pupil) => SelectPupilListCard(
                    isSelectMode: isSelectMode,
                    isSelected: selectedPupilIds.contains(pupil.pupilId),
                    passedPupil: pupil,
                    onCardPress: onCardPress,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: ActionBar(
        actions: [
          if (isSelectMode)
            TappableIcon(
              tooltip: 'Abbrechen',
              icon: const Icon(Icons.close, size: 30),
              onPressed: cancelSelect,
            ),
          TappableIcon(
            tooltip: 'alle auswählen',
            icon: Icon(
              Icons.select_all_rounded,
              color: isSelectAllMode
                  ? Colors.deepOrange
                  : style.colors.background,
              size: 30,
            ),
            onPressed: () => toggleSelectAll(selectablePupils),
          ),
          TappableIcon(
            tooltip: 'Okay',
            icon: Icon(
              Icons.check,
              color: isSelectMode
                  ? style.colors.success
                  : style.colors.background,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context, selectedPupilIds);
            },
          ),
          FilterButton(
            isSearchBar: false,
            filtersActive: di<FiltersStateManager>().filtersActive,
            onLongPress: () => di<FiltersStateManager>().resetFilters(),
            showBottomSheetFunction: showSelectPupilsFilterBottomSheet,
          ),
        ],
      ),
    );
  }
}

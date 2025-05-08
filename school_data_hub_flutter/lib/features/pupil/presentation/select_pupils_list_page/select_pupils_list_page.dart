import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_filter_enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_filter_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/select_pupils_list_page/widgets/select_pupils_list_card.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/select_pupils_list_page/widgets/select_pupils_search_bar.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/select_pupils_list_page/widgets/select_pupils_view_bottom_navbar.dart';
import 'package:watch_it/watch_it.dart';

final _pupilManager = di<PupilManager>();
final _pupilFilerManager = di<PupilFilterManager>();

class SelectPupilsListPage extends WatchingStatefulWidget {
  final List<PupilProxy>? selectablePupils;

  const SelectPupilsListPage({required this.selectablePupils, super.key});

  @override
  State<SelectPupilsListPage> createState() => _SelectPupilsListPageState();
}

class _SelectPupilsListPageState extends State<SelectPupilsListPage> {
  List<PupilProxy>? pupils;

  Map<PupilFilter, bool>? inheritedFilters;

  List<int> selectedPupilIds = [];
  bool isSelectAllMode = false;
  bool isSelectMode = false;

  @override
  void initState() {
    setState(() {
      inheritedFilters = _pupilFilerManager.pupilFilterState.value;
    });
    super.initState();
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
        selectedPupilIds =
            selectablePupils.map((pupil) => pupil.pupilId).toList();
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
    final locale = AppLocalizations.of(context)!;
    bool filtersOn = watchValue((FiltersStateManager x) => x.filtersActive);
    final List<PupilProxy> filteredPupils =
        watchValue((PupilsFilter x) => x.filteredPupils);

    final List<PupilProxy> selectablePupils = filteredPupils
        .where((pupil) => widget.selectablePupils!.contains(pupil))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: GenericAppBar(
        title: locale.selectPupils,
        iconData: Icons.group_add_rounded,
      ),
      body: RefreshIndicator(
        onRefresh: () async => _pupilManager.fetchAllPupils(),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: CustomScrollView(
              slivers: [
                const SliverGap(5),
                GenericSliverSearchAppBar(
                  height: 110,
                  title: SelectPupilsSearchBar(
                    selectablePupils: selectablePupils,
                    selectedPupils:
                        _pupilManager.getPupilsFromPupilIds(selectedPupilIds),
                  ),
                ),
                GenericSliverListWithEmptyListCheck(
                    items: selectablePupils,
                    itemBuilder: (_, pupil) => SelectPupilListCard(
                          isSelectMode: isSelectMode,
                          isSelected: selectedPupilIds.contains(pupil.pupilId),
                          passedPupil: pupil,
                          onCardPress: onCardPress,
                        )),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SelectPupilsPageBottomNavBar(
        isSelectAllMode: isSelectAllMode,
        isSelectMode: isSelectMode,
        filtersOn: filtersOn,
        selectedPupilIds: selectedPupilIds,
        cancelSelect: cancelSelect,
        toggleSelectAll: () => toggleSelectAll(selectablePupils),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_list_page.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/_credit/credit_list_page/widgets/credit_filters_widget.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/_credit/credit_list_page/widgets/credit_list_card.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/_credit/credit_list_page/widgets/credit_list_search_bar_stats.dart';

class CreditListPage extends WatchingWidget {
  const CreditListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pupilsFilter = di<PupilsFilter>();
    final filterStateManager = di<FiltersStateManager>();
    final int userCredit = watchPropertyValue(
      (HubSessionManager x) => x.user,
    )!.credit;

    return GenericListPage<PupilProxy>(
      backgroundColor: AppColors.canvasColor,
      iconData: Icons.credit_card,
      title: 'Guthaben: $userCredit',
      sliverAppBarHeight: 110,
      searchBarConfig: GenericListSearchBarConfig(
        statsWidget: CreditListSearchBarStats(
          filteredPupils: pupilsFilter.filteredPupils,
        ),
        searchType: SearchType.pupil,
        hintText: 'Schüler/in suchen',
        refreshFunction: pupilsFilter.refresh,
        onChanged: (value) => pupilsFilter.textFilter.setFilterText(value),
        searchTextSource: pupilsFilter.textFilter,
        filtersActive: filterStateManager.filtersActive,
        onResetFilters: filterStateManager.resetFilters,
      ),
      filterSheetChildren: const [
        CommonPupilFiltersWidget(),
        CreditFiltersWidget(),
      ],
      itemsListenable: pupilsFilter.filteredPupils,
      itemBuilder: (_, pupil) => CreditListCard(pupil),
      onRefresh: () async => di<PupilProxyManager>().fetchAllPupils(),
      maxWidth: 700,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/list_screen.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/_credit/credit_list_page/widgets/credit_filters_widget.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/_credit/credit_list_page/widgets/credit_list_card.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/_credit/credit_list_page/widgets/credit_list_search_bar_stats.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';

class CreditListScreen extends StatelessWidget {
  const CreditListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pupilsFilter = di<PupilsFilter>();
    final filterStateManager = di<FiltersStateManager>();

    return ListScreen<PupilProxy>(
      backgroundColor: Style.of(context).colors.canvas,
      iconData: Icons.credit_card,
      appBar: const _CreditAppBar(),
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

/// Rebuilds only when [HubSessionManager.user] changes, keeping the list
/// cards stable when the teacher's credit balance updates.
class _CreditAppBar extends WatchingWidget implements PreferredSizeWidget {
  const _CreditAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final int userCredit = watchPropertyValue(
      (HubSessionManager x) => x.user,
    )!.credit;

    return AppHeader(
      iconData: Icons.credit_card,
      titleWidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.credit_card, size: 25, color: style.colors.background),
          const SizedBox(width: 10),
          Text(
            'Guthaben: $userCredit',
            style: context.typography.title.withColor(style.colors.background),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_list_page.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_authorizations/domain/authorization_manager.dart';
import 'package:school_data_hub_flutter/features/_authorizations/domain/filters/pupil_authorization_filter_manager.dart';
import 'package:school_data_hub_flutter/features/_authorizations/presentation/authorization_pupils_page/widgets/authorization_pupil_card.dart';
import 'package:school_data_hub_flutter/features/_authorizations/presentation/authorization_pupils_page/widgets/authorization_pupils_filters_widget.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/pupil_count_search_bar_stats.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/select_pupils_list_page/select_pupils_list_page.dart';

class AuthorizationPupilsPage extends WatchingWidget {
  final Authorization authorization;

  const AuthorizationPupilsPage(this.authorization, {super.key});

  @override
  Widget build(BuildContext context) {
    final pupilManager = di<PupilProxyManager>();
    final pupilsFilter = di<PupilsFilter>();
    final filterStateManager = di<FiltersStateManager>();
    final pupilAuthorizationFilterManager =
        di<PupilAuthorizationFilterManager>();
    final thisAuthorization = watchValue(
      (AuthorizationManager x) => x.authorizations,
    ).firstWhere((authorization) => authorization.id == this.authorization.id);

    final filteredPupils = watchValue((PupilsFilter x) => x.filteredPupils);

    final List<PupilAuthorization> pupilAuthorizations =
        pupilAuthorizationFilterManager
            .applyAuthorizationFiltersToPupilAuthorizations(
              thisAuthorization.authorizedPupils!,
            );

    List<PupilProxy> pupilsInList = filteredPupils
        .where(
          (pupil) => pupilAuthorizations.any(
            (pupilAuth) => pupilAuth.pupilId == pupil.pupilId,
          ),
        )
        .toList();
    final pupilsInListListenable =
        createOnce(() => ValueNotifier<List<PupilProxy>>([]));
    pupilsInListListenable.value = pupilsInList;

    return GenericListPage<PupilProxy>(
      iconData: Icons.list,
      title: authorization.name,
      backgroundColor: AppColors.canvasColor,
      maxWidth: 700,
      searchBarConfig: GenericListSearchBarConfig(
        statsWidget: PupilCountSearchBarStats(
          filteredPupils: pupilsInListListenable,
        ),
        searchType: SearchType.pupil,
        hintText: 'Schüler/in suchen',
        refreshFunction: pupilsFilter.refreshs,
        onChanged: (value) => pupilsFilter.textFilter.setFilterText(value),
        searchTextSource: pupilsFilter.textFilter,
        filtersActive: filterStateManager.filtersActive,
        onResetFilters: filterStateManager.resetFilters,
      ),
      filterSheetChildren: const [
        CommonPupilFiltersWidget(),
        AuthorizationPupilsFiltersWidget(),
      ],
      itemsListenable: pupilsInListListenable,
      itemBuilder: (_, PupilProxy pupil) => AuthorizationPupilCard(
        pupil.pupilId,
        authorization,
      ),
      onRefresh: () async => di<AuthorizationManager>().fetchAuthorizations(),
      bottomBarActions: [
        if (di<HubSessionManager>().userName == authorization.createdBy ||
            di<HubSessionManager>().isAdmin)
          IconButton(
            tooltip: 'Kinder hinzufügen',
            icon: const Icon(Icons.add, color: Colors.white, size: 30),
            onPressed: () async {
              final List<int>? selectedPupilIds = await Navigator.of(context)
                  .push(
                    MaterialPageRoute<List<int>>(
                      builder: (ctx) => SelectPupilsListPage(
                        selectablePupils: pupilManager.getPupilsNotListed(
                          pupilManager.getPupilIdsFromPupils(pupilsInList),
                        ),
                      ),
                    ),
                  );
              if (selectedPupilIds == null) return;
              if (selectedPupilIds.isNotEmpty) {
                di<AuthorizationManager>().updateAuthorization(
                  authId: authorization.id!,
                  membersToUpdate: (
                    operation: MemberOperation.add,
                    pupilIds: selectedPupilIds,
                  ),
                );
              }
            },
          ),
      ],
    );
  }
}

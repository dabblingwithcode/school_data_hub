import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/features/_authorizations/domain/authorization_manager.dart';
import 'package:school_data_hub_flutter/features/_authorizations/domain/filters/pupil_authorization_filter_manager.dart';
import 'package:school_data_hub_flutter/features/_authorizations/presentation/authorization_pupils_page/widgets/authorization_pupil_card.dart';
import 'package:school_data_hub_flutter/features/_authorizations/presentation/authorization_pupils_page/widgets/authorization_pupil_list_searchbar.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_button.dart';
import 'package:school_data_hub_flutter/features/_authorizations/presentation/authorization_pupils_page/widgets/authorization_pupils_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/select_pupils_list_page/select_pupils_list_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:flutter_it/flutter_it.dart';

class AuthorizationPupilsPage extends WatchingWidget {
  final Authorization authorization;

  const AuthorizationPupilsPage(this.authorization, {super.key});

  @override
  Widget build(BuildContext context) {
    final pupilManager = di<PupilProxyManager>();
    final pupilAuthorizationFilterManager =
        di<PupilAuthorizationFilterManager>();
    // final filters = watchValue((PupilFilterManager x) => x.filterState);

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

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: GenericAppBar(iconData: Icons.list, title: authorization.name),
      body: RefreshIndicator(
        onRefresh: () async => di<AuthorizationManager>().fetchAuthorizations(),
        child: Center(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: CustomScrollView(
                slivers: [
                  const SliverGap(5),
                  GenericSliverSearchAppBar(
                    height: 110,
                    title: AuthorizationPupilListSearchBar(
                      pupils: pupilsInList,
                    ),
                  ),
                  pupilsInList.isEmpty
                      ? const SliverToBoxAdapter(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Keine Ergebnisse',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              // Your list view items go here
                              return AuthorizationPupilCard(
                                pupilsInList[index].pupilId,
                                authorization,
                              );
                            },
                            childCount: pupilsInList
                                .length, // Adjust this based on your data
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: GenericBottomNavBar(
        actions: [
          if (di<HubSessionManager>().userName == authorization.createdBy ||
              di<HubSessionManager>().isAdmin)
            IconButton(
              tooltip: 'Kinder hinzufügen',
              icon: const Icon(Icons.add, color: Colors.white, size: 30),
              onPressed: () async {
                final List<int>? selectedPupilIds =
                    await Navigator.of(context).push(
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
          GenericFilterButton(
            isSearchBar: false,
            showBottomSheetFunction: showAuthorizationPupilsFilterBottomSheet,
          ),
        ],
      ),
    );
  }
}

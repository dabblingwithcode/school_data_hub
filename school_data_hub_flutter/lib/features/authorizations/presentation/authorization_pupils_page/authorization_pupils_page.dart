import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/theme/app_colors.dart';
import 'package:schuldaten_hub/common/widgets/list_view_components/generic_sliver_search_app_bar.dart';
import 'package:schuldaten_hub/features/authorizations/domain/authorization_manager.dart';
import 'package:schuldaten_hub/features/authorizations/domain/filters/pupil_authorization_filter_manager.dart';
import 'package:schuldaten_hub/features/authorizations/domain/models/authorization.dart';
import 'package:schuldaten_hub/features/authorizations/domain/models/pupil_authorization.dart';
import 'package:schuldaten_hub/features/authorizations/presentation/authorization_pupils_page/widgets/authorization_pupil_card.dart';
import 'package:schuldaten_hub/features/authorizations/presentation/authorization_pupils_page/widgets/authorization_pupil_list_searchbar.dart';
import 'package:schuldaten_hub/features/authorizations/presentation/authorization_pupils_page/widgets/authorization_pupils_bottom_navbar.dart';
import 'package:schuldaten_hub/features/pupil/domain/filters/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/domain/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

class AuthorizationPupilsPage extends WatchingWidget {
  final Authorization authorization;

  const AuthorizationPupilsPage(this.authorization, {super.key});

  @override
  Widget build(BuildContext context) {
    // final filters = watchValue((PupilFilterManager x) => x.filterState);

    final thisAuthorization =
        watchValue((AuthorizationManager x) => x.authorizations).firstWhere(
            (authorization) =>
                authorization.authorizationId ==
                this.authorization.authorizationId);

    final filteredPupils = watchValue((PupilsFilter x) => x.filteredPupils);

    final List<PupilAuthorization> pupilAuthorizations =
        locator<PupilAuthorizationFilterManager>()
            .applyAuthorizationFiltersToPupilAuthorizations(
                thisAuthorization.authorizedPupils);

    List<PupilProxy> pupilsInList = filteredPupils
        .where((pupil) => pupilAuthorizations
            .any((pupilAuth) => pupilAuth.pupilId == pupil.internalId))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.list, color: Colors.white),
            const Gap(5),
            Text(authorization.authorizationName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            locator<AuthorizationManager>().fetchAuthorizations(),
        child: Center(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: CustomScrollView(
                slivers: [
                  const SliverGap(5),
                  GenericSliverSearchAppBar(
                    height: 110,
                    title:
                        AuthorizationPupilListSearchBar(pupils: pupilsInList),
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
                                  pupilsInList[index].internalId,
                                  authorization);
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
      bottomNavigationBar: AuthorizationPupilsBottomNavBar(
        authorization: authorization,
        pupilsInAuthorization:
            locator<PupilManager>().pupilIdsFromPupils(pupilsInList),
      ),
    );
  }
}

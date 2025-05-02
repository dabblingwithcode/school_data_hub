import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/domain/filters/filters_state_manager.dart';
import 'package:schuldaten_hub/common/domain/models/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/theme/app_colors.dart';
import 'package:schuldaten_hub/common/theme/styles.dart';
import 'package:schuldaten_hub/features/authorizations/domain/authorization_manager.dart';
import 'package:schuldaten_hub/features/authorizations/domain/filters/authorization_filter_manager.dart';
import 'package:schuldaten_hub/features/authorizations/domain/models/authorization.dart';
import 'package:schuldaten_hub/features/authorizations/presentation/authorizations_list_page/widgets/authorization_card.dart';
import 'package:schuldaten_hub/features/authorizations/presentation/authorizations_list_page/widgets/authorization_list_bottom_navbar.dart';
import 'package:schuldaten_hub/features/authorizations/presentation/authorizations_list_page/widgets/authorization_list_search_text_field.dart';
import 'package:schuldaten_hub/features/pupil/domain/filters/pupils_filter.dart';
import 'package:watch_it/watch_it.dart';

class AuthorizationsListPage extends WatchingWidget {
  const AuthorizationsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool filtersOn = watchValue((FiltersStateManager x) => x.filtersActive);

    List<Authorization> authorizations =
        watchValue((AuthorizationFilterManager x) => x.filteredAuthorizations);

    //- TODO: implement slivers and separate the search bar from the list

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fact_check_rounded, size: 25, color: Colors.white),
            Gap(10),
            Text(
              'Nachweis-Listen',
              style: AppStyles.appBarTextStyle,
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            locator<AuthorizationManager>().fetchAuthorizations(),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 15.0, right: 10.00),
                  child: Row(
                    children: [
                      const Text(
                        'Gesamt:',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        authorizations.length.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: AuthorizationListSearchTextField(
                            searchType: SearchType.authorization,
                            hintText: 'Liste suchen',
                            refreshFunction: locator<AuthorizationManager>()
                                .fetchAuthorizations),
                      ),
                      //---------------------------------
                      InkWell(
                        onTap: () {},

                        onLongPress: () =>
                            locator<PupilsFilter>().resetFilters(),
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
                authorizations.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Keine Ergebnisse',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: authorizations.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AuthorizationCard(
                                authorization: authorizations[index]);
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const AuthorizationListBottomNavBar(),
    );
  }
}

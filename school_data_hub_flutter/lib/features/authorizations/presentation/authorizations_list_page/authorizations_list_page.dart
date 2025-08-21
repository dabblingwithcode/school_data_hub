import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/authorizations/domain/authorization_manager.dart';
import 'package:school_data_hub_flutter/features/authorizations/domain/filters/authorization_filter_manager.dart';
import 'package:school_data_hub_flutter/features/authorizations/presentation/authorizations_list_page/widgets/authorization_card.dart';
import 'package:school_data_hub_flutter/features/authorizations/presentation/authorizations_list_page/widgets/authorization_list_bottom_navbar.dart';
import 'package:school_data_hub_flutter/features/authorizations/presentation/authorizations_list_page/widgets/authorization_list_search_text_field.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:watch_it/watch_it.dart';

final _authorizationManager = di<AuthorizationManager>();
final _pupilsFilter = di<PupilsFilter>();

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
        onRefresh: () async => _authorizationManager.fetchAuthorizations(),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
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
                            refreshFunction:
                                _authorizationManager.fetchAuthorizations),
                      ),
                      //---------------------------------
                      InkWell(
                        onTap: () {},

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

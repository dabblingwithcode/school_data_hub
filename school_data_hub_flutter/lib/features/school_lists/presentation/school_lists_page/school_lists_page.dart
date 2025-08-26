import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/filters/school_list_filter_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_lists_page/widgets/school_list_card.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_lists_page/widgets/school_list_search_text_field.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_lists_page/widgets/school_lists_bottom_navbar.dart';
import 'package:watch_it/watch_it.dart';

final _schoolListFilterManager = di<SchoolListFilterManager>();
final _schoolListManager = di<SchoolListManager>();

class SchoolListsPage extends WatchingWidget {
  const SchoolListsPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool filtersOn = watchValue((SchoolListFilterManager x) => x.filterState);
    // List<SchoolList> schoolLists =
    //     watchPropertyValue((SchoolListManager x) => x.schoolLists);
    // _schoolListFilterManager.updateFilteredSchoolLists(schoolLists);
    List<SchoolList> filteredSchoolLists =
        watchValue((SchoolListFilterManager x) => x.filteredSchoolLists);
    // List<SchoolList> visibleSchoolLists = schoolLists
    //     .where((element) =>
    //         element.visibility == 'public' ||
    //         element.createdBy == session.username ||
    //         element.visibility.contains(session.username!))
    //     .toList();

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.rule_rounded, size: 25, color: Colors.white),
            Gap(10),
            Text(
              'Listen',
              style: AppStyles.appBarTextStyle,
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => _schoolListManager.fetchSchoolLists(),
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
                        filteredSchoolLists.length.toString(),
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
                        child: SchoolListSearchTextField(
                            searchType: SearchType.list,
                            hintText: 'Liste suchen',
                            refreshFunction:
                                _schoolListManager.fetchSchoolLists),
                      ),
                      //---------------------------------
                      InkWell(
                        onTap: () {},

                        onLongPress: () =>
                            _schoolListFilterManager.resetFilters(),
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
                filteredSchoolLists.isEmpty
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
                          itemCount: filteredSchoolLists.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SchoolListCard(
                                schoolList: filteredSchoolLists[index]);
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const SchoolListsBottomNavBar(),
    );
  }
}

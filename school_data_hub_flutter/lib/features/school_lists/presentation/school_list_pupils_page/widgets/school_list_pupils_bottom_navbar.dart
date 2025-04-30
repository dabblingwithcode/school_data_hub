import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/paddings.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/filter_button.dart';
import 'package:school_data_hub_flutter/common/widgets/list_view_components/generic_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/select_pupils_list_page/select_pupils_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_list_pupils_page/widgets/school_list_pupil_filters_widget.dart';
import 'package:watch_it/watch_it.dart';

final _schoolListManager = di<SchoolListManager>();
final _serverpodSessionManager = di<ServerpodSessionManager>();
final _pupilManager = di<PupilManager>();

class SchoolListPupilsPageBottomNavBar extends StatelessWidget {
  final String listId;

  final List<int> pupilsInList;
  const SchoolListPupilsPageBottomNavBar(
      {required this.listId, required this.pupilsInList, super.key});

  @override
  Widget build(BuildContext context) {
    final schoolList = _schoolListManager.getSchoolListById(listId);
    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        height: 60,
        padding: const EdgeInsets.all(9),
        shape: null,
        color: AppColors.backgroundColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: <Widget>[
              const Spacer(),
              IconButton(
                tooltip: 'zurück',
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              if (schoolList.public != true ||
                  _serverpodSessionManager.userName == schoolList.createdBy)
                Row(
                  children: [
                    const Gap(30),
                    IconButton(
                        tooltip: 'Liste teilen',
                        onPressed: () async {
                          // TODO: UNCOMMENT THIS
                          // final String? visibility = await shortTextfieldDialog(
                          //     context: context,
                          //     title: 'Liste teilen mit...',
                          //     labelText: 'Kürzel eingeben',
                          //     hintText: 'Kürzel eingeben',
                          //     obscureText: false);
                          // if (visibility != null) {
                          //   _schoolListManager.updateSchoolListProperty(
                          //       listId, null, null, visibility);
                          // }
                        },
                        icon: const Icon(
                          Icons.share,
                          size: 30,
                        )),
                  ],
                ),
              const Gap(AppPaddings.bottomNavBarButtonGap),
              IconButton(
                tooltip: 'Kinder hinzufügen',
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ),
                onPressed: () async {
                  final List<int> selectedPupilIds =
                      await Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => SelectPupilsListPage(
                                selectablePupils: _pupilManager
                                    .pupilsNotListed(pupilsInList)),
                          )) ??
                          [];
                  // TODO: UNCOMMENT THIS
                  // if (selectedPupilIds.isNotEmpty) {
                  //   _schoolListManager.addPupilsToSchoolList(
                  //     listId,
                  //     selectedPupilIds,
                  //   );
                  // }
                },
              ),
              const Gap(AppPaddings.bottomNavBarButtonGap),
              FilterButton(
                  isSearchBar: false,
                  showBottomSheetFunction: () => showGenericFilterBottomSheet(
                        context: context,
                        filterList: [
                          const CommonPupilFiltersWidget(),
                          const SchoolListPupilFiltersWidget(),
                        ],
                      )),
              const Gap(15)
            ],
          ),
        ),
      ),
    );
  }
}

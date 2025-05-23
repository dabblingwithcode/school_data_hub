import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/paddings.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/authorizations/domain/authorization_manager.dart';
import 'package:school_data_hub_flutter/features/authorizations/presentation/authorization_pupils_page/widgets/authorization_pupils_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/select_pupils_list_page/select_pupils_list_page.dart';
import 'package:watch_it/watch_it.dart';

final _serverpodSessionManager = di<ServerpodSessionManager>();
final _authorizationManager = di<AuthorizationManager>();
final _pupilManager = di<PupilManager>();

class AuthorizationPupilsBottomNavBar extends WatchingWidget {
  final Authorization authorization;

  final List<int> pupilsInAuthorization;
  const AuthorizationPupilsBottomNavBar(
      {required this.pupilsInAuthorization,
      required this.authorization,
      super.key});

  @override
  Widget build(BuildContext context) {
    final filtersActive =
        watchValue((FiltersStateManager x) => x.filtersActive);
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
                  size: 35,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              if (di<ServerpodSessionManager>().userName ==
                      authorization.createdBy ||
                  _serverpodSessionManager.isAdmin) ...[
                const Gap(AppPaddings.bottomNavBarButtonGap),
                IconButton(
                    tooltip: 'Kinder hinzufügen',
                    icon: const Icon(Icons.add, color: Colors.white, size: 30),
                    onPressed: () async {
                      final List<int>? selectedPupilIds =
                          await Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => SelectPupilsListPage(
                            selectablePupils: di<PupilManager>()
                                .pupilsNotListed(pupilsInAuthorization)),
                      ));
                      if (selectedPupilIds == null) {
                        return;
                      }
                      if (selectedPupilIds.isNotEmpty) {
                        _authorizationManager.updateAuthorization(
                            authId: authorization.id!,
                            membersToUpdate: (
                              operation: MemberOperation.add,
                              pupilIds: selectedPupilIds
                            ));
                      }
                    })
              ],
              const Gap(AppPaddings.bottomNavBarButtonGap),
              InkWell(
                onTap: () => showAuthorizationPupilsFilterBottomSheet(context),
                onLongPress: () {
                  di<PupilsFilter>().resetFilters();
                },
                child: Icon(
                  Icons.filter_list,
                  color: filtersActive ? Colors.deepOrange : Colors.white,
                  size: 30,
                ),
              ),
              const Gap(15)
            ],
          ),
        ),
      ),
    );
  }
}

BottomAppBar authorizationPupilsBottomNavBar(
    BuildContext context,
    Authorization authorization,
    bool filtersOn,
    List<int> pupilsInAuthorization) {
  return BottomAppBar(
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
              size: 35,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const Gap(30),
          di<ServerpodSessionManager>().userName == authorization.createdBy
              ? IconButton(
                  tooltip: 'Kinder hinzufügen',
                  icon: const Icon(Icons.add, color: Colors.white, size: 30),
                  onPressed: () async {
                    final List<int>? selectedPupilIds =
                        await Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => SelectPupilsListPage(
                          selectablePupils: di<PupilManager>()
                              .pupilsNotListed(pupilsInAuthorization)),
                    ));
                    if (selectedPupilIds == null) {
                      return;
                    }
                    if (selectedPupilIds.isNotEmpty) {
                      _authorizationManager.updateAuthorization(
                          authId: authorization.id!,
                          membersToUpdate: (
                            operation: MemberOperation.add,
                            pupilIds: selectedPupilIds
                          ));
                    }
                  })
              : const SizedBox.shrink(),
          const Gap(10),
          InkWell(
            onTap: () => showAuthorizationPupilsFilterBottomSheet(context),
            onLongPress: () => di<PupilsFilter>().resetFilters(),
            child: Icon(
              Icons.filter_list,
              color: filtersOn ? Colors.deepOrange : Colors.white,
              size: 30,
            ),
          ),
          const Gap(10)
        ],
      ),
    ),
  );
}

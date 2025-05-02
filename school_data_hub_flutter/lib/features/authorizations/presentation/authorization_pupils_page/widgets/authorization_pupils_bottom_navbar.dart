import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/domain/filters/filters_state_manager.dart';
import 'package:schuldaten_hub/common/domain/session_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/theme/app_colors.dart';
import 'package:schuldaten_hub/common/theme/paddings.dart';
import 'package:schuldaten_hub/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:schuldaten_hub/features/authorizations/domain/authorization_manager.dart';
import 'package:schuldaten_hub/features/authorizations/domain/models/authorization.dart';
import 'package:schuldaten_hub/features/authorizations/presentation/authorization_pupils_page/widgets/authorization_pupils_filter_bottom_sheet.dart';
import 'package:schuldaten_hub/features/pupil/domain/filters/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/domain/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/presentation/select_pupils_list_page/select_pupils_list_page.dart';
import 'package:watch_it/watch_it.dart';

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
              if (locator<SessionManager>().credentials.value.username ==
                      authorization.createdBy ||
                  locator<SessionManager>().isAdmin.value) ...[
                const Gap(AppPaddings.bottomNavBarButtonGap),
                IconButton(
                    tooltip: 'Kinder hinzufügen',
                    icon: const Icon(Icons.add, color: Colors.white, size: 30),
                    onPressed: () async {
                      final List<int>? selectedPupilIds =
                          await Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => SelectPupilsListPage(
                            selectablePupils: locator<PupilManager>()
                                .pupilsNotListed(pupilsInAuthorization)),
                      ));
                      if (selectedPupilIds == null) {
                        return;
                      }
                      if (selectedPupilIds.isNotEmpty) {
                        locator<AuthorizationManager>().postPupilAuthorizations(
                            selectedPupilIds, authorization.authorizationId);
                      }
                    })
              ],
              const Gap(AppPaddings.bottomNavBarButtonGap),
              InkWell(
                onTap: () => showAuthorizationPupilsFilterBottomSheet(context),
                onLongPress: () {
                  locator<PupilsFilter>().resetFilters();
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
          locator<SessionManager>().credentials.value.username ==
                  authorization.createdBy
              ? IconButton(
                  tooltip: 'Kinder hinzufügen',
                  icon: const Icon(Icons.add, color: Colors.white, size: 30),
                  onPressed: () async {
                    final List<int>? selectedPupilIds =
                        await Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => SelectPupilsListPage(
                          selectablePupils: locator<PupilManager>()
                              .pupilsNotListed(pupilsInAuthorization)),
                    ));
                    if (selectedPupilIds == null) {
                      return;
                    }
                    if (selectedPupilIds.isNotEmpty) {
                      locator<AuthorizationManager>().postPupilAuthorizations(
                          selectedPupilIds, authorization.authorizationId);
                    }
                  })
              : const SizedBox.shrink(),
          const Gap(10),
          InkWell(
            onTap: () => showAuthorizationPupilsFilterBottomSheet(context),
            onLongPress: () => locator<PupilsFilter>().resetFilters(),
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

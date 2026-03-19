import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/pupil_profile_screen_content/after_school_care_content/pupil_profile_after_school_care_content.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/pupil_profile_screen_content/attendance_content/pupil_profile_attendance_content.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/pupil_profile_screen_content/authorization_content/pupil_profile_authorization_content.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/pupil_profile_screen_content/communication_content/pupil_profile_communication_content.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/pupil_profile_screen_content/credit/pupil_profile_credit_content.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/pupil_profile_screen_content/infos_content/pupil_profile_infos_content.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/pupil_profile_screen_content/learning_content/pupil_profile_learning_content.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/pupil_profile_screen_content/learning_support_content/pupil_profile_learning_support_content.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/pupil_profile_screen_content/school_list_content/pupil_school_lists_content_card.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/pupil_profile_screen_content/schoolday_events_content/pupil_profile_schoolday_events_content.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/widgets/pupil_profile_content_widgets.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';

class PupilProfilePageContent extends WatchingStatefulWidget {
  final PupilProxy pupil;

  const PupilProfilePageContent({required this.pupil, super.key});

  @override
  State<PupilProfilePageContent> createState() =>
      _PupilProfilePageContentState();
}

class _PupilProfilePageContentState extends State<PupilProfilePageContent> {
  static const _scopeName = 'pupil_profile_page';
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    di.pushNewScope(
      scopeName: _scopeName,
      init: (getIt) {
        getIt.registerSingleton<ProfileMinHeight>(ProfileMinHeight());
      },
    );
    final initialPage = di<BottomNavManager>().pupilProfileNavState.value;
    _pageController = PageController(initialPage: initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    di.popScope();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Sync nav bar tap → PageView
    registerHandler(
      select: (BottomNavManager x) => x.pupilProfileNavState,
      handler: (context, value, cancel) {
        if (_pageController.hasClients &&
            _pageController.page?.round() != value) {
          _pageController.animateToPage(
            value,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
    );

    return Container(
      decoration: BoxDecoration(color: Style.of(context).colors.canvas),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Set once so short pages fill the viewport.
          final profileMinHeight = di<ProfileMinHeight>();
          if (profileMinHeight.value == 0) {
            profileMinHeight.value = constraints.maxHeight - 5;
          }
          return PageView(
            controller: _pageController,
            onPageChanged: (index) =>
                di<BottomNavManager>().setPupilProfileNavPage(index),
            children: const [
              _ProfilePageWrapper(childBuilder: _ProfilePageChild.info),
              _ProfilePageWrapper(childBuilder: _ProfilePageChild.language),
              _ProfilePageWrapper(childBuilder: _ProfilePageChild.credit),
              _ProfilePageWrapper(childBuilder: _ProfilePageChild.attendance),
              _ProfilePageWrapper(childBuilder: _ProfilePageChild.schoolday),
              _ProfilePageWrapper(childBuilder: _ProfilePageChild.ogs),
              _ProfilePageWrapper(childBuilder: _ProfilePageChild.lists),
              _ProfilePageWrapper(childBuilder: _ProfilePageChild.auth),
              _ProfilePageWrapper(childBuilder: _ProfilePageChild.learningSup),
              _ProfilePageWrapper(childBuilder: _ProfilePageChild.learning),
            ],
          );
        },
      ),
    );
  }
}

enum _ProfilePageChild {
  info,
  language,
  credit,
  attendance,
  schoolday,
  ogs,
  lists,
  auth,
  learningSup,
  learning,
}

class _ProfilePageWrapper extends StatefulWidget {
  final _ProfilePageChild childBuilder;
  const _ProfilePageWrapper({required this.childBuilder});

  @override
  State<_ProfilePageWrapper> createState() => _ProfilePageWrapperState();
}

class _ProfilePageWrapperState extends State<_ProfilePageWrapper> {
  @override
  Widget build(BuildContext context) {
    final PupilProxy pupil = (context as Element)
        .findAncestorWidgetOfExactType<PupilProfilePageContent>()!
        .pupil;

    Widget child;
    switch (widget.childBuilder) {
      case _ProfilePageChild.info:
        child = PupilProfileInfosContent(pupil: pupil);
        break;
      case _ProfilePageChild.language:
        child = PupilProfileCommunicationContent(pupil: pupil);
        break;
      case _ProfilePageChild.credit:
        child = PupilProfileCreditContent(pupil: pupil);
        break;
      case _ProfilePageChild.attendance:
        child = PupilAttendanceContent(pupil: pupil);
        break;
      case _ProfilePageChild.schoolday:
        child = PupilProfileSchooldayEventsContent(pupil: pupil);
        break;
      case _ProfilePageChild.ogs:
        child = PupilProfileAfterSchoolCareContent(pupil: pupil);
        break;
      case _ProfilePageChild.lists:
        child = PupilProfileSchoolListsContentCard(pupil: pupil);
        break;
      case _ProfilePageChild.auth:
        child = PupilProfileAuthorizationContent(pupil: pupil);
        break;
      case _ProfilePageChild.learningSup:
        child = PupilProfileLearningSupportContent(pupil: pupil);
        break;
      case _ProfilePageChild.learning:
        child = PupilLearningContent(pupil: pupil);
        break;
    }

    // ScrollConfiguration disables the auto-added Scrollbar on desktop.
    // Without this, during a PageView swipe both transitioning pages briefly
    // attach their primary ScrollViews to the same PrimaryScrollController,
    // causing the Scrollbar to crash: "attached to more than one ScrollPosition".
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: Builder(
        builder: (context) {
          return RefreshIndicator(
            onRefresh: () async =>
                di<PupilProxyManager>().updatePupilData(pupil.pupilId),
            child: CustomScrollView(
              key: PageStorageKey(widget.childBuilder.index),
              slivers: [
                SliverOverlapInjector(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                    context,
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  sliver: SliverToBoxAdapter(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: di<ProfileMinHeight>().value,
                      ),
                      child: child,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

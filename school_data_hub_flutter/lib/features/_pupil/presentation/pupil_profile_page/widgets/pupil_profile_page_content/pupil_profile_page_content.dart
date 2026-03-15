import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/after_school_care_content/pupil_after_school_care_content.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/attendance_content/pupil_profile_attendance_content.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/authorization_content/pupil_profile_authorization_content.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/communication_content/pupil_profile_communication_content.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/credit/pupil_profile_credit_content.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/infos_content/pupil_profile_infos_content.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/learning_content/pupil_profile_learning_content.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/learning_support_content/pupil_profile_learning_support_content.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/school_list_content/pupil_school_lists_content_card.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/schoolday_events_content/pupil_profile_schoolday_events_content.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';

class PupilProfilePageContent extends WatchingStatefulWidget {
  final PupilProxy pupil;

  const PupilProfilePageContent({required this.pupil, super.key});

  @override
  State<PupilProfilePageContent> createState() =>
      _PupilProfilePageContentState();
}

class _PupilProfilePageContentState extends State<PupilProfilePageContent> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    final initialPage = di<BottomNavManager>().pupilProfileNavState.value;
    _pageController = PageController(initialPage: initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
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
      decoration: BoxDecoration(color: AppColors.pupilProfileBackgroundColor),
      child: PageView(
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

class _ProfilePageWrapper extends StatelessWidget {
  final _ProfilePageChild childBuilder;
  const _ProfilePageWrapper({required this.childBuilder});

  @override
  Widget build(BuildContext context) {
    final PupilProxy pupil = (context as Element)
        .findAncestorWidgetOfExactType<PupilProfilePageContent>()!
        .pupil;

    Widget child;
    switch (childBuilder) {
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
        child = PupilOgsContent(pupil: pupil);
        break;
      case _ProfilePageChild.lists:
        child = PupilSchoolListsContentCard(pupil: pupil);
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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(borderRadius: BorderRadius.circular(16), child: child),
      ),
    );
  }
}

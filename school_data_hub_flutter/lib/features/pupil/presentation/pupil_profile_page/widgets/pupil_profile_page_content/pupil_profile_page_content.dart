import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/after_school_care_content/pupil_after_school_care_content.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/attendance_content/pupil_profile_attendance_content.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/authorization_content/pupil_profile_authorization_content.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/communication_content/pupil_profile_communication_content.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/credit/pupil_profile_credit_content.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/infos_content/pupil_profile_infos_content.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/learning_content/pupil_profile_learning_content.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/learning_support_content/pupil_profile_learning_support_content.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/school_list_content/pupil_school_lists_content_card.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/schoolday_events_content/pupil_profile_schoolday_events_content.dart';
import 'package:watch_it/watch_it.dart';

class PupilProfilePageContent extends WatchingWidget {
  final PupilProxy pupil;

  const PupilProfilePageContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    int navState = watchValue((BottomNavManager x) => x.pupilProfileNavState);

    final children = [
      const _ProfilePageWrapper(childBuilder: _ProfilePageChild.info),
      const _ProfilePageWrapper(childBuilder: _ProfilePageChild.language),
      const _ProfilePageWrapper(childBuilder: _ProfilePageChild.credit),
      const _ProfilePageWrapper(childBuilder: _ProfilePageChild.attendance),
      const _ProfilePageWrapper(childBuilder: _ProfilePageChild.schoolday),
      const _ProfilePageWrapper(childBuilder: _ProfilePageChild.ogs),
      const _ProfilePageWrapper(childBuilder: _ProfilePageChild.lists),
      const _ProfilePageWrapper(childBuilder: _ProfilePageChild.auth),
      const _ProfilePageWrapper(childBuilder: _ProfilePageChild.learningSup),
      const _ProfilePageWrapper(childBuilder: _ProfilePageChild.learning),
    ];

    return Container(
      decoration: BoxDecoration(color: AppColors.pupilProfileBackgroundColor),
      child: Padding(
        padding: const EdgeInsets.only(left: 4, right: 4, bottom: 10),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: KeyedSubtree(
            key: ValueKey(navState),
            child: children[navState],
          ),
        ),
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

    return Container(
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
    );
  }
}

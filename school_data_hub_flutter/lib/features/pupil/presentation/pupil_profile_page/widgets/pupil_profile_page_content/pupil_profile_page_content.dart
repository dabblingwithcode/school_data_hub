import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_navigation.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/infos_content/pupil_profile_infos_content.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_profile_authorizations_content.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_profile_communication_content.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_profile_credit_content.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_schoolday_events_content.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/widgets/school_list_content/pupil_school_lists_content.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/pupil_profile_attendance_content.dart';
import 'package:watch_it/watch_it.dart';

class PupilProfilePageContent extends WatchingWidget {
  final PupilProxy pupil;

  const PupilProfilePageContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    int navState =
        watchValue((MainMenuBottomNavManager x) => x.pupilProfileNavState);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          if (navState == ProfileNavigationState.info.value)
            PupilInfosContent(pupil: pupil),
          if (navState == ProfileNavigationState.language.value)
            PupilCommunicationContent(pupil: pupil),
          if (navState == ProfileNavigationState.credit.value)
            PupilCreditContent(pupil: pupil),
          if (navState == ProfileNavigationState.attendance.value)
            PupilAttendanceContent(pupil: pupil),
          if (navState == ProfileNavigationState.schooldayEvent.value)
            PupilSchooldayEventsContent(pupil: pupil),
          // if (navState == 5) PupilOgsContent(pupil: pupil),
          if (navState == ProfileNavigationState.lists.value)
            PupilSchoolListsContent(pupil: pupil),
          if (navState == ProfileNavigationState.authorization.value)
            PupilAuthorizationsContent(pupil: pupil),
          // if (navState == 8) PupilLearningSupportContent(pupil: pupil),
          // if (navState == 9) PupilLearningContent(pupil: pupil),
          const Gap(20),
        ],
      ),
    );
  }
}

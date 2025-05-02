import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/infos_content/pupil_profile_infos_content.dart';
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
          if (navState == 0) PupilInfosContent(pupil: pupil),
          if (navState == 1) PupilCommunicationContent(pupil: pupil),
          if (navState == 2) PupilCreditContent(pupil: pupil),
          if (navState == 3) PupilAttendanceContent(pupil: pupil),
          if (navState == 4) PupilSchooldayEventsContent(pupil: pupil),
          // if (navState == 5) PupilOgsContent(pupil: pupil),
          if (navState == 6) PupilSchoolListsContent(pupil: pupil),
          // if (navState == 7) PupilAuthorizationsContent(pupil: pupil),
          // if (navState == 8) PupilLearningSupportContent(pupil: pupil),
          // if (navState == 9) PupilLearningContent(pupil: pupil),
          const Gap(20),
        ],
      ),
    );
  }
}

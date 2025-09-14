import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_navigation.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/authorization_content/pupil_profile_authorization_content.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/communication_content/pupil_profile_communication_content.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/credit/pupil_profile_credit_content.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/infos_content/pupil_profile_infos_content.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/learning_content/pupil_profile_learning_content.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/learning_support_content/pupil_profile_learning_support_content.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/school_list_content/pupil_school_lists_content_card.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/schoolday_events_content/pupil_profile_schoolday_events_content.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/pupil_profile_attendance_content.dart';
import 'package:watch_it/watch_it.dart';

class PupilProfilePageContent extends WatchingWidget {
  final PupilProxy pupil;

  const PupilProfilePageContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    int navState = watchValue((BottomNavManager x) => x.pupilProfileNavState);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.pupilProfileBackgroundColor,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 4,
            right: 4,
            bottom: 8.0,
          ), // Reduced padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Add animated transition for content switching
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.1, 0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: _buildContentForState(navState),
              ),
              const Gap(16), // Reduced from 32 to 16
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentForState(int navState) {
    // Use a key to ensure AnimatedSwitcher recognizes content changes
    final contentKey = ValueKey(navState);

    return Container(
      key: contentKey,
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: _getContentWidget(navState),
      ),
    );
  }

  Widget _getContentWidget(int navState) {
    if (navState == ProfileNavigationState.info.value) {
      return PupilProfileInfosContent(pupil: pupil);
    } else if (navState == ProfileNavigationState.language.value) {
      return PupilProfileCommunicationContent(pupil: pupil);
    } else if (navState == ProfileNavigationState.credit.value) {
      return PupilProfileCreditContent(pupil: pupil);
    } else if (navState == ProfileNavigationState.attendance.value) {
      return PupilAttendanceContent(pupil: pupil);
    } else if (navState == ProfileNavigationState.schooldayEvent.value) {
      return PupilProfileSchooldayEventsContent(pupil: pupil);
    } else if (navState == ProfileNavigationState.lists.value) {
      return PupilSchoolListsContentCard(pupil: pupil);
    } else if (navState == ProfileNavigationState.authorization.value) {
      return PupilProfileAuthorizationContent(pupil: pupil);
    } else if (navState == ProfileNavigationState.learningSupport.value) {
      return PupilProfileLearningSupportContent(pupil: pupil);
    } else if (navState == ProfileNavigationState.learning.value) {
      return PupilLearningContent(pupil: pupil);
    } else {
      return PupilProfileInfosContent(pupil: pupil);
    }
  }
}

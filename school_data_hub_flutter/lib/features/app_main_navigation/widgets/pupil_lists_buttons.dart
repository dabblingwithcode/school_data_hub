import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/attendance_page/attendance_list_page.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/missed_classes_pupil_list_page/missed_classes_pupil_list_page.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_page/schoolday_event_list_page.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/widgets/main_menu_button.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_competence_list_page/learning_pupil_list_page.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/learning_support_list_page/learning_support_list_page.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_page/matrix_users_list_page.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/pupil_matrix_contacts_list_page/pupils_matrix_contacts_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/after_school_care/after_school_care_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/_credit/credit_list_page/credit_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/family_language_lessons_page/family_language_lessons_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/religion_page/religion_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/special_info_page/special_info_list_page.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';
import 'package:watch_it/watch_it.dart';

class PupilListButtons extends WatchingWidget {
  final double screenWidth;
  const PupilListButtons({required this.screenWidth, super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    // Always call watch methods at the top level, not conditionally

    final isReady = watchPropertyValue((HubSessionManager x) => x.isReady);

    final matrixSessionConfigured = watchPropertyValue(
      (HubSessionManager x) => x.isMatrixSessionConfigured,
    );

    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        MainMenuButton(
          destinationPage: const SchooldayEventListPage(),
          buttonIcon: const Icon(
            Icons.warning_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: locale.schooldayEvents,
        ),
        MainMenuButton(
          destinationPage: const MissedSchooldayesPupilListPage(),
          buttonIcon: const Icon(
            Icons.calendar_month_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: locale.missedSchooldays,
        ),
        MainMenuButton(
          destinationPage: const AttendanceListPage(),
          buttonIcon: const Icon(
            Icons.event_available_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: locale.attendance,
        ),
        MainMenuButton(
          destinationPage: const CreditListPage(),
          buttonIcon: const Icon(
            Icons.attach_money_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: locale.pupilCredit,
        ),
        if (isReady)
          MainMenuButton(
            destinationPage: const LearningPupilListPage(),
            buttonIcon: const Icon(
              Icons.lightbulb,
              size: 50,
              color: AppColors.gridViewColor,
            ),
            buttonText: locale.learningLists,
          ),
        MainMenuButton(
          destinationPage: const LearningSupportListPage(),
          buttonIcon: const Icon(
            Icons.support_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: locale.supportLists,
        ),
        MainMenuButton(
          destinationPage: const SpecialInfoListPage(),
          buttonIcon: const Icon(
            Icons.emergency_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: locale.specialInfo,
        ),
        const MainMenuButton(
          destinationPage: const ReligionListPage(),
          buttonIcon: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.mosque_rounded,
                size: 50,
                color: AppColors.gridViewColor,
              ),
              Icon(
                Icons.church_rounded,
                size: 50,
                color: AppColors.gridViewColor,
              ),
            ],
          ),
          buttonText: 'Reli-Unterricht',
        ),
        const MainMenuButton(
          destinationPage: const FamilyLanguageLessonsListPage(),
          buttonIcon: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.translate_rounded,
                size: 50,
                color: AppColors.gridViewColor,
              ),
            ],
          ),
          buttonText: 'HSU',
        ),
        MainMenuButton(
          destinationPage: const OgsListPage(),
          buttonIcon: Text(
            locale.allDayCare,
            style: const TextStyle(
              fontSize: 35,
              color: AppColors.gridViewColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          buttonText: locale.allDayCare,
        ),
        if (matrixSessionConfigured)
          MainMenuButton(
            destinationPage: const MatrixUsersListPage(),
            buttonIcon: const Icon(
              Icons.chat_rounded,
              size: 50,
              color: AppColors.gridViewColor,
            ),
            buttonText: locale.matrixRooms,
          ),
        const MainMenuButton(
          destinationPage: PupilsMatrixContactsListPage(),
          buttonIcon: Icon(
            Icons.group,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: 'Matrix Kontakte',
        ),
      ],
    );
  }
}

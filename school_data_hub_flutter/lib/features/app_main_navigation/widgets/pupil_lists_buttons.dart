import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/widgets/main_menu_button.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/attendance_page/attendance_list_page.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/missed_classes_pupil_list_page/missed_classes_pupil_list_page.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/learning_support_list_page/learning_support_list_page.dart';
import 'package:school_data_hub_flutter/features/matrix/presentation/matrix_users_list_page/matrix_users_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/credit/credit_list_page/credit_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/special_info_page/special_info_list_page.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/presentation/schoolday_event_list_page/schoolday_event_list_page.dart';
import 'package:watch_it/watch_it.dart';

class PupilListButtons extends WatchingWidget {
  final double screenWidth;
  const PupilListButtons({required this.screenWidth, super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    bool matrixSessionConfigured = watchPropertyValue(
        (ServerpodSessionManager x) => x.matrixPolicyManagerRegistrationStatus);
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
            buttonText: locale.schooldayEvents),
        MainMenuButton(
            destinationPage: const MissedClassesPupilListPage(),
            buttonIcon: const Icon(
              Icons.calendar_month_rounded,
              size: 50,
              color: AppColors.gridViewColor,
            ),
            buttonText: locale.missedClasses),
        MainMenuButton(
            destinationPage: const AttendanceListPage(),
            buttonIcon: const Icon(
              Icons.event_available_rounded,
              size: 50,
              color: AppColors.gridViewColor,
            ),
            buttonText: locale.attendance),
        MainMenuButton(
            destinationPage: const CreditListPage(),
            buttonIcon: const Icon(
              Icons.attach_money_rounded,
              size: 50,
              color: AppColors.gridViewColor,
            ),
            buttonText: locale.pupilCredit),
        MainMenuButton(
            destinationPage:
                const Placeholder(), // const LearningPupilListPage(),
            buttonIcon: const Icon(
              Icons.lightbulb,
              size: 50,
              color: AppColors.gridViewColor,
            ),
            buttonText: locale.learningLists),
        MainMenuButton(
            destinationPage: const LearningSupportListPage(),
            buttonIcon: const Icon(
              Icons.support_rounded,
              size: 50,
              color: AppColors.gridViewColor,
            ),
            buttonText: locale.supportLists),
        MainMenuButton(
            destinationPage: const SpecialInfoListPage(),
            buttonIcon: const Icon(
              Icons.emergency_rounded,
              size: 50,
              color: AppColors.gridViewColor,
            ),
            buttonText: locale.specialInfo),
        MainMenuButton(
            destinationPage: const Placeholder(), // const OgsListPage(),
            buttonIcon: Text(
              locale.allDayCare,
              style: const TextStyle(
                  fontSize: 35,
                  color: AppColors.gridViewColor,
                  fontWeight: FontWeight.bold),
            ),
            buttonText: locale.allDayCare),
        if (matrixSessionConfigured)
          MainMenuButton(
              destinationPage: const MatrixUsersListPage(),
              buttonIcon: const Icon(
                Icons.chat_rounded,
                size: 50,
                color: AppColors.gridViewColor,
              ),
              buttonText: locale.matrixRooms),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/widgets/main_menu_button.dart';
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
          destinationRoute: '/pupil/schoolday-events',
          buttonIcon: const Icon(
            Icons.warning_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: locale.schooldayEvents,
        ),
        MainMenuButton(
          destinationRoute: '/pupil/missed-schooldays',
          buttonIcon: const Icon(
            Icons.calendar_month_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: locale.missedSchooldays,
        ),
        MainMenuButton(
          destinationRoute: '/pupil/attendance',
          buttonIcon: const Icon(
            Icons.event_available_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: locale.attendance,
        ),
        MainMenuButton(
          destinationRoute: '/pupil/credit',
          buttonIcon: const Icon(
            Icons.attach_money_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: locale.pupilCredit,
        ),
        if (isReady)
          MainMenuButton(
            destinationRoute: '/pupil/learning-lists',
            buttonIcon: const Icon(
              Icons.lightbulb,
              size: 50,
              color: AppColors.gridViewColor,
            ),
            buttonText: locale.learningLists,
          ),
        MainMenuButton(
          destinationRoute: '/pupil/support-lists',
          buttonIcon: const Icon(
            Icons.support_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: locale.supportLists,
        ),
        MainMenuButton(
          destinationRoute: '/pupil/special-info',
          buttonIcon: const Icon(
            Icons.emergency_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: locale.specialInfo,
        ),
        const MainMenuButton(
          destinationRoute: '/pupil/religion',
          buttonIcon: Row(
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
          destinationRoute: '/pupil/family-language',
          buttonIcon: Row(
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
          destinationRoute: '/pupil/ogs',
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
            destinationRoute: '/pupil/matrix-users',
            buttonIcon: const Icon(
              Icons.chat_rounded,
              size: 50,
              color: AppColors.gridViewColor,
            ),
            buttonText: locale.matrixRooms,
          ),
        const MainMenuButton(
          destinationRoute: '/pupil/matrix-contacts',
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

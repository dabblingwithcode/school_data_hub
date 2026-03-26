import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/widgets/birthday_date_range_dialog.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/widgets/main_menu_button.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';

class PupilListButtons extends WatchingWidget {
  const PupilListButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    // Always call watch methods at the top level, not conditionally

    final isReady = watchPropertyValue((HubSessionManager x) => x.isReady);

    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        MainMenuButton(
          routePath: RoutePaths.pupilSchooldayEvents,
          buttonIcon: Icon(
            Icons.warning_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: locale.schooldayEvents,
        ),
        MainMenuButton(
          routePath: RoutePaths.pupilMissedSchooldays,
          buttonIcon: Icon(
            Icons.calendar_month_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: locale.missedSchooldays,
        ),
        MainMenuButton(
          routePath: RoutePaths.pupilAttendance,
          buttonIcon: Icon(
            Icons.event_available_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: locale.attendance,
        ),
        MainMenuButton(
          routePath: RoutePaths.pupilCredit,
          buttonIcon: Icon(
            Icons.attach_money_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: locale.pupilCredit,
        ),
        if (isReady)
          MainMenuButton(
            routePath: RoutePaths.learningPupilList,
            buttonIcon: Icon(
              Icons.lightbulb,
              size: 50,
              color: AppColors.gridViewColor,
            ),
            buttonText: locale.learningLists,
          ),
        MainMenuButton(
          routePath: RoutePaths.pupilLearningSupport,
          buttonIcon: Icon(
            Icons.support_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: locale.supportLists,
        ),
        MainMenuButton(
          routePath: RoutePaths.pupilSpecialInfo,
          buttonIcon: Icon(
            Icons.emergency_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: locale.specialInfo,
        ),
        MainMenuButton(
          routePath: RoutePaths.pupilReligion,
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
        MainMenuButton(
          routePath: RoutePaths.pupilFamilyLanguage,
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
          routePath: RoutePaths.pupilAfterSchoolCare,
          buttonIcon: Text(
            locale.allDayCare,
            style: TextStyle(
              fontSize: 35,
              color: AppColors.gridViewColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          buttonText: locale.allDayCare,
        ),
        MainMenuButton(
          routePath: RoutePaths.pupilPublicMediaAuth,
          buttonIcon: Icon(
            Icons.shield,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: 'Einwilligung\nMedien',
        ),
        MainMenuButton(
          routePath: RoutePaths.pupilMatrixContacts,
          buttonIcon: Icon(
            Icons.group,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: 'Matrix Kontakte',
        ),
        MainMenuButton(
          onTap: () async {
            final result =
                await showDialog<
                  ({DateTime pastDayValue, DateTime futureDayValue})?
                >(
                  context: context,
                  builder: (ctx) => const BirthdayDateRangeDialog(),
                );
            if (result == null) return;
            if (context.mounted) {
              context.push(
                RoutePaths.pupilBirthdays,
                extra: {
                  'selectedDate': result.pastDayValue,
                  'endDate': result.futureDayValue,
                },
              );
            }
          },
          buttonIcon: Icon(
            Icons.cake_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: 'Geburtstage',
        ),
      ],
    );
  }
}

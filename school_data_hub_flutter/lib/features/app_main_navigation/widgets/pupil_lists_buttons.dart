import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/attendance_page/attendance_list_page.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/missed_schooldays_pupil_list_page/missed_schooldays_pupil_list_page.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_page/schoolday_event_list_page.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/widgets/main_menu_button.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_list_learning_page/pupil_list_learning_page.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/learning_support_list_page/learning_support_list_page.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_page/matrix_users_list_page.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/pupil_matrix_contacts_list_page/pupils_matrix_contacts_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/_credit/credit_list_page/credit_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/after_school_care/after_school_care_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/birthdays_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/family_language_lessons_page/family_language_lessons_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/religion_page/religion_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/special_info_page/special_info_list_page.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';

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
          buttonIcon: Icon(
            Icons.warning_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: locale.schooldayEvents,
        ),
        MainMenuButton(
          destinationPage: const MissedSchooldaysPupilListPage(),
          buttonIcon: Icon(
            Icons.calendar_month_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: locale.missedSchooldays,
        ),
        MainMenuButton(
          destinationPage: const AttendanceListPage(),
          buttonIcon: Icon(
            Icons.event_available_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: locale.attendance,
        ),
        MainMenuButton(
          destinationPage: const CreditListPage(),
          buttonIcon: Icon(
            Icons.attach_money_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: locale.pupilCredit,
        ),
        if (isReady)
          MainMenuButton(
            destinationPage: const PupilListLearningPage(),
            buttonIcon: Icon(
              Icons.lightbulb,
              size: 50,
              color: AppColors.gridViewColor,
            ),
            buttonText: locale.learningLists,
          ),
        MainMenuButton(
          destinationPage: const LearningSupportListPage(),
          buttonIcon: Icon(
            Icons.support_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: locale.supportLists,
        ),
        MainMenuButton(
          destinationPage: const SpecialInfoListPage(),
          buttonIcon: Icon(
            Icons.emergency_rounded,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: locale.specialInfo,
        ),
        MainMenuButton(
          destinationPage: const ReligionListPage(),
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
          destinationPage: const FamilyLanguageLessonsListPage(),
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
          destinationPage: const OgsListPage(),
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
        if (matrixSessionConfigured)
          MainMenuButton(
            destinationPage: const MatrixUsersListPage(),
            buttonIcon: Icon(
              Icons.chat_rounded,
              size: 50,
              color: AppColors.gridViewColor,
            ),
            buttonText: locale.matrixRooms,
          ),
        MainMenuButton(
          destinationPage: const PupilsMatrixContactsListPage(),
          buttonIcon: Icon(
            Icons.group,
            size: 50,
            color: AppColors.gridViewColor,
          ),
          buttonText: 'Matrix Kontakte',
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            onTap: () async {
              final result = await showDialog<(DateTime, DateTime)>(
                context: context,
                builder: (ctx) => const _BirthdayDateRangeDialog(),
              );
              if (result == null) return;
              if (context.mounted) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => BirthdaysView(
                      selectedDate: result.$1,
                      endDate: result.$2,
                    ),
                  ),
                );
              }
            },
            child: SizedBox(
              width: 150,
              height: 150,
              child: Card(
                color: AppColors.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cake_rounded,
                      size: 50,
                      color: AppColors.gridViewColor,
                    ),
                    const Gap(10),
                    const Text(
                      'Geburtstage',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BirthdayDateRangeDialog extends WatchingWidget {
  const _BirthdayDateRangeDialog();

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final pastDate = createOnce(() => ValueNotifier<DateTime>(now));
    final futureDate = createOnce(() => ValueNotifier<DateTime>(now));

    final pastDateValue = watch(pastDate).value;
    final futureDateValue = watch(futureDate).value;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cake_rounded,
                  size: 20,
                  color: AppColors.accentColor,
                ),
                const Gap(10),
                Text(
                  'Geburtstage',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundColor,
                  ),
                ),
              ],
            ),
            const Gap(20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('von ', style: TextStyle(fontSize: 16)),
                InkWell(
                  onTap: () async {
                    final selected = await showDatePicker(
                      context: context,
                      initialDate: pastDateValue,
                      firstDate: DateTime(now.year - 1, now.month, now.day),
                      lastDate: now,
                    );
                    if (selected != null) {
                      pastDate.value = selected;
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      pastDateValue == now
                          ? 'Heute'
                          : pastDateValue.formatDateForUser(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('bis  ', style: TextStyle(fontSize: 16)),
                InkWell(
                  onTap: () async {
                    final selected = await showDatePicker(
                      context: context,
                      initialDate: futureDateValue,
                      firstDate: now,
                      lastDate: DateTime(now.year + 1, now.month, now.day),
                    );
                    if (selected != null) {
                      futureDate.value = selected;
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      futureDateValue == now
                          ? 'Heute'
                          : futureDateValue.formatDateForUser(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(20),
            ElevatedButton(
              style: AppStyles.actionButtonStyle,
              onPressed: () {
                Navigator.of(context).pop((pastDateValue, futureDateValue));
              },
              child: const Text('Anzeigen', style: AppStyles.buttonTextStyle),
            ),
          ],
        ),
      ),
    );
  }
}

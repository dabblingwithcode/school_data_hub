import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/widgets/pupil_learning_content_expansion_tile_nav_bar.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_profile_content_widgets.dart';
import 'package:watch_it/watch_it.dart';

class PupilLearningContent extends WatchingWidget {
  final PupilProxy pupil;
  const PupilLearningContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    watch(pupil);
    return Container(
      decoration: BoxDecoration(color: AppColors.pupilProfileBackgroundColor),
      child: Column(
        children: [
          PupilProfileContentSection(
            icon: Icons.lightbulb,
            title: 'Lernen',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Gap(5),
                    const Text('3 Jahre Eingangsphase?'),
                    const Gap(5),
                    InkWell(
                      onTap: () async {
                        final date = await showCalendarDatePicker2Dialog(
                          context: context,
                          config: CalendarDatePicker2WithActionButtonsConfig(
                            // selectableDayPredicate: (day) =>
                            //     !schooldayDates.any((element) => element.isSameDate(day)),
                            calendarType: CalendarDatePicker2Type.single,
                          ),
                          dialogSize: const Size(325, 400),
                          value: [], //schooldayDates,
                          borderRadius: BorderRadius.circular(15),
                        );

                        if (date != null && date.isNotEmpty) {
                          di<PupilManager>().updateSchoolyearHeldBackDate(
                            pupilId: pupil.pupilId,
                            date: (value: date.first!.toUtc()),
                          );
                        }
                      },
                      onLongPress: () async {
                        if (pupil.schoolyearHeldBackAt == null) return;
                        final confirmation = await confirmationDialog(
                          context: context,
                          title: 'Eintrag löschen',
                          message: 'Eintrag wirklich löschen?',
                        );
                        if (confirmation != true) return;
                        di<PupilManager>().updateSchoolyearHeldBackDate(
                          pupilId: pupil.internalId,
                          date: (value: null),
                        );
                      },
                      child: Text(
                        pupil.schoolyearHeldBackAt != null
                            ? 'Entscheidung vom ${pupil.schoolyearHeldBackAt!.formatDateForUser()}'
                            : 'nein',
                        style: TextStyle(
                          color: AppColors.interactiveColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const Gap(5),
                Row(
                  children: [
                    const Gap(5),
                    const Text('Klassenleitung:'),
                    const Gap(5),
                    Text(
                      pupil.groupTutor ?? 'Kein Eintrag',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                if (pupil.familyLanguageLessonsSince != null) ...[
                  const Gap(5),
                  Row(
                    children: [
                      const Gap(5),
                      const Text('HSU seit:'),
                      const Gap(5),
                      Text(
                        pupil.familyLanguageLessonsSince?.formatDateForUser() ??
                            'Kein Eintrag',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(pupil.language),
                    ],
                  ),
                ],
                if (pupil.religionLessonsSince != null) ...[
                  const Gap(5),
                  Row(
                    children: [
                      const Gap(5),
                      const Text('Religionsunterricht seit:'),
                      const Gap(5),
                      Text(
                        pupil.religionLessonsSince?.formatDateForUser() ??
                            'Kein Eintrag',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Gap(5),
                      Text(pupil.religion ?? 'Kein Eintrag'),
                    ],
                  ),
                ],
                const Gap(10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [CompetenceChecksBadges(pupil: pupil)],
                // ),
                PupilLearningContentExpansionTileNavBar(pupil: pupil),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

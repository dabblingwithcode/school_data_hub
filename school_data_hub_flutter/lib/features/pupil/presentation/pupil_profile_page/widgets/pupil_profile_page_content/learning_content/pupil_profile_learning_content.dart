import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/paddings.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_competence_list_page/widgets/pupil_competence_checks/competence_checks_badges.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/widgets/pupil_learning_content_expansion_tile_nav_bar.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

class PupilLearningContent extends StatelessWidget {
  final PupilProxy pupil;
  const PupilLearningContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.pupilProfileCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: AppPaddings.pupilProfileCardPadding,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Icon(
              Icons.lightbulb,
              color: AppColors.accentColor,
              size: 24,
            ),
            Gap(5),
            Text('Lernen',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.backgroundColor,
                ))
          ]),
          const Gap(10),
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
                        date: (value: date.first!.toUtc()));
                  }
                },
                onLongPress: () async {
                  if (pupil.schoolyearHeldBackAt == null) return;
                  final confirmation = await confirmationDialog(
                      context: context,
                      title: 'Eintrag löschen',
                      message: 'Eintrag wirklich löschen?');
                  if (confirmation != true) return;
                  di<PupilManager>().updateSchoolyearHeldBackDate(
                      pupilId: pupil.internalId, date: (value: null));
                },
                child: Text(
                  pupil.schoolyearHeldBackAt != null
                      ? 'Entscheidung vom ${pupil.schoolyearHeldBackAt!.formatForUser()}'
                      : 'nein',
                  style: const TextStyle(
                    color: AppColors.interactiveColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CompetenceChecksBadges(pupil: pupil),
            ],
          ),
          PupilLearningContentExpansionTileNavBar(
            pupil: pupil,
          ),
        ]),
      ),
    );
  }
}

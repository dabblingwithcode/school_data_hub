import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/pupil_profile_page_content/learning_content/pupil_learning_content_expansion_tile_nav_bar.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_content_widgets.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_helper.dart';

enum SchoolTransitionRecommendation {
  rGy(key: 'R/GY', value: 'Realschule/Gymnasium(eingeschänkt)'),
  hR(key: 'H/R', value: 'Hauptschule/Realschule(eingeschränkt)'),
  h(key: 'H', value: 'Hauptschule'),
  r(key: 'R', value: 'Realschule'),
  gy(key: 'GY', value: 'Gymnasium'),
  none(key: 'OHN', value: 'Ohne Schulübergangsvorschlag');

  final String key;
  final String value;
  const SchoolTransitionRecommendation({
    required this.key,
    required this.value,
  });
}

class PupilLearningContent extends WatchingWidget {
  final PupilProxy pupil;
  const PupilLearningContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    watch(pupil);
    return PupilProfileContentCard(
      icon: Icons.lightbulb,
      iconColor: const Color.fromARGB(255, 241, 149, 27),
      title: 'Lernen',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PupilProfileContentSectionStart(
            label: 'Klassenleitung:',
            value: pupil.groupTutor != null
                ? UserHelper.getUserByUserName(
                        pupil.groupTutor!,
                      )?.userInfo?.fullName ??
                      pupil.groupTutor!
                : 'Kein Eintrag',
          ),
          PupilProfileContentSectionInside(
            icon: Icons.abc,
            label: '3 Jahre Eingangsphase?',
            value: pupil.schoolyearHeldBackAt != null ? 'Ja' : 'Nein',
            onTap: () async {
              final date = await showCalendarDatePicker2Dialog(
                context: context,
                config: CalendarDatePicker2WithActionButtonsConfig(
                  calendarType: CalendarDatePicker2Type.single,
                ),
                dialogSize: const Size(325, 400),
                value: [],
                borderRadius: BorderRadius.circular(15),
              );

              if (date != null && date.isNotEmpty) {
                di<PupilProxyManager>().updateSchoolyearHeldBackDate(
                  pupilId: pupil.pupilId,
                  date: (value: date.first!.toUtc()),
                );
              }
            },
          ),
          if (pupil.familyLanguageLessonsSince != null)
            PupilProfileContentSectionInside(
              icon: Icons.language,
              label: 'HSU seit:',
              value: pupil.familyLanguageLessonsSince != null
                  ? '${pupil.familyLanguageLessonsSince!.formatDateForUser()} (${pupil.language})'
                  : 'Kein Eintrag',
            ),
          if (pupil.religionLessonsSince != null)
            PupilProfileContentSectionInside(
              icon: Icons.menu_book,
              label: 'Religionsunterricht seit:',
              value: pupil.religionLessonsSince != null
                  ? '${pupil.religionLessonsSince!.formatDateForUser()} (${pupil.religion})'
                  : 'Kein Eintrag',
            ),
          PupilProfileContentSectionEnd(
            icon: Icons.school,
            label: 'Schulformempfehlung:',
            value: pupil.schoolTransitionRecommendation ?? 'Kein Eintrag',
          ),

          const Gap(10),
          PupilLearningContentExpansionTileNavBar(pupil: pupil),
        ],
      ),
    );
  }
}

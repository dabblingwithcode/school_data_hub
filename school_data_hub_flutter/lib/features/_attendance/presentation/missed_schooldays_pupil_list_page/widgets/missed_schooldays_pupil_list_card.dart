import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_switch.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_helper_functions.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/widgets/attendance_stats_pupil.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/widgets/missed_class_card.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_navigation.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/avatar.dart';

class MissedSchooldaysPupilListCard extends WatchingWidget {
  final PupilProxy pupil;
  const MissedSchooldaysPupilListCard(this.pupil, {super.key});

  @override
  Widget build(BuildContext context) {
    final tileController = createOnce(() => CustomExpansionTileController());
    final PupilProxy pupil = watch(this.pupil);
    final attendanceManager = di<AttendanceManager>();
    List<MissedSchoolday> missedSchooldays = watch(
      attendanceManager.getPupilMissedSchooldaysProxy(pupil.pupilId),
    ).missedSchooldays;

    // sort by missedDay
    missedSchooldays.sort(
      (b, a) => a.schoolday!.schoolday.compareTo(b.schoolday!.schoolday),
    );
    final missedHoursForActualReport =
        AttendanceHelper.missedHoursforSemesterOrSchoolyear(pupil);
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1.0,
      margin: const EdgeInsets.only(
        left: 4.0,
        right: 4.0,
        top: 4.0,
        bottom: 4.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AvatarWithBadges(pupil: pupil, size: 80),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(15),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: InkWell(
                                  onTap: () {
                                    di<BottomNavManager>()
                                        .setPupilProfileNavPage(
                                          ProfileNavigationState
                                              .attendance
                                              .value,
                                        );
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) =>
                                            PupilProfilePage(pupil: pupil),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        pupil.firstName,
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const Gap(5),
                                      Text(
                                        pupil.lastName,
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const Gap(5),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: CustomExpansionTileSwitch(
                                  customExpansionTileController: tileController,
                                  includeSwitch: true,
                                  switchColor: AppColors.interactiveColor,
                                  expansionSwitchWidget: attendanceStats(pupil),
                                ),
                              ),
                            ),
                            const Gap(10),
                          ],
                        ),
                      ],
                    ),
                    const Gap(10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            'Fehlstunden:',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            ' ${missedHoursForActualReport.missed.toString()}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Gap(5),
                          const Text(
                            'davon unent:',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            ' ${missedHoursForActualReport.unexcused.toString()}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Gap(15),
                        ],
                      ),
                    ),
                    const Gap(10),
                  ],
                ),
              ),
            ],
          ),
          CustomExpansionTileContent(
            title: null,
            tileController: tileController,
            widgetList: [
              ListView.builder(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: missedSchooldays.length,
                itemBuilder: (BuildContext context, int index) {
                  return MissedSchooldayCard(
                    pupil: pupil,
                    missedSchoolday: missedSchooldays[index],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

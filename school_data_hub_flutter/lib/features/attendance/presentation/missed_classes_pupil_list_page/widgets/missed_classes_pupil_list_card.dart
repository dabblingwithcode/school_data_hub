import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_switch.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_helper_functions.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/widgets/attendance_stats_pupil.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/avatar.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/pupil_profile_attendance_content.dart';
import 'package:watch_it/watch_it.dart';

class AttendanceRankingListCard extends WatchingStatefulWidget {
  final PupilProxy pupil;
  const AttendanceRankingListCard(this.pupil, {super.key});

  @override
  State<AttendanceRankingListCard> createState() =>
      _AttendanceRankingListCardState();
}

class _AttendanceRankingListCardState extends State<AttendanceRankingListCard> {
  late CustomExpansionTileController _tileController;
  @override
  void initState() {
    super.initState();
    _tileController = CustomExpansionTileController();
  }

  @override
  Widget build(BuildContext context) {
    final PupilProxy pupil = watch(widget.pupil);
    final List<int> missedHoursForActualReport =
        AttendanceHelper.missedHoursforSemesterOrSchoolyear(pupil);
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1.0,
      margin:
          const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
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
                                    di<MainMenuBottomNavManager>()
                                        .setPupilProfileNavPage(3);
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (ctx) => PupilProfilePage(
                                        pupil: pupil,
                                      ),
                                    ));
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
                                    customExpansionTileController:
                                        _tileController,
                                    includeSwitch: true,
                                    switchColor: AppColors.interactiveColor,
                                    expansionSwitchWidget:
                                        attendanceStats(pupil)),
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
                            ' ${missedHoursForActualReport[0].toString()}',
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
                            ' ${missedHoursForActualReport[1].toString()}',
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
              tileController: _tileController,
              widgetList: [PupilAttendanceContent(pupil: pupil)]),
        ],
      ),
    );
  }
}

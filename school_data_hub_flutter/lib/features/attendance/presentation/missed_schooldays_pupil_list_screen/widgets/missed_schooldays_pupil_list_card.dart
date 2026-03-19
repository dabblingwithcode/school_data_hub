import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/avatar/avatar.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_helper.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/widgets/attendance_stats_pupil.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/widgets/missed_schoolday_card.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/pupil_profile_screen.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/widgets/pupil_profile_navigation.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';

class MissedSchooldaysPupilListCard extends WatchingWidget {
  final PupilProxy pupil;
  const MissedSchooldaysPupilListCard(this.pupil, {super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final tileController = createOnce(() => ExpansionController());

    return CardBox(
      padding: EdgeInsets.all(Style.spacing.sm),
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Gap(15),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: GestureDetector(
                              onTap: () {
                                di<BottomNavManager>().setPupilProfileNavPage(
                                  ProfileNavigationState.attendance.value,
                                );
                                Navigator.of(context).push<void>(
                                  MaterialPageRoute<void>(
                                    builder: (ctx) =>
                                        PupilProfilePage(pupil: pupil),
                                  ),
                                );
                              },
                              child: _MissedSchooldaysNameRow(pupil: pupil),
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
                            child: ExpansionHeader(
                              expansionController: tileController,
                              includeSwitch: true,
                              switchColor: style.colors.interactive,
                              expansionSwitchWidget: AttendanceStatsPupil(
                                pupil,
                              ),
                            ),
                          ),
                        ),
                        const Gap(10),
                      ],
                    ),
                    const Gap(10),
                    _MissedSchooldaysSummary(pupil: pupil),
                  ],
                ),
              ),
            ],
          ),
          ExpansionBody(
            title: null,
            tileController: tileController,
            widgetList: [_MissedSchooldaysList(pupil: pupil)],
          ),
        ],
      ),
    );
  }
}

/// Rebuilds only when [pupil.firstName] or [pupil.lastName] changes.
class _MissedSchooldaysNameRow extends WatchingWidget {
  final PupilProxy pupil;

  const _MissedSchooldaysNameRow({required this.pupil});

  @override
  Widget build(BuildContext context) {
    final firstName = watchPropertyValue((m) => m.firstName, target: pupil);
    final lastName = watchPropertyValue((m) => m.lastName, target: pupil);
    return Row(
      children: [
        Text(
          firstName,
          overflow: TextOverflow.fade,
          softWrap: false,
          textAlign: TextAlign.left,
          style: context.typography.subtitle.bold,
        ),
        const Gap(5),
        Text(
          lastName,
          overflow: TextOverflow.fade,
          softWrap: false,
          textAlign: TextAlign.left,
          style: context.typography.subtitle,
        ),
        const Gap(5),
      ],
    );
  }
}

/// Rebuilds only when the missed schooldays list for this pupil changes.
class _MissedSchooldaysSummary extends WatchingWidget {
  final PupilProxy pupil;

  const _MissedSchooldaysSummary({required this.pupil});

  @override
  Widget build(BuildContext context) {
    final attendanceManager = di<AttendanceManager>();
    watch(
      attendanceManager.getPupilMissedSchooldaysProxy(pupil.pupilId),
    ).missedSchooldays;

    final missedHoursForActualReport =
        AttendanceHelper.missedHoursforSemesterOrSchoolyear(pupil);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Fehlstunden:', style: context.typography.body),
          Text(
            ' ${missedHoursForActualReport.missed.toString()}',
            style: context.typography.body.bold,
          ),
          const Gap(5),
          Text('davon unent:', style: context.typography.body),
          Text(
            ' ${missedHoursForActualReport.unexcused.toString()}',
            style: context.typography.body.bold,
          ),
          const Gap(15),
        ],
      ),
    );
  }
}

class _MissedSchooldaysList extends WatchingWidget {
  final PupilProxy pupil;
  const _MissedSchooldaysList({required this.pupil});

  @override
  Widget build(BuildContext context) {
    final attendanceManager = di<AttendanceManager>();
    List<MissedSchoolday> missedSchooldays = watch(
      attendanceManager.getPupilMissedSchooldaysProxy(pupil.pupilId),
    ).missedSchooldays;
    return ListView.builder(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: missedSchooldays.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: MissedSchooldayCard(
            pupil: pupil,
            missedSchoolday: missedSchooldays[index],
          ),
        );
      },
    );
  }
}

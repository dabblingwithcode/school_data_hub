import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/after_school_care/widgets/after_school_care_details.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_navigation.dart';
import 'package:school_data_hub_flutter/common/widgets/avatar/avatar.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';

class AfterSchoolCareCard extends WatchingWidget {
  final PupilProxy pupil;
  const AfterSchoolCareCard(this.pupil, {super.key});

  @override
  Widget build(BuildContext context) {
    final tileController = createOnce(() => ExpansionController());

    return CardBox(
      padding: EdgeInsets.all(Style.spacing.sm),
      child: Column(
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
                    Gap(Style.spacing.lg),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: GestureDetector(
                              onTap: () {
                                di<BottomNavManager>().setPupilProfileNavPage(
                                  ProfileNavigationState.afterSchoolCare.value,
                                );
                                Navigator.of(context).push<void>(
                                  MaterialPageRoute<void>(
                                    builder: (ctx) =>
                                        PupilProfilePage(pupil: pupil),
                                  ),
                                );
                              },
                              child: _AfterSchoolCareNameRow(pupil: pupil),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(Style.spacing.xl),
              _AfterSchoolCareTimeDisplay(
                pupil: pupil,
                tileController: tileController,
              ),
              Gap(Style.spacing.xl),
            ],
          ),
          ExpansionBody(
            title: null,
            tileController: tileController,
            widgetList: [AfterSchoolCareDetails(pupil: pupil)],
          ),
        ],
      ),
    );
  }
}

/// Rebuilds only when [pupil.firstName] or [pupil.lastName] changes.
class _AfterSchoolCareNameRow extends WatchingWidget {
  final PupilProxy pupil;

  const _AfterSchoolCareNameRow({required this.pupil});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final firstName =
        watchPropertyValue((m) => m.firstName, target: pupil);
    final lastName =
        watchPropertyValue((m) => m.lastName, target: pupil);
    return Row(
      children: [
        Text(
          firstName,
          overflow: TextOverflow.fade,
          softWrap: false,
          textAlign: TextAlign.left,
          style: context.typography.title.withColor(
            style.colors.foreground,
          ).bold,
        ),
        Gap(Style.spacing.xs),
        Text(
          lastName,
          overflow: TextOverflow.fade,
          softWrap: false,
          textAlign: TextAlign.left,
          style: context.typography.title.withColor(
            style.colors.foreground,
          ),
        ),
        Gap(Style.spacing.xs),
      ],
    );
  }
}

/// Rebuilds only when [SchoolCalendarManager.thisDate] or [pupil.afterSchoolCare] changes.
class _AfterSchoolCareTimeDisplay extends WatchingWidget {
  final PupilProxy pupil;
  final ExpansionController tileController;

  const _AfterSchoolCareTimeDisplay({
    required this.pupil,
    required this.tileController,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final thisDate =
        watchValue((SchoolCalendarManager x) => x.thisDate);
    watchPropertyValue((m) => m.afterSchoolCare, target: pupil);
    final weekday = dateTimeToAfterSchoolCareWeekday(thisDate);
    final timeText =
        weekday != null ? (pupil.pickUpTime(weekday) ?? 'keine') : 'keine';

    return GestureDetector(
      onTap: () => tileController.toggle(),
      child: Column(
        children: [
          Gap(Style.spacing.xl),
          const Text('Abholzeit'),
          Center(
            child: Text(
              timeText,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: style.colors.accent,
              ),
            ),
          ),
          const Text('Uhr'),
        ],
      ),
    );
  }
}

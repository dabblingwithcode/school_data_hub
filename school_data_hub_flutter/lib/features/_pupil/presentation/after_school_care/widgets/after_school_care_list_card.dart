import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_controller.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/after_school_care/widgets/after_school_care_details.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_navigation.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/avatar.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';

class AfterSchoolCareCard extends WatchingWidget {
  final PupilProxy pupil;
  const AfterSchoolCareCard(this.pupil, {super.key});

  @override
  Widget build(BuildContext context) {
    final tileController = createOnce(() => CustomExpansionTileController());

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
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: InkWell(
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
              const Gap(20),
              _AfterSchoolCareTimeDisplay(
                pupil: pupil,
                tileController: tileController,
              ),
              const Gap(20),
            ],
          ),
          CustomExpansionTileContent(
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
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const Gap(5),
        Text(
          lastName,
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
    );
  }
}

/// Rebuilds only when [SchoolCalendarManager.thisDate] or [pupil.afterSchoolCare] changes.
class _AfterSchoolCareTimeDisplay extends WatchingWidget {
  final PupilProxy pupil;
  final CustomExpansionTileController tileController;

  const _AfterSchoolCareTimeDisplay({
    required this.pupil,
    required this.tileController,
  });

  @override
  Widget build(BuildContext context) {
    final thisDate =
        watchValue((SchoolCalendarManager x) => x.thisDate);
    watchPropertyValue((m) => m.afterSchoolCare, target: pupil);
    final weekday = dateTimeToAfterSchoolCareWeekday(thisDate);
    final timeText =
        weekday != null ? (pupil.pickUpTime(weekday) ?? 'keine') : 'keine';

    return InkWell(
      onTap: () => tileController.toggle(),
      child: Column(
        children: [
          const Gap(20),
          const Text('Abholzeit'),
          Center(
            child: Text(
              timeText,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: AppColors.backgroundColor,
              ),
            ),
          ),
          const Text('Uhr'),
        ],
      ),
    );
  }
}

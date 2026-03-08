import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_switch.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/avatar.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/filters/schoolday_event_filter_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_helper_functions.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_page/widgets/pupil_schoolday_events_list.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_page/widgets/schoolday_event_pupil_list_card/widgets/schoolday_event_pupil_stats.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';

class SchooldayEventPupilListCard extends WatchingWidget {
  final PupilProxy passedPupil;
  const SchooldayEventPupilListCard(this.passedPupil, {super.key});

  @override
  Widget build(BuildContext context) {
    final tileController = createOnce(() => CustomExpansionTileController());
    final mainMenuBottomNavManager = di<BottomNavManager>();
    final PupilProxy pupil = passedPupil;
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              AvatarWithBadges(pupil: pupil, size: 80),
              const Gap(5),
              Expanded(
                child: Column(
                  children: [
                    const Gap(10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: InkWell(
                              onTap: () {
                                mainMenuBottomNavManager.setPupilProfileNavPage(
                                  4,
                                );
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (ctx) =>
                                        PupilProfilePage(pupil: pupil),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    pupil.firstName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Gap(10),
                                  Text(
                                    pupil.lastName,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    _LastEventRow(pupil: pupil),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomExpansionTileSwitch(
                          includeSwitch: true,
                          switchColor: AppColors.interactiveColor,
                          customExpansionTileController: tileController,
                          expansionSwitchWidget: SchooldayEventPupilStats(
                            pupil: pupil,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(10),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
            child: CustomExpansionTileContent(
              title: const Text(
                'Vorfälle',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              tileController: tileController,
              widgetList: [PupilSchooldayEventsList(pupil: pupil)],
            ),
          ),
        ],
      ),
    );
  }
}

class _LastEventRow extends WatchingWidget {
  final PupilProxy pupil;

  const _LastEventRow({required this.pupil});

  @override
  Widget build(BuildContext context) {
    final schooldayEventFilterManager = di<SchooldayEventFilterManager>();
    final schooldayEventManager = di<SchooldayEventManager>();
    final unfilteredEvents = watch(
      schooldayEventManager.getPupilSchooldayEventsProxy(pupil.pupilId),
    ).schooldayEvents;
    watchValue((SchooldayEventFilterManager x) => x.schooldayEventsFilterState);
    final schooldayEvents = schooldayEventFilterManager.filteredSchooldayEvents(
      unfilteredEvents.values.toList(),
    );
    return Row(
      children: [
        Text(schooldayEvents.isNotEmpty ? 'zuletzt:' : 'keine Ereignisse'),
        const Gap(10),
        if (schooldayEvents.isNotEmpty)
          Text(
            SchoolDayEventHelper.getLastSchoolEventDate(
              schooldayEvents,
            ).formatDateForUser(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
      ],
    );
  }
}

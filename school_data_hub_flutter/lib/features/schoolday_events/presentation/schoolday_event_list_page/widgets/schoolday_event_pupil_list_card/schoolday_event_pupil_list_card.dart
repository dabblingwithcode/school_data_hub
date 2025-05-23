import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_switch.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/avatar.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/filters/schoolday_event_filter_manager.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/schoolday_event_helper_functions.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/schoolday_event_manager.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/presentation/schoolday_event_list_page/widgets/pupil_schoolday_events_list.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/presentation/schoolday_event_list_page/widgets/schoolday_event_pupil_list_card/widgets/schoolday_event_pupil_stats.dart';
import 'package:watch_it/watch_it.dart';

final _schooldayEventFilterManager = di<SchooldayEventFilterManager>();

final _schooldayEventManager = di<SchooldayEventManager>();

final _mainMenuBottomNavManager = di<BottomNavManager>();

class SchooldayEventPupilListCard extends WatchingStatefulWidget {
  final PupilProxy passedPupil;
  const SchooldayEventPupilListCard(this.passedPupil, {super.key});

  @override
  State<SchooldayEventPupilListCard> createState() =>
      _SchooldayEventListCardState();
}

class _SchooldayEventListCardState extends State<SchooldayEventPupilListCard> {
  late CustomExpansionTileController _tileController;
  late List<SchooldayEvent> schooldayEvents;
  @override
  void initState() {
    super.initState();
    _tileController = CustomExpansionTileController();
  }

  @override
  Widget build(BuildContext context) {
    final PupilProxy pupil = widget.passedPupil;
    final unfilteredEvents = watch(
            _schooldayEventManager.getPupilSchooldayEventsProxy(pupil.pupilId))
        .schooldayEvents;
    schooldayEvents = _schooldayEventFilterManager
        .filteredSchooldayEvents(unfilteredEvents.values.toList());
    // TODO: This is a workaround for the filter manager. It should be moved to
    // - SchooldayEventListPage or to the filter manager.
    if (_schooldayEventFilterManager.schooldayEventsFilterState.value.values
        .any((x) => x == true)) {
      if (schooldayEvents.isEmpty) {
        return const SizedBox.shrink();
      }
    }
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
                                  _mainMenuBottomNavManager
                                      .setPupilProfileNavPage(4);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => PupilProfilePage(
                                      pupil: pupil,
                                    ),
                                  ));
                                },
                                child: Text(
                                  pupil.firstName,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: InkWell(
                                onTap: () {
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //   builder: (ctx) => PupilProfilePage(
                                  //     pupil: pupil,
                                  //   ),
                                  // ));
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      pupil.lastName,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    if (pupil.family != null) ...[
                                      const Gap(10),
                                      const Icon(Icons.group,
                                          size: 25,
                                          color: AppColors.backgroundColor),
                                    ]
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text('zuletzt:'),
                          const Gap(10),
                          if (schooldayEvents.isNotEmpty)
                            Text(
                              SchoolDayEventHelper.getLastSchoolEventDate(
                                      schooldayEvents)
                                  .formatForUser(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomExpansionTileSwitch(
                              includeSwitch: true,
                              switchColor: AppColors.interactiveColor,
                              customExpansionTileController: _tileController,
                              expansionSwitchWidget: SchooldayEventPupilStats(
                                pupil: pupil,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(10),
              ],
            ),
            Padding(
                padding:
                    const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                child: CustomExpansionTileContent(
                  title: const Text('Vorfälle',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  tileController: _tileController,
                  widgetList: [PupilSchooldayEventsList(pupil: pupil)],
                )),
          ],
        ));
  }
}

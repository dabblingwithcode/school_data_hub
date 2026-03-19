import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/avatar/avatar.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/pupil_profile_screen.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/filters/schoolday_event_filter_manager.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/models/schoolday_event_enums.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/schoolday_event_helper_functions.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/schoolday_event_manager.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/presentation/schoolday_event_list_screen/widgets/pupil_schoolday_events_list.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/presentation/schoolday_event_list_screen/widgets/schoolday_event_pupil_list_card/widgets/schoolday_event_pupil_stats.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';

class SchooldayEventPupilListCard extends WatchingWidget {
  final PupilProxy passedPupil;
  const SchooldayEventPupilListCard(this.passedPupil, {super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final tileController = createOnce(() => ExpansionController());
    final mainMenuBottomNavManager = di<BottomNavManager>();
    final PupilProxy pupil = passedPupil;
    return CardBox(
      variant: CardBoxVariant.filled,
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              AvatarWithBadges(pupil: pupil, size: 80),
              Gap(Style.spacing.xs),
              Expanded(
                child: Column(
                  children: [
                    Gap(Style.spacing.sm),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: GestureDetector(
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
                              child: _NameRow(pupil: pupil),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(Style.spacing.sm),
                    _LastEventRow(pupil: pupil),
                    Gap(Style.spacing.sm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ExpansionHeader(
                              includeSwitch: true,
                              switchColor: style.colors.interactive,
                              expansionController: tileController,
                              expansionSwitchWidget: SchooldayEventPupilStats(
                                pupil: pupil,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(Style.spacing.sm),
            ],
          ),
          ExpansionBody(
            title: Text('Vorfälle', style: context.typography.body.bold),
            tileController: tileController,
            widgetList: [PupilSchooldayEventsList(pupil: pupil)],
          ),
        ],
      ),
    );
  }
}

/// Rebuilds only when [pupil.firstName] or [pupil.lastName] changes.
class _NameRow extends WatchingWidget {
  final PupilProxy pupil;

  const _NameRow({required this.pupil});

  @override
  Widget build(BuildContext context) {
    final firstName = watchPropertyValue(
      (PupilProxy m) => m.firstName,
      target: pupil,
    );
    final lastName = watchPropertyValue(
      (PupilProxy m) => m.lastName,
      target: pupil,
    );
    return Row(
      children: [
        Text(firstName, style: context.typography.title),
        Gap(Style.spacing.sm),
        Text(lastName, style: context.typography.title.w400),
      ],
    );
  }
}

/// Rebuilds only when this pupil's schoolday events or the event filter state change.
class _LastEventRow extends WatchingWidget {
  final PupilProxy pupil;

  const _LastEventRow({required this.pupil});

  @override
  Widget build(BuildContext context) {
    final schooldayEventManager = di<SchooldayEventManager>();
    final schooldayEventFilterManager = di<SchooldayEventFilterManager>();
    final proxy = schooldayEventManager.getPupilSchooldayEventsProxy(
      pupil.pupilId,
    );
    final unfilteredEvents = watch(proxy).schooldayEvents;
    // .select so we only rebuild when the filter map content actually changes
    watch(
      schooldayEventFilterManager.schooldayEventsFilterState.select(
        (m) => Map<SchooldayEventFilter, bool>.from(m),
      ),
    );
    final schooldayEvents = schooldayEventFilterManager.filteredSchooldayEvents(
      unfilteredEvents.values.toList(),
    );
    return Row(
      children: [
        Text(
          schooldayEvents.isNotEmpty ? 'zuletzt:' : 'keine Ereignisse',
          style: context.typography.body,
        ),
        Gap(Style.spacing.sm),
        if (schooldayEvents.isNotEmpty)
          Flexible(
            child: Text(
              SchoolDayEventHelper.getLastSchoolEventDate(
                schooldayEvents,
              ).formatDateForUser(),
              style: context.typography.title,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }
}

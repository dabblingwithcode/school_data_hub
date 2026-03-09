import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/filters/schoolday_event_filter_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/models/schoolday_event_enums.dart';

/// Event-type and reason filter sections for the schoolday event filter sheet.
/// Use with [CommonPupilFiltersWidget] in [showGenericFilterBottomSheet] filterList.
class SchooldayEventFiltersWidget extends WatchingWidget {
  const SchooldayEventFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final schooldayEventFilterManager = di<SchooldayEventFilterManager>();
    final pupilsFilter = di<PupilsFilter>();
    PupilSortMode sortMode = watchValue((PupilsFilter x) => x.sortMode);
    final Map<SchooldayEventFilter, bool> activeSchooldayEventFilters =
        watchValue(
          (SchooldayEventFilterManager x) => x.schooldayEventsFilterState,
        );
    bool valueLastSevenDays =
        activeSchooldayEventFilters[SchooldayEventFilter.sevenDays]!;
    bool valueProcessed =
        activeSchooldayEventFilters[SchooldayEventFilter.processed]!;
    bool valueRedCard =
        activeSchooldayEventFilters[SchooldayEventFilter.admonition]!;
    bool valueRedCardOgs =
        activeSchooldayEventFilters[SchooldayEventFilter
            .afternoonCareAdmonition]!;
    bool valueRedCardSentHome =
        activeSchooldayEventFilters[SchooldayEventFilter.admonitionAndBanned]!;
    bool valueParentsMeeting =
        activeSchooldayEventFilters[SchooldayEventFilter.parentsMeeting]!;
    bool valueOtherEvents =
        activeSchooldayEventFilters[SchooldayEventFilter.otherEvent]!;
    bool valueViolenceAgainstPupils =
        activeSchooldayEventFilters[SchooldayEventFilter
            .violenceAgainstPupils]!;
    bool valueViolenceAgainstAdults =
        activeSchooldayEventFilters[SchooldayEventFilter
            .violenceAgainstAdults]!;
    bool valueViolenceAgainstThings =
        activeSchooldayEventFilters[SchooldayEventFilter
            .violenceAgainstThings]!;
    bool valueInsultOthers =
        activeSchooldayEventFilters[SchooldayEventFilter.insultOthers]!;
    bool valueAnnoy = activeSchooldayEventFilters[SchooldayEventFilter.annoy]!;
    bool valueIgnoreInstructions =
        activeSchooldayEventFilters[SchooldayEventFilter.ignoreInstructions]!;
    bool valueDangerousBehaviour =
        activeSchooldayEventFilters[SchooldayEventFilter.dangerousBehaviour]!;
    bool valueDisturbLesson =
        activeSchooldayEventFilters[SchooldayEventFilter.disturbLesson]!;
    bool valueOtherReasons =
        activeSchooldayEventFilters[SchooldayEventFilter.other]!;
    bool valueLearningDevelopmentInfo =
        activeSchooldayEventFilters[SchooldayEventFilter
            .learningDevelopmentInfo]!;
    bool valueLearningSupportInfo =
        activeSchooldayEventFilters[SchooldayEventFilter.learningSupportInfo]!;
    bool valueAdmonitionInfo =
        activeSchooldayEventFilters[SchooldayEventFilter.admonitionInfo]!;
    bool valueDuringBreak =
        activeSchooldayEventFilters[SchooldayEventFilter.duringBreak]!;
    bool valueNotDuringBreak =
        activeSchooldayEventFilters[SchooldayEventFilter.notDuringBreak]!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Row(children: [Text('Ereignisse', style: AppStyles.subtitle)]),
        const Gap(5),
        Wrap(
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            ThemedFilterChip(
              label: '7 Tage',
              selected: valueLastSevenDays,
              onSelected: (val) {
                schooldayEventFilterManager.setFilter(
                  schooldayEventFilters: [
                    (filter: SchooldayEventFilter.sevenDays, value: val),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: 'nicht bearbeitet',
              selected: valueProcessed,
              onSelected: (val) {
                schooldayEventFilterManager.setFilter(
                  schooldayEventFilters: [
                    (filter: SchooldayEventFilter.processed, value: val),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: '🟥',
              selected: valueRedCard,
              onSelected: (val) {
                schooldayEventFilterManager.setFilter(
                  schooldayEventFilters: [
                    (filter: SchooldayEventFilter.admonition, value: val),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: '🟥 OGS',
              selected: valueRedCardOgs,
              onSelected: (val) {
                schooldayEventFilterManager.setFilter(
                  schooldayEventFilters: [
                    (
                      filter: SchooldayEventFilter.afternoonCareAdmonition,
                      value: val,
                    ),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: '🟥🏠',
              selected: valueRedCardSentHome,
              onSelected: (val) {
                schooldayEventFilterManager.setFilter(
                  schooldayEventFilters: [
                    (
                      filter: SchooldayEventFilter.admonitionAndBanned,
                      value: val,
                    ),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: '👪️',
              selected: valueParentsMeeting,
              onSelected: (val) {
                schooldayEventFilterManager.setFilter(
                  schooldayEventFilters: [
                    (filter: SchooldayEventFilter.parentsMeeting, value: val),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: '📝',
              selected: valueOtherEvents,
              onSelected: (val) {
                schooldayEventFilterManager.setFilter(
                  schooldayEventFilters: [
                    (filter: SchooldayEventFilter.otherEvent, value: val),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: '🕒Pause',
              selected: valueDuringBreak,
              onSelected: (val) {
                schooldayEventFilterManager.setFilter(
                  schooldayEventFilters: val
                      ? [
                          (filter: SchooldayEventFilter.duringBreak, value: true),
                          (filter: SchooldayEventFilter.notDuringBreak, value: false),
                        ]
                      : [
                          (filter: SchooldayEventFilter.duringBreak, value: false),
                        ],
                );
              },
            ),
            ThemedFilterChip(
              label: '🕒Unterricht',
              selected: valueNotDuringBreak,
              onSelected: (val) {
                schooldayEventFilterManager.setFilter(
                  schooldayEventFilters: val
                      ? [
                          (filter: SchooldayEventFilter.notDuringBreak, value: true),
                          (filter: SchooldayEventFilter.duringBreak, value: false),
                        ]
                      : [
                          (filter: SchooldayEventFilter.notDuringBreak, value: false),
                        ],
                );
              },
            ),
          ],
        ),
        const Gap(10),
        const Row(children: [Text('Grund', style: AppStyles.subtitle)]),
        const Gap(5),
        Wrap(
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            ThemedFilterChip(
              label: '🤜🤕',
              selected: valueViolenceAgainstPupils,
              onSelected: (val) {
                schooldayEventFilterManager.setFilter(
                  schooldayEventFilters: [
                    (
                      filter: SchooldayEventFilter.violenceAgainstPupils,
                      value: val,
                    ),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: '🤜🎓️',
              selected: valueViolenceAgainstAdults,
              onSelected: (val) {
                schooldayEventFilterManager.setFilter(
                  schooldayEventFilters: [
                    (
                      filter: SchooldayEventFilter.violenceAgainstAdults,
                      value: val,
                    ),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: '🤜🏠',
              selected: valueViolenceAgainstThings,
              onSelected: (val) {
                schooldayEventFilterManager.setFilter(
                  schooldayEventFilters: [
                    (
                      filter: SchooldayEventFilter.violenceAgainstThings,
                      value: val,
                    ),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: '🤬💔',
              selected: valueInsultOthers,
              onSelected: (val) {
                schooldayEventFilterManager.setFilter(
                  schooldayEventFilters: [
                    (filter: SchooldayEventFilter.insultOthers, value: val),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: '😈😖',
              selected: valueAnnoy,
              onSelected: (val) {
                schooldayEventFilterManager.setFilter(
                  schooldayEventFilters: [
                    (filter: SchooldayEventFilter.annoy, value: val),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: '🚨😱',
              selected: valueDangerousBehaviour,
              onSelected: (val) {
                schooldayEventFilterManager.setFilter(
                  schooldayEventFilters: [
                    (
                      filter: SchooldayEventFilter.dangerousBehaviour,
                      value: val,
                    ),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: '🛑🎓️',
              selected: valueDisturbLesson,
              onSelected: (val) {
                schooldayEventFilterManager.setFilter(
                  schooldayEventFilters: [
                    (filter: SchooldayEventFilter.disturbLesson, value: val),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: '🎓️🙉',
              selected: valueIgnoreInstructions,
              onSelected: (val) {
                schooldayEventFilterManager.setFilter(
                  schooldayEventFilters: [
                    (
                      filter: SchooldayEventFilter.ignoreInstructions,
                      value: val,
                    ),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: '💡🧠',
              selected: valueLearningDevelopmentInfo,
              onSelected: (val) {
                schooldayEventFilterManager.setFilter(
                  schooldayEventFilters: [
                    (
                      filter: SchooldayEventFilter.learningDevelopmentInfo,
                      value: val,
                    ),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: '🛟🧠',
              selected: valueLearningSupportInfo,
              onSelected: (val) {
                schooldayEventFilterManager.setFilter(
                  schooldayEventFilters: [
                    (
                      filter: SchooldayEventFilter.learningSupportInfo,
                      value: val,
                    ),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: '⚠️ℹ️',
              selected: valueAdmonitionInfo,
              onSelected: (val) {
                schooldayEventFilterManager.setFilter(
                  schooldayEventFilters: [
                    (filter: SchooldayEventFilter.admonitionInfo, value: val),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: '📝',
              selected: valueOtherReasons,
              onSelected: (val) {
                schooldayEventFilterManager.setFilter(
                  schooldayEventFilters: [
                    (filter: SchooldayEventFilter.other, value: val),
                  ],
                );
              },
            ),
          ],
        ),
        const Gap(10),
        const Row(children: [Text('Sortieren', style: AppStyles.subtitle)]),
        const Gap(5),
        Wrap(
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            ThemedFilterChip(
              label: 'A-Z',
              selected: sortMode == PupilSortMode.sortByName,
              onSelected: (val) {
                pupilsFilter.setSortMode(PupilSortMode.sortByName);
              },
            ),
            ThemedFilterChip(
              label: 'Anzahl',
              selected: sortMode == PupilSortMode.sortBySchooldayEvents,
              onSelected: (val) {
                pupilsFilter.setSortMode(PupilSortMode.sortBySchooldayEvents);
              },
            ),
            ThemedFilterChip(
              label: 'zuletzt',
              selected: sortMode == PupilSortMode.sortByLastSchooldayEvent,
              onSelected: (val) {
                pupilsFilter.setSortMode(
                  PupilSortMode.sortByLastSchooldayEvent,
                );
              },
            ),
          ],
        ),
        const Gap(20),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/domain/models/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/theme/styles.dart';
import 'package:schuldaten_hub/common/widgets/themed_filter_chip.dart';
import 'package:schuldaten_hub/features/pupil/domain/filters/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:schuldaten_hub/features/schoolday_events/domain/filters/schoolday_event_filter_manager.dart';
import 'package:schuldaten_hub/features/schoolday_events/domain/models/schoolday_event_enums.dart';
import 'package:watch_it/watch_it.dart';

class SchooldayEventFilterBottomSheet extends WatchingWidget {
  const SchooldayEventFilterBottomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    PupilSortMode sortMode = watchValue((PupilsFilter x) => x.sortMode);
    final Map<SchooldayEventFilter, bool> activeSchooldayEventFilters =
        watchValue(
            (SchooldayEventFilterManager x) => x.schooldayEventsFilterState);
    bool valueLastSevenDays =
        activeSchooldayEventFilters[SchooldayEventFilter.sevenDays]!;
    // event type
    bool valueProcessed =
        activeSchooldayEventFilters[SchooldayEventFilter.processed]!;
    bool valueRedCard =
        activeSchooldayEventFilters[SchooldayEventFilter.admonition]!;
    bool valueRedCardOgs = activeSchooldayEventFilters[
        SchooldayEventFilter.afternoonCareAdmonition]!;
    bool valueRedCardSentHome =
        activeSchooldayEventFilters[SchooldayEventFilter.admonitionAndBanned]!;
    bool valueParentsMeeting =
        activeSchooldayEventFilters[SchooldayEventFilter.parentsMeeting]!;
    bool valueOtherEvents =
        activeSchooldayEventFilters[SchooldayEventFilter.otherEvent]!;
    bool valueViolenceAgainstPupils = activeSchooldayEventFilters[
        SchooldayEventFilter.violenceAgainstPupils]!;
    bool valueViolenceAgainstAdults = activeSchooldayEventFilters[
        SchooldayEventFilter.violenceAgainstAdults]!;
    bool valueViolenceAgainstThings = activeSchooldayEventFilters[
        SchooldayEventFilter.violenceAgainstThings]!;
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
    bool valueLearningDevelopmentInfo = activeSchooldayEventFilters[
        SchooldayEventFilter.learningDevelopmentInfo]!;
    bool valueLearningSupportInfo =
        activeSchooldayEventFilters[SchooldayEventFilter.learningSupportInfo]!;
    bool valueAdmonitionInfo =
        activeSchooldayEventFilters[SchooldayEventFilter.admonitionInfo]!;

    final schooldayEventFilterLocator = locator<SchooldayEventFilterManager>();
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 5),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const FilterHeading(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    const CommonPupilFiltersWidget(),
                    const Row(
                      children: [
                        Text(
                          'Ereignisse',
                          style: AppStyles.subtitle,
                        )
                      ],
                    ),
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
                            schooldayEventFilterLocator.setFilter(
                                schooldayEventFilters: [
                                  (
                                    filter: SchooldayEventFilter.sevenDays,
                                    value: val
                                  )
                                ]);
                          },
                        ),
                        ThemedFilterChip(
                          label: 'nicht bearbeitet',
                          selected: valueProcessed,
                          onSelected: (val) {
                            schooldayEventFilterLocator.setFilter(
                                schooldayEventFilters: [
                                  (
                                    filter: SchooldayEventFilter.processed,
                                    value: val
                                  )
                                ]);
                          },
                        ),
                        ThemedFilterChip(
                          label: '🟥',
                          selected: valueRedCard,
                          onSelected: (val) {
                            schooldayEventFilterLocator.setFilter(
                                schooldayEventFilters: [
                                  (
                                    filter: SchooldayEventFilter.admonition,
                                    value: val
                                  )
                                ]);
                          },
                        ),
                        ThemedFilterChip(
                          label: '🟥 OGS',
                          selected: valueRedCardOgs,
                          onSelected: (val) {
                            schooldayEventFilterLocator.setFilter(
                                schooldayEventFilters: [
                                  (
                                    filter: SchooldayEventFilter
                                        .afternoonCareAdmonition,
                                    value: val
                                  )
                                ]);
                          },
                        ),
                        ThemedFilterChip(
                          label: '🟥🏠',
                          selected: valueRedCardSentHome,
                          onSelected: (val) {
                            schooldayEventFilterLocator
                                .setFilter(schooldayEventFilters: [
                              (
                                filter:
                                    SchooldayEventFilter.admonitionAndBanned,
                                value: val
                              )
                            ]);
                          },
                        ),
                        ThemedFilterChip(
                          label: '👪️',
                          selected: valueParentsMeeting,
                          onSelected: (val) {
                            schooldayEventFilterLocator.setFilter(
                              schooldayEventFilters: [
                                (
                                  filter: SchooldayEventFilter.parentsMeeting,
                                  value: val
                                )
                              ],
                            );
                          },
                        ),
                        ThemedFilterChip(
                          label: '📝',
                          selected: valueOtherEvents,
                          onSelected: (val) {
                            schooldayEventFilterLocator.setFilter(
                                schooldayEventFilters: [
                                  (
                                    filter: SchooldayEventFilter.otherEvent,
                                    value: val
                                  )
                                ]);
                          },
                        ),
                      ],
                    ),
                    const Gap(10),
                    const Row(
                      children: [
                        Text(
                          'Grund',
                          style: AppStyles.subtitle,
                        )
                      ],
                    ),
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
                              schooldayEventFilterLocator.setFilter(
                                  schooldayEventFilters: [
                                    (
                                      filter: SchooldayEventFilter
                                          .violenceAgainstPupils,
                                      value: val
                                    )
                                  ]);
                            },
                          ),
                          ThemedFilterChip(
                            label: '🤜🎓️',
                            selected: valueViolenceAgainstAdults,
                            onSelected: (val) {
                              schooldayEventFilterLocator.setFilter(
                                  schooldayEventFilters: [
                                    (
                                      filter: SchooldayEventFilter
                                          .violenceAgainstAdults,
                                      value: val
                                    )
                                  ]);
                            },
                          ),
                          ThemedFilterChip(
                            label: '🤜🏠',
                            selected: valueViolenceAgainstThings,
                            onSelected: (val) {
                              schooldayEventFilterLocator.setFilter(
                                  schooldayEventFilters: [
                                    (
                                      filter: SchooldayEventFilter
                                          .violenceAgainstThings,
                                      value: val
                                    )
                                  ]);
                            },
                          ),
                          ThemedFilterChip(
                            label: '🤬💔',
                            selected: valueInsultOthers,
                            onSelected: (val) {
                              schooldayEventFilterLocator.setFilter(
                                  schooldayEventFilters: [
                                    (
                                      filter: SchooldayEventFilter.insultOthers,
                                      value: val
                                    )
                                  ]);
                            },
                          ),
                          ThemedFilterChip(
                            label: '😈😖',
                            selected: valueAnnoy,
                            onSelected: (val) {
                              schooldayEventFilterLocator
                                  .setFilter(schooldayEventFilters: [
                                (filter: SchooldayEventFilter.annoy, value: val)
                              ]);
                            },
                          ),
                          ThemedFilterChip(
                            label: '🚨😱',
                            selected: valueDangerousBehaviour,
                            onSelected: (val) {
                              schooldayEventFilterLocator
                                  .setFilter(schooldayEventFilters: [
                                (
                                  filter:
                                      SchooldayEventFilter.dangerousBehaviour,
                                  value: val
                                )
                              ]);
                            },
                          ),
                          ThemedFilterChip(
                            label: '🛑🎓️',
                            selected: valueDisturbLesson,
                            onSelected: (val) {
                              schooldayEventFilterLocator
                                  .setFilter(schooldayEventFilters: [
                                (
                                  filter: SchooldayEventFilter.disturbLesson,
                                  value: val
                                )
                              ]);
                            },
                          ),
                          ThemedFilterChip(
                            label: '🎓️🙉',
                            selected: valueIgnoreInstructions,
                            onSelected: (val) {
                              schooldayEventFilterLocator
                                  .setFilter(schooldayEventFilters: [
                                (
                                  filter:
                                      SchooldayEventFilter.ignoreInstructions,
                                  value: val
                                )
                              ]);
                            },
                          ),
                          ThemedFilterChip(
                            label: '💡🧠',
                            selected: valueLearningDevelopmentInfo,
                            onSelected: (val) {
                              schooldayEventFilterLocator.setFilter(
                                  schooldayEventFilters: [
                                    (
                                      filter: SchooldayEventFilter
                                          .learningDevelopmentInfo,
                                      value: val
                                    )
                                  ]);
                            },
                          ),
                          ThemedFilterChip(
                            label: '🛟🧠',
                            selected: valueLearningSupportInfo,
                            onSelected: (val) {
                              schooldayEventFilterLocator
                                  .setFilter(schooldayEventFilters: [
                                (
                                  filter:
                                      SchooldayEventFilter.learningSupportInfo,
                                  value: val
                                )
                              ]);
                            },
                          ),
                          ThemedFilterChip(
                            label: '⚠️ℹ️',
                            selected: valueAdmonitionInfo,
                            onSelected: (val) {
                              schooldayEventFilterLocator
                                  .setFilter(schooldayEventFilters: [
                                (
                                  filter: SchooldayEventFilter.admonitionInfo,
                                  value: val
                                )
                              ]);
                            },
                          ),
                          ThemedFilterChip(
                            label: '📝',
                            selected: valueOtherReasons,
                            onSelected: (val) {
                              schooldayEventFilterLocator
                                  .setFilter(schooldayEventFilters: [
                                (filter: SchooldayEventFilter.other, value: val)
                              ]);
                            },
                          ),
                        ]),
                    const Gap(10),
                    const Row(
                      children: [
                        Text(
                          'Sortieren',
                          style: AppStyles.subtitle,
                        )
                      ],
                    ),
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
                            locator<PupilsFilter>()
                                .setSortMode(PupilSortMode.sortByName);
                          },
                        ),
                        ThemedFilterChip(
                          label: 'Anzahl',
                          selected:
                              sortMode == PupilSortMode.sortBySchooldayEvents,
                          onSelected: (val) {
                            locator<PupilsFilter>().setSortMode(
                                PupilSortMode.sortBySchooldayEvents);
                          },
                        ),
                        ThemedFilterChip(
                          label: 'zuletzt',
                          selected: sortMode ==
                              PupilSortMode.sortByLastSchooldayEvent,
                          onSelected: (val) {
                            locator<PupilsFilter>().setSortMode(
                                PupilSortMode.sortByLastSchooldayEvent);
                          },
                        ),
                      ],
                    ),
                    const Gap(20),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

showSchooldayEventFilterBottomSheet(BuildContext context) {
  showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    context: context,
    builder: (_) => const SchooldayEventFilterBottomSheet(),
  );
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/schoolday_date_picker.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/models/schoolday_event_enums.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/new_schoolday_event_page/widgets/schoolday_event_filter_chip.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:watch_it/watch_it.dart';

class NewSchooldayEventPage extends WatchingWidget {
  final int pupilId;

  const NewSchooldayEventPage({super.key, required this.pupilId});

  SchoolCalendarManager get _schoolCalendarManager =>
      di<SchoolCalendarManager>();
  SchooldayEventManager get _schooldayEventManager =>
      di<SchooldayEventManager>();

  String _getDropdownItemText(SchooldayEventType reason) {
    switch (reason) {
      case SchooldayEventType.notSet:
        return 'bitte wählen';
      case SchooldayEventType.admonition:
        return 'rote Karte';
      case SchooldayEventType.afternoonCareAdmonition:
        return 'rote Karte - OGS';
      case SchooldayEventType.admonitionAndBanned:
        return 'rote Karte + abholen';
      case SchooldayEventType.parentsMeeting:
        return 'Elterngespräch';
      case SchooldayEventType.otherEvent:
        return 'sonstiges';
    }
  }

  Future<void> postSchooldayEvent({
    required SchooldayEventType schooldayEventType,
    required DateTime thisDate,
    required bool violenceAgainstPupils,
    required bool violenceAgainstTeacher,
    required bool violenceAgainstThings,
    required bool imminentDanger,
    required bool insultOthers,
    required bool annoyOthers,
    required bool ignoreTeacherInstructions,
    required bool disturbLesson,
    required bool learningDevelopmentInfo,
    required bool learningSupportInfo,
    required bool admonitionInfo,
    required bool transitionAdvice,
    required bool other,
    required String eventTime,
  }) async {
    Set<String> schooldayEventReason = {};
    String schooldayEventReasons = '';
    if (violenceAgainstPupils == true) {
      schooldayEventReason.add(
        SchooldayEventReason.violenceAgainstPupils.value,
      );
    }

    if (violenceAgainstTeacher == true) {
      schooldayEventReason.add(
        SchooldayEventReason.violenceAgainstTeachers.value,
      );
    }

    if (violenceAgainstThings == true) {
      schooldayEventReason.add(
        SchooldayEventReason.violenceAgainstThings.value,
      );
    }

    if (imminentDanger == true) {
      schooldayEventReason.add(SchooldayEventReason.dangerousBehaviour.value);
    }

    if (insultOthers == true) {
      schooldayEventReason.add(SchooldayEventReason.insultOthers.value);
    }

    if (annoyOthers == true) {
      schooldayEventReason.add(SchooldayEventReason.annoyOthers.value);
    }

    if (ignoreTeacherInstructions == true) {
      schooldayEventReason.add(SchooldayEventReason.ignoreInstructions.value);
    }

    if (disturbLesson == true) {
      schooldayEventReason.add(SchooldayEventReason.disturbLesson.value);
    }

    if (learningDevelopmentInfo == true) {
      schooldayEventReason.add(
        SchooldayEventReason.learningDevelopmentInfo.value,
      );
    }

    if (learningSupportInfo == true) {
      schooldayEventReason.add(SchooldayEventReason.learningSupportInfo.value);
    }

    if (admonitionInfo == true) {
      schooldayEventReason.add(SchooldayEventReason.admonitionInfo.value);
    }

    if (other == true) {
      schooldayEventReason.add(SchooldayEventReason.other.value);
    }
    if (transitionAdvice == true) {
      schooldayEventReason.add(SchooldayEventReason.transitionAdvice.value);
    }
    for (final reason in schooldayEventReason) {
      schooldayEventReasons = '$schooldayEventReasons$reason*';
    }

    final Schoolday? schoolday = _schoolCalendarManager.getSchooldayByDate(
      thisDate,
    );

    // TODO: This is very optimistic. We should check if the schoolday is null and handle it properly.

    await _schooldayEventManager.postSchooldayEvent(
      pupilId,
      schoolday!.id!,
      thisDate,
      schooldayEventType,
      schooldayEventReasons,
      eventTime: eventTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    final schooldayEventTypeDropdown = createOnce(
      () => ValueNotifier<SchooldayEventType>(SchooldayEventType.notSet),
    );
    final thisDate = createOnce(
      () => ValueNotifier<DateTime>(_schoolCalendarManager.thisDate.value),
    );
    final now = DateTime.now();
    final defaultTime =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    final eventTime = createOnce(() => ValueNotifier<String>(defaultTime));
    final violenceAgainstPupils = createOnce(() => ValueNotifier<bool>(false));
    final violenceAgainstTeacher = createOnce(() => ValueNotifier<bool>(false));
    final violenceAgainstThings = createOnce(() => ValueNotifier<bool>(false));
    final insultOthers = createOnce(() => ValueNotifier<bool>(false));
    final annoyOthers = createOnce(() => ValueNotifier<bool>(false));
    final imminentDanger = createOnce(() => ValueNotifier<bool>(false));
    final ignoreTeacherInstructions = createOnce(
      () => ValueNotifier<bool>(false),
    );
    final disturbLesson = createOnce(() => ValueNotifier<bool>(false));
    final other = createOnce(() => ValueNotifier<bool>(false));
    final learningDevelopmentInfo = createOnce(
      () => ValueNotifier<bool>(false),
    );
    final learningSupportInfo = createOnce(() => ValueNotifier<bool>(false));
    final transitionAdvice = createOnce(() => ValueNotifier<bool>(false));
    final admonitionInfo = createOnce(() => ValueNotifier<bool>(false));
    final schooldayEventType = watch(schooldayEventTypeDropdown).value;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: const Text('Neues Ereignis', style: AppStyles.appBarTextStyle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Ereignis-Art',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                DropdownButton<SchooldayEventType>(
                  isDense: true,
                  underline: Container(),
                  style: AppStyles.subtitle,
                  value: schooldayEventType,
                  onChanged: (SchooldayEventType? newValue) {
                    schooldayEventTypeDropdown.value = newValue!;
                  },
                  items: SchooldayEventType.values
                      .map<DropdownMenuItem<SchooldayEventType>>((
                        SchooldayEventType value,
                      ) {
                        return DropdownMenuItem<SchooldayEventType>(
                          value: value,
                          child: Text(
                            _getDropdownItemText(value),
                            style: TextStyle(
                              color: value == SchooldayEventType.notSet
                                  ? Colors.red
                                  : AppColors.backgroundColor,
                              fontSize: 20,
                            ),
                          ),
                        );
                      })
                      .toList(),
                ),
                const Gap(10),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Datum',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        final DateTime? newDate = await selectSchooldayDate(
                          context,
                          thisDate.value,
                        );
                        if (newDate != null) {
                          thisDate.value = newDate;
                        }
                      },
                      icon: Icon(
                        Icons.calendar_today_rounded,
                        color: AppColors.interactiveColor,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final DateTime? newDate = await selectSchooldayDate(
                          context,
                          thisDate.value,
                        );
                        if (newDate != null) {
                          thisDate.value = newDate;
                        }
                      },
                      child: Text(
                        watch(thisDate).value.formatDateForUser(),
                        style: AppStyles.title.copyWith(
                          color: AppColors.interactiveColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Uhrzeit',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                            hour: int.parse(eventTime.value.split(':')[0]),
                            minute: int.parse(eventTime.value.split(':')[1]),
                          ),
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(
                                context,
                              ).copyWith(alwaysUse24HourFormat: true),
                              child: child!,
                            );
                          },
                        );
                        if (picked != null) {
                          eventTime.value =
                              '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
                        }
                      },
                      icon: Icon(
                        Icons.access_time_rounded,
                        color: AppColors.interactiveColor,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                            hour: int.parse(eventTime.value.split(':')[0]),
                            minute: int.parse(eventTime.value.split(':')[1]),
                          ),
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(
                                context,
                              ).copyWith(alwaysUse24HourFormat: true),
                              child: child!,
                            );
                          },
                        );
                        if (picked != null) {
                          eventTime.value =
                              '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
                        }
                      },
                      child: Text(
                        watch(eventTime).value,
                        style: AppStyles.title.copyWith(
                          color: AppColors.interactiveColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                const Text(
                  'Grund',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const Gap(5),
                Expanded(
                  child: schooldayEventType == SchooldayEventType.notSet
                      ? const Center(
                          child: Text(
                            'Bitte eine Ereignis-Art auswählen!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : schooldayEventType == SchooldayEventType.parentsMeeting
                      ? SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                children: [
                                  SchooldayEventReasonFilterChip(
                                    isReason: watch(
                                      learningDevelopmentInfo,
                                    ).value,
                                    onSelected: (value) {
                                      learningDevelopmentInfo.value = value;
                                    },
                                    emojis: '💡🧠',
                                    text: 'Lernentwicklung',
                                  ),
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: watch(learningSupportInfo).value,
                                    onSelected: (value) {
                                      learningSupportInfo.value = value;
                                    },
                                    emojis: '🛟🧠',
                                    text: 'Förderung',
                                  ),
                                  SchooldayEventReasonFilterChip(
                                    isReason: watch(transitionAdvice).value,
                                    onSelected: (value) {
                                      transitionAdvice.value = value;
                                    },
                                    emojis: '🧠🗺️',
                                    text: 'Übergang',
                                  ),
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: watch(admonitionInfo).value,
                                    onSelected: (value) {
                                      admonitionInfo.value = value;
                                    },
                                    emojis: '⚠️ℹ️',
                                    text: 'Regelverstoß',
                                  ),
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: watch(other).value,
                                    onSelected: (value) {
                                      other.value = value;
                                    },
                                    emojis: '📝',
                                    text: 'Sonstiges',
                                  ),
                                  const Gap(5),
                                ],
                              ),
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                children: [
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: watch(
                                      violenceAgainstPupils,
                                    ).value,
                                    onSelected: (value) {
                                      violenceAgainstPupils.value = value;
                                    },
                                    emojis: '🤜🤕',
                                    text: 'Gewalt gegen Kinder',
                                  ),
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: watch(
                                      violenceAgainstTeacher,
                                    ).value,
                                    onSelected: (value) {
                                      violenceAgainstTeacher.value = value;
                                    },
                                    emojis: '🤜🎓️',
                                    text: 'Gewalt gegen Erwachsene',
                                  ),
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: watch(
                                      violenceAgainstThings,
                                    ).value,
                                    onSelected: (value) {
                                      violenceAgainstThings.value = value;
                                    },
                                    emojis: '🤜🏫',
                                    text: 'Gewalt gegen Sachen',
                                  ),
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: watch(insultOthers).value,
                                    onSelected: (value) {
                                      insultOthers.value = value;
                                    },
                                    emojis: '🤬💔',
                                    text: 'Beleidigen',
                                  ),
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: watch(annoyOthers).value,
                                    onSelected: (value) {
                                      annoyOthers.value = value;
                                    },
                                    emojis: '😈😖',
                                    text: 'Ärgern',
                                  ),
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: watch(imminentDanger).value,
                                    onSelected: (value) {
                                      imminentDanger.value = value;
                                    },
                                    emojis: '🚨😱',
                                    text: 'Gefahr für sich/andere',
                                  ),
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: watch(
                                      ignoreTeacherInstructions,
                                    ).value,
                                    onSelected: (value) {
                                      ignoreTeacherInstructions.value = value;
                                    },
                                    emojis: '🎓️🙉',
                                    text: 'Anweisungen ignorieren',
                                  ),
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: watch(disturbLesson).value,
                                    onSelected: (value) {
                                      disturbLesson.value = value;
                                    },
                                    emojis: '🛑🎓️',
                                    text: 'Unterricht stören',
                                  ),
                                  const Gap(5),
                                  SchooldayEventReasonFilterChip(
                                    isReason: watch(other).value,
                                    onSelected: (value) {
                                      other.value = value;
                                    },
                                    emojis: '📝',
                                    text: 'Sonstiges',
                                  ),
                                  const Gap(5),
                                ],
                              ),
                            ],
                          ),
                        ),
                ),
                const Gap(10),
                ElevatedButton(
                  style: AppStyles.successButtonStyle,
                  onPressed: () async {
                    if (schooldayEventType == SchooldayEventType.notSet) {
                      informationDialog(
                        context,
                        'Kein Ereignis ausgewählt',
                        'Bitte eine Ereignis-Art auswählen!',
                      );
                      return;
                    }
                    if (violenceAgainstPupils.value == false &&
                        violenceAgainstTeacher.value == false &&
                        violenceAgainstThings.value == false &&
                        insultOthers.value == false &&
                        annoyOthers.value == false &&
                        imminentDanger.value == false &&
                        ignoreTeacherInstructions.value == false &&
                        disturbLesson.value == false &&
                        learningDevelopmentInfo.value == false &&
                        learningSupportInfo.value == false &&
                        admonitionInfo.value == false &&
                        transitionAdvice.value == false &&
                        other.value == false) {
                      informationDialog(
                        context,
                        'Kein Grund ausgewählt',
                        'Bitte mindestens einen Grund auswählen!',
                      );
                      return;
                    }
                      unawaited(
                      postSchooldayEvent(
                        schooldayEventType: schooldayEventType,
                        thisDate: thisDate.value,
                        violenceAgainstPupils: violenceAgainstPupils.value,
                        violenceAgainstTeacher: violenceAgainstTeacher.value,
                        violenceAgainstThings: violenceAgainstThings.value,
                        imminentDanger: imminentDanger.value,

                        insultOthers: insultOthers.value,
                        annoyOthers: annoyOthers.value,
                        ignoreTeacherInstructions:
                            ignoreTeacherInstructions.value,
                        disturbLesson: disturbLesson.value,
                        learningDevelopmentInfo: learningDevelopmentInfo.value,
                        learningSupportInfo: learningSupportInfo.value,
                        admonitionInfo: admonitionInfo.value,
                        transitionAdvice: transitionAdvice.value,
                        other: other.value,
                        eventTime: eventTime.value,
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('SENDEN', style: AppStyles.buttonTextStyle),
                ),
                const Gap(15),
                ElevatedButton(
                  style: AppStyles.cancelButtonStyle,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'ABBRECHEN',
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

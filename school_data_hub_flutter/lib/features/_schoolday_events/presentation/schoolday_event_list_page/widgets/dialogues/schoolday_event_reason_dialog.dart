import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/models/schoolday_event_enums.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/new_schoolday_event_page/widgets/schoolday_event_filter_chip.dart';
import 'package:watch_it/watch_it.dart';

class SchooldayEventReasonDialog extends WatchingWidget {
  final SchooldayEvent schooldayEvent;

  const SchooldayEventReasonDialog({required this.schooldayEvent, super.key});

  @override
  Widget build(BuildContext context) {
    final violenceAgainstPupils = createOnce(
      () => ValueNotifier<bool>(
        schooldayEvent.eventReason.contains(
          SchooldayEventReason.violenceAgainstPupils.value,
        ),
      ),
    );
    final violenceAgainstTeacher = createOnce(
      () => ValueNotifier<bool>(
        schooldayEvent.eventReason.contains(
          SchooldayEventReason.violenceAgainstTeachers.value,
        ),
      ),
    );
    final violenceAgainstThings = createOnce(
      () => ValueNotifier<bool>(
        schooldayEvent.eventReason.contains(
          SchooldayEventReason.violenceAgainstThings.value,
        ),
      ),
    );
    final insultOthers = createOnce(
      () => ValueNotifier<bool>(
        schooldayEvent.eventReason.contains(
          SchooldayEventReason.insultOthers.value,
        ),
      ),
    );
    final annoyOthers = createOnce(
      () => ValueNotifier<bool>(
        schooldayEvent.eventReason.contains(
          SchooldayEventReason.annoyOthers.value,
        ),
      ),
    );
    final imminentDanger = createOnce(
      () => ValueNotifier<bool>(
        schooldayEvent.eventReason.contains(
          SchooldayEventReason.dangerousBehaviour.value,
        ),
      ),
    );
    final ignoreTeacherInstructions = createOnce(
      () => ValueNotifier<bool>(
        schooldayEvent.eventReason.contains(
          SchooldayEventReason.ignoreInstructions.value,
        ),
      ),
    );
    final disturbLesson = createOnce(
      () => ValueNotifier<bool>(
        schooldayEvent.eventReason.contains(
          SchooldayEventReason.disturbLesson.value,
        ),
      ),
    );
    final other = createOnce(
      () => ValueNotifier<bool>(
        schooldayEvent.eventReason.contains(SchooldayEventReason.other.value),
      ),
    );
    final learningDevelopmentInfo = createOnce(
      () => ValueNotifier<bool>(
        schooldayEvent.eventReason.contains(
          SchooldayEventReason.learningDevelopmentInfo.value,
        ),
      ),
    );
    final learningSupportInfo = createOnce(
      () => ValueNotifier<bool>(
        schooldayEvent.eventReason.contains(
          SchooldayEventReason.learningSupportInfo.value,
        ),
      ),
    );
    final admonitionInfo = createOnce(
      () => ValueNotifier<bool>(
        schooldayEvent.eventReason.contains(
          SchooldayEventReason.admonitionInfo.value,
        ),
      ),
    );

    return AlertDialog(
      title: const Text(
        'Grund bearbeiten',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: schooldayEvent.eventType == SchooldayEventType.parentsMeeting
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    children: [
                      SchooldayEventReasonFilterChip(
                        isReason: watch(learningDevelopmentInfo).value,
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
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    children: [
                      const Gap(5),
                      SchooldayEventReasonFilterChip(
                        isReason: watch(violenceAgainstPupils).value,
                        onSelected: (value) {
                          violenceAgainstPupils.value = value;
                        },
                        emojis: '🤜🤕',
                        text: 'Gewalt gegen Kinder',
                      ),
                      const Gap(5),
                      SchooldayEventReasonFilterChip(
                        isReason: watch(violenceAgainstTeacher).value,
                        onSelected: (value) {
                          violenceAgainstTeacher.value = value;
                        },
                        emojis: '🤜🎓️',
                        text: 'Gewalt gegen Erwachsene',
                      ),
                      const Gap(5),
                      SchooldayEventReasonFilterChip(
                        isReason: watch(violenceAgainstThings).value,
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
                        isReason: watch(ignoreTeacherInstructions).value,
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
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('ABBRECHEN', style: TextStyle(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () async {
            Set<String> schooldayEventReason = {};
            String schooldayEventReasons = '';
            if (violenceAgainstPupils.value == true) {
              schooldayEventReason.add(
                SchooldayEventReason.violenceAgainstPupils.value,
              );
            }

            if (violenceAgainstTeacher.value == true) {
              schooldayEventReason.add(
                SchooldayEventReason.violenceAgainstTeachers.value,
              );
            }

            if (violenceAgainstThings.value == true) {
              schooldayEventReason.add(
                SchooldayEventReason.violenceAgainstThings.value,
              );
            }

            if (imminentDanger.value == true) {
              schooldayEventReason.add(
                SchooldayEventReason.dangerousBehaviour.value,
              );
            }

            if (insultOthers.value == true) {
              schooldayEventReason.add(SchooldayEventReason.insultOthers.value);
            }

            if (annoyOthers.value == true) {
              schooldayEventReason.add(SchooldayEventReason.annoyOthers.value);
            }

            if (ignoreTeacherInstructions.value == true) {
              schooldayEventReason.add(
                SchooldayEventReason.ignoreInstructions.value,
              );
            }

            if (disturbLesson.value == true) {
              schooldayEventReason.add(
                SchooldayEventReason.disturbLesson.value,
              );
            }

            if (learningDevelopmentInfo.value == true) {
              schooldayEventReason.add(
                SchooldayEventReason.learningDevelopmentInfo.value,
              );
            }

            if (learningSupportInfo.value == true) {
              schooldayEventReason.add(
                SchooldayEventReason.learningSupportInfo.value,
              );
            }

            if (admonitionInfo.value == true) {
              schooldayEventReason.add(
                SchooldayEventReason.admonitionInfo.value,
              );
            }

            if (other.value == true) {
              schooldayEventReason.add(SchooldayEventReason.other.value);
            }

            for (final reason in schooldayEventReason) {
              schooldayEventReasons = '$schooldayEventReasons$reason*';
            }

            await di<SchooldayEventManager>().updateSchooldayEvent(
              eventToUpdate: schooldayEvent,
              reason: schooldayEventReasons,
            );

            if (context.mounted) {
              Navigator.pop(context);
            }
          },
          child: const Text('SPEICHERN', style: AppStyles.buttonTextStyle),
        ),
      ],
    );
  }
}

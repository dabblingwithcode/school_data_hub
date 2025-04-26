import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/schoolday_date_picker.dart';
import 'package:school_data_hub_flutter/features/schoolday/domain/schoolday_manager.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/models/schoolday_event_enums.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/schoolday_event_manager.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/presentation/new_schoolday_event_page/widgets/schoolday_event_filter_chip.dart';
import 'package:watch_it/watch_it.dart';

final _schooldayManager = di<SchooldayManager>();
final _schooldayEventManager = di<SchooldayEventManager>();

class NewSchooldayEventPage extends StatefulWidget {
  final int pupilId;

  const NewSchooldayEventPage({
    super.key,
    required this.pupilId,
  });

  @override
  NewSchooldayEventPageState createState() => NewSchooldayEventPageState();
}

class NewSchooldayEventPageState extends State<NewSchooldayEventPage> {
  SchooldayEventType schooldayEventTypeDropdown = SchooldayEventType.notSet;
  bool violenceAgainstPupils = false;
  bool violenceAgainstTeacher = false;
  bool violenceAgainstThings = false;
  bool insultOthers = false;
  bool annoyOthers = false;
  bool imminentDanger = false;
  bool ignoreTeacherInstructions = false;
  bool disturbLesson = false;
  bool other = false;
  bool learningDevelopmentInfo = false;
  bool learningSupportInfo = false;
  bool admonitionInfo = false;

  DateTime thisDate = _schooldayManager.thisDate.value;
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

  Future<void> postSchooldayEvent() async {
    Set<String> schooldayEventReason = {};
    String schooldayEventReasons = '';
    if (violenceAgainstPupils == true) {
      schooldayEventReason
          .add(SchooldayEventReason.violenceAgainstPupils.value);
    }

    if (violenceAgainstTeacher == true) {
      schooldayEventReason
          .add(SchooldayEventReason.violenceAgainstTeachers.value);
    }

    if (violenceAgainstThings == true) {
      schooldayEventReason
          .add(SchooldayEventReason.violenceAgainstThings.value);
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
      schooldayEventReason
          .add(SchooldayEventReason.learningDevelopmentInfo.value);
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

    for (final reason in schooldayEventReason) {
      schooldayEventReasons = '$schooldayEventReasons$reason*';
    }

    final Schoolday? schoolday = _schooldayManager.getSchooldayByDate(thisDate);

    // TODO: This is very optimistic. We should check if the schoolday is null and handle it properly.

    await _schooldayEventManager.postSchooldayEvent(widget.pupilId,
        schoolday!.id!, schooldayEventTypeDropdown, schooldayEventReasons);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: const Text(
          'Neues Ereignis',
          style: AppStyles.appBarTextStyle,
        ),
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
                  value: schooldayEventTypeDropdown,
                  onChanged: (SchooldayEventType? newValue) {
                    setState(() {
                      schooldayEventTypeDropdown = newValue!;
                    });
                  },
                  items: SchooldayEventType.values
                      .map<DropdownMenuItem<SchooldayEventType>>(
                          (SchooldayEventType value) {
                    return DropdownMenuItem<SchooldayEventType>(
                      value: value,
                      child: Text(
                        _getDropdownItemText(value),
                        style: TextStyle(
                            color: value == SchooldayEventType.notSet
                                ? Colors.red
                                : AppColors.backgroundColor,
                            fontSize: 20),
                      ),
                    );
                  }).toList(),
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
                        final DateTime? newDate =
                            await selectSchooldayDate(context, thisDate);
                        if (newDate != null) {
                          setState(() {
                            thisDate = newDate;
                          });
                        }
                      },
                      icon: const Icon(Icons.calendar_today_rounded,
                          color: AppColors.interactiveColor),
                    ),
                    InkWell(
                      onTap: () async {
                        final DateTime? newDate =
                            await selectSchooldayDate(context, thisDate);
                        if (newDate != null) {
                          setState(() {
                            thisDate = newDate;
                          });
                        }
                      },
                      child: Text(
                        thisDate.formatForUser(),
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
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const Gap(5),
                Expanded(
                  child: schooldayEventTypeDropdown == SchooldayEventType.notSet
                      ? const Center(
                          child: Text(
                          'Bitte eine Ereignis-Art auswählen!',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ))
                      : schooldayEventTypeDropdown ==
                              SchooldayEventType.parentsMeeting
                          ? SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    children: [
                                      SchooldayEventReasonFilterChip(
                                        isReason: learningDevelopmentInfo,
                                        onSelected: (value) {
                                          setState(() {
                                            learningDevelopmentInfo = value;
                                          });
                                        },
                                        emojis: '💡🧠',
                                        text: 'Lernentwicklung',
                                      ),
                                      const Gap(5),
                                      SchooldayEventReasonFilterChip(
                                        isReason: learningSupportInfo,
                                        onSelected: (value) {
                                          setState(() {
                                            learningSupportInfo = value;
                                          });
                                        },
                                        emojis: '🛟🧠',
                                        text: 'Förderung',
                                      ),
                                      const Gap(5),
                                      SchooldayEventReasonFilterChip(
                                        isReason: admonitionInfo,
                                        onSelected: (value) {
                                          setState(() {
                                            admonitionInfo = value;
                                          });
                                        },
                                        emojis: '⚠️ℹ️',
                                        text: 'Regelverstoß',
                                      ),
                                      const Gap(5),
                                      SchooldayEventReasonFilterChip(
                                        isReason: other,
                                        onSelected: (value) {
                                          setState(() {
                                            other = value;
                                          });
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
                                        isReason: violenceAgainstPupils,
                                        onSelected: (value) {
                                          setState(() {
                                            violenceAgainstPupils = value;
                                          });
                                        },
                                        emojis: '🤜🤕',
                                        text: 'Gewalt gegen Kinder',
                                      ),
                                      const Gap(5),
                                      SchooldayEventReasonFilterChip(
                                        isReason: violenceAgainstTeacher,
                                        onSelected: (value) {
                                          setState(() {
                                            violenceAgainstTeacher = value;
                                          });
                                        },
                                        emojis: '🤜🎓️',
                                        text: 'Gewalt gegen Erwachsene',
                                      ),
                                      const Gap(5),
                                      SchooldayEventReasonFilterChip(
                                        isReason: violenceAgainstThings,
                                        onSelected: (value) {
                                          setState(() {
                                            violenceAgainstThings = value;
                                          });
                                        },
                                        emojis: '🤜🏫',
                                        text: 'Gewalt gegen Sachen',
                                      ),
                                      const Gap(5),
                                      SchooldayEventReasonFilterChip(
                                        isReason: insultOthers,
                                        onSelected: (value) {
                                          setState(() {
                                            insultOthers = value;
                                          });
                                        },
                                        emojis: '🤬💔',
                                        text: 'Beleidigen',
                                      ),
                                      const Gap(5),
                                      SchooldayEventReasonFilterChip(
                                        isReason: annoyOthers,
                                        onSelected: (value) {
                                          setState(() {
                                            annoyOthers = value;
                                          });
                                        },
                                        emojis: '😈😖',
                                        text: 'Ärgern',
                                      ),
                                      const Gap(5),
                                      SchooldayEventReasonFilterChip(
                                        isReason: imminentDanger,
                                        onSelected: (value) {
                                          setState(() {
                                            imminentDanger = value;
                                          });
                                        },
                                        emojis: '🚨😱',
                                        text: 'Gefahr für sich/andere',
                                      ),
                                      const Gap(5),
                                      SchooldayEventReasonFilterChip(
                                        isReason: ignoreTeacherInstructions,
                                        onSelected: (value) {
                                          setState(() {
                                            ignoreTeacherInstructions = value;
                                          });
                                        },
                                        emojis: '🎓️🙉',
                                        text: 'Anweisungen ignorieren',
                                      ),
                                      const Gap(5),
                                      SchooldayEventReasonFilterChip(
                                        isReason: disturbLesson,
                                        onSelected: (value) {
                                          setState(() {
                                            disturbLesson = value;
                                          });
                                        },
                                        emojis: '🛑🎓️',
                                        text: 'Unterricht stören',
                                      ),
                                      const Gap(5),
                                      SchooldayEventReasonFilterChip(
                                        isReason: other,
                                        onSelected: (value) {
                                          setState(() {
                                            other = value;
                                          });
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
                    if (schooldayEventTypeDropdown ==
                        SchooldayEventType.notSet) {
                      informationDialog(context, 'Kein Ereignis ausgewählt',
                          'Bitte eine Ereignis-Art auswählen!');
                      return;
                    }
                    if (violenceAgainstPupils == false &&
                        violenceAgainstTeacher == false &&
                        violenceAgainstThings == false &&
                        insultOthers == false &&
                        annoyOthers == false &&
                        imminentDanger == false &&
                        ignoreTeacherInstructions == false &&
                        disturbLesson == false &&
                        learningDevelopmentInfo == false &&
                        learningSupportInfo == false &&
                        admonitionInfo == false &&
                        other == false) {
                      informationDialog(context, 'Kein Grund ausgewählt',
                          'Bitte mindestens einen Grund auswählen!');
                      return;
                    }
                    unawaited(postSchooldayEvent());
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'SENDEN',
                    style: AppStyles.buttonTextStyle,
                  ),
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

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the tree

    super.dispose();
  }
}

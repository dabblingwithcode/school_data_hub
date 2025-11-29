import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/filters/schoolday_event_filter_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/models/schoolday_event_enums.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:watch_it/watch_it.dart';

class SchooldayEventsCounts {
  final int totalSchooldayEvents;
  final int totalLessonSchooldayEvents;
  final int totalOgsSchooldayEvents;
  final int totalSentHomeSchooldayEvents;
  final int totalParentsMeetingSchooldayEvents;

  SchooldayEventsCounts({
    required this.totalSchooldayEvents,
    required this.totalLessonSchooldayEvents,
    required this.totalOgsSchooldayEvents,
    required this.totalSentHomeSchooldayEvents,
    required this.totalParentsMeetingSchooldayEvents,
  });
}

class SchoolDayEventHelper {
  static PupilsFilter get _pupilsFilter => di<PupilsFilter>();

  static SchooldayEventFilterManager get _schooldayEventFilterManager =>
      di<SchooldayEventFilterManager>();
  static HubSessionManager get _hubSessionManager => di<HubSessionManager>();
  static SchooldayEventManager get _schooldayEventManager =>
      di<SchooldayEventManager>();

  static int pupilsWithSchoolDayEvents() {
    final List<PupilProxy> pupils = _pupilsFilter.filteredPupils.value;
    int pupilsWithEvents = 0;
    for (PupilProxy pupil in pupils) {
      if (_schooldayEventFilterManager
          .filteredSchooldayEvents(
            _schooldayEventManager
                .getPupilSchooldayEventsProxy(pupil.pupilId)
                .schooldayEvents
                .values
                .toList(),
          )
          .isNotEmpty) {
        pupilsWithEvents++;
      }
    }
    return pupilsWithEvents;
  }

  static int schooldayEventSum(PupilProxy pupil) {
    return _schooldayEventFilterManager
        .filteredSchooldayEvents(
          _schooldayEventManager
              .getPupilSchooldayEventsProxy(pupil.pupilId)
              .schooldayEvents
              .values
              .toList(),
        )
        .length;
  }

  static bool isAuthorizedToChangeStatus(SchooldayEvent schooldayEvent) {
    if (_hubSessionManager.isAdmin == true ||
        schooldayEvent.createdBy ==
            _hubSessionManager.user!.userInfo!.userName!) {
      return true;
    }
    return false;
  }

  static DateTime getPupilLastSchooldayEventDate(PupilProxy pupil) {
    final List<SchooldayEvent> schooldayEvents = _schooldayEventFilterManager
        .filteredSchooldayEvents(
          _schooldayEventManager
              .getPupilSchooldayEventsProxy(pupil.pupilId)
              .schooldayEvents
              .values
              .toList(),
        );
    if (schooldayEvents.isEmpty) {
      // TODO: Watch out - why did we use this date?
      // if schoolday events is empty, we return a mock date
      return DateTime(2017, 9, 7, 17);
    }
    return getLastSchoolEventDate(schooldayEvents);
  }

  static int? findSchooldayEventIndex(PupilProxy pupil, DateTime date) {
    final int? foundSchooldayEventIndex = pupil.schooldayEvents?.indexWhere(
      (datematch) => (datematch.schoolday!.schoolday.isSameDate(date)),
    );
    if (foundSchooldayEventIndex == null) {
      return null;
    }
    return foundSchooldayEventIndex;
  }

  static bool pupilIsAdmonishedToday(PupilProxy pupil) {
    final pupilSchooldayEvents = _schooldayEventManager
        .getPupilSchooldayEventsProxy(pupil.pupilId)
        .schooldayEvents;
    if (pupilSchooldayEvents.isEmpty) return false;
    if (pupilSchooldayEvents.values.any(
      (element) =>
          element.schoolday!.schoolday.isSameDate(DateTime.now()) &&
          (element.eventType == SchooldayEventType.admonition ||
              element.eventType == SchooldayEventType.afternoonCareAdmonition ||
              element.eventType == SchooldayEventType.admonitionAndBanned),
    )) {
      return true;
    }
    return false;
  }

  static SchooldayEventsCounts getSchooldayEventsCounts(
    List<PupilProxy> pupils,
  ) {
    int totalSchooldayEvents = 0;
    int teachingSchooldayEvents = 0;
    int ogsSchooldayEvents = 0;
    int sentHomeSchooldayEvents = 0;
    int parentsMeetingSchooldayEvents = 0;

    for (PupilProxy pupil in pupils) {
      final pupilSchooldayEvents = _schooldayEventFilterManager
          .filteredSchooldayEvents(
            _schooldayEventManager
                .getPupilSchooldayEventsProxy(pupil.pupilId)
                .schooldayEvents
                .values
                .toList(),
          );

      totalSchooldayEvents = totalSchooldayEvents + pupilSchooldayEvents.length;
      teachingSchooldayEvents =
          teachingSchooldayEvents +
          pupilSchooldayEvents
              .where(
                (element) => element.eventType == SchooldayEventType.admonition,
              )
              .length;
      ogsSchooldayEvents =
          ogsSchooldayEvents +
          pupilSchooldayEvents
              .where(
                (element) =>
                    element.eventType ==
                    SchooldayEventType.afternoonCareAdmonition,
              )
              .length;
      sentHomeSchooldayEvents =
          sentHomeSchooldayEvents +
          pupilSchooldayEvents
              .where(
                (element) =>
                    element.eventType == SchooldayEventType.admonitionAndBanned,
              )
              .length;
      parentsMeetingSchooldayEvents =
          parentsMeetingSchooldayEvents +
          pupilSchooldayEvents
              .where(
                (element) =>
                    element.eventType == SchooldayEventType.parentsMeeting,
              )
              .length;
    }

    return SchooldayEventsCounts(
      totalSchooldayEvents: totalSchooldayEvents,
      totalLessonSchooldayEvents: teachingSchooldayEvents,
      totalOgsSchooldayEvents: ogsSchooldayEvents,
      totalSentHomeSchooldayEvents: sentHomeSchooldayEvents,
      totalParentsMeetingSchooldayEvents: parentsMeetingSchooldayEvents,
    );
  }

  static DateTime getLastSchoolEventDate(List<SchooldayEvent> schooldayEvents) {
    schooldayEvents.sort(
      (a, b) => b.schoolday!.schoolday.compareTo(a.schoolday!.schoolday),
    );
    return schooldayEvents.first.schoolday!.schoolday;
  }

  static int getOgsSchooldayEventCount(List<PupilProxy> pupils) {
    int schooldayEvents = 0;
    for (PupilProxy pupil in pupils) {
      if (pupil.schooldayEvents != null) {
        for (SchooldayEvent schooldayEvent in pupil.schooldayEvents!) {
          if (schooldayEvent.eventType ==
              SchooldayEventType.afternoonCareAdmonition) {
            schooldayEvents++;
          }
        }
      }
    }
    return schooldayEvents;
  }

  //- TODO: this should use  SchooldavEventType enum

  static String getSchooldayEventTypeText(SchooldayEventType value) {
    switch (value) {
      case SchooldayEventType.notSet:
        return 'bitte wählen';
      case SchooldayEventType.admonition:
        return '';
      case SchooldayEventType.afternoonCareAdmonition:
        return 'OGS';
      case SchooldayEventType.otherEvent:
        return 'Sonstiges';
      case SchooldayEventType.parentsMeeting:
        return 'Elterngespräch';
      default:
        return '';
    }
  }

  //- TODO: this should use  SchooldavEventReason enum

  static String getSchooldayEventReasonText(String value) {
    bool firstItem = true;
    String schooldayEventReasonText = '';

    if (value.contains(SchooldayEventReason.violenceAgainstPupils.value)) {
      schooldayEventReasonText =
          '${schooldayEventReasonText}Gewalt gegen Menschen';
      firstItem = false;
    }

    if (value.contains(SchooldayEventReason.violenceAgainstThings.value)) {
      if (firstItem == false) {
        schooldayEventReasonText = '$schooldayEventReasonText - ';
      }
      schooldayEventReasonText =
          '${schooldayEventReasonText}Gewalt gegen Sachen';
      firstItem = false;
    }
    if (value.contains(SchooldayEventReason.annoyOthers.value)) {
      if (firstItem == false) {
        schooldayEventReasonText = '$schooldayEventReasonText - ';
      }

      schooldayEventReasonText =
          // ignore: unnecessary_brace_in_string_interps
          '${schooldayEventReasonText}Ärgern anderer Kinder';
      firstItem = false;
    }

    if (value.contains(SchooldayEventReason.ignoreInstructions.value)) {
      if (firstItem == false) {
        schooldayEventReasonText = '$schooldayEventReasonText - ';
      }
      schooldayEventReasonText =
          '${schooldayEventReasonText}Ignorieren von Anweisungen';
      firstItem == false;
    }

    if (value.contains(SchooldayEventReason.disturbLesson.value)) {
      if (firstItem == false) {
        schooldayEventReasonText = '$schooldayEventReasonText - ';
      }
      schooldayEventReasonText =
          '${schooldayEventReasonText}Unterrichtsstörung';
      firstItem = false;
    }

    if (value.contains(SchooldayEventReason.other.value)) {
      if (firstItem == false) {
        schooldayEventReasonText = '$schooldayEventReasonText - ';
      }
      schooldayEventReasonText = '${schooldayEventReasonText}Sonstiges';
      firstItem = false;
    }
    return schooldayEventReasonText;
  }

  static int comparePupilsBySchooldayEventDate(PupilProxy a, PupilProxy b) {
    // Handle potential null cases with null-aware operators
    return (a.schooldayEvents?.isEmpty ?? true) ==
            (b.schooldayEvents?.isEmpty ?? true)
        ? compareLastSchooldayEventDates(a, b) // Handle empty or both empty
        : (a.schooldayEvents?.isEmpty ?? true)
        ? 1
        : -1; // Place empty after non-empty
  }

  static int comparePupilsByLastNonProcessedSchooldayEvent(
    PupilProxy a,
    PupilProxy b,
  ) {
    // Handle potential null cases with null-aware operators
    return (a.schooldayEvents?.isEmpty ?? true) ==
            (b.schooldayEvents?.isEmpty ?? true)
        ? compareLastSchooldayEventDates(a, b) // Handle empty or both empty
        : (a.schooldayEvents?.isEmpty ?? true)
        ? 1
        : -1; // Place empty after non-empty
  }

  static int compareLastSchooldayEventDates(PupilProxy a, PupilProxy b) {
    // Ensure non-empty lists before accessing elements
    if (a.schooldayEvents!.isNotEmpty && b.schooldayEvents!.isNotEmpty) {
      final schooldayEventA = a.schooldayEvents!.last.schoolday!.schoolday;
      final schooldayEventB = b.schooldayEvents!.last.schoolday!.schoolday;
      return schooldayEventB.compareTo(
        schooldayEventA,
      ); // Reversed for descending order
    } else {
      return 0;
    }
  }
}

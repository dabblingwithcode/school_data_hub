import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/filters/schoolday_event_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

final _pupilsFilter = di<PupilsFilter>();

final _schooldayEventFilterManager = di<SchooldayEventFilterManager>();
final _serverpodSessionManager = di<ServerpodSessionManager>();

class SchooldayEventsCounts {
  final int totalSchooldayEvents;
  final int totalLessonSchooldayEvents;
  final int totalOgsSchooldayEvents;
  final int totalSentHomeSchooldayEvents;
  final int totalParentsMeetingSchooldayEvents;

  SchooldayEventsCounts(
      {required this.totalSchooldayEvents,
      required this.totalLessonSchooldayEvents,
      required this.totalOgsSchooldayEvents,
      required this.totalSentHomeSchooldayEvents,
      required this.totalParentsMeetingSchooldayEvents});
}

class SchoolDayEventHelper {
  static int pupilsWithSchoolDayEvents() {
    final List<PupilProxy> pupils = _pupilsFilter.filteredPupils.value;
    int pupilsWithEvents = 0;
    for (PupilProxy pupil in pupils) {
      if (_schooldayEventFilterManager
          .filteredSchooldayEvents(pupil)
          .isNotEmpty) {
        pupilsWithEvents++;
      }
    }
    return pupilsWithEvents;
  }

  static int schooldayEventSum(PupilProxy pupil) {
    return _schooldayEventFilterManager.filteredSchooldayEvents(pupil).length;
  }

  static bool isAuthorizedToChangeStatus(SchooldayEvent schooldayEvent) {
    if (_serverpodSessionManager.isAdmin == true ||
        schooldayEvent.createdBy ==
            _serverpodSessionManager.user!.userInfo!.userName!) {
      return true;
    }
    return false;
  }

  static DateTime getPupilLastSchooldayEventDate(PupilProxy pupil) {
    final List<SchooldayEvent> schooldayEvents =
        _schooldayEventFilterManager.filteredSchooldayEvents(pupil);
    if (schooldayEvents.isEmpty) {
      // if schoolday events is empty, we return a mock date
      return DateTime(2017, 9, 7, 17);
    }
    return getLastSchoolEventDate(schooldayEvents);
  }

  static int? findSchooldayEventIndex(PupilProxy pupil, DateTime date) {
    final int? foundSchooldayEventIndex = pupil.schooldayEvents?.indexWhere(
        (datematch) => (datematch.schoolday!.schoolday.isSameDate(date)));
    if (foundSchooldayEventIndex == null) {
      return null;
    }
    return foundSchooldayEventIndex;
  }

  static bool pupilIsAdmonishedToday(PupilProxy pupil) {
    if (pupil.schooldayEvents!.isEmpty) return false;
    if (pupil.schooldayEvents!.any((element) =>
        element.schoolday!.schoolday.isSameDate(DateTime.now()) &&
        (element.eventType == SchooldayEventType.admonition ||
            element.eventType == SchooldayEventType.afternoonCareAdmonition ||
            element.eventType == SchooldayEventType.admonitionAndBanned))) {
      return true;
    }
    return false;
  }

  static SchooldayEventsCounts getSchooldayEventsCounts(
      List<PupilProxy> pupils) {
    int totalSchooldayEvents = 0;
    int teachingSchooldayEvents = 0;
    int ogsSchooldayEvents = 0;
    int sentHomeSchooldayEvents = 0;
    int parentsMeetingSchooldayEvents = 0;

    for (PupilProxy pupil in pupils) {
      final pupilSchooldayEvents =
          locator<SchooldayEventFilterManager>().filteredSchooldayEvents(pupil);

      totalSchooldayEvents = totalSchooldayEvents + pupilSchooldayEvents.length;
      teachingSchooldayEvents = teachingSchooldayEvents +
          pupilSchooldayEvents
              .where((element) =>
                  element.eventType == SchooldayEventType.admonition)
              .length;
      ogsSchooldayEvents = ogsSchooldayEvents +
          pupilSchooldayEvents
              .where((element) =>
                  element.eventType ==
                  SchooldayEventType.afternoonCareAdmonition)
              .length;
      sentHomeSchooldayEvents = sentHomeSchooldayEvents +
          pupilSchooldayEvents
              .where((element) =>
                  element.eventType == SchooldayEventType.admonitionAndBanned)
              .length;
      parentsMeetingSchooldayEvents = parentsMeetingSchooldayEvents +
          pupilSchooldayEvents
              .where((element) =>
                  element.eventType == SchooldayEventType.parentsMeeting)
              .length;
    }

    return SchooldayEventsCounts(
        totalSchooldayEvents: totalSchooldayEvents,
        totalLessonSchooldayEvents: teachingSchooldayEvents,
        totalOgsSchooldayEvents: ogsSchooldayEvents,
        totalSentHomeSchooldayEvents: sentHomeSchooldayEvents,
        totalParentsMeetingSchooldayEvents: parentsMeetingSchooldayEvents);
  }

  static DateTime getLastSchoolEventDate(List<SchooldayEvent> schooldayEvents) {
    schooldayEvents.sort(
        (a, b) => b.schoolday!.schoolday.compareTo(a.schoolday!.schoolday));
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

  static String getSchooldayEventTypeText(String value) {
    switch (value) {
      case 'choose':
        return 'bitte wählen';
      case 'rk':
        return '';
      case 'rkogs':
        return 'OGS';
      case 'other':
        return 'Sonstiges';
      case 'Eg':
        return 'Elterngespräch';
      default:
        return '';
    }
  }

  //- TODO: this should use  SchooldavEventReason enum

  static String getSchooldayEventReasonText(String value) {
    bool firstItem = true;
    String schooldayEventReasonText = '';

    if (value.contains(SchooldayEventReason.violenceAgainstPupils)) {
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
      PupilProxy a, PupilProxy b) {
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
      return schooldayEventB
          .compareTo(schooldayEventA); // Reversed for descending order
    } else {
      return 0;
    }
  }
}

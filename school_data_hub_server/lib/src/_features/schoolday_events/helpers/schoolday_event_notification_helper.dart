import 'dart:async';

import 'package:logging/logging.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/utils/matrix_notifications/matrix_notifications.dart';
import 'package:serverpod/serverpod.dart';

final Logger _log = Logger('SchooldayEventNotificationHelper');

class SchooldayEventNotificationHelper {
  /// Returns plain text notification message

  static Future<void> sendNotification({
    required Session session,
    required String pupilNameAndGroup,
    required String tutor,
    required SchooldayEvent eventWithSchoolday,
    required String dateTimeAsString,
    bool? changedProcessedStatus,
  }) async {
    try {
      final pupil = await PupilData.db.findFirstRow(session,
          where: (t) => t.id.equals(eventWithSchoolday.pupilId),
          include:
              PupilData.include(schooldayEvents: SchooldayEvent.includeList()));
      final numberOfEventsOfTheSameType = pupil?.schooldayEvents
              ?.where(
                  (event) => event.eventType == eventWithSchoolday.eventType)
              .length ??
          0;
      final recipients =
          await MatrixNotifications.instance.findNotificationRecipients(
        session: session,
        pupilNameAndGroup: pupilNameAndGroup,
        tutor: tutor,
      );

      // Send notification to all recipients
      if (recipients.isEmpty) {
        // Fallback to default recipient if no matches found
        _log.warning(
            'No recipients found for schoolday event ${eventWithSchoolday.id}');
        return;
      }

      unawaited(MatrixNotifications.instance.sendDirectTextMessage(
        session: session,
        recipients: recipients.toList(),
        text: _getSchooldayEventNotificationText(
            eventcreator: eventWithSchoolday.createdBy,
            pupilName: pupilNameAndGroup,
            dateTimeAsString: dateTimeAsString,
            schooldayEvent: eventWithSchoolday,
            numberOfEvents: numberOfEventsOfTheSameType),
        html: _getSchooldayEventNotificationHtml(
            eventcreator: eventWithSchoolday.createdBy,
            pupilName: pupilNameAndGroup,
            dateTimeAsString: dateTimeAsString,
            schooldayEvent: eventWithSchoolday,
            numberOfEvents: numberOfEventsOfTheSameType),
      ));
    } catch (e) {
      _log.severe('Error sending matrix notification: $e');
    }
  }
}

String _getEventTypeText(SchooldayEventType type) => switch (type) {
      SchooldayEventType.admonition => 'Rote Karte 🚫',
      SchooldayEventType.admonitionAndBanned => 'Rote Karte und Abholen 🚫🏠️',
      SchooldayEventType.afternoonCareAdmonition => 'Rote Karte OGS ⚠️🍽️',
      SchooldayEventType.parentsMeeting => 'Elterngespräch 👪💬',
      SchooldayEventType.otherEvent => 'Sonstiges 🗒️',
      // TODO: Handle this case.
      SchooldayEventType.notSet => '❓️',
    };

String _getEventReasonText(String reason) => reason
    .replaceAll('gm', '🤜🤕')
    .replaceAll('gl', '🤜🎓️')
    .replaceAll('gs', '🤜🏫')
    .replaceAll('ab', '🤬💔')
    .replaceAll('gv', '🚨😱')
    .replaceAll('äa', '😈😖')
    .replaceAll('il', '🎓️🙉')
    .replaceAll('us', '🛑🎓️')
    .replaceAll('ss', '📝')
    .replaceAll('le', '💡🧠')
    .replaceAll('fi', '🛟🧠')
    .replaceAll('ki', '⚠️ℹ️');

String _getSchooldayEventNotificationText(
    {required String eventcreator,
    required String pupilName,
    required String dateTimeAsString,
    required SchooldayEvent schooldayEvent,
    bool? processedStatusChange,
    int? numberOfEvents}) {
  final eventType = _getEventTypeText(schooldayEvent.eventType);
  final eventReason = _getEventReasonText(schooldayEvent.eventReason);

  return '''
$eventType
für $pupilName
$eventReason

von $eventcreator am $dateTimeAsString

${numberOfEvents != null ? 'Das ist die $numberOfEvents. Schulereignis für $pupilName.' : ''}
''';
}

/// Returns HTML formatted notification message for Matrix
String _getSchooldayEventNotificationHtml({
  required String eventcreator,
  required String pupilName,
  required String dateTimeAsString,
  required SchooldayEvent schooldayEvent,
  int? numberOfEvents,
  bool? processedStatusChange,
}) {
  final eventType = _getEventTypeText(schooldayEvent.eventType);
  final eventReason = _getEventReasonText(schooldayEvent.eventReason);

  // Escape HTML entities
  String escapeHtml(String text) {
    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#39;');
  }

  return '''
<h3><strong>${escapeHtml(eventType)}</strong></h3><p>für</p>
<h3><strong>${escapeHtml(pupilName)}</strong></h3>
<h4>Grund:</h4>
<p><strong>${escapeHtml(eventReason).replaceAll('*', '<br>')}</strong></p>
  ${processedStatusChange != null ? schooldayEvent.processed == true ? '<h3>Status: <strong>Bearbeitet von ${escapeHtml(eventcreator)} am ${escapeHtml(dateTimeAsString)}' : '<h3>Status: <strong>Nicht bearbeitet' : '<p>Eingetragen von <strong>${escapeHtml(eventcreator)}</strong> am <strong>${escapeHtml(dateTimeAsString)}</strong></p>'}

${numberOfEvents != null ? '<p>Das ist das <strong>$numberOfEvents</strong>. Schulereignis dieser Art für <strong>${escapeHtml(pupilName)}</strong>.</p>' : ''}
''';
}

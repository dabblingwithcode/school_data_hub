import 'package:school_data_hub_server/src/generated/protocol.dart';

/// Returns plain text notification message
String getSchooldayEventNotificationText(
    {required String eventcreator,
    required String pupilName,
    required String dateTimeAsString,
    required SchooldayEvent schooldayEvent,
    bool? processedStatusChange,
    int? numberOfEvents}) {
  final String eventType = switch (schooldayEvent.eventType) {
    SchooldayEventType.admonition => 'Rote Karte 🚫',
    SchooldayEventType.admonitionAndBanned => 'Rote Karte und Abholen 🚫🏠️',
    SchooldayEventType.afternoonCareAdmonition => 'Rote Karte OGS ⚠️🍽️',
    SchooldayEventType.parentsMeeting => 'Elterngespräch 👪💬',
    SchooldayEventType.otherEvent => 'Sonstiges 🗒️',
    // TODO: Handle this case.
    SchooldayEventType.notSet => '❓️',
  };
  final String eventReason = schooldayEvent.eventReason
      .replaceFirst('gm', '🤜🤕')
      .replaceFirst('gl', '🤜🎓️')
      .replaceFirst('gs', '🤜🏫')
      .replaceFirst('ab', '🤬💔')
      .replaceFirst('gv', '🚨😱')
      .replaceFirst('äa', '😈😖')
      .replaceFirst('il', '🎓️🙉')
      .replaceFirst('us', '🛑🎓️')
      .replaceFirst('ss', '📝')
      .replaceFirst('le', '💡🧠')
      .replaceFirst('fi', '🛟🧠')
      .replaceFirst('ki', '⚠️ℹ️');

  return '''
$eventType
für $pupilName
$eventReason

von $eventcreator am $dateTimeAsString

${numberOfEvents != null ? 'Das ist die $numberOfEvents. Schulereignis für $pupilName.' : ''}
''';
}

/// Returns HTML formatted notification message for Matrix
String getSchooldayEventNotificationHtml({
  required String eventcreator,
  required String pupilName,
  required String dateTimeAsString,
  required SchooldayEvent schooldayEvent,
  int? numberOfEvents,
  bool? processedStatusChange,
}) {
  final String eventType = switch (schooldayEvent.eventType) {
    SchooldayEventType.admonition => 'Rote Karte 🚫',
    SchooldayEventType.admonitionAndBanned => 'Rote Karte und Abholen 🚫🏠️',
    SchooldayEventType.afternoonCareAdmonition => 'Rote Karte OGS ⚠️🍽️',
    SchooldayEventType.parentsMeeting => 'Elterngespräch 👪💬',
    SchooldayEventType.otherEvent => 'Sonstiges 🗒️',
    SchooldayEventType.notSet => '❓️',
  };

  final String eventReason = schooldayEvent.eventReason
      .replaceFirst('gm', '🤜🤕 Gewalt gegen Kinder')
      .replaceFirst('gl', '🤜🎓️ Gewalt gegen Erwachsene')
      .replaceFirst('gs', '🤜🏫 Gewalt gegen Sachen')
      .replaceFirst('ab', '🤬💔 Beleidigen')
      .replaceFirst('gv', '🚨😱 Gefahr für sich/andere')
      .replaceFirst('äa', '😈😖 Ärgern')
      .replaceFirst('il', '🎓️🙉 Anweisungen ignorieren')
      .replaceFirst('us', '🛑🎓️ Unterricht stören')
      .replaceFirst('ss', '📝 Sonstiges')
      .replaceFirst('le', '💡🧠 Lernentwicklung')
      .replaceFirst('fi', '🛟🧠 Förderung')
      .replaceFirst('ki', '⚠️ℹ️ Regelverstoß');

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

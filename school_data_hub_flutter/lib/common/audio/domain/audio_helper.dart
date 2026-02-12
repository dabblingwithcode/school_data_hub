import 'package:path/path.dart' as p;

/// Supported audio file extensions.
const Set<String> audioExtensions = {'.m4a', '.aac', '.wav', '.mp3', '.ogg'};

/// Whether [documentId] represents an audio file based on its extension.
bool isAudioDocument(String documentId) {
  final ext = p.extension(documentId).toLowerCase();
  return audioExtensions.contains(ext);
}

/// Parses duration from documentId format: "00-01_839400e1-12c2-4d3a-894f-a715eac9b1ee.m4a"
/// Returns formatted string like "00:01" or "??:??" if parsing fails.
String parseDurationFromDocumentId(String documentId) {
  try {
    final durationString = documentId.split('_').first;
    if (durationString.length != 5) {
      return '??:??';
    }
    final parts = durationString.split('-');
    if (parts.length != 2) {
      return '??:??';
    }
    return '${parts.first}:${parts.last}';
  } catch (_) {
    return '??:??';
  }
}

/// Formats a [Duration] as "MM:SS".
String formatDuration(Duration d) {
  final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}

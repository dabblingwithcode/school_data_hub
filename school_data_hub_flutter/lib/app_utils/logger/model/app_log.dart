// Represents a single log entry for display
import 'package:logging/logging.dart';

class AppLog {
  final Level level;
  final String message;
  final String loggerName;
  final DateTime time;

  AppLog(this.level, this.message, this.loggerName) : time = DateTime.now();

  @override
  String toString() =>
      '[${time.toIso8601String().split('T').last.substring(0, 8)}] [${level.name}] [$loggerName] $message';
}

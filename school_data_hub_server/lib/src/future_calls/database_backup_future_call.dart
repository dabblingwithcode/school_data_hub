import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:serverpod/serverpod.dart';

class DatabaseBackupFutureCall extends FutureCall {
  @override
  Future<void> invoke(Session session, SerializableModel? object) async {
    try {
      final config = session.serverpod.config.database;
      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
      // uses current working directory as base path
      final currentDir = Directory.current.path;
      final backupPath =
          path.join(currentDir, 'database_backups', 'backup_$timestamp.sql');

      // Use absolute path for executable as recommended by [Process.run] notes
      const pgDumpAbsolutePath = r'C:\Program Files\PostgreSQL\17\bin\pg_dump';

      // Execute pg_dump command
      final result = await Process.run(
        pgDumpAbsolutePath,
        [
          '-h', config!.host,
          '-p', config.port.toString(),
          '-U', config.user,
          '-d', config.name,
          '-f', backupPath,
          //'-F', 'c', // Format flag (optional)
        ],
        runInShell: true,
        environment: {'PGPASSWORD': config.password},
      );

      if (result.exitCode != 0) {
        throw 'pg_dump failed: ${result.stderr}';
      }

      session.log('Database backup created at $backupPath');

      // Here you can schedule the next backup
      final nextBackupTime = DateTime.now()
          .add(Duration(days: 1))
          .copyWith(hour: 23, minute: 59, second: 0);

      unawaited(session.serverpod.futureCallAtTime(
        'databaseBackupFutureCall',
        null,
        nextBackupTime,
      ));
      session.log(
          'Database backup successful! Next backup scheduled at $nextBackupTime.',
          level: LogLevel.info);
    } catch (e) {
      session.log('Database backup failed: $e', level: LogLevel.error);

      // reschedule the backup in 1 hour
      final nextBackupTime = DateTime.now().add(Duration(hours: 1));
      unawaited(session.serverpod.futureCallAtTime(
        'databaseBackupFutureCall',
        null,
        nextBackupTime,
      ));
      session.log('Next backup scheduled at $nextBackupTime.',
          level: LogLevel.info);
    }
  }
}

import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

final _log = Logger('CreateLocalStorageDirectories');

void createLocalStorageDirectories() {
  try {
    _log.info('=== Starting storage directory creation ===');

    // Get the current working directory
    final serverDirPath = Directory.current.path;
    _log.info('Current working directory is [$serverDirPath]');

    // Determine storage path based on environment - same logic as server.dart
    String storagePath;

    if (Platform.isLinux && Directory('/app').existsSync()) {
      // Docker container environment
      storagePath = '/app/storage';
      _log.info('Detected Docker container environment, using: [$storagePath]');
    } else {
      // Local development environment
      storagePath = p.join(serverDirPath, 'storage');
      _log.info(
          'Detected local development environment, using: [$storagePath]');
    }

    final storageDir = Directory(storagePath);

    _log.info('Using storage directory: [$storagePath]');

    // Create the main storage directory if it doesn't exist
    if (!storageDir.existsSync()) {
      try {
        storageDir.createSync(recursive: true);
        _log.info('Created storage directory: [$storagePath]');
      } catch (e) {
        _log.severe('Could not create storage directory at [$storagePath]: $e');
        return;
      }
    } else {
      _log.info('Storage directory already exists: [$storagePath]');
    }

    // Create all required subdirectories
    final directories = [
      p.join(storagePath, 'public'),
      p.join(storagePath, 'public', 'serverpod'),
      p.join(storagePath, 'public', 'serverpod', 'user_images'),
      p.join(storagePath, 'private'),
      p.join(storagePath, 'private', 'auths'),
      p.join(storagePath, 'private', 'avatars'),
      p.join(storagePath, 'private', 'documents'),
      p.join(storagePath, 'private', 'events'),
      p.join(storagePath, 'temp'),
    ];

    for (final dirPath in directories) {
      final dir = Directory(dirPath);
      if (!dir.existsSync()) {
        try {
          dir.createSync(recursive: true);
          _log.fine('Created directory: [$dirPath]');
        } catch (e) {
          _log.warning('Could not create directory [$dirPath]: $e');
        }
      } else {
        _log.fine('Directory already exists: [$dirPath]');
      }
    }

    _log.info('Storage directories setup completed successfully');
    _log.info('=== Storage directory creation finished ===');
  } catch (e, stackTrace) {
    _log.severe('Error creating storage directories: $e\n$stackTrace');
  }
}

// IOSink _setupFileLogging() {
//   final logFile = File('storage_directories.log');
//   final logSink = logFile.openWrite(mode: FileMode.append);

//   Logger.root.onRecord.listen((record) {
//     if (record.loggerName == 'CreateLocalStorageDirectories') {
//       final logEntry =
//           '${record.time}: ${record.level.name}: ${record.message}\n';
//       logSink.write(logEntry);
//     }
//   });

//   return logSink;
// }

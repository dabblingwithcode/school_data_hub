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

    // Try multiple possible storage paths
    final possiblePaths = [
      p.join(serverDirPath, 'storage'),
      '/app/storage', // Docker container path
      'storage', // Relative path
    ];

    Directory? storageDir;
    String? selectedPath;

    // Find the first path that exists or can be created
    for (final path in possiblePaths) {
      final dir = Directory(path);
      _log.fine('Checking storage path: [${dir.path}]');

      if (dir.existsSync()) {
        storageDir = dir;
        selectedPath = path;
        _log.info('Using existing storage directory: [${dir.path}]');
        break;
      }

      // Try to create the directory
      try {
        dir.createSync(recursive: true);
        storageDir = dir;
        selectedPath = path;
        _log.info('Created storage directory: [${dir.path}]');
        break;
      } catch (e) {
        _log.warning('Could not create directory at [${dir.path}]: $e');
        continue;
      }
    }

    if (storageDir == null) {
      _log.severe('Could not create or find any storage directory!');
      return;
    }

    _log.info('Using storage directory: [${storageDir.path}]');

    // Create all required subdirectories
    final directories = [
      p.join(storageDir.path, 'public'),
      p.join(storageDir.path, 'public', 'serverpod'),
      p.join(storageDir.path, 'public', 'serverpod', 'user_images'),
      p.join(storageDir.path, 'private'),
      p.join(storageDir.path, 'private', 'auths'),
      p.join(storageDir.path, 'private', 'avatars'),
      p.join(storageDir.path, 'private', 'documents'),
      p.join(storageDir.path, 'private', 'events'),
      p.join(storageDir.path, 'temp'),
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

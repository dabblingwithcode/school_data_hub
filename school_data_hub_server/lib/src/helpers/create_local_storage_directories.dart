import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

final _log = Logger('CreateLocalStorageDirectories');

void createLocalStorageDirectories() {
  try {
    // Get the current working directory
    final serverDirPath = Directory.current.path;
    _log.fine('Current path is [$serverDirPath] .');
    // Create the directories for local storage
    final storageDir = Directory(p.join(serverDirPath, 'storage'));
    _log.fine('Storage path is [${storageDir.path}] .');
    // If the storage directory does not exist,
    // the subdirectories do not exist either
    if (storageDir.existsSync()) {
      _log.fine('Storage directory [${storageDir.path}] already exists.');
    } else {
      _log.warning(
        'Storage directory not found in [${storageDir.path}] - creating...',
      );
      storageDir.createSync(recursive: true);
      final publicDir = Directory(p.join(storageDir.path, 'public'));
      final serverpodDir = Directory(p.join(publicDir.path, 'serverpod'));
      final userImagesDir = Directory(p.join(serverpodDir.path, 'user_images'));
      final privateDir = Directory(p.join(storageDir.path, 'private'));
      final tempDir = Directory(p.join(storageDir.path, 'temp'));
      final authsDir = Directory(p.join(privateDir.path, 'auths'));
      final avatarsDir = Directory(p.join(privateDir.path, 'avatars'));
      final documentsDir = Directory(p.join(privateDir.path, 'documents'));
      final evertsDir = Directory(p.join(privateDir.path, 'events'));

      publicDir.createSync(recursive: true);
      serverpodDir.createSync(recursive: true);
      userImagesDir.createSync(recursive: true);
      tempDir.createSync(recursive: true);
      authsDir.createSync(recursive: true);
      avatarsDir.createSync(recursive: true);
      documentsDir.createSync(recursive: true);
      evertsDir.createSync(recursive: true);
      _log.fine(
        'Storage directories created successfully in [${storageDir.path}]',
      );
    }
  } finally {}
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

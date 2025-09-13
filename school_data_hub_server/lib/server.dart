import 'dart:developer';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:school_data_hub_server/src/future_calls/database_backup_future_call.dart';
import 'package:school_data_hub_server/src/future_calls/increase_credit_future_call.dart';
import 'package:school_data_hub_server/src/helpers/create_local_storage_directories.dart';
import 'package:school_data_hub_server/src/helpers/populate_test_environment.dart';
import 'package:school_data_hub_server/src/utils/local_storage.dart';
import 'package:school_data_hub_server/src/utils/logger/logrecord_formatter.dart';
import 'package:school_data_hub_server/src/web/routes/root.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';

// This is the starting point of your Serverpod server. In most cases, you will
// only need to make additions to this file if you add future calls,  are
// configuring Relic (Serverpod's web-server), or need custom setup work.

void run(List<String> args) async {
  // Set the global logging level
  Logger.root.level = Level.ALL;

  // Add your custom colored console listener
  Logger.root.onRecord.listen((record) {
    final colorFormatter = ColorFormatter();
    log(colorFormatter.format(record));
  });

  // Also add a simple console output for Docker environments
  // TODO ADVICE: Is this print bad in production?
  Logger.root.onRecord.listen((record) {
    print(
        '${record.time}: ${record.level.name}: ${record.loggerName}: ${record.message}');
  });
  // auth configuration
  auth.AuthConfig.set(auth.AuthConfig(
    enableUserImages: false,
    userCanEditUserName: false,
    userCanEditFullName: true,
    // other config options
  ));
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    authenticationHandler: auth.authenticationHandler,
  );

  // Configure storage with environment-aware paths
  String storageBasePath;

  // Determine storage path based on environment
  if (Platform.isLinux && Directory('/app').existsSync()) {
    // Docker container environment
    storageBasePath = '/app/storage';
  } else {
    // Local development environment
    storageBasePath = p.join(Directory.current.path, 'storage');
  }

  pod.addCloudStorage(LocalStorage(
    storageId: 'private',
    pathPrefix: p.join(storageBasePath, 'private'),
  ));
  pod.addCloudStorage(LocalStorage(
    storageId: 'public',
    pathPrefix: p.join(storageBasePath, 'public'),
  ));

  // If you are using any future calls, they need to be registered here.
  pod.registerFutureCall(
      DatabaseBackupFutureCall(), 'databaseBackupFutureCall');
  pod.registerFutureCall(
      IncreaseCreditFutureCall(), 'increaseCreditFutureCall');

  // Setup a default page at the web root.
  pod.webServer.addRoute(RouteRoot(), '/');
  pod.webServer.addRoute(RouteRoot(), '/index.html');
  // Serve all files in the /static directory.
  pod.webServer.addRoute(
    RouteStaticDirectory(serverDirectory: 'static', basePath: '/'),
    '/*',
  );

  // Start the server.
  await pod.start();

  // Create storage directories early
  createLocalStorageDirectories();

  var session = await pod.createSession();

  // Check if there are any users in the database. If not, we need to populate the test environment.
  final userCount = await auth.UserInfo.db.count(session);
  print('Current user count in database: $userCount');

  final adminUser = await auth.UserInfo.db.findFirstRow(
    session,
    where: (t) => t.fullName.equals('Administrator'),
  );
  if (adminUser == null) {
    print('No users found, populating test environment...');
    await populateTestEnvironment(session);
  } else {
    print('Users already exist, skipping test environment population');
  }

  // TODO: uncomment in production
  // Trigger the backup future call to generate database backups.
  // It will be triggered right away and after that it will recall itself every day at 2 AM.
  // TODO: automate deleting old backups after a certain time (30 days?).  // await session.serverpod.futureCallWithDelay(
  //   'databaseBackupFutureCall',
  //   null,
  //   const Duration(seconds: 1),
  // );

  await session.serverpod.futureCallWithDelay(
    'increaseCreditFutureCall',
    null,
    const Duration(seconds: 1),
  );
}

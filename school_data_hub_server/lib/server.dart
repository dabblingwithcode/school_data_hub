import 'dart:developer';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:school_data_hub_server/src/future_calls/database_backup_future_call.dart';
import 'package:school_data_hub_server/src/future_calls/increase_credit_future_call.dart';
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

  // Configure storage.
  // we use p.join to avoid issues with different OS path separators
  pod.addCloudStorage(LocalStorage(
    //publicStorageUrl: publicStorageUrl,
    storageId: 'private',
    pathPrefix: p.join('storage', 'private').toString(),
  ));
  pod.addCloudStorage(LocalStorage(
    storageId: 'public',
    pathPrefix: p.join('storage', 'public').toString(),
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

  var session = await pod.createSession();

  // Check if there are any users in the database. If not, we can populate the test environment.
  if (await auth.UserInfo.db.count(session) == 0) {
    await populateTestEnvironment(session);
  }
  createLocalStorageDirectories();

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

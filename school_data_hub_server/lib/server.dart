import 'package:school_data_hub_server/src/future_calls/database_backup_future_call.dart';
import 'package:school_data_hub_server/src/future_calls/increase_credit_future_call.dart';
import 'package:school_data_hub_server/src/future_calls/populate_support_categories_future_call.dart';
import 'package:school_data_hub_server/src/web/routes/root.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';

// This is the starting point of your Serverpod server. In most cases, you will
// only need to make additions to this file if you add future calls,  are
// configuring Relic (Serverpod's web-server), or need custom setup work.

void run(List<String> args) async {
  // auth configuration
  auth.AuthConfig.set(auth.AuthConfig(
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

  // If you are using any future calls, they need to be registered here.
  pod.registerFutureCall(
      DatabaseBackupFutureCall(), 'databaseBackupFutureCall');
  pod.registerFutureCall(
      IncreaseCreditFutureCall(), 'increaseCreditFutureCall');

  pod.registerFutureCall(PopulateSupportCategoriesFutureCall(),
      'populateSupportCategoriesFutureCall');

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

  // Populate support categories
  await session.serverpod.futureCallWithDelay(
    'populateSupportCategoriesFutureCall',
    null,
    const Duration(seconds: 1),
  );

  // Trigger the backup future call to run every day at 2 AM.
  await session.serverpod.futureCallWithDelay(
    'databaseBackupFutureCall',
    null,
    const Duration(seconds: 1),
  );

  await session.serverpod.futureCallWithDelay(
    'increaseCreditFutureCall',
    null,
    const Duration(seconds: 1),
  );

  // We need an admin user to manage the server.
  // TODO: This is a one-time setup step. You can comment this out after the first run.
  // It will create an admin user if it doesn't exist.

  try {
    // Check if admin user exists (using email as identifier)
    final adminEmail = 'admin@test.org'; // Use your preferred admin email
    var adminUser = await auth.Users.findUserByEmail(session, adminEmail);

    if (adminUser == null) {
      // Create admin user if it doesn't exist
      // For email authentication, you need to create a user with email/password
      final adminPassword = 'admin'; // Set a secure password in production

      // Create the user
      adminUser = await auth.Emails.createUser(
        session,
        'Admin User', // User name
        adminEmail,
        adminPassword,
      );

      if (adminUser != null) {
        // Grant admin scope to the user
        await auth.Users.updateUserScopes(
            session, adminUser.id!, {Scope.admin});

        session.log('Admin user created successfully: ');
        session.log('Email: $adminEmail');
        session
            .log('Password: $adminPassword'); // Log the password for reference
        session.log('Please change the password after the first login.');
      } else {
        session.log('Failed to create admin user');
      }
    } else {
      session.log('Admin user already exists');
    }
  } finally {
    session.close();
  }
}

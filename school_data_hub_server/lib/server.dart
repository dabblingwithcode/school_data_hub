import 'dart:developer';

import 'package:school_data_hub_server/src/web/routes/root.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';

// This is the starting point of your Serverpod server. In most cases, you will
// only need to make additions to this file if you add future calls,  are
// configuring Relic (Serverpod's web-server), or need custom setup work.

void run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    authenticationHandler: auth.authenticationHandler,
  );

  // If you are using any future calls, they need to be registered here.
  // pod.registerFutureCall(ExampleFutureCall(), 'exampleFutureCall');

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

  // We need an admin user to manage the server.
  // TODO: This is a one-time setup step. You can comment this out after the first run.
  // It will create an admin user if it doesn't exist.
  var session = await pod.createSession();
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

        log('Admin user created successfully: ');
        log('Email: $adminEmail');
        log('Password: $adminPassword'); // Log the password for reference
        log('Please change the password after the first login.');
      } else {
        log('Failed to create admin user');
      }
    } else {
      log('Admin user already exists');
    }
  } finally {
    session.close();
  }
}

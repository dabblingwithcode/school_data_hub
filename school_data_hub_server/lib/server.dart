import 'dart:developer';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:school_data_hub_server/src/future_calls/database_backup_future_call.dart';
import 'package:school_data_hub_server/src/future_calls/increase_credit_future_call.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/helpers/create_local_storage_directories.dart';
import 'package:school_data_hub_server/src/helpers/populate_test_environment.dart';
import 'package:school_data_hub_server/src/utils/local_storage.dart';
import 'package:school_data_hub_server/src/utils/logger/logrecord_formatter.dart';
import 'package:school_data_hub_server/src/utils/mailer.dart';
import 'package:school_data_hub_server/src/web/routes/root.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

import 'src/generated/endpoints.dart';

// This is the starting point of your Serverpod server. In most cases, you will
// only need to make additions to this file if you add future calls,  are
// configuring Relic (Serverpod's web-server), or need custom setup work.

void run(List<String> args) async {
  // Enable hierarchical logging to allow setting levels on non-root loggers
  Logger.root.level = Level.INFO;
  hierarchicalLoggingEnabled = true;

  // Reduce noise from mailer package SMTP connections
  Logger('Connection').level = Level.WARNING;

  // Add your custom colored console listener
  Logger.root.onRecord.listen((record) {
    final colorFormatter = ColorFormatter();
    log(colorFormatter.format(record));
  });
  final _logger = Logger('ServerpodInit');
  // Also add a simple console output for Docker environments

  // Logger.root.onRecord.listen((record) {
  //   print(
  //       '${record.time}: ${record.level.name}: ${record.loggerName}: ${record.message}');
  // });

  // auth configuration
  // TODO: configure this properly
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
  pod.loadCustomPasswords([
    (envName: 'MATRIX_SERVER_URL', alias: 'matrixServerUrl'),
    (envName: 'MATRIX_AUTH_TOKEN', alias: 'matrixAuthToken'),
    (envName: 'SERVERPOD_MAIL_USERNAME', alias: 'emailUsername'),
    (envName: 'SERVERPOD_MAIL_PASSWORD', alias: 'emailPassword'),
    (envName: 'SERVERPOD_MAIL_SMTP_HOST', alias: 'emailSmtpHost'),
    (envName: 'SERVERPOD_MAIL_ADMIN', alias: 'emailAdmin'),
  ]);
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

  // Initialize MailerService from environment variables if available
  final mailUsername = Serverpod.instance.getPassword('emailUsername');
  final mailPassword = Serverpod.instance.getPassword('emailPassword');
  final mailSmtpHost = Serverpod.instance.getPassword('emailSmtpHost');

  bool mailerInitialized = false;

  if (mailUsername != null &&
      mailPassword != null &&
      mailSmtpHost != null &&
      mailUsername.isNotEmpty &&
      mailPassword.isNotEmpty &&
      mailSmtpHost.isNotEmpty) {
    try {
      MailerService.instance.initialize(
        username: mailUsername,
        password: mailPassword,
        smtpHost: mailSmtpHost,
        smtpPort: 587, // Hardcoded as per requirements
        fromName: 'Schuldaten Benachrichtigungen',
        defaultRecipient: '',
      );
      mailerInitialized = true;
      _logger.info(
          'MailerService initialized successfully from environment variables');
    } catch (e) {
      _logger.severe('Failed to initialize MailerService: $e');
    }
  }

  // Try to initialize from session passwords as fallback
  if (!mailerInitialized) {
    final initialized = MailerService.instance.initializeFromSession(session);
    if (initialized) {
      mailerInitialized = true;
      _logger.info(
          'MailerService initialized successfully from session passwords');
    } else {
      _logger.warning(
          'Mail configuration not found in session passwords. Email functionality will not be available.');
    }
  }

  // Check if there are any users in the database. If not, we need to populate the test environment.
  final userCount = await session.db.count<User>();
  _logger.info('Current user count in database: $userCount');

  final adminUser = await auth.UserInfo.db.findFirstRow(
    session,
    where: (t) => t.fullName.equals('Administrator'),
  );
  if (adminUser == null) {
    _logger.warning('No users found, populating test environment...');
    await populateTestEnvironment(session);
  } else {
    _logger.info('Users already exist, skipping test environment population');
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

  // Send startup notification email
  try {
    final emailAdmin = Serverpod.instance.getPassword('emailAdmin');
    if (emailAdmin != null && emailAdmin.isNotEmpty) {
      final success = await MailerService.instance.sendNotification(
        recipient: emailAdmin,
        subject: 'Server Started',
        message: 'School Data Hub Server has started successfully.\n\n'
            'Timestamp: ${DateTime.now().toIso8601String()}\n'
            'User count: $userCount',
      );

      if (success) {
        _logger.info('Startup notification email sent successfully');
      } else {
        _logger.warning(
            'Failed to send startup notification email (service may not be initialized)');
      }
    } else {
      _logger.info(
          'Email admin address not configured, skipping startup notification');
    }
  } catch (e) {
    _logger.severe('Error sending startup notification email: $e');
  }
}

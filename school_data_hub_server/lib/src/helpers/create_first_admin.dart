import 'package:logging/logging.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

final _log = Logger('CreateFirstAdmin');

Future<User?> createFirstAdmin(
  Session session,
) async {
  //- Create test admin

  // For email authentication, we need to create a user with email/password
  final adminEmail = 'test';
  final adminPassword = 'test'; // Set a secure password in production

  // Create the userinfo
  var adminUser = await auth.Emails.createUser(
    session,
    'TES',
    adminEmail,
    adminPassword,
  );
  if (adminUser?.id == null) {
    _log.severe('Failed to create admin user');
    return null;
  }

  // Grant admin scope to the user
  await auth.Users.updateUserScopes(
      session, adminUser!.id!, {Scope('serverpod.admin')});

  adminUser.fullName = 'Administrator';
  await auth.UserInfo.db.updateRow(session, adminUser);

  final User hubUser = User(
      userInfoId: adminUser.id!,
      role: Role.admin,
      timeUnits: 28,
      reliefTimeUnits: 0,
      credit: 50,
      userFlags: UserFlags(
          isTester: true,
          confirmedTermsOfUse: false,
          confirmedPrivacyPolicy: false,
          changedPassword: false,
          madeFirstSteps: false));

  await session.db.insertRow(hubUser);

  _log.fine('Admin user created successfully: ');
  _log.fine('Email: admin');
  _log.fine('Password: admin'); // Log the password for reference
  _log.warning('You should NOT use this in production!');
  return hubUser;
}

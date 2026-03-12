import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

Future<User?> createFirstAdmin(
  Session session,
) async {
  //- Create test admin

  // For email authentication, we need to create a user with email/password
  final adminEmail = 'admin';
  final adminPassword = 'admin'; // Set a secure password in production

  // Create the userinfo
  var adminUser = await auth.Emails.createUser(
    session,
    'ADM',
    adminEmail,
    adminPassword,
  );
  if (adminUser?.id == null) {
    session.log('Failed to create admin user', level: LogLevel.error);
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

  session.log('Admin user created successfully: ', level: LogLevel.debug);
  session.log('Email: admin', level: LogLevel.debug);
  session.log('Password: admin', level: LogLevel.debug); // Log the password for reference
  session.log('You should NOT use this in production!', level: LogLevel.warning);
  return hubUser;
}

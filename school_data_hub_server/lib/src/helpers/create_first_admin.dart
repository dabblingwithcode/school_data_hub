import 'package:logging/logging.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

final _log = Logger('CreateFirstAdmin');

Future<User?> createFirstAdmin(
  Session session,
) async {
  //- Create test admin

  final adminEmail = 'admin';

  // For email authentication, you need to create a user with email/password
  final adminPassword = 'admin'; // Set a secure password in production

  // Create the userinfo
  var adminUser = await auth.Emails.createUser(
    session,
    'ADM',
    adminEmail,
    adminPassword,
  );
  if (adminUser?.id == null) {
    _log.severe('Failed to create admin user');
    return null;
  }

  adminUser!.fullName = 'Administrator';
  await auth.UserInfo.db.updateRow(session, adminUser);

  final User adminuser = User(
      userInfoId: adminUser.id!,
      role: Role.admin,
      timeUnits: 28,
      credit: 50,
      userFlags: UserFlags(
          confirmedTermsOfUse: false,
          confirmedPrivacyPolicy: false,
          changedPassword: false,
          madeFirstSteps: false));

  await session.db.insertRow(adminuser);
  // Grant admin scope to the user
  await auth.Users.updateUserScopes(session, adminUser.id!, {Scope.admin});

  _log.fine('Admin user created successfully: ');
  _log.fine('Email: admin');
  _log.fine('Password: admin'); // Log the password for reference
  _log.warning('You should NOT use this in production!');
  return adminuser;
}

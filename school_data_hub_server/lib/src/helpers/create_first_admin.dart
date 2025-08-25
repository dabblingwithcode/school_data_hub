import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

Future<User?> createFirstAdmin(
  Session session,
) async {
  //- Create test admin

  final adminEmail = 'admin';
  //  var adminUser = await auth.Users.findUserByEmail(session, adminEmail);

  // For email authentication, you need to create a user with email/password
  final adminPassword = 'admin'; // Set a secure password in production

  // Create the userinfo
  var adminUser = await auth.Emails.createUser(
    session,
    'ADM', // User name
    adminEmail,
    adminPassword,
  );

  if (adminUser != null) {
    // Grant admin scope to the user
    await auth.Users.updateUserScopes(session, adminUser.id!, {Scope.admin});

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

    return adminuser;
  }
  return null;
}

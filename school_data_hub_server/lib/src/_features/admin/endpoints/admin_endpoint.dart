import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:school_data_hub_server/src/_features/learning/helpers/import_competences_from_json_file.dart';
import 'package:school_data_hub_server/src/_features/learning_support/helpers/import_support_categories_from_file_content_json.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/helpers/convert_file_to_content_string.dart';
import 'package:school_data_hub_server/src/helpers/generate_pupil_from_admin_console_data.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

/// The endpoint for admin operations.
/// This endpoint requires the user to be logged in and have admin scope.
class AdminEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {Scope.admin};

  Future<User> createUser(
    Session session, {
    required String userName,
    required String fullName,
    required String email,
    required String password,
    required Role role,
    required int timeUnits,
    required List<String> scopeNames,
  }) async {
    session.log('Creating user: $userName, $email');
    final UserInfo? userInfo =
        await auth.Emails.createUser(session, userName, email, password);

    if (userInfo?.id == null) {
      throw 'Failed to create user';
    }
    // We need to do some updates to the user info object

    userInfo!.fullName = fullName;

    await auth.UserInfo.db.updateRow(session, userInfo);

    // Convert string scopes to Scope objects
    final scopes = scopeNames.map((name) => Scope(name)).toSet();

    // Create a new User object and insert it into the database
    final newUser = User(
      userInfoId: userInfo.id!,
      userFlags: UserFlags(
        confirmedTermsOfUse: false,
        confirmedPrivacyPolicy: false,
        changedPassword: false,
        madeFirstSteps: false,
      ),
      pupilsAuth: {},
      role: role,
      timeUnits: timeUnits,
      credit: 50,
    );

    await User.db.insertRow(session, newUser);

    // Update scopes if provided
    await auth.Users.updateUserScopes(session, userInfo.id!, scopes);

    return newUser;
  }

  Future<void> deleteUser(Session session, int userId) async {
    // Find the user by ID
    final user = await auth.Users.findUserByUserId(session, userId);
    if (user == null) {
      throw Exception('User not found.');
    }

    // TODO; for now no easy way to delete user from all tables, so just set blocked to true
    // await session.db.deleteRow(user);
    user.blocked = true;
  }

  Future<void> promoteUserScope(
      Session session, int userId, String scopeName) async {
    // Find the user by ID
    final user = await auth.Users.findUserByUserId(session, userId);
    if (user == null) {
      throw Exception('User not found.');
    }
    final Set<Scope> userscopes = {
      ...user.scopeNames.map((scope) => Scope(scope)).toSet(),
      Scope(scopeName)
    };
    // Add the scope to the user
    await auth.Users.updateUserScopes(session, user.id!, userscopes);
  }

  Future<void> demoteUserScope(
      Session session, int userId, String scopeName) async {
    // Find the user by ID
    final user = await auth.Users.findUserByUserId(session, userId);
    if (user == null) {
      throw Exception('User not found.');
    }
    final List<String> scopesWithoutDemotedScope =
        user.scopeNames.where((scope) => scope != scopeName).toList();
    final Set<Scope> userscopes = {
      ...scopesWithoutDemotedScope.map((scope) => Scope(scope)).toSet(),
      Scope(scopeName)
    };
    // Remove the scope from the user
    await auth.Users.updateUserScopes(session, user.id!, userscopes);
  }

  Future<User?> getUserById(Session session, int userId) async {
    final user = await User.db.findFirstRow(
      session,
      where: (t) => t.userInfoId.equals(userId),
    );
    return user;
  }

  Future<Set<PupilData>> updateBackendPupilDataState(
      Session session, String filePath) async {
    // check if the file is a txt or csv file
    final extension = filePath.split('.').last;
    if (extension != 'txt' && extension != 'csv') {
      throw Exception('File is not a compatible format!');
    }

    // Decode bytes to string (UTF-8 is common, but you can use other encodings)
    final content = await convertFileToContentString(session, filePath);

    // get all active pupils from the database and create a list
    final activePupils =
        await PupilData.db.find(session, where: (t) => t.active.equals(true));

    // we monitor the pupils that we haven't processed yet
    final List<PupilData> unprocessedPupilsList = List.from(activePupils);
    session.log('Unprocessed pupils: $unprocessedPupilsList');

    final List<String> lines = LineSplitter.split(content).toList();
    for (final line in lines) {
      // Check if the pupil is already in the database
      final PupilData? existingPupil = unprocessedPupilsList.firstWhereOrNull(
        (pupil) => pupil.internalId == int.parse(line.split(',')[0]),
      );

      if (existingPupil != null) {
        // If the pupil exists, we process it updating just the after care status
        // This is the second string of the line
        if (line.split(',')[1] == 'true') {
          // we just check if the after achool care is set
          // if it is already set we leave it alone
          // if not, we set the after school care as an empty object
          // the user will have to fill it later
          if (existingPupil.afterSchoolCare == null) {
            existingPupil.afterSchoolCare = AfterSchoolCare();

            await session.db.updateRow(existingPupil);
          } else {
            // the after school care is already set, we leave it alone
          }
        } else {
          // there is no entry for after School care
          // if the existing pupil has an after school care entry, we remove it
          if (existingPupil.afterSchoolCare != null) {
            existingPupil.afterSchoolCare = null;
            await session.db.updateRow(existingPupil);
          }
        }
        // we have processed the pupil, let's remove it from the unprocessed list
        unprocessedPupilsList.remove(existingPupil);
      } else {
        // If the pupil doesn't exist, we first need to check if it exists and should be activated
        // if it doesn't exist, we'll created a new one
        final inactivePupil = await PupilData.db.findFirstRow(
          session,
          where: (t) => t.internalId.equals(int.parse(line.split(',')[0])),
        );
        if (inactivePupil != null) {
          // If the pupil exists, we just activate it and update the after school care status
          inactivePupil.active = true;
          inactivePupil.afterSchoolCare =
              line.split(',')[1] == 'true' ? AfterSchoolCare() : null;
          await session.db.updateRow(inactivePupil);
        } else {
          final pupil = generatePupilfromExternalAdminConsoleData(line);

          await session.db.insertRow(pupil);
        }
      }
    }
    // if there are unprocessed pupils, they are not active in the school data system
    // we set them to inactive
    for (final pupil in unprocessedPupilsList) {
      pupil.active = false;
      await session.db.updateRow(pupil);
    }

    // we return the updated set of pupils that are active in the school data system
    final pupils = await PupilData.db.find(session);
    return pupils.toSet();
  }

  Future<List<Competence>> importCompetencesFromJsonFile(
      Session session, String filePath) async {
    final content = await convertFileToContentString(session, filePath);

    final categories = await importCompetencesFromFileContentJson(content);
    await Competence.db.insert(session, categories);
    return categories;
  }

  Future<List<SupportCategory>> importSupportCategoriesFromJsonFile(
      Session session, String filePath) async {
    final content = await convertFileToContentString(session, filePath);

    final categories =
        await importSupportCategoriesFromFileContentJson(content);
    await SupportCategory.db.insert(session, categories);
    return categories;
  }
}

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
  Set<Scope> get requiredScopes => {Scope('serverpod.admin')};

  Future<User> createUser(
    Session session, {
    required String userName,
    required String fullName,
    required String email,
    required String password,
    required Role role,
    required int timeUnits,
    required int reliefTimeUnits,
    required List<String> scopeNames,
    required bool isTester,
    String? schooldayEventsProcessingTeam,
    String? matrixUserId,
    int? credit,
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
    Set<Scope> scopes = {};

    for (final scope in scopeNames) {
      if (scope == 'admin') {
        scopes.add(Scope('serverpod.admin'));
      } else {
        scopes.add(Scope(scope));
      }
    }
    // Update scopes if provided
    await auth.Users.updateUserScopes(session, userInfo.id!, scopes);
    // Create a new User object and insert it into the database
    final newUser = User(
      userInfoId: userInfo.id!,
      userFlags: UserFlags(
        isTester: isTester,
        confirmedTermsOfUse: false,
        confirmedPrivacyPolicy: false,
        changedPassword: false,
        madeFirstSteps: false,
      ),
      pupilsAuth: {},
      role: role,
      timeUnits: timeUnits,
      reliefTimeUnits: reliefTimeUnits,
      credit: credit ?? 50,
      matrixUserId: matrixUserId,
    );

    await User.db.insertRow(session, newUser);

    return newUser;
  }

  Future<bool> resetPassword(
      Session session, String userEmail, String newPassword) async {
    final emailAuth = await EmailAuth.db.findFirstRow(
      session,
      where: (t) => t.email.equals(userEmail),
    );
    if (emailAuth == null) throw Exception('EmailAuth not found');
    emailAuth.hash = await auth.Emails.generatePasswordHash(newPassword);
    await auth.EmailAuth.db.updateRow(session, emailAuth);
    final user = await User.db.findFirstRow(session,
        where: (t) => t.userInfoId.equals(emailAuth.userId));
    if (user == null) throw Exception('User not found');
    user.userFlags = user.userFlags.copyWith(changedPassword: true);
    await User.db.updateRow(session, user);
    return true;
  }

  Future<void> deleteUser(Session session, int userId) async {
    // Find the user by ID
    final user = await auth.Users.findUserByUserId(session, userId);
    if (user == null) {
      throw Exception('User not found.');
    }

    // TODO; for now no flow to delete user from all tables, so just set blocked to true
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
    // read the file content
    final content = await convertFileToContentString(session, filePath);

    // get all active pupils from the database and create a list
    final activePupils = await PupilData.db
        .find(session, where: (t) => t.status.equals(PupilStatus.active));

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
          // we check if the after achool care is set
          // if it is already set we leave it alone
          // if not, we set the after school care as an empty object
          // the user will have to fill it later
          if (existingPupil.afterSchoolCare == null) {
            existingPupil.afterSchoolCare = AfterSchoolCare();

            await session.db.updateRow(existingPupil);
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
        // The pupil is not in the active pupils list
        // We first need to check if it exists but is inactive and should be activated
        // if it doesn't exist, we'll created a new one
        final inactivePupil = await PupilData.db.findFirstRow(
          session,
          where: (t) => t.internalId.equals(int.parse(line.split(',')[0])),
        );
        if (inactivePupil != null) {
          // If the pupil exists, we just activate it and update the after school care status
          inactivePupil.status = PupilStatus.active;
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
    // so we set them to inactive
    for (final pupil in unprocessedPupilsList) {
      pupil.status = PupilStatus.inactive;
      await session.db.updateRow(pupil);
    }

    // we return the updated set of pupils that are active in the school data system
    final pupils = await PupilData.db
        .find(session, where: (t) => t.status.equals(PupilStatus.active));
    return pupils.toSet();
  }

  Future<List<Competence>> importCompetencesFromJsonFile(
      Session session, String filePath) async {
    final content = await convertFileToContentString(session, filePath);

    final competences = await importCompetencesFromFileContentJson(content);

    final List<Competence> processedCompetences = [];

    for (final competence in competences) {
      // Check if competence exists by publicId
      final existingCompetence = await Competence.db.findFirstRow(
        session,
        where: (t) => t.publicId.equals(competence.publicId),
      );

      if (existingCompetence != null) {
        // Update existing competence
        final updatedCompetence = existingCompetence.copyWith(
          name: competence.name,
          parentCompetence: competence.parentCompetence,
          level: competence.level,
          indicators: competence.indicators,
        );
        await session.db.updateRow(updatedCompetence);
        processedCompetences.add(updatedCompetence);
      } else {
        // Create new competence
        await session.db.insertRow(competence);
        processedCompetences.add(competence);
      }
    }

    return processedCompetences;
  }

  Future<List<SupportCategory>> importSupportCategoriesFromJsonFile(
      Session session, String filePath) async {
    final content = await convertFileToContentString(session, filePath);

    final categories =
        await importSupportCategoriesFromFileContentJson(content);

    final List<SupportCategory> processedCategories = [];

    for (final category in categories) {
      // Check if support category exists by categoryId
      final existingCategory = await SupportCategory.db.findFirstRow(
        session,
        where: (t) => t.categoryId.equals(category.categoryId),
      );

      if (existingCategory != null) {
        // Update existing category
        final updatedCategory = existingCategory.copyWith(
          name: category.name,
          parentCategory: category.parentCategory,
        );
        await session.db.updateRow(updatedCategory);
        processedCategories.add(updatedCategory);
      } else {
        // Create new category
        await session.db.insertRow(category);
        processedCategories.add(category);
      }
    }

    return processedCategories;
  }

  Future<SchoolData> postSchoolData(
      Session session, SchoolData schoolData) async {
    final schooldataInDb = await session.db.insertRow(schoolData);
    return schooldataInDb;
  }
}

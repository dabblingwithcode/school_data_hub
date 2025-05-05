import 'dart:convert';
import 'dart:io';

import 'package:school_data_hub_server/src/endpoints/security/admin_endpoint.dart';
import 'package:school_data_hub_server/src/endpoints/competence_endpoint.dart';
import 'package:school_data_hub_server/src/endpoints/schoolday_admin_endpoint.dart';
import 'package:school_data_hub_server/src/endpoints/support_category_endpoint.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class PopulateTestEnvironmentFutureCall extends FutureCall {
  @override
  Future<void> invoke(Session session, SerializableModel? object) async {
    try {
      // Check if the tables are already populated
      // If not, populate them with fake data

      //-Competences

      final existingCompetences = await Competence.db.find(session);

      if (existingCompetences.isEmpty) {
        session.log('No competences in the database. Populating...',
            level: LogLevel.info);
        // Path to the JSON file containing containing the competences
        final competenceJsonFilePath = '../test_data/competence.json';
        final File file = File(competenceJsonFilePath);
        if (!file.existsSync()) {
          throw Exception('File not found: $file');
        }
        // Call the endpoint to import competences from the JSON file
        final competenceEndpoint = CompetenceEndpoint();
        await competenceEndpoint.importCompetencesFromJsonFile(session, file);
        session.log('Competences populated successfully!',
            level: LogLevel.info);
      }

      //- Support categories

      final existingCategories = await SupportCategory.db.find(session);

      if (existingCategories.isEmpty) {
        session.log('No support categories in the database. Populating...',
            level: LogLevel.info);
        // Path to the JSON file containing support categories
        final supportCategoriesjsonFilePath =
            '../test_data/support_category.json';
        // Call the endpoint to import support categories from the JSON file
        final supportCategoryEndpoint = SupportCategoryEndpoint();
        await supportCategoryEndpoint.importSupportCategoriesFromJsonFile(
            session, supportCategoriesjsonFilePath);
        session.log('Support categories populated successfully!',
            level: LogLevel.info);
      }

      //- Pupils

      final existingPupils = await PupilData.db.find(session);

      if (existingPupils.isEmpty) {
        session.log('No pupils in the database. Populating...',
            level: LogLevel.info);
        // Path to the JSON file containing support categories
        final pupilsFilePath = '../test_data/fake_pupils_export.txt';
        final pupilsFile = File(pupilsFilePath);
        if (!pupilsFile.existsSync()) {
          throw Exception('File not found: $pupilsFile');
        }
        // Call the endpoint to import support categories from the JSON file
        final adminEndpoint = AdminEndpoint();
        await adminEndpoint.updateBackendPupilDataState(session, pupilsFile);
        session.log('Pupils populated successfully!', level: LogLevel.info);
      }
      //- School semesters

      final existingSchoolSemesters = await SchoolSemester.db.find(session);
      if (existingSchoolSemesters.isEmpty) {
        session.log('No school semesters in the database. Populating...',
            level: LogLevel.info);
        final schoolSemesterFilePath = '../test_data/school_semester.json';
        final schoolSemesterFile = File(schoolSemesterFilePath);
        if (!schoolSemesterFile.existsSync()) {
          throw Exception('File not found: $schoolSemesterFile');
        }
        final jsonString = schoolSemesterFile.readAsStringSync();
        final schoolSemester = SchoolSemester.fromJson(jsonDecode(jsonString));

        SchoolSemester.db.insertRow(session, schoolSemester);
      }

      //- Schooldays

      final existingSchooldays = await Schoolday.db.find(session);

      if (existingSchooldays.isEmpty) {
        session.log('No school days in the database. Populating...',
            level: LogLevel.info);
        final schooldayEndpoint = SchooldayAdminEndpoint();
        await schooldayEndpoint.createSchooldays(session, _schoolDays);

        // final schooldaysFilePath = '../test_data/schoolday.json';

        // final schooldaysFile = File(schooldaysFilePath);

        // final jsonString = schooldaysFile.readAsStringSync();

        // final List<Map<String, dynamic>> jsonList = jsonDecode(jsonString);

        // await session.db.transaction((transaction) async {
        //   for (var jsonItem in jsonList) {
        //     final schoolday = Schoolday.fromJson(jsonItem);
        //     await Schoolday.db.insertRow(
        //       session,
        //       schoolday,
        //       transaction: transaction,
        //     );
        //   }
        // });

        session.log('Schooldays populated successfully!', level: LogLevel.info);
      }

      session.log('Test environment populated successfully!',
          level: LogLevel.info);
    } catch (e) {
      session.log('Error populating test environment: $e',
          level: LogLevel.error);
    }
  }
}

final List<DateTime> _schoolDays = [
  DateTime(2025, 2, 7),
  DateTime(2025, 2, 10),
  DateTime(2025, 2, 11),
  DateTime(2025, 2, 12),
  DateTime(2025, 2, 13),
  DateTime(2025, 2, 14),
  DateTime(2025, 2, 17),
  DateTime(2025, 2, 18),
  DateTime(2025, 2, 19),
  DateTime(2025, 2, 20),
  DateTime(2025, 2, 21),
  DateTime(2025, 2, 24),
  DateTime(2025, 2, 25),
  DateTime(2025, 2, 26),
  DateTime(2025, 2, 27),
  DateTime(2025, 2, 28),
  DateTime(2025, 3, 3),
  DateTime(2025, 3, 4),
  DateTime(2025, 3, 5),
  DateTime(2025, 3, 6),
  DateTime(2025, 3, 7),
  DateTime(2025, 3, 10),
  DateTime(2025, 3, 11),
  DateTime(2025, 3, 12),
  DateTime(2025, 3, 13),
  DateTime(2025, 3, 14),
  DateTime(2025, 3, 17),
  DateTime(2025, 3, 18),
  DateTime(2025, 3, 19),
  DateTime(2025, 3, 20),
  DateTime(2025, 3, 21),
  DateTime(2025, 3, 24),
  DateTime(2025, 3, 25),
  DateTime(2025, 3, 26),
  DateTime(2025, 3, 27),
  DateTime(2025, 3, 28),
  DateTime(2025, 3, 31),
  DateTime(2025, 4, 1),
  DateTime(2025, 4, 2),
  DateTime(2025, 4, 3),
  DateTime(2025, 4, 4),
  DateTime(2025, 4, 7),
  DateTime(2025, 4, 8),
  DateTime(2025, 4, 9),
  DateTime(2025, 4, 10),
  DateTime(2025, 4, 11),
  DateTime(2025, 4, 14),
  DateTime(2025, 4, 15),
  DateTime(2025, 4, 16),
  DateTime(2025, 4, 17),
  DateTime(2025, 4, 18),
  DateTime(2025, 4, 21),
  DateTime(2025, 4, 22),
  DateTime(2025, 4, 23),
  DateTime(2025, 4, 24),
  DateTime(2025, 4, 25),
  DateTime(2025, 4, 28),
  DateTime(2025, 4, 29),
  DateTime(2025, 4, 30),
  DateTime(2025, 5, 1),
  DateTime(2025, 5, 2),
  DateTime(2025, 5, 5),
  DateTime(2025, 5, 6),
  DateTime(2025, 5, 7),
  DateTime(2025, 5, 8),
  DateTime(2025, 5, 9),
  DateTime(2025, 5, 12),
  DateTime(2025, 5, 13),
  DateTime(2025, 5, 14),
  DateTime(2025, 5, 15),
  DateTime(2025, 5, 16),
  DateTime(2025, 5, 19),
  DateTime(2025, 5, 20),
  DateTime(2025, 5, 21),
  DateTime(2025, 5, 22),
  DateTime(2025, 5, 23),
  DateTime(2025, 5, 26),
  DateTime(2025, 5, 27),
  DateTime(2025, 5, 28),
  DateTime(2025, 5, 29),
  DateTime(2025, 5, 30),
  DateTime(2025, 6, 2),
  DateTime(2025, 6, 3),
  DateTime(2025, 6, 4),
  DateTime(2025, 6, 5),
  DateTime(2025, 6, 6),
  DateTime(2025, 6, 9),
  DateTime(2025, 6, 10),
  DateTime(2025, 6, 11),
  DateTime(2025, 6, 12),
  DateTime(2025, 6, 13),
  DateTime(2025, 6, 16),
  DateTime(2025, 6, 17),
  DateTime(2025, 6, 18),
  DateTime(2025, 6, 19),
  DateTime(2025, 6, 20),
  DateTime(2025, 6, 23),
  DateTime(2025, 6, 24),
  DateTime(2025, 6, 25),
  DateTime(2025, 6, 26),
  DateTime(2025, 6, 27),
  DateTime(2025, 6, 30),
  DateTime(2025, 7, 1),
  DateTime(2025, 7, 2),
  DateTime(2025, 7, 3),
  DateTime(2025, 7, 4),
  DateTime(2025, 7, 7),
  DateTime(2025, 7, 8),
  DateTime(2025, 7, 9),
  DateTime(2025, 7, 10),
  DateTime(2025, 7, 11),
];

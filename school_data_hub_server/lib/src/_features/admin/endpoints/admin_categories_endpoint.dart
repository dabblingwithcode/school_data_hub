import 'package:school_data_hub_server/src/_features/learning/competence/helpers/import_competences_from_json_file.dart';
import 'package:school_data_hub_server/src/_features/learning_support/helpers/import_support_categories_from_file_content_json.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/helpers/convert_file_to_content_string.dart';
import 'package:serverpod/serverpod.dart';

class AdminCategoriesEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {Scope('serverpod.admin')};
  Future<List<Competence>> importCompetencesFromJsonFile(
      Session session, String filePath) async {
    final content = await convertFileToContentString(session, filePath);

    final competences = await importCompetencesFromFileContentJson(content);

    return await session.db.transaction((transaction) async {
      final List<Competence> processedCompetences = [];

      for (final competence in competences) {
        // Check if competence exists by publicId
        final existingCompetence = await Competence.db.findFirstRow(
          session,
          where: (t) => t.publicId.equals(competence.publicId),
          transaction: transaction,
        );

        if (existingCompetence != null) {
          // Update existing competence
          final updatedCompetence = existingCompetence.copyWith(
            name: competence.name,
            parentCompetence: competence.parentCompetence,
            level: competence.level,
            indicators: competence.indicators,
          );
          await Competence.db
              .updateRow(session, updatedCompetence, transaction: transaction);
          processedCompetences.add(updatedCompetence);
        } else {
          // Create new competence
          final inserted = await Competence.db
              .insertRow(session, competence, transaction: transaction);
          processedCompetences.add(inserted);
        }
      }

      return processedCompetences;
    });
  }

  Future<List<SupportCategory>> importSupportCategoriesFromJsonFile(
      Session session, String filePath) async {
    final content = await convertFileToContentString(session, filePath);

    final categories =
        await importSupportCategoriesFromFileContentJson(content);

    return await session.db.transaction((transaction) async {
      final List<SupportCategory> processedCategories = [];

      for (final category in categories) {
        // Check if support category exists by categoryId
        final existingCategory = await SupportCategory.db.findFirstRow(
          session,
          where: (t) => t.categoryId.equals(category.categoryId),
          transaction: transaction,
        );

        if (existingCategory != null) {
          // Update existing category
          final updatedCategory = existingCategory.copyWith(
            name: category.name,
            parentCategory: category.parentCategory,
          );
          await SupportCategory.db
              .updateRow(session, updatedCategory, transaction: transaction);
          processedCategories.add(updatedCategory);
        } else {
          // Create new category
          final inserted = await SupportCategory.db
              .insertRow(session, category, transaction: transaction);
          processedCategories.add(inserted);
        }
      }

      return processedCategories;
    });
  }
}

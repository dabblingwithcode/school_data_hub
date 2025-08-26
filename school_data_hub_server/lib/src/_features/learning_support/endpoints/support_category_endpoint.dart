import 'package:school_data_hub_server/src/_features/learning_support/helpers/import_support_categories_from_file_content_json.dart'
    as helper;
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/helpers/convert_file_to_content_string.dart';
import 'package:serverpod/serverpod.dart';

class SupportCategoryEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<SupportCategory>> fetchSupportCategories(Session session) async {
    final categories = await SupportCategory.db.find(session);
    return categories;
  }

  Future<List<SupportCategory>> importSupportCategoriesFromJsonFile(
      Session session, String jsonFilePath) async {
    final fileContent = await convertFileToContentString(session, jsonFilePath);
    final categories =
        await helper.importSupportCategoriesFromFileContentJson(fileContent);
    await SupportCategory.db.insert(session, categories);
    return categories;
  }

  Future<bool> createSupportCategory(
      Session session, SupportCategory category) async {
    await session.db.insertRow(category);
    return true;
  }

  Future<bool> updateSupportCategory(
      Session session, SupportCategory category) async {
    await session.db.updateRow(category);
    return true;
  }

  Future<bool> deleteSupportCategory(
      Session session, SupportCategory category) async {
    await session.db.deleteRow<SupportCategory>(category);
    return true;
  }
}

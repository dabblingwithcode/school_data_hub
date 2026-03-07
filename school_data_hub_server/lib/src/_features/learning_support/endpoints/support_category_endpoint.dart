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
    await session.db.transaction((transaction) async {
      await SupportCategory.db
          .insert(session, categories, transaction: transaction);

      // Reset the auto-increment sequence so that future inserts don't collide
      // with the imported IDs.
      await session.db.unsafeExecute(
        "SELECT setval('support_category_id_seq', "
        "(SELECT COALESCE(MAX(id), 0) FROM support_category));",
      );
    });
    for (final c in categories) {
      session.messages.postMessage('hub_events_stream', c);
    }
    return categories;
  }

  Future<bool> createSupportCategory(
      Session session, SupportCategory category) async {
    // Ensure id is null so the database auto-generates it.
    final newCategory = category.copyWith(id: null);
    final inserted =
        await SupportCategory.db.insertRow(session, newCategory);
    session.messages.postMessage('hub_events_stream', inserted);
    return true;
  }

  Future<bool> updateSupportCategory(
      Session session, SupportCategory category) async {
    await session.db.updateRow(category);
    session.messages.postMessage('hub_events_stream', category);
    return true;
  }

  Future<bool> deleteSupportCategory(
      Session session, SupportCategory category) async {
    await session.db.deleteRow<SupportCategory>(category);
    session.messages.postMessage(
      'hub_events_stream',
      HubDeleteEvent(
        objectType: HubObjectType.supportCategory,
        id: category.categoryId,
      ),
    );
    return true;
  }
}

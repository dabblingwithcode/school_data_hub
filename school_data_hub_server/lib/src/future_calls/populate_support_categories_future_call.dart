import 'package:school_data_hub_server/src/endpoints/support_category_endpoint.dart';
import 'package:school_data_hub_server/src/generated/learning_support/support_category.dart';
import 'package:serverpod/serverpod.dart';

class PopulateSupportCategoriesFutureCall extends FutureCall {
  @override
  Future<void> invoke(Session session, SerializableModel? object) async {
    try {
      // Path to the JSON file containing support categories
      final jsonFilePath = '../test_data/support_category.json';

      // If there are support categories already in the database, skip the import
      final existingCategories = await SupportCategory.db.find(session);

      if (existingCategories.isNotEmpty) {
        session.log('Support categories already exist in the database.',
            level: LogLevel.info);
        return;
      }
      // Call the endpoint to import support categories from the JSON file
      final endpoint = SupportCategoryEndpoint();
      await endpoint.importSupportCategoriesFromJsonFile(session, jsonFilePath);

      session.log('Support categories populated successfully!',
          level: LogLevel.info);
    } catch (e) {
      session.log('Error populating support categories: $e',
          level: LogLevel.error);
    }
  }
}

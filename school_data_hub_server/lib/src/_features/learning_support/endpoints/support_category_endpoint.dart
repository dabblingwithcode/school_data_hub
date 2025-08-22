import 'dart:convert';
import 'dart:io';

import 'package:school_data_hub_server/src/generated/protocol.dart';
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
    final File file = File(jsonFilePath);
    if (!file.existsSync()) {
      throw Exception('File not found: $jsonFilePath');
    }
    final fileContent = await file.readAsString();
    if (fileContent.isEmpty) {
      throw Exception('File is empty: $jsonFilePath');
    }
    // Parse the JSON content
    final List<dynamic> jsonList = jsonDecode(fileContent);
    final List<SupportCategory> categories = jsonList.map((json) {
      return SupportCategory.fromJson(json as Map<String, dynamic>);
    }).toList();
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

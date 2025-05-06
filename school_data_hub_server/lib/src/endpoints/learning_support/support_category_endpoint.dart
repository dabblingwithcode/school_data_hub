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

  Future<SupportCategoryStatus> postCategoryStatus(
    Session session,
    int pupilId,
    int supportCategoryId,
    int status,
    String comment,
    String createdBy,
  ) async {
    final newSupportCategoryStatus = SupportCategoryStatus(
      pupilId: pupilId,
      supportCategoryId: supportCategoryId,
      comment: comment,
      status: status,
      createdBy: createdBy,
      createdAt: DateTime.now().toUtc(),
    );
    final statusInDatabase =
        await session.db.insertRow(newSupportCategoryStatus);
    return statusInDatabase;
  }

  Future<SupportCategoryStatus> updateCategoryStatus(
    Session session,
    int pupilId,
    int supportCategoryId,
    int? status,
    String? comment,
    String? createdBy,
    DateTime? createdAt,
  ) async {
    final existingStatus = await SupportCategoryStatus.db.findFirstRow(
      session,
      where: (t) =>
          t.pupilId.equals(pupilId) &
          t.supportCategoryId.equals(supportCategoryId),
    );
    if (existingStatus == null) {
      throw Exception(
          'SupportCategoryStatus not found for pupilId: $pupilId and supportCategoryId: $supportCategoryId');
    }
    final updatedStatus = existingStatus.copyWith(
      status: status ?? existingStatus.status,
      createdBy: createdBy ?? existingStatus.createdBy,
      createdAt: createdAt ?? existingStatus.createdAt,
      comment: comment ?? existingStatus.comment,
    );
    await session.db.updateRow(updatedStatus);
    return updatedStatus;
  }
}

import 'dart:convert';

import 'package:school_data_hub_server/src/generated/protocol.dart';

Future<List<SupportCategory>> importSupportCategoriesFromFileContentJson(
    String jsonContent) async {
  // Parse the JSON content
  final List<dynamic> jsonList = jsonDecode(jsonContent);
  final List<SupportCategory> categories = jsonList.map((json) {
    return SupportCategory.fromJson(json as Map<String, dynamic>);
  }).toList();

  return categories;
}

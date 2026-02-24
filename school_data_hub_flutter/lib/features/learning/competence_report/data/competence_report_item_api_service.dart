import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:flutter_it/flutter_it.dart';

class CompetenceReportItemApiService {
  Client get _client => di<Client>();

  Future<List<CompetenceReportItem>> fetchAllCompetenceReportItems() async {
    return _client.competenceReportItem.fetchAllCompetenceReportItems();
  }

  Future<CompetenceReportItem> postCompetenceReportItem({
    int? parentItem,
    required String name,
    List<String>? level,
    int? order,
  }) async {
    return _client.competenceReportItem.postCompetenceReportItem(
      parentItem: parentItem,
      name: name,
      level: level,
      order: order,
    );
  }

  Future<CompetenceReportItem> updateCompetenceReportItem(
    CompetenceReportItem item,
  ) async {
    return _client.competenceReportItem.updateCompetenceReportItem(item);
  }

  Future<bool> deleteCompetenceReportItem(int publicId) async {
    return _client.competenceReportItem.deleteCompetenceReportItem(publicId);
  }
}

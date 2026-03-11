import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';

class CompetenceReportItemApiService {
  Client get _client => di<Client>();

  Future<List<CompetenceReportItem>?> fetchAllCompetenceReportItems() async {
    return ClientHelper.apiCall(
      call: () => _client.competenceReportItem.fetchAllCompetenceReportItems(),
      errorMessage: 'Zeugniskompetenzen',
    );
  }

  Future<CompetenceReportItem?> postCompetenceReportItem({
    int? parentItem,
    required String name,
    List<String>? level,
    int? order,
  }) async {
    return ClientHelper.apiCall(
      call: () => _client.competenceReportItem.postCompetenceReportItem(
        parentItem: parentItem,
        name: name,
        level: level,
        order: order,
      ),
      errorMessage: 'Zeugniskompetenz erstellen',
    );
  }

  Future<CompetenceReportItem?> updateCompetenceReportItem(
    CompetenceReportItem item,
  ) async {
    return ClientHelper.apiCall(
      call: () => _client.competenceReportItem.updateCompetenceReportItem(item),
      errorMessage: 'Zeugniskompetenz aktualisieren',
    );
  }

  Future<bool?> deleteCompetenceReportItem(int publicId) async {
    return ClientHelper.apiCall(
      call: () => _client.competenceReportItem.deleteCompetenceReportItem(publicId),
      errorMessage: 'Zeugniskompetenz löschen',
    );
  }
}

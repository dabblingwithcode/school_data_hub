import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:watch_it/watch_it.dart';

final _client = di<Client>();

class WorkbookApiService {
  //- get workbooks

  Future<List<Workbook>?> getWorkbooks() async {
    final workbooks = ClientHelper.apiCall(
      call: () => _client.workbooks.fetchWorkbooks(),
      errorMessage: 'Fehler beim Laden der Arbeitshefte',
    );
    return workbooks;
  }

  Future<Workbook?> fetchWorkbookByIsbn(int isbn) async {
    final workbook = ClientHelper.apiCall(
      call: () => _client.workbooks.fetchWorkbookByIsbn(isbn),
      errorMessage: 'Fehler beim Laden des Arbeitshefts',
    );
    return workbook;
  }

  //- post new workbook

  Future<Workbook?> updateWorkbook({
    required Workbook workbook,
  }) async {
    final updatedWorkbook = await ClientHelper.apiCall(
      call: () => _client.workbooks.updateWorkbook(workbook),
      errorMessage: 'Fehler beim Aktualisieren des Arbeitshefts',
    );

    return updatedWorkbook;
  }

  Future<bool?> deleteWorkbook(int isbn) async {
    final success = await ClientHelper.apiCall(
      call: () => _client.workbooks.deleteWorkbook(isbn),
      errorMessage: 'Fehler beim Löschen des Arbeitshefts',
    );
    return success;
  }
}

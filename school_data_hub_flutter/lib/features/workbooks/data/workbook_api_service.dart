import 'dart:io';

import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/data/file_upload_service.dart';
import 'package:school_data_hub_flutter/common/models/enums.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:flutter_it/flutter_it.dart';

class WorkbookApiService {
  Client get _client => di<Client>();
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

  Future<Workbook?> updateWorkbook({required Workbook workbook}) async {
    final updatedWorkbook = await ClientHelper.apiCall(
      call: () => _client.workbooks.updateWorkbook(workbook),
      errorMessage: 'Fehler beim Aktualisieren des Arbeitshefts',
    );

    return updatedWorkbook;
  }

  Future<Workbook?> updateWorkbookImage({
    required int isbn,
    required File file,
  }) async {
    final result = await ClientFileUpload.uploadFile(
      file: file,
      storageId: StorageId.public,
      folder: ServerStorageFolder.events,
      customPath: 'workbook_$isbn.jpg',
    );
    if (result.cancelled || !result.success || result.path == null) {
      return null;
    }
    return await ClientHelper.apiCall(
      call: () => _client.workbooks.updateWorkbookImage(isbn, result.path!),
      errorMessage: 'Das Bild konnte nicht aktualisiert werden',
    );
  }

  Future<Workbook?> deleteWorkbookImage(int isbn) async {
    return await ClientHelper.apiCall(
      call: () => _client.workbooks.deleteWorkbookImage(isbn),
      errorMessage: 'Das Bild konnte nicht gelöscht werden',
    );
  }

  Future<bool?> deleteWorkbook(int isbn) async {
    final success = await ClientHelper.apiCall(
      call: () => _client.workbooks.deleteWorkbook(isbn),
      errorMessage: 'Fehler beim Löschen des Arbeitshefts',
    );
    return success;
  }
}

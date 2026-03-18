import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:school_data_hub_flutter/core/client/hub_stream_service.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/data/workbook_api_service.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/pupil_workbook_manager.dart';

final _log = Logger('WorkbookManager');

class WorkbookManager {
  final _workbookApiService = WorkbookApiService();
  StreamSubscription<dynamic>? _hubSubscription;

  final _notificationService = di<NotificationManager>();

  ValueListenable<List<Workbook>> get workbooks => _workbooks;

  final _workbooks = ValueNotifier<List<Workbook>>([]);

  WorkbookManager();

  void dispose() {
    _hubSubscription?.cancel();
    _hubSubscription = null;
    _workbooks.dispose();
  }

  Future<WorkbookManager> init() async {
    await fetchWorkbooks();
    _hubSubscription = di<HubStreamService>().events.listen(_onHubEvent);
    return this;
  }

  void _onHubEvent(dynamic event) {
    if (event is Workbook) {
      _log.fine('[STREAM] upsert workbook ${event.isbn}');
      _updateWorkbookInCollection(event);
    } else if (event is HubDeleteEvent) {
      if (event.objectType == HubObjectType.workbook) {
        _log.fine('[STREAM] delete workbook ${event.id}');
        _removeWorkbookFromCollectionById(event.id);
      }
    } else if (event is HubReconnected) {
      fetchWorkbooks();
    } else if (event is HubSelectiveReconnect) {
      if (event.changedTypes.contains(HubObjectType.workbook)) {
        fetchWorkbooks();
      }
    }
  }

  void clearData() {
    _workbooks.value = [];
  }

  void _updateWorkbookInCollection(Workbook workbook) {
    List<Workbook> workbooks = List.from(_workbooks.value);
    int index = workbooks.indexWhere((wb) => wb.isbn == workbook.isbn);
    if (index != -1) {
      workbooks[index] = workbook;
    } else {
      workbooks.add(workbook);
    }
    _workbooks.value = workbooks;
  }

  void _removeWorkbookFromCollection(int isbn) {
    List<Workbook> workbooks = List.from(_workbooks.value);
    int index = workbooks.indexWhere((wb) => wb.isbn == isbn);
    if (index != -1) {
      workbooks.removeAt(index);
    }
    _workbooks.value = workbooks;
  }

  void _removeWorkbookFromCollectionById(int id) {
    List<Workbook> workbooks = List.from(_workbooks.value);
    int index = workbooks.indexWhere((wb) => wb.id == id);
    if (index != -1) {
      workbooks.removeAt(index);
    }
    _workbooks.value = workbooks;
  }

  Future<void> fetchWorkbooks() async {
    final List<Workbook>? responseWorkbooks = await _workbookApiService
        .getWorkbooks();
    if (responseWorkbooks == null) {
      return;
    }
    // sort workbooks by name
    responseWorkbooks.sort((a, b) => a.name.compareTo(b.name));
    _log.info('Workbooks fetched: ${responseWorkbooks.length}');

    _workbooks.value = responseWorkbooks;

    return;
  }

  Future<void> fetchWorkbookByIsbn(int isbn) async {
    final Workbook? responseWorkbook = await _workbookApiService
        .fetchWorkbookByIsbn(isbn);
    if (responseWorkbook == null) {
      return;
    }
    _updateWorkbookInCollection(responseWorkbook);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Arbeitsheft erfolgreich geladen',
    );

    return;
  }

  Future<void> updateWorkbookProperty({
    required Workbook workbook,
    String? name,
    String? subject,
    String? level,
    int? amount,
  }) async {
    final Workbook workbookToUpdate = workbook.copyWith(
      name: name ?? workbook.name,
      subject: subject ?? workbook.subject,
      level: level ?? workbook.level,
      amount: amount ?? workbook.amount,
    );

    final updatedWorkbook = await ClientHelper.apiCall(
      call: () =>
          _workbookApiService.updateWorkbook(workbook: workbookToUpdate),
      errorMessage: 'Fehler beim Aktualisieren des Arbeitshefts',
    );
    if (updatedWorkbook == null) {
      return;
    }
    _updateWorkbookInCollection(updatedWorkbook);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Arbeitsheft erfolgreich aktualisiert',
    );

    return;
  }

  Future<void> postWorkbookFile(File imageFile, int isbn) async {
    final updatedWorkbook = await _workbookApiService.updateWorkbookImage(
      isbn: isbn,
      file: imageFile,
    );
    if (updatedWorkbook == null) return;
    _updateWorkbookInCollection(updatedWorkbook);
    _log.info('Workbook image updated for ISBN: $isbn');
  }

  Future<void> deleteWorkbookFile(int isbn) async {
    final updatedWorkbook = await _workbookApiService.deleteWorkbookImage(isbn);
    if (updatedWorkbook == null) return;
    _updateWorkbookInCollection(updatedWorkbook);
    _notificationService.showSnackBar(
      NotificationType.success,
      'Bild erfolgreich gelöscht',
    );
  }

  Future<void> deleteWorkbook(Workbook workbook) async {
    final success = await _workbookApiService.deleteWorkbook(workbook.isbn);
    if (success == null) {
      return;
    }

    _removeWorkbookFromCollection(workbook.isbn);
    _notificationService.showSnackBar(
      NotificationType.success,
      'Arbeitsheft erfolgreich gelöscht',
    );

    di<PupilWorkbookManager>().deleteAllPupilWorkbooks(workbook.isbn);

    return;
  }

  //- helper function
  Workbook? getWorkbookByIsbn(int? isbn) {
    if (isbn == null) return null;
    final Workbook? workbook = _workbooks.value.firstWhereOrNull(
      (element) => element.isbn == isbn,
    );
    return workbook;
  }

  //- helper function
  void updateWorkbookInRepositoryWithResponse(Workbook workbook) {
    List<Workbook> workbooks = List.from(_workbooks.value);
    int index = workbooks.indexWhere((wb) => wb.isbn == workbook.isbn);
    workbooks[index] = workbook;
    _workbooks.value = workbooks;
  }
}

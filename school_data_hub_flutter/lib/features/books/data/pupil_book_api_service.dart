import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/models/enums.dart';
import 'package:schuldaten_hub/common/domain/env_manager.dart';
import 'package:schuldaten_hub/common/domain/models/enums.dart';
import 'package:schuldaten_hub/common/services/api/api_client.dart';
import 'package:schuldaten_hub/common/services/api/api_settings.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_service.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/pupil/domain/models/pupil_data.dart';

class PupilBookApiService {
  final ApiClient _client = locator<ApiClient>();
  final _notificationService = locator<NotificationService>();

  String _baseUrl() {
    return locator<EnvManager>().env!.serverUrl;
  }
  //- get pupil books

  //- post new pupil book
  String _newPupilBookUrl({required int pupilId, required String bookId}) {
    return '/pupil_books/$pupilId/book/$bookId';
  }

  Future<PupilData> postNewPupilWorkbook(
      {required int pupilId, required String bookId}) async {
    _notificationService.apiRunning(true);

    final Response response = await _client.post(
      '${_baseUrl()}${_newPupilBookUrl(pupilId: pupilId, bookId: bookId)}',
      options: _client.hubOptions,
    );

    _notificationService.apiRunning(false);

    if (response.statusCode != 200) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Erstellen des Leihvorgangs');
      _notificationService.apiRunning(false);
      throw ApiException('Failed to create a pupil book', response.statusCode);
    }
    final PupilData pupil = PupilData.fromJson(response.data);

    return pupil;
  }

  //- delete pupil book
  String _deletePupilBook(String lendingId) {
    return '/pupil_books/$lendingId';
  }

  Future<PupilData> deletePupilBook(String lendingId) async {
    _notificationService.apiRunning(true);

    final Response response = await _client.delete(
      '${_baseUrl()}${_deletePupilBook(lendingId)}',
      options: _client.hubOptions,
    );

    _notificationService.apiRunning(false);

    if (response.statusCode != 200) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Löschen des Arbeitshefts');

      throw ApiException(
          'Failed to delete a pupil workbook', response.statusCode);
    }
    final PupilData pupil = PupilData.fromJson(response.data);

    return pupil;
  }

  String _patchPupilBook({required String lendingId}) {
    return '/pupil_books/$lendingId';
  }

  Future<PupilData> patchPupilBook({
    DateTime? lentAt,
    String? lentBy,
    String? state,
    int? rating,
    DateTime? returnedAt,
    String? receivedBy,
    required String lendingId,
  }) async {
    _notificationService.apiRunning(true);

    final data = jsonEncode({
      if (lentAt != null) 'lent_at': lentAt,
      if (lentBy != null) 'lent_by': lentBy,
      if (state != null) 'state': state,
      if (rating != null) 'rating': rating,
      if (returnedAt != null) 'returned_at': returnedAt.formatForJson(),
      if (receivedBy != null) 'received_by': receivedBy
    });

    final Response response = await _client.patch(
      '${_baseUrl()}${_patchPupilBook(lendingId: lendingId)}',
      data: data,
      options: _client.hubOptions,
    );

    _notificationService.apiRunning(false);

    if (response.statusCode != 200) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Aktualisieren des Leihvorgangs');

      throw ApiException(
          'Failed to update a pupil workbook', response.statusCode);
    }
    final PupilData pupil = PupilData.fromJson(response.data);

    return pupil;
  }
}

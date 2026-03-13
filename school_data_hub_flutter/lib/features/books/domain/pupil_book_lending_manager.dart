import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/core/client/file_upload_service.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/books/data/pupil_book_lending_api_service.dart';

class PupilBookLendingManager with ChangeNotifier {
  HubSessionManager get _hubSessionManager => di<HubSessionManager>();
  NotificationService get _notificationService => di<NotificationService>();

  final Map<int, List<PupilBookLending>> _pupilBookLendings = {};
  final Map<String, PupilBookLending> _lendingIdMap = {};
  final Map<int, List<PupilBookLending>> _isbnPupilBookLendingsMap = {};
  final _pupilBookLendingApiService = PupilBookLendingApiService();

  Future<PupilBookLendingManager> init() async {
    final allLendings = await _pupilBookLendingApiService
        .fetchAllPupilBookLendings();
    if (allLendings == null) {
      return this;
    }
    for (var lending in allLendings) {
      _addPupilBookLendingToCollections(lending);
    }

    return this;
  }

  List<PupilBookLending> getPupilBookLendings(int pupilId) {
    return _pupilBookLendings[pupilId] ?? [];
  }

  PupilBookLending? getLendingByLendingId(String lendingId) {
    return _lendingIdMap[lendingId];
  }

  List<PupilBookLending> get allPupilBookLendings {
    return _pupilBookLendings.values.expand((lendings) => lendings).toList();
  }

  void _addPupilBookLendingToCollections(PupilBookLending lending) {
    // Add to pupil-indexed map
    if (_pupilBookLendings.containsKey(lending.pupilId)) {
      _pupilBookLendings[lending.pupilId]!.add(lending);
    } else {
      _pupilBookLendings[lending.pupilId] = [lending];
    }
    if (lending.libraryBook != null) {
      final isbn = lending.isbn;
      if (_isbnPupilBookLendingsMap.containsKey(isbn)) {
        _isbnPupilBookLendingsMap[isbn]!.add(lending);
      } else {
        _isbnPupilBookLendingsMap[isbn] = [lending];
      }
    }
    // Add to lending ID map for quick lookups
    _lendingIdMap[lending.lendingId] = lending;
  }

  void _removePupilBookLendingFromCollections(PupilBookLending lending) {
    // Remove from pupil-indexed map
    if (_pupilBookLendings.containsKey(lending.pupilId)) {
      _pupilBookLendings[lending.pupilId]!.removeWhere(
        (l) => l.lendingId == lending.lendingId,
      );
      if (_pupilBookLendings[lending.pupilId]!.isEmpty) {
        _pupilBookLendings.remove(lending.pupilId);
      }
    }
    if (lending.libraryBook != null) {
      final isbn = lending.isbn;
      if (_isbnPupilBookLendingsMap.containsKey(isbn)) {
        _isbnPupilBookLendingsMap[isbn]!.removeWhere(
          (l) => l.lendingId == lending.lendingId,
        );
        if (_isbnPupilBookLendingsMap[isbn]!.isEmpty) {
          _isbnPupilBookLendingsMap.remove(isbn);
        }
      }
    }
    // Remove from lending ID map
    _lendingIdMap.remove(lending.lendingId);
  }

  void _updatePupilBookLendingInCollections(PupilBookLending lending) {
    // Update in pupil-indexed map
    if (_pupilBookLendings.containsKey(lending.pupilId)) {
      final index = _pupilBookLendings[lending.pupilId]!.indexWhere(
        (l) => l.lendingId == lending.lendingId,
      );
      if (index != -1) {
        _pupilBookLendings[lending.pupilId]![index] = lending;
      } else {
        _pupilBookLendings[lending.pupilId]!.add(lending);
      }
    } else {
      _pupilBookLendings[lending.pupilId] = [lending];
    }
    if (lending.libraryBook != null) {
      final isbn = lending.isbn;
      if (_isbnPupilBookLendingsMap.containsKey(isbn)) {
        final index = _isbnPupilBookLendingsMap[isbn]!.indexWhere(
          (l) => l.lendingId == lending.lendingId,
        );
        if (index != -1) {
          _isbnPupilBookLendingsMap[isbn]![index] = lending;
        } else {
          _isbnPupilBookLendingsMap[isbn]!.add(lending);
        }
      } else {
        _isbnPupilBookLendingsMap[isbn] = [lending];
      }
    }
    // Update in lending ID map
    _lendingIdMap[lending.lendingId] = lending;
  }

  void clearPupilBookLendings() {
    _pupilBookLendings.clear();
    _lendingIdMap.clear();
    notifyListeners();
  }

  //- API calls

  //- create

  Future<void> postPupilBookLending({
    required int pupilId,
    required String libraryId,
  }) async {
    final userName = _hubSessionManager.userName;
    if (userName == null) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Kein Benutzername gefunden',
      );
      return;
    }

    final lending = await _pupilBookLendingApiService.postPupilBookLending(
      pupilId: pupilId,
      libraryId: libraryId,
      lentBy: userName,
    );

    if (lending == null) {
      return;
    }

    _addPupilBookLendingToCollections(lending);
    notifyListeners();

    _notificationService.showSnackBar(
      NotificationType.success,
      'Buch ausgeliehen',
    );
  }

  //- update

  Future<void> updatePupilBookLending({
    required PupilBookLending pupilBookLending,
    DateTime? lentAt,
    String? lentBy,
    ({String? value})? status,
    ({int? value})? score,
    ({int? value})? bookScore,
    ({DateTime? value})? returnedAt,
    ({String? value})? receivedBy,
  }) async {
    final updatedBookLending = pupilBookLending.copyWith(
      lentAt: lentAt ?? pupilBookLending.lentAt,
      lentBy: lentBy ?? pupilBookLending.lentBy,
      status: status != null ? status.value : pupilBookLending.status,
      score: score != null ? score.value : pupilBookLending.score,
      bookScore: bookScore != null
          ? bookScore.value
          : pupilBookLending.bookScore,
      returnedAt: returnedAt != null
          ? returnedAt.value
          : pupilBookLending.returnedAt,
      receivedBy: receivedBy != null
          ? receivedBy.value
          : pupilBookLending.receivedBy,
    );

    final lending = await _pupilBookLendingApiService.updatePupilBookLending(
      bookLending: updatedBookLending,
    );

    if (lending == null) {
      return;
    }

    _updatePupilBookLendingInCollections(lending);
    notifyListeners();

    _notificationService.showSnackBar(
      NotificationType.success,
      'Leihvorgang aktualisiert',
    );
  }

  Future<void> returnLibraryBook({
    required PupilBookLending pupilBookLending,
  }) async {
    final updatedBookLending = pupilBookLending.copyWith(
      returnedAt: DateTime.now().toUtc(),
      receivedBy: _hubSessionManager.userName,
    );

    final lending = await _pupilBookLendingApiService.updatePupilBookLending(
      bookLending: updatedBookLending,
    );

    if (lending == null) {
      return;
    }

    _updatePupilBookLendingInCollections(lending);
    notifyListeners();

    _notificationService.showSnackBar(
      NotificationType.success,
      'Buch zurückgegeben',
    );
  }

  //- add book lending file
  Future<void> addPupilBookLendingFile(
    File file, {
    required PupilBookLending pupilBookLending,
    String? fileInfo,
  }) async {
    try {
      final encryptedFile = await customEncrypter.encryptFile(file);
      final fileResponse = await ClientFileUpload.uploadFile(
        file: encryptedFile,
        storageId: StorageId.private,
        folder: ServerStorageFolder.documents,
        fileInfo: fileInfo,
      );

      if (!fileResponse.success) {
        _notificationService.showSnackBar(
          NotificationType.error,
          'Die Datei konnte nicht hochgeladen werden!',
        );
        return;
      }

      final pupilBookLendingWithFile = await _pupilBookLendingApiService
          .addFileToPupilBookLending(
            lendingId: pupilBookLending.lendingId,
            filePath: fileResponse.path!,
            addedBy: _hubSessionManager.userName!,
          );

      if (pupilBookLendingWithFile == null) {
        return;
      }

      _updatePupilBookLendingInCollections(pupilBookLendingWithFile);
      notifyListeners();

      _notificationService.showSnackBar(
        NotificationType.success,
        'Datei zum Leihvorgang hinzugefügt',
      );
    } catch (e) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Hochladen der Datei: $e',
      );
    }
  }

  //- delete file from lending
  Future<void> deletePupilBookLendingFile({
    required PupilBookLending pupilBookLending,
    required String fileId,
  }) async {
    try {
      final success = await _pupilBookLendingApiService
          .removeFileFromPupilBookLending(
            lendingId: pupilBookLending.lendingId,
            fileId: fileId,
          );

      if (success == null) {
        return;
      }
      pupilBookLending.pupilBookLendingFiles!.removeWhere(
        (file) => file.documentId == fileId,
      );

      notifyListeners();

      _notificationService.showSnackBar(
        NotificationType.success,
        'Datei aus Leihvorgang entfernt',
      );
    } catch (e) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Löschen der Datei: $e',
      );
    }
  }

  //- delete

  Future<void> deletePupilBookLending({required String lendingId}) async {
    final existingLending = _lendingIdMap[lendingId];
    if (existingLending == null) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Leihvorgang nicht gefunden',
      );
      return;
    }

    final success = await _pupilBookLendingApiService.deletePupilBookLending(
      lendingId: lendingId,
    );

    if (success != true) {
      return;
    }

    _removePupilBookLendingFromCollections(existingLending);
    notifyListeners();

    _notificationService.showSnackBar(
      NotificationType.success,
      'Leihvorgang gelöscht',
    );
  }

  @override
  void dispose() {
    _pupilBookLendings.clear();
    _lendingIdMap.clear();
    super.dispose();
  }
}

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/core/client/file_upload_service.dart';
import 'package:school_data_hub_flutter/core/client/hub_stream_service.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/books/data/pupil_book_lending_api_service.dart';

class PupilBookLendingManager with ChangeNotifier {
  HubSessionManager get _hubSessionManager => di<HubSessionManager>();
  NotificationManager get _notificationService => di<NotificationManager>();
  final _log = Logger('PupilBookLendingManager');
  StreamSubscription<dynamic>? _hubSubscription;

  final Map<int, List<PupilBookLending>> _pupilBookLendings = {};
  final Map<int, List<PupilBookLending>> _userBookLendings = {};
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

    _hubSubscription = di<HubStreamService>().events.listen(_onHubEvent);

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

  List<PupilBookLending> getUserBookLendings(int userId) {
    return _userBookLendings[userId] ?? [];
  }

  List<PupilBookLending> get allUserBookLendings {
    return _userBookLendings.values.expand((lendings) => lendings).toList();
  }

  List<PupilBookLending> get allLendings {
    return _lendingIdMap.values.toList();
  }

  PupilBookLending? getActiveLendingByLibraryBookId(int libraryBookId) {
    return _lendingIdMap.values.cast<PupilBookLending?>().firstWhere(
      (l) => l!.libraryBookId == libraryBookId && l.returnedAt == null,
      orElse: () => null,
    );
  }

  void _addPupilBookLendingToCollections(PupilBookLending lending) {
    // Add to pupil-indexed or user-indexed map
    if (lending.borrowerType == 'user' && lending.borrowerUserId != null) {
      _userBookLendings
          .putIfAbsent(lending.borrowerUserId!, () => [])
          .add(lending);
    } else {
      _pupilBookLendings.putIfAbsent(lending.pupilId!, () => []).add(lending);
    }
    if (lending.libraryBook != null) {
      final isbn = lending.isbn;
      _isbnPupilBookLendingsMap.putIfAbsent(isbn, () => []).add(lending);
    }
    // Add to lending ID map for quick lookups
    _lendingIdMap[lending.lendingId] = lending;
  }

  void _removePupilBookLendingFromCollections(PupilBookLending lending) {
    // Remove from pupil-indexed or user-indexed map
    if (lending.borrowerType == 'user' && lending.borrowerUserId != null) {
      final userId = lending.borrowerUserId!;
      _userBookLendings[userId]?.removeWhere(
        (l) => l.lendingId == lending.lendingId,
      );
      if (_userBookLendings[userId]?.isEmpty ?? false) {
        _userBookLendings.remove(userId);
      }
    } else {
      _pupilBookLendings[lending.pupilId]?.removeWhere(
        (l) => l.lendingId == lending.lendingId,
      );
      if (_pupilBookLendings[lending.pupilId]?.isEmpty ?? false) {
        _pupilBookLendings.remove(lending.pupilId);
      }
    }
    if (lending.libraryBook != null) {
      final isbn = lending.isbn;
      _isbnPupilBookLendingsMap[isbn]?.removeWhere(
        (l) => l.lendingId == lending.lendingId,
      );
      if (_isbnPupilBookLendingsMap[isbn]?.isEmpty ?? false) {
        _isbnPupilBookLendingsMap.remove(isbn);
      }
    }
    // Remove from lending ID map
    _lendingIdMap.remove(lending.lendingId);
  }

  void _updatePupilBookLendingInCollections(PupilBookLending lending) {
    // Update in pupil-indexed or user-indexed map
    if (lending.borrowerType == 'user' && lending.borrowerUserId != null) {
      final userId = lending.borrowerUserId!;
      final list = _userBookLendings.putIfAbsent(userId, () => []);
      final index = list.indexWhere((l) => l.lendingId == lending.lendingId);
      if (index != -1) {
        list[index] = lending;
      } else {
        list.add(lending);
      }
    } else {
      final list = _pupilBookLendings.putIfAbsent(lending.pupilId!, () => []);
      final index = list.indexWhere((l) => l.lendingId == lending.lendingId);
      if (index != -1) {
        list[index] = lending;
      } else {
        list.add(lending);
      }
    }
    if (lending.libraryBook != null) {
      final isbn = lending.isbn;
      final list = _isbnPupilBookLendingsMap.putIfAbsent(isbn, () => []);
      final index = list.indexWhere((l) => l.lendingId == lending.lendingId);
      if (index != -1) {
        list[index] = lending;
      } else {
        list.add(lending);
      }
    }
    // Update in lending ID map
    _lendingIdMap[lending.lendingId] = lending;
  }

  void clearPupilBookLendings() {
    _pupilBookLendings.clear();
    _userBookLendings.clear();
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

  Future<void> postUserBookLending({
    required int userId,
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

    final lending = await _pupilBookLendingApiService.postUserBookLending(
      userId: userId,
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

  //- Hub stream handlers

  void _onHubEvent(dynamic event) {
    if (event is PupilBookLending) {
      _upsertFromStream(event);
    } else if (event is HubDeleteEvent &&
        event.objectType == HubObjectType.pupilBookLending) {
      _deleteFromStream(event.id);
    } else if (event is HubReconnected) {
      _refetchAll();
    } else if (event is HubSelectiveReconnect) {
      if (event.changedTypes.contains(HubObjectType.pupilBookLending)) {
        _refetchAll();
      }
    }
  }

  void _upsertFromStream(PupilBookLending lending) {
    _log.fine('[STREAM] upsert pupilBookLending ${lending.id}');
    _updatePupilBookLendingInCollections(lending);
    notifyListeners();
  }

  void _deleteFromStream(int id) {
    _log.fine('[STREAM] delete pupilBookLending $id');
    // Find the lending by id in the lending ID map
    final found = _lendingIdMap.values.cast<PupilBookLending?>().firstWhere(
      (l) => l!.id == id,
      orElse: () => null,
    );
    if (found != null) {
      _removePupilBookLendingFromCollections(found);
      notifyListeners();
    }
  }

  Future<void> _refetchAll() async {
    _pupilBookLendings.clear();
    _userBookLendings.clear();
    _lendingIdMap.clear();
    _isbnPupilBookLendingsMap.clear();
    final allLendings = await _pupilBookLendingApiService
        .fetchAllPupilBookLendings();
    if (allLendings == null) return;
    for (var lending in allLendings) {
      _addPupilBookLendingToCollections(lending);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _hubSubscription?.cancel();
    _hubSubscription = null;
    _pupilBookLendings.clear();
    _userBookLendings.clear();
    _lendingIdMap.clear();
    super.dispose();
  }
}

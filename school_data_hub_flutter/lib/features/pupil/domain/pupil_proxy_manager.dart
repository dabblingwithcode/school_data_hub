import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/books/data/pupil_book_api_service.dart';
import 'package:school_data_hub_flutter/features/pupil/data/pupil_data_api_service.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter_impl.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:watch_it/watch_it.dart';

class PupilProxyManager extends ChangeNotifier {
  final _log = Logger('PupilManager');

  final _notificationService = di<NotificationService>();

  final _hubSessionManager = di<HubSessionManager>();

  final _pupilDataApiService = PupilDataApiService();

  final _pupilBookApiService = PupilBookApiService();

  final _pupilIdPupilsMap = <int, PupilProxy>{};

  List<PupilProxy> get allPupils => _pupilIdPupilsMap.values.toList();

  PupilProxyManager();

  void dispose() {
    // dispose all the pupil proxies
    for (final pupil in _pupilIdPupilsMap.values) {
      pupil.dispose();
    }
    _pupilIdPupilsMap.clear();
    super.dispose();
    return;
  }

  Future<void> init() async {
    await fetchAllPupils();
  }

  //- HELPER METHODS

  void clearData() {
    _pupilIdPupilsMap.clear();
    return;
  }

  PupilProxy? getPupilByPupilId(int pupilId) {
    if (!_pupilIdPupilsMap.containsKey(pupilId)) {
      _log.warning('Pupil $pupilId not found');
      return null;
    }
    return _pupilIdPupilsMap[pupilId];
  }

  List<PupilProxy> getPupilsFromPupilIds(List<int> pupilIds) {
    List<PupilProxy> pupilsfromPupilIds = [];

    for (int pupilId in pupilIds) {
      final PupilProxy? pupil = _pupilIdPupilsMap.values.firstWhereOrNull(
        (pupil) => pupil.pupilId == pupilId,
      );
      if (pupil != null) {
        pupilsfromPupilIds.add(pupil);
      }
    }

    return pupilsfromPupilIds;
  }

  List<PupilProxy> getPupilsFromInternalIds(List<int> internalIds) {
    List<PupilProxy> pupilsfromInternalIds = [];

    for (int internalId in internalIds) {
      final PupilProxy? pupil = _pupilIdPupilsMap.values.firstWhereOrNull(
        (pupil) => pupil.internalId == internalId,
      );
      if (pupil != null) {
        pupilsfromInternalIds.add(pupil);
      }
    }

    return pupilsfromInternalIds;
  }

  List<int> getInternalIdsFromPupils(List<PupilProxy> pupils) {
    return pupils.map((pupil) => pupil.internalId).toList();
  }

  List<int> getPupilIdsFromPupils(List<PupilProxy> pupils) {
    return pupils.map((pupil) => pupil.pupilId).toList();
  }

  List<int> getInternalIdsFromPupilIds(List<int> pupilIds) {
    List<int> internalIds = [];
    for (int pupilId in pupilIds) {
      final PupilProxy? pupil = _pupilIdPupilsMap[pupilId];
      if (pupil != null) {
        internalIds.add(pupil.internalId);
      }
    }
    return internalIds;
  }

  List<PupilProxy> getPupilsNotListed(List<int> pupilIds) {
    Map<int, PupilProxy> allPupilsMap = Map<int, PupilProxy>.of(
      _pupilIdPupilsMap,
    );
    allPupilsMap.removeWhere((key, value) => pupilIds.contains(key));
    return allPupilsMap.values.toList();
  }

  List<PupilProxy> getSiblings(PupilProxy pupil) {
    if (pupil.family == null) {
      return [];
    }

    Map<int, PupilProxy> allPupilsMap = Map<int, PupilProxy>.of(
      _pupilIdPupilsMap,
    );

    // Filter by family value of the pupil
    allPupilsMap.removeWhere((key, value) => value.family != pupil.family);

    // Remove the pupil itself from the list of siblings
    allPupilsMap.remove(pupil.pupilId);

    final pupilSiblings = allPupilsMap.values.toList();

    return pupilSiblings;
  }

  /// Returns the relevant birthday date for a pupil, considering year boundaries.
  /// If the birthday this year hasn't occurred yet, returns last year's birthday.
  /// Otherwise, returns this year's birthday.
  DateTime getRelevantBirthdayDate(PupilProxy pupil) {
    final now = DateTime.now();
    final birthdayToLocal = pupil.birthday.toLocal();
    final birthdayThisYear = DateTime(
      now.year,
      birthdayToLocal.month,
      birthdayToLocal.day,
    );
    final birthdayLastYear = DateTime(
      now.year - 1,
      birthdayToLocal.month,
      birthdayToLocal.day,
    );
    return birthdayThisYear.isAfter(now) ? birthdayLastYear : birthdayThisYear;
  }

  List<PupilProxy> getPupilsWithBirthdaySinceDate(DateTime date) {
    Map<int, PupilProxy> allPupils = Map<int, PupilProxy>.of(_pupilIdPupilsMap);

    final DateTime now = DateTime.now();

    allPupils.removeWhere((key, pupil) {
      final DateTime relevantBirthday = getRelevantBirthdayDate(pupil);

      // Check if the relevant birthday falls within the range [date, now]
      return !(relevantBirthday.isSameDate(date) ||
          relevantBirthday.isSameDate(now) ||
          (relevantBirthday.isAfter(date) && relevantBirthday.isBefore(now)));
    });

    final pupilsWithBirthdaySinceDate = allPupils.values.toList();

    // Sort by most recent birthday (descending)
    pupilsWithBirthdaySinceDate.sort((b, a) {
      final relevantBirthdayA = getRelevantBirthdayDate(a);
      final relevantBirthdayB = getRelevantBirthdayDate(b);

      return relevantBirthdayA.compareTo(relevantBirthdayB);
    });

    return pupilsWithBirthdaySinceDate;
  }

  /// **TODO:** Do we need this?
  PupilsFilter getPupilFilter() {
    //return PupilsFilterImplementation(this, sortMode: sortMode);
    return PupilsFilterImplementation(this);
  }

  //- API CALLS

  //- Fetch all available pupils from the backend

  Future<void> fetchAllPupils() async {
    _log.info('Fetching all pupils');
    final pupilsToFetch = di<PupilIdentityManager>().availablePupilIds;

    if (pupilsToFetch.isEmpty) {
      _log.info(
        'No pupil identities available, canot fetch pupils without ids',
      );
      return;
    }
    await fetchPupilsByInternalId(pupilsToFetch);
  }

  Future<void> updatePupilList(List<PupilProxy> pupils) async {
    await fetchPupilsByInternalId(pupils.map((e) => e.pupilId).toList());
  }

  Future<void> updatePupilData(int pupilId) async {
    final fetchedPupil = await _pupilDataApiService.fetchListOfPupils(
      pupilInternalIds: [pupilId],
    );
    if (fetchedPupil == null) {
      return;
    }
    if (fetchedPupil.isNotEmpty) {
      updatePupilProxyWithPupilData(fetchedPupil.first);
    }
  }
  //- Fetch pupils with the given internal ids

  Future<void> fetchPupilsByInternalId(List<int> pupilInternalIds) async {
    _notificationService.showSnackBar(
      NotificationType.info,
      'Lade Schülerdaten vom Server. Bitte warten...',
    );

    // fetch the pupils from the backend
    final fetchedPupils = await _pupilDataApiService.fetchListOfPupils(
      pupilInternalIds: pupilInternalIds,
    );
    if (fetchedPupils == null) {
      return;
    }
    // check if we did not get a pupil response for some ids
    // if so, we will delete the personal data for those ids later
    final List<int> outdatedPupilIdentitiesIds = pupilInternalIds
        .where(
          (element) =>
              !fetchedPupils.any((pupil) => pupil.internalId == element),
        )
        .toList();

    // now we match the pupils from the response with their personal data

    updatePupilProxiesWithPupilData(fetchedPupils);

    // remove the outdated pupil identities that
    // did not get a response from the backend
    // because this means the pupil is not in the database anymore
    // and we need to delete the personal data from the device

    if (outdatedPupilIdentitiesIds.isNotEmpty) {
      final deletedPupilIdentities = await di<PupilIdentityManager>()
          .deleteOrphanPupilIdentities(outdatedPupilIdentitiesIds);
      _notificationService.showInformationDialog(
        'Diese Schüler_innen existieren nicht mehr in der Datenbank, Ihre Ids wurden aus dem Gerät gelöscht:\n\n$deletedPupilIdentities',
      );
    }
    _notificationService.showSnackBar(
      NotificationType.success,
      'Schülerdaten geladen!',
    );

    notifyListeners();
  }

  void updatePupilProxyWithPupilData(PupilData pupilData) {
    final proxy = _pupilIdPupilsMap[pupilData.id!];
    if (proxy != null) {
      proxy.updatePupil(pupilData);
    } else {
      final pupilIdentity = di<PupilIdentityManager>()
          .getPupilIdentityByInternalId(pupilData.internalId);
      if (pupilIdentity != null) {
        _pupilIdPupilsMap[pupilData.id!] = PupilProxy(
          pupilData: pupilData,
          pupilIdentity: pupilIdentity,
          siblingsResolver: getSiblings,
        );
        notifyListeners();
      }
    }
  }

  void updatePupilProxiesWithPupilData(List<PupilData> pupils) {
    for (PupilData pupil in pupils) {
      updatePupilProxyWithPupilData(pupil);
    }
  }

  //-TODO: These functions should be somewhere else

  Future<void> updateSchoolyearHeldBackDate({
    required int pupilId,
    required ({DateTime? value}) date,
  }) async {
    final PupilData? updatedPupil = await _pupilDataApiService
        .updateSchoolyearHeldBackDate(pupilId: pupilId, date: date);
    if (updatedPupil == null) {
      return;
    }
    updatePupilProxyWithPupilData(updatedPupil);
  }

  Future<void> postPupilBookLending({
    required int pupilId,
    required String libraryId,
  }) async {
    final userName = _hubSessionManager.userName;

    final PupilData? updatedPupil = await _pupilBookApiService
        .postPupilBookLending(
          pupilId: pupilId,
          libraryId: libraryId,
          lentBy: userName!,
        );
    if (updatedPupil == null) {
      return;
    }
    _pupilIdPupilsMap[pupilId]!.updatePupil(updatedPupil);

    return;
  }

  Future<void> deletePupilBook({required String lendingId}) async {
    final pupil = await _pupilBookApiService.deletePupilBook(lendingId);
    if (pupil == null) {
      return;
    }
    _pupilIdPupilsMap[pupil.id!]!.updatePupil(pupil);

    return;
  }

  Future<void> returnLibraryBook({
    required PupilBookLending pupilBookLending,
  }) async {
    final updatedBookLending = pupilBookLending.copyWith(
      returnedAt: DateTime.now().toUtc(),
      receivedBy: _hubSessionManager.userName,
    );

    final pupil = await _pupilBookApiService.updatePupilBookLending(
      bookLending: updatedBookLending,
    );
    if (pupil == null) {
      return;
    }
    _pupilIdPupilsMap[pupil.id!]!.updatePupil(pupil);

    return;
  }

  Future<void> updatePupilBookLending({
    required PupilBookLending pupilBookLending,
    DateTime? lentAt,
    String? lentBy,
    ({String? value})? status,
    ({int? value})? score,
    ({DateTime? value})? returnedAt,
    ({String? value})? receivedBy,
  }) async {
    final updatedBookLending = pupilBookLending.copyWith(
      lentAt: lentAt ?? pupilBookLending.lentAt,
      lentBy: lentBy ?? pupilBookLending.lentBy,
      status: status != null ? status.value : pupilBookLending.status,
      score: score != null ? score.value : pupilBookLending.score,
      returnedAt: returnedAt != null
          ? returnedAt.value
          : pupilBookLending.returnedAt,
      receivedBy: receivedBy != null
          ? receivedBy.value
          : pupilBookLending.receivedBy,
    );
    final pupil = await _pupilBookApiService.updatePupilBookLending(
      bookLending: updatedBookLending,
    );
    if (pupil == null) {
      return;
    }
    _pupilIdPupilsMap[pupil.id!]!.updatePupil(pupil);

    return;
  }
}

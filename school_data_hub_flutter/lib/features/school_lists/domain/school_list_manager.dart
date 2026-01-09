import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/data/school_list_api_service.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/models/pupil_list_entry_proxy.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/models/school_list_pupil_entries_proxy.dart';
import 'package:watch_it/watch_it.dart';

class SchoolListManager with ChangeNotifier {
  final _notificationService = di<NotificationService>();

  final _apiSchoolListService = SchoolListApiService();

  final _pupilManager = di<PupilProxyManager>();

  final _log = Logger('SchoolListManager');

  @override
  void dispose() {
    clearData();
    super.dispose();
    return;
  }

  Future<SchoolListManager> init() async {
    await fetchSchoolLists();
    return this;
  }

  final Map<int, SchoolList> _schoolListMap =
      {}; //-When created, copyWith with pupilEntries = null to avoid redundance!

  List<SchoolList> get schoolLists => _schoolListMap.values.toList();

  final Map<int, SchoolListPupilEntriesProxyMap> _schoolListIdPupilEntriesMap =
      {};

  List<SchoolListPupilEntriesProxyMap> get allPupilEntries =>
      _schoolListIdPupilEntriesMap.values.toList();

  void clearData() {
    _schoolListMap.clear();
    _schoolListIdPupilEntriesMap.clear();
  }

  //- Getters

  SchoolListPupilEntriesProxyMap getPupilEntriesProxyFromSchoolList(
    int listId,
  ) {
    if (!_schoolListIdPupilEntriesMap.containsKey(listId)) {
      return SchoolListPupilEntriesProxyMap();
    }
    return _schoolListIdPupilEntriesMap[listId]!;
  }

  SchoolList getSchoolListById(int listId) {
    return _schoolListMap[listId]!;
  }

  PupilListEntryProxy? getPupilSchoolListEntryProxy({
    required int pupilId,
    required int listId,
  }) {
    final proxyMap = _schoolListIdPupilEntriesMap[listId];
    if (proxyMap == null) return null;

    return proxyMap.pupilEntries.values.firstWhereOrNull(
      (element) => element.pupilEntry.pupilId == pupilId,
    );
  }

  List<PupilProxy> getPupilsinSchoolList(int listId) {
    final proxyMap = _schoolListIdPupilEntriesMap[listId];
    if (proxyMap == null) return [];

    final pupilIdsInList = proxyMap.pupilEntries.values
        .map((e) => e.pupilEntry.pupilId)
        .toSet();

    return _pupilManager.getPupilsFromPupilIds(pupilIdsInList.toList());
  }

  //- Update collections

  void _updateCollectionsFromSchoolList(
    SchoolList schoolList, {
    bool notify = true,
  }) {
    final listId = schoolList.id!;
    // First extract the pupil lists from the school list
    final List<PupilListEntry> pupilEntries = schoolList.pupilEntries ?? [];

    // Now add the school list to the map
    // setting pupilEntries to null to avoid redundancy
    _schoolListMap[listId] = schoolList.copyWith(pupilEntries: null);

    // Next, we update the pupil entries map for the school list
    // with the key being the pupilId
    final proxyMap = _schoolListIdPupilEntriesMap.putIfAbsent(
      listId,
      () => SchoolListPupilEntriesProxyMap(),
    );

    proxyMap.setPupilEntries(pupilEntries);

    if (notify) {
      notifyListeners();
    }
    _log.info(
      'Updated School list $listId with ${pupilEntries.length} pupil entries',
    );
  }

  //- API calls

  Future<void> fetchSchoolLists() async {
    final responseSchoolLists = await _apiSchoolListService.fetchSchoolLists();
    if (responseSchoolLists == null) {
      return;
    }

    _notificationService.showSnackBar(
      NotificationType.success,
      '${responseSchoolLists.length} Schullisten geladen!',
    );

    for (final schoolList in responseSchoolLists) {
      // go through the pupil lists and add them to the map
      // with the key being the pupilId
      _updateCollectionsFromSchoolList(schoolList, notify: false);
    }

    notifyListeners();
    return;
  }

  Future<void> updateSchoolListProperty({
    required int listId,
    String? name,
    String? description,
    bool? public,
    ({String? value})? authorizedUsers,
    ({List<int> pupilIds, MemberOperation operation})? operation,
  }) async {
    final SchoolList? updatedSchoolList = await _apiSchoolListService
        .updateSchoolListProperty(
          listId: listId,
          name: name,
          description: description,
          public: public,
          authorizedUsers: authorizedUsers,
          updateMembers: operation,
        );
    if (updatedSchoolList == null) {
      _log.warning('Failed to update school list $listId properties');
      return;
    }
    _updateCollectionsFromSchoolList(updatedSchoolList);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Schulliste erfolgreich aktualisiert',
    );

    return;
  }

  Future<void> updatePupilListEntry({
    required PupilListEntry entry,
    ({bool? value})? status,
    ({String? value})? comment,
  }) async {
    final entryToUpdate = entry.copyWith(
      status: status != null ? status.value : entry.status,
      comment: comment != null ? comment.value : entry.comment,
      entryBy: di<HubSessionManager>().userName,
    );

    final PupilListEntry? updatedEntry = await _apiSchoolListService
        .updatePupilEntry(entry: entryToUpdate);
    if (updatedEntry == null) {
      _log.warning('Failed to update pupil entry ${entry.id}');
      return;
    }
    _schoolListIdPupilEntriesMap[updatedEntry.schoolListId]!.updatePupilEntry(
      updatedEntry,
    );
    _log.info('Updated pupil entry ${updatedEntry.id}');

    return;
  }

  Future<void> deleteSchoolList(int listId) async {
    final success = await _apiSchoolListService.deleteSchoolList(listId);
    if (success == null) {
      _log.warning('Failed to delete school list $listId');
      return;
    }
    _schoolListMap.remove(listId);
    _schoolListIdPupilEntriesMap.remove(listId);
    _notificationService.showSnackBar(
      NotificationType.success,
      'Schulliste erfolgreich gelöscht',
    );

    _log.info('Deleted school list $listId');
    notifyListeners();
  }

  Future<void> postSchoolListWithGroup({
    required String name,
    required String description,
    required List<int> pupilIds,
    required bool public,
  }) async {
    final schoolList = await ClientHelper.apiCall(
      call: () => _apiSchoolListService.postSchoolListWithGroup(
        name: name,
        description: description,
        pupilIds: pupilIds,
        public: public,
      ),
      errorMessage: 'Fehler beim Erstellen der Schulliste',
    );
    if (schoolList == null) {
      _log.warning('Failed to create new school list');
      return;
    }
    _schoolListMap[schoolList.id!] = schoolList;
    _updateCollectionsFromSchoolList(schoolList);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Schulliste erfolgreich erstellt',
    );
    _log.info('Created new school list ${schoolList.id}');

    return;
  }
}

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
import 'package:flutter_it/flutter_it.dart';

class SchoolListManager with ChangeNotifier {
  final _notificationService = di<NotificationService>();

  final _apiSchoolListService = SchoolListApiService();

  final _pupilManager = di<PupilProxyManager>();

  final _log = Logger('SchoolListManager');

  @override
  void dispose() {
    clearData();
    _schoolLists.dispose();
    super.dispose();
  }

  Future<SchoolListManager> init() async {
    await fetchSchoolLists();
    return this;
  }

  final Map<int, SchoolList> _schoolListMap = {};
  final _schoolLists = ListNotifier<SchoolList>();

  /// Reactive list of school lists (without pupil entries embedded).
  ValueListenable<List<SchoolList>> get schoolLists => _schoolLists;

  final Map<int, SchoolListPupilEntriesProxyMap> _schoolListIdPupilEntriesMap =
      {};

  List<SchoolListPupilEntriesProxyMap> get allPupilEntries =>
      _schoolListIdPupilEntriesMap.values.toList();

  void clearData() {
    _schoolListMap.clear();
    _schoolLists.clear();
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
    final List<PupilListEntry> pupilEntries = schoolList.pupilEntries ?? [];
    final storedList = schoolList.copyWith(pupilEntries: null);

    _schoolListMap[listId] = storedList;

    final existingIndex =
        _schoolLists.value.indexWhere((l) => l.id == listId);
    if (existingIndex != -1) {
      _schoolLists[existingIndex] = storedList;
    } else {
      _schoolLists.add(storedList);
    }

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

  //- Stream entry points (called by HubStreamService)

  void upsertFromStream(SchoolList schoolList) {
    _log.fine('[STREAM] upsert schoolList ${schoolList.id}');
    _updateCollectionsFromSchoolList(schoolList);
  }

  void deleteFromStream(int id) {
    _log.fine('[STREAM] delete schoolList $id');
    if (_schoolListMap.containsKey(id)) {
      _schoolListMap.remove(id);
      _schoolListIdPupilEntriesMap.remove(id);
      final index = _schoolLists.value.indexWhere((l) => l.id == id);
      if (index != -1) {
        _schoolLists.removeAt(index);
      }
      notifyListeners();
    }
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

    _schoolLists.startTransAction();
    for (final schoolList in responseSchoolLists) {
      _updateCollectionsFromSchoolList(schoolList, notify: false);
    }
    _schoolLists.endTransAction();

    notifyListeners();
  }

  Future<void> updateSchoolListProperty({
    required int listId,
    String? name,
    String? description,
    bool? public,
    ({String? value})? authorizedUsers,
    ({List<int> pupilIds, MemberOperation operation})? operation,
  }) async {
    final SchoolList? updatedSchoolList =
        await _apiSchoolListService.updateSchoolListProperty(
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

    final PupilListEntry? updatedEntry =
        await _apiSchoolListService.updatePupilEntry(entry: entryToUpdate);
    if (updatedEntry == null) {
      _log.warning('Failed to update pupil entry ${entry.id}');
      return;
    }
    _schoolListIdPupilEntriesMap[updatedEntry.schoolListId]!.updatePupilEntry(
      updatedEntry,
    );
    _log.info('Updated pupil entry ${updatedEntry.id}');
  }

  Future<void> deleteSchoolList(int listId) async {
    final success = await _apiSchoolListService.deleteSchoolList(listId);
    if (success == null) {
      _log.warning('Failed to delete school list $listId');
      return;
    }
    _schoolListMap.remove(listId);
    _schoolListIdPupilEntriesMap.remove(listId);
    final index = _schoolLists.value.indexWhere((l) => l.id == listId);
    if (index != -1) {
      _schoolLists.removeAt(index);
    }
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
    _updateCollectionsFromSchoolList(schoolList);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Schulliste erfolgreich erstellt',
    );
    _log.info('Created new school list ${schoolList.id}');
  }
}

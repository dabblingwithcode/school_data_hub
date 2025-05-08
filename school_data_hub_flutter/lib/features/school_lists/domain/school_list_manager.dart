import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/data/school_list_api_service.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/models/pupil_list_entry_proxy.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/models/school_list_pupil_entries_proxy.dart';
import 'package:watch_it/watch_it.dart';

final _notificationService = di<NotificationService>();

final _apiSchoolListService = SchoolListApiService();

final _pupilManager = di<PupilManager>();

final _log = Logger('SchoolListManager');

class SchoolListManager with ChangeNotifier {
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

  Future<SchoolListManager> init() async {
    await fetchSchoolLists();
    return this;
  }

  //- Getters

  SchoolListPupilEntriesProxyMap getPupilEntriesProxyFromSchoolList(
      int listId) {
    if (!_schoolListIdPupilEntriesMap.containsKey(listId)) {
      return SchoolListPupilEntriesProxyMap();
    }
    return _schoolListIdPupilEntriesMap[listId]!;
  }

  SchoolList getSchoolListById(int listId) {
    return _schoolListMap[listId]!;
  }

  PupilListEntryProxy? getPupilSchoolListEntryProxy(
      {required int pupilId, required int listId}) {
    if (!_schoolListIdPupilEntriesMap.containsKey(listId)) {
      return null;
    }
    final pupilEntries = _schoolListIdPupilEntriesMap[listId]!.pupilEntries;
    if (pupilEntries.isEmpty) {
      return null;
    }
    return pupilEntries.values
        .firstWhere((element) => element.pupilEntry.pupilId == pupilId);
  }

  List<PupilProxy> getPupilsinSchoolList(int listId) {
    if (!_schoolListIdPupilEntriesMap.containsKey(listId)) {
      return [];
    }
    final pupilEntries = _schoolListIdPupilEntriesMap[listId]!.pupilEntries;
    if (pupilEntries.isEmpty) {
      return [];
    }
    final pupilIdsInList =
        pupilEntries.values.map((e) => e.pupilEntry.pupilId).toSet().toList();

    return _pupilManager.getPupilsFromPupilIds(pupilIdsInList);
  }

  //- Update collections

  void _updateCollectionsFromSchoolList(SchoolList schoolList) {
    // First extract the pupil lists from the school list
    final List<PupilListEntry> pupilEntries = schoolList.pupilEntries!;

    // Now add the school list to the map
    // setting pupilEntries to null to avoid redundancy
    _schoolListMap[schoolList.id!] = schoolList.copyWith(pupilEntries: null);

    // Next, we update the pupil entries map for the school list
    // with the key being the pupilId
    if (_schoolListIdPupilEntriesMap.containsKey(schoolList.id!)) {
      _schoolListIdPupilEntriesMap[schoolList.id!]!
          .setPupilEntries(pupilEntries);
      _log.fine(
          'Updated pupil entries map for school list number ${schoolList.id!}');
    } else {
      _schoolListIdPupilEntriesMap[schoolList.id!] =
          SchoolListPupilEntriesProxyMap();
      _schoolListIdPupilEntriesMap[schoolList.id!]!
          .setPupilEntries(pupilEntries);
      _log.fine(
          'Created new pupil entries map for school list number ${schoolList.id!}');
    }

    notifyListeners();
    _log.fine(
        'Finished updating School list number ${schoolList.id!} with ${pupilEntries.length} pupil entries');
  }

  //- API calls

  Future<void> fetchSchoolLists() async {
    final List<SchoolList> responseSchoolLists =
        await _apiSchoolListService.fetchSchoolLists();

    _notificationService.showSnackBar(NotificationType.success,
        '${responseSchoolLists.length} Schullisten geladen!');

    for (final schoolList in responseSchoolLists) {
      _schoolListMap[schoolList.id!] = schoolList;
      // go through the pupil lists and add them to the map
      // with the key being the pupilId
      _updateCollectionsFromSchoolList(schoolList);
    }

    notifyListeners();
    return;
  }

  Future updateSchoolListProperty(
      {required int listId,
      String? name,
      String? description,
      bool? public,
      ({List<int> pupilIds, MemberOperation operation})? operation}) async {
    final SchoolList updatedSchoolList =
        await _apiSchoolListService.updateSchoolListProperty(
            listId: listId,
            name: name,
            description: description,
            public: public,
            updateMembers: operation);
    _log.fine(
        'Fetched school list number ${updatedSchoolList.id!} with ${updatedSchoolList.pupilEntries!.length} pupil entries');
    _updateCollectionsFromSchoolList(updatedSchoolList);

    _notificationService.showSnackBar(
        NotificationType.success, 'Schulliste erfolgreich aktualisiert');

    return;
  }

  Future<void> updatePupilListEntry({
    required PupilListEntry entry,
    ({bool? value})? status,
    ({String? value})? comment,
  }) async {
    final entryToUpdate = entry.copyWith(
      status: status?.value != null ? status!.value : entry.status,
      comment: comment?.value != null ? comment!.value : entry.comment,
    );

    final PupilListEntry updatedEntry =
        await _apiSchoolListService.updatePupilEntry(entry: entryToUpdate);
    _schoolListIdPupilEntriesMap[updatedEntry.schoolListId]!
        .updatePupilEntry(updatedEntry);
    _notificationService.showSnackBar(
        NotificationType.success, 'Eintrag erfolgreich aktualisiert');

    return;
  }

  Future<void> deleteSchoolList(int listId) async {
    try {
      final success = await _apiSchoolListService.deleteSchoolList(listId);
      if (success) {
        _schoolListMap.remove(listId);
        _schoolListIdPupilEntriesMap.remove(listId);
        _notificationService.showSnackBar(
            NotificationType.success, 'Schulliste erfolgreich gelöscht');
      } else {
        _notificationService.showSnackBar(
            NotificationType.error, 'Fehler beim Löschen der Schulliste');
      }
    } catch (e) {
      _log.severe('Error deleting school list: $e');
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Löschen der Schulliste: $e');
    }
    notifyListeners();
  }
// Future<void> deleteSchoolList(String listId) async {
//   final List<SchoolList> updatedSchoolLists =
//       await _apiSchoolListService.deleteSchoolList(listId);

//   // first delete the pupil lists from the map
//   for (final pupilList in _schoolListMap[listId]!.pupilEntries) {
//     _pupilListMap.value[pupilList.listedPupilId]!.remove(pupilList);
//     _pupilSchoolLists.value =
//         _pupilListMap.value.values.expand((list) => list).toList();
//   }
//   _schoolListMap.clear();
//   for (final schoolList in updatedSchoolLists) {
//     _schoolListMap[schoolList.listId] = schoolList;
//     _schoolLists.value = _schoolListMap.values.toList();
//     // go through the pupil lists and add them to the map
//     // with the key being the pupilId
//     _updatePupilListsFromSchoolList(schoolList);
//   }

//   _updateRepositories();

//   _notificationService.showSnackBar(
//       NotificationType.success, 'Schulliste erfolgreich gelöscht');

//   return;
// }

  Future<void> postSchoolListWithGroup(
      {required String name,
      required String description,
      required List<int> pupilIds,
      required bool public}) async {
    try {
      final schoolList = await _apiSchoolListService.postSchoolListWithGroup(
          name: name,
          description: description,
          pupilIds: pupilIds,
          public: public);

      _schoolListMap[schoolList.id!] = schoolList;
      _updateCollectionsFromSchoolList(schoolList);
    } catch (e) {
      _log.severe('Error creating school list: $e');

      throw Exception(
          'Fehler beim Erstellen der Schulliste: $e'); // Handle the error
    }

    _notificationService.showSnackBar(
        NotificationType.success, 'Schulliste erfolgreich erstellt');

    return;
  }

// Future<void> addPupilsToSchoolList(String listId, List<int> pupilIds) async {
//   final SchoolList updatedSchoolList = await _apiSchoolListService
//       .addPupilsToSchoolList(listId: listId, pupilIds: pupilIds);

//   _schoolListMap[updatedSchoolList.listId] = updatedSchoolList;
//   _updateRepositories();
//   _updatePupilListsFromSchoolList(updatedSchoolList);

//   _notificationService.showSnackBar(
//       NotificationType.success, 'Schüler erfolgreich hinzugefügt');

//   return;
// }

// Future<void> deletePupilsFromSchoolList(
//   List<int> pupilIds,
//   String listId,
// ) async {
//   // The response are the updated pupils whose pupil list was deleted

//   final SchoolList updatedSchoolList =
//       await _apiSchoolListService.deletePupilsFromSchoolList(
//     pupilIds: pupilIds,
//     listId: listId,
//   );
//   _schoolListMap[updatedSchoolList.listId] = updatedSchoolList;
//   _updateRepositories();
//   _updatePupilListsFromSchoolList(updatedSchoolList);

//   _notificationService.showSnackBar(
//       NotificationType.success, 'Schülereinträge erfolgreich gelöscht');

//   return;
// }

// Future<void> patchPupilList(
//     int pupilId, String listId, bool? value, String? comment) async {
//   final SchoolList updatedSchoolList =
//       await _apiSchoolListService.patchSchoolListPupil(
//           pupilId: pupilId, listId: listId, value: value, comment: comment);
//   _schoolListMap[updatedSchoolList.listId] = updatedSchoolList;
//   _updateRepositories();
//   _updatePupilListsFromSchoolList(updatedSchoolList);

//   _notificationService.showSnackBar(
//       NotificationType.success, 'Eintrag erfolgreich aktualisiert');

  //   return;
  // }
}

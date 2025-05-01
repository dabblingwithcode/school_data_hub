import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/data/school_list_api_service.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/filters/school_list_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

final _notificationService = di<NotificationService>();

final _apiSchoolListService = SchoolListApiService();

final _schoolListFilterManager = di<SchoolListFilterManager>();

final _pupilManager = di<PupilManager>();

final _log = Logger('SchoolListManager');

class SchoolListManager with ChangeNotifier {
// We keep the school lists in a map for fast access
// the pupil lists are kept in a separate map
//-When created, copyWith with pupilEntries = null to avoid redundance!
  final Map<int, SchoolList> _schoolListMap = {};
  Map<int, SchoolList> get schoolListMap => _schoolListMap;

  List<SchoolList> get schoolLists => _schoolListMap.values.toList();

// We keep two maps of pupil lists for fast access
// one with the pupilId as key and the other with the schoolListId as key

  final Map<int, List<PupilListEntry>> _schoolListIdPupilEntriesMap = {};
  Map<int, List<PupilListEntry>> get schoolListIdPupilEntriesMap =>
      _schoolListIdPupilEntriesMap;

  final Map<int, List<PupilListEntry>> _pupilIdSchoolListPupilEntriesMap = {};
  Map<int, List<PupilListEntry>> get pupilIdSchoolListPupilEntriesMap =>
      _pupilIdSchoolListPupilEntriesMap;

  SchoolListManager();

  void clearData() {
    _schoolListMap.clear();
    _schoolListIdPupilEntriesMap.clear();
    _pupilIdSchoolListPupilEntriesMap.clear();
  }

  Future<SchoolListManager> init() async {
    await fetchSchoolLists();
    return this;
  }

  //- Getters

  SchoolList getSchoolListById(int listId) {
    return _schoolListMap[listId]!;
  }

  List<PupilListEntry> getSchoolListsEntriesFromPupil(int pupilId) {
    if (!_pupilIdSchoolListPupilEntriesMap.containsKey(pupilId)) {
      return [];
    }
    return _pupilIdSchoolListPupilEntriesMap[pupilId]!;
  }

  PupilListEntry? getPupilSchoolListEntry(
      {required int pupilId, required int listId}) {
    return _schoolListIdPupilEntriesMap[pupilId]!
        .where((element) => element.schoolListId == listId)
        .first;
  }

  List<PupilProxy> getPupilsinSchoolList(int listId) {
    if (!_schoolListMap.containsKey(listId)) {
      return [];
    }
    final pupilEntries = _schoolListIdPupilEntriesMap[listId];
    if (pupilEntries == null || pupilEntries.isEmpty) {
      return [];
    }

    final List<int> pupilIdsInList =
        pupilEntries.map((e) => e.pupilId).toList();

    return _pupilManager.pupilsFromPupilIds(pupilIdsInList);
  }

  // TODO: Are we using this function anywhere?
  //- If not, remove it
  List<PupilProxy> pupilsPresentInSchoolList(
      int listId, List<PupilProxy> pupils) {
    List<PupilProxy> pupilsInList = getPupilsinSchoolList(listId);
    return pupils
        .where((pupil) => pupilsInList
            .any((element) => element.internalId == pupil.internalId))
        .toList();
  }

  //- Update collections

  void _updateCollectionsFromSchoolList(SchoolList schoolList) {
    // First extract the pupil lists from the school list
    final List<PupilListEntry> pupilEntries = schoolList.pupilEntries!;

    // Now add the school list to the map
    // setting pupilEntries to null to avoid redundancy
    _schoolListMap[schoolList.id!] = schoolList.copyWith(pupilEntries: null);

    // Next, we update both pupil entries maps
    // with the fresh pupil entries from the school list

    // We use the school list id as key for the first map
    _schoolListIdPupilEntriesMap[schoolList.id!] = pupilEntries;

    // and the pupil id as key for the second map

    // First, clean up any stale entries for this school list from _pupilIdSchoolListPupilEntriesMap
    // in case an entry was deleted
    // Find all pupils that have an entry for this school list
    List<int> pupilsToCleanup = [];
    _pupilIdSchoolListPupilEntriesMap.forEach((pupilId, lists) {
      if (lists.any((element) => element.schoolListId == schoolList.id!)) {
        pupilsToCleanup.add(pupilId);
      }
    });

    // Now remove all entries related to this school list from each pupil's list
    for (final pupilId in pupilsToCleanup) {
      if (_pupilIdSchoolListPupilEntriesMap.containsKey(pupilId)) {
        _pupilIdSchoolListPupilEntriesMap[pupilId] =
            _pupilIdSchoolListPupilEntriesMap[pupilId]!
                .where((element) => element.schoolListId != schoolList.id!)
                .toList();
      }
    }

    for (final pupilList in pupilEntries) {
      final pupilEntriesInMap =
          _pupilIdSchoolListPupilEntriesMap[pupilList.pupilId];
      if (pupilEntriesInMap == null) {
        _pupilIdSchoolListPupilEntriesMap[pupilList.pupilId] = [pupilList];
        continue;
      }
      // if the pupil list is already in the pupil lists we update it

      if (pupilEntriesInMap.isNotEmpty) {
        final index = pupilEntriesInMap
            .indexWhere((element) => element.schoolListId == schoolList.id!);
        if (index != -1) {
          pupilEntriesInMap[index] = pupilList;
        } else {
          pupilEntriesInMap.add(pupilList);
        }
      } else {
        pupilEntriesInMap.add(pupilList);
      }

      _pupilIdSchoolListPupilEntriesMap[pupilList.pupilId] = pupilEntriesInMap;
    }
    notifyListeners();
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
      ({
        List<int> pupilIds,
        SchoolListMemberOperation operation
      })? operation}) async {
    final SchoolList updatedSchoolList =
        await _apiSchoolListService.updateSchoolListProperty(
            listId: listId,
            name: name,
            description: description,
            public: public,
            updateMembers: operation);

    _updateCollectionsFromSchoolList(updatedSchoolList);
    _schoolListFilterManager
        .updateFilteredSchoolLists(_schoolListMap.values.toList());

    _notificationService.showSnackBar(
        NotificationType.success, 'Schulliste erfolgreich aktualisiert');

    return;
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

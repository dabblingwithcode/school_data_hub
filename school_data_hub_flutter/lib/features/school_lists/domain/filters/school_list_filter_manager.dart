import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_filter_enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_filter_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:watch_it/watch_it.dart';

final _schoolListManager = di<SchoolListManager>();
final _log = Logger('SchoolListFilterManager');
final _filtersStateManager = di<FiltersStateManager>();
final _pupilFilterManager = di<PupilFilterManager>();
final _notificationService = di<NotificationService>();

class SchoolListFilterManager {
  final _filteredSchoolLists = ValueNotifier<List<SchoolList>>([]);
  ValueListenable<List<SchoolList>> get filteredSchoolLists =>
      _filteredSchoolLists;

  ValueListenable<bool> get filterState => _filterState;
  final _filterState = ValueNotifier<bool>(false);

  // SchoolListFilterManager();

  void updateFilteredSchoolLists(List<SchoolList> schoolLists) {
    _filteredSchoolLists.value = schoolLists;
  }

  void resetFilters() {
    _filterState.value = false;
    _filteredSchoolLists.value = _schoolListManager.schoolLists.value;
    _filtersStateManager.setFilterState(
        filterState: FilterState.schoolList, value: false);
  }

  void onSearchEnter(String text) {
    if (text.isEmpty) {
      _filteredSchoolLists.value = _schoolListManager.schoolLists.value;
      return;
    }
    _filterState.value = true;
    _filtersStateManager.setFilterState(
        filterState: FilterState.schoolList, value: true);
    String lowerCaseText = text.toLowerCase();
    _filteredSchoolLists.value = _schoolListManager.schoolLists.value
        .where((element) => element.name.toLowerCase().contains(lowerCaseText))
        .toList();
  }

  List<PupilList> addPupilListFiltersToFilteredPupils(
      List<PupilList> pupilLists) {
    List<PupilList> filteredPupilLists = [];
    bool filterIsOn = false;
    for (PupilList pupilList in pupilLists) {
      if (_pupilFilterManager
              .pupilFilterState.value[PupilFilter.schoolListYesResponse]! &&
          pupilList.status != true) {
        filterIsOn = true;
        continue;
      }
      if (_pupilFilterManager
              .pupilFilterState.value[PupilFilter.schoolListNoResponse]! &&
          pupilList.status != false) {
        filterIsOn = true;
        continue;
      }
      if (_pupilFilterManager
              .pupilFilterState.value[PupilFilter.schoolListNullResponse]! &&
          pupilList.status != null) {
        filterIsOn = true;
        continue;
      }
      if (_pupilFilterManager
              .pupilFilterState.value[PupilFilter.schoolListCommentResponse]! &&
          pupilList.comment == null) {
        filterIsOn = true;
        continue;
      }
      filteredPupilLists.add(pupilList);
    }
    //- TODO: Implement filterState, FlutterError (setState() or markNeedsBuild() called during build.
    // if (filterIsOn) {
    //   _filterState.value = true;
    // } else {
    //   _filterState.value = false;
    // }

    return filteredPupilLists;
  }
}

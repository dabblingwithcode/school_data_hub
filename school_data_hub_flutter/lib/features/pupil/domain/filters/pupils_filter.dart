// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_text_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

enum PupilProperties {
  specialNeeds,
  ogs,
  notOgs,
  specialInfo,
  migrationSupport,

  preSchoolRevision0,
  preSchoolRevision1,
  preSchoolRevision2,
  preSchoolRevision3,
  developmentPlan1,
  developmentPlan2,
  developmentPlan3,
  fiveYears,
  communicationPupil,
  communicationTutor1,
  communicationTutor2,
  justGirls,
  justBoys,
  schoolListYesResponse,
  schoolListNoResponse,
  schoolListNullResponse,
  schoolListCommentResponse,
  authorizationYesResponse,
  authorizationNoResponse,
  authorizationNullResponse,
  authorizationCommentResponse,
  supportAreaMotorics,
  supportAreaLanguage,
  supportAreaMath,
  supportAreaGerman,
  supportAreaEmotions,
  supportAreaLearning,
}

class RadioButtonFilter extends Filter<PupilProxy> {
  RadioButtonFilter({required super.name});

  bool _isActive1 = false;
  bool _isActive2 = false;

  bool get isActive1 => _isActive1;
  bool get isActive2 => _isActive2;

  void toggle1() {
    if (_isActive1) {
      _isActive1 = false;
    } else {
      _isActive1 = true;
      _isActive2 = false;
    }

    notifyListeners();
  }

  void toggle2() {
    if (_isActive2) {
      _isActive2 = false;
    } else {
      _isActive2 = true;
      _isActive1 = false;
    }

    notifyListeners();
  }

  @override
  void reset() {
    _isActive1 = false;
    _isActive2 = false;
    notifyListeners();
  }

  @override
  bool matches(PupilProxy item) {
    // TODO: implement matches
    throw UnimplementedError();
  }
}

abstract class PupilsFilter implements Listenable {
  ValueListenable<List<PupilProxy>> get filteredPupils;
  ValueListenable<List<int>> get filteredPupilIds;
  List<Filter> get groupFilters;
  ValueListenable<PupilSortMode> get sortMode;

  //List<Filter> get groupFilters;
  List<Filter> get schoolGradeFilters;
  List<Filter> get genderFilters;
  PupilTextFilter get textFilter;

  /// must be called when this object is no longer needed
  void dispose();

  // updates the filtered pupils with current filters
  // and sort mode
  void refreshs();

  void clearFilteredPupils();

  // reset the filters to its initial state
  void resetFilters();

  // for now, we need to access the switch from outside
  // because additional filters outside are still used
  // void setFiltersOnValue(bool value);
  // void setFilterState();
  void setSortMode(PupilSortMode sortMode);
  void sortPupils();
  void setTextFilter(String? text, {bool refresh = true});
  void populateGroupFilters(List<String> groupIds);
}

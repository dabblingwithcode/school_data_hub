import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/domain/filters/filters_state_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/authorizations/domain/models/pupil_authorization.dart';
import 'package:schuldaten_hub/features/pupil/domain/filters/pupil_filter_enums.dart';
import 'package:schuldaten_hub/features/pupil/domain/filters/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/domain/filters/pupils_filter.dart';

typedef AuthorizationFilterRecord = ({
  AuthorizationFilter authorizationFilter,
  bool value
});

// class AuthorizationFilter extends Filter<PupilProxy> {
//   AuthorizationFilter({
//     required super.name,
//   });

//   Authorization? _authorization;
//   Authorization? get authorization => _authorization;

//   void setAuthorization(Authorization authorization) {
//     _authorization = authorization;
//     toggle(true);
//     notifyListeners();
//   }

//   @override
//   void reset() {
//     _authorization = null;
//     super.reset();
//   }

//   @override
//   bool matches(PupilProxy item) {
//     return addAuthorizationFiltersToPupil(item, authorization!);
//   }
// }

final activeFilters = locator<PupilFilterManager>();

// bool addAuthorizationFiltersToPupil(
//   PupilProxy pupil,
//   Authorization authorization,
// ) {
//   // Check first if the filtered pupil is in the authorization. If not, continue with next one.

//   final PupilAuthorization? pupilAuthorization = pupil.authorizations!
//       .firstWhereOrNull((pupilAuthorization) =>
//           pupilAuthorization.originAuthorization ==
//           authorization.authorizationId);

//   if (pupilAuthorization == null) {
//     return false;
//   }
//   // This one is - let's apply the authorization filters

//   if (activeFilters.filterState.value[PupilFilter.authorizationYesResponse]! &&
//       pupilAuthorization.status == false) {
//     return false;
//   }
//   if (activeFilters.filterState.value[PupilFilter.authorizationNoResponse]! &&
//       pupilAuthorization.status == true) {
//     return false;
//   }
//   if (activeFilters.filterState.value[PupilFilter.authorizationNullResponse]! &&
//       pupilAuthorization.status != null) {
//     return false;
//   }
//   if (activeFilters
//           .filterState.value[PupilFilter.authorizationCommentResponse]! &&
//       pupilAuthorization.comment == null) {
//     return false;
//   }

//   return true;
// }

// List<PupilProxy> addAuthorizationFiltersToFilteredPupils(
//   List<PupilProxy> pupils,
//   Authorization authorization,
// ) {
//   List<PupilProxy> filteredPupils = [];

//   for (PupilProxy pupil in pupils) {
//     // Check first if the filtered pupil is in the authorization. If not, continue with next one.

//     final PupilAuthorization? pupilAuthorization = pupil.authorizations!
//         .firstWhereOrNull((pupilAuthorization) =>
//             pupilAuthorization.originAuthorization ==
//             authorization.authorizationId);

//     if (pupilAuthorization == null) {
//       continue;
//     }
//     // This one is - let's apply the authorization filters

//     if (activeFilters
//             .filterState.value[PupilFilter.authorizationYesResponse]! &&
//         pupilAuthorization.status == false) {
//       continue;
//     }
//     if (activeFilters.filterState.value[PupilFilter.authorizationNoResponse]! &&
//         pupilAuthorization.status == true) {
//       continue;
//     }
//     if (activeFilters
//             .filterState.value[PupilFilter.authorizationNullResponse]! &&
//         pupilAuthorization.status != null) {
//       continue;
//     }
//     if (activeFilters
//             .filterState.value[PupilFilter.authorizationCommentResponse]! &&
//         pupilAuthorization.comment == null) {
//       continue;
//     }

//     filteredPupils.add(pupil);
//   }
//   return filteredPupils;
// }

enum AuthorizationFilter {
  yes,
  no,
  nullResponse,
  commentResponse,
  fileResponse
}

Map<AuthorizationFilter, bool> initialPupilAuthorizationFilterValues = {
  AuthorizationFilter.yes: false,
  AuthorizationFilter.no: false,
  AuthorizationFilter.nullResponse: false,
  AuthorizationFilter.commentResponse: false,
  AuthorizationFilter.fileResponse: false,
};

class PupilAuthorizationFilterManager {
  final _pupilAuthorizationFilterState =
      ValueNotifier<Map<AuthorizationFilter, bool>>(
          initialPupilAuthorizationFilterValues);
  ValueListenable<Map<AuthorizationFilter, bool>>
      get authorizationFilterState => _pupilAuthorizationFilterState;

  PupilAuthorizationFilterManager();

  resetFilters() {
    _pupilAuthorizationFilterState.value = {
      ...initialPupilAuthorizationFilterValues
    };
    locator<FiltersStateManager>()
        .setFilterState(filterState: FilterState.pupil, value: false);
  }

  void setFilter(
      {required List<AuthorizationFilterRecord> authorizationFilters}) {
    for (AuthorizationFilterRecord record in authorizationFilters) {
      _pupilAuthorizationFilterState.value = {
        ..._pupilAuthorizationFilterState.value,
        record.authorizationFilter: record.value,
      };
    }

    final authorizationFilterStateEqualsInitialValues = const MapEquality()
        .equals(_pupilAuthorizationFilterState.value,
            initialPupilAuthorizationFilterValues);

    locator<FiltersStateManager>().setFilterState(
        filterState: FilterState.pupil,
        value: !authorizationFilterStateEqualsInitialValues);

    locator<PupilsFilter>().refreshs();
  }

  List<PupilAuthorization> applyAuthorizationFiltersToPupilAuthorizations(
    List<PupilAuthorization> pupilAuthorizations,
  ) {
    List<PupilAuthorization> filteredPupilAuthorizations = [];
    bool filterIsOn = false;
    for (PupilAuthorization pupilAuthorization in pupilAuthorizations) {
      if (activeFilters
              .pupilFilterState.value[PupilFilter.authorizationPositive]! &&
          pupilAuthorization.status != true) {
        filterIsOn = true;
        continue;
      }
      if (activeFilters
              .pupilFilterState.value[PupilFilter.authorizationNegative]! &&
          pupilAuthorization.status != false) {
        filterIsOn = true;
        continue;
      }
      if (activeFilters
              .pupilFilterState.value[PupilFilter.authorizationNoValue]! &&
          pupilAuthorization.status != null) {
        filterIsOn = true;
        continue;
      }
      if (activeFilters
              .pupilFilterState.value[PupilFilter.authorizationComment]! &&
          pupilAuthorization.comment == null) {
        filterIsOn = true;
        continue;
      }
      if (activeFilters
              .pupilFilterState.value[PupilFilter.authorizationNoFile]! &&
          pupilAuthorization.fileId != null) {
        filterIsOn = true;
        continue;
      }

      filteredPupilAuthorizations.add(pupilAuthorization);
    }
    if (filterIsOn) {
      locator<FiltersStateManager>()
          .setFilterState(filterState: FilterState.pupil, value: true);
    }

    return filteredPupilAuthorizations;
  }
}

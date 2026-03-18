import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/features/_authorizations/domain/filters/authorization_filter_predicates.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';

typedef AuthorizationFilterRecord = ({
  AuthorizationFilter authorizationFilter,
  bool value,
});

enum AuthorizationFilter {
  yes,
  no,
  nullResponse,
  commentResponse,
  fileResponse,
}

Map<AuthorizationFilter, bool> initialPupilAuthorizationFilterValues = {
  AuthorizationFilter.yes: false,
  AuthorizationFilter.no: false,
  AuthorizationFilter.nullResponse: false,
  AuthorizationFilter.commentResponse: false,
  AuthorizationFilter.fileResponse: false,
};

class PupilAuthorizationFilterManager implements Resettable {
  final _pupilAuthorizationFilterState =
      ValueNotifier<Map<AuthorizationFilter, bool>>(
        initialPupilAuthorizationFilterValues,
      );
  ValueListenable<Map<AuthorizationFilter, bool>>
  get authorizationFilterState => _pupilAuthorizationFilterState;

  PupilAuthorizationFilterManager();
  void dispose() {
    _pupilAuthorizationFilterState.dispose();
    return;
  }

  @override
  void resetFilters() {
    _pupilAuthorizationFilterState.value = {
      ...initialPupilAuthorizationFilterValues,
    };
    di<FiltersStateManager>().setFilterState(
      filterState: FilterState.pupil,
      value: false,
    );
  }

  void setFilter({
    required List<AuthorizationFilterRecord> authorizationFilters,
  }) {
    for (AuthorizationFilterRecord record in authorizationFilters) {
      _pupilAuthorizationFilterState.value = {
        ..._pupilAuthorizationFilterState.value,
        record.authorizationFilter: record.value,
      };
    }

    final authorizationFilterStateEqualsInitialValues =
        const MapEquality<AuthorizationFilter, bool>().equals(
          _pupilAuthorizationFilterState.value,
          initialPupilAuthorizationFilterValues,
        );

    di<FiltersStateManager>().setFilterState(
      filterState: FilterState.pupil,
      value: !authorizationFilterStateEqualsInitialValues,
    );

    di<PupilsFilter>().refresh();
  }

  List<PupilAuthorization> applyAuthorizationFiltersToPupilAuthorizations(
    List<PupilAuthorization> pupilAuthorizations,
  ) {
    final activeFilters = _pupilAuthorizationFilterState.value;
    final filtered = <PupilAuthorization>[];
    bool filterIsOn = false;

    for (final pa in pupilAuthorizations) {
      if (!AuthorizationFilterPredicates.matchesAuthorizationGroup(
        pa,
        activeFilters,
      )) {
        filterIsOn = true;
        continue;
      }
      filtered.add(pa);
    }

    if (filterIsOn) {
      di<FiltersStateManager>().setFilterState(
        filterState: FilterState.pupil,
        value: true,
      );
    }

    return filtered;
  }
}

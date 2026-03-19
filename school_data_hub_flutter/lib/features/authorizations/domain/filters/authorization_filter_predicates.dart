import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/authorizations/domain/filters/pupil_authorization_filter_manager.dart';

/// Pure predicate functions for pupil authorization filtering.
/// No dependency on get_it or manager; easy to unit test.
class AuthorizationFilterPredicates {
  AuthorizationFilterPredicates._();

  /// Returns true if the pupil authorization matches all active filters.
  /// Uses complementary group logic: if any filter is active, the entry
  /// must match at least one.
  static bool matchesAuthorizationGroup(
    PupilAuthorization pa,
    Map<AuthorizationFilter, bool> activeFilters,
  ) {
    bool anyActive = false;
    bool anyMatched = false;

    if (activeFilters[AuthorizationFilter.yes]!) {
      anyActive = true;
      if (pa.status == true) anyMatched = true;
    }
    if (activeFilters[AuthorizationFilter.no]!) {
      anyActive = true;
      if (pa.status == false) anyMatched = true;
    }
    if (activeFilters[AuthorizationFilter.nullResponse]!) {
      anyActive = true;
      if (pa.status == null) anyMatched = true;
    }
    if (activeFilters[AuthorizationFilter.commentResponse]!) {
      anyActive = true;
      if (pa.comment != null) anyMatched = true;
    }
    if (activeFilters[AuthorizationFilter.fileResponse]!) {
      anyActive = true;
      if (pa.fileId == null) anyMatched = true;
    }

    return !anyActive || anyMatched;
  }
}

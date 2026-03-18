import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';

/// Pure predicate functions for pupil book lending filtering.
/// No dependency on get_it or manager; easy to unit test.
class PupilBookLendingFilterPredicates {
  PupilBookLendingFilterPredicates._();

  /// True when the lending should be excluded (filter on and lent before cutoff).
  static bool excludeBySevenDays({
    required PupilBookLending lending,
    required DateTime sevenDaysAgo,
    required bool filterOn,
  }) {
    return filterOn && lending.lentAt.isBefore(sevenDaysAgo);
  }

  /// True when the lending should be excluded (filter on and lent before cutoff).
  static bool excludeByThirtyDays({
    required PupilBookLending lending,
    required DateTime thirtyDaysAgo,
    required bool filterOn,
  }) {
    return filterOn && lending.lentAt.isBefore(thirtyDaysAgo);
  }

  /// True when the lending should be excluded (filter on and already returned).
  static bool excludeByCurrentlyBorrowed({
    required PupilBookLending lending,
    required bool filterOn,
  }) {
    return filterOn && lending.returnedAt != null;
  }

  /// True when the lending should be excluded (filter on and not yet returned).
  static bool excludeByReturned({
    required PupilBookLending lending,
    required bool filterOn,
  }) {
    return filterOn && lending.returnedAt == null;
  }

  static const _scoreFilters = [
    PupilBookLendingFilter.highScore,
    PupilBookLendingFilter.lowScore,
    PupilBookLendingFilter.noScore,
  ];

  /// Complementary group: if any score filter is active, lending must match
  /// at least one. If none active, all pass.
  static bool matchesScoreGroup(
    PupilBookLending lending,
    Map<PupilBookLendingFilter, bool> activeFilters,
  ) {
    bool anyActive = false;
    bool anyMatched = false;
    for (final filter in _scoreFilters) {
      if (activeFilters[filter]!) {
        anyActive = true;
        if (_matchesScoreFilter(lending.score, filter)) {
          anyMatched = true;
        }
      }
    }
    return !anyActive || anyMatched;
  }

  static bool _matchesScoreFilter(int score, PupilBookLendingFilter filter) {
    switch (filter) {
      case PupilBookLendingFilter.highScore:
        return score >= 3;
      case PupilBookLendingFilter.lowScore:
        return score > 0 && score < 3;
      case PupilBookLendingFilter.noScore:
        return score == 0;
      default:
        return false;
    }
  }
}

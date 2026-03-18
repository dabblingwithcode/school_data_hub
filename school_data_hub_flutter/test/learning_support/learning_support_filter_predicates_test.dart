import 'package:flutter_test/flutter_test.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/filters/learning_support_filter_predicates.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/models/learning_support_enums.dart';

Map<SupportLevelType, bool> _levelFilters([
  Set<SupportLevelType> active = const {},
]) {
  return {
    for (final f in SupportLevelType.values) f: active.contains(f),
  };
}

Map<SupportArea, bool> _areaFilters([
  Set<SupportArea> active = const {},
]) {
  return {
    for (final f in SupportArea.values) f: active.contains(f),
  };
}

Map<CurrentLearningSupportPlan, bool> _planFilters([
  Set<CurrentLearningSupportPlan> active = const {},
]) {
  return {
    for (final f in CurrentLearningSupportPlan.values) f: active.contains(f),
  };
}

SupportCategoryStatus _status(int categoryId) {
  return SupportCategoryStatus(
    score: 1,
    createdBy: 'test',
    createdAt: DateTime.utc(2026, 1, 1),
    pupilId: 1,
    supportCategoryId: categoryId,
    learningSupportPlanId: 1,
  );
}

void main() {
  group('matchesSupportLevelGroup', () {
    test('passes when no level filters active', () {
      expect(
        LearningSupportFilterPredicates.matchesSupportLevelGroup(
          2,
          _levelFilters(),
        ),
        isTrue,
      );
    });

    test('level 1 filter matches level 1', () {
      expect(
        LearningSupportFilterPredicates.matchesSupportLevelGroup(
          1,
          _levelFilters({SupportLevelType.supportLevel1}),
        ),
        isTrue,
      );
    });

    test('level 1 filter rejects level 2', () {
      expect(
        LearningSupportFilterPredicates.matchesSupportLevelGroup(
          2,
          _levelFilters({SupportLevelType.supportLevel1}),
        ),
        isFalse,
      );
    });

    test('level 1 + level 3 OR logic matches level 3', () {
      expect(
        LearningSupportFilterPredicates.matchesSupportLevelGroup(
          3,
          _levelFilters({
            SupportLevelType.supportLevel1,
            SupportLevelType.supportLevel3,
          }),
        ),
        isTrue,
      );
    });

    test('null support level fails when any filter active', () {
      expect(
        LearningSupportFilterPredicates.matchesSupportLevelGroup(
          null,
          _levelFilters({SupportLevelType.supportLevel1}),
        ),
        isFalse,
      );
    });

    test('null support level passes when no filter active', () {
      expect(
        LearningSupportFilterPredicates.matchesSupportLevelGroup(
          null,
          _levelFilters(),
        ),
        isTrue,
      );
    });
  });

  group('matchesSpecialNeeds', () {
    test('passes when filter off', () {
      expect(
        LearningSupportFilterPredicates.matchesSpecialNeeds(null, false),
        isTrue,
      );
    });

    test('passes when filter on and has special needs', () {
      expect(
        LearningSupportFilterPredicates.matchesSpecialNeeds(['LE'], true),
        isTrue,
      );
    });

    test('fails when filter on and no special needs', () {
      expect(
        LearningSupportFilterPredicates.matchesSpecialNeeds(null, true),
        isFalse,
      );
    });
  });

  group('matchesSupportAreaGroup', () {
    test('passes when no area filters active', () {
      expect(
        LearningSupportFilterPredicates.matchesSupportAreaGroup(
          [_status(10)],
          _areaFilters(),
          (id) => id, // identity resolver
        ),
        isTrue,
      );
    });

    test('fails when statuses is null', () {
      expect(
        LearningSupportFilterPredicates.matchesSupportAreaGroup(
          null,
          _areaFilters(),
          (id) => id,
        ),
        isFalse,
      );
    });

    test('motorics filter matches status with root category 1', () {
      expect(
        LearningSupportFilterPredicates.matchesSupportAreaGroup(
          [_status(100)],
          _areaFilters({SupportArea.motorics}),
          (id) => 1, // all categories resolve to root 1 (motorics)
        ),
        isTrue,
      );
    });

    test('motorics filter rejects status with different root category', () {
      expect(
        LearningSupportFilterPredicates.matchesSupportAreaGroup(
          [_status(100)],
          _areaFilters({SupportArea.motorics}),
          (id) => 3, // resolves to root 3 (math), not 1 (motorics)
        ),
        isFalse,
      );
    });

    test('OR logic: motorics + math, status matches math', () {
      expect(
        LearningSupportFilterPredicates.matchesSupportAreaGroup(
          [_status(100)],
          _areaFilters({SupportArea.motorics, SupportArea.math}),
          (id) => 3, // matches math (3)
        ),
        isTrue,
      );
    });
  });

  group('matchesCurrentPlanGroup', () {
    test('passes when no plan filters active', () {
      expect(
        LearningSupportFilterPredicates.matchesCurrentPlanGroup(
          needsPlan: true,
          hasPlan: false,
          activeFilters: _planFilters(),
        ),
        isTrue,
      );
    });

    test('available filter matches when has plan', () {
      expect(
        LearningSupportFilterPredicates.matchesCurrentPlanGroup(
          needsPlan: true,
          hasPlan: true,
          activeFilters:
              _planFilters({CurrentLearningSupportPlan.available}),
        ),
        isTrue,
      );
    });

    test('available filter rejects when no plan', () {
      expect(
        LearningSupportFilterPredicates.matchesCurrentPlanGroup(
          needsPlan: true,
          hasPlan: false,
          activeFilters:
              _planFilters({CurrentLearningSupportPlan.available}),
        ),
        isFalse,
      );
    });

    test('notAvailable matches when needs but does not have plan', () {
      expect(
        LearningSupportFilterPredicates.matchesCurrentPlanGroup(
          needsPlan: true,
          hasPlan: false,
          activeFilters:
              _planFilters({CurrentLearningSupportPlan.notAvailable}),
        ),
        isTrue,
      );
    });

    test('notAvailable rejects when does not need plan', () {
      expect(
        LearningSupportFilterPredicates.matchesCurrentPlanGroup(
          needsPlan: false,
          hasPlan: false,
          activeFilters:
              _planFilters({CurrentLearningSupportPlan.notAvailable}),
        ),
        isFalse,
      );
    });
  });
}

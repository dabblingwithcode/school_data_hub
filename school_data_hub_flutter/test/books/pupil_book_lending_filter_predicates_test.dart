import 'package:flutter_test/flutter_test.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/books/domain/filters/pupil_book_lending_filter_predicates.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';

PupilBookLending _make({
  int score = 0,
  DateTime? lentAt,
  DateTime? returnedAt,
}) {
  return PupilBookLending(
    lendingId: 'L1',
    score: score,
    lentAt: lentAt ?? DateTime.utc(2026, 3, 10),
    lentBy: 'test',
    returnedAt: returnedAt,
    pupilId: 1,
    isbn: 123,
    libraryBookId: 1,
  );
}

Map<PupilBookLendingFilter, bool> _filters([
  Set<PupilBookLendingFilter> active = const {},
]) {
  return {
    for (final f in PupilBookLendingFilter.values) f: active.contains(f),
  };
}

void main() {
  group('excludeBySevenDays', () {
    final cutoff = DateTime.utc(2026, 3, 6);

    test('excludes when filter on and lent before cutoff', () {
      expect(
        PupilBookLendingFilterPredicates.excludeBySevenDays(
          lending: _make(lentAt: DateTime.utc(2026, 3, 1)),
          sevenDaysAgo: cutoff,
          filterOn: true,
        ),
        isTrue,
      );
    });

    test('does not exclude when lent after cutoff', () {
      expect(
        PupilBookLendingFilterPredicates.excludeBySevenDays(
          lending: _make(lentAt: DateTime.utc(2026, 3, 10)),
          sevenDaysAgo: cutoff,
          filterOn: true,
        ),
        isFalse,
      );
    });

    test('does not exclude when filter off', () {
      expect(
        PupilBookLendingFilterPredicates.excludeBySevenDays(
          lending: _make(lentAt: DateTime.utc(2026, 3, 1)),
          sevenDaysAgo: cutoff,
          filterOn: false,
        ),
        isFalse,
      );
    });
  });

  group('excludeByCurrentlyBorrowed', () {
    test('excludes returned book when filter on', () {
      expect(
        PupilBookLendingFilterPredicates.excludeByCurrentlyBorrowed(
          lending: _make(returnedAt: DateTime.utc(2026, 3, 12)),
          filterOn: true,
        ),
        isTrue,
      );
    });

    test('does not exclude unreturned book', () {
      expect(
        PupilBookLendingFilterPredicates.excludeByCurrentlyBorrowed(
          lending: _make(returnedAt: null),
          filterOn: true,
        ),
        isFalse,
      );
    });
  });

  group('excludeByReturned', () {
    test('excludes unreturned book when filter on', () {
      expect(
        PupilBookLendingFilterPredicates.excludeByReturned(
          lending: _make(returnedAt: null),
          filterOn: true,
        ),
        isTrue,
      );
    });

    test('does not exclude returned book', () {
      expect(
        PupilBookLendingFilterPredicates.excludeByReturned(
          lending: _make(returnedAt: DateTime.utc(2026, 3, 12)),
          filterOn: true,
        ),
        isFalse,
      );
    });
  });

  group('matchesScoreGroup', () {
    test('passes when no score filters active', () {
      expect(
        PupilBookLendingFilterPredicates.matchesScoreGroup(
          _make(score: 2),
          _filters(),
        ),
        isTrue,
      );
    });

    test('highScore matches score >= 3', () {
      expect(
        PupilBookLendingFilterPredicates.matchesScoreGroup(
          _make(score: 4),
          _filters({PupilBookLendingFilter.highScore}),
        ),
        isTrue,
      );
    });

    test('highScore rejects score < 3', () {
      expect(
        PupilBookLendingFilterPredicates.matchesScoreGroup(
          _make(score: 2),
          _filters({PupilBookLendingFilter.highScore}),
        ),
        isFalse,
      );
    });

    test('lowScore matches 0 < score < 3', () {
      expect(
        PupilBookLendingFilterPredicates.matchesScoreGroup(
          _make(score: 1),
          _filters({PupilBookLendingFilter.lowScore}),
        ),
        isTrue,
      );
    });

    test('noScore matches score == 0', () {
      expect(
        PupilBookLendingFilterPredicates.matchesScoreGroup(
          _make(score: 0),
          _filters({PupilBookLendingFilter.noScore}),
        ),
        isTrue,
      );
    });

    test('noScore rejects score > 0', () {
      expect(
        PupilBookLendingFilterPredicates.matchesScoreGroup(
          _make(score: 1),
          _filters({PupilBookLendingFilter.noScore}),
        ),
        isFalse,
      );
    });

    test('highScore + lowScore OR logic matches either', () {
      // score=4 matches highScore
      expect(
        PupilBookLendingFilterPredicates.matchesScoreGroup(
          _make(score: 4),
          _filters({
            PupilBookLendingFilter.highScore,
            PupilBookLendingFilter.lowScore,
          }),
        ),
        isTrue,
      );
      // score=1 matches lowScore
      expect(
        PupilBookLendingFilterPredicates.matchesScoreGroup(
          _make(score: 1),
          _filters({
            PupilBookLendingFilter.highScore,
            PupilBookLendingFilter.lowScore,
          }),
        ),
        isTrue,
      );
      // score=0 matches neither
      expect(
        PupilBookLendingFilterPredicates.matchesScoreGroup(
          _make(score: 0),
          _filters({
            PupilBookLendingFilter.highScore,
            PupilBookLendingFilter.lowScore,
          }),
        ),
        isFalse,
      );
    });
  });
}

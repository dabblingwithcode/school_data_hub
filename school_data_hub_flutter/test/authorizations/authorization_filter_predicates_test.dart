import 'package:flutter_test/flutter_test.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/authorizations/domain/filters/authorization_filter_predicates.dart';
import 'package:school_data_hub_flutter/features/authorizations/domain/filters/pupil_authorization_filter_manager.dart';

PupilAuthorization _make({bool? status, String? comment, int? fileId}) {
  return PupilAuthorization(
    authorizationId: 1,
    pupilId: 1,
    status: status,
    comment: comment,
    fileId: fileId,
  );
}

Map<AuthorizationFilter, bool> _filters([
  Set<AuthorizationFilter> active = const {},
]) {
  return {for (final f in AuthorizationFilter.values) f: active.contains(f)};
}

void main() {
  group('matchesAuthorizationGroup', () {
    test('passes when no filters active', () {
      expect(
        AuthorizationFilterPredicates.matchesAuthorizationGroup(
          _make(),
          _filters(),
        ),
        isTrue,
      );
    });

    test('yes filter matches status=true', () {
      expect(
        AuthorizationFilterPredicates.matchesAuthorizationGroup(
          _make(status: true),
          _filters({AuthorizationFilter.yes}),
        ),
        isTrue,
      );
    });

    test('yes filter rejects status=false', () {
      expect(
        AuthorizationFilterPredicates.matchesAuthorizationGroup(
          _make(status: false),
          _filters({AuthorizationFilter.yes}),
        ),
        isFalse,
      );
    });

    test('no filter matches status=false', () {
      expect(
        AuthorizationFilterPredicates.matchesAuthorizationGroup(
          _make(status: false),
          _filters({AuthorizationFilter.no}),
        ),
        isTrue,
      );
    });

    test('nullResponse filter matches null status', () {
      expect(
        AuthorizationFilterPredicates.matchesAuthorizationGroup(
          _make(status: null),
          _filters({AuthorizationFilter.nullResponse}),
        ),
        isTrue,
      );
    });

    test('nullResponse filter rejects non-null status', () {
      expect(
        AuthorizationFilterPredicates.matchesAuthorizationGroup(
          _make(status: true),
          _filters({AuthorizationFilter.nullResponse}),
        ),
        isFalse,
      );
    });

    test('commentResponse filter matches entry with comment', () {
      expect(
        AuthorizationFilterPredicates.matchesAuthorizationGroup(
          _make(comment: 'note'),
          _filters({AuthorizationFilter.commentResponse}),
        ),
        isTrue,
      );
    });

    test('commentResponse filter rejects entry without comment', () {
      expect(
        AuthorizationFilterPredicates.matchesAuthorizationGroup(
          _make(comment: null),
          _filters({AuthorizationFilter.commentResponse}),
        ),
        isFalse,
      );
    });

    test('fileResponse filter matches entry without file', () {
      expect(
        AuthorizationFilterPredicates.matchesAuthorizationGroup(
          _make(fileId: null),
          _filters({AuthorizationFilter.fileResponse}),
        ),
        isTrue,
      );
    });

    test('fileResponse filter rejects entry with file', () {
      expect(
        AuthorizationFilterPredicates.matchesAuthorizationGroup(
          _make(fileId: 42),
          _filters({AuthorizationFilter.fileResponse}),
        ),
        isFalse,
      );
    });

    test('multiple filters use OR logic', () {
      // yes + no active: status=true matches yes → passes
      expect(
        AuthorizationFilterPredicates.matchesAuthorizationGroup(
          _make(status: true),
          _filters({AuthorizationFilter.yes, AuthorizationFilter.no}),
        ),
        isTrue,
      );
      // yes + no active: status=null matches neither → fails
      expect(
        AuthorizationFilterPredicates.matchesAuthorizationGroup(
          _make(status: null),
          _filters({AuthorizationFilter.yes, AuthorizationFilter.no}),
        ),
        isFalse,
      );
    });
  });
}

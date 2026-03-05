import 'package:flutter_test/flutter_test.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/models/hook.dart';

void main() {
  group('Hook serialization', () {
    test('emits invite reject hook payload for consult.RESTServiceURL', () {
      final hook = Hook(
        id: 'reject-invites-to-matrix-corporal',
        eventType: 'beforeAuthenticatedRequest',
        matchRules: [
          MatchRules(key: 'method', regex: 'POST'),
          MatchRules(
            key: 'route',
            regex: '^/_matrix/client/(r0|v3)/rooms/[^/]+/invite\$',
          ),
        ],
        action: 'consult.RESTServiceURL',
        rESTServiceURL:
            'http://hook-rest-service:8080/reject-invite-to-matrix-corporal',
        rESTServiceContingencyHook: RESTServiceContingencyHook(
          action: 'reject',
          responseStatusCode: 503,
          rejectionErrorCode: 'M_SERVICE_UNAVAILABLE',
          rejectionErrorMessage: 'Invite check unavailable.',
        ),
      );

      expect(hook.toCorporalJson(), {
        'id': 'reject-invites-to-matrix-corporal',
        'eventType': 'beforeAuthenticatedRequest',
        'matchRules': [
          {'type': 'method', 'regex': 'POST'},
          {'type': 'route', 'regex': '^/_matrix/client/(r0|v3)/rooms/[^/]+/invite\$'},
        ],
        'action': 'consult.RESTServiceURL',
        'RESTServiceURL':
            'http://hook-rest-service:8080/reject-invite-to-matrix-corporal',
        'RESTServiceContingencyHook': {
          'action': 'reject',
          'responseStatusCode': 503,
          'rejectionErrorCode': 'M_SERVICE_UNAVAILABLE',
          'rejectionErrorMessage': 'Invite check unavailable.',
        },
      });
    });

    test('reads matrix-corporal key names from JSON', () {
      final hook = Hook.fromJson({
        'id': 'reject-invites-to-matrix-corporal',
        'eventType': 'beforeAuthenticatedRequest',
        'matchRules': [
          {'type': 'method', 'regex': 'POST'},
        ],
        'action': 'consult.RESTServiceURL',
        'RESTServiceURL':
            'http://hook-rest-service:8080/reject-invite-to-matrix-corporal',
        'RESTServiceContingencyHook': {
          'action': 'reject',
          'responseStatusCode': 503,
          'rejectionErrorCode': 'M_SERVICE_UNAVAILABLE',
          'rejectionErrorMessage': 'Invite check unavailable.',
        },
      });

      expect(hook.matchRules?.first.key, 'method');
      expect(
        hook.rESTServiceURL,
        'http://hook-rest-service:8080/reject-invite-to-matrix-corporal',
      );
      expect(hook.rESTServiceContingencyHook?.responseStatusCode, 503);
    });
  });
}

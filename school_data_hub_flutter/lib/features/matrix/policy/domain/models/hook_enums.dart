/// Event types for matrix-corporal hooks.
/// See: https://github.com/devture/matrix-corporal/blob/main/docs/event-hooks.md#event-types
enum HookEventType {
  beforeAnyRequest('beforeAnyRequest', 'Before any request'),
  beforeAuthenticatedRequest(
    'beforeAuthenticatedRequest',
    'Before authenticated request',
  ),
  beforeAuthenticatedPolicyCheckedRequest(
    'beforeAuthenticatedPolicyCheckedRequest',
    'Before authenticated policy-checked request',
  ),
  beforeUnauthenticatedRequest(
    'beforeUnauthenticatedRequest',
    'Before unauthenticated request',
  ),
  afterAnyRequest('afterAnyRequest', 'After any request'),
  afterAuthenticatedRequest(
    'afterAuthenticatedRequest',
    'After authenticated request',
  ),
  afterAuthenticatedPolicyCheckedRequest(
    'afterAuthenticatedPolicyCheckedRequest',
    'After authenticated policy-checked request',
  ),
  afterUnauthenticatedRequest(
    'afterUnauthenticatedRequest',
    'After unauthenticated request',
  );

  const HookEventType(this.apiValue, this.label);
  final String apiValue;
  final String label;

  static HookEventType? fromApiValue(String? value) {
    if (value == null || value.isEmpty) return null;
    for (final e in HookEventType.values) {
      if (e.apiValue == value) return e;
    }
    return null;
  }
}

/// Actions for matrix-corporal hooks.
/// See: https://github.com/devture/matrix-corporal/blob/main/docs/event-hooks.md#actions
enum HookAction {
  passUnmodified('pass.unmodified', 'Pass unmodified'),
  passModifiedRequest('pass.modifiedRequest', 'Pass modified request'),
  passModifiedResponse('pass.modifiedResponse', 'Pass modified response'),
  reject('reject', 'Reject'),
  respond('respond', 'Respond'),
  consultRESTServiceURL('consult.RESTServiceURL', 'Consult REST service URL');

  const HookAction(this.apiValue, this.label);
  final String apiValue;
  final String label;

  static HookAction? fromApiValue(String? value) {
    if (value == null || value.isEmpty) return null;
    for (final e in HookAction.values) {
      if (e.apiValue == value) return e;
    }
    return null;
  }
}

/// Match rule type for hook matchRules.
/// See: https://github.com/devture/matrix-corporal/blob/main/docs/event-hooks.md#matching-rules
enum MatchRuleType {
  method('method', 'HTTP method'),
  route('route', 'Request URI / route'),
  matrixUserID('matrixUserID', 'Matrix user ID');

  const MatchRuleType(this.apiValue, this.label);
  final String apiValue;
  final String label;

  static MatchRuleType? fromApiValue(String? value) {
    if (value == null || value.isEmpty) return null;
    for (final e in MatchRuleType.values) {
      if (e.apiValue == value) return e;
    }
    return null;
  }
}

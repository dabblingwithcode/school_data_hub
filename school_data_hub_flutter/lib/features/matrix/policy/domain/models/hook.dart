import 'package:json_annotation/json_annotation.dart';

part 'hook.g.dart';

@JsonSerializable()
class MatchRules {
  String? key;
  String? regex;

  MatchRules({this.key, this.regex});

  factory MatchRules.fromJson(Map<String, dynamic> json) =>
      _$MatchRulesFromJson(json);

  Map<String, dynamic> toJson() => _$MatchRulesToJson(this);

  Map<String, dynamic> toCorporalJson() {
    final map = <String, dynamic>{};
    if (key != null && key!.isNotEmpty) {
      map['type'] = key;
    }
    if (regex != null && regex!.isNotEmpty) {
      map['regex'] = regex;
    }
    return map;
  }

  MatchRules copyWith({String? key, String? regex}) => MatchRules(
        key: key ?? this.key,
        regex: regex ?? this.regex,
      );
}

@JsonSerializable()
class RESTServiceRequestHeaders {
  String? authorization;

  RESTServiceRequestHeaders({this.authorization});
  factory RESTServiceRequestHeaders.fromJson(Map<String, dynamic> json) =>
      _$RESTServiceRequestHeadersFromJson(json);
  Map<String, dynamic> toJson() => _$RESTServiceRequestHeadersToJson(this);

  RESTServiceRequestHeaders copyWith({String? authorization}) =>
      RESTServiceRequestHeaders(
        authorization: authorization ?? this.authorization,
      );
}

@JsonSerializable()
class RESTServiceContingencyHook {
  String? action;
  int? responseStatusCode;
  String? rejectionErrorCode;
  String? rejectionErrorMessage;

  RESTServiceContingencyHook({
    this.action,
    this.responseStatusCode,
    this.rejectionErrorCode,
    this.rejectionErrorMessage,
  });
  factory RESTServiceContingencyHook.fromJson(Map<String, dynamic> json) =>
      _$RESTServiceContingencyHookFromJson(json);
  Map<String, dynamic> toJson() => _$RESTServiceContingencyHookToJson(this);

  Map<String, dynamic> toCorporalJson() {
    final map = <String, dynamic>{};
    if (action != null && action!.isNotEmpty) {
      map['action'] = action;
    }
    if (responseStatusCode != null) {
      map['responseStatusCode'] = responseStatusCode;
    }
    if (rejectionErrorCode != null && rejectionErrorCode!.isNotEmpty) {
      map['rejectionErrorCode'] = rejectionErrorCode;
    }
    if (rejectionErrorMessage != null && rejectionErrorMessage!.isNotEmpty) {
      map['rejectionErrorMessage'] = rejectionErrorMessage;
    }
    return map;
  }

  RESTServiceContingencyHook copyWith({
    String? action,
    int? responseStatusCode,
    String? rejectionErrorCode,
    String? rejectionErrorMessage,
  }) =>
      RESTServiceContingencyHook(
        action: action ?? this.action,
        responseStatusCode: responseStatusCode ?? this.responseStatusCode,
        rejectionErrorCode: rejectionErrorCode ?? this.rejectionErrorCode,
        rejectionErrorMessage:
            rejectionErrorMessage ?? this.rejectionErrorMessage,
      );
}

@JsonSerializable()
class Hook {
  String? id;
  String? eventType;
  List<MatchRules>? matchRules;
  String? action;
  int? responseStatusCode;
  String? rejectionErrorCode;
  String? rejectionErrorMessage;
  String? rESTServiceURL;
  RESTServiceRequestHeaders? rESTServiceRequestHeaders;
  RESTServiceContingencyHook? rESTServiceContingencyHook;

  Hook({
    this.id,
    this.eventType,
    this.matchRules,
    this.action,
    this.responseStatusCode,
    this.rejectionErrorCode,
    this.rejectionErrorMessage,
    this.rESTServiceURL,
    this.rESTServiceRequestHeaders,
    this.rESTServiceContingencyHook,
  });
  factory Hook.fromJson(Map<String, dynamic> json) => _$HookFromJson(json);
  Map<String, dynamic> toJson() => _$HookToJson(this);

  Map<String, dynamic> toCorporalJson() {
    final map = <String, dynamic>{};
    if (id != null && id!.isNotEmpty) {
      map['id'] = id;
    }
    if (eventType != null && eventType!.isNotEmpty) {
      map['eventType'] = eventType;
    }
    if (matchRules != null && matchRules!.isNotEmpty) {
      map['matchRules'] = matchRules!
          .map((rule) => rule.toCorporalJson())
          .where((ruleMap) => ruleMap.isNotEmpty)
          .toList();
    }
    if (action != null && action!.isNotEmpty) {
      map['action'] = action;
    }

    switch (action) {
      case 'consult.RESTServiceURL':
        if (rESTServiceURL != null && rESTServiceURL!.isNotEmpty) {
          map['RESTServiceURL'] = rESTServiceURL;
        }
        if (rESTServiceContingencyHook != null) {
          final contingency = rESTServiceContingencyHook!.toCorporalJson();
          if (contingency.isNotEmpty) {
            map['RESTServiceContingencyHook'] = contingency;
          }
        }
        break;
      case 'reject':
      case 'respond':
        if (responseStatusCode != null) {
          map['responseStatusCode'] = responseStatusCode;
        }
        if (rejectionErrorCode != null && rejectionErrorCode!.isNotEmpty) {
          map['rejectionErrorCode'] = rejectionErrorCode;
        }
        if (rejectionErrorMessage != null && rejectionErrorMessage!.isNotEmpty) {
          map['rejectionErrorMessage'] = rejectionErrorMessage;
        }
        break;
      case 'pass.modifiedRequest':
      case 'pass.modifiedResponse':
      case 'pass.unmodified':
      case null:
        break;
      default:
        if (responseStatusCode != null) {
          map['responseStatusCode'] = responseStatusCode;
        }
        if (rejectionErrorCode != null && rejectionErrorCode!.isNotEmpty) {
          map['rejectionErrorCode'] = rejectionErrorCode;
        }
        if (rejectionErrorMessage != null && rejectionErrorMessage!.isNotEmpty) {
          map['rejectionErrorMessage'] = rejectionErrorMessage;
        }
        if (rESTServiceURL != null && rESTServiceURL!.isNotEmpty) {
          map['RESTServiceURL'] = rESTServiceURL;
        }
        if (rESTServiceContingencyHook != null) {
          final contingency = rESTServiceContingencyHook!.toCorporalJson();
          if (contingency.isNotEmpty) {
            map['RESTServiceContingencyHook'] = contingency;
          }
        }
        break;
    }

    return map;
  }

  Hook copyWith({
    String? id,
    String? eventType,
    List<MatchRules>? matchRules,
    String? action,
    int? responseStatusCode,
    String? rejectionErrorCode,
    String? rejectionErrorMessage,
    String? rESTServiceURL,
    RESTServiceRequestHeaders? rESTServiceRequestHeaders,
    RESTServiceContingencyHook? rESTServiceContingencyHook,
  }) =>
      Hook(
        id: id ?? this.id,
        eventType: eventType ?? this.eventType,
        matchRules: matchRules ?? this.matchRules,
        action: action ?? this.action,
        responseStatusCode: responseStatusCode ?? this.responseStatusCode,
        rejectionErrorCode: rejectionErrorCode ?? this.rejectionErrorCode,
        rejectionErrorMessage:
            rejectionErrorMessage ?? this.rejectionErrorMessage,
        rESTServiceURL: rESTServiceURL ?? this.rESTServiceURL,
        rESTServiceRequestHeaders:
            rESTServiceRequestHeaders ?? this.rESTServiceRequestHeaders,
        rESTServiceContingencyHook:
            rESTServiceContingencyHook ?? this.rESTServiceContingencyHook,
      );
}

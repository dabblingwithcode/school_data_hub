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
}

@JsonSerializable()
class RESTServiceRequestHeaders {
  String? authorization;

  RESTServiceRequestHeaders({this.authorization});
  factory RESTServiceRequestHeaders.fromJson(Map<String, dynamic> json) =>
      _$RESTServiceRequestHeadersFromJson(json);
  Map<String, dynamic> toJson() => _$RESTServiceRequestHeadersToJson(this);
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
}

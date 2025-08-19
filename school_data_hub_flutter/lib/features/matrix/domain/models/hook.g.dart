// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchRules _$MatchRulesFromJson(Map<String, dynamic> json) => MatchRules(
      key: json['key'] as String?,
      regex: json['regex'] as String?,
    );

Map<String, dynamic> _$MatchRulesToJson(MatchRules instance) =>
    <String, dynamic>{
      'key': instance.key,
      'regex': instance.regex,
    };

RESTServiceRequestHeaders _$RESTServiceRequestHeadersFromJson(
        Map<String, dynamic> json) =>
    RESTServiceRequestHeaders(
      authorization: json['authorization'] as String?,
    );

Map<String, dynamic> _$RESTServiceRequestHeadersToJson(
        RESTServiceRequestHeaders instance) =>
    <String, dynamic>{
      'authorization': instance.authorization,
    };

RESTServiceContingencyHook _$RESTServiceContingencyHookFromJson(
        Map<String, dynamic> json) =>
    RESTServiceContingencyHook(
      action: json['action'] as String?,
      responseStatusCode: (json['responseStatusCode'] as num?)?.toInt(),
      rejectionErrorCode: json['rejectionErrorCode'] as String?,
      rejectionErrorMessage: json['rejectionErrorMessage'] as String?,
    );

Map<String, dynamic> _$RESTServiceContingencyHookToJson(
        RESTServiceContingencyHook instance) =>
    <String, dynamic>{
      'action': instance.action,
      'responseStatusCode': instance.responseStatusCode,
      'rejectionErrorCode': instance.rejectionErrorCode,
      'rejectionErrorMessage': instance.rejectionErrorMessage,
    };

Hook _$HookFromJson(Map<String, dynamic> json) => Hook(
      id: json['id'] as String?,
      eventType: json['eventType'] as String?,
      matchRules: (json['matchRules'] as List<dynamic>?)
          ?.map((e) => MatchRules.fromJson(e as Map<String, dynamic>))
          .toList(),
      action: json['action'] as String?,
      responseStatusCode: (json['responseStatusCode'] as num?)?.toInt(),
      rejectionErrorCode: json['rejectionErrorCode'] as String?,
      rejectionErrorMessage: json['rejectionErrorMessage'] as String?,
      rESTServiceURL: json['rESTServiceURL'] as String?,
      rESTServiceRequestHeaders: json['rESTServiceRequestHeaders'] == null
          ? null
          : RESTServiceRequestHeaders.fromJson(
              json['rESTServiceRequestHeaders'] as Map<String, dynamic>),
      rESTServiceContingencyHook: json['rESTServiceContingencyHook'] == null
          ? null
          : RESTServiceContingencyHook.fromJson(
              json['rESTServiceContingencyHook'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HookToJson(Hook instance) => <String, dynamic>{
      'id': instance.id,
      'eventType': instance.eventType,
      'matchRules': instance.matchRules,
      'action': instance.action,
      'responseStatusCode': instance.responseStatusCode,
      'rejectionErrorCode': instance.rejectionErrorCode,
      'rejectionErrorMessage': instance.rejectionErrorMessage,
      'rESTServiceURL': instance.rESTServiceURL,
      'rESTServiceRequestHeaders': instance.rESTServiceRequestHeaders,
      'rESTServiceContingencyHook': instance.rESTServiceContingencyHook,
    };

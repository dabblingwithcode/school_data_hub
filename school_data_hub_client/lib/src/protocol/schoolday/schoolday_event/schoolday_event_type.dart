/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

enum SchooldayEventType implements _i1.SerializableModel {
  notSet,
  parentsMeeting,
  admonition,
  afternoonCareAdmonition,
  admonitionAndBanned,
  otherEvent;

  static SchooldayEventType fromJson(String name) {
    switch (name) {
      case 'notSet':
        return SchooldayEventType.notSet;
      case 'parentsMeeting':
        return SchooldayEventType.parentsMeeting;
      case 'admonition':
        return SchooldayEventType.admonition;
      case 'afternoonCareAdmonition':
        return SchooldayEventType.afternoonCareAdmonition;
      case 'admonitionAndBanned':
        return SchooldayEventType.admonitionAndBanned;
      case 'otherEvent':
        return SchooldayEventType.otherEvent;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "SchooldayEventType"');
    }
  }

  @override
  String toJson() => name;
  @override
  String toString() => name;
}

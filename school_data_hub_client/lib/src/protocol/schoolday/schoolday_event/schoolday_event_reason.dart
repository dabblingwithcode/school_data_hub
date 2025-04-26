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

enum SchooldayEventReason implements _i1.SerializableModel {
  violenceAgainstPupils,
  violenceAgainstTeachers,
  violenceAgainstThings,
  insultOthers,
  dangerousBehaviour,
  annoyOthers,
  ignoreInstructions,
  disturbLesson,
  other,
  learningDevelopmentInfo,
  learningSupportInfo,
  admonitionInfo;

  static SchooldayEventReason fromJson(String name) {
    switch (name) {
      case 'violenceAgainstPupils':
        return SchooldayEventReason.violenceAgainstPupils;
      case 'violenceAgainstTeachers':
        return SchooldayEventReason.violenceAgainstTeachers;
      case 'violenceAgainstThings':
        return SchooldayEventReason.violenceAgainstThings;
      case 'insultOthers':
        return SchooldayEventReason.insultOthers;
      case 'dangerousBehaviour':
        return SchooldayEventReason.dangerousBehaviour;
      case 'annoyOthers':
        return SchooldayEventReason.annoyOthers;
      case 'ignoreInstructions':
        return SchooldayEventReason.ignoreInstructions;
      case 'disturbLesson':
        return SchooldayEventReason.disturbLesson;
      case 'other':
        return SchooldayEventReason.other;
      case 'learningDevelopmentInfo':
        return SchooldayEventReason.learningDevelopmentInfo;
      case 'learningSupportInfo':
        return SchooldayEventReason.learningSupportInfo;
      case 'admonitionInfo':
        return SchooldayEventReason.admonitionInfo;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "SchooldayEventReason"');
    }
  }

  @override
  String toJson() => name;
  @override
  String toString() => name;
}

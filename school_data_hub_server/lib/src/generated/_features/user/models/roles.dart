/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

enum Role implements _i1.SerializableModel {
  admin,
  teacher,
  specialEducatorE,
  specialEducatorK,
  educator,
  trainee,
  afterSchoolCare,
  socialWorker,
  notAssigned;

  static Role fromJson(String name) {
    switch (name) {
      case 'admin':
        return Role.admin;
      case 'teacher':
        return Role.teacher;
      case 'specialEducatorE':
        return Role.specialEducatorE;
      case 'specialEducatorK':
        return Role.specialEducatorK;
      case 'educator':
        return Role.educator;
      case 'trainee':
        return Role.trainee;
      case 'afterSchoolCare':
        return Role.afterSchoolCare;
      case 'socialWorker':
        return Role.socialWorker;
      case 'notAssigned':
        return Role.notAssigned;
      default:
        throw ArgumentError('Value "$name" cannot be converted to "Role"');
    }
  }

  @override
  String toJson() => name;
  @override
  String toString() => name;
}

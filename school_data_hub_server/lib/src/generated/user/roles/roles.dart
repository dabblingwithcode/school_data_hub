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
  technical,
  teacher,
  educator,
  pupil,
  notAssigned;

  static Role fromJson(String name) {
    switch (name) {
      case 'technical':
        return Role.technical;
      case 'teacher':
        return Role.teacher;
      case 'educator':
        return Role.educator;
      case 'pupil':
        return Role.pupil;
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

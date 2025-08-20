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

enum MatrixRoomType implements _i1.SerializableModel {
  contacts,
  globalParents,
  globalChildrem,
  globalTeacher,
  groupChildren,
  groupParents,
  staff,
  other;

  static MatrixRoomType fromJson(String name) {
    switch (name) {
      case 'contacts':
        return MatrixRoomType.contacts;
      case 'globalParents':
        return MatrixRoomType.globalParents;
      case 'globalChildrem':
        return MatrixRoomType.globalChildrem;
      case 'globalTeacher':
        return MatrixRoomType.globalTeacher;
      case 'groupChildren':
        return MatrixRoomType.groupChildren;
      case 'groupParents':
        return MatrixRoomType.groupParents;
      case 'staff':
        return MatrixRoomType.staff;
      case 'other':
        return MatrixRoomType.other;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "MatrixRoomType"');
    }
  }

  @override
  String toJson() => name;
  @override
  String toString() => name;
}

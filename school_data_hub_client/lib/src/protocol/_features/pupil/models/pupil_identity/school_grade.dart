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

enum SchoolGrade implements _i1.SerializableModel {
  E1,
  E2,
  E3,
  K3,
  K4;

  static SchoolGrade fromJson(String name) {
    switch (name) {
      case 'E1':
        return SchoolGrade.E1;
      case 'E2':
        return SchoolGrade.E2;
      case 'E3':
        return SchoolGrade.E3;
      case 'K3':
        return SchoolGrade.K3;
      case 'K4':
        return SchoolGrade.K4;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "SchoolGrade"');
    }
  }

  @override
  String toJson() => name;
  @override
  String toString() => name;
}

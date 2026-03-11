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

abstract class BatchCreateUserError implements _i1.SerializableModel {
  BatchCreateUserError._({
    required this.rowIndex,
    required this.userNameOrKurzel,
    required this.message,
  });

  factory BatchCreateUserError({
    required int rowIndex,
    required String userNameOrKurzel,
    required String message,
  }) = _BatchCreateUserErrorImpl;

  factory BatchCreateUserError.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return BatchCreateUserError(
      rowIndex: jsonSerialization['rowIndex'] as int,
      userNameOrKurzel: jsonSerialization['userNameOrKurzel'] as String,
      message: jsonSerialization['message'] as String,
    );
  }

  int rowIndex;

  String userNameOrKurzel;

  String message;

  /// Returns a shallow copy of this [BatchCreateUserError]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BatchCreateUserError copyWith({
    int? rowIndex,
    String? userNameOrKurzel,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'rowIndex': rowIndex,
      'userNameOrKurzel': userNameOrKurzel,
      'message': message,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _BatchCreateUserErrorImpl extends BatchCreateUserError {
  _BatchCreateUserErrorImpl({
    required int rowIndex,
    required String userNameOrKurzel,
    required String message,
  }) : super._(
          rowIndex: rowIndex,
          userNameOrKurzel: userNameOrKurzel,
          message: message,
        );

  /// Returns a shallow copy of this [BatchCreateUserError]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BatchCreateUserError copyWith({
    int? rowIndex,
    String? userNameOrKurzel,
    String? message,
  }) {
    return BatchCreateUserError(
      rowIndex: rowIndex ?? this.rowIndex,
      userNameOrKurzel: userNameOrKurzel ?? this.userNameOrKurzel,
      message: message ?? this.message,
    );
  }
}

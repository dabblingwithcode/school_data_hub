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
import '../../../_features/admin/models/created_user_credential.dart' as _i2;
import '../../../_features/admin/models/batch_create_user_error.dart' as _i3;

abstract class BatchCreateUsersResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  BatchCreateUsersResponse._({
    required this.credentials,
    required this.errors,
  });

  factory BatchCreateUsersResponse({
    required List<_i2.CreatedUserCredential> credentials,
    required List<_i3.BatchCreateUserError> errors,
  }) = _BatchCreateUsersResponseImpl;

  factory BatchCreateUsersResponse.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return BatchCreateUsersResponse(
      credentials: (jsonSerialization['credentials'] as List)
          .map((e) =>
              _i2.CreatedUserCredential.fromJson((e as Map<String, dynamic>)))
          .toList(),
      errors: (jsonSerialization['errors'] as List)
          .map((e) =>
              _i3.BatchCreateUserError.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  List<_i2.CreatedUserCredential> credentials;

  List<_i3.BatchCreateUserError> errors;

  /// Returns a shallow copy of this [BatchCreateUsersResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BatchCreateUsersResponse copyWith({
    List<_i2.CreatedUserCredential>? credentials,
    List<_i3.BatchCreateUserError>? errors,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'credentials': credentials.toJson(valueToJson: (v) => v.toJson()),
      'errors': errors.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'credentials':
          credentials.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'errors': errors.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _BatchCreateUsersResponseImpl extends BatchCreateUsersResponse {
  _BatchCreateUsersResponseImpl({
    required List<_i2.CreatedUserCredential> credentials,
    required List<_i3.BatchCreateUserError> errors,
  }) : super._(
          credentials: credentials,
          errors: errors,
        );

  /// Returns a shallow copy of this [BatchCreateUsersResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BatchCreateUsersResponse copyWith({
    List<_i2.CreatedUserCredential>? credentials,
    List<_i3.BatchCreateUserError>? errors,
  }) {
    return BatchCreateUsersResponse(
      credentials:
          credentials ?? this.credentials.map((e0) => e0.copyWith()).toList(),
      errors: errors ?? this.errors.map((e0) => e0.copyWith()).toList(),
    );
  }
}

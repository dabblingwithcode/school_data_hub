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
import '../../../_features/admin/models/created_user_credential.dart' as _i2;
import '../../../_features/admin/models/batch_create_user_error.dart' as _i3;

abstract class BatchCreateUserEvent implements _i1.SerializableModel {
  BatchCreateUserEvent._({
    this.credential,
    this.error,
  });

  factory BatchCreateUserEvent({
    _i2.CreatedUserCredential? credential,
    _i3.BatchCreateUserError? error,
  }) = _BatchCreateUserEventImpl;

  factory BatchCreateUserEvent.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return BatchCreateUserEvent(
      credential: jsonSerialization['credential'] == null
          ? null
          : _i2.CreatedUserCredential.fromJson(
              (jsonSerialization['credential'] as Map<String, dynamic>)),
      error: jsonSerialization['error'] == null
          ? null
          : _i3.BatchCreateUserError.fromJson(
              (jsonSerialization['error'] as Map<String, dynamic>)),
    );
  }

  _i2.CreatedUserCredential? credential;

  _i3.BatchCreateUserError? error;

  /// Returns a shallow copy of this [BatchCreateUserEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BatchCreateUserEvent copyWith({
    _i2.CreatedUserCredential? credential,
    _i3.BatchCreateUserError? error,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (credential != null) 'credential': credential?.toJson(),
      if (error != null) 'error': error?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BatchCreateUserEventImpl extends BatchCreateUserEvent {
  _BatchCreateUserEventImpl({
    _i2.CreatedUserCredential? credential,
    _i3.BatchCreateUserError? error,
  }) : super._(
          credential: credential,
          error: error,
        );

  /// Returns a shallow copy of this [BatchCreateUserEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BatchCreateUserEvent copyWith({
    Object? credential = _Undefined,
    Object? error = _Undefined,
  }) {
    return BatchCreateUserEvent(
      credential: credential is _i2.CreatedUserCredential?
          ? credential
          : this.credential?.copyWith(),
      error:
          error is _i3.BatchCreateUserError? ? error : this.error?.copyWith(),
    );
  }
}

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

abstract class CreditTransaction implements _i1.SerializableModel {
  CreditTransaction._({
    this.id,
    required this.sender,
    required this.receiver,
    required this.amount,
    required this.dateTime,
    this.description,
  });

  factory CreditTransaction({
    int? id,
    required String sender,
    required int receiver,
    required int amount,
    required DateTime dateTime,
    String? description,
  }) = _CreditTransactionImpl;

  factory CreditTransaction.fromJson(Map<String, dynamic> jsonSerialization) {
    return CreditTransaction(
      id: jsonSerialization['id'] as int?,
      sender: jsonSerialization['sender'] as String,
      receiver: jsonSerialization['receiver'] as int,
      amount: jsonSerialization['amount'] as int,
      dateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateTime']),
      description: jsonSerialization['description'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String sender;

  int receiver;

  int amount;

  DateTime dateTime;

  String? description;

  /// Returns a shallow copy of this [CreditTransaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CreditTransaction copyWith({
    int? id,
    String? sender,
    int? receiver,
    int? amount,
    DateTime? dateTime,
    String? description,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'sender': sender,
      'receiver': receiver,
      'amount': amount,
      'dateTime': dateTime.toJson(),
      if (description != null) 'description': description,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CreditTransactionImpl extends CreditTransaction {
  _CreditTransactionImpl({
    int? id,
    required String sender,
    required int receiver,
    required int amount,
    required DateTime dateTime,
    String? description,
  }) : super._(
          id: id,
          sender: sender,
          receiver: receiver,
          amount: amount,
          dateTime: dateTime,
          description: description,
        );

  /// Returns a shallow copy of this [CreditTransaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CreditTransaction copyWith({
    Object? id = _Undefined,
    String? sender,
    int? receiver,
    int? amount,
    DateTime? dateTime,
    Object? description = _Undefined,
  }) {
    return CreditTransaction(
      id: id is int? ? id : this.id,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      amount: amount ?? this.amount,
      dateTime: dateTime ?? this.dateTime,
      description: description is String? ? description : this.description,
    );
  }
}

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

abstract class Transaction implements _i1.SerializableModel {
  Transaction._({
    this.id,
    required this.transactionId,
    required this.createdBy,
    required this.reciever,
    required this.amount,
    required this.dateTime,
    this.description,
  });

  factory Transaction({
    int? id,
    required String transactionId,
    required String createdBy,
    required int reciever,
    required int amount,
    required DateTime dateTime,
    String? description,
  }) = _TransactionImpl;

  factory Transaction.fromJson(Map<String, dynamic> jsonSerialization) {
    return Transaction(
      id: jsonSerialization['id'] as int?,
      transactionId: jsonSerialization['transactionId'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      reciever: jsonSerialization['reciever'] as int,
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

  String transactionId;

  String createdBy;

  int reciever;

  int amount;

  DateTime dateTime;

  String? description;

  /// Returns a shallow copy of this [Transaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Transaction copyWith({
    int? id,
    String? transactionId,
    String? createdBy,
    int? reciever,
    int? amount,
    DateTime? dateTime,
    String? description,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'transactionId': transactionId,
      'createdBy': createdBy,
      'reciever': reciever,
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

class _TransactionImpl extends Transaction {
  _TransactionImpl({
    int? id,
    required String transactionId,
    required String createdBy,
    required int reciever,
    required int amount,
    required DateTime dateTime,
    String? description,
  }) : super._(
          id: id,
          transactionId: transactionId,
          createdBy: createdBy,
          reciever: reciever,
          amount: amount,
          dateTime: dateTime,
          description: description,
        );

  /// Returns a shallow copy of this [Transaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Transaction copyWith({
    Object? id = _Undefined,
    String? transactionId,
    String? createdBy,
    int? reciever,
    int? amount,
    DateTime? dateTime,
    Object? description = _Undefined,
  }) {
    return Transaction(
      id: id is int? ? id : this.id,
      transactionId: transactionId ?? this.transactionId,
      createdBy: createdBy ?? this.createdBy,
      reciever: reciever ?? this.reciever,
      amount: amount ?? this.amount,
      dateTime: dateTime ?? this.dateTime,
      description: description is String? ? description : this.description,
    );
  }
}

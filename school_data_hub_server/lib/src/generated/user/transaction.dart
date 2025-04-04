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

abstract class Transaction implements _i1.TableRow, _i1.ProtocolSerialization {
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

  static final t = TransactionTable();

  static const db = TransactionRepository._();

  @override
  int? id;

  String transactionId;

  String createdBy;

  int reciever;

  int amount;

  DateTime dateTime;

  String? description;

  @override
  _i1.Table get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static TransactionInclude include() {
    return TransactionInclude._();
  }

  static TransactionIncludeList includeList({
    _i1.WhereExpressionBuilder<TransactionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TransactionTable>? orderByList,
    TransactionInclude? include,
  }) {
    return TransactionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Transaction.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Transaction.t),
      include: include,
    );
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

class TransactionTable extends _i1.Table {
  TransactionTable({super.tableRelation}) : super(tableName: 'transaction') {
    transactionId = _i1.ColumnString(
      'transactionId',
      this,
    );
    createdBy = _i1.ColumnString(
      'createdBy',
      this,
    );
    reciever = _i1.ColumnInt(
      'reciever',
      this,
    );
    amount = _i1.ColumnInt(
      'amount',
      this,
    );
    dateTime = _i1.ColumnDateTime(
      'dateTime',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
  }

  late final _i1.ColumnString transactionId;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnInt reciever;

  late final _i1.ColumnInt amount;

  late final _i1.ColumnDateTime dateTime;

  late final _i1.ColumnString description;

  @override
  List<_i1.Column> get columns => [
        id,
        transactionId,
        createdBy,
        reciever,
        amount,
        dateTime,
        description,
      ];
}

class TransactionInclude extends _i1.IncludeObject {
  TransactionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Transaction.t;
}

class TransactionIncludeList extends _i1.IncludeList {
  TransactionIncludeList._({
    _i1.WhereExpressionBuilder<TransactionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Transaction.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Transaction.t;
}

class TransactionRepository {
  const TransactionRepository._();

  /// Returns a list of [Transaction]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Transaction>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TransactionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TransactionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Transaction>(
      where: where?.call(Transaction.t),
      orderBy: orderBy?.call(Transaction.t),
      orderByList: orderByList?.call(Transaction.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Transaction] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Transaction?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TransactionTable>? where,
    int? offset,
    _i1.OrderByBuilder<TransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TransactionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Transaction>(
      where: where?.call(Transaction.t),
      orderBy: orderBy?.call(Transaction.t),
      orderByList: orderByList?.call(Transaction.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Transaction] by its [id] or null if no such row exists.
  Future<Transaction?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Transaction>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Transaction]s in the list and returns the inserted rows.
  ///
  /// The returned [Transaction]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Transaction>> insert(
    _i1.Session session,
    List<Transaction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Transaction>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Transaction] and returns the inserted row.
  ///
  /// The returned [Transaction] will have its `id` field set.
  Future<Transaction> insertRow(
    _i1.Session session,
    Transaction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Transaction>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Transaction]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Transaction>> update(
    _i1.Session session,
    List<Transaction> rows, {
    _i1.ColumnSelections<TransactionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Transaction>(
      rows,
      columns: columns?.call(Transaction.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Transaction]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Transaction> updateRow(
    _i1.Session session,
    Transaction row, {
    _i1.ColumnSelections<TransactionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Transaction>(
      row,
      columns: columns?.call(Transaction.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Transaction]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Transaction>> delete(
    _i1.Session session,
    List<Transaction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Transaction>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Transaction].
  Future<Transaction> deleteRow(
    _i1.Session session,
    Transaction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Transaction>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Transaction>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TransactionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Transaction>(
      where: where(Transaction.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TransactionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Transaction>(
      where: where?.call(Transaction.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

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

abstract class CreditTransaction
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CreditTransaction._({
    this.id,
    required this.sender,
    required this.receiver,
    required this.amount,
    required this.dateTime,
    this.description,
  }) : _pupilDataCredittransactionsPupilDataId = null;

  factory CreditTransaction({
    int? id,
    required String sender,
    required int receiver,
    required int amount,
    required DateTime dateTime,
    String? description,
  }) = _CreditTransactionImpl;

  factory CreditTransaction.fromJson(Map<String, dynamic> jsonSerialization) {
    return CreditTransactionImplicit._(
      id: jsonSerialization['id'] as int?,
      sender: jsonSerialization['sender'] as String,
      receiver: jsonSerialization['receiver'] as int,
      amount: jsonSerialization['amount'] as int,
      dateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateTime']),
      description: jsonSerialization['description'] as String?,
      $_pupilDataCredittransactionsPupilDataId:
          jsonSerialization['_pupilDataCredittransactionsPupilDataId'] as int?,
    );
  }

  static final t = CreditTransactionTable();

  static const db = CreditTransactionRepository._();

  @override
  int? id;

  String sender;

  int receiver;

  int amount;

  DateTime dateTime;

  String? description;

  final int? _pupilDataCredittransactionsPupilDataId;

  @override
  _i1.Table<int?> get table => t;

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
      if (_pupilDataCredittransactionsPupilDataId != null)
        '_pupilDataCredittransactionsPupilDataId':
            _pupilDataCredittransactionsPupilDataId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'sender': sender,
      'receiver': receiver,
      'amount': amount,
      'dateTime': dateTime.toJson(),
      if (description != null) 'description': description,
    };
  }

  static CreditTransactionInclude include() {
    return CreditTransactionInclude._();
  }

  static CreditTransactionIncludeList includeList({
    _i1.WhereExpressionBuilder<CreditTransactionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CreditTransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CreditTransactionTable>? orderByList,
    CreditTransactionInclude? include,
  }) {
    return CreditTransactionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CreditTransaction.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CreditTransaction.t),
      include: include,
    );
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
    return CreditTransactionImplicit._(
      id: id is int? ? id : this.id,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      amount: amount ?? this.amount,
      dateTime: dateTime ?? this.dateTime,
      description: description is String? ? description : this.description,
      $_pupilDataCredittransactionsPupilDataId:
          this._pupilDataCredittransactionsPupilDataId,
    );
  }
}

class CreditTransactionImplicit extends _CreditTransactionImpl {
  CreditTransactionImplicit._({
    int? id,
    required String sender,
    required int receiver,
    required int amount,
    required DateTime dateTime,
    String? description,
    int? $_pupilDataCredittransactionsPupilDataId,
  })  : _pupilDataCredittransactionsPupilDataId =
            $_pupilDataCredittransactionsPupilDataId,
        super(
          id: id,
          sender: sender,
          receiver: receiver,
          amount: amount,
          dateTime: dateTime,
          description: description,
        );

  factory CreditTransactionImplicit(
    CreditTransaction creditTransaction, {
    int? $_pupilDataCredittransactionsPupilDataId,
  }) {
    return CreditTransactionImplicit._(
      id: creditTransaction.id,
      sender: creditTransaction.sender,
      receiver: creditTransaction.receiver,
      amount: creditTransaction.amount,
      dateTime: creditTransaction.dateTime,
      description: creditTransaction.description,
      $_pupilDataCredittransactionsPupilDataId:
          $_pupilDataCredittransactionsPupilDataId,
    );
  }

  @override
  final int? _pupilDataCredittransactionsPupilDataId;
}

class CreditTransactionTable extends _i1.Table<int?> {
  CreditTransactionTable({super.tableRelation})
      : super(tableName: 'credit_transaction') {
    sender = _i1.ColumnString(
      'sender',
      this,
    );
    receiver = _i1.ColumnInt(
      'receiver',
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
    $_pupilDataCredittransactionsPupilDataId = _i1.ColumnInt(
      '_pupilDataCredittransactionsPupilDataId',
      this,
    );
  }

  late final _i1.ColumnString sender;

  late final _i1.ColumnInt receiver;

  late final _i1.ColumnInt amount;

  late final _i1.ColumnDateTime dateTime;

  late final _i1.ColumnString description;

  late final _i1.ColumnInt $_pupilDataCredittransactionsPupilDataId;

  @override
  List<_i1.Column> get columns => [
        id,
        sender,
        receiver,
        amount,
        dateTime,
        description,
        $_pupilDataCredittransactionsPupilDataId,
      ];

  @override
  List<_i1.Column> get managedColumns => [
        id,
        sender,
        receiver,
        amount,
        dateTime,
        description,
      ];
}

class CreditTransactionInclude extends _i1.IncludeObject {
  CreditTransactionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CreditTransaction.t;
}

class CreditTransactionIncludeList extends _i1.IncludeList {
  CreditTransactionIncludeList._({
    _i1.WhereExpressionBuilder<CreditTransactionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CreditTransaction.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CreditTransaction.t;
}

class CreditTransactionRepository {
  const CreditTransactionRepository._();

  /// Returns a list of [CreditTransaction]s matching the given query parameters.
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
  Future<List<CreditTransaction>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CreditTransactionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CreditTransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CreditTransactionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<CreditTransaction>(
      where: where?.call(CreditTransaction.t),
      orderBy: orderBy?.call(CreditTransaction.t),
      orderByList: orderByList?.call(CreditTransaction.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [CreditTransaction] matching the given query parameters.
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
  Future<CreditTransaction?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CreditTransactionTable>? where,
    int? offset,
    _i1.OrderByBuilder<CreditTransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CreditTransactionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<CreditTransaction>(
      where: where?.call(CreditTransaction.t),
      orderBy: orderBy?.call(CreditTransaction.t),
      orderByList: orderByList?.call(CreditTransaction.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [CreditTransaction] by its [id] or null if no such row exists.
  Future<CreditTransaction?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<CreditTransaction>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [CreditTransaction]s in the list and returns the inserted rows.
  ///
  /// The returned [CreditTransaction]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CreditTransaction>> insert(
    _i1.Session session,
    List<CreditTransaction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CreditTransaction>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CreditTransaction] and returns the inserted row.
  ///
  /// The returned [CreditTransaction] will have its `id` field set.
  Future<CreditTransaction> insertRow(
    _i1.Session session,
    CreditTransaction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CreditTransaction>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CreditTransaction]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CreditTransaction>> update(
    _i1.Session session,
    List<CreditTransaction> rows, {
    _i1.ColumnSelections<CreditTransactionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CreditTransaction>(
      rows,
      columns: columns?.call(CreditTransaction.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CreditTransaction]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CreditTransaction> updateRow(
    _i1.Session session,
    CreditTransaction row, {
    _i1.ColumnSelections<CreditTransactionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CreditTransaction>(
      row,
      columns: columns?.call(CreditTransaction.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CreditTransaction]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CreditTransaction>> delete(
    _i1.Session session,
    List<CreditTransaction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CreditTransaction>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CreditTransaction].
  Future<CreditTransaction> deleteRow(
    _i1.Session session,
    CreditTransaction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CreditTransaction>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CreditTransaction>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CreditTransactionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CreditTransaction>(
      where: where(CreditTransaction.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CreditTransactionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CreditTransaction>(
      where: where?.call(CreditTransaction.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

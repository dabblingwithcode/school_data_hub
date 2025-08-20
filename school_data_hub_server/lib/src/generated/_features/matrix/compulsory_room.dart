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
import '../../_features/matrix/matrix_room_type.dart' as _i2;

abstract class CompulsoryRoom
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CompulsoryRoom._({
    this.id,
    required this.roomId,
    required this.roomType,
  });

  factory CompulsoryRoom({
    int? id,
    required String roomId,
    required _i2.MatrixRoomType roomType,
  }) = _CompulsoryRoomImpl;

  factory CompulsoryRoom.fromJson(Map<String, dynamic> jsonSerialization) {
    return CompulsoryRoom(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as String,
      roomType: _i2.MatrixRoomType.fromJson(
          (jsonSerialization['roomType'] as String)),
    );
  }

  static final t = CompulsoryRoomTable();

  static const db = CompulsoryRoomRepository._();

  @override
  int? id;

  String roomId;

  _i2.MatrixRoomType roomType;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CompulsoryRoom]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CompulsoryRoom copyWith({
    int? id,
    String? roomId,
    _i2.MatrixRoomType? roomType,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'roomId': roomId,
      'roomType': roomType.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'roomId': roomId,
      'roomType': roomType.toJson(),
    };
  }

  static CompulsoryRoomInclude include() {
    return CompulsoryRoomInclude._();
  }

  static CompulsoryRoomIncludeList includeList({
    _i1.WhereExpressionBuilder<CompulsoryRoomTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CompulsoryRoomTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompulsoryRoomTable>? orderByList,
    CompulsoryRoomInclude? include,
  }) {
    return CompulsoryRoomIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CompulsoryRoom.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CompulsoryRoom.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompulsoryRoomImpl extends CompulsoryRoom {
  _CompulsoryRoomImpl({
    int? id,
    required String roomId,
    required _i2.MatrixRoomType roomType,
  }) : super._(
          id: id,
          roomId: roomId,
          roomType: roomType,
        );

  /// Returns a shallow copy of this [CompulsoryRoom]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CompulsoryRoom copyWith({
    Object? id = _Undefined,
    String? roomId,
    _i2.MatrixRoomType? roomType,
  }) {
    return CompulsoryRoom(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      roomType: roomType ?? this.roomType,
    );
  }
}

class CompulsoryRoomTable extends _i1.Table<int?> {
  CompulsoryRoomTable({super.tableRelation})
      : super(tableName: 'compulsory_room') {
    roomId = _i1.ColumnString(
      'roomId',
      this,
    );
    roomType = _i1.ColumnEnum(
      'roomType',
      this,
      _i1.EnumSerialization.byName,
    );
  }

  late final _i1.ColumnString roomId;

  late final _i1.ColumnEnum<_i2.MatrixRoomType> roomType;

  @override
  List<_i1.Column> get columns => [
        id,
        roomId,
        roomType,
      ];
}

class CompulsoryRoomInclude extends _i1.IncludeObject {
  CompulsoryRoomInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CompulsoryRoom.t;
}

class CompulsoryRoomIncludeList extends _i1.IncludeList {
  CompulsoryRoomIncludeList._({
    _i1.WhereExpressionBuilder<CompulsoryRoomTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CompulsoryRoom.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CompulsoryRoom.t;
}

class CompulsoryRoomRepository {
  const CompulsoryRoomRepository._();

  /// Returns a list of [CompulsoryRoom]s matching the given query parameters.
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
  Future<List<CompulsoryRoom>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompulsoryRoomTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CompulsoryRoomTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompulsoryRoomTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<CompulsoryRoom>(
      where: where?.call(CompulsoryRoom.t),
      orderBy: orderBy?.call(CompulsoryRoom.t),
      orderByList: orderByList?.call(CompulsoryRoom.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [CompulsoryRoom] matching the given query parameters.
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
  Future<CompulsoryRoom?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompulsoryRoomTable>? where,
    int? offset,
    _i1.OrderByBuilder<CompulsoryRoomTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompulsoryRoomTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<CompulsoryRoom>(
      where: where?.call(CompulsoryRoom.t),
      orderBy: orderBy?.call(CompulsoryRoom.t),
      orderByList: orderByList?.call(CompulsoryRoom.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [CompulsoryRoom] by its [id] or null if no such row exists.
  Future<CompulsoryRoom?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<CompulsoryRoom>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [CompulsoryRoom]s in the list and returns the inserted rows.
  ///
  /// The returned [CompulsoryRoom]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CompulsoryRoom>> insert(
    _i1.Session session,
    List<CompulsoryRoom> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CompulsoryRoom>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CompulsoryRoom] and returns the inserted row.
  ///
  /// The returned [CompulsoryRoom] will have its `id` field set.
  Future<CompulsoryRoom> insertRow(
    _i1.Session session,
    CompulsoryRoom row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CompulsoryRoom>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CompulsoryRoom]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CompulsoryRoom>> update(
    _i1.Session session,
    List<CompulsoryRoom> rows, {
    _i1.ColumnSelections<CompulsoryRoomTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CompulsoryRoom>(
      rows,
      columns: columns?.call(CompulsoryRoom.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CompulsoryRoom]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CompulsoryRoom> updateRow(
    _i1.Session session,
    CompulsoryRoom row, {
    _i1.ColumnSelections<CompulsoryRoomTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CompulsoryRoom>(
      row,
      columns: columns?.call(CompulsoryRoom.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CompulsoryRoom]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CompulsoryRoom>> delete(
    _i1.Session session,
    List<CompulsoryRoom> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CompulsoryRoom>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CompulsoryRoom].
  Future<CompulsoryRoom> deleteRow(
    _i1.Session session,
    CompulsoryRoom row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CompulsoryRoom>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CompulsoryRoom>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CompulsoryRoomTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CompulsoryRoom>(
      where: where(CompulsoryRoom.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompulsoryRoomTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CompulsoryRoom>(
      where: where?.call(CompulsoryRoom.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

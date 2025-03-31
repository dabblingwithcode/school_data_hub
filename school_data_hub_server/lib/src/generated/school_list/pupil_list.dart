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
import '../school_list/school_list.dart' as _i2;
import '../pupil_data/pupil_data.dart' as _i3;

abstract class PupilList implements _i1.TableRow, _i1.ProtocolSerialization {
  PupilList._({
    this.id,
    this.status,
    this.comment,
    this.entryBy,
    required this.schoolListId,
    this.schoolList,
    required this.pupilId,
    this.pupil,
  });

  factory PupilList({
    int? id,
    bool? status,
    String? comment,
    String? entryBy,
    required int schoolListId,
    _i2.SchoolList? schoolList,
    required int pupilId,
    _i3.PupilData? pupil,
  }) = _PupilListImpl;

  factory PupilList.fromJson(Map<String, dynamic> jsonSerialization) {
    return PupilList(
      id: jsonSerialization['id'] as int?,
      status: jsonSerialization['status'] as bool?,
      comment: jsonSerialization['comment'] as String?,
      entryBy: jsonSerialization['entryBy'] as String?,
      schoolListId: jsonSerialization['schoolListId'] as int,
      schoolList: jsonSerialization['schoolList'] == null
          ? null
          : _i2.SchoolList.fromJson(
              (jsonSerialization['schoolList'] as Map<String, dynamic>)),
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i3.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
    );
  }

  static final t = PupilListTable();

  static const db = PupilListRepository._();

  @override
  int? id;

  bool? status;

  String? comment;

  String? entryBy;

  int schoolListId;

  _i2.SchoolList? schoolList;

  int pupilId;

  _i3.PupilData? pupil;

  @override
  _i1.Table get table => t;

  /// Returns a shallow copy of this [PupilList]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilList copyWith({
    int? id,
    bool? status,
    String? comment,
    String? entryBy,
    int? schoolListId,
    _i2.SchoolList? schoolList,
    int? pupilId,
    _i3.PupilData? pupil,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (status != null) 'status': status,
      if (comment != null) 'comment': comment,
      if (entryBy != null) 'entryBy': entryBy,
      'schoolListId': schoolListId,
      if (schoolList != null) 'schoolList': schoolList?.toJson(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (status != null) 'status': status,
      if (comment != null) 'comment': comment,
      if (entryBy != null) 'entryBy': entryBy,
      'schoolListId': schoolListId,
      if (schoolList != null) 'schoolList': schoolList?.toJsonForProtocol(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJsonForProtocol(),
    };
  }

  static PupilListInclude include({
    _i2.SchoolListInclude? schoolList,
    _i3.PupilDataInclude? pupil,
  }) {
    return PupilListInclude._(
      schoolList: schoolList,
      pupil: pupil,
    );
  }

  static PupilListIncludeList includeList({
    _i1.WhereExpressionBuilder<PupilListTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PupilListTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilListTable>? orderByList,
    PupilListInclude? include,
  }) {
    return PupilListIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PupilList.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PupilList.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PupilListImpl extends PupilList {
  _PupilListImpl({
    int? id,
    bool? status,
    String? comment,
    String? entryBy,
    required int schoolListId,
    _i2.SchoolList? schoolList,
    required int pupilId,
    _i3.PupilData? pupil,
  }) : super._(
          id: id,
          status: status,
          comment: comment,
          entryBy: entryBy,
          schoolListId: schoolListId,
          schoolList: schoolList,
          pupilId: pupilId,
          pupil: pupil,
        );

  /// Returns a shallow copy of this [PupilList]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilList copyWith({
    Object? id = _Undefined,
    Object? status = _Undefined,
    Object? comment = _Undefined,
    Object? entryBy = _Undefined,
    int? schoolListId,
    Object? schoolList = _Undefined,
    int? pupilId,
    Object? pupil = _Undefined,
  }) {
    return PupilList(
      id: id is int? ? id : this.id,
      status: status is bool? ? status : this.status,
      comment: comment is String? ? comment : this.comment,
      entryBy: entryBy is String? ? entryBy : this.entryBy,
      schoolListId: schoolListId ?? this.schoolListId,
      schoolList: schoolList is _i2.SchoolList?
          ? schoolList
          : this.schoolList?.copyWith(),
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i3.PupilData? ? pupil : this.pupil?.copyWith(),
    );
  }
}

class PupilListTable extends _i1.Table {
  PupilListTable({super.tableRelation}) : super(tableName: 'pupil_list') {
    status = _i1.ColumnBool(
      'status',
      this,
    );
    comment = _i1.ColumnString(
      'comment',
      this,
    );
    entryBy = _i1.ColumnString(
      'entryBy',
      this,
    );
    schoolListId = _i1.ColumnInt(
      'schoolListId',
      this,
    );
    pupilId = _i1.ColumnInt(
      'pupilId',
      this,
    );
  }

  late final _i1.ColumnBool status;

  late final _i1.ColumnString comment;

  late final _i1.ColumnString entryBy;

  late final _i1.ColumnInt schoolListId;

  _i2.SchoolListTable? _schoolList;

  late final _i1.ColumnInt pupilId;

  _i3.PupilDataTable? _pupil;

  _i2.SchoolListTable get schoolList {
    if (_schoolList != null) return _schoolList!;
    _schoolList = _i1.createRelationTable(
      relationFieldName: 'schoolList',
      field: PupilList.t.schoolListId,
      foreignField: _i2.SchoolList.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SchoolListTable(tableRelation: foreignTableRelation),
    );
    return _schoolList!;
  }

  _i3.PupilDataTable get pupil {
    if (_pupil != null) return _pupil!;
    _pupil = _i1.createRelationTable(
      relationFieldName: 'pupil',
      field: PupilList.t.pupilId,
      foreignField: _i3.PupilData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PupilDataTable(tableRelation: foreignTableRelation),
    );
    return _pupil!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        status,
        comment,
        entryBy,
        schoolListId,
        pupilId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'schoolList') {
      return schoolList;
    }
    if (relationField == 'pupil') {
      return pupil;
    }
    return null;
  }
}

class PupilListInclude extends _i1.IncludeObject {
  PupilListInclude._({
    _i2.SchoolListInclude? schoolList,
    _i3.PupilDataInclude? pupil,
  }) {
    _schoolList = schoolList;
    _pupil = pupil;
  }

  _i2.SchoolListInclude? _schoolList;

  _i3.PupilDataInclude? _pupil;

  @override
  Map<String, _i1.Include?> get includes => {
        'schoolList': _schoolList,
        'pupil': _pupil,
      };

  @override
  _i1.Table get table => PupilList.t;
}

class PupilListIncludeList extends _i1.IncludeList {
  PupilListIncludeList._({
    _i1.WhereExpressionBuilder<PupilListTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PupilList.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => PupilList.t;
}

class PupilListRepository {
  const PupilListRepository._();

  final attachRow = const PupilListAttachRowRepository._();

  /// Returns a list of [PupilList]s matching the given query parameters.
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
  Future<List<PupilList>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilListTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PupilListTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilListTable>? orderByList,
    _i1.Transaction? transaction,
    PupilListInclude? include,
  }) async {
    return session.db.find<PupilList>(
      where: where?.call(PupilList.t),
      orderBy: orderBy?.call(PupilList.t),
      orderByList: orderByList?.call(PupilList.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [PupilList] matching the given query parameters.
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
  Future<PupilList?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilListTable>? where,
    int? offset,
    _i1.OrderByBuilder<PupilListTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilListTable>? orderByList,
    _i1.Transaction? transaction,
    PupilListInclude? include,
  }) async {
    return session.db.findFirstRow<PupilList>(
      where: where?.call(PupilList.t),
      orderBy: orderBy?.call(PupilList.t),
      orderByList: orderByList?.call(PupilList.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [PupilList] by its [id] or null if no such row exists.
  Future<PupilList?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    PupilListInclude? include,
  }) async {
    return session.db.findById<PupilList>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [PupilList]s in the list and returns the inserted rows.
  ///
  /// The returned [PupilList]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PupilList>> insert(
    _i1.Session session,
    List<PupilList> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PupilList>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PupilList] and returns the inserted row.
  ///
  /// The returned [PupilList] will have its `id` field set.
  Future<PupilList> insertRow(
    _i1.Session session,
    PupilList row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PupilList>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PupilList]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PupilList>> update(
    _i1.Session session,
    List<PupilList> rows, {
    _i1.ColumnSelections<PupilListTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PupilList>(
      rows,
      columns: columns?.call(PupilList.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PupilList]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PupilList> updateRow(
    _i1.Session session,
    PupilList row, {
    _i1.ColumnSelections<PupilListTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PupilList>(
      row,
      columns: columns?.call(PupilList.t),
      transaction: transaction,
    );
  }

  /// Deletes all [PupilList]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PupilList>> delete(
    _i1.Session session,
    List<PupilList> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PupilList>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PupilList].
  Future<PupilList> deleteRow(
    _i1.Session session,
    PupilList row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PupilList>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PupilList>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PupilListTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PupilList>(
      where: where(PupilList.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilListTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PupilList>(
      where: where?.call(PupilList.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class PupilListAttachRowRepository {
  const PupilListAttachRowRepository._();

  /// Creates a relation between the given [PupilList] and [SchoolList]
  /// by setting the [PupilList]'s foreign key `schoolListId` to refer to the [SchoolList].
  Future<void> schoolList(
    _i1.Session session,
    PupilList pupilList,
    _i2.SchoolList schoolList, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilList.id == null) {
      throw ArgumentError.notNull('pupilList.id');
    }
    if (schoolList.id == null) {
      throw ArgumentError.notNull('schoolList.id');
    }

    var $pupilList = pupilList.copyWith(schoolListId: schoolList.id);
    await session.db.updateRow<PupilList>(
      $pupilList,
      columns: [PupilList.t.schoolListId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [PupilList] and [PupilData]
  /// by setting the [PupilList]'s foreign key `pupilId` to refer to the [PupilData].
  Future<void> pupil(
    _i1.Session session,
    PupilList pupilList,
    _i3.PupilData pupil, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilList.id == null) {
      throw ArgumentError.notNull('pupilList.id');
    }
    if (pupil.id == null) {
      throw ArgumentError.notNull('pupil.id');
    }

    var $pupilList = pupilList.copyWith(pupilId: pupil.id);
    await session.db.updateRow<PupilList>(
      $pupilList,
      columns: [PupilList.t.pupilId],
      transaction: transaction,
    );
  }
}

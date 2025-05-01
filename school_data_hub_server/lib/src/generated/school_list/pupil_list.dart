/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../school_list/school_list.dart' as _i2;
import '../pupil_data/pupil_data.dart' as _i3;

abstract class PupilListEntry
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PupilListEntry._({
    this.id,
    this.status,
    this.comment,
    this.entryBy,
    required this.schoolListId,
    this.schoolList,
    required this.pupilId,
    this.pupil,
  });

  factory PupilListEntry({
    int? id,
    bool? status,
    String? comment,
    String? entryBy,
    required int schoolListId,
    _i2.SchoolList? schoolList,
    required int pupilId,
    _i3.PupilData? pupil,
  }) = _PupilListEntryImpl;

  factory PupilListEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return PupilListEntry(
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

  static final t = PupilListEntryTable();

  static const db = PupilListEntryRepository._();

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
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PupilListEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilListEntry copyWith({
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

  static PupilListEntryInclude include({
    _i2.SchoolListInclude? schoolList,
    _i3.PupilDataInclude? pupil,
  }) {
    return PupilListEntryInclude._(
      schoolList: schoolList,
      pupil: pupil,
    );
  }

  static PupilListEntryIncludeList includeList({
    _i1.WhereExpressionBuilder<PupilListEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PupilListEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilListEntryTable>? orderByList,
    PupilListEntryInclude? include,
  }) {
    return PupilListEntryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PupilListEntry.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PupilListEntry.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PupilListEntryImpl extends PupilListEntry {
  _PupilListEntryImpl({
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

  /// Returns a shallow copy of this [PupilListEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilListEntry copyWith({
    Object? id = _Undefined,
    Object? status = _Undefined,
    Object? comment = _Undefined,
    Object? entryBy = _Undefined,
    int? schoolListId,
    Object? schoolList = _Undefined,
    int? pupilId,
    Object? pupil = _Undefined,
  }) {
    return PupilListEntry(
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

class PupilListEntryTable extends _i1.Table<int?> {
  PupilListEntryTable({super.tableRelation}) : super(tableName: 'pupil_list') {
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
      field: PupilListEntry.t.schoolListId,
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
      field: PupilListEntry.t.pupilId,
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

class PupilListEntryInclude extends _i1.IncludeObject {
  PupilListEntryInclude._({
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
  _i1.Table<int?> get table => PupilListEntry.t;
}

class PupilListEntryIncludeList extends _i1.IncludeList {
  PupilListEntryIncludeList._({
    _i1.WhereExpressionBuilder<PupilListEntryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PupilListEntry.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PupilListEntry.t;
}

class PupilListEntryRepository {
  const PupilListEntryRepository._();

  final attachRow = const PupilListEntryAttachRowRepository._();

  /// Returns a list of [PupilListEntry]s matching the given query parameters.
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
  Future<List<PupilListEntry>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilListEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PupilListEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilListEntryTable>? orderByList,
    _i1.Transaction? transaction,
    PupilListEntryInclude? include,
  }) async {
    return session.db.find<PupilListEntry>(
      where: where?.call(PupilListEntry.t),
      orderBy: orderBy?.call(PupilListEntry.t),
      orderByList: orderByList?.call(PupilListEntry.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [PupilListEntry] matching the given query parameters.
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
  Future<PupilListEntry?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilListEntryTable>? where,
    int? offset,
    _i1.OrderByBuilder<PupilListEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilListEntryTable>? orderByList,
    _i1.Transaction? transaction,
    PupilListEntryInclude? include,
  }) async {
    return session.db.findFirstRow<PupilListEntry>(
      where: where?.call(PupilListEntry.t),
      orderBy: orderBy?.call(PupilListEntry.t),
      orderByList: orderByList?.call(PupilListEntry.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [PupilListEntry] by its [id] or null if no such row exists.
  Future<PupilListEntry?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    PupilListEntryInclude? include,
  }) async {
    return session.db.findById<PupilListEntry>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [PupilListEntry]s in the list and returns the inserted rows.
  ///
  /// The returned [PupilListEntry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PupilListEntry>> insert(
    _i1.Session session,
    List<PupilListEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PupilListEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PupilListEntry] and returns the inserted row.
  ///
  /// The returned [PupilListEntry] will have its `id` field set.
  Future<PupilListEntry> insertRow(
    _i1.Session session,
    PupilListEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PupilListEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PupilListEntry]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PupilListEntry>> update(
    _i1.Session session,
    List<PupilListEntry> rows, {
    _i1.ColumnSelections<PupilListEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PupilListEntry>(
      rows,
      columns: columns?.call(PupilListEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PupilListEntry]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PupilListEntry> updateRow(
    _i1.Session session,
    PupilListEntry row, {
    _i1.ColumnSelections<PupilListEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PupilListEntry>(
      row,
      columns: columns?.call(PupilListEntry.t),
      transaction: transaction,
    );
  }

  /// Deletes all [PupilListEntry]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PupilListEntry>> delete(
    _i1.Session session,
    List<PupilListEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PupilListEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PupilListEntry].
  Future<PupilListEntry> deleteRow(
    _i1.Session session,
    PupilListEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PupilListEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PupilListEntry>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PupilListEntryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PupilListEntry>(
      where: where(PupilListEntry.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilListEntryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PupilListEntry>(
      where: where?.call(PupilListEntry.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class PupilListEntryAttachRowRepository {
  const PupilListEntryAttachRowRepository._();

  /// Creates a relation between the given [PupilListEntry] and [SchoolList]
  /// by setting the [PupilListEntry]'s foreign key `schoolListId` to refer to the [SchoolList].
  Future<void> schoolList(
    _i1.Session session,
    PupilListEntry pupilListEntry,
    _i2.SchoolList schoolList, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilListEntry.id == null) {
      throw ArgumentError.notNull('pupilListEntry.id');
    }
    if (schoolList.id == null) {
      throw ArgumentError.notNull('schoolList.id');
    }

    var $pupilListEntry = pupilListEntry.copyWith(schoolListId: schoolList.id);
    await session.db.updateRow<PupilListEntry>(
      $pupilListEntry,
      columns: [PupilListEntry.t.schoolListId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [PupilListEntry] and [PupilData]
  /// by setting the [PupilListEntry]'s foreign key `pupilId` to refer to the [PupilData].
  Future<void> pupil(
    _i1.Session session,
    PupilListEntry pupilListEntry,
    _i3.PupilData pupil, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilListEntry.id == null) {
      throw ArgumentError.notNull('pupilListEntry.id');
    }
    if (pupil.id == null) {
      throw ArgumentError.notNull('pupil.id');
    }

    var $pupilListEntry = pupilListEntry.copyWith(pupilId: pupil.id);
    await session.db.updateRow<PupilListEntry>(
      $pupilListEntry,
      columns: [PupilListEntry.t.pupilId],
      transaction: transaction,
    );
  }
}

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
import '../schoolday/schoolday.dart' as _i2;
import '../pupil_data/pupil_data.dart' as _i3;

abstract class MissedClass
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  MissedClass._({
    this.id,
    required this.missedType,
    required this.unexcused,
    required this.contacted,
    required this.returned,
    this.returnedAt,
    required this.writtenExcuse,
    this.minutesLate,
    required this.createdBy,
    this.modifiedBy,
    this.comment,
    required this.schooldayId,
    this.schoolday,
    required this.pupilId,
    this.pupil,
  });

  factory MissedClass({
    int? id,
    required String missedType,
    required bool unexcused,
    required String contacted,
    required bool returned,
    DateTime? returnedAt,
    required bool writtenExcuse,
    int? minutesLate,
    required String createdBy,
    String? modifiedBy,
    String? comment,
    required int schooldayId,
    _i2.Schoolday? schoolday,
    required int pupilId,
    _i3.PupilData? pupil,
  }) = _MissedClassImpl;

  factory MissedClass.fromJson(Map<String, dynamic> jsonSerialization) {
    return MissedClass(
      id: jsonSerialization['id'] as int?,
      missedType: jsonSerialization['missedType'] as String,
      unexcused: jsonSerialization['unexcused'] as bool,
      contacted: jsonSerialization['contacted'] as String,
      returned: jsonSerialization['returned'] as bool,
      returnedAt: jsonSerialization['returnedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['returnedAt']),
      writtenExcuse: jsonSerialization['writtenExcuse'] as bool,
      minutesLate: jsonSerialization['minutesLate'] as int?,
      createdBy: jsonSerialization['createdBy'] as String,
      modifiedBy: jsonSerialization['modifiedBy'] as String?,
      comment: jsonSerialization['comment'] as String?,
      schooldayId: jsonSerialization['schooldayId'] as int,
      schoolday: jsonSerialization['schoolday'] == null
          ? null
          : _i2.Schoolday.fromJson(
              (jsonSerialization['schoolday'] as Map<String, dynamic>)),
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i3.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
    );
  }

  static final t = MissedClassTable();

  static const db = MissedClassRepository._();

  @override
  int? id;

  String missedType;

  bool unexcused;

  String contacted;

  bool returned;

  DateTime? returnedAt;

  bool writtenExcuse;

  int? minutesLate;

  String createdBy;

  String? modifiedBy;

  String? comment;

  int schooldayId;

  _i2.Schoolday? schoolday;

  int pupilId;

  _i3.PupilData? pupil;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [MissedClass]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MissedClass copyWith({
    int? id,
    String? missedType,
    bool? unexcused,
    String? contacted,
    bool? returned,
    DateTime? returnedAt,
    bool? writtenExcuse,
    int? minutesLate,
    String? createdBy,
    String? modifiedBy,
    String? comment,
    int? schooldayId,
    _i2.Schoolday? schoolday,
    int? pupilId,
    _i3.PupilData? pupil,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'missedType': missedType,
      'unexcused': unexcused,
      'contacted': contacted,
      'returned': returned,
      if (returnedAt != null) 'returnedAt': returnedAt?.toJson(),
      'writtenExcuse': writtenExcuse,
      if (minutesLate != null) 'minutesLate': minutesLate,
      'createdBy': createdBy,
      if (modifiedBy != null) 'modifiedBy': modifiedBy,
      if (comment != null) 'comment': comment,
      'schooldayId': schooldayId,
      if (schoolday != null) 'schoolday': schoolday?.toJson(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'missedType': missedType,
      'unexcused': unexcused,
      'contacted': contacted,
      'returned': returned,
      if (returnedAt != null) 'returnedAt': returnedAt?.toJson(),
      'writtenExcuse': writtenExcuse,
      if (minutesLate != null) 'minutesLate': minutesLate,
      'createdBy': createdBy,
      if (modifiedBy != null) 'modifiedBy': modifiedBy,
      if (comment != null) 'comment': comment,
      'schooldayId': schooldayId,
      if (schoolday != null) 'schoolday': schoolday?.toJsonForProtocol(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJsonForProtocol(),
    };
  }

  static MissedClassInclude include({
    _i2.SchooldayInclude? schoolday,
    _i3.PupilDataInclude? pupil,
  }) {
    return MissedClassInclude._(
      schoolday: schoolday,
      pupil: pupil,
    );
  }

  static MissedClassIncludeList includeList({
    _i1.WhereExpressionBuilder<MissedClassTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MissedClassTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MissedClassTable>? orderByList,
    MissedClassInclude? include,
  }) {
    return MissedClassIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MissedClass.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MissedClass.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MissedClassImpl extends MissedClass {
  _MissedClassImpl({
    int? id,
    required String missedType,
    required bool unexcused,
    required String contacted,
    required bool returned,
    DateTime? returnedAt,
    required bool writtenExcuse,
    int? minutesLate,
    required String createdBy,
    String? modifiedBy,
    String? comment,
    required int schooldayId,
    _i2.Schoolday? schoolday,
    required int pupilId,
    _i3.PupilData? pupil,
  }) : super._(
          id: id,
          missedType: missedType,
          unexcused: unexcused,
          contacted: contacted,
          returned: returned,
          returnedAt: returnedAt,
          writtenExcuse: writtenExcuse,
          minutesLate: minutesLate,
          createdBy: createdBy,
          modifiedBy: modifiedBy,
          comment: comment,
          schooldayId: schooldayId,
          schoolday: schoolday,
          pupilId: pupilId,
          pupil: pupil,
        );

  /// Returns a shallow copy of this [MissedClass]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MissedClass copyWith({
    Object? id = _Undefined,
    String? missedType,
    bool? unexcused,
    String? contacted,
    bool? returned,
    Object? returnedAt = _Undefined,
    bool? writtenExcuse,
    Object? minutesLate = _Undefined,
    String? createdBy,
    Object? modifiedBy = _Undefined,
    Object? comment = _Undefined,
    int? schooldayId,
    Object? schoolday = _Undefined,
    int? pupilId,
    Object? pupil = _Undefined,
  }) {
    return MissedClass(
      id: id is int? ? id : this.id,
      missedType: missedType ?? this.missedType,
      unexcused: unexcused ?? this.unexcused,
      contacted: contacted ?? this.contacted,
      returned: returned ?? this.returned,
      returnedAt: returnedAt is DateTime? ? returnedAt : this.returnedAt,
      writtenExcuse: writtenExcuse ?? this.writtenExcuse,
      minutesLate: minutesLate is int? ? minutesLate : this.minutesLate,
      createdBy: createdBy ?? this.createdBy,
      modifiedBy: modifiedBy is String? ? modifiedBy : this.modifiedBy,
      comment: comment is String? ? comment : this.comment,
      schooldayId: schooldayId ?? this.schooldayId,
      schoolday:
          schoolday is _i2.Schoolday? ? schoolday : this.schoolday?.copyWith(),
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i3.PupilData? ? pupil : this.pupil?.copyWith(),
    );
  }
}

class MissedClassTable extends _i1.Table<int> {
  MissedClassTable({super.tableRelation}) : super(tableName: 'missed_class') {
    missedType = _i1.ColumnString(
      'missedType',
      this,
    );
    unexcused = _i1.ColumnBool(
      'unexcused',
      this,
    );
    contacted = _i1.ColumnString(
      'contacted',
      this,
    );
    returned = _i1.ColumnBool(
      'returned',
      this,
    );
    returnedAt = _i1.ColumnDateTime(
      'returnedAt',
      this,
    );
    writtenExcuse = _i1.ColumnBool(
      'writtenExcuse',
      this,
    );
    minutesLate = _i1.ColumnInt(
      'minutesLate',
      this,
    );
    createdBy = _i1.ColumnString(
      'createdBy',
      this,
    );
    modifiedBy = _i1.ColumnString(
      'modifiedBy',
      this,
    );
    comment = _i1.ColumnString(
      'comment',
      this,
    );
    schooldayId = _i1.ColumnInt(
      'schooldayId',
      this,
    );
    pupilId = _i1.ColumnInt(
      'pupilId',
      this,
    );
  }

  late final _i1.ColumnString missedType;

  late final _i1.ColumnBool unexcused;

  late final _i1.ColumnString contacted;

  late final _i1.ColumnBool returned;

  late final _i1.ColumnDateTime returnedAt;

  late final _i1.ColumnBool writtenExcuse;

  late final _i1.ColumnInt minutesLate;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnString modifiedBy;

  late final _i1.ColumnString comment;

  late final _i1.ColumnInt schooldayId;

  _i2.SchooldayTable? _schoolday;

  late final _i1.ColumnInt pupilId;

  _i3.PupilDataTable? _pupil;

  _i2.SchooldayTable get schoolday {
    if (_schoolday != null) return _schoolday!;
    _schoolday = _i1.createRelationTable(
      relationFieldName: 'schoolday',
      field: MissedClass.t.schooldayId,
      foreignField: _i2.Schoolday.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SchooldayTable(tableRelation: foreignTableRelation),
    );
    return _schoolday!;
  }

  _i3.PupilDataTable get pupil {
    if (_pupil != null) return _pupil!;
    _pupil = _i1.createRelationTable(
      relationFieldName: 'pupil',
      field: MissedClass.t.pupilId,
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
        missedType,
        unexcused,
        contacted,
        returned,
        returnedAt,
        writtenExcuse,
        minutesLate,
        createdBy,
        modifiedBy,
        comment,
        schooldayId,
        pupilId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'schoolday') {
      return schoolday;
    }
    if (relationField == 'pupil') {
      return pupil;
    }
    return null;
  }
}

class MissedClassInclude extends _i1.IncludeObject {
  MissedClassInclude._({
    _i2.SchooldayInclude? schoolday,
    _i3.PupilDataInclude? pupil,
  }) {
    _schoolday = schoolday;
    _pupil = pupil;
  }

  _i2.SchooldayInclude? _schoolday;

  _i3.PupilDataInclude? _pupil;

  @override
  Map<String, _i1.Include?> get includes => {
        'schoolday': _schoolday,
        'pupil': _pupil,
      };

  @override
  _i1.Table<int> get table => MissedClass.t;
}

class MissedClassIncludeList extends _i1.IncludeList {
  MissedClassIncludeList._({
    _i1.WhereExpressionBuilder<MissedClassTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MissedClass.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => MissedClass.t;
}

class MissedClassRepository {
  const MissedClassRepository._();

  final attachRow = const MissedClassAttachRowRepository._();

  /// Returns a list of [MissedClass]s matching the given query parameters.
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
  Future<List<MissedClass>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MissedClassTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MissedClassTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MissedClassTable>? orderByList,
    _i1.Transaction? transaction,
    MissedClassInclude? include,
  }) async {
    return session.db.find<MissedClass>(
      where: where?.call(MissedClass.t),
      orderBy: orderBy?.call(MissedClass.t),
      orderByList: orderByList?.call(MissedClass.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [MissedClass] matching the given query parameters.
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
  Future<MissedClass?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MissedClassTable>? where,
    int? offset,
    _i1.OrderByBuilder<MissedClassTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MissedClassTable>? orderByList,
    _i1.Transaction? transaction,
    MissedClassInclude? include,
  }) async {
    return session.db.findFirstRow<MissedClass>(
      where: where?.call(MissedClass.t),
      orderBy: orderBy?.call(MissedClass.t),
      orderByList: orderByList?.call(MissedClass.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [MissedClass] by its [id] or null if no such row exists.
  Future<MissedClass?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    MissedClassInclude? include,
  }) async {
    return session.db.findById<MissedClass>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [MissedClass]s in the list and returns the inserted rows.
  ///
  /// The returned [MissedClass]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<MissedClass>> insert(
    _i1.Session session,
    List<MissedClass> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<MissedClass>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [MissedClass] and returns the inserted row.
  ///
  /// The returned [MissedClass] will have its `id` field set.
  Future<MissedClass> insertRow(
    _i1.Session session,
    MissedClass row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MissedClass>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MissedClass]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MissedClass>> update(
    _i1.Session session,
    List<MissedClass> rows, {
    _i1.ColumnSelections<MissedClassTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MissedClass>(
      rows,
      columns: columns?.call(MissedClass.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MissedClass]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MissedClass> updateRow(
    _i1.Session session,
    MissedClass row, {
    _i1.ColumnSelections<MissedClassTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MissedClass>(
      row,
      columns: columns?.call(MissedClass.t),
      transaction: transaction,
    );
  }

  /// Deletes all [MissedClass]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MissedClass>> delete(
    _i1.Session session,
    List<MissedClass> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MissedClass>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MissedClass].
  Future<MissedClass> deleteRow(
    _i1.Session session,
    MissedClass row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MissedClass>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MissedClass>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MissedClassTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MissedClass>(
      where: where(MissedClass.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MissedClassTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MissedClass>(
      where: where?.call(MissedClass.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class MissedClassAttachRowRepository {
  const MissedClassAttachRowRepository._();

  /// Creates a relation between the given [MissedClass] and [Schoolday]
  /// by setting the [MissedClass]'s foreign key `schooldayId` to refer to the [Schoolday].
  Future<void> schoolday(
    _i1.Session session,
    MissedClass missedClass,
    _i2.Schoolday schoolday, {
    _i1.Transaction? transaction,
  }) async {
    if (missedClass.id == null) {
      throw ArgumentError.notNull('missedClass.id');
    }
    if (schoolday.id == null) {
      throw ArgumentError.notNull('schoolday.id');
    }

    var $missedClass = missedClass.copyWith(schooldayId: schoolday.id);
    await session.db.updateRow<MissedClass>(
      $missedClass,
      columns: [MissedClass.t.schooldayId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [MissedClass] and [PupilData]
  /// by setting the [MissedClass]'s foreign key `pupilId` to refer to the [PupilData].
  Future<void> pupil(
    _i1.Session session,
    MissedClass missedClass,
    _i3.PupilData pupil, {
    _i1.Transaction? transaction,
  }) async {
    if (missedClass.id == null) {
      throw ArgumentError.notNull('missedClass.id');
    }
    if (pupil.id == null) {
      throw ArgumentError.notNull('pupil.id');
    }

    var $missedClass = missedClass.copyWith(pupilId: pupil.id);
    await session.db.updateRow<MissedClass>(
      $missedClass,
      columns: [MissedClass.t.pupilId],
      transaction: transaction,
    );
  }
}

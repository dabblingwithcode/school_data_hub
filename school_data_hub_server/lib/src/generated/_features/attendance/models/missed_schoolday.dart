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
import '../../../_features/attendance/models/missed_type.dart' as _i2;
import '../../../_features/attendance/models/contacted_type.dart' as _i3;
import '../../../_features/schoolday/models/schoolday.dart' as _i4;
import '../../../_features/pupil/models/pupil_data/pupil_data.dart' as _i5;

abstract class MissedSchoolday
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  MissedSchoolday._({
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

  factory MissedSchoolday({
    int? id,
    required _i2.MissedType missedType,
    required bool unexcused,
    required _i3.ContactedType contacted,
    required bool returned,
    DateTime? returnedAt,
    required bool writtenExcuse,
    int? minutesLate,
    required String createdBy,
    String? modifiedBy,
    String? comment,
    required int schooldayId,
    _i4.Schoolday? schoolday,
    required int pupilId,
    _i5.PupilData? pupil,
  }) = _MissedSchooldayImpl;

  factory MissedSchoolday.fromJson(Map<String, dynamic> jsonSerialization) {
    return MissedSchoolday(
      id: jsonSerialization['id'] as int?,
      missedType:
          _i2.MissedType.fromJson((jsonSerialization['missedType'] as String)),
      unexcused: jsonSerialization['unexcused'] as bool,
      contacted: _i3.ContactedType.fromJson(
          (jsonSerialization['contacted'] as String)),
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
          : _i4.Schoolday.fromJson(
              (jsonSerialization['schoolday'] as Map<String, dynamic>)),
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i5.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
    );
  }

  static final t = MissedSchooldayTable();

  static const db = MissedSchooldayRepository._();

  @override
  int? id;

  _i2.MissedType missedType;

  bool unexcused;

  _i3.ContactedType contacted;

  bool returned;

  DateTime? returnedAt;

  bool writtenExcuse;

  int? minutesLate;

  String createdBy;

  String? modifiedBy;

  String? comment;

  int schooldayId;

  _i4.Schoolday? schoolday;

  int pupilId;

  _i5.PupilData? pupil;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [MissedSchoolday]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MissedSchoolday copyWith({
    int? id,
    _i2.MissedType? missedType,
    bool? unexcused,
    _i3.ContactedType? contacted,
    bool? returned,
    DateTime? returnedAt,
    bool? writtenExcuse,
    int? minutesLate,
    String? createdBy,
    String? modifiedBy,
    String? comment,
    int? schooldayId,
    _i4.Schoolday? schoolday,
    int? pupilId,
    _i5.PupilData? pupil,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'missedType': missedType.toJson(),
      'unexcused': unexcused,
      'contacted': contacted.toJson(),
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
      'missedType': missedType.toJson(),
      'unexcused': unexcused,
      'contacted': contacted.toJson(),
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

  static MissedSchooldayInclude include({
    _i4.SchooldayInclude? schoolday,
    _i5.PupilDataInclude? pupil,
  }) {
    return MissedSchooldayInclude._(
      schoolday: schoolday,
      pupil: pupil,
    );
  }

  static MissedSchooldayIncludeList includeList({
    _i1.WhereExpressionBuilder<MissedSchooldayTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MissedSchooldayTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MissedSchooldayTable>? orderByList,
    MissedSchooldayInclude? include,
  }) {
    return MissedSchooldayIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MissedSchoolday.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MissedSchoolday.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MissedSchooldayImpl extends MissedSchoolday {
  _MissedSchooldayImpl({
    int? id,
    required _i2.MissedType missedType,
    required bool unexcused,
    required _i3.ContactedType contacted,
    required bool returned,
    DateTime? returnedAt,
    required bool writtenExcuse,
    int? minutesLate,
    required String createdBy,
    String? modifiedBy,
    String? comment,
    required int schooldayId,
    _i4.Schoolday? schoolday,
    required int pupilId,
    _i5.PupilData? pupil,
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

  /// Returns a shallow copy of this [MissedSchoolday]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MissedSchoolday copyWith({
    Object? id = _Undefined,
    _i2.MissedType? missedType,
    bool? unexcused,
    _i3.ContactedType? contacted,
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
    return MissedSchoolday(
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
          schoolday is _i4.Schoolday? ? schoolday : this.schoolday?.copyWith(),
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i5.PupilData? ? pupil : this.pupil?.copyWith(),
    );
  }
}

class MissedSchooldayTable extends _i1.Table<int?> {
  MissedSchooldayTable({super.tableRelation})
      : super(tableName: 'missed_class') {
    missedType = _i1.ColumnEnum(
      'missedType',
      this,
      _i1.EnumSerialization.byName,
    );
    unexcused = _i1.ColumnBool(
      'unexcused',
      this,
    );
    contacted = _i1.ColumnEnum(
      'contacted',
      this,
      _i1.EnumSerialization.byName,
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

  late final _i1.ColumnEnum<_i2.MissedType> missedType;

  late final _i1.ColumnBool unexcused;

  late final _i1.ColumnEnum<_i3.ContactedType> contacted;

  late final _i1.ColumnBool returned;

  late final _i1.ColumnDateTime returnedAt;

  late final _i1.ColumnBool writtenExcuse;

  late final _i1.ColumnInt minutesLate;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnString modifiedBy;

  late final _i1.ColumnString comment;

  late final _i1.ColumnInt schooldayId;

  _i4.SchooldayTable? _schoolday;

  late final _i1.ColumnInt pupilId;

  _i5.PupilDataTable? _pupil;

  _i4.SchooldayTable get schoolday {
    if (_schoolday != null) return _schoolday!;
    _schoolday = _i1.createRelationTable(
      relationFieldName: 'schoolday',
      field: MissedSchoolday.t.schooldayId,
      foreignField: _i4.Schoolday.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.SchooldayTable(tableRelation: foreignTableRelation),
    );
    return _schoolday!;
  }

  _i5.PupilDataTable get pupil {
    if (_pupil != null) return _pupil!;
    _pupil = _i1.createRelationTable(
      relationFieldName: 'pupil',
      field: MissedSchoolday.t.pupilId,
      foreignField: _i5.PupilData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.PupilDataTable(tableRelation: foreignTableRelation),
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

class MissedSchooldayInclude extends _i1.IncludeObject {
  MissedSchooldayInclude._({
    _i4.SchooldayInclude? schoolday,
    _i5.PupilDataInclude? pupil,
  }) {
    _schoolday = schoolday;
    _pupil = pupil;
  }

  _i4.SchooldayInclude? _schoolday;

  _i5.PupilDataInclude? _pupil;

  @override
  Map<String, _i1.Include?> get includes => {
        'schoolday': _schoolday,
        'pupil': _pupil,
      };

  @override
  _i1.Table<int?> get table => MissedSchoolday.t;
}

class MissedSchooldayIncludeList extends _i1.IncludeList {
  MissedSchooldayIncludeList._({
    _i1.WhereExpressionBuilder<MissedSchooldayTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MissedSchoolday.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => MissedSchoolday.t;
}

class MissedSchooldayRepository {
  const MissedSchooldayRepository._();

  final attachRow = const MissedSchooldayAttachRowRepository._();

  /// Returns a list of [MissedSchoolday]s matching the given query parameters.
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
  Future<List<MissedSchoolday>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MissedSchooldayTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MissedSchooldayTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MissedSchooldayTable>? orderByList,
    _i1.Transaction? transaction,
    MissedSchooldayInclude? include,
  }) async {
    return session.db.find<MissedSchoolday>(
      where: where?.call(MissedSchoolday.t),
      orderBy: orderBy?.call(MissedSchoolday.t),
      orderByList: orderByList?.call(MissedSchoolday.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [MissedSchoolday] matching the given query parameters.
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
  Future<MissedSchoolday?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MissedSchooldayTable>? where,
    int? offset,
    _i1.OrderByBuilder<MissedSchooldayTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MissedSchooldayTable>? orderByList,
    _i1.Transaction? transaction,
    MissedSchooldayInclude? include,
  }) async {
    return session.db.findFirstRow<MissedSchoolday>(
      where: where?.call(MissedSchoolday.t),
      orderBy: orderBy?.call(MissedSchoolday.t),
      orderByList: orderByList?.call(MissedSchoolday.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [MissedSchoolday] by its [id] or null if no such row exists.
  Future<MissedSchoolday?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    MissedSchooldayInclude? include,
  }) async {
    return session.db.findById<MissedSchoolday>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [MissedSchoolday]s in the list and returns the inserted rows.
  ///
  /// The returned [MissedSchoolday]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<MissedSchoolday>> insert(
    _i1.Session session,
    List<MissedSchoolday> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<MissedSchoolday>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [MissedSchoolday] and returns the inserted row.
  ///
  /// The returned [MissedSchoolday] will have its `id` field set.
  Future<MissedSchoolday> insertRow(
    _i1.Session session,
    MissedSchoolday row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MissedSchoolday>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MissedSchoolday]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MissedSchoolday>> update(
    _i1.Session session,
    List<MissedSchoolday> rows, {
    _i1.ColumnSelections<MissedSchooldayTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MissedSchoolday>(
      rows,
      columns: columns?.call(MissedSchoolday.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MissedSchoolday]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MissedSchoolday> updateRow(
    _i1.Session session,
    MissedSchoolday row, {
    _i1.ColumnSelections<MissedSchooldayTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MissedSchoolday>(
      row,
      columns: columns?.call(MissedSchoolday.t),
      transaction: transaction,
    );
  }

  /// Deletes all [MissedSchoolday]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MissedSchoolday>> delete(
    _i1.Session session,
    List<MissedSchoolday> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MissedSchoolday>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MissedSchoolday].
  Future<MissedSchoolday> deleteRow(
    _i1.Session session,
    MissedSchoolday row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MissedSchoolday>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MissedSchoolday>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MissedSchooldayTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MissedSchoolday>(
      where: where(MissedSchoolday.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MissedSchooldayTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MissedSchoolday>(
      where: where?.call(MissedSchoolday.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class MissedSchooldayAttachRowRepository {
  const MissedSchooldayAttachRowRepository._();

  /// Creates a relation between the given [MissedSchoolday] and [Schoolday]
  /// by setting the [MissedSchoolday]'s foreign key `schooldayId` to refer to the [Schoolday].
  Future<void> schoolday(
    _i1.Session session,
    MissedSchoolday missedSchoolday,
    _i4.Schoolday schoolday, {
    _i1.Transaction? transaction,
  }) async {
    if (missedSchoolday.id == null) {
      throw ArgumentError.notNull('missedSchoolday.id');
    }
    if (schoolday.id == null) {
      throw ArgumentError.notNull('schoolday.id');
    }

    var $missedSchoolday = missedSchoolday.copyWith(schooldayId: schoolday.id);
    await session.db.updateRow<MissedSchoolday>(
      $missedSchoolday,
      columns: [MissedSchoolday.t.schooldayId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [MissedSchoolday] and [PupilData]
  /// by setting the [MissedSchoolday]'s foreign key `pupilId` to refer to the [PupilData].
  Future<void> pupil(
    _i1.Session session,
    MissedSchoolday missedSchoolday,
    _i5.PupilData pupil, {
    _i1.Transaction? transaction,
  }) async {
    if (missedSchoolday.id == null) {
      throw ArgumentError.notNull('missedSchoolday.id');
    }
    if (pupil.id == null) {
      throw ArgumentError.notNull('pupil.id');
    }

    var $missedSchoolday = missedSchoolday.copyWith(pupilId: pupil.id);
    await session.db.updateRow<MissedSchoolday>(
      $missedSchoolday,
      columns: [MissedSchoolday.t.pupilId],
      transaction: transaction,
    );
  }
}

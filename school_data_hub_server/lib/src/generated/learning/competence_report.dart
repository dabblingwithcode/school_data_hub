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
import '../pupil_data/pupil_data.dart' as _i2;
import '../learning/competence_report_check.dart' as _i3;
import '../schoolday/school_semester.dart' as _i4;

abstract class CompetenceReport
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  CompetenceReport._({
    this.id,
    required this.reportId,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedBy,
    required this.achievement,
    required this.achievedAt,
    required this.pupilId,
    this.pupil,
    this.competenceReportChecks,
    required this.schoolSemesterId,
    this.schoolSemester,
  });

  factory CompetenceReport({
    int? id,
    required String reportId,
    required String createdBy,
    required DateTime createdAt,
    required String modifiedBy,
    required String achievement,
    required DateTime achievedAt,
    required int pupilId,
    _i2.PupilData? pupil,
    List<_i3.CompetenceReportCheck>? competenceReportChecks,
    required int schoolSemesterId,
    _i4.SchoolSemester? schoolSemester,
  }) = _CompetenceReportImpl;

  factory CompetenceReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return CompetenceReport(
      id: jsonSerialization['id'] as int?,
      reportId: jsonSerialization['reportId'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      modifiedBy: jsonSerialization['modifiedBy'] as String,
      achievement: jsonSerialization['achievement'] as String,
      achievedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['achievedAt']),
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i2.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
      competenceReportChecks: (jsonSerialization['competenceReportChecks']
              as List?)
          ?.map((e) =>
              _i3.CompetenceReportCheck.fromJson((e as Map<String, dynamic>)))
          .toList(),
      schoolSemesterId: jsonSerialization['schoolSemesterId'] as int,
      schoolSemester: jsonSerialization['schoolSemester'] == null
          ? null
          : _i4.SchoolSemester.fromJson(
              (jsonSerialization['schoolSemester'] as Map<String, dynamic>)),
    );
  }

  static final t = CompetenceReportTable();

  static const db = CompetenceReportRepository._();

  @override
  int? id;

  String reportId;

  String createdBy;

  DateTime createdAt;

  String modifiedBy;

  String achievement;

  DateTime achievedAt;

  int pupilId;

  _i2.PupilData? pupil;

  List<_i3.CompetenceReportCheck>? competenceReportChecks;

  int schoolSemesterId;

  _i4.SchoolSemester? schoolSemester;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [CompetenceReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CompetenceReport copyWith({
    int? id,
    String? reportId,
    String? createdBy,
    DateTime? createdAt,
    String? modifiedBy,
    String? achievement,
    DateTime? achievedAt,
    int? pupilId,
    _i2.PupilData? pupil,
    List<_i3.CompetenceReportCheck>? competenceReportChecks,
    int? schoolSemesterId,
    _i4.SchoolSemester? schoolSemester,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'reportId': reportId,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'modifiedBy': modifiedBy,
      'achievement': achievement,
      'achievedAt': achievedAt.toJson(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
      if (competenceReportChecks != null)
        'competenceReportChecks':
            competenceReportChecks?.toJson(valueToJson: (v) => v.toJson()),
      'schoolSemesterId': schoolSemesterId,
      if (schoolSemester != null) 'schoolSemester': schoolSemester?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'reportId': reportId,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'modifiedBy': modifiedBy,
      'achievement': achievement,
      'achievedAt': achievedAt.toJson(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJsonForProtocol(),
      if (competenceReportChecks != null)
        'competenceReportChecks': competenceReportChecks?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      'schoolSemesterId': schoolSemesterId,
      if (schoolSemester != null)
        'schoolSemester': schoolSemester?.toJsonForProtocol(),
    };
  }

  static CompetenceReportInclude include({
    _i2.PupilDataInclude? pupil,
    _i3.CompetenceReportCheckIncludeList? competenceReportChecks,
    _i4.SchoolSemesterInclude? schoolSemester,
  }) {
    return CompetenceReportInclude._(
      pupil: pupil,
      competenceReportChecks: competenceReportChecks,
      schoolSemester: schoolSemester,
    );
  }

  static CompetenceReportIncludeList includeList({
    _i1.WhereExpressionBuilder<CompetenceReportTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CompetenceReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompetenceReportTable>? orderByList,
    CompetenceReportInclude? include,
  }) {
    return CompetenceReportIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CompetenceReport.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CompetenceReport.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompetenceReportImpl extends CompetenceReport {
  _CompetenceReportImpl({
    int? id,
    required String reportId,
    required String createdBy,
    required DateTime createdAt,
    required String modifiedBy,
    required String achievement,
    required DateTime achievedAt,
    required int pupilId,
    _i2.PupilData? pupil,
    List<_i3.CompetenceReportCheck>? competenceReportChecks,
    required int schoolSemesterId,
    _i4.SchoolSemester? schoolSemester,
  }) : super._(
          id: id,
          reportId: reportId,
          createdBy: createdBy,
          createdAt: createdAt,
          modifiedBy: modifiedBy,
          achievement: achievement,
          achievedAt: achievedAt,
          pupilId: pupilId,
          pupil: pupil,
          competenceReportChecks: competenceReportChecks,
          schoolSemesterId: schoolSemesterId,
          schoolSemester: schoolSemester,
        );

  /// Returns a shallow copy of this [CompetenceReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CompetenceReport copyWith({
    Object? id = _Undefined,
    String? reportId,
    String? createdBy,
    DateTime? createdAt,
    String? modifiedBy,
    String? achievement,
    DateTime? achievedAt,
    int? pupilId,
    Object? pupil = _Undefined,
    Object? competenceReportChecks = _Undefined,
    int? schoolSemesterId,
    Object? schoolSemester = _Undefined,
  }) {
    return CompetenceReport(
      id: id is int? ? id : this.id,
      reportId: reportId ?? this.reportId,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      achievement: achievement ?? this.achievement,
      achievedAt: achievedAt ?? this.achievedAt,
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i2.PupilData? ? pupil : this.pupil?.copyWith(),
      competenceReportChecks: competenceReportChecks
              is List<_i3.CompetenceReportCheck>?
          ? competenceReportChecks
          : this.competenceReportChecks?.map((e0) => e0.copyWith()).toList(),
      schoolSemesterId: schoolSemesterId ?? this.schoolSemesterId,
      schoolSemester: schoolSemester is _i4.SchoolSemester?
          ? schoolSemester
          : this.schoolSemester?.copyWith(),
    );
  }
}

class CompetenceReportTable extends _i1.Table<int> {
  CompetenceReportTable({super.tableRelation})
      : super(tableName: 'competence_report') {
    reportId = _i1.ColumnString(
      'reportId',
      this,
    );
    createdBy = _i1.ColumnString(
      'createdBy',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    modifiedBy = _i1.ColumnString(
      'modifiedBy',
      this,
    );
    achievement = _i1.ColumnString(
      'achievement',
      this,
    );
    achievedAt = _i1.ColumnDateTime(
      'achievedAt',
      this,
    );
    pupilId = _i1.ColumnInt(
      'pupilId',
      this,
    );
    schoolSemesterId = _i1.ColumnInt(
      'schoolSemesterId',
      this,
    );
  }

  late final _i1.ColumnString reportId;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnString modifiedBy;

  late final _i1.ColumnString achievement;

  late final _i1.ColumnDateTime achievedAt;

  late final _i1.ColumnInt pupilId;

  _i2.PupilDataTable? _pupil;

  _i3.CompetenceReportCheckTable? ___competenceReportChecks;

  _i1.ManyRelation<_i3.CompetenceReportCheckTable>? _competenceReportChecks;

  late final _i1.ColumnInt schoolSemesterId;

  _i4.SchoolSemesterTable? _schoolSemester;

  _i2.PupilDataTable get pupil {
    if (_pupil != null) return _pupil!;
    _pupil = _i1.createRelationTable(
      relationFieldName: 'pupil',
      field: CompetenceReport.t.pupilId,
      foreignField: _i2.PupilData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PupilDataTable(tableRelation: foreignTableRelation),
    );
    return _pupil!;
  }

  _i3.CompetenceReportCheckTable get __competenceReportChecks {
    if (___competenceReportChecks != null) return ___competenceReportChecks!;
    ___competenceReportChecks = _i1.createRelationTable(
      relationFieldName: '__competenceReportChecks',
      field: CompetenceReport.t.id,
      foreignField: _i3.CompetenceReportCheck.t.competenceReportId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CompetenceReportCheckTable(tableRelation: foreignTableRelation),
    );
    return ___competenceReportChecks!;
  }

  _i4.SchoolSemesterTable get schoolSemester {
    if (_schoolSemester != null) return _schoolSemester!;
    _schoolSemester = _i1.createRelationTable(
      relationFieldName: 'schoolSemester',
      field: CompetenceReport.t.schoolSemesterId,
      foreignField: _i4.SchoolSemester.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.SchoolSemesterTable(tableRelation: foreignTableRelation),
    );
    return _schoolSemester!;
  }

  _i1.ManyRelation<_i3.CompetenceReportCheckTable> get competenceReportChecks {
    if (_competenceReportChecks != null) return _competenceReportChecks!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'competenceReportChecks',
      field: CompetenceReport.t.id,
      foreignField: _i3.CompetenceReportCheck.t.competenceReportId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CompetenceReportCheckTable(tableRelation: foreignTableRelation),
    );
    _competenceReportChecks = _i1.ManyRelation<_i3.CompetenceReportCheckTable>(
      tableWithRelations: relationTable,
      table: _i3.CompetenceReportCheckTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _competenceReportChecks!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        reportId,
        createdBy,
        createdAt,
        modifiedBy,
        achievement,
        achievedAt,
        pupilId,
        schoolSemesterId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'pupil') {
      return pupil;
    }
    if (relationField == 'competenceReportChecks') {
      return __competenceReportChecks;
    }
    if (relationField == 'schoolSemester') {
      return schoolSemester;
    }
    return null;
  }
}

class CompetenceReportInclude extends _i1.IncludeObject {
  CompetenceReportInclude._({
    _i2.PupilDataInclude? pupil,
    _i3.CompetenceReportCheckIncludeList? competenceReportChecks,
    _i4.SchoolSemesterInclude? schoolSemester,
  }) {
    _pupil = pupil;
    _competenceReportChecks = competenceReportChecks;
    _schoolSemester = schoolSemester;
  }

  _i2.PupilDataInclude? _pupil;

  _i3.CompetenceReportCheckIncludeList? _competenceReportChecks;

  _i4.SchoolSemesterInclude? _schoolSemester;

  @override
  Map<String, _i1.Include?> get includes => {
        'pupil': _pupil,
        'competenceReportChecks': _competenceReportChecks,
        'schoolSemester': _schoolSemester,
      };

  @override
  _i1.Table<int> get table => CompetenceReport.t;
}

class CompetenceReportIncludeList extends _i1.IncludeList {
  CompetenceReportIncludeList._({
    _i1.WhereExpressionBuilder<CompetenceReportTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CompetenceReport.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => CompetenceReport.t;
}

class CompetenceReportRepository {
  const CompetenceReportRepository._();

  final attach = const CompetenceReportAttachRepository._();

  final attachRow = const CompetenceReportAttachRowRepository._();

  final detach = const CompetenceReportDetachRepository._();

  final detachRow = const CompetenceReportDetachRowRepository._();

  /// Returns a list of [CompetenceReport]s matching the given query parameters.
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
  Future<List<CompetenceReport>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompetenceReportTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CompetenceReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompetenceReportTable>? orderByList,
    _i1.Transaction? transaction,
    CompetenceReportInclude? include,
  }) async {
    return session.db.find<CompetenceReport>(
      where: where?.call(CompetenceReport.t),
      orderBy: orderBy?.call(CompetenceReport.t),
      orderByList: orderByList?.call(CompetenceReport.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [CompetenceReport] matching the given query parameters.
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
  Future<CompetenceReport?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompetenceReportTable>? where,
    int? offset,
    _i1.OrderByBuilder<CompetenceReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompetenceReportTable>? orderByList,
    _i1.Transaction? transaction,
    CompetenceReportInclude? include,
  }) async {
    return session.db.findFirstRow<CompetenceReport>(
      where: where?.call(CompetenceReport.t),
      orderBy: orderBy?.call(CompetenceReport.t),
      orderByList: orderByList?.call(CompetenceReport.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [CompetenceReport] by its [id] or null if no such row exists.
  Future<CompetenceReport?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CompetenceReportInclude? include,
  }) async {
    return session.db.findById<CompetenceReport>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [CompetenceReport]s in the list and returns the inserted rows.
  ///
  /// The returned [CompetenceReport]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CompetenceReport>> insert(
    _i1.Session session,
    List<CompetenceReport> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CompetenceReport>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CompetenceReport] and returns the inserted row.
  ///
  /// The returned [CompetenceReport] will have its `id` field set.
  Future<CompetenceReport> insertRow(
    _i1.Session session,
    CompetenceReport row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CompetenceReport>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CompetenceReport]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CompetenceReport>> update(
    _i1.Session session,
    List<CompetenceReport> rows, {
    _i1.ColumnSelections<CompetenceReportTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CompetenceReport>(
      rows,
      columns: columns?.call(CompetenceReport.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CompetenceReport]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CompetenceReport> updateRow(
    _i1.Session session,
    CompetenceReport row, {
    _i1.ColumnSelections<CompetenceReportTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CompetenceReport>(
      row,
      columns: columns?.call(CompetenceReport.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CompetenceReport]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CompetenceReport>> delete(
    _i1.Session session,
    List<CompetenceReport> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CompetenceReport>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CompetenceReport].
  Future<CompetenceReport> deleteRow(
    _i1.Session session,
    CompetenceReport row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CompetenceReport>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CompetenceReport>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CompetenceReportTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CompetenceReport>(
      where: where(CompetenceReport.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompetenceReportTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CompetenceReport>(
      where: where?.call(CompetenceReport.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class CompetenceReportAttachRepository {
  const CompetenceReportAttachRepository._();

  /// Creates a relation between this [CompetenceReport] and the given [CompetenceReportCheck]s
  /// by setting each [CompetenceReportCheck]'s foreign key `competenceReportId` to refer to this [CompetenceReport].
  Future<void> competenceReportChecks(
    _i1.Session session,
    CompetenceReport competenceReport,
    List<_i3.CompetenceReportCheck> competenceReportCheck, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceReportCheck.any((e) => e.id == null)) {
      throw ArgumentError.notNull('competenceReportCheck.id');
    }
    if (competenceReport.id == null) {
      throw ArgumentError.notNull('competenceReport.id');
    }

    var $competenceReportCheck = competenceReportCheck
        .map((e) => e.copyWith(competenceReportId: competenceReport.id))
        .toList();
    await session.db.update<_i3.CompetenceReportCheck>(
      $competenceReportCheck,
      columns: [_i3.CompetenceReportCheck.t.competenceReportId],
      transaction: transaction,
    );
  }
}

class CompetenceReportAttachRowRepository {
  const CompetenceReportAttachRowRepository._();

  /// Creates a relation between the given [CompetenceReport] and [PupilData]
  /// by setting the [CompetenceReport]'s foreign key `pupilId` to refer to the [PupilData].
  Future<void> pupil(
    _i1.Session session,
    CompetenceReport competenceReport,
    _i2.PupilData pupil, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceReport.id == null) {
      throw ArgumentError.notNull('competenceReport.id');
    }
    if (pupil.id == null) {
      throw ArgumentError.notNull('pupil.id');
    }

    var $competenceReport = competenceReport.copyWith(pupilId: pupil.id);
    await session.db.updateRow<CompetenceReport>(
      $competenceReport,
      columns: [CompetenceReport.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CompetenceReport] and [SchoolSemester]
  /// by setting the [CompetenceReport]'s foreign key `schoolSemesterId` to refer to the [SchoolSemester].
  Future<void> schoolSemester(
    _i1.Session session,
    CompetenceReport competenceReport,
    _i4.SchoolSemester schoolSemester, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceReport.id == null) {
      throw ArgumentError.notNull('competenceReport.id');
    }
    if (schoolSemester.id == null) {
      throw ArgumentError.notNull('schoolSemester.id');
    }

    var $competenceReport =
        competenceReport.copyWith(schoolSemesterId: schoolSemester.id);
    await session.db.updateRow<CompetenceReport>(
      $competenceReport,
      columns: [CompetenceReport.t.schoolSemesterId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [CompetenceReport] and the given [CompetenceReportCheck]
  /// by setting the [CompetenceReportCheck]'s foreign key `competenceReportId` to refer to this [CompetenceReport].
  Future<void> competenceReportChecks(
    _i1.Session session,
    CompetenceReport competenceReport,
    _i3.CompetenceReportCheck competenceReportCheck, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceReportCheck.id == null) {
      throw ArgumentError.notNull('competenceReportCheck.id');
    }
    if (competenceReport.id == null) {
      throw ArgumentError.notNull('competenceReport.id');
    }

    var $competenceReportCheck =
        competenceReportCheck.copyWith(competenceReportId: competenceReport.id);
    await session.db.updateRow<_i3.CompetenceReportCheck>(
      $competenceReportCheck,
      columns: [_i3.CompetenceReportCheck.t.competenceReportId],
      transaction: transaction,
    );
  }
}

class CompetenceReportDetachRepository {
  const CompetenceReportDetachRepository._();

  /// Detaches the relation between this [CompetenceReport] and the given [CompetenceReportCheck]
  /// by setting the [CompetenceReportCheck]'s foreign key `competenceReportId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> competenceReportChecks(
    _i1.Session session,
    List<_i3.CompetenceReportCheck> competenceReportCheck, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceReportCheck.any((e) => e.id == null)) {
      throw ArgumentError.notNull('competenceReportCheck.id');
    }

    var $competenceReportCheck = competenceReportCheck
        .map((e) => e.copyWith(competenceReportId: null))
        .toList();
    await session.db.update<_i3.CompetenceReportCheck>(
      $competenceReportCheck,
      columns: [_i3.CompetenceReportCheck.t.competenceReportId],
      transaction: transaction,
    );
  }
}

class CompetenceReportDetachRowRepository {
  const CompetenceReportDetachRowRepository._();

  /// Detaches the relation between this [CompetenceReport] and the given [CompetenceReportCheck]
  /// by setting the [CompetenceReportCheck]'s foreign key `competenceReportId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> competenceReportChecks(
    _i1.Session session,
    _i3.CompetenceReportCheck competenceReportCheck, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceReportCheck.id == null) {
      throw ArgumentError.notNull('competenceReportCheck.id');
    }

    var $competenceReportCheck =
        competenceReportCheck.copyWith(competenceReportId: null);
    await session.db.updateRow<_i3.CompetenceReportCheck>(
      $competenceReportCheck,
      columns: [_i3.CompetenceReportCheck.t.competenceReportId],
      transaction: transaction,
    );
  }
}

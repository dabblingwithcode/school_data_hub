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
import '../learning/competence_report.dart' as _i3;

abstract class SchoolSemester
    implements _i1.TableRow, _i1.ProtocolSerialization {
  SchoolSemester._({
    this.id,
    required this.startDate,
    required this.endDate,
    required this.classConferenceDate,
    required this.supportConferenceDate,
    required this.isFirst,
    required this.reportConferenceDate,
    this.schooldays,
    this.competenceReports,
  });

  factory SchoolSemester({
    int? id,
    required DateTime startDate,
    required DateTime endDate,
    required DateTime classConferenceDate,
    required DateTime supportConferenceDate,
    required bool isFirst,
    required DateTime reportConferenceDate,
    List<_i2.Schoolday>? schooldays,
    List<_i3.CompetenceReport>? competenceReports,
  }) = _SchoolSemesterImpl;

  factory SchoolSemester.fromJson(Map<String, dynamic> jsonSerialization) {
    return SchoolSemester(
      id: jsonSerialization['id'] as int?,
      startDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startDate']),
      endDate: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      classConferenceDate: _i1.DateTimeJsonExtension.fromJson(
          jsonSerialization['classConferenceDate']),
      supportConferenceDate: _i1.DateTimeJsonExtension.fromJson(
          jsonSerialization['supportConferenceDate']),
      isFirst: jsonSerialization['isFirst'] as bool,
      reportConferenceDate: _i1.DateTimeJsonExtension.fromJson(
          jsonSerialization['reportConferenceDate']),
      schooldays: (jsonSerialization['schooldays'] as List?)
          ?.map((e) => _i2.Schoolday.fromJson((e as Map<String, dynamic>)))
          .toList(),
      competenceReports: (jsonSerialization['competenceReports'] as List?)
          ?.map(
              (e) => _i3.CompetenceReport.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = SchoolSemesterTable();

  static const db = SchoolSemesterRepository._();

  @override
  int? id;

  DateTime startDate;

  DateTime endDate;

  DateTime classConferenceDate;

  DateTime supportConferenceDate;

  bool isFirst;

  DateTime reportConferenceDate;

  List<_i2.Schoolday>? schooldays;

  List<_i3.CompetenceReport>? competenceReports;

  @override
  _i1.Table get table => t;

  /// Returns a shallow copy of this [SchoolSemester]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SchoolSemester copyWith({
    int? id,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? classConferenceDate,
    DateTime? supportConferenceDate,
    bool? isFirst,
    DateTime? reportConferenceDate,
    List<_i2.Schoolday>? schooldays,
    List<_i3.CompetenceReport>? competenceReports,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'startDate': startDate.toJson(),
      'endDate': endDate.toJson(),
      'classConferenceDate': classConferenceDate.toJson(),
      'supportConferenceDate': supportConferenceDate.toJson(),
      'isFirst': isFirst,
      'reportConferenceDate': reportConferenceDate.toJson(),
      if (schooldays != null)
        'schooldays': schooldays?.toJson(valueToJson: (v) => v.toJson()),
      if (competenceReports != null)
        'competenceReports':
            competenceReports?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'startDate': startDate.toJson(),
      'endDate': endDate.toJson(),
      'classConferenceDate': classConferenceDate.toJson(),
      'supportConferenceDate': supportConferenceDate.toJson(),
      'isFirst': isFirst,
      'reportConferenceDate': reportConferenceDate.toJson(),
      if (schooldays != null)
        'schooldays':
            schooldays?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (competenceReports != null)
        'competenceReports': competenceReports?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static SchoolSemesterInclude include({
    _i2.SchooldayIncludeList? schooldays,
    _i3.CompetenceReportIncludeList? competenceReports,
  }) {
    return SchoolSemesterInclude._(
      schooldays: schooldays,
      competenceReports: competenceReports,
    );
  }

  static SchoolSemesterIncludeList includeList({
    _i1.WhereExpressionBuilder<SchoolSemesterTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SchoolSemesterTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SchoolSemesterTable>? orderByList,
    SchoolSemesterInclude? include,
  }) {
    return SchoolSemesterIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SchoolSemester.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SchoolSemester.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SchoolSemesterImpl extends SchoolSemester {
  _SchoolSemesterImpl({
    int? id,
    required DateTime startDate,
    required DateTime endDate,
    required DateTime classConferenceDate,
    required DateTime supportConferenceDate,
    required bool isFirst,
    required DateTime reportConferenceDate,
    List<_i2.Schoolday>? schooldays,
    List<_i3.CompetenceReport>? competenceReports,
  }) : super._(
          id: id,
          startDate: startDate,
          endDate: endDate,
          classConferenceDate: classConferenceDate,
          supportConferenceDate: supportConferenceDate,
          isFirst: isFirst,
          reportConferenceDate: reportConferenceDate,
          schooldays: schooldays,
          competenceReports: competenceReports,
        );

  /// Returns a shallow copy of this [SchoolSemester]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SchoolSemester copyWith({
    Object? id = _Undefined,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? classConferenceDate,
    DateTime? supportConferenceDate,
    bool? isFirst,
    DateTime? reportConferenceDate,
    Object? schooldays = _Undefined,
    Object? competenceReports = _Undefined,
  }) {
    return SchoolSemester(
      id: id is int? ? id : this.id,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      classConferenceDate: classConferenceDate ?? this.classConferenceDate,
      supportConferenceDate:
          supportConferenceDate ?? this.supportConferenceDate,
      isFirst: isFirst ?? this.isFirst,
      reportConferenceDate: reportConferenceDate ?? this.reportConferenceDate,
      schooldays: schooldays is List<_i2.Schoolday>?
          ? schooldays
          : this.schooldays?.map((e0) => e0.copyWith()).toList(),
      competenceReports: competenceReports is List<_i3.CompetenceReport>?
          ? competenceReports
          : this.competenceReports?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class SchoolSemesterTable extends _i1.Table {
  SchoolSemesterTable({super.tableRelation})
      : super(tableName: 'school_semester') {
    startDate = _i1.ColumnDateTime(
      'startDate',
      this,
    );
    endDate = _i1.ColumnDateTime(
      'endDate',
      this,
    );
    classConferenceDate = _i1.ColumnDateTime(
      'classConferenceDate',
      this,
    );
    supportConferenceDate = _i1.ColumnDateTime(
      'supportConferenceDate',
      this,
    );
    isFirst = _i1.ColumnBool(
      'isFirst',
      this,
    );
    reportConferenceDate = _i1.ColumnDateTime(
      'reportConferenceDate',
      this,
    );
  }

  late final _i1.ColumnDateTime startDate;

  late final _i1.ColumnDateTime endDate;

  late final _i1.ColumnDateTime classConferenceDate;

  late final _i1.ColumnDateTime supportConferenceDate;

  late final _i1.ColumnBool isFirst;

  late final _i1.ColumnDateTime reportConferenceDate;

  _i2.SchooldayTable? ___schooldays;

  _i1.ManyRelation<_i2.SchooldayTable>? _schooldays;

  _i3.CompetenceReportTable? ___competenceReports;

  _i1.ManyRelation<_i3.CompetenceReportTable>? _competenceReports;

  _i2.SchooldayTable get __schooldays {
    if (___schooldays != null) return ___schooldays!;
    ___schooldays = _i1.createRelationTable(
      relationFieldName: '__schooldays',
      field: SchoolSemester.t.id,
      foreignField: _i2.Schoolday.t.schoolSemesterId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SchooldayTable(tableRelation: foreignTableRelation),
    );
    return ___schooldays!;
  }

  _i3.CompetenceReportTable get __competenceReports {
    if (___competenceReports != null) return ___competenceReports!;
    ___competenceReports = _i1.createRelationTable(
      relationFieldName: '__competenceReports',
      field: SchoolSemester.t.id,
      foreignField: _i3.CompetenceReport.t.schoolSemesterId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CompetenceReportTable(tableRelation: foreignTableRelation),
    );
    return ___competenceReports!;
  }

  _i1.ManyRelation<_i2.SchooldayTable> get schooldays {
    if (_schooldays != null) return _schooldays!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'schooldays',
      field: SchoolSemester.t.id,
      foreignField: _i2.Schoolday.t.schoolSemesterId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SchooldayTable(tableRelation: foreignTableRelation),
    );
    _schooldays = _i1.ManyRelation<_i2.SchooldayTable>(
      tableWithRelations: relationTable,
      table: _i2.SchooldayTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _schooldays!;
  }

  _i1.ManyRelation<_i3.CompetenceReportTable> get competenceReports {
    if (_competenceReports != null) return _competenceReports!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'competenceReports',
      field: SchoolSemester.t.id,
      foreignField: _i3.CompetenceReport.t.schoolSemesterId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CompetenceReportTable(tableRelation: foreignTableRelation),
    );
    _competenceReports = _i1.ManyRelation<_i3.CompetenceReportTable>(
      tableWithRelations: relationTable,
      table: _i3.CompetenceReportTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _competenceReports!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        startDate,
        endDate,
        classConferenceDate,
        supportConferenceDate,
        isFirst,
        reportConferenceDate,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'schooldays') {
      return __schooldays;
    }
    if (relationField == 'competenceReports') {
      return __competenceReports;
    }
    return null;
  }
}

class SchoolSemesterInclude extends _i1.IncludeObject {
  SchoolSemesterInclude._({
    _i2.SchooldayIncludeList? schooldays,
    _i3.CompetenceReportIncludeList? competenceReports,
  }) {
    _schooldays = schooldays;
    _competenceReports = competenceReports;
  }

  _i2.SchooldayIncludeList? _schooldays;

  _i3.CompetenceReportIncludeList? _competenceReports;

  @override
  Map<String, _i1.Include?> get includes => {
        'schooldays': _schooldays,
        'competenceReports': _competenceReports,
      };

  @override
  _i1.Table get table => SchoolSemester.t;
}

class SchoolSemesterIncludeList extends _i1.IncludeList {
  SchoolSemesterIncludeList._({
    _i1.WhereExpressionBuilder<SchoolSemesterTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SchoolSemester.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => SchoolSemester.t;
}

class SchoolSemesterRepository {
  const SchoolSemesterRepository._();

  final attach = const SchoolSemesterAttachRepository._();

  final attachRow = const SchoolSemesterAttachRowRepository._();

  final detach = const SchoolSemesterDetachRepository._();

  final detachRow = const SchoolSemesterDetachRowRepository._();

  /// Returns a list of [SchoolSemester]s matching the given query parameters.
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
  Future<List<SchoolSemester>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SchoolSemesterTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SchoolSemesterTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SchoolSemesterTable>? orderByList,
    _i1.Transaction? transaction,
    SchoolSemesterInclude? include,
  }) async {
    return session.db.find<SchoolSemester>(
      where: where?.call(SchoolSemester.t),
      orderBy: orderBy?.call(SchoolSemester.t),
      orderByList: orderByList?.call(SchoolSemester.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [SchoolSemester] matching the given query parameters.
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
  Future<SchoolSemester?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SchoolSemesterTable>? where,
    int? offset,
    _i1.OrderByBuilder<SchoolSemesterTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SchoolSemesterTable>? orderByList,
    _i1.Transaction? transaction,
    SchoolSemesterInclude? include,
  }) async {
    return session.db.findFirstRow<SchoolSemester>(
      where: where?.call(SchoolSemester.t),
      orderBy: orderBy?.call(SchoolSemester.t),
      orderByList: orderByList?.call(SchoolSemester.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [SchoolSemester] by its [id] or null if no such row exists.
  Future<SchoolSemester?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    SchoolSemesterInclude? include,
  }) async {
    return session.db.findById<SchoolSemester>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [SchoolSemester]s in the list and returns the inserted rows.
  ///
  /// The returned [SchoolSemester]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SchoolSemester>> insert(
    _i1.Session session,
    List<SchoolSemester> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SchoolSemester>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SchoolSemester] and returns the inserted row.
  ///
  /// The returned [SchoolSemester] will have its `id` field set.
  Future<SchoolSemester> insertRow(
    _i1.Session session,
    SchoolSemester row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SchoolSemester>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SchoolSemester]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SchoolSemester>> update(
    _i1.Session session,
    List<SchoolSemester> rows, {
    _i1.ColumnSelections<SchoolSemesterTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SchoolSemester>(
      rows,
      columns: columns?.call(SchoolSemester.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SchoolSemester]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SchoolSemester> updateRow(
    _i1.Session session,
    SchoolSemester row, {
    _i1.ColumnSelections<SchoolSemesterTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SchoolSemester>(
      row,
      columns: columns?.call(SchoolSemester.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SchoolSemester]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SchoolSemester>> delete(
    _i1.Session session,
    List<SchoolSemester> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SchoolSemester>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SchoolSemester].
  Future<SchoolSemester> deleteRow(
    _i1.Session session,
    SchoolSemester row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SchoolSemester>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SchoolSemester>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SchoolSemesterTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SchoolSemester>(
      where: where(SchoolSemester.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SchoolSemesterTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SchoolSemester>(
      where: where?.call(SchoolSemester.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class SchoolSemesterAttachRepository {
  const SchoolSemesterAttachRepository._();

  /// Creates a relation between this [SchoolSemester] and the given [Schoolday]s
  /// by setting each [Schoolday]'s foreign key `schoolSemesterId` to refer to this [SchoolSemester].
  Future<void> schooldays(
    _i1.Session session,
    SchoolSemester schoolSemester,
    List<_i2.Schoolday> schoolday, {
    _i1.Transaction? transaction,
  }) async {
    if (schoolday.any((e) => e.id == null)) {
      throw ArgumentError.notNull('schoolday.id');
    }
    if (schoolSemester.id == null) {
      throw ArgumentError.notNull('schoolSemester.id');
    }

    var $schoolday = schoolday
        .map((e) => e.copyWith(schoolSemesterId: schoolSemester.id))
        .toList();
    await session.db.update<_i2.Schoolday>(
      $schoolday,
      columns: [_i2.Schoolday.t.schoolSemesterId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [SchoolSemester] and the given [CompetenceReport]s
  /// by setting each [CompetenceReport]'s foreign key `schoolSemesterId` to refer to this [SchoolSemester].
  Future<void> competenceReports(
    _i1.Session session,
    SchoolSemester schoolSemester,
    List<_i3.CompetenceReport> competenceReport, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceReport.any((e) => e.id == null)) {
      throw ArgumentError.notNull('competenceReport.id');
    }
    if (schoolSemester.id == null) {
      throw ArgumentError.notNull('schoolSemester.id');
    }

    var $competenceReport = competenceReport
        .map((e) => e.copyWith(schoolSemesterId: schoolSemester.id))
        .toList();
    await session.db.update<_i3.CompetenceReport>(
      $competenceReport,
      columns: [_i3.CompetenceReport.t.schoolSemesterId],
      transaction: transaction,
    );
  }
}

class SchoolSemesterAttachRowRepository {
  const SchoolSemesterAttachRowRepository._();

  /// Creates a relation between this [SchoolSemester] and the given [Schoolday]
  /// by setting the [Schoolday]'s foreign key `schoolSemesterId` to refer to this [SchoolSemester].
  Future<void> schooldays(
    _i1.Session session,
    SchoolSemester schoolSemester,
    _i2.Schoolday schoolday, {
    _i1.Transaction? transaction,
  }) async {
    if (schoolday.id == null) {
      throw ArgumentError.notNull('schoolday.id');
    }
    if (schoolSemester.id == null) {
      throw ArgumentError.notNull('schoolSemester.id');
    }

    var $schoolday = schoolday.copyWith(schoolSemesterId: schoolSemester.id);
    await session.db.updateRow<_i2.Schoolday>(
      $schoolday,
      columns: [_i2.Schoolday.t.schoolSemesterId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [SchoolSemester] and the given [CompetenceReport]
  /// by setting the [CompetenceReport]'s foreign key `schoolSemesterId` to refer to this [SchoolSemester].
  Future<void> competenceReports(
    _i1.Session session,
    SchoolSemester schoolSemester,
    _i3.CompetenceReport competenceReport, {
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
    await session.db.updateRow<_i3.CompetenceReport>(
      $competenceReport,
      columns: [_i3.CompetenceReport.t.schoolSemesterId],
      transaction: transaction,
    );
  }
}

class SchoolSemesterDetachRepository {
  const SchoolSemesterDetachRepository._();

  /// Detaches the relation between this [SchoolSemester] and the given [Schoolday]
  /// by setting the [Schoolday]'s foreign key `schoolSemesterId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> schooldays(
    _i1.Session session,
    List<_i2.Schoolday> schoolday, {
    _i1.Transaction? transaction,
  }) async {
    if (schoolday.any((e) => e.id == null)) {
      throw ArgumentError.notNull('schoolday.id');
    }

    var $schoolday =
        schoolday.map((e) => e.copyWith(schoolSemesterId: null)).toList();
    await session.db.update<_i2.Schoolday>(
      $schoolday,
      columns: [_i2.Schoolday.t.schoolSemesterId],
      transaction: transaction,
    );
  }
}

class SchoolSemesterDetachRowRepository {
  const SchoolSemesterDetachRowRepository._();

  /// Detaches the relation between this [SchoolSemester] and the given [Schoolday]
  /// by setting the [Schoolday]'s foreign key `schoolSemesterId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> schooldays(
    _i1.Session session,
    _i2.Schoolday schoolday, {
    _i1.Transaction? transaction,
  }) async {
    if (schoolday.id == null) {
      throw ArgumentError.notNull('schoolday.id');
    }

    var $schoolday = schoolday.copyWith(schoolSemesterId: null);
    await session.db.updateRow<_i2.Schoolday>(
      $schoolday,
      columns: [_i2.Schoolday.t.schoolSemesterId],
      transaction: transaction,
    );
  }
}

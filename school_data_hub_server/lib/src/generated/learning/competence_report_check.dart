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
import '../learning/competence.dart' as _i3;
import '../learning/competence_report.dart' as _i4;

abstract class CompetenceReportCheck
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  CompetenceReportCheck._({
    this.id,
    required this.publicId,
    required this.achievement,
    required this.comment,
    required this.createdBy,
    required this.createdAt,
    required this.pupilId,
    this.pupil,
    required this.competenceId,
    this.competence,
    required this.competenceReportId,
    this.competenceReport,
  });

  factory CompetenceReportCheck({
    int? id,
    required String publicId,
    required int achievement,
    required String comment,
    required String createdBy,
    required DateTime createdAt,
    required int pupilId,
    _i2.PupilData? pupil,
    required int competenceId,
    _i3.Competence? competence,
    required int competenceReportId,
    _i4.CompetenceReport? competenceReport,
  }) = _CompetenceReportCheckImpl;

  factory CompetenceReportCheck.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CompetenceReportCheck(
      id: jsonSerialization['id'] as int?,
      publicId: jsonSerialization['publicId'] as String,
      achievement: jsonSerialization['achievement'] as int,
      comment: jsonSerialization['comment'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i2.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
      competenceId: jsonSerialization['competenceId'] as int,
      competence: jsonSerialization['competence'] == null
          ? null
          : _i3.Competence.fromJson(
              (jsonSerialization['competence'] as Map<String, dynamic>)),
      competenceReportId: jsonSerialization['competenceReportId'] as int,
      competenceReport: jsonSerialization['competenceReport'] == null
          ? null
          : _i4.CompetenceReport.fromJson(
              (jsonSerialization['competenceReport'] as Map<String, dynamic>)),
    );
  }

  static final t = CompetenceReportCheckTable();

  static const db = CompetenceReportCheckRepository._();

  @override
  int? id;

  String publicId;

  int achievement;

  String comment;

  String createdBy;

  DateTime createdAt;

  int pupilId;

  _i2.PupilData? pupil;

  int competenceId;

  _i3.Competence? competence;

  int competenceReportId;

  _i4.CompetenceReport? competenceReport;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [CompetenceReportCheck]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CompetenceReportCheck copyWith({
    int? id,
    String? publicId,
    int? achievement,
    String? comment,
    String? createdBy,
    DateTime? createdAt,
    int? pupilId,
    _i2.PupilData? pupil,
    int? competenceId,
    _i3.Competence? competence,
    int? competenceReportId,
    _i4.CompetenceReport? competenceReport,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'publicId': publicId,
      'achievement': achievement,
      'comment': comment,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
      'competenceId': competenceId,
      if (competence != null) 'competence': competence?.toJson(),
      'competenceReportId': competenceReportId,
      if (competenceReport != null)
        'competenceReport': competenceReport?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'publicId': publicId,
      'achievement': achievement,
      'comment': comment,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJsonForProtocol(),
      'competenceId': competenceId,
      if (competence != null) 'competence': competence?.toJsonForProtocol(),
      'competenceReportId': competenceReportId,
      if (competenceReport != null)
        'competenceReport': competenceReport?.toJsonForProtocol(),
    };
  }

  static CompetenceReportCheckInclude include({
    _i2.PupilDataInclude? pupil,
    _i3.CompetenceInclude? competence,
    _i4.CompetenceReportInclude? competenceReport,
  }) {
    return CompetenceReportCheckInclude._(
      pupil: pupil,
      competence: competence,
      competenceReport: competenceReport,
    );
  }

  static CompetenceReportCheckIncludeList includeList({
    _i1.WhereExpressionBuilder<CompetenceReportCheckTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CompetenceReportCheckTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompetenceReportCheckTable>? orderByList,
    CompetenceReportCheckInclude? include,
  }) {
    return CompetenceReportCheckIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CompetenceReportCheck.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CompetenceReportCheck.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompetenceReportCheckImpl extends CompetenceReportCheck {
  _CompetenceReportCheckImpl({
    int? id,
    required String publicId,
    required int achievement,
    required String comment,
    required String createdBy,
    required DateTime createdAt,
    required int pupilId,
    _i2.PupilData? pupil,
    required int competenceId,
    _i3.Competence? competence,
    required int competenceReportId,
    _i4.CompetenceReport? competenceReport,
  }) : super._(
          id: id,
          publicId: publicId,
          achievement: achievement,
          comment: comment,
          createdBy: createdBy,
          createdAt: createdAt,
          pupilId: pupilId,
          pupil: pupil,
          competenceId: competenceId,
          competence: competence,
          competenceReportId: competenceReportId,
          competenceReport: competenceReport,
        );

  /// Returns a shallow copy of this [CompetenceReportCheck]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CompetenceReportCheck copyWith({
    Object? id = _Undefined,
    String? publicId,
    int? achievement,
    String? comment,
    String? createdBy,
    DateTime? createdAt,
    int? pupilId,
    Object? pupil = _Undefined,
    int? competenceId,
    Object? competence = _Undefined,
    int? competenceReportId,
    Object? competenceReport = _Undefined,
  }) {
    return CompetenceReportCheck(
      id: id is int? ? id : this.id,
      publicId: publicId ?? this.publicId,
      achievement: achievement ?? this.achievement,
      comment: comment ?? this.comment,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i2.PupilData? ? pupil : this.pupil?.copyWith(),
      competenceId: competenceId ?? this.competenceId,
      competence: competence is _i3.Competence?
          ? competence
          : this.competence?.copyWith(),
      competenceReportId: competenceReportId ?? this.competenceReportId,
      competenceReport: competenceReport is _i4.CompetenceReport?
          ? competenceReport
          : this.competenceReport?.copyWith(),
    );
  }
}

class CompetenceReportCheckTable extends _i1.Table<int> {
  CompetenceReportCheckTable({super.tableRelation})
      : super(tableName: 'competence_report_check') {
    publicId = _i1.ColumnString(
      'publicId',
      this,
    );
    achievement = _i1.ColumnInt(
      'achievement',
      this,
    );
    comment = _i1.ColumnString(
      'comment',
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
    pupilId = _i1.ColumnInt(
      'pupilId',
      this,
    );
    competenceId = _i1.ColumnInt(
      'competenceId',
      this,
    );
    competenceReportId = _i1.ColumnInt(
      'competenceReportId',
      this,
    );
  }

  late final _i1.ColumnString publicId;

  late final _i1.ColumnInt achievement;

  late final _i1.ColumnString comment;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnInt pupilId;

  _i2.PupilDataTable? _pupil;

  late final _i1.ColumnInt competenceId;

  _i3.CompetenceTable? _competence;

  late final _i1.ColumnInt competenceReportId;

  _i4.CompetenceReportTable? _competenceReport;

  _i2.PupilDataTable get pupil {
    if (_pupil != null) return _pupil!;
    _pupil = _i1.createRelationTable(
      relationFieldName: 'pupil',
      field: CompetenceReportCheck.t.pupilId,
      foreignField: _i2.PupilData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PupilDataTable(tableRelation: foreignTableRelation),
    );
    return _pupil!;
  }

  _i3.CompetenceTable get competence {
    if (_competence != null) return _competence!;
    _competence = _i1.createRelationTable(
      relationFieldName: 'competence',
      field: CompetenceReportCheck.t.competenceId,
      foreignField: _i3.Competence.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CompetenceTable(tableRelation: foreignTableRelation),
    );
    return _competence!;
  }

  _i4.CompetenceReportTable get competenceReport {
    if (_competenceReport != null) return _competenceReport!;
    _competenceReport = _i1.createRelationTable(
      relationFieldName: 'competenceReport',
      field: CompetenceReportCheck.t.competenceReportId,
      foreignField: _i4.CompetenceReport.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.CompetenceReportTable(tableRelation: foreignTableRelation),
    );
    return _competenceReport!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        publicId,
        achievement,
        comment,
        createdBy,
        createdAt,
        pupilId,
        competenceId,
        competenceReportId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'pupil') {
      return pupil;
    }
    if (relationField == 'competence') {
      return competence;
    }
    if (relationField == 'competenceReport') {
      return competenceReport;
    }
    return null;
  }
}

class CompetenceReportCheckInclude extends _i1.IncludeObject {
  CompetenceReportCheckInclude._({
    _i2.PupilDataInclude? pupil,
    _i3.CompetenceInclude? competence,
    _i4.CompetenceReportInclude? competenceReport,
  }) {
    _pupil = pupil;
    _competence = competence;
    _competenceReport = competenceReport;
  }

  _i2.PupilDataInclude? _pupil;

  _i3.CompetenceInclude? _competence;

  _i4.CompetenceReportInclude? _competenceReport;

  @override
  Map<String, _i1.Include?> get includes => {
        'pupil': _pupil,
        'competence': _competence,
        'competenceReport': _competenceReport,
      };

  @override
  _i1.Table<int> get table => CompetenceReportCheck.t;
}

class CompetenceReportCheckIncludeList extends _i1.IncludeList {
  CompetenceReportCheckIncludeList._({
    _i1.WhereExpressionBuilder<CompetenceReportCheckTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CompetenceReportCheck.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => CompetenceReportCheck.t;
}

class CompetenceReportCheckRepository {
  const CompetenceReportCheckRepository._();

  final attachRow = const CompetenceReportCheckAttachRowRepository._();

  /// Returns a list of [CompetenceReportCheck]s matching the given query parameters.
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
  Future<List<CompetenceReportCheck>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompetenceReportCheckTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CompetenceReportCheckTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompetenceReportCheckTable>? orderByList,
    _i1.Transaction? transaction,
    CompetenceReportCheckInclude? include,
  }) async {
    return session.db.find<CompetenceReportCheck>(
      where: where?.call(CompetenceReportCheck.t),
      orderBy: orderBy?.call(CompetenceReportCheck.t),
      orderByList: orderByList?.call(CompetenceReportCheck.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [CompetenceReportCheck] matching the given query parameters.
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
  Future<CompetenceReportCheck?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompetenceReportCheckTable>? where,
    int? offset,
    _i1.OrderByBuilder<CompetenceReportCheckTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompetenceReportCheckTable>? orderByList,
    _i1.Transaction? transaction,
    CompetenceReportCheckInclude? include,
  }) async {
    return session.db.findFirstRow<CompetenceReportCheck>(
      where: where?.call(CompetenceReportCheck.t),
      orderBy: orderBy?.call(CompetenceReportCheck.t),
      orderByList: orderByList?.call(CompetenceReportCheck.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [CompetenceReportCheck] by its [id] or null if no such row exists.
  Future<CompetenceReportCheck?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CompetenceReportCheckInclude? include,
  }) async {
    return session.db.findById<CompetenceReportCheck>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [CompetenceReportCheck]s in the list and returns the inserted rows.
  ///
  /// The returned [CompetenceReportCheck]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CompetenceReportCheck>> insert(
    _i1.Session session,
    List<CompetenceReportCheck> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CompetenceReportCheck>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CompetenceReportCheck] and returns the inserted row.
  ///
  /// The returned [CompetenceReportCheck] will have its `id` field set.
  Future<CompetenceReportCheck> insertRow(
    _i1.Session session,
    CompetenceReportCheck row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CompetenceReportCheck>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CompetenceReportCheck]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CompetenceReportCheck>> update(
    _i1.Session session,
    List<CompetenceReportCheck> rows, {
    _i1.ColumnSelections<CompetenceReportCheckTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CompetenceReportCheck>(
      rows,
      columns: columns?.call(CompetenceReportCheck.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CompetenceReportCheck]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CompetenceReportCheck> updateRow(
    _i1.Session session,
    CompetenceReportCheck row, {
    _i1.ColumnSelections<CompetenceReportCheckTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CompetenceReportCheck>(
      row,
      columns: columns?.call(CompetenceReportCheck.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CompetenceReportCheck]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CompetenceReportCheck>> delete(
    _i1.Session session,
    List<CompetenceReportCheck> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CompetenceReportCheck>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CompetenceReportCheck].
  Future<CompetenceReportCheck> deleteRow(
    _i1.Session session,
    CompetenceReportCheck row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CompetenceReportCheck>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CompetenceReportCheck>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CompetenceReportCheckTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CompetenceReportCheck>(
      where: where(CompetenceReportCheck.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompetenceReportCheckTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CompetenceReportCheck>(
      where: where?.call(CompetenceReportCheck.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class CompetenceReportCheckAttachRowRepository {
  const CompetenceReportCheckAttachRowRepository._();

  /// Creates a relation between the given [CompetenceReportCheck] and [PupilData]
  /// by setting the [CompetenceReportCheck]'s foreign key `pupilId` to refer to the [PupilData].
  Future<void> pupil(
    _i1.Session session,
    CompetenceReportCheck competenceReportCheck,
    _i2.PupilData pupil, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceReportCheck.id == null) {
      throw ArgumentError.notNull('competenceReportCheck.id');
    }
    if (pupil.id == null) {
      throw ArgumentError.notNull('pupil.id');
    }

    var $competenceReportCheck =
        competenceReportCheck.copyWith(pupilId: pupil.id);
    await session.db.updateRow<CompetenceReportCheck>(
      $competenceReportCheck,
      columns: [CompetenceReportCheck.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CompetenceReportCheck] and [Competence]
  /// by setting the [CompetenceReportCheck]'s foreign key `competenceId` to refer to the [Competence].
  Future<void> competence(
    _i1.Session session,
    CompetenceReportCheck competenceReportCheck,
    _i3.Competence competence, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceReportCheck.id == null) {
      throw ArgumentError.notNull('competenceReportCheck.id');
    }
    if (competence.id == null) {
      throw ArgumentError.notNull('competence.id');
    }

    var $competenceReportCheck =
        competenceReportCheck.copyWith(competenceId: competence.id);
    await session.db.updateRow<CompetenceReportCheck>(
      $competenceReportCheck,
      columns: [CompetenceReportCheck.t.competenceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CompetenceReportCheck] and [CompetenceReport]
  /// by setting the [CompetenceReportCheck]'s foreign key `competenceReportId` to refer to the [CompetenceReport].
  Future<void> competenceReport(
    _i1.Session session,
    CompetenceReportCheck competenceReportCheck,
    _i4.CompetenceReport competenceReport, {
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
    await session.db.updateRow<CompetenceReportCheck>(
      $competenceReportCheck,
      columns: [CompetenceReportCheck.t.competenceReportId],
      transaction: transaction,
    );
  }
}

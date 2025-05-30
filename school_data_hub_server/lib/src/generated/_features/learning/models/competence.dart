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
import '../../../_features/learning/models/competence_goal.dart' as _i2;
import '../../../_features/learning/models/competence_check.dart' as _i3;
import '../../../_features/learning/models/competence_report_check.dart' as _i4;

abstract class Competence
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Competence._({
    this.id,
    required this.publicId,
    this.parentCompetence,
    required this.name,
    this.level,
    this.indicators,
    this.order,
    this.competenceGoals,
    this.competenceChecks,
    this.competenceReportChecks,
  });

  factory Competence({
    int? id,
    required int publicId,
    int? parentCompetence,
    required String name,
    List<String>? level,
    List<String>? indicators,
    int? order,
    List<_i2.CompetenceGoal>? competenceGoals,
    List<_i3.CompetenceCheck>? competenceChecks,
    List<_i4.CompetenceReportCheck>? competenceReportChecks,
  }) = _CompetenceImpl;

  factory Competence.fromJson(Map<String, dynamic> jsonSerialization) {
    return Competence(
      id: jsonSerialization['id'] as int?,
      publicId: jsonSerialization['publicId'] as int,
      parentCompetence: jsonSerialization['parentCompetence'] as int?,
      name: jsonSerialization['name'] as String,
      level: (jsonSerialization['level'] as List?)
          ?.map((e) => e as String)
          .toList(),
      indicators: (jsonSerialization['indicators'] as List?)
          ?.map((e) => e as String)
          .toList(),
      order: jsonSerialization['order'] as int?,
      competenceGoals: (jsonSerialization['competenceGoals'] as List?)
          ?.map((e) => _i2.CompetenceGoal.fromJson((e as Map<String, dynamic>)))
          .toList(),
      competenceChecks: (jsonSerialization['competenceChecks'] as List?)
          ?.map(
              (e) => _i3.CompetenceCheck.fromJson((e as Map<String, dynamic>)))
          .toList(),
      competenceReportChecks: (jsonSerialization['competenceReportChecks']
              as List?)
          ?.map((e) =>
              _i4.CompetenceReportCheck.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = CompetenceTable();

  static const db = CompetenceRepository._();

  @override
  int? id;

  int publicId;

  int? parentCompetence;

  String name;

  List<String>? level;

  List<String>? indicators;

  int? order;

  List<_i2.CompetenceGoal>? competenceGoals;

  List<_i3.CompetenceCheck>? competenceChecks;

  List<_i4.CompetenceReportCheck>? competenceReportChecks;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Competence]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Competence copyWith({
    int? id,
    int? publicId,
    int? parentCompetence,
    String? name,
    List<String>? level,
    List<String>? indicators,
    int? order,
    List<_i2.CompetenceGoal>? competenceGoals,
    List<_i3.CompetenceCheck>? competenceChecks,
    List<_i4.CompetenceReportCheck>? competenceReportChecks,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'publicId': publicId,
      if (parentCompetence != null) 'parentCompetence': parentCompetence,
      'name': name,
      if (level != null) 'level': level?.toJson(),
      if (indicators != null) 'indicators': indicators?.toJson(),
      if (order != null) 'order': order,
      if (competenceGoals != null)
        'competenceGoals':
            competenceGoals?.toJson(valueToJson: (v) => v.toJson()),
      if (competenceChecks != null)
        'competenceChecks':
            competenceChecks?.toJson(valueToJson: (v) => v.toJson()),
      if (competenceReportChecks != null)
        'competenceReportChecks':
            competenceReportChecks?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'publicId': publicId,
      if (parentCompetence != null) 'parentCompetence': parentCompetence,
      'name': name,
      if (level != null) 'level': level?.toJson(),
      if (indicators != null) 'indicators': indicators?.toJson(),
      if (order != null) 'order': order,
      if (competenceGoals != null)
        'competenceGoals':
            competenceGoals?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (competenceChecks != null)
        'competenceChecks':
            competenceChecks?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (competenceReportChecks != null)
        'competenceReportChecks': competenceReportChecks?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static CompetenceInclude include({
    _i2.CompetenceGoalIncludeList? competenceGoals,
    _i3.CompetenceCheckIncludeList? competenceChecks,
    _i4.CompetenceReportCheckIncludeList? competenceReportChecks,
  }) {
    return CompetenceInclude._(
      competenceGoals: competenceGoals,
      competenceChecks: competenceChecks,
      competenceReportChecks: competenceReportChecks,
    );
  }

  static CompetenceIncludeList includeList({
    _i1.WhereExpressionBuilder<CompetenceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CompetenceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompetenceTable>? orderByList,
    CompetenceInclude? include,
  }) {
    return CompetenceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Competence.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Competence.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompetenceImpl extends Competence {
  _CompetenceImpl({
    int? id,
    required int publicId,
    int? parentCompetence,
    required String name,
    List<String>? level,
    List<String>? indicators,
    int? order,
    List<_i2.CompetenceGoal>? competenceGoals,
    List<_i3.CompetenceCheck>? competenceChecks,
    List<_i4.CompetenceReportCheck>? competenceReportChecks,
  }) : super._(
          id: id,
          publicId: publicId,
          parentCompetence: parentCompetence,
          name: name,
          level: level,
          indicators: indicators,
          order: order,
          competenceGoals: competenceGoals,
          competenceChecks: competenceChecks,
          competenceReportChecks: competenceReportChecks,
        );

  /// Returns a shallow copy of this [Competence]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Competence copyWith({
    Object? id = _Undefined,
    int? publicId,
    Object? parentCompetence = _Undefined,
    String? name,
    Object? level = _Undefined,
    Object? indicators = _Undefined,
    Object? order = _Undefined,
    Object? competenceGoals = _Undefined,
    Object? competenceChecks = _Undefined,
    Object? competenceReportChecks = _Undefined,
  }) {
    return Competence(
      id: id is int? ? id : this.id,
      publicId: publicId ?? this.publicId,
      parentCompetence:
          parentCompetence is int? ? parentCompetence : this.parentCompetence,
      name: name ?? this.name,
      level:
          level is List<String>? ? level : this.level?.map((e0) => e0).toList(),
      indicators: indicators is List<String>?
          ? indicators
          : this.indicators?.map((e0) => e0).toList(),
      order: order is int? ? order : this.order,
      competenceGoals: competenceGoals is List<_i2.CompetenceGoal>?
          ? competenceGoals
          : this.competenceGoals?.map((e0) => e0.copyWith()).toList(),
      competenceChecks: competenceChecks is List<_i3.CompetenceCheck>?
          ? competenceChecks
          : this.competenceChecks?.map((e0) => e0.copyWith()).toList(),
      competenceReportChecks: competenceReportChecks
              is List<_i4.CompetenceReportCheck>?
          ? competenceReportChecks
          : this.competenceReportChecks?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class CompetenceTable extends _i1.Table<int?> {
  CompetenceTable({super.tableRelation}) : super(tableName: 'competence') {
    publicId = _i1.ColumnInt(
      'publicId',
      this,
    );
    parentCompetence = _i1.ColumnInt(
      'parentCompetence',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    level = _i1.ColumnSerializable(
      'level',
      this,
    );
    indicators = _i1.ColumnSerializable(
      'indicators',
      this,
    );
    order = _i1.ColumnInt(
      'order',
      this,
    );
  }

  late final _i1.ColumnInt publicId;

  late final _i1.ColumnInt parentCompetence;

  late final _i1.ColumnString name;

  late final _i1.ColumnSerializable level;

  late final _i1.ColumnSerializable indicators;

  late final _i1.ColumnInt order;

  _i2.CompetenceGoalTable? ___competenceGoals;

  _i1.ManyRelation<_i2.CompetenceGoalTable>? _competenceGoals;

  _i3.CompetenceCheckTable? ___competenceChecks;

  _i1.ManyRelation<_i3.CompetenceCheckTable>? _competenceChecks;

  _i4.CompetenceReportCheckTable? ___competenceReportChecks;

  _i1.ManyRelation<_i4.CompetenceReportCheckTable>? _competenceReportChecks;

  _i2.CompetenceGoalTable get __competenceGoals {
    if (___competenceGoals != null) return ___competenceGoals!;
    ___competenceGoals = _i1.createRelationTable(
      relationFieldName: '__competenceGoals',
      field: Competence.t.id,
      foreignField: _i2.CompetenceGoal.t.competenceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CompetenceGoalTable(tableRelation: foreignTableRelation),
    );
    return ___competenceGoals!;
  }

  _i3.CompetenceCheckTable get __competenceChecks {
    if (___competenceChecks != null) return ___competenceChecks!;
    ___competenceChecks = _i1.createRelationTable(
      relationFieldName: '__competenceChecks',
      field: Competence.t.id,
      foreignField: _i3.CompetenceCheck.t.competenceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CompetenceCheckTable(tableRelation: foreignTableRelation),
    );
    return ___competenceChecks!;
  }

  _i4.CompetenceReportCheckTable get __competenceReportChecks {
    if (___competenceReportChecks != null) return ___competenceReportChecks!;
    ___competenceReportChecks = _i1.createRelationTable(
      relationFieldName: '__competenceReportChecks',
      field: Competence.t.id,
      foreignField: _i4.CompetenceReportCheck.t.competenceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.CompetenceReportCheckTable(tableRelation: foreignTableRelation),
    );
    return ___competenceReportChecks!;
  }

  _i1.ManyRelation<_i2.CompetenceGoalTable> get competenceGoals {
    if (_competenceGoals != null) return _competenceGoals!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'competenceGoals',
      field: Competence.t.id,
      foreignField: _i2.CompetenceGoal.t.competenceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CompetenceGoalTable(tableRelation: foreignTableRelation),
    );
    _competenceGoals = _i1.ManyRelation<_i2.CompetenceGoalTable>(
      tableWithRelations: relationTable,
      table: _i2.CompetenceGoalTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _competenceGoals!;
  }

  _i1.ManyRelation<_i3.CompetenceCheckTable> get competenceChecks {
    if (_competenceChecks != null) return _competenceChecks!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'competenceChecks',
      field: Competence.t.id,
      foreignField: _i3.CompetenceCheck.t.competenceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CompetenceCheckTable(tableRelation: foreignTableRelation),
    );
    _competenceChecks = _i1.ManyRelation<_i3.CompetenceCheckTable>(
      tableWithRelations: relationTable,
      table: _i3.CompetenceCheckTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _competenceChecks!;
  }

  _i1.ManyRelation<_i4.CompetenceReportCheckTable> get competenceReportChecks {
    if (_competenceReportChecks != null) return _competenceReportChecks!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'competenceReportChecks',
      field: Competence.t.id,
      foreignField: _i4.CompetenceReportCheck.t.competenceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.CompetenceReportCheckTable(tableRelation: foreignTableRelation),
    );
    _competenceReportChecks = _i1.ManyRelation<_i4.CompetenceReportCheckTable>(
      tableWithRelations: relationTable,
      table: _i4.CompetenceReportCheckTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _competenceReportChecks!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        publicId,
        parentCompetence,
        name,
        level,
        indicators,
        order,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'competenceGoals') {
      return __competenceGoals;
    }
    if (relationField == 'competenceChecks') {
      return __competenceChecks;
    }
    if (relationField == 'competenceReportChecks') {
      return __competenceReportChecks;
    }
    return null;
  }
}

class CompetenceInclude extends _i1.IncludeObject {
  CompetenceInclude._({
    _i2.CompetenceGoalIncludeList? competenceGoals,
    _i3.CompetenceCheckIncludeList? competenceChecks,
    _i4.CompetenceReportCheckIncludeList? competenceReportChecks,
  }) {
    _competenceGoals = competenceGoals;
    _competenceChecks = competenceChecks;
    _competenceReportChecks = competenceReportChecks;
  }

  _i2.CompetenceGoalIncludeList? _competenceGoals;

  _i3.CompetenceCheckIncludeList? _competenceChecks;

  _i4.CompetenceReportCheckIncludeList? _competenceReportChecks;

  @override
  Map<String, _i1.Include?> get includes => {
        'competenceGoals': _competenceGoals,
        'competenceChecks': _competenceChecks,
        'competenceReportChecks': _competenceReportChecks,
      };

  @override
  _i1.Table<int?> get table => Competence.t;
}

class CompetenceIncludeList extends _i1.IncludeList {
  CompetenceIncludeList._({
    _i1.WhereExpressionBuilder<CompetenceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Competence.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Competence.t;
}

class CompetenceRepository {
  const CompetenceRepository._();

  final attach = const CompetenceAttachRepository._();

  final attachRow = const CompetenceAttachRowRepository._();

  final detach = const CompetenceDetachRepository._();

  final detachRow = const CompetenceDetachRowRepository._();

  /// Returns a list of [Competence]s matching the given query parameters.
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
  Future<List<Competence>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompetenceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CompetenceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompetenceTable>? orderByList,
    _i1.Transaction? transaction,
    CompetenceInclude? include,
  }) async {
    return session.db.find<Competence>(
      where: where?.call(Competence.t),
      orderBy: orderBy?.call(Competence.t),
      orderByList: orderByList?.call(Competence.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Competence] matching the given query parameters.
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
  Future<Competence?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompetenceTable>? where,
    int? offset,
    _i1.OrderByBuilder<CompetenceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompetenceTable>? orderByList,
    _i1.Transaction? transaction,
    CompetenceInclude? include,
  }) async {
    return session.db.findFirstRow<Competence>(
      where: where?.call(Competence.t),
      orderBy: orderBy?.call(Competence.t),
      orderByList: orderByList?.call(Competence.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Competence] by its [id] or null if no such row exists.
  Future<Competence?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CompetenceInclude? include,
  }) async {
    return session.db.findById<Competence>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Competence]s in the list and returns the inserted rows.
  ///
  /// The returned [Competence]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Competence>> insert(
    _i1.Session session,
    List<Competence> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Competence>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Competence] and returns the inserted row.
  ///
  /// The returned [Competence] will have its `id` field set.
  Future<Competence> insertRow(
    _i1.Session session,
    Competence row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Competence>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Competence]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Competence>> update(
    _i1.Session session,
    List<Competence> rows, {
    _i1.ColumnSelections<CompetenceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Competence>(
      rows,
      columns: columns?.call(Competence.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Competence]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Competence> updateRow(
    _i1.Session session,
    Competence row, {
    _i1.ColumnSelections<CompetenceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Competence>(
      row,
      columns: columns?.call(Competence.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Competence]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Competence>> delete(
    _i1.Session session,
    List<Competence> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Competence>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Competence].
  Future<Competence> deleteRow(
    _i1.Session session,
    Competence row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Competence>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Competence>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CompetenceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Competence>(
      where: where(Competence.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompetenceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Competence>(
      where: where?.call(Competence.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class CompetenceAttachRepository {
  const CompetenceAttachRepository._();

  /// Creates a relation between this [Competence] and the given [CompetenceGoal]s
  /// by setting each [CompetenceGoal]'s foreign key `competenceId` to refer to this [Competence].
  Future<void> competenceGoals(
    _i1.Session session,
    Competence competence,
    List<_i2.CompetenceGoal> competenceGoal, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceGoal.any((e) => e.id == null)) {
      throw ArgumentError.notNull('competenceGoal.id');
    }
    if (competence.id == null) {
      throw ArgumentError.notNull('competence.id');
    }

    var $competenceGoal = competenceGoal
        .map((e) => e.copyWith(competenceId: competence.id))
        .toList();
    await session.db.update<_i2.CompetenceGoal>(
      $competenceGoal,
      columns: [_i2.CompetenceGoal.t.competenceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Competence] and the given [CompetenceCheck]s
  /// by setting each [CompetenceCheck]'s foreign key `competenceId` to refer to this [Competence].
  Future<void> competenceChecks(
    _i1.Session session,
    Competence competence,
    List<_i3.CompetenceCheck> competenceCheck, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceCheck.any((e) => e.id == null)) {
      throw ArgumentError.notNull('competenceCheck.id');
    }
    if (competence.id == null) {
      throw ArgumentError.notNull('competence.id');
    }

    var $competenceCheck = competenceCheck
        .map((e) => e.copyWith(competenceId: competence.id))
        .toList();
    await session.db.update<_i3.CompetenceCheck>(
      $competenceCheck,
      columns: [_i3.CompetenceCheck.t.competenceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Competence] and the given [CompetenceReportCheck]s
  /// by setting each [CompetenceReportCheck]'s foreign key `competenceId` to refer to this [Competence].
  Future<void> competenceReportChecks(
    _i1.Session session,
    Competence competence,
    List<_i4.CompetenceReportCheck> competenceReportCheck, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceReportCheck.any((e) => e.id == null)) {
      throw ArgumentError.notNull('competenceReportCheck.id');
    }
    if (competence.id == null) {
      throw ArgumentError.notNull('competence.id');
    }

    var $competenceReportCheck = competenceReportCheck
        .map((e) => e.copyWith(competenceId: competence.id))
        .toList();
    await session.db.update<_i4.CompetenceReportCheck>(
      $competenceReportCheck,
      columns: [_i4.CompetenceReportCheck.t.competenceId],
      transaction: transaction,
    );
  }
}

class CompetenceAttachRowRepository {
  const CompetenceAttachRowRepository._();

  /// Creates a relation between this [Competence] and the given [CompetenceGoal]
  /// by setting the [CompetenceGoal]'s foreign key `competenceId` to refer to this [Competence].
  Future<void> competenceGoals(
    _i1.Session session,
    Competence competence,
    _i2.CompetenceGoal competenceGoal, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceGoal.id == null) {
      throw ArgumentError.notNull('competenceGoal.id');
    }
    if (competence.id == null) {
      throw ArgumentError.notNull('competence.id');
    }

    var $competenceGoal = competenceGoal.copyWith(competenceId: competence.id);
    await session.db.updateRow<_i2.CompetenceGoal>(
      $competenceGoal,
      columns: [_i2.CompetenceGoal.t.competenceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Competence] and the given [CompetenceCheck]
  /// by setting the [CompetenceCheck]'s foreign key `competenceId` to refer to this [Competence].
  Future<void> competenceChecks(
    _i1.Session session,
    Competence competence,
    _i3.CompetenceCheck competenceCheck, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceCheck.id == null) {
      throw ArgumentError.notNull('competenceCheck.id');
    }
    if (competence.id == null) {
      throw ArgumentError.notNull('competence.id');
    }

    var $competenceCheck =
        competenceCheck.copyWith(competenceId: competence.id);
    await session.db.updateRow<_i3.CompetenceCheck>(
      $competenceCheck,
      columns: [_i3.CompetenceCheck.t.competenceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Competence] and the given [CompetenceReportCheck]
  /// by setting the [CompetenceReportCheck]'s foreign key `competenceId` to refer to this [Competence].
  Future<void> competenceReportChecks(
    _i1.Session session,
    Competence competence,
    _i4.CompetenceReportCheck competenceReportCheck, {
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
    await session.db.updateRow<_i4.CompetenceReportCheck>(
      $competenceReportCheck,
      columns: [_i4.CompetenceReportCheck.t.competenceId],
      transaction: transaction,
    );
  }
}

class CompetenceDetachRepository {
  const CompetenceDetachRepository._();

  /// Detaches the relation between this [Competence] and the given [CompetenceGoal]
  /// by setting the [CompetenceGoal]'s foreign key `competenceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> competenceGoals(
    _i1.Session session,
    List<_i2.CompetenceGoal> competenceGoal, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceGoal.any((e) => e.id == null)) {
      throw ArgumentError.notNull('competenceGoal.id');
    }

    var $competenceGoal =
        competenceGoal.map((e) => e.copyWith(competenceId: null)).toList();
    await session.db.update<_i2.CompetenceGoal>(
      $competenceGoal,
      columns: [_i2.CompetenceGoal.t.competenceId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Competence] and the given [CompetenceCheck]
  /// by setting the [CompetenceCheck]'s foreign key `competenceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> competenceChecks(
    _i1.Session session,
    List<_i3.CompetenceCheck> competenceCheck, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceCheck.any((e) => e.id == null)) {
      throw ArgumentError.notNull('competenceCheck.id');
    }

    var $competenceCheck =
        competenceCheck.map((e) => e.copyWith(competenceId: null)).toList();
    await session.db.update<_i3.CompetenceCheck>(
      $competenceCheck,
      columns: [_i3.CompetenceCheck.t.competenceId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Competence] and the given [CompetenceReportCheck]
  /// by setting the [CompetenceReportCheck]'s foreign key `competenceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> competenceReportChecks(
    _i1.Session session,
    List<_i4.CompetenceReportCheck> competenceReportCheck, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceReportCheck.any((e) => e.id == null)) {
      throw ArgumentError.notNull('competenceReportCheck.id');
    }

    var $competenceReportCheck = competenceReportCheck
        .map((e) => e.copyWith(competenceId: null))
        .toList();
    await session.db.update<_i4.CompetenceReportCheck>(
      $competenceReportCheck,
      columns: [_i4.CompetenceReportCheck.t.competenceId],
      transaction: transaction,
    );
  }
}

class CompetenceDetachRowRepository {
  const CompetenceDetachRowRepository._();

  /// Detaches the relation between this [Competence] and the given [CompetenceGoal]
  /// by setting the [CompetenceGoal]'s foreign key `competenceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> competenceGoals(
    _i1.Session session,
    _i2.CompetenceGoal competenceGoal, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceGoal.id == null) {
      throw ArgumentError.notNull('competenceGoal.id');
    }

    var $competenceGoal = competenceGoal.copyWith(competenceId: null);
    await session.db.updateRow<_i2.CompetenceGoal>(
      $competenceGoal,
      columns: [_i2.CompetenceGoal.t.competenceId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Competence] and the given [CompetenceCheck]
  /// by setting the [CompetenceCheck]'s foreign key `competenceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> competenceChecks(
    _i1.Session session,
    _i3.CompetenceCheck competenceCheck, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceCheck.id == null) {
      throw ArgumentError.notNull('competenceCheck.id');
    }

    var $competenceCheck = competenceCheck.copyWith(competenceId: null);
    await session.db.updateRow<_i3.CompetenceCheck>(
      $competenceCheck,
      columns: [_i3.CompetenceCheck.t.competenceId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Competence] and the given [CompetenceReportCheck]
  /// by setting the [CompetenceReportCheck]'s foreign key `competenceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> competenceReportChecks(
    _i1.Session session,
    _i4.CompetenceReportCheck competenceReportCheck, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceReportCheck.id == null) {
      throw ArgumentError.notNull('competenceReportCheck.id');
    }

    var $competenceReportCheck =
        competenceReportCheck.copyWith(competenceId: null);
    await session.db.updateRow<_i4.CompetenceReportCheck>(
      $competenceReportCheck,
      columns: [_i4.CompetenceReportCheck.t.competenceId],
      transaction: transaction,
    );
  }
}

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
import '../shared/document.dart' as _i4;

abstract class CompetenceGoal
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  CompetenceGoal._({
    this.id,
    required this.publicId,
    required this.description,
    this.strategies,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedBy,
    required this.achievement,
    required this.achievedAt,
    required this.pupilId,
    this.pupil,
    required this.competenceId,
    this.competence,
    this.documents,
  });

  factory CompetenceGoal({
    int? id,
    required String publicId,
    required String description,
    List<String>? strategies,
    required String createdBy,
    required DateTime createdAt,
    required String modifiedBy,
    required String achievement,
    required DateTime achievedAt,
    required int pupilId,
    _i2.PupilData? pupil,
    required int competenceId,
    _i3.Competence? competence,
    List<_i4.HubDocument>? documents,
  }) = _CompetenceGoalImpl;

  factory CompetenceGoal.fromJson(Map<String, dynamic> jsonSerialization) {
    return CompetenceGoal(
      id: jsonSerialization['id'] as int?,
      publicId: jsonSerialization['publicId'] as String,
      description: jsonSerialization['description'] as String,
      strategies: (jsonSerialization['strategies'] as List?)
          ?.map((e) => e as String)
          .toList(),
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
      competenceId: jsonSerialization['competenceId'] as int,
      competence: jsonSerialization['competence'] == null
          ? null
          : _i3.Competence.fromJson(
              (jsonSerialization['competence'] as Map<String, dynamic>)),
      documents: (jsonSerialization['documents'] as List?)
          ?.map((e) => _i4.HubDocument.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = CompetenceGoalTable();

  static const db = CompetenceGoalRepository._();

  @override
  int? id;

  String publicId;

  String description;

  List<String>? strategies;

  String createdBy;

  DateTime createdAt;

  String modifiedBy;

  String achievement;

  DateTime achievedAt;

  int pupilId;

  _i2.PupilData? pupil;

  int competenceId;

  _i3.Competence? competence;

  List<_i4.HubDocument>? documents;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [CompetenceGoal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CompetenceGoal copyWith({
    int? id,
    String? publicId,
    String? description,
    List<String>? strategies,
    String? createdBy,
    DateTime? createdAt,
    String? modifiedBy,
    String? achievement,
    DateTime? achievedAt,
    int? pupilId,
    _i2.PupilData? pupil,
    int? competenceId,
    _i3.Competence? competence,
    List<_i4.HubDocument>? documents,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'publicId': publicId,
      'description': description,
      if (strategies != null) 'strategies': strategies?.toJson(),
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'modifiedBy': modifiedBy,
      'achievement': achievement,
      'achievedAt': achievedAt.toJson(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
      'competenceId': competenceId,
      if (competence != null) 'competence': competence?.toJson(),
      if (documents != null)
        'documents': documents?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'publicId': publicId,
      'description': description,
      if (strategies != null) 'strategies': strategies?.toJson(),
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'modifiedBy': modifiedBy,
      'achievement': achievement,
      'achievedAt': achievedAt.toJson(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJsonForProtocol(),
      'competenceId': competenceId,
      if (competence != null) 'competence': competence?.toJsonForProtocol(),
      if (documents != null)
        'documents':
            documents?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static CompetenceGoalInclude include({
    _i2.PupilDataInclude? pupil,
    _i3.CompetenceInclude? competence,
    _i4.HubDocumentIncludeList? documents,
  }) {
    return CompetenceGoalInclude._(
      pupil: pupil,
      competence: competence,
      documents: documents,
    );
  }

  static CompetenceGoalIncludeList includeList({
    _i1.WhereExpressionBuilder<CompetenceGoalTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CompetenceGoalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompetenceGoalTable>? orderByList,
    CompetenceGoalInclude? include,
  }) {
    return CompetenceGoalIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CompetenceGoal.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CompetenceGoal.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompetenceGoalImpl extends CompetenceGoal {
  _CompetenceGoalImpl({
    int? id,
    required String publicId,
    required String description,
    List<String>? strategies,
    required String createdBy,
    required DateTime createdAt,
    required String modifiedBy,
    required String achievement,
    required DateTime achievedAt,
    required int pupilId,
    _i2.PupilData? pupil,
    required int competenceId,
    _i3.Competence? competence,
    List<_i4.HubDocument>? documents,
  }) : super._(
          id: id,
          publicId: publicId,
          description: description,
          strategies: strategies,
          createdBy: createdBy,
          createdAt: createdAt,
          modifiedBy: modifiedBy,
          achievement: achievement,
          achievedAt: achievedAt,
          pupilId: pupilId,
          pupil: pupil,
          competenceId: competenceId,
          competence: competence,
          documents: documents,
        );

  /// Returns a shallow copy of this [CompetenceGoal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CompetenceGoal copyWith({
    Object? id = _Undefined,
    String? publicId,
    String? description,
    Object? strategies = _Undefined,
    String? createdBy,
    DateTime? createdAt,
    String? modifiedBy,
    String? achievement,
    DateTime? achievedAt,
    int? pupilId,
    Object? pupil = _Undefined,
    int? competenceId,
    Object? competence = _Undefined,
    Object? documents = _Undefined,
  }) {
    return CompetenceGoal(
      id: id is int? ? id : this.id,
      publicId: publicId ?? this.publicId,
      description: description ?? this.description,
      strategies: strategies is List<String>?
          ? strategies
          : this.strategies?.map((e0) => e0).toList(),
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      achievement: achievement ?? this.achievement,
      achievedAt: achievedAt ?? this.achievedAt,
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i2.PupilData? ? pupil : this.pupil?.copyWith(),
      competenceId: competenceId ?? this.competenceId,
      competence: competence is _i3.Competence?
          ? competence
          : this.competence?.copyWith(),
      documents: documents is List<_i4.HubDocument>?
          ? documents
          : this.documents?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class CompetenceGoalTable extends _i1.Table<int> {
  CompetenceGoalTable({super.tableRelation})
      : super(tableName: 'competence_goal') {
    publicId = _i1.ColumnString(
      'publicId',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    strategies = _i1.ColumnSerializable(
      'strategies',
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
    competenceId = _i1.ColumnInt(
      'competenceId',
      this,
    );
  }

  late final _i1.ColumnString publicId;

  late final _i1.ColumnString description;

  late final _i1.ColumnSerializable strategies;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnString modifiedBy;

  late final _i1.ColumnString achievement;

  late final _i1.ColumnDateTime achievedAt;

  late final _i1.ColumnInt pupilId;

  _i2.PupilDataTable? _pupil;

  late final _i1.ColumnInt competenceId;

  _i3.CompetenceTable? _competence;

  _i4.HubDocumentTable? ___documents;

  _i1.ManyRelation<_i4.HubDocumentTable>? _documents;

  _i2.PupilDataTable get pupil {
    if (_pupil != null) return _pupil!;
    _pupil = _i1.createRelationTable(
      relationFieldName: 'pupil',
      field: CompetenceGoal.t.pupilId,
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
      field: CompetenceGoal.t.competenceId,
      foreignField: _i3.Competence.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CompetenceTable(tableRelation: foreignTableRelation),
    );
    return _competence!;
  }

  _i4.HubDocumentTable get __documents {
    if (___documents != null) return ___documents!;
    ___documents = _i1.createRelationTable(
      relationFieldName: '__documents',
      field: CompetenceGoal.t.id,
      foreignField: _i4.HubDocument.t.$_competenceGoalDocumentsCompetenceGoalId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.HubDocumentTable(tableRelation: foreignTableRelation),
    );
    return ___documents!;
  }

  _i1.ManyRelation<_i4.HubDocumentTable> get documents {
    if (_documents != null) return _documents!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'documents',
      field: CompetenceGoal.t.id,
      foreignField: _i4.HubDocument.t.$_competenceGoalDocumentsCompetenceGoalId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.HubDocumentTable(tableRelation: foreignTableRelation),
    );
    _documents = _i1.ManyRelation<_i4.HubDocumentTable>(
      tableWithRelations: relationTable,
      table: _i4.HubDocumentTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _documents!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        publicId,
        description,
        strategies,
        createdBy,
        createdAt,
        modifiedBy,
        achievement,
        achievedAt,
        pupilId,
        competenceId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'pupil') {
      return pupil;
    }
    if (relationField == 'competence') {
      return competence;
    }
    if (relationField == 'documents') {
      return __documents;
    }
    return null;
  }
}

class CompetenceGoalInclude extends _i1.IncludeObject {
  CompetenceGoalInclude._({
    _i2.PupilDataInclude? pupil,
    _i3.CompetenceInclude? competence,
    _i4.HubDocumentIncludeList? documents,
  }) {
    _pupil = pupil;
    _competence = competence;
    _documents = documents;
  }

  _i2.PupilDataInclude? _pupil;

  _i3.CompetenceInclude? _competence;

  _i4.HubDocumentIncludeList? _documents;

  @override
  Map<String, _i1.Include?> get includes => {
        'pupil': _pupil,
        'competence': _competence,
        'documents': _documents,
      };

  @override
  _i1.Table<int> get table => CompetenceGoal.t;
}

class CompetenceGoalIncludeList extends _i1.IncludeList {
  CompetenceGoalIncludeList._({
    _i1.WhereExpressionBuilder<CompetenceGoalTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CompetenceGoal.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => CompetenceGoal.t;
}

class CompetenceGoalRepository {
  const CompetenceGoalRepository._();

  final attach = const CompetenceGoalAttachRepository._();

  final attachRow = const CompetenceGoalAttachRowRepository._();

  final detach = const CompetenceGoalDetachRepository._();

  final detachRow = const CompetenceGoalDetachRowRepository._();

  /// Returns a list of [CompetenceGoal]s matching the given query parameters.
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
  Future<List<CompetenceGoal>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompetenceGoalTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CompetenceGoalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompetenceGoalTable>? orderByList,
    _i1.Transaction? transaction,
    CompetenceGoalInclude? include,
  }) async {
    return session.db.find<CompetenceGoal>(
      where: where?.call(CompetenceGoal.t),
      orderBy: orderBy?.call(CompetenceGoal.t),
      orderByList: orderByList?.call(CompetenceGoal.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [CompetenceGoal] matching the given query parameters.
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
  Future<CompetenceGoal?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompetenceGoalTable>? where,
    int? offset,
    _i1.OrderByBuilder<CompetenceGoalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompetenceGoalTable>? orderByList,
    _i1.Transaction? transaction,
    CompetenceGoalInclude? include,
  }) async {
    return session.db.findFirstRow<CompetenceGoal>(
      where: where?.call(CompetenceGoal.t),
      orderBy: orderBy?.call(CompetenceGoal.t),
      orderByList: orderByList?.call(CompetenceGoal.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [CompetenceGoal] by its [id] or null if no such row exists.
  Future<CompetenceGoal?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CompetenceGoalInclude? include,
  }) async {
    return session.db.findById<CompetenceGoal>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [CompetenceGoal]s in the list and returns the inserted rows.
  ///
  /// The returned [CompetenceGoal]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CompetenceGoal>> insert(
    _i1.Session session,
    List<CompetenceGoal> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CompetenceGoal>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CompetenceGoal] and returns the inserted row.
  ///
  /// The returned [CompetenceGoal] will have its `id` field set.
  Future<CompetenceGoal> insertRow(
    _i1.Session session,
    CompetenceGoal row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CompetenceGoal>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CompetenceGoal]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CompetenceGoal>> update(
    _i1.Session session,
    List<CompetenceGoal> rows, {
    _i1.ColumnSelections<CompetenceGoalTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CompetenceGoal>(
      rows,
      columns: columns?.call(CompetenceGoal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CompetenceGoal]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CompetenceGoal> updateRow(
    _i1.Session session,
    CompetenceGoal row, {
    _i1.ColumnSelections<CompetenceGoalTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CompetenceGoal>(
      row,
      columns: columns?.call(CompetenceGoal.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CompetenceGoal]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CompetenceGoal>> delete(
    _i1.Session session,
    List<CompetenceGoal> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CompetenceGoal>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CompetenceGoal].
  Future<CompetenceGoal> deleteRow(
    _i1.Session session,
    CompetenceGoal row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CompetenceGoal>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CompetenceGoal>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CompetenceGoalTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CompetenceGoal>(
      where: where(CompetenceGoal.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompetenceGoalTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CompetenceGoal>(
      where: where?.call(CompetenceGoal.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class CompetenceGoalAttachRepository {
  const CompetenceGoalAttachRepository._();

  /// Creates a relation between this [CompetenceGoal] and the given [HubDocument]s
  /// by setting each [HubDocument]'s foreign key `_competenceGoalDocumentsCompetenceGoalId` to refer to this [CompetenceGoal].
  Future<void> documents(
    _i1.Session session,
    CompetenceGoal competenceGoal,
    List<_i4.HubDocument> hubDocument, {
    _i1.Transaction? transaction,
  }) async {
    if (hubDocument.any((e) => e.id == null)) {
      throw ArgumentError.notNull('hubDocument.id');
    }
    if (competenceGoal.id == null) {
      throw ArgumentError.notNull('competenceGoal.id');
    }

    var $hubDocument = hubDocument
        .map((e) => _i4.HubDocumentImplicit(
              e,
              $_competenceGoalDocumentsCompetenceGoalId: competenceGoal.id,
            ))
        .toList();
    await session.db.update<_i4.HubDocument>(
      $hubDocument,
      columns: [_i4.HubDocument.t.$_competenceGoalDocumentsCompetenceGoalId],
      transaction: transaction,
    );
  }
}

class CompetenceGoalAttachRowRepository {
  const CompetenceGoalAttachRowRepository._();

  /// Creates a relation between the given [CompetenceGoal] and [PupilData]
  /// by setting the [CompetenceGoal]'s foreign key `pupilId` to refer to the [PupilData].
  Future<void> pupil(
    _i1.Session session,
    CompetenceGoal competenceGoal,
    _i2.PupilData pupil, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceGoal.id == null) {
      throw ArgumentError.notNull('competenceGoal.id');
    }
    if (pupil.id == null) {
      throw ArgumentError.notNull('pupil.id');
    }

    var $competenceGoal = competenceGoal.copyWith(pupilId: pupil.id);
    await session.db.updateRow<CompetenceGoal>(
      $competenceGoal,
      columns: [CompetenceGoal.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CompetenceGoal] and [Competence]
  /// by setting the [CompetenceGoal]'s foreign key `competenceId` to refer to the [Competence].
  Future<void> competence(
    _i1.Session session,
    CompetenceGoal competenceGoal,
    _i3.Competence competence, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceGoal.id == null) {
      throw ArgumentError.notNull('competenceGoal.id');
    }
    if (competence.id == null) {
      throw ArgumentError.notNull('competence.id');
    }

    var $competenceGoal = competenceGoal.copyWith(competenceId: competence.id);
    await session.db.updateRow<CompetenceGoal>(
      $competenceGoal,
      columns: [CompetenceGoal.t.competenceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [CompetenceGoal] and the given [HubDocument]
  /// by setting the [HubDocument]'s foreign key `_competenceGoalDocumentsCompetenceGoalId` to refer to this [CompetenceGoal].
  Future<void> documents(
    _i1.Session session,
    CompetenceGoal competenceGoal,
    _i4.HubDocument hubDocument, {
    _i1.Transaction? transaction,
  }) async {
    if (hubDocument.id == null) {
      throw ArgumentError.notNull('hubDocument.id');
    }
    if (competenceGoal.id == null) {
      throw ArgumentError.notNull('competenceGoal.id');
    }

    var $hubDocument = _i4.HubDocumentImplicit(
      hubDocument,
      $_competenceGoalDocumentsCompetenceGoalId: competenceGoal.id,
    );
    await session.db.updateRow<_i4.HubDocument>(
      $hubDocument,
      columns: [_i4.HubDocument.t.$_competenceGoalDocumentsCompetenceGoalId],
      transaction: transaction,
    );
  }
}

class CompetenceGoalDetachRepository {
  const CompetenceGoalDetachRepository._();

  /// Detaches the relation between this [CompetenceGoal] and the given [HubDocument]
  /// by setting the [HubDocument]'s foreign key `_competenceGoalDocumentsCompetenceGoalId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> documents(
    _i1.Session session,
    List<_i4.HubDocument> hubDocument, {
    _i1.Transaction? transaction,
  }) async {
    if (hubDocument.any((e) => e.id == null)) {
      throw ArgumentError.notNull('hubDocument.id');
    }

    var $hubDocument = hubDocument
        .map((e) => _i4.HubDocumentImplicit(
              e,
              $_competenceGoalDocumentsCompetenceGoalId: null,
            ))
        .toList();
    await session.db.update<_i4.HubDocument>(
      $hubDocument,
      columns: [_i4.HubDocument.t.$_competenceGoalDocumentsCompetenceGoalId],
      transaction: transaction,
    );
  }
}

class CompetenceGoalDetachRowRepository {
  const CompetenceGoalDetachRowRepository._();

  /// Detaches the relation between this [CompetenceGoal] and the given [HubDocument]
  /// by setting the [HubDocument]'s foreign key `_competenceGoalDocumentsCompetenceGoalId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> documents(
    _i1.Session session,
    _i4.HubDocument hubDocument, {
    _i1.Transaction? transaction,
  }) async {
    if (hubDocument.id == null) {
      throw ArgumentError.notNull('hubDocument.id');
    }

    var $hubDocument = _i4.HubDocumentImplicit(
      hubDocument,
      $_competenceGoalDocumentsCompetenceGoalId: null,
    );
    await session.db.updateRow<_i4.HubDocument>(
      $hubDocument,
      columns: [_i4.HubDocument.t.$_competenceGoalDocumentsCompetenceGoalId],
      transaction: transaction,
    );
  }
}

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
import '../learning/competence_check_file.dart' as _i4;

abstract class CompetenceCheck
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  CompetenceCheck._({
    this.id,
    required this.publicId,
    required this.achievement,
    required this.comment,
    required this.createdBy,
    required this.createdAt,
    required this.valueFactor,
    required this.groupCheckId,
    required this.groupCheckName,
    required this.pupilId,
    this.pupil,
    required this.competenceId,
    this.competence,
    this.competenceCheckFiles,
  });

  factory CompetenceCheck({
    int? id,
    required String publicId,
    required String achievement,
    required String comment,
    required String createdBy,
    required DateTime createdAt,
    required double valueFactor,
    required String groupCheckId,
    required String groupCheckName,
    required int pupilId,
    _i2.PupilData? pupil,
    required int competenceId,
    _i3.Competence? competence,
    List<_i4.CompetenceCheckFile>? competenceCheckFiles,
  }) = _CompetenceCheckImpl;

  factory CompetenceCheck.fromJson(Map<String, dynamic> jsonSerialization) {
    return CompetenceCheck(
      id: jsonSerialization['id'] as int?,
      publicId: jsonSerialization['publicId'] as String,
      achievement: jsonSerialization['achievement'] as String,
      comment: jsonSerialization['comment'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      valueFactor: (jsonSerialization['valueFactor'] as num).toDouble(),
      groupCheckId: jsonSerialization['groupCheckId'] as String,
      groupCheckName: jsonSerialization['groupCheckName'] as String,
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
      competenceCheckFiles: (jsonSerialization['competenceCheckFiles'] as List?)
          ?.map((e) =>
              _i4.CompetenceCheckFile.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = CompetenceCheckTable();

  static const db = CompetenceCheckRepository._();

  @override
  int? id;

  String publicId;

  String achievement;

  String comment;

  String createdBy;

  DateTime createdAt;

  double valueFactor;

  String groupCheckId;

  String groupCheckName;

  int pupilId;

  _i2.PupilData? pupil;

  int competenceId;

  _i3.Competence? competence;

  List<_i4.CompetenceCheckFile>? competenceCheckFiles;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [CompetenceCheck]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CompetenceCheck copyWith({
    int? id,
    String? publicId,
    String? achievement,
    String? comment,
    String? createdBy,
    DateTime? createdAt,
    double? valueFactor,
    String? groupCheckId,
    String? groupCheckName,
    int? pupilId,
    _i2.PupilData? pupil,
    int? competenceId,
    _i3.Competence? competence,
    List<_i4.CompetenceCheckFile>? competenceCheckFiles,
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
      'valueFactor': valueFactor,
      'groupCheckId': groupCheckId,
      'groupCheckName': groupCheckName,
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
      'competenceId': competenceId,
      if (competence != null) 'competence': competence?.toJson(),
      if (competenceCheckFiles != null)
        'competenceCheckFiles':
            competenceCheckFiles?.toJson(valueToJson: (v) => v.toJson()),
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
      'valueFactor': valueFactor,
      'groupCheckId': groupCheckId,
      'groupCheckName': groupCheckName,
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJsonForProtocol(),
      'competenceId': competenceId,
      if (competence != null) 'competence': competence?.toJsonForProtocol(),
      if (competenceCheckFiles != null)
        'competenceCheckFiles': competenceCheckFiles?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static CompetenceCheckInclude include({
    _i2.PupilDataInclude? pupil,
    _i3.CompetenceInclude? competence,
    _i4.CompetenceCheckFileIncludeList? competenceCheckFiles,
  }) {
    return CompetenceCheckInclude._(
      pupil: pupil,
      competence: competence,
      competenceCheckFiles: competenceCheckFiles,
    );
  }

  static CompetenceCheckIncludeList includeList({
    _i1.WhereExpressionBuilder<CompetenceCheckTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CompetenceCheckTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompetenceCheckTable>? orderByList,
    CompetenceCheckInclude? include,
  }) {
    return CompetenceCheckIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CompetenceCheck.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CompetenceCheck.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompetenceCheckImpl extends CompetenceCheck {
  _CompetenceCheckImpl({
    int? id,
    required String publicId,
    required String achievement,
    required String comment,
    required String createdBy,
    required DateTime createdAt,
    required double valueFactor,
    required String groupCheckId,
    required String groupCheckName,
    required int pupilId,
    _i2.PupilData? pupil,
    required int competenceId,
    _i3.Competence? competence,
    List<_i4.CompetenceCheckFile>? competenceCheckFiles,
  }) : super._(
          id: id,
          publicId: publicId,
          achievement: achievement,
          comment: comment,
          createdBy: createdBy,
          createdAt: createdAt,
          valueFactor: valueFactor,
          groupCheckId: groupCheckId,
          groupCheckName: groupCheckName,
          pupilId: pupilId,
          pupil: pupil,
          competenceId: competenceId,
          competence: competence,
          competenceCheckFiles: competenceCheckFiles,
        );

  /// Returns a shallow copy of this [CompetenceCheck]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CompetenceCheck copyWith({
    Object? id = _Undefined,
    String? publicId,
    String? achievement,
    String? comment,
    String? createdBy,
    DateTime? createdAt,
    double? valueFactor,
    String? groupCheckId,
    String? groupCheckName,
    int? pupilId,
    Object? pupil = _Undefined,
    int? competenceId,
    Object? competence = _Undefined,
    Object? competenceCheckFiles = _Undefined,
  }) {
    return CompetenceCheck(
      id: id is int? ? id : this.id,
      publicId: publicId ?? this.publicId,
      achievement: achievement ?? this.achievement,
      comment: comment ?? this.comment,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      valueFactor: valueFactor ?? this.valueFactor,
      groupCheckId: groupCheckId ?? this.groupCheckId,
      groupCheckName: groupCheckName ?? this.groupCheckName,
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i2.PupilData? ? pupil : this.pupil?.copyWith(),
      competenceId: competenceId ?? this.competenceId,
      competence: competence is _i3.Competence?
          ? competence
          : this.competence?.copyWith(),
      competenceCheckFiles:
          competenceCheckFiles is List<_i4.CompetenceCheckFile>?
              ? competenceCheckFiles
              : this.competenceCheckFiles?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class CompetenceCheckTable extends _i1.Table<int> {
  CompetenceCheckTable({super.tableRelation})
      : super(tableName: 'competence_check') {
    publicId = _i1.ColumnString(
      'publicId',
      this,
    );
    achievement = _i1.ColumnString(
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
    valueFactor = _i1.ColumnDouble(
      'valueFactor',
      this,
    );
    groupCheckId = _i1.ColumnString(
      'groupCheckId',
      this,
    );
    groupCheckName = _i1.ColumnString(
      'groupCheckName',
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

  late final _i1.ColumnString achievement;

  late final _i1.ColumnString comment;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDouble valueFactor;

  late final _i1.ColumnString groupCheckId;

  late final _i1.ColumnString groupCheckName;

  late final _i1.ColumnInt pupilId;

  _i2.PupilDataTable? _pupil;

  late final _i1.ColumnInt competenceId;

  _i3.CompetenceTable? _competence;

  _i4.CompetenceCheckFileTable? ___competenceCheckFiles;

  _i1.ManyRelation<_i4.CompetenceCheckFileTable>? _competenceCheckFiles;

  _i2.PupilDataTable get pupil {
    if (_pupil != null) return _pupil!;
    _pupil = _i1.createRelationTable(
      relationFieldName: 'pupil',
      field: CompetenceCheck.t.pupilId,
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
      field: CompetenceCheck.t.competenceId,
      foreignField: _i3.Competence.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CompetenceTable(tableRelation: foreignTableRelation),
    );
    return _competence!;
  }

  _i4.CompetenceCheckFileTable get __competenceCheckFiles {
    if (___competenceCheckFiles != null) return ___competenceCheckFiles!;
    ___competenceCheckFiles = _i1.createRelationTable(
      relationFieldName: '__competenceCheckFiles',
      field: CompetenceCheck.t.id,
      foreignField: _i4.CompetenceCheckFile.t.competenceCheckId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.CompetenceCheckFileTable(tableRelation: foreignTableRelation),
    );
    return ___competenceCheckFiles!;
  }

  _i1.ManyRelation<_i4.CompetenceCheckFileTable> get competenceCheckFiles {
    if (_competenceCheckFiles != null) return _competenceCheckFiles!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'competenceCheckFiles',
      field: CompetenceCheck.t.id,
      foreignField: _i4.CompetenceCheckFile.t.competenceCheckId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.CompetenceCheckFileTable(tableRelation: foreignTableRelation),
    );
    _competenceCheckFiles = _i1.ManyRelation<_i4.CompetenceCheckFileTable>(
      tableWithRelations: relationTable,
      table: _i4.CompetenceCheckFileTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _competenceCheckFiles!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        publicId,
        achievement,
        comment,
        createdBy,
        createdAt,
        valueFactor,
        groupCheckId,
        groupCheckName,
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
    if (relationField == 'competenceCheckFiles') {
      return __competenceCheckFiles;
    }
    return null;
  }
}

class CompetenceCheckInclude extends _i1.IncludeObject {
  CompetenceCheckInclude._({
    _i2.PupilDataInclude? pupil,
    _i3.CompetenceInclude? competence,
    _i4.CompetenceCheckFileIncludeList? competenceCheckFiles,
  }) {
    _pupil = pupil;
    _competence = competence;
    _competenceCheckFiles = competenceCheckFiles;
  }

  _i2.PupilDataInclude? _pupil;

  _i3.CompetenceInclude? _competence;

  _i4.CompetenceCheckFileIncludeList? _competenceCheckFiles;

  @override
  Map<String, _i1.Include?> get includes => {
        'pupil': _pupil,
        'competence': _competence,
        'competenceCheckFiles': _competenceCheckFiles,
      };

  @override
  _i1.Table<int> get table => CompetenceCheck.t;
}

class CompetenceCheckIncludeList extends _i1.IncludeList {
  CompetenceCheckIncludeList._({
    _i1.WhereExpressionBuilder<CompetenceCheckTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CompetenceCheck.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => CompetenceCheck.t;
}

class CompetenceCheckRepository {
  const CompetenceCheckRepository._();

  final attach = const CompetenceCheckAttachRepository._();

  final attachRow = const CompetenceCheckAttachRowRepository._();

  final detach = const CompetenceCheckDetachRepository._();

  final detachRow = const CompetenceCheckDetachRowRepository._();

  /// Returns a list of [CompetenceCheck]s matching the given query parameters.
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
  Future<List<CompetenceCheck>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompetenceCheckTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CompetenceCheckTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompetenceCheckTable>? orderByList,
    _i1.Transaction? transaction,
    CompetenceCheckInclude? include,
  }) async {
    return session.db.find<CompetenceCheck>(
      where: where?.call(CompetenceCheck.t),
      orderBy: orderBy?.call(CompetenceCheck.t),
      orderByList: orderByList?.call(CompetenceCheck.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [CompetenceCheck] matching the given query parameters.
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
  Future<CompetenceCheck?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompetenceCheckTable>? where,
    int? offset,
    _i1.OrderByBuilder<CompetenceCheckTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompetenceCheckTable>? orderByList,
    _i1.Transaction? transaction,
    CompetenceCheckInclude? include,
  }) async {
    return session.db.findFirstRow<CompetenceCheck>(
      where: where?.call(CompetenceCheck.t),
      orderBy: orderBy?.call(CompetenceCheck.t),
      orderByList: orderByList?.call(CompetenceCheck.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [CompetenceCheck] by its [id] or null if no such row exists.
  Future<CompetenceCheck?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CompetenceCheckInclude? include,
  }) async {
    return session.db.findById<CompetenceCheck>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [CompetenceCheck]s in the list and returns the inserted rows.
  ///
  /// The returned [CompetenceCheck]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CompetenceCheck>> insert(
    _i1.Session session,
    List<CompetenceCheck> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CompetenceCheck>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CompetenceCheck] and returns the inserted row.
  ///
  /// The returned [CompetenceCheck] will have its `id` field set.
  Future<CompetenceCheck> insertRow(
    _i1.Session session,
    CompetenceCheck row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CompetenceCheck>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CompetenceCheck]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CompetenceCheck>> update(
    _i1.Session session,
    List<CompetenceCheck> rows, {
    _i1.ColumnSelections<CompetenceCheckTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CompetenceCheck>(
      rows,
      columns: columns?.call(CompetenceCheck.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CompetenceCheck]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CompetenceCheck> updateRow(
    _i1.Session session,
    CompetenceCheck row, {
    _i1.ColumnSelections<CompetenceCheckTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CompetenceCheck>(
      row,
      columns: columns?.call(CompetenceCheck.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CompetenceCheck]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CompetenceCheck>> delete(
    _i1.Session session,
    List<CompetenceCheck> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CompetenceCheck>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CompetenceCheck].
  Future<CompetenceCheck> deleteRow(
    _i1.Session session,
    CompetenceCheck row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CompetenceCheck>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CompetenceCheck>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CompetenceCheckTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CompetenceCheck>(
      where: where(CompetenceCheck.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompetenceCheckTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CompetenceCheck>(
      where: where?.call(CompetenceCheck.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class CompetenceCheckAttachRepository {
  const CompetenceCheckAttachRepository._();

  /// Creates a relation between this [CompetenceCheck] and the given [CompetenceCheckFile]s
  /// by setting each [CompetenceCheckFile]'s foreign key `competenceCheckId` to refer to this [CompetenceCheck].
  Future<void> competenceCheckFiles(
    _i1.Session session,
    CompetenceCheck competenceCheck,
    List<_i4.CompetenceCheckFile> competenceCheckFile, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceCheckFile.any((e) => e.id == null)) {
      throw ArgumentError.notNull('competenceCheckFile.id');
    }
    if (competenceCheck.id == null) {
      throw ArgumentError.notNull('competenceCheck.id');
    }

    var $competenceCheckFile = competenceCheckFile
        .map((e) => e.copyWith(competenceCheckId: competenceCheck.id))
        .toList();
    await session.db.update<_i4.CompetenceCheckFile>(
      $competenceCheckFile,
      columns: [_i4.CompetenceCheckFile.t.competenceCheckId],
      transaction: transaction,
    );
  }
}

class CompetenceCheckAttachRowRepository {
  const CompetenceCheckAttachRowRepository._();

  /// Creates a relation between the given [CompetenceCheck] and [PupilData]
  /// by setting the [CompetenceCheck]'s foreign key `pupilId` to refer to the [PupilData].
  Future<void> pupil(
    _i1.Session session,
    CompetenceCheck competenceCheck,
    _i2.PupilData pupil, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceCheck.id == null) {
      throw ArgumentError.notNull('competenceCheck.id');
    }
    if (pupil.id == null) {
      throw ArgumentError.notNull('pupil.id');
    }

    var $competenceCheck = competenceCheck.copyWith(pupilId: pupil.id);
    await session.db.updateRow<CompetenceCheck>(
      $competenceCheck,
      columns: [CompetenceCheck.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CompetenceCheck] and [Competence]
  /// by setting the [CompetenceCheck]'s foreign key `competenceId` to refer to the [Competence].
  Future<void> competence(
    _i1.Session session,
    CompetenceCheck competenceCheck,
    _i3.Competence competence, {
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
    await session.db.updateRow<CompetenceCheck>(
      $competenceCheck,
      columns: [CompetenceCheck.t.competenceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [CompetenceCheck] and the given [CompetenceCheckFile]
  /// by setting the [CompetenceCheckFile]'s foreign key `competenceCheckId` to refer to this [CompetenceCheck].
  Future<void> competenceCheckFiles(
    _i1.Session session,
    CompetenceCheck competenceCheck,
    _i4.CompetenceCheckFile competenceCheckFile, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceCheckFile.id == null) {
      throw ArgumentError.notNull('competenceCheckFile.id');
    }
    if (competenceCheck.id == null) {
      throw ArgumentError.notNull('competenceCheck.id');
    }

    var $competenceCheckFile =
        competenceCheckFile.copyWith(competenceCheckId: competenceCheck.id);
    await session.db.updateRow<_i4.CompetenceCheckFile>(
      $competenceCheckFile,
      columns: [_i4.CompetenceCheckFile.t.competenceCheckId],
      transaction: transaction,
    );
  }
}

class CompetenceCheckDetachRepository {
  const CompetenceCheckDetachRepository._();

  /// Detaches the relation between this [CompetenceCheck] and the given [CompetenceCheckFile]
  /// by setting the [CompetenceCheckFile]'s foreign key `competenceCheckId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> competenceCheckFiles(
    _i1.Session session,
    List<_i4.CompetenceCheckFile> competenceCheckFile, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceCheckFile.any((e) => e.id == null)) {
      throw ArgumentError.notNull('competenceCheckFile.id');
    }

    var $competenceCheckFile = competenceCheckFile
        .map((e) => e.copyWith(competenceCheckId: null))
        .toList();
    await session.db.update<_i4.CompetenceCheckFile>(
      $competenceCheckFile,
      columns: [_i4.CompetenceCheckFile.t.competenceCheckId],
      transaction: transaction,
    );
  }
}

class CompetenceCheckDetachRowRepository {
  const CompetenceCheckDetachRowRepository._();

  /// Detaches the relation between this [CompetenceCheck] and the given [CompetenceCheckFile]
  /// by setting the [CompetenceCheckFile]'s foreign key `competenceCheckId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> competenceCheckFiles(
    _i1.Session session,
    _i4.CompetenceCheckFile competenceCheckFile, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceCheckFile.id == null) {
      throw ArgumentError.notNull('competenceCheckFile.id');
    }

    var $competenceCheckFile =
        competenceCheckFile.copyWith(competenceCheckId: null);
    await session.db.updateRow<_i4.CompetenceCheckFile>(
      $competenceCheckFile,
      columns: [_i4.CompetenceCheckFile.t.competenceCheckId],
      transaction: transaction,
    );
  }
}

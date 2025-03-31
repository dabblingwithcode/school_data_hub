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
import '../learning/competence_check.dart' as _i2;

abstract class CompetenceCheckFile
    implements _i1.TableRow, _i1.ProtocolSerialization {
  CompetenceCheckFile._({
    this.id,
    required this.fileId,
    required this.fileUrl,
    required this.fileExtension,
    required this.uploadedAt,
    required this.uploadedBy,
    required this.competenceCheckId,
    this.competenceCheck,
  });

  factory CompetenceCheckFile({
    int? id,
    required String fileId,
    required String fileUrl,
    required String fileExtension,
    required DateTime uploadedAt,
    required String uploadedBy,
    required int competenceCheckId,
    _i2.CompetenceCheck? competenceCheck,
  }) = _CompetenceCheckFileImpl;

  factory CompetenceCheckFile.fromJson(Map<String, dynamic> jsonSerialization) {
    return CompetenceCheckFile(
      id: jsonSerialization['id'] as int?,
      fileId: jsonSerialization['fileId'] as String,
      fileUrl: jsonSerialization['fileUrl'] as String,
      fileExtension: jsonSerialization['fileExtension'] as String,
      uploadedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['uploadedAt']),
      uploadedBy: jsonSerialization['uploadedBy'] as String,
      competenceCheckId: jsonSerialization['competenceCheckId'] as int,
      competenceCheck: jsonSerialization['competenceCheck'] == null
          ? null
          : _i2.CompetenceCheck.fromJson(
              (jsonSerialization['competenceCheck'] as Map<String, dynamic>)),
    );
  }

  static final t = CompetenceCheckFileTable();

  static const db = CompetenceCheckFileRepository._();

  @override
  int? id;

  String fileId;

  String fileUrl;

  String fileExtension;

  DateTime uploadedAt;

  String uploadedBy;

  int competenceCheckId;

  _i2.CompetenceCheck? competenceCheck;

  @override
  _i1.Table get table => t;

  /// Returns a shallow copy of this [CompetenceCheckFile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CompetenceCheckFile copyWith({
    int? id,
    String? fileId,
    String? fileUrl,
    String? fileExtension,
    DateTime? uploadedAt,
    String? uploadedBy,
    int? competenceCheckId,
    _i2.CompetenceCheck? competenceCheck,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'fileId': fileId,
      'fileUrl': fileUrl,
      'fileExtension': fileExtension,
      'uploadedAt': uploadedAt.toJson(),
      'uploadedBy': uploadedBy,
      'competenceCheckId': competenceCheckId,
      if (competenceCheck != null) 'competenceCheck': competenceCheck?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'fileId': fileId,
      'fileUrl': fileUrl,
      'fileExtension': fileExtension,
      'uploadedAt': uploadedAt.toJson(),
      'uploadedBy': uploadedBy,
      'competenceCheckId': competenceCheckId,
      if (competenceCheck != null)
        'competenceCheck': competenceCheck?.toJsonForProtocol(),
    };
  }

  static CompetenceCheckFileInclude include(
      {_i2.CompetenceCheckInclude? competenceCheck}) {
    return CompetenceCheckFileInclude._(competenceCheck: competenceCheck);
  }

  static CompetenceCheckFileIncludeList includeList({
    _i1.WhereExpressionBuilder<CompetenceCheckFileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CompetenceCheckFileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompetenceCheckFileTable>? orderByList,
    CompetenceCheckFileInclude? include,
  }) {
    return CompetenceCheckFileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CompetenceCheckFile.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CompetenceCheckFile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompetenceCheckFileImpl extends CompetenceCheckFile {
  _CompetenceCheckFileImpl({
    int? id,
    required String fileId,
    required String fileUrl,
    required String fileExtension,
    required DateTime uploadedAt,
    required String uploadedBy,
    required int competenceCheckId,
    _i2.CompetenceCheck? competenceCheck,
  }) : super._(
          id: id,
          fileId: fileId,
          fileUrl: fileUrl,
          fileExtension: fileExtension,
          uploadedAt: uploadedAt,
          uploadedBy: uploadedBy,
          competenceCheckId: competenceCheckId,
          competenceCheck: competenceCheck,
        );

  /// Returns a shallow copy of this [CompetenceCheckFile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CompetenceCheckFile copyWith({
    Object? id = _Undefined,
    String? fileId,
    String? fileUrl,
    String? fileExtension,
    DateTime? uploadedAt,
    String? uploadedBy,
    int? competenceCheckId,
    Object? competenceCheck = _Undefined,
  }) {
    return CompetenceCheckFile(
      id: id is int? ? id : this.id,
      fileId: fileId ?? this.fileId,
      fileUrl: fileUrl ?? this.fileUrl,
      fileExtension: fileExtension ?? this.fileExtension,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      uploadedBy: uploadedBy ?? this.uploadedBy,
      competenceCheckId: competenceCheckId ?? this.competenceCheckId,
      competenceCheck: competenceCheck is _i2.CompetenceCheck?
          ? competenceCheck
          : this.competenceCheck?.copyWith(),
    );
  }
}

class CompetenceCheckFileTable extends _i1.Table {
  CompetenceCheckFileTable({super.tableRelation})
      : super(tableName: 'competence_check_file') {
    fileId = _i1.ColumnString(
      'fileId',
      this,
    );
    fileUrl = _i1.ColumnString(
      'fileUrl',
      this,
    );
    fileExtension = _i1.ColumnString(
      'fileExtension',
      this,
    );
    uploadedAt = _i1.ColumnDateTime(
      'uploadedAt',
      this,
    );
    uploadedBy = _i1.ColumnString(
      'uploadedBy',
      this,
    );
    competenceCheckId = _i1.ColumnInt(
      'competenceCheckId',
      this,
    );
  }

  late final _i1.ColumnString fileId;

  late final _i1.ColumnString fileUrl;

  late final _i1.ColumnString fileExtension;

  late final _i1.ColumnDateTime uploadedAt;

  late final _i1.ColumnString uploadedBy;

  late final _i1.ColumnInt competenceCheckId;

  _i2.CompetenceCheckTable? _competenceCheck;

  _i2.CompetenceCheckTable get competenceCheck {
    if (_competenceCheck != null) return _competenceCheck!;
    _competenceCheck = _i1.createRelationTable(
      relationFieldName: 'competenceCheck',
      field: CompetenceCheckFile.t.competenceCheckId,
      foreignField: _i2.CompetenceCheck.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CompetenceCheckTable(tableRelation: foreignTableRelation),
    );
    return _competenceCheck!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        fileId,
        fileUrl,
        fileExtension,
        uploadedAt,
        uploadedBy,
        competenceCheckId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'competenceCheck') {
      return competenceCheck;
    }
    return null;
  }
}

class CompetenceCheckFileInclude extends _i1.IncludeObject {
  CompetenceCheckFileInclude._({_i2.CompetenceCheckInclude? competenceCheck}) {
    _competenceCheck = competenceCheck;
  }

  _i2.CompetenceCheckInclude? _competenceCheck;

  @override
  Map<String, _i1.Include?> get includes =>
      {'competenceCheck': _competenceCheck};

  @override
  _i1.Table get table => CompetenceCheckFile.t;
}

class CompetenceCheckFileIncludeList extends _i1.IncludeList {
  CompetenceCheckFileIncludeList._({
    _i1.WhereExpressionBuilder<CompetenceCheckFileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CompetenceCheckFile.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => CompetenceCheckFile.t;
}

class CompetenceCheckFileRepository {
  const CompetenceCheckFileRepository._();

  final attachRow = const CompetenceCheckFileAttachRowRepository._();

  /// Returns a list of [CompetenceCheckFile]s matching the given query parameters.
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
  Future<List<CompetenceCheckFile>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompetenceCheckFileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CompetenceCheckFileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompetenceCheckFileTable>? orderByList,
    _i1.Transaction? transaction,
    CompetenceCheckFileInclude? include,
  }) async {
    return session.db.find<CompetenceCheckFile>(
      where: where?.call(CompetenceCheckFile.t),
      orderBy: orderBy?.call(CompetenceCheckFile.t),
      orderByList: orderByList?.call(CompetenceCheckFile.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [CompetenceCheckFile] matching the given query parameters.
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
  Future<CompetenceCheckFile?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompetenceCheckFileTable>? where,
    int? offset,
    _i1.OrderByBuilder<CompetenceCheckFileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompetenceCheckFileTable>? orderByList,
    _i1.Transaction? transaction,
    CompetenceCheckFileInclude? include,
  }) async {
    return session.db.findFirstRow<CompetenceCheckFile>(
      where: where?.call(CompetenceCheckFile.t),
      orderBy: orderBy?.call(CompetenceCheckFile.t),
      orderByList: orderByList?.call(CompetenceCheckFile.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [CompetenceCheckFile] by its [id] or null if no such row exists.
  Future<CompetenceCheckFile?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CompetenceCheckFileInclude? include,
  }) async {
    return session.db.findById<CompetenceCheckFile>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [CompetenceCheckFile]s in the list and returns the inserted rows.
  ///
  /// The returned [CompetenceCheckFile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CompetenceCheckFile>> insert(
    _i1.Session session,
    List<CompetenceCheckFile> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CompetenceCheckFile>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CompetenceCheckFile] and returns the inserted row.
  ///
  /// The returned [CompetenceCheckFile] will have its `id` field set.
  Future<CompetenceCheckFile> insertRow(
    _i1.Session session,
    CompetenceCheckFile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CompetenceCheckFile>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CompetenceCheckFile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CompetenceCheckFile>> update(
    _i1.Session session,
    List<CompetenceCheckFile> rows, {
    _i1.ColumnSelections<CompetenceCheckFileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CompetenceCheckFile>(
      rows,
      columns: columns?.call(CompetenceCheckFile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CompetenceCheckFile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CompetenceCheckFile> updateRow(
    _i1.Session session,
    CompetenceCheckFile row, {
    _i1.ColumnSelections<CompetenceCheckFileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CompetenceCheckFile>(
      row,
      columns: columns?.call(CompetenceCheckFile.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CompetenceCheckFile]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CompetenceCheckFile>> delete(
    _i1.Session session,
    List<CompetenceCheckFile> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CompetenceCheckFile>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CompetenceCheckFile].
  Future<CompetenceCheckFile> deleteRow(
    _i1.Session session,
    CompetenceCheckFile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CompetenceCheckFile>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CompetenceCheckFile>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CompetenceCheckFileTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CompetenceCheckFile>(
      where: where(CompetenceCheckFile.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompetenceCheckFileTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CompetenceCheckFile>(
      where: where?.call(CompetenceCheckFile.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class CompetenceCheckFileAttachRowRepository {
  const CompetenceCheckFileAttachRowRepository._();

  /// Creates a relation between the given [CompetenceCheckFile] and [CompetenceCheck]
  /// by setting the [CompetenceCheckFile]'s foreign key `competenceCheckId` to refer to the [CompetenceCheck].
  Future<void> competenceCheck(
    _i1.Session session,
    CompetenceCheckFile competenceCheckFile,
    _i2.CompetenceCheck competenceCheck, {
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
    await session.db.updateRow<CompetenceCheckFile>(
      $competenceCheckFile,
      columns: [CompetenceCheckFile.t.competenceCheckId],
      transaction: transaction,
    );
  }
}

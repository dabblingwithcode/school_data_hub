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
import '../book/pupil_book_lending.dart' as _i2;

abstract class PupilBookLendingFile
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PupilBookLendingFile._({
    this.id,
    required this.fileId,
    required this.fileUrl,
    required this.fileExtension,
    required this.uploadedAt,
    required this.uploadedBy,
    required this.lendingId,
    this.lending,
  });

  factory PupilBookLendingFile({
    int? id,
    required String fileId,
    required String fileUrl,
    required String fileExtension,
    required DateTime uploadedAt,
    required String uploadedBy,
    required int lendingId,
    _i2.PupilBookLending? lending,
  }) = _PupilBookLendingFileImpl;

  factory PupilBookLendingFile.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return PupilBookLendingFile(
      id: jsonSerialization['id'] as int?,
      fileId: jsonSerialization['fileId'] as String,
      fileUrl: jsonSerialization['fileUrl'] as String,
      fileExtension: jsonSerialization['fileExtension'] as String,
      uploadedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['uploadedAt']),
      uploadedBy: jsonSerialization['uploadedBy'] as String,
      lendingId: jsonSerialization['lendingId'] as int,
      lending: jsonSerialization['lending'] == null
          ? null
          : _i2.PupilBookLending.fromJson(
              (jsonSerialization['lending'] as Map<String, dynamic>)),
    );
  }

  static final t = PupilBookLendingFileTable();

  static const db = PupilBookLendingFileRepository._();

  @override
  int? id;

  String fileId;

  String fileUrl;

  String fileExtension;

  DateTime uploadedAt;

  String uploadedBy;

  int lendingId;

  _i2.PupilBookLending? lending;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PupilBookLendingFile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilBookLendingFile copyWith({
    int? id,
    String? fileId,
    String? fileUrl,
    String? fileExtension,
    DateTime? uploadedAt,
    String? uploadedBy,
    int? lendingId,
    _i2.PupilBookLending? lending,
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
      'lendingId': lendingId,
      if (lending != null) 'lending': lending?.toJson(),
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
      'lendingId': lendingId,
      if (lending != null) 'lending': lending?.toJsonForProtocol(),
    };
  }

  static PupilBookLendingFileInclude include(
      {_i2.PupilBookLendingInclude? lending}) {
    return PupilBookLendingFileInclude._(lending: lending);
  }

  static PupilBookLendingFileIncludeList includeList({
    _i1.WhereExpressionBuilder<PupilBookLendingFileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PupilBookLendingFileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilBookLendingFileTable>? orderByList,
    PupilBookLendingFileInclude? include,
  }) {
    return PupilBookLendingFileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PupilBookLendingFile.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PupilBookLendingFile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PupilBookLendingFileImpl extends PupilBookLendingFile {
  _PupilBookLendingFileImpl({
    int? id,
    required String fileId,
    required String fileUrl,
    required String fileExtension,
    required DateTime uploadedAt,
    required String uploadedBy,
    required int lendingId,
    _i2.PupilBookLending? lending,
  }) : super._(
          id: id,
          fileId: fileId,
          fileUrl: fileUrl,
          fileExtension: fileExtension,
          uploadedAt: uploadedAt,
          uploadedBy: uploadedBy,
          lendingId: lendingId,
          lending: lending,
        );

  /// Returns a shallow copy of this [PupilBookLendingFile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilBookLendingFile copyWith({
    Object? id = _Undefined,
    String? fileId,
    String? fileUrl,
    String? fileExtension,
    DateTime? uploadedAt,
    String? uploadedBy,
    int? lendingId,
    Object? lending = _Undefined,
  }) {
    return PupilBookLendingFile(
      id: id is int? ? id : this.id,
      fileId: fileId ?? this.fileId,
      fileUrl: fileUrl ?? this.fileUrl,
      fileExtension: fileExtension ?? this.fileExtension,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      uploadedBy: uploadedBy ?? this.uploadedBy,
      lendingId: lendingId ?? this.lendingId,
      lending:
          lending is _i2.PupilBookLending? ? lending : this.lending?.copyWith(),
    );
  }
}

class PupilBookLendingFileTable extends _i1.Table<int?> {
  PupilBookLendingFileTable({super.tableRelation})
      : super(tableName: 'pupil_book_lending_file') {
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
    lendingId = _i1.ColumnInt(
      'lendingId',
      this,
    );
  }

  late final _i1.ColumnString fileId;

  late final _i1.ColumnString fileUrl;

  late final _i1.ColumnString fileExtension;

  late final _i1.ColumnDateTime uploadedAt;

  late final _i1.ColumnString uploadedBy;

  late final _i1.ColumnInt lendingId;

  _i2.PupilBookLendingTable? _lending;

  _i2.PupilBookLendingTable get lending {
    if (_lending != null) return _lending!;
    _lending = _i1.createRelationTable(
      relationFieldName: 'lending',
      field: PupilBookLendingFile.t.lendingId,
      foreignField: _i2.PupilBookLending.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PupilBookLendingTable(tableRelation: foreignTableRelation),
    );
    return _lending!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        fileId,
        fileUrl,
        fileExtension,
        uploadedAt,
        uploadedBy,
        lendingId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'lending') {
      return lending;
    }
    return null;
  }
}

class PupilBookLendingFileInclude extends _i1.IncludeObject {
  PupilBookLendingFileInclude._({_i2.PupilBookLendingInclude? lending}) {
    _lending = lending;
  }

  _i2.PupilBookLendingInclude? _lending;

  @override
  Map<String, _i1.Include?> get includes => {'lending': _lending};

  @override
  _i1.Table<int?> get table => PupilBookLendingFile.t;
}

class PupilBookLendingFileIncludeList extends _i1.IncludeList {
  PupilBookLendingFileIncludeList._({
    _i1.WhereExpressionBuilder<PupilBookLendingFileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PupilBookLendingFile.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PupilBookLendingFile.t;
}

class PupilBookLendingFileRepository {
  const PupilBookLendingFileRepository._();

  final attachRow = const PupilBookLendingFileAttachRowRepository._();

  /// Returns a list of [PupilBookLendingFile]s matching the given query parameters.
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
  Future<List<PupilBookLendingFile>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilBookLendingFileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PupilBookLendingFileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilBookLendingFileTable>? orderByList,
    _i1.Transaction? transaction,
    PupilBookLendingFileInclude? include,
  }) async {
    return session.db.find<PupilBookLendingFile>(
      where: where?.call(PupilBookLendingFile.t),
      orderBy: orderBy?.call(PupilBookLendingFile.t),
      orderByList: orderByList?.call(PupilBookLendingFile.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [PupilBookLendingFile] matching the given query parameters.
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
  Future<PupilBookLendingFile?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilBookLendingFileTable>? where,
    int? offset,
    _i1.OrderByBuilder<PupilBookLendingFileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilBookLendingFileTable>? orderByList,
    _i1.Transaction? transaction,
    PupilBookLendingFileInclude? include,
  }) async {
    return session.db.findFirstRow<PupilBookLendingFile>(
      where: where?.call(PupilBookLendingFile.t),
      orderBy: orderBy?.call(PupilBookLendingFile.t),
      orderByList: orderByList?.call(PupilBookLendingFile.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [PupilBookLendingFile] by its [id] or null if no such row exists.
  Future<PupilBookLendingFile?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    PupilBookLendingFileInclude? include,
  }) async {
    return session.db.findById<PupilBookLendingFile>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [PupilBookLendingFile]s in the list and returns the inserted rows.
  ///
  /// The returned [PupilBookLendingFile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PupilBookLendingFile>> insert(
    _i1.Session session,
    List<PupilBookLendingFile> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PupilBookLendingFile>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PupilBookLendingFile] and returns the inserted row.
  ///
  /// The returned [PupilBookLendingFile] will have its `id` field set.
  Future<PupilBookLendingFile> insertRow(
    _i1.Session session,
    PupilBookLendingFile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PupilBookLendingFile>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PupilBookLendingFile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PupilBookLendingFile>> update(
    _i1.Session session,
    List<PupilBookLendingFile> rows, {
    _i1.ColumnSelections<PupilBookLendingFileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PupilBookLendingFile>(
      rows,
      columns: columns?.call(PupilBookLendingFile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PupilBookLendingFile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PupilBookLendingFile> updateRow(
    _i1.Session session,
    PupilBookLendingFile row, {
    _i1.ColumnSelections<PupilBookLendingFileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PupilBookLendingFile>(
      row,
      columns: columns?.call(PupilBookLendingFile.t),
      transaction: transaction,
    );
  }

  /// Deletes all [PupilBookLendingFile]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PupilBookLendingFile>> delete(
    _i1.Session session,
    List<PupilBookLendingFile> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PupilBookLendingFile>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PupilBookLendingFile].
  Future<PupilBookLendingFile> deleteRow(
    _i1.Session session,
    PupilBookLendingFile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PupilBookLendingFile>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PupilBookLendingFile>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PupilBookLendingFileTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PupilBookLendingFile>(
      where: where(PupilBookLendingFile.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilBookLendingFileTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PupilBookLendingFile>(
      where: where?.call(PupilBookLendingFile.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class PupilBookLendingFileAttachRowRepository {
  const PupilBookLendingFileAttachRowRepository._();

  /// Creates a relation between the given [PupilBookLendingFile] and [PupilBookLending]
  /// by setting the [PupilBookLendingFile]'s foreign key `lendingId` to refer to the [PupilBookLending].
  Future<void> lending(
    _i1.Session session,
    PupilBookLendingFile pupilBookLendingFile,
    _i2.PupilBookLending lending, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilBookLendingFile.id == null) {
      throw ArgumentError.notNull('pupilBookLendingFile.id');
    }
    if (lending.id == null) {
      throw ArgumentError.notNull('lending.id');
    }

    var $pupilBookLendingFile =
        pupilBookLendingFile.copyWith(lendingId: lending.id);
    await session.db.updateRow<PupilBookLendingFile>(
      $pupilBookLendingFile,
      columns: [PupilBookLendingFile.t.lendingId],
      transaction: transaction,
    );
  }
}

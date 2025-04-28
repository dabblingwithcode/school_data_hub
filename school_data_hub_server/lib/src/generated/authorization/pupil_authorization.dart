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
import '../authorization/authorization.dart' as _i2;
import '../pupil_data/pupil_data.dart' as _i3;

abstract class PupilAuthorization
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PupilAuthorization._({
    this.id,
    this.status,
    this.comment,
    this.createdBy,
    this.fileId,
    this.fileUrl,
    required this.authorizationId,
    this.authorization,
    required this.pupilId,
    this.pupil,
  });

  factory PupilAuthorization({
    int? id,
    bool? status,
    String? comment,
    String? createdBy,
    String? fileId,
    String? fileUrl,
    required int authorizationId,
    _i2.Authorization? authorization,
    required int pupilId,
    _i3.PupilData? pupil,
  }) = _PupilAuthorizationImpl;

  factory PupilAuthorization.fromJson(Map<String, dynamic> jsonSerialization) {
    return PupilAuthorization(
      id: jsonSerialization['id'] as int?,
      status: jsonSerialization['status'] as bool?,
      comment: jsonSerialization['comment'] as String?,
      createdBy: jsonSerialization['createdBy'] as String?,
      fileId: jsonSerialization['fileId'] as String?,
      fileUrl: jsonSerialization['fileUrl'] as String?,
      authorizationId: jsonSerialization['authorizationId'] as int,
      authorization: jsonSerialization['authorization'] == null
          ? null
          : _i2.Authorization.fromJson(
              (jsonSerialization['authorization'] as Map<String, dynamic>)),
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i3.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
    );
  }

  static final t = PupilAuthorizationTable();

  static const db = PupilAuthorizationRepository._();

  @override
  int? id;

  bool? status;

  String? comment;

  String? createdBy;

  String? fileId;

  String? fileUrl;

  int authorizationId;

  _i2.Authorization? authorization;

  int pupilId;

  _i3.PupilData? pupil;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PupilAuthorization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilAuthorization copyWith({
    int? id,
    bool? status,
    String? comment,
    String? createdBy,
    String? fileId,
    String? fileUrl,
    int? authorizationId,
    _i2.Authorization? authorization,
    int? pupilId,
    _i3.PupilData? pupil,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (status != null) 'status': status,
      if (comment != null) 'comment': comment,
      if (createdBy != null) 'createdBy': createdBy,
      if (fileId != null) 'fileId': fileId,
      if (fileUrl != null) 'fileUrl': fileUrl,
      'authorizationId': authorizationId,
      if (authorization != null) 'authorization': authorization?.toJson(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (status != null) 'status': status,
      if (comment != null) 'comment': comment,
      if (createdBy != null) 'createdBy': createdBy,
      if (fileId != null) 'fileId': fileId,
      if (fileUrl != null) 'fileUrl': fileUrl,
      'authorizationId': authorizationId,
      if (authorization != null)
        'authorization': authorization?.toJsonForProtocol(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJsonForProtocol(),
    };
  }

  static PupilAuthorizationInclude include({
    _i2.AuthorizationInclude? authorization,
    _i3.PupilDataInclude? pupil,
  }) {
    return PupilAuthorizationInclude._(
      authorization: authorization,
      pupil: pupil,
    );
  }

  static PupilAuthorizationIncludeList includeList({
    _i1.WhereExpressionBuilder<PupilAuthorizationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PupilAuthorizationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilAuthorizationTable>? orderByList,
    PupilAuthorizationInclude? include,
  }) {
    return PupilAuthorizationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PupilAuthorization.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PupilAuthorization.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PupilAuthorizationImpl extends PupilAuthorization {
  _PupilAuthorizationImpl({
    int? id,
    bool? status,
    String? comment,
    String? createdBy,
    String? fileId,
    String? fileUrl,
    required int authorizationId,
    _i2.Authorization? authorization,
    required int pupilId,
    _i3.PupilData? pupil,
  }) : super._(
          id: id,
          status: status,
          comment: comment,
          createdBy: createdBy,
          fileId: fileId,
          fileUrl: fileUrl,
          authorizationId: authorizationId,
          authorization: authorization,
          pupilId: pupilId,
          pupil: pupil,
        );

  /// Returns a shallow copy of this [PupilAuthorization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilAuthorization copyWith({
    Object? id = _Undefined,
    Object? status = _Undefined,
    Object? comment = _Undefined,
    Object? createdBy = _Undefined,
    Object? fileId = _Undefined,
    Object? fileUrl = _Undefined,
    int? authorizationId,
    Object? authorization = _Undefined,
    int? pupilId,
    Object? pupil = _Undefined,
  }) {
    return PupilAuthorization(
      id: id is int? ? id : this.id,
      status: status is bool? ? status : this.status,
      comment: comment is String? ? comment : this.comment,
      createdBy: createdBy is String? ? createdBy : this.createdBy,
      fileId: fileId is String? ? fileId : this.fileId,
      fileUrl: fileUrl is String? ? fileUrl : this.fileUrl,
      authorizationId: authorizationId ?? this.authorizationId,
      authorization: authorization is _i2.Authorization?
          ? authorization
          : this.authorization?.copyWith(),
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i3.PupilData? ? pupil : this.pupil?.copyWith(),
    );
  }
}

class PupilAuthorizationTable extends _i1.Table<int?> {
  PupilAuthorizationTable({super.tableRelation})
      : super(tableName: 'pupil_authorization') {
    status = _i1.ColumnBool(
      'status',
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
    fileId = _i1.ColumnString(
      'fileId',
      this,
    );
    fileUrl = _i1.ColumnString(
      'fileUrl',
      this,
    );
    authorizationId = _i1.ColumnInt(
      'authorizationId',
      this,
    );
    pupilId = _i1.ColumnInt(
      'pupilId',
      this,
    );
  }

  late final _i1.ColumnBool status;

  late final _i1.ColumnString comment;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnString fileId;

  late final _i1.ColumnString fileUrl;

  late final _i1.ColumnInt authorizationId;

  _i2.AuthorizationTable? _authorization;

  late final _i1.ColumnInt pupilId;

  _i3.PupilDataTable? _pupil;

  _i2.AuthorizationTable get authorization {
    if (_authorization != null) return _authorization!;
    _authorization = _i1.createRelationTable(
      relationFieldName: 'authorization',
      field: PupilAuthorization.t.authorizationId,
      foreignField: _i2.Authorization.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AuthorizationTable(tableRelation: foreignTableRelation),
    );
    return _authorization!;
  }

  _i3.PupilDataTable get pupil {
    if (_pupil != null) return _pupil!;
    _pupil = _i1.createRelationTable(
      relationFieldName: 'pupil',
      field: PupilAuthorization.t.pupilId,
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
        status,
        comment,
        createdBy,
        fileId,
        fileUrl,
        authorizationId,
        pupilId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'authorization') {
      return authorization;
    }
    if (relationField == 'pupil') {
      return pupil;
    }
    return null;
  }
}

class PupilAuthorizationInclude extends _i1.IncludeObject {
  PupilAuthorizationInclude._({
    _i2.AuthorizationInclude? authorization,
    _i3.PupilDataInclude? pupil,
  }) {
    _authorization = authorization;
    _pupil = pupil;
  }

  _i2.AuthorizationInclude? _authorization;

  _i3.PupilDataInclude? _pupil;

  @override
  Map<String, _i1.Include?> get includes => {
        'authorization': _authorization,
        'pupil': _pupil,
      };

  @override
  _i1.Table<int?> get table => PupilAuthorization.t;
}

class PupilAuthorizationIncludeList extends _i1.IncludeList {
  PupilAuthorizationIncludeList._({
    _i1.WhereExpressionBuilder<PupilAuthorizationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PupilAuthorization.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PupilAuthorization.t;
}

class PupilAuthorizationRepository {
  const PupilAuthorizationRepository._();

  final attachRow = const PupilAuthorizationAttachRowRepository._();

  /// Returns a list of [PupilAuthorization]s matching the given query parameters.
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
  Future<List<PupilAuthorization>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilAuthorizationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PupilAuthorizationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilAuthorizationTable>? orderByList,
    _i1.Transaction? transaction,
    PupilAuthorizationInclude? include,
  }) async {
    return session.db.find<PupilAuthorization>(
      where: where?.call(PupilAuthorization.t),
      orderBy: orderBy?.call(PupilAuthorization.t),
      orderByList: orderByList?.call(PupilAuthorization.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [PupilAuthorization] matching the given query parameters.
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
  Future<PupilAuthorization?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilAuthorizationTable>? where,
    int? offset,
    _i1.OrderByBuilder<PupilAuthorizationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilAuthorizationTable>? orderByList,
    _i1.Transaction? transaction,
    PupilAuthorizationInclude? include,
  }) async {
    return session.db.findFirstRow<PupilAuthorization>(
      where: where?.call(PupilAuthorization.t),
      orderBy: orderBy?.call(PupilAuthorization.t),
      orderByList: orderByList?.call(PupilAuthorization.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [PupilAuthorization] by its [id] or null if no such row exists.
  Future<PupilAuthorization?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    PupilAuthorizationInclude? include,
  }) async {
    return session.db.findById<PupilAuthorization>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [PupilAuthorization]s in the list and returns the inserted rows.
  ///
  /// The returned [PupilAuthorization]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PupilAuthorization>> insert(
    _i1.Session session,
    List<PupilAuthorization> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PupilAuthorization>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PupilAuthorization] and returns the inserted row.
  ///
  /// The returned [PupilAuthorization] will have its `id` field set.
  Future<PupilAuthorization> insertRow(
    _i1.Session session,
    PupilAuthorization row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PupilAuthorization>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PupilAuthorization]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PupilAuthorization>> update(
    _i1.Session session,
    List<PupilAuthorization> rows, {
    _i1.ColumnSelections<PupilAuthorizationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PupilAuthorization>(
      rows,
      columns: columns?.call(PupilAuthorization.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PupilAuthorization]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PupilAuthorization> updateRow(
    _i1.Session session,
    PupilAuthorization row, {
    _i1.ColumnSelections<PupilAuthorizationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PupilAuthorization>(
      row,
      columns: columns?.call(PupilAuthorization.t),
      transaction: transaction,
    );
  }

  /// Deletes all [PupilAuthorization]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PupilAuthorization>> delete(
    _i1.Session session,
    List<PupilAuthorization> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PupilAuthorization>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PupilAuthorization].
  Future<PupilAuthorization> deleteRow(
    _i1.Session session,
    PupilAuthorization row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PupilAuthorization>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PupilAuthorization>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PupilAuthorizationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PupilAuthorization>(
      where: where(PupilAuthorization.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilAuthorizationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PupilAuthorization>(
      where: where?.call(PupilAuthorization.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class PupilAuthorizationAttachRowRepository {
  const PupilAuthorizationAttachRowRepository._();

  /// Creates a relation between the given [PupilAuthorization] and [Authorization]
  /// by setting the [PupilAuthorization]'s foreign key `authorizationId` to refer to the [Authorization].
  Future<void> authorization(
    _i1.Session session,
    PupilAuthorization pupilAuthorization,
    _i2.Authorization authorization, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilAuthorization.id == null) {
      throw ArgumentError.notNull('pupilAuthorization.id');
    }
    if (authorization.id == null) {
      throw ArgumentError.notNull('authorization.id');
    }

    var $pupilAuthorization =
        pupilAuthorization.copyWith(authorizationId: authorization.id);
    await session.db.updateRow<PupilAuthorization>(
      $pupilAuthorization,
      columns: [PupilAuthorization.t.authorizationId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [PupilAuthorization] and [PupilData]
  /// by setting the [PupilAuthorization]'s foreign key `pupilId` to refer to the [PupilData].
  Future<void> pupil(
    _i1.Session session,
    PupilAuthorization pupilAuthorization,
    _i3.PupilData pupil, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilAuthorization.id == null) {
      throw ArgumentError.notNull('pupilAuthorization.id');
    }
    if (pupil.id == null) {
      throw ArgumentError.notNull('pupil.id');
    }

    var $pupilAuthorization = pupilAuthorization.copyWith(pupilId: pupil.id);
    await session.db.updateRow<PupilAuthorization>(
      $pupilAuthorization,
      columns: [PupilAuthorization.t.pupilId],
      transaction: transaction,
    );
  }
}

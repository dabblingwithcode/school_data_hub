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
import '../../../../_features/pupil/models/pupil_data/communication/public_media_auth.dart'
    as _i2;
import '../../../../_shared/models/hub_document.dart' as _i3;

abstract class PupilMediaData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PupilMediaData._({
    this.id,
    required this.publicMediaAuth,
    this.avatarId,
    this.avatar,
    this.avatarAuthId,
    this.avatarAuth,
    this.publicMediaAuthDocumentId,
    this.publicMediaAuthDocument,
  });

  factory PupilMediaData({
    int? id,
    required _i2.PublicMediaAuth publicMediaAuth,
    int? avatarId,
    _i3.HubDocument? avatar,
    int? avatarAuthId,
    _i3.HubDocument? avatarAuth,
    int? publicMediaAuthDocumentId,
    _i3.HubDocument? publicMediaAuthDocument,
  }) = _PupilMediaDataImpl;

  factory PupilMediaData.fromJson(Map<String, dynamic> jsonSerialization) {
    return PupilMediaData(
      id: jsonSerialization['id'] as int?,
      publicMediaAuth: _i2.PublicMediaAuth.fromJson(
          (jsonSerialization['publicMediaAuth'] as Map<String, dynamic>)),
      avatarId: jsonSerialization['avatarId'] as int?,
      avatar: jsonSerialization['avatar'] == null
          ? null
          : _i3.HubDocument.fromJson(
              (jsonSerialization['avatar'] as Map<String, dynamic>)),
      avatarAuthId: jsonSerialization['avatarAuthId'] as int?,
      avatarAuth: jsonSerialization['avatarAuth'] == null
          ? null
          : _i3.HubDocument.fromJson(
              (jsonSerialization['avatarAuth'] as Map<String, dynamic>)),
      publicMediaAuthDocumentId:
          jsonSerialization['publicMediaAuthDocumentId'] as int?,
      publicMediaAuthDocument:
          jsonSerialization['publicMediaAuthDocument'] == null
              ? null
              : _i3.HubDocument.fromJson(
                  (jsonSerialization['publicMediaAuthDocument']
                      as Map<String, dynamic>)),
    );
  }

  static final t = PupilMediaDataTable();

  static const db = PupilMediaDataRepository._();

  @override
  int? id;

  _i2.PublicMediaAuth publicMediaAuth;

  int? avatarId;

  _i3.HubDocument? avatar;

  int? avatarAuthId;

  _i3.HubDocument? avatarAuth;

  int? publicMediaAuthDocumentId;

  _i3.HubDocument? publicMediaAuthDocument;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PupilMediaData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilMediaData copyWith({
    int? id,
    _i2.PublicMediaAuth? publicMediaAuth,
    int? avatarId,
    _i3.HubDocument? avatar,
    int? avatarAuthId,
    _i3.HubDocument? avatarAuth,
    int? publicMediaAuthDocumentId,
    _i3.HubDocument? publicMediaAuthDocument,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'publicMediaAuth': publicMediaAuth.toJson(),
      if (avatarId != null) 'avatarId': avatarId,
      if (avatar != null) 'avatar': avatar?.toJson(),
      if (avatarAuthId != null) 'avatarAuthId': avatarAuthId,
      if (avatarAuth != null) 'avatarAuth': avatarAuth?.toJson(),
      if (publicMediaAuthDocumentId != null)
        'publicMediaAuthDocumentId': publicMediaAuthDocumentId,
      if (publicMediaAuthDocument != null)
        'publicMediaAuthDocument': publicMediaAuthDocument?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'publicMediaAuth': publicMediaAuth.toJsonForProtocol(),
      if (avatarId != null) 'avatarId': avatarId,
      if (avatar != null) 'avatar': avatar?.toJsonForProtocol(),
      if (avatarAuthId != null) 'avatarAuthId': avatarAuthId,
      if (avatarAuth != null) 'avatarAuth': avatarAuth?.toJsonForProtocol(),
      if (publicMediaAuthDocumentId != null)
        'publicMediaAuthDocumentId': publicMediaAuthDocumentId,
      if (publicMediaAuthDocument != null)
        'publicMediaAuthDocument': publicMediaAuthDocument?.toJsonForProtocol(),
    };
  }

  static PupilMediaDataInclude include({
    _i3.HubDocumentInclude? avatar,
    _i3.HubDocumentInclude? avatarAuth,
    _i3.HubDocumentInclude? publicMediaAuthDocument,
  }) {
    return PupilMediaDataInclude._(
      avatar: avatar,
      avatarAuth: avatarAuth,
      publicMediaAuthDocument: publicMediaAuthDocument,
    );
  }

  static PupilMediaDataIncludeList includeList({
    _i1.WhereExpressionBuilder<PupilMediaDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PupilMediaDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilMediaDataTable>? orderByList,
    PupilMediaDataInclude? include,
  }) {
    return PupilMediaDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PupilMediaData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PupilMediaData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PupilMediaDataImpl extends PupilMediaData {
  _PupilMediaDataImpl({
    int? id,
    required _i2.PublicMediaAuth publicMediaAuth,
    int? avatarId,
    _i3.HubDocument? avatar,
    int? avatarAuthId,
    _i3.HubDocument? avatarAuth,
    int? publicMediaAuthDocumentId,
    _i3.HubDocument? publicMediaAuthDocument,
  }) : super._(
          id: id,
          publicMediaAuth: publicMediaAuth,
          avatarId: avatarId,
          avatar: avatar,
          avatarAuthId: avatarAuthId,
          avatarAuth: avatarAuth,
          publicMediaAuthDocumentId: publicMediaAuthDocumentId,
          publicMediaAuthDocument: publicMediaAuthDocument,
        );

  /// Returns a shallow copy of this [PupilMediaData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilMediaData copyWith({
    Object? id = _Undefined,
    _i2.PublicMediaAuth? publicMediaAuth,
    Object? avatarId = _Undefined,
    Object? avatar = _Undefined,
    Object? avatarAuthId = _Undefined,
    Object? avatarAuth = _Undefined,
    Object? publicMediaAuthDocumentId = _Undefined,
    Object? publicMediaAuthDocument = _Undefined,
  }) {
    return PupilMediaData(
      id: id is int? ? id : this.id,
      publicMediaAuth: publicMediaAuth ?? this.publicMediaAuth.copyWith(),
      avatarId: avatarId is int? ? avatarId : this.avatarId,
      avatar: avatar is _i3.HubDocument? ? avatar : this.avatar?.copyWith(),
      avatarAuthId: avatarAuthId is int? ? avatarAuthId : this.avatarAuthId,
      avatarAuth: avatarAuth is _i3.HubDocument?
          ? avatarAuth
          : this.avatarAuth?.copyWith(),
      publicMediaAuthDocumentId: publicMediaAuthDocumentId is int?
          ? publicMediaAuthDocumentId
          : this.publicMediaAuthDocumentId,
      publicMediaAuthDocument: publicMediaAuthDocument is _i3.HubDocument?
          ? publicMediaAuthDocument
          : this.publicMediaAuthDocument?.copyWith(),
    );
  }
}

class PupilMediaDataTable extends _i1.Table<int?> {
  PupilMediaDataTable({super.tableRelation})
      : super(tableName: 'pupil_media_data') {
    publicMediaAuth = _i1.ColumnSerializable(
      'publicMediaAuth',
      this,
    );
    avatarId = _i1.ColumnInt(
      'avatarId',
      this,
    );
    avatarAuthId = _i1.ColumnInt(
      'avatarAuthId',
      this,
    );
    publicMediaAuthDocumentId = _i1.ColumnInt(
      'publicMediaAuthDocumentId',
      this,
    );
  }

  late final _i1.ColumnSerializable publicMediaAuth;

  late final _i1.ColumnInt avatarId;

  _i3.HubDocumentTable? _avatar;

  late final _i1.ColumnInt avatarAuthId;

  _i3.HubDocumentTable? _avatarAuth;

  late final _i1.ColumnInt publicMediaAuthDocumentId;

  _i3.HubDocumentTable? _publicMediaAuthDocument;

  _i3.HubDocumentTable get avatar {
    if (_avatar != null) return _avatar!;
    _avatar = _i1.createRelationTable(
      relationFieldName: 'avatar',
      field: PupilMediaData.t.avatarId,
      foreignField: _i3.HubDocument.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.HubDocumentTable(tableRelation: foreignTableRelation),
    );
    return _avatar!;
  }

  _i3.HubDocumentTable get avatarAuth {
    if (_avatarAuth != null) return _avatarAuth!;
    _avatarAuth = _i1.createRelationTable(
      relationFieldName: 'avatarAuth',
      field: PupilMediaData.t.avatarAuthId,
      foreignField: _i3.HubDocument.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.HubDocumentTable(tableRelation: foreignTableRelation),
    );
    return _avatarAuth!;
  }

  _i3.HubDocumentTable get publicMediaAuthDocument {
    if (_publicMediaAuthDocument != null) return _publicMediaAuthDocument!;
    _publicMediaAuthDocument = _i1.createRelationTable(
      relationFieldName: 'publicMediaAuthDocument',
      field: PupilMediaData.t.publicMediaAuthDocumentId,
      foreignField: _i3.HubDocument.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.HubDocumentTable(tableRelation: foreignTableRelation),
    );
    return _publicMediaAuthDocument!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        publicMediaAuth,
        avatarId,
        avatarAuthId,
        publicMediaAuthDocumentId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'avatar') {
      return avatar;
    }
    if (relationField == 'avatarAuth') {
      return avatarAuth;
    }
    if (relationField == 'publicMediaAuthDocument') {
      return publicMediaAuthDocument;
    }
    return null;
  }
}

class PupilMediaDataInclude extends _i1.IncludeObject {
  PupilMediaDataInclude._({
    _i3.HubDocumentInclude? avatar,
    _i3.HubDocumentInclude? avatarAuth,
    _i3.HubDocumentInclude? publicMediaAuthDocument,
  }) {
    _avatar = avatar;
    _avatarAuth = avatarAuth;
    _publicMediaAuthDocument = publicMediaAuthDocument;
  }

  _i3.HubDocumentInclude? _avatar;

  _i3.HubDocumentInclude? _avatarAuth;

  _i3.HubDocumentInclude? _publicMediaAuthDocument;

  @override
  Map<String, _i1.Include?> get includes => {
        'avatar': _avatar,
        'avatarAuth': _avatarAuth,
        'publicMediaAuthDocument': _publicMediaAuthDocument,
      };

  @override
  _i1.Table<int?> get table => PupilMediaData.t;
}

class PupilMediaDataIncludeList extends _i1.IncludeList {
  PupilMediaDataIncludeList._({
    _i1.WhereExpressionBuilder<PupilMediaDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PupilMediaData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PupilMediaData.t;
}

class PupilMediaDataRepository {
  const PupilMediaDataRepository._();

  final attachRow = const PupilMediaDataAttachRowRepository._();

  final detachRow = const PupilMediaDataDetachRowRepository._();

  /// Returns a list of [PupilMediaData]s matching the given query parameters.
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
  Future<List<PupilMediaData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilMediaDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PupilMediaDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilMediaDataTable>? orderByList,
    _i1.Transaction? transaction,
    PupilMediaDataInclude? include,
  }) async {
    return session.db.find<PupilMediaData>(
      where: where?.call(PupilMediaData.t),
      orderBy: orderBy?.call(PupilMediaData.t),
      orderByList: orderByList?.call(PupilMediaData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [PupilMediaData] matching the given query parameters.
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
  Future<PupilMediaData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilMediaDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<PupilMediaDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilMediaDataTable>? orderByList,
    _i1.Transaction? transaction,
    PupilMediaDataInclude? include,
  }) async {
    return session.db.findFirstRow<PupilMediaData>(
      where: where?.call(PupilMediaData.t),
      orderBy: orderBy?.call(PupilMediaData.t),
      orderByList: orderByList?.call(PupilMediaData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [PupilMediaData] by its [id] or null if no such row exists.
  Future<PupilMediaData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    PupilMediaDataInclude? include,
  }) async {
    return session.db.findById<PupilMediaData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [PupilMediaData]s in the list and returns the inserted rows.
  ///
  /// The returned [PupilMediaData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PupilMediaData>> insert(
    _i1.Session session,
    List<PupilMediaData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PupilMediaData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PupilMediaData] and returns the inserted row.
  ///
  /// The returned [PupilMediaData] will have its `id` field set.
  Future<PupilMediaData> insertRow(
    _i1.Session session,
    PupilMediaData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PupilMediaData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PupilMediaData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PupilMediaData>> update(
    _i1.Session session,
    List<PupilMediaData> rows, {
    _i1.ColumnSelections<PupilMediaDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PupilMediaData>(
      rows,
      columns: columns?.call(PupilMediaData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PupilMediaData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PupilMediaData> updateRow(
    _i1.Session session,
    PupilMediaData row, {
    _i1.ColumnSelections<PupilMediaDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PupilMediaData>(
      row,
      columns: columns?.call(PupilMediaData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [PupilMediaData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PupilMediaData>> delete(
    _i1.Session session,
    List<PupilMediaData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PupilMediaData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PupilMediaData].
  Future<PupilMediaData> deleteRow(
    _i1.Session session,
    PupilMediaData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PupilMediaData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PupilMediaData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PupilMediaDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PupilMediaData>(
      where: where(PupilMediaData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilMediaDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PupilMediaData>(
      where: where?.call(PupilMediaData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class PupilMediaDataAttachRowRepository {
  const PupilMediaDataAttachRowRepository._();

  /// Creates a relation between the given [PupilMediaData] and [HubDocument]
  /// by setting the [PupilMediaData]'s foreign key `avatarId` to refer to the [HubDocument].
  Future<void> avatar(
    _i1.Session session,
    PupilMediaData pupilMediaData,
    _i3.HubDocument avatar, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilMediaData.id == null) {
      throw ArgumentError.notNull('pupilMediaData.id');
    }
    if (avatar.id == null) {
      throw ArgumentError.notNull('avatar.id');
    }

    var $pupilMediaData = pupilMediaData.copyWith(avatarId: avatar.id);
    await session.db.updateRow<PupilMediaData>(
      $pupilMediaData,
      columns: [PupilMediaData.t.avatarId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [PupilMediaData] and [HubDocument]
  /// by setting the [PupilMediaData]'s foreign key `avatarAuthId` to refer to the [HubDocument].
  Future<void> avatarAuth(
    _i1.Session session,
    PupilMediaData pupilMediaData,
    _i3.HubDocument avatarAuth, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilMediaData.id == null) {
      throw ArgumentError.notNull('pupilMediaData.id');
    }
    if (avatarAuth.id == null) {
      throw ArgumentError.notNull('avatarAuth.id');
    }

    var $pupilMediaData = pupilMediaData.copyWith(avatarAuthId: avatarAuth.id);
    await session.db.updateRow<PupilMediaData>(
      $pupilMediaData,
      columns: [PupilMediaData.t.avatarAuthId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [PupilMediaData] and [HubDocument]
  /// by setting the [PupilMediaData]'s foreign key `publicMediaAuthDocumentId` to refer to the [HubDocument].
  Future<void> publicMediaAuthDocument(
    _i1.Session session,
    PupilMediaData pupilMediaData,
    _i3.HubDocument publicMediaAuthDocument, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilMediaData.id == null) {
      throw ArgumentError.notNull('pupilMediaData.id');
    }
    if (publicMediaAuthDocument.id == null) {
      throw ArgumentError.notNull('publicMediaAuthDocument.id');
    }

    var $pupilMediaData = pupilMediaData.copyWith(
        publicMediaAuthDocumentId: publicMediaAuthDocument.id);
    await session.db.updateRow<PupilMediaData>(
      $pupilMediaData,
      columns: [PupilMediaData.t.publicMediaAuthDocumentId],
      transaction: transaction,
    );
  }
}

class PupilMediaDataDetachRowRepository {
  const PupilMediaDataDetachRowRepository._();

  /// Detaches the relation between this [PupilMediaData] and the [HubDocument] set in `avatar`
  /// by setting the [PupilMediaData]'s foreign key `avatarId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> avatar(
    _i1.Session session,
    PupilMediaData pupilmediadata, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilmediadata.id == null) {
      throw ArgumentError.notNull('pupilmediadata.id');
    }

    var $pupilmediadata = pupilmediadata.copyWith(avatarId: null);
    await session.db.updateRow<PupilMediaData>(
      $pupilmediadata,
      columns: [PupilMediaData.t.avatarId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilMediaData] and the [HubDocument] set in `avatarAuth`
  /// by setting the [PupilMediaData]'s foreign key `avatarAuthId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> avatarAuth(
    _i1.Session session,
    PupilMediaData pupilmediadata, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilmediadata.id == null) {
      throw ArgumentError.notNull('pupilmediadata.id');
    }

    var $pupilmediadata = pupilmediadata.copyWith(avatarAuthId: null);
    await session.db.updateRow<PupilMediaData>(
      $pupilmediadata,
      columns: [PupilMediaData.t.avatarAuthId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilMediaData] and the [HubDocument] set in `publicMediaAuthDocument`
  /// by setting the [PupilMediaData]'s foreign key `publicMediaAuthDocumentId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> publicMediaAuthDocument(
    _i1.Session session,
    PupilMediaData pupilmediadata, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilmediadata.id == null) {
      throw ArgumentError.notNull('pupilmediadata.id');
    }

    var $pupilmediadata =
        pupilmediadata.copyWith(publicMediaAuthDocumentId: null);
    await session.db.updateRow<PupilMediaData>(
      $pupilmediadata,
      columns: [PupilMediaData.t.publicMediaAuthDocumentId],
      transaction: transaction,
    );
  }
}

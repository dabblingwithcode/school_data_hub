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
import '../authorization/pupil_authorization.dart' as _i2;

abstract class Authorization
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Authorization._({
    this.id,
    required this.name,
    required this.description,
    required this.createdBy,
    this.authorizedPupils,
  });

  factory Authorization({
    int? id,
    required String name,
    required String description,
    required String createdBy,
    List<_i2.PupilAuthorization>? authorizedPupils,
  }) = _AuthorizationImpl;

  factory Authorization.fromJson(Map<String, dynamic> jsonSerialization) {
    return Authorization(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      authorizedPupils: (jsonSerialization['authorizedPupils'] as List?)
          ?.map((e) =>
              _i2.PupilAuthorization.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = AuthorizationTable();

  static const db = AuthorizationRepository._();

  @override
  int? id;

  String name;

  String description;

  String createdBy;

  List<_i2.PupilAuthorization>? authorizedPupils;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Authorization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Authorization copyWith({
    int? id,
    String? name,
    String? description,
    String? createdBy,
    List<_i2.PupilAuthorization>? authorizedPupils,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'description': description,
      'createdBy': createdBy,
      if (authorizedPupils != null)
        'authorizedPupils':
            authorizedPupils?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'description': description,
      'createdBy': createdBy,
      if (authorizedPupils != null)
        'authorizedPupils':
            authorizedPupils?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static AuthorizationInclude include(
      {_i2.PupilAuthorizationIncludeList? authorizedPupils}) {
    return AuthorizationInclude._(authorizedPupils: authorizedPupils);
  }

  static AuthorizationIncludeList includeList({
    _i1.WhereExpressionBuilder<AuthorizationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AuthorizationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AuthorizationTable>? orderByList,
    AuthorizationInclude? include,
  }) {
    return AuthorizationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Authorization.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Authorization.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuthorizationImpl extends Authorization {
  _AuthorizationImpl({
    int? id,
    required String name,
    required String description,
    required String createdBy,
    List<_i2.PupilAuthorization>? authorizedPupils,
  }) : super._(
          id: id,
          name: name,
          description: description,
          createdBy: createdBy,
          authorizedPupils: authorizedPupils,
        );

  /// Returns a shallow copy of this [Authorization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Authorization copyWith({
    Object? id = _Undefined,
    String? name,
    String? description,
    String? createdBy,
    Object? authorizedPupils = _Undefined,
  }) {
    return Authorization(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      authorizedPupils: authorizedPupils is List<_i2.PupilAuthorization>?
          ? authorizedPupils
          : this.authorizedPupils?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class AuthorizationTable extends _i1.Table<int?> {
  AuthorizationTable({super.tableRelation})
      : super(tableName: 'authorization') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    createdBy = _i1.ColumnString(
      'createdBy',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString createdBy;

  _i2.PupilAuthorizationTable? ___authorizedPupils;

  _i1.ManyRelation<_i2.PupilAuthorizationTable>? _authorizedPupils;

  _i2.PupilAuthorizationTable get __authorizedPupils {
    if (___authorizedPupils != null) return ___authorizedPupils!;
    ___authorizedPupils = _i1.createRelationTable(
      relationFieldName: '__authorizedPupils',
      field: Authorization.t.id,
      foreignField: _i2.PupilAuthorization.t.authorizationId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PupilAuthorizationTable(tableRelation: foreignTableRelation),
    );
    return ___authorizedPupils!;
  }

  _i1.ManyRelation<_i2.PupilAuthorizationTable> get authorizedPupils {
    if (_authorizedPupils != null) return _authorizedPupils!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'authorizedPupils',
      field: Authorization.t.id,
      foreignField: _i2.PupilAuthorization.t.authorizationId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PupilAuthorizationTable(tableRelation: foreignTableRelation),
    );
    _authorizedPupils = _i1.ManyRelation<_i2.PupilAuthorizationTable>(
      tableWithRelations: relationTable,
      table: _i2.PupilAuthorizationTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _authorizedPupils!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        description,
        createdBy,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'authorizedPupils') {
      return __authorizedPupils;
    }
    return null;
  }
}

class AuthorizationInclude extends _i1.IncludeObject {
  AuthorizationInclude._(
      {_i2.PupilAuthorizationIncludeList? authorizedPupils}) {
    _authorizedPupils = authorizedPupils;
  }

  _i2.PupilAuthorizationIncludeList? _authorizedPupils;

  @override
  Map<String, _i1.Include?> get includes =>
      {'authorizedPupils': _authorizedPupils};

  @override
  _i1.Table<int?> get table => Authorization.t;
}

class AuthorizationIncludeList extends _i1.IncludeList {
  AuthorizationIncludeList._({
    _i1.WhereExpressionBuilder<AuthorizationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Authorization.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Authorization.t;
}

class AuthorizationRepository {
  const AuthorizationRepository._();

  final attach = const AuthorizationAttachRepository._();

  final attachRow = const AuthorizationAttachRowRepository._();

  final detach = const AuthorizationDetachRepository._();

  final detachRow = const AuthorizationDetachRowRepository._();

  /// Returns a list of [Authorization]s matching the given query parameters.
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
  Future<List<Authorization>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AuthorizationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AuthorizationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AuthorizationTable>? orderByList,
    _i1.Transaction? transaction,
    AuthorizationInclude? include,
  }) async {
    return session.db.find<Authorization>(
      where: where?.call(Authorization.t),
      orderBy: orderBy?.call(Authorization.t),
      orderByList: orderByList?.call(Authorization.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Authorization] matching the given query parameters.
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
  Future<Authorization?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AuthorizationTable>? where,
    int? offset,
    _i1.OrderByBuilder<AuthorizationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AuthorizationTable>? orderByList,
    _i1.Transaction? transaction,
    AuthorizationInclude? include,
  }) async {
    return session.db.findFirstRow<Authorization>(
      where: where?.call(Authorization.t),
      orderBy: orderBy?.call(Authorization.t),
      orderByList: orderByList?.call(Authorization.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Authorization] by its [id] or null if no such row exists.
  Future<Authorization?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    AuthorizationInclude? include,
  }) async {
    return session.db.findById<Authorization>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Authorization]s in the list and returns the inserted rows.
  ///
  /// The returned [Authorization]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Authorization>> insert(
    _i1.Session session,
    List<Authorization> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Authorization>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Authorization] and returns the inserted row.
  ///
  /// The returned [Authorization] will have its `id` field set.
  Future<Authorization> insertRow(
    _i1.Session session,
    Authorization row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Authorization>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Authorization]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Authorization>> update(
    _i1.Session session,
    List<Authorization> rows, {
    _i1.ColumnSelections<AuthorizationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Authorization>(
      rows,
      columns: columns?.call(Authorization.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Authorization]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Authorization> updateRow(
    _i1.Session session,
    Authorization row, {
    _i1.ColumnSelections<AuthorizationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Authorization>(
      row,
      columns: columns?.call(Authorization.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Authorization]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Authorization>> delete(
    _i1.Session session,
    List<Authorization> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Authorization>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Authorization].
  Future<Authorization> deleteRow(
    _i1.Session session,
    Authorization row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Authorization>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Authorization>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AuthorizationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Authorization>(
      where: where(Authorization.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AuthorizationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Authorization>(
      where: where?.call(Authorization.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class AuthorizationAttachRepository {
  const AuthorizationAttachRepository._();

  /// Creates a relation between this [Authorization] and the given [PupilAuthorization]s
  /// by setting each [PupilAuthorization]'s foreign key `authorizationId` to refer to this [Authorization].
  Future<void> authorizedPupils(
    _i1.Session session,
    Authorization authorization,
    List<_i2.PupilAuthorization> pupilAuthorization, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilAuthorization.any((e) => e.id == null)) {
      throw ArgumentError.notNull('pupilAuthorization.id');
    }
    if (authorization.id == null) {
      throw ArgumentError.notNull('authorization.id');
    }

    var $pupilAuthorization = pupilAuthorization
        .map((e) => e.copyWith(authorizationId: authorization.id))
        .toList();
    await session.db.update<_i2.PupilAuthorization>(
      $pupilAuthorization,
      columns: [_i2.PupilAuthorization.t.authorizationId],
      transaction: transaction,
    );
  }
}

class AuthorizationAttachRowRepository {
  const AuthorizationAttachRowRepository._();

  /// Creates a relation between this [Authorization] and the given [PupilAuthorization]
  /// by setting the [PupilAuthorization]'s foreign key `authorizationId` to refer to this [Authorization].
  Future<void> authorizedPupils(
    _i1.Session session,
    Authorization authorization,
    _i2.PupilAuthorization pupilAuthorization, {
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
    await session.db.updateRow<_i2.PupilAuthorization>(
      $pupilAuthorization,
      columns: [_i2.PupilAuthorization.t.authorizationId],
      transaction: transaction,
    );
  }
}

class AuthorizationDetachRepository {
  const AuthorizationDetachRepository._();

  /// Detaches the relation between this [Authorization] and the given [PupilAuthorization]
  /// by setting the [PupilAuthorization]'s foreign key `authorizationId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> authorizedPupils(
    _i1.Session session,
    List<_i2.PupilAuthorization> pupilAuthorization, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilAuthorization.any((e) => e.id == null)) {
      throw ArgumentError.notNull('pupilAuthorization.id');
    }

    var $pupilAuthorization = pupilAuthorization
        .map((e) => e.copyWith(authorizationId: null))
        .toList();
    await session.db.update<_i2.PupilAuthorization>(
      $pupilAuthorization,
      columns: [_i2.PupilAuthorization.t.authorizationId],
      transaction: transaction,
    );
  }
}

class AuthorizationDetachRowRepository {
  const AuthorizationDetachRowRepository._();

  /// Detaches the relation between this [Authorization] and the given [PupilAuthorization]
  /// by setting the [PupilAuthorization]'s foreign key `authorizationId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> authorizedPupils(
    _i1.Session session,
    _i2.PupilAuthorization pupilAuthorization, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilAuthorization.id == null) {
      throw ArgumentError.notNull('pupilAuthorization.id');
    }

    var $pupilAuthorization =
        pupilAuthorization.copyWith(authorizationId: null);
    await session.db.updateRow<_i2.PupilAuthorization>(
      $pupilAuthorization,
      columns: [_i2.PupilAuthorization.t.authorizationId],
      transaction: transaction,
    );
  }
}

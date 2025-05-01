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
import '../school_list/pupil_entry.dart' as _i2;

abstract class SchoolList
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SchoolList._({
    this.id,
    required this.listId,
    required this.archived,
    required this.name,
    required this.description,
    required this.createdBy,
    required this.public,
    this.authorizedUsers,
    this.pupilEntries,
  });

  factory SchoolList({
    int? id,
    required String listId,
    required bool archived,
    required String name,
    required String description,
    required String createdBy,
    required bool public,
    String? authorizedUsers,
    List<_i2.PupilListEntry>? pupilEntries,
  }) = _SchoolListImpl;

  factory SchoolList.fromJson(Map<String, dynamic> jsonSerialization) {
    return SchoolList(
      id: jsonSerialization['id'] as int?,
      listId: jsonSerialization['listId'] as String,
      archived: jsonSerialization['archived'] as bool,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      public: jsonSerialization['public'] as bool,
      authorizedUsers: jsonSerialization['authorizedUsers'] as String?,
      pupilEntries: (jsonSerialization['pupilEntries'] as List?)
          ?.map((e) => _i2.PupilListEntry.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = SchoolListTable();

  static const db = SchoolListRepository._();

  @override
  int? id;

  String listId;

  bool archived;

  String name;

  String description;

  String createdBy;

  bool public;

  String? authorizedUsers;

  List<_i2.PupilListEntry>? pupilEntries;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SchoolList]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SchoolList copyWith({
    int? id,
    String? listId,
    bool? archived,
    String? name,
    String? description,
    String? createdBy,
    bool? public,
    String? authorizedUsers,
    List<_i2.PupilListEntry>? pupilEntries,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'listId': listId,
      'archived': archived,
      'name': name,
      'description': description,
      'createdBy': createdBy,
      'public': public,
      if (authorizedUsers != null) 'authorizedUsers': authorizedUsers,
      if (pupilEntries != null)
        'pupilEntries': pupilEntries?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'listId': listId,
      'archived': archived,
      'name': name,
      'description': description,
      'createdBy': createdBy,
      'public': public,
      if (authorizedUsers != null) 'authorizedUsers': authorizedUsers,
      if (pupilEntries != null)
        'pupilEntries':
            pupilEntries?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static SchoolListInclude include(
      {_i2.PupilListEntryIncludeList? pupilEntries}) {
    return SchoolListInclude._(pupilEntries: pupilEntries);
  }

  static SchoolListIncludeList includeList({
    _i1.WhereExpressionBuilder<SchoolListTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SchoolListTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SchoolListTable>? orderByList,
    SchoolListInclude? include,
  }) {
    return SchoolListIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SchoolList.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SchoolList.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SchoolListImpl extends SchoolList {
  _SchoolListImpl({
    int? id,
    required String listId,
    required bool archived,
    required String name,
    required String description,
    required String createdBy,
    required bool public,
    String? authorizedUsers,
    List<_i2.PupilListEntry>? pupilEntries,
  }) : super._(
          id: id,
          listId: listId,
          archived: archived,
          name: name,
          description: description,
          createdBy: createdBy,
          public: public,
          authorizedUsers: authorizedUsers,
          pupilEntries: pupilEntries,
        );

  /// Returns a shallow copy of this [SchoolList]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SchoolList copyWith({
    Object? id = _Undefined,
    String? listId,
    bool? archived,
    String? name,
    String? description,
    String? createdBy,
    bool? public,
    Object? authorizedUsers = _Undefined,
    Object? pupilEntries = _Undefined,
  }) {
    return SchoolList(
      id: id is int? ? id : this.id,
      listId: listId ?? this.listId,
      archived: archived ?? this.archived,
      name: name ?? this.name,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      public: public ?? this.public,
      authorizedUsers:
          authorizedUsers is String? ? authorizedUsers : this.authorizedUsers,
      pupilEntries: pupilEntries is List<_i2.PupilListEntry>?
          ? pupilEntries
          : this.pupilEntries?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class SchoolListTable extends _i1.Table<int?> {
  SchoolListTable({super.tableRelation}) : super(tableName: 'school_list') {
    listId = _i1.ColumnString(
      'listId',
      this,
    );
    archived = _i1.ColumnBool(
      'archived',
      this,
    );
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
    public = _i1.ColumnBool(
      'public',
      this,
    );
    authorizedUsers = _i1.ColumnString(
      'authorizedUsers',
      this,
    );
  }

  late final _i1.ColumnString listId;

  late final _i1.ColumnBool archived;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnBool public;

  late final _i1.ColumnString authorizedUsers;

  _i2.PupilListEntryTable? ___pupilEntries;

  _i1.ManyRelation<_i2.PupilListEntryTable>? _pupilEntries;

  _i2.PupilListEntryTable get __pupilEntries {
    if (___pupilEntries != null) return ___pupilEntries!;
    ___pupilEntries = _i1.createRelationTable(
      relationFieldName: '__pupilEntries',
      field: SchoolList.t.id,
      foreignField: _i2.PupilListEntry.t.schoolListId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PupilListEntryTable(tableRelation: foreignTableRelation),
    );
    return ___pupilEntries!;
  }

  _i1.ManyRelation<_i2.PupilListEntryTable> get pupilEntries {
    if (_pupilEntries != null) return _pupilEntries!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'pupilEntries',
      field: SchoolList.t.id,
      foreignField: _i2.PupilListEntry.t.schoolListId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PupilListEntryTable(tableRelation: foreignTableRelation),
    );
    _pupilEntries = _i1.ManyRelation<_i2.PupilListEntryTable>(
      tableWithRelations: relationTable,
      table: _i2.PupilListEntryTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _pupilEntries!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        listId,
        archived,
        name,
        description,
        createdBy,
        public,
        authorizedUsers,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'pupilEntries') {
      return __pupilEntries;
    }
    return null;
  }
}

class SchoolListInclude extends _i1.IncludeObject {
  SchoolListInclude._({_i2.PupilListEntryIncludeList? pupilEntries}) {
    _pupilEntries = pupilEntries;
  }

  _i2.PupilListEntryIncludeList? _pupilEntries;

  @override
  Map<String, _i1.Include?> get includes => {'pupilEntries': _pupilEntries};

  @override
  _i1.Table<int?> get table => SchoolList.t;
}

class SchoolListIncludeList extends _i1.IncludeList {
  SchoolListIncludeList._({
    _i1.WhereExpressionBuilder<SchoolListTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SchoolList.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SchoolList.t;
}

class SchoolListRepository {
  const SchoolListRepository._();

  final attach = const SchoolListAttachRepository._();

  final attachRow = const SchoolListAttachRowRepository._();

  /// Returns a list of [SchoolList]s matching the given query parameters.
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
  Future<List<SchoolList>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SchoolListTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SchoolListTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SchoolListTable>? orderByList,
    _i1.Transaction? transaction,
    SchoolListInclude? include,
  }) async {
    return session.db.find<SchoolList>(
      where: where?.call(SchoolList.t),
      orderBy: orderBy?.call(SchoolList.t),
      orderByList: orderByList?.call(SchoolList.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [SchoolList] matching the given query parameters.
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
  Future<SchoolList?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SchoolListTable>? where,
    int? offset,
    _i1.OrderByBuilder<SchoolListTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SchoolListTable>? orderByList,
    _i1.Transaction? transaction,
    SchoolListInclude? include,
  }) async {
    return session.db.findFirstRow<SchoolList>(
      where: where?.call(SchoolList.t),
      orderBy: orderBy?.call(SchoolList.t),
      orderByList: orderByList?.call(SchoolList.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [SchoolList] by its [id] or null if no such row exists.
  Future<SchoolList?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    SchoolListInclude? include,
  }) async {
    return session.db.findById<SchoolList>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [SchoolList]s in the list and returns the inserted rows.
  ///
  /// The returned [SchoolList]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SchoolList>> insert(
    _i1.Session session,
    List<SchoolList> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SchoolList>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SchoolList] and returns the inserted row.
  ///
  /// The returned [SchoolList] will have its `id` field set.
  Future<SchoolList> insertRow(
    _i1.Session session,
    SchoolList row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SchoolList>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SchoolList]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SchoolList>> update(
    _i1.Session session,
    List<SchoolList> rows, {
    _i1.ColumnSelections<SchoolListTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SchoolList>(
      rows,
      columns: columns?.call(SchoolList.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SchoolList]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SchoolList> updateRow(
    _i1.Session session,
    SchoolList row, {
    _i1.ColumnSelections<SchoolListTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SchoolList>(
      row,
      columns: columns?.call(SchoolList.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SchoolList]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SchoolList>> delete(
    _i1.Session session,
    List<SchoolList> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SchoolList>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SchoolList].
  Future<SchoolList> deleteRow(
    _i1.Session session,
    SchoolList row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SchoolList>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SchoolList>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SchoolListTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SchoolList>(
      where: where(SchoolList.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SchoolListTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SchoolList>(
      where: where?.call(SchoolList.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class SchoolListAttachRepository {
  const SchoolListAttachRepository._();

  /// Creates a relation between this [SchoolList] and the given [PupilListEntry]s
  /// by setting each [PupilListEntry]'s foreign key `schoolListId` to refer to this [SchoolList].
  Future<void> pupilEntries(
    _i1.Session session,
    SchoolList schoolList,
    List<_i2.PupilListEntry> pupilListEntry, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilListEntry.any((e) => e.id == null)) {
      throw ArgumentError.notNull('pupilListEntry.id');
    }
    if (schoolList.id == null) {
      throw ArgumentError.notNull('schoolList.id');
    }

    var $pupilListEntry = pupilListEntry
        .map((e) => e.copyWith(schoolListId: schoolList.id))
        .toList();
    await session.db.update<_i2.PupilListEntry>(
      $pupilListEntry,
      columns: [_i2.PupilListEntry.t.schoolListId],
      transaction: transaction,
    );
  }
}

class SchoolListAttachRowRepository {
  const SchoolListAttachRowRepository._();

  /// Creates a relation between this [SchoolList] and the given [PupilListEntry]
  /// by setting the [PupilListEntry]'s foreign key `schoolListId` to refer to this [SchoolList].
  Future<void> pupilEntries(
    _i1.Session session,
    SchoolList schoolList,
    _i2.PupilListEntry pupilListEntry, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilListEntry.id == null) {
      throw ArgumentError.notNull('pupilListEntry.id');
    }
    if (schoolList.id == null) {
      throw ArgumentError.notNull('schoolList.id');
    }

    var $pupilListEntry = pupilListEntry.copyWith(schoolListId: schoolList.id);
    await session.db.updateRow<_i2.PupilListEntry>(
      $pupilListEntry,
      columns: [_i2.PupilListEntry.t.schoolListId],
      transaction: transaction,
    );
  }
}

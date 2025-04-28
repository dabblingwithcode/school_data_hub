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
import '../learning_support/support_goal/support_goal.dart' as _i2;
import '../learning_support/support_category_status.dart' as _i3;

abstract class SupportCategory
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SupportCategory._({
    this.id,
    required this.name,
    required this.categoryId,
    this.parentCategory,
    this.categoryGoals,
    this.categoryStatues,
  });

  factory SupportCategory({
    int? id,
    required String name,
    required int categoryId,
    int? parentCategory,
    List<_i2.SupportGoal>? categoryGoals,
    List<_i3.SupportCategoryStatus>? categoryStatues,
  }) = _SupportCategoryImpl;

  factory SupportCategory.fromJson(Map<String, dynamic> jsonSerialization) {
    return SupportCategory(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      categoryId: jsonSerialization['categoryId'] as int,
      parentCategory: jsonSerialization['parentCategory'] as int?,
      categoryGoals: (jsonSerialization['categoryGoals'] as List?)
          ?.map((e) => _i2.SupportGoal.fromJson((e as Map<String, dynamic>)))
          .toList(),
      categoryStatues: (jsonSerialization['categoryStatues'] as List?)
          ?.map((e) =>
              _i3.SupportCategoryStatus.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = SupportCategoryTable();

  static const db = SupportCategoryRepository._();

  @override
  int? id;

  String name;

  int categoryId;

  int? parentCategory;

  List<_i2.SupportGoal>? categoryGoals;

  List<_i3.SupportCategoryStatus>? categoryStatues;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SupportCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SupportCategory copyWith({
    int? id,
    String? name,
    int? categoryId,
    int? parentCategory,
    List<_i2.SupportGoal>? categoryGoals,
    List<_i3.SupportCategoryStatus>? categoryStatues,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'categoryId': categoryId,
      if (parentCategory != null) 'parentCategory': parentCategory,
      if (categoryGoals != null)
        'categoryGoals': categoryGoals?.toJson(valueToJson: (v) => v.toJson()),
      if (categoryStatues != null)
        'categoryStatues':
            categoryStatues?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'categoryId': categoryId,
      if (parentCategory != null) 'parentCategory': parentCategory,
      if (categoryGoals != null)
        'categoryGoals':
            categoryGoals?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (categoryStatues != null)
        'categoryStatues':
            categoryStatues?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static SupportCategoryInclude include({
    _i2.SupportGoalIncludeList? categoryGoals,
    _i3.SupportCategoryStatusIncludeList? categoryStatues,
  }) {
    return SupportCategoryInclude._(
      categoryGoals: categoryGoals,
      categoryStatues: categoryStatues,
    );
  }

  static SupportCategoryIncludeList includeList({
    _i1.WhereExpressionBuilder<SupportCategoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SupportCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SupportCategoryTable>? orderByList,
    SupportCategoryInclude? include,
  }) {
    return SupportCategoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SupportCategory.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SupportCategory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SupportCategoryImpl extends SupportCategory {
  _SupportCategoryImpl({
    int? id,
    required String name,
    required int categoryId,
    int? parentCategory,
    List<_i2.SupportGoal>? categoryGoals,
    List<_i3.SupportCategoryStatus>? categoryStatues,
  }) : super._(
          id: id,
          name: name,
          categoryId: categoryId,
          parentCategory: parentCategory,
          categoryGoals: categoryGoals,
          categoryStatues: categoryStatues,
        );

  /// Returns a shallow copy of this [SupportCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SupportCategory copyWith({
    Object? id = _Undefined,
    String? name,
    int? categoryId,
    Object? parentCategory = _Undefined,
    Object? categoryGoals = _Undefined,
    Object? categoryStatues = _Undefined,
  }) {
    return SupportCategory(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      parentCategory:
          parentCategory is int? ? parentCategory : this.parentCategory,
      categoryGoals: categoryGoals is List<_i2.SupportGoal>?
          ? categoryGoals
          : this.categoryGoals?.map((e0) => e0.copyWith()).toList(),
      categoryStatues: categoryStatues is List<_i3.SupportCategoryStatus>?
          ? categoryStatues
          : this.categoryStatues?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class SupportCategoryTable extends _i1.Table<int?> {
  SupportCategoryTable({super.tableRelation})
      : super(tableName: 'support_category') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    categoryId = _i1.ColumnInt(
      'categoryId',
      this,
    );
    parentCategory = _i1.ColumnInt(
      'parentCategory',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnInt categoryId;

  late final _i1.ColumnInt parentCategory;

  _i2.SupportGoalTable? ___categoryGoals;

  _i1.ManyRelation<_i2.SupportGoalTable>? _categoryGoals;

  _i3.SupportCategoryStatusTable? ___categoryStatues;

  _i1.ManyRelation<_i3.SupportCategoryStatusTable>? _categoryStatues;

  _i2.SupportGoalTable get __categoryGoals {
    if (___categoryGoals != null) return ___categoryGoals!;
    ___categoryGoals = _i1.createRelationTable(
      relationFieldName: '__categoryGoals',
      field: SupportCategory.t.id,
      foreignField:
          _i2.SupportGoal.t.$_supportCategoryCategorygoalsSupportCategoryId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SupportGoalTable(tableRelation: foreignTableRelation),
    );
    return ___categoryGoals!;
  }

  _i3.SupportCategoryStatusTable get __categoryStatues {
    if (___categoryStatues != null) return ___categoryStatues!;
    ___categoryStatues = _i1.createRelationTable(
      relationFieldName: '__categoryStatues',
      field: SupportCategory.t.id,
      foreignField: _i3.SupportCategoryStatus.t
          .$_supportCategoryCategorystatuesSupportCategoryId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.SupportCategoryStatusTable(tableRelation: foreignTableRelation),
    );
    return ___categoryStatues!;
  }

  _i1.ManyRelation<_i2.SupportGoalTable> get categoryGoals {
    if (_categoryGoals != null) return _categoryGoals!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'categoryGoals',
      field: SupportCategory.t.id,
      foreignField:
          _i2.SupportGoal.t.$_supportCategoryCategorygoalsSupportCategoryId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SupportGoalTable(tableRelation: foreignTableRelation),
    );
    _categoryGoals = _i1.ManyRelation<_i2.SupportGoalTable>(
      tableWithRelations: relationTable,
      table: _i2.SupportGoalTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _categoryGoals!;
  }

  _i1.ManyRelation<_i3.SupportCategoryStatusTable> get categoryStatues {
    if (_categoryStatues != null) return _categoryStatues!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'categoryStatues',
      field: SupportCategory.t.id,
      foreignField: _i3.SupportCategoryStatus.t
          .$_supportCategoryCategorystatuesSupportCategoryId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.SupportCategoryStatusTable(tableRelation: foreignTableRelation),
    );
    _categoryStatues = _i1.ManyRelation<_i3.SupportCategoryStatusTable>(
      tableWithRelations: relationTable,
      table: _i3.SupportCategoryStatusTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _categoryStatues!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        categoryId,
        parentCategory,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'categoryGoals') {
      return __categoryGoals;
    }
    if (relationField == 'categoryStatues') {
      return __categoryStatues;
    }
    return null;
  }
}

class SupportCategoryInclude extends _i1.IncludeObject {
  SupportCategoryInclude._({
    _i2.SupportGoalIncludeList? categoryGoals,
    _i3.SupportCategoryStatusIncludeList? categoryStatues,
  }) {
    _categoryGoals = categoryGoals;
    _categoryStatues = categoryStatues;
  }

  _i2.SupportGoalIncludeList? _categoryGoals;

  _i3.SupportCategoryStatusIncludeList? _categoryStatues;

  @override
  Map<String, _i1.Include?> get includes => {
        'categoryGoals': _categoryGoals,
        'categoryStatues': _categoryStatues,
      };

  @override
  _i1.Table<int?> get table => SupportCategory.t;
}

class SupportCategoryIncludeList extends _i1.IncludeList {
  SupportCategoryIncludeList._({
    _i1.WhereExpressionBuilder<SupportCategoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SupportCategory.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SupportCategory.t;
}

class SupportCategoryRepository {
  const SupportCategoryRepository._();

  final attach = const SupportCategoryAttachRepository._();

  final attachRow = const SupportCategoryAttachRowRepository._();

  final detach = const SupportCategoryDetachRepository._();

  final detachRow = const SupportCategoryDetachRowRepository._();

  /// Returns a list of [SupportCategory]s matching the given query parameters.
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
  Future<List<SupportCategory>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SupportCategoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SupportCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SupportCategoryTable>? orderByList,
    _i1.Transaction? transaction,
    SupportCategoryInclude? include,
  }) async {
    return session.db.find<SupportCategory>(
      where: where?.call(SupportCategory.t),
      orderBy: orderBy?.call(SupportCategory.t),
      orderByList: orderByList?.call(SupportCategory.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [SupportCategory] matching the given query parameters.
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
  Future<SupportCategory?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SupportCategoryTable>? where,
    int? offset,
    _i1.OrderByBuilder<SupportCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SupportCategoryTable>? orderByList,
    _i1.Transaction? transaction,
    SupportCategoryInclude? include,
  }) async {
    return session.db.findFirstRow<SupportCategory>(
      where: where?.call(SupportCategory.t),
      orderBy: orderBy?.call(SupportCategory.t),
      orderByList: orderByList?.call(SupportCategory.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [SupportCategory] by its [id] or null if no such row exists.
  Future<SupportCategory?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    SupportCategoryInclude? include,
  }) async {
    return session.db.findById<SupportCategory>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [SupportCategory]s in the list and returns the inserted rows.
  ///
  /// The returned [SupportCategory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SupportCategory>> insert(
    _i1.Session session,
    List<SupportCategory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SupportCategory>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SupportCategory] and returns the inserted row.
  ///
  /// The returned [SupportCategory] will have its `id` field set.
  Future<SupportCategory> insertRow(
    _i1.Session session,
    SupportCategory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SupportCategory>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SupportCategory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SupportCategory>> update(
    _i1.Session session,
    List<SupportCategory> rows, {
    _i1.ColumnSelections<SupportCategoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SupportCategory>(
      rows,
      columns: columns?.call(SupportCategory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SupportCategory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SupportCategory> updateRow(
    _i1.Session session,
    SupportCategory row, {
    _i1.ColumnSelections<SupportCategoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SupportCategory>(
      row,
      columns: columns?.call(SupportCategory.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SupportCategory]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SupportCategory>> delete(
    _i1.Session session,
    List<SupportCategory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SupportCategory>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SupportCategory].
  Future<SupportCategory> deleteRow(
    _i1.Session session,
    SupportCategory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SupportCategory>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SupportCategory>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SupportCategoryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SupportCategory>(
      where: where(SupportCategory.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SupportCategoryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SupportCategory>(
      where: where?.call(SupportCategory.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class SupportCategoryAttachRepository {
  const SupportCategoryAttachRepository._();

  /// Creates a relation between this [SupportCategory] and the given [SupportGoal]s
  /// by setting each [SupportGoal]'s foreign key `_supportCategoryCategorygoalsSupportCategoryId` to refer to this [SupportCategory].
  Future<void> categoryGoals(
    _i1.Session session,
    SupportCategory supportCategory,
    List<_i2.SupportGoal> supportGoal, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoal.any((e) => e.id == null)) {
      throw ArgumentError.notNull('supportGoal.id');
    }
    if (supportCategory.id == null) {
      throw ArgumentError.notNull('supportCategory.id');
    }

    var $supportGoal = supportGoal
        .map((e) => _i2.SupportGoalImplicit(
              e,
              $_supportCategoryCategorygoalsSupportCategoryId:
                  supportCategory.id,
            ))
        .toList();
    await session.db.update<_i2.SupportGoal>(
      $supportGoal,
      columns: [
        _i2.SupportGoal.t.$_supportCategoryCategorygoalsSupportCategoryId
      ],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [SupportCategory] and the given [SupportCategoryStatus]s
  /// by setting each [SupportCategoryStatus]'s foreign key `_supportCategoryCategorystatuesSupportCategoryId` to refer to this [SupportCategory].
  Future<void> categoryStatues(
    _i1.Session session,
    SupportCategory supportCategory,
    List<_i3.SupportCategoryStatus> supportCategoryStatus, {
    _i1.Transaction? transaction,
  }) async {
    if (supportCategoryStatus.any((e) => e.id == null)) {
      throw ArgumentError.notNull('supportCategoryStatus.id');
    }
    if (supportCategory.id == null) {
      throw ArgumentError.notNull('supportCategory.id');
    }

    var $supportCategoryStatus = supportCategoryStatus
        .map((e) => _i3.SupportCategoryStatusImplicit(
              e,
              $_supportCategoryCategorystatuesSupportCategoryId:
                  supportCategory.id,
            ))
        .toList();
    await session.db.update<_i3.SupportCategoryStatus>(
      $supportCategoryStatus,
      columns: [
        _i3.SupportCategoryStatus.t
            .$_supportCategoryCategorystatuesSupportCategoryId
      ],
      transaction: transaction,
    );
  }
}

class SupportCategoryAttachRowRepository {
  const SupportCategoryAttachRowRepository._();

  /// Creates a relation between this [SupportCategory] and the given [SupportGoal]
  /// by setting the [SupportGoal]'s foreign key `_supportCategoryCategorygoalsSupportCategoryId` to refer to this [SupportCategory].
  Future<void> categoryGoals(
    _i1.Session session,
    SupportCategory supportCategory,
    _i2.SupportGoal supportGoal, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoal.id == null) {
      throw ArgumentError.notNull('supportGoal.id');
    }
    if (supportCategory.id == null) {
      throw ArgumentError.notNull('supportCategory.id');
    }

    var $supportGoal = _i2.SupportGoalImplicit(
      supportGoal,
      $_supportCategoryCategorygoalsSupportCategoryId: supportCategory.id,
    );
    await session.db.updateRow<_i2.SupportGoal>(
      $supportGoal,
      columns: [
        _i2.SupportGoal.t.$_supportCategoryCategorygoalsSupportCategoryId
      ],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [SupportCategory] and the given [SupportCategoryStatus]
  /// by setting the [SupportCategoryStatus]'s foreign key `_supportCategoryCategorystatuesSupportCategoryId` to refer to this [SupportCategory].
  Future<void> categoryStatues(
    _i1.Session session,
    SupportCategory supportCategory,
    _i3.SupportCategoryStatus supportCategoryStatus, {
    _i1.Transaction? transaction,
  }) async {
    if (supportCategoryStatus.id == null) {
      throw ArgumentError.notNull('supportCategoryStatus.id');
    }
    if (supportCategory.id == null) {
      throw ArgumentError.notNull('supportCategory.id');
    }

    var $supportCategoryStatus = _i3.SupportCategoryStatusImplicit(
      supportCategoryStatus,
      $_supportCategoryCategorystatuesSupportCategoryId: supportCategory.id,
    );
    await session.db.updateRow<_i3.SupportCategoryStatus>(
      $supportCategoryStatus,
      columns: [
        _i3.SupportCategoryStatus.t
            .$_supportCategoryCategorystatuesSupportCategoryId
      ],
      transaction: transaction,
    );
  }
}

class SupportCategoryDetachRepository {
  const SupportCategoryDetachRepository._();

  /// Detaches the relation between this [SupportCategory] and the given [SupportGoal]
  /// by setting the [SupportGoal]'s foreign key `_supportCategoryCategorygoalsSupportCategoryId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> categoryGoals(
    _i1.Session session,
    List<_i2.SupportGoal> supportGoal, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoal.any((e) => e.id == null)) {
      throw ArgumentError.notNull('supportGoal.id');
    }

    var $supportGoal = supportGoal
        .map((e) => _i2.SupportGoalImplicit(
              e,
              $_supportCategoryCategorygoalsSupportCategoryId: null,
            ))
        .toList();
    await session.db.update<_i2.SupportGoal>(
      $supportGoal,
      columns: [
        _i2.SupportGoal.t.$_supportCategoryCategorygoalsSupportCategoryId
      ],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [SupportCategory] and the given [SupportCategoryStatus]
  /// by setting the [SupportCategoryStatus]'s foreign key `_supportCategoryCategorystatuesSupportCategoryId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> categoryStatues(
    _i1.Session session,
    List<_i3.SupportCategoryStatus> supportCategoryStatus, {
    _i1.Transaction? transaction,
  }) async {
    if (supportCategoryStatus.any((e) => e.id == null)) {
      throw ArgumentError.notNull('supportCategoryStatus.id');
    }

    var $supportCategoryStatus = supportCategoryStatus
        .map((e) => _i3.SupportCategoryStatusImplicit(
              e,
              $_supportCategoryCategorystatuesSupportCategoryId: null,
            ))
        .toList();
    await session.db.update<_i3.SupportCategoryStatus>(
      $supportCategoryStatus,
      columns: [
        _i3.SupportCategoryStatus.t
            .$_supportCategoryCategorystatuesSupportCategoryId
      ],
      transaction: transaction,
    );
  }
}

class SupportCategoryDetachRowRepository {
  const SupportCategoryDetachRowRepository._();

  /// Detaches the relation between this [SupportCategory] and the given [SupportGoal]
  /// by setting the [SupportGoal]'s foreign key `_supportCategoryCategorygoalsSupportCategoryId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> categoryGoals(
    _i1.Session session,
    _i2.SupportGoal supportGoal, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoal.id == null) {
      throw ArgumentError.notNull('supportGoal.id');
    }

    var $supportGoal = _i2.SupportGoalImplicit(
      supportGoal,
      $_supportCategoryCategorygoalsSupportCategoryId: null,
    );
    await session.db.updateRow<_i2.SupportGoal>(
      $supportGoal,
      columns: [
        _i2.SupportGoal.t.$_supportCategoryCategorygoalsSupportCategoryId
      ],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [SupportCategory] and the given [SupportCategoryStatus]
  /// by setting the [SupportCategoryStatus]'s foreign key `_supportCategoryCategorystatuesSupportCategoryId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> categoryStatues(
    _i1.Session session,
    _i3.SupportCategoryStatus supportCategoryStatus, {
    _i1.Transaction? transaction,
  }) async {
    if (supportCategoryStatus.id == null) {
      throw ArgumentError.notNull('supportCategoryStatus.id');
    }

    var $supportCategoryStatus = _i3.SupportCategoryStatusImplicit(
      supportCategoryStatus,
      $_supportCategoryCategorystatuesSupportCategoryId: null,
    );
    await session.db.updateRow<_i3.SupportCategoryStatus>(
      $supportCategoryStatus,
      columns: [
        _i3.SupportCategoryStatus.t
            .$_supportCategoryCategorystatuesSupportCategoryId
      ],
      transaction: transaction,
    );
  }
}

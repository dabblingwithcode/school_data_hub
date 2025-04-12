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
import '../../../learning/timetable/lesson/lesson.dart' as _i2;

abstract class LessonSubject
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  LessonSubject._({
    this.id,
    required this.name,
    this.description,
    this.lessons,
  });

  factory LessonSubject({
    int? id,
    required String name,
    String? description,
    List<_i2.Lesson>? lessons,
  }) = _LessonSubjectImpl;

  factory LessonSubject.fromJson(Map<String, dynamic> jsonSerialization) {
    return LessonSubject(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      lessons: (jsonSerialization['lessons'] as List?)
          ?.map((e) => _i2.Lesson.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = LessonSubjectTable();

  static const db = LessonSubjectRepository._();

  @override
  int? id;

  String name;

  String? description;

  List<_i2.Lesson>? lessons;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [LessonSubject]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LessonSubject copyWith({
    int? id,
    String? name,
    String? description,
    List<_i2.Lesson>? lessons,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      if (description != null) 'description': description,
      if (lessons != null)
        'lessons': lessons?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      if (description != null) 'description': description,
      if (lessons != null)
        'lessons': lessons?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static LessonSubjectInclude include({_i2.LessonIncludeList? lessons}) {
    return LessonSubjectInclude._(lessons: lessons);
  }

  static LessonSubjectIncludeList includeList({
    _i1.WhereExpressionBuilder<LessonSubjectTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LessonSubjectTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LessonSubjectTable>? orderByList,
    LessonSubjectInclude? include,
  }) {
    return LessonSubjectIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LessonSubject.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LessonSubject.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LessonSubjectImpl extends LessonSubject {
  _LessonSubjectImpl({
    int? id,
    required String name,
    String? description,
    List<_i2.Lesson>? lessons,
  }) : super._(
          id: id,
          name: name,
          description: description,
          lessons: lessons,
        );

  /// Returns a shallow copy of this [LessonSubject]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LessonSubject copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    Object? lessons = _Undefined,
  }) {
    return LessonSubject(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      lessons: lessons is List<_i2.Lesson>?
          ? lessons
          : this.lessons?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class LessonSubjectTable extends _i1.Table<int> {
  LessonSubjectTable({super.tableRelation})
      : super(tableName: 'lesson_subject') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  _i2.LessonTable? ___lessons;

  _i1.ManyRelation<_i2.LessonTable>? _lessons;

  _i2.LessonTable get __lessons {
    if (___lessons != null) return ___lessons!;
    ___lessons = _i1.createRelationTable(
      relationFieldName: '__lessons',
      field: LessonSubject.t.id,
      foreignField: _i2.Lesson.t.subjectId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.LessonTable(tableRelation: foreignTableRelation),
    );
    return ___lessons!;
  }

  _i1.ManyRelation<_i2.LessonTable> get lessons {
    if (_lessons != null) return _lessons!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'lessons',
      field: LessonSubject.t.id,
      foreignField: _i2.Lesson.t.subjectId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.LessonTable(tableRelation: foreignTableRelation),
    );
    _lessons = _i1.ManyRelation<_i2.LessonTable>(
      tableWithRelations: relationTable,
      table: _i2.LessonTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _lessons!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        description,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'lessons') {
      return __lessons;
    }
    return null;
  }
}

class LessonSubjectInclude extends _i1.IncludeObject {
  LessonSubjectInclude._({_i2.LessonIncludeList? lessons}) {
    _lessons = lessons;
  }

  _i2.LessonIncludeList? _lessons;

  @override
  Map<String, _i1.Include?> get includes => {'lessons': _lessons};

  @override
  _i1.Table<int> get table => LessonSubject.t;
}

class LessonSubjectIncludeList extends _i1.IncludeList {
  LessonSubjectIncludeList._({
    _i1.WhereExpressionBuilder<LessonSubjectTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LessonSubject.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => LessonSubject.t;
}

class LessonSubjectRepository {
  const LessonSubjectRepository._();

  final attach = const LessonSubjectAttachRepository._();

  final attachRow = const LessonSubjectAttachRowRepository._();

  /// Returns a list of [LessonSubject]s matching the given query parameters.
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
  Future<List<LessonSubject>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LessonSubjectTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LessonSubjectTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LessonSubjectTable>? orderByList,
    _i1.Transaction? transaction,
    LessonSubjectInclude? include,
  }) async {
    return session.db.find<LessonSubject>(
      where: where?.call(LessonSubject.t),
      orderBy: orderBy?.call(LessonSubject.t),
      orderByList: orderByList?.call(LessonSubject.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [LessonSubject] matching the given query parameters.
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
  Future<LessonSubject?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LessonSubjectTable>? where,
    int? offset,
    _i1.OrderByBuilder<LessonSubjectTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LessonSubjectTable>? orderByList,
    _i1.Transaction? transaction,
    LessonSubjectInclude? include,
  }) async {
    return session.db.findFirstRow<LessonSubject>(
      where: where?.call(LessonSubject.t),
      orderBy: orderBy?.call(LessonSubject.t),
      orderByList: orderByList?.call(LessonSubject.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [LessonSubject] by its [id] or null if no such row exists.
  Future<LessonSubject?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    LessonSubjectInclude? include,
  }) async {
    return session.db.findById<LessonSubject>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [LessonSubject]s in the list and returns the inserted rows.
  ///
  /// The returned [LessonSubject]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<LessonSubject>> insert(
    _i1.Session session,
    List<LessonSubject> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<LessonSubject>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [LessonSubject] and returns the inserted row.
  ///
  /// The returned [LessonSubject] will have its `id` field set.
  Future<LessonSubject> insertRow(
    _i1.Session session,
    LessonSubject row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LessonSubject>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LessonSubject]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LessonSubject>> update(
    _i1.Session session,
    List<LessonSubject> rows, {
    _i1.ColumnSelections<LessonSubjectTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LessonSubject>(
      rows,
      columns: columns?.call(LessonSubject.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LessonSubject]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LessonSubject> updateRow(
    _i1.Session session,
    LessonSubject row, {
    _i1.ColumnSelections<LessonSubjectTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LessonSubject>(
      row,
      columns: columns?.call(LessonSubject.t),
      transaction: transaction,
    );
  }

  /// Deletes all [LessonSubject]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LessonSubject>> delete(
    _i1.Session session,
    List<LessonSubject> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LessonSubject>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LessonSubject].
  Future<LessonSubject> deleteRow(
    _i1.Session session,
    LessonSubject row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LessonSubject>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LessonSubject>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<LessonSubjectTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LessonSubject>(
      where: where(LessonSubject.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LessonSubjectTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LessonSubject>(
      where: where?.call(LessonSubject.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class LessonSubjectAttachRepository {
  const LessonSubjectAttachRepository._();

  /// Creates a relation between this [LessonSubject] and the given [Lesson]s
  /// by setting each [Lesson]'s foreign key `subjectId` to refer to this [LessonSubject].
  Future<void> lessons(
    _i1.Session session,
    LessonSubject lessonSubject,
    List<_i2.Lesson> lesson, {
    _i1.Transaction? transaction,
  }) async {
    if (lesson.any((e) => e.id == null)) {
      throw ArgumentError.notNull('lesson.id');
    }
    if (lessonSubject.id == null) {
      throw ArgumentError.notNull('lessonSubject.id');
    }

    var $lesson =
        lesson.map((e) => e.copyWith(subjectId: lessonSubject.id)).toList();
    await session.db.update<_i2.Lesson>(
      $lesson,
      columns: [_i2.Lesson.t.subjectId],
      transaction: transaction,
    );
  }
}

class LessonSubjectAttachRowRepository {
  const LessonSubjectAttachRowRepository._();

  /// Creates a relation between this [LessonSubject] and the given [Lesson]
  /// by setting the [Lesson]'s foreign key `subjectId` to refer to this [LessonSubject].
  Future<void> lessons(
    _i1.Session session,
    LessonSubject lessonSubject,
    _i2.Lesson lesson, {
    _i1.Transaction? transaction,
  }) async {
    if (lesson.id == null) {
      throw ArgumentError.notNull('lesson.id');
    }
    if (lessonSubject.id == null) {
      throw ArgumentError.notNull('lessonSubject.id');
    }

    var $lesson = lesson.copyWith(subjectId: lessonSubject.id);
    await session.db.updateRow<_i2.Lesson>(
      $lesson,
      columns: [_i2.Lesson.t.subjectId],
      transaction: transaction,
    );
  }
}

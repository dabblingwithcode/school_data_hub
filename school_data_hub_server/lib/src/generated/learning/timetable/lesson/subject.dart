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
import '../../../learning/timetable/lesson/scheduled_lesson.dart' as _i2;

abstract class Subject implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  Subject._({
    this.id,
    required this.publicId,
    required this.name,
    this.description,
    this.color,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedBy,
    this.scheduledLessons,
  });

  factory Subject({
    int? id,
    required String publicId,
    required String name,
    String? description,
    String? color,
    required String createdBy,
    required DateTime createdAt,
    required String modifiedBy,
    List<_i2.ScheduledLesson>? scheduledLessons,
  }) = _SubjectImpl;

  factory Subject.fromJson(Map<String, dynamic> jsonSerialization) {
    return Subject(
      id: jsonSerialization['id'] as int?,
      publicId: jsonSerialization['publicId'] as String,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      color: jsonSerialization['color'] as String?,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      modifiedBy: jsonSerialization['modifiedBy'] as String,
      scheduledLessons: (jsonSerialization['scheduledLessons'] as List?)
          ?.map(
              (e) => _i2.ScheduledLesson.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = SubjectTable();

  static const db = SubjectRepository._();

  @override
  int? id;

  String publicId;

  String name;

  String? description;

  String? color;

  String createdBy;

  DateTime createdAt;

  String modifiedBy;

  List<_i2.ScheduledLesson>? scheduledLessons;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [Subject]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Subject copyWith({
    int? id,
    String? publicId,
    String? name,
    String? description,
    String? color,
    String? createdBy,
    DateTime? createdAt,
    String? modifiedBy,
    List<_i2.ScheduledLesson>? scheduledLessons,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'publicId': publicId,
      'name': name,
      if (description != null) 'description': description,
      if (color != null) 'color': color,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'modifiedBy': modifiedBy,
      if (scheduledLessons != null)
        'scheduledLessons':
            scheduledLessons?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'publicId': publicId,
      'name': name,
      if (description != null) 'description': description,
      if (color != null) 'color': color,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'modifiedBy': modifiedBy,
      if (scheduledLessons != null)
        'scheduledLessons':
            scheduledLessons?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static SubjectInclude include(
      {_i2.ScheduledLessonIncludeList? scheduledLessons}) {
    return SubjectInclude._(scheduledLessons: scheduledLessons);
  }

  static SubjectIncludeList includeList({
    _i1.WhereExpressionBuilder<SubjectTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubjectTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubjectTable>? orderByList,
    SubjectInclude? include,
  }) {
    return SubjectIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Subject.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Subject.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubjectImpl extends Subject {
  _SubjectImpl({
    int? id,
    required String publicId,
    required String name,
    String? description,
    String? color,
    required String createdBy,
    required DateTime createdAt,
    required String modifiedBy,
    List<_i2.ScheduledLesson>? scheduledLessons,
  }) : super._(
          id: id,
          publicId: publicId,
          name: name,
          description: description,
          color: color,
          createdBy: createdBy,
          createdAt: createdAt,
          modifiedBy: modifiedBy,
          scheduledLessons: scheduledLessons,
        );

  /// Returns a shallow copy of this [Subject]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Subject copyWith({
    Object? id = _Undefined,
    String? publicId,
    String? name,
    Object? description = _Undefined,
    Object? color = _Undefined,
    String? createdBy,
    DateTime? createdAt,
    String? modifiedBy,
    Object? scheduledLessons = _Undefined,
  }) {
    return Subject(
      id: id is int? ? id : this.id,
      publicId: publicId ?? this.publicId,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      color: color is String? ? color : this.color,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      scheduledLessons: scheduledLessons is List<_i2.ScheduledLesson>?
          ? scheduledLessons
          : this.scheduledLessons?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class SubjectTable extends _i1.Table<int> {
  SubjectTable({super.tableRelation}) : super(tableName: 'subject') {
    publicId = _i1.ColumnString(
      'publicId',
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
    color = _i1.ColumnString(
      'color',
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
  }

  late final _i1.ColumnString publicId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString color;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnString modifiedBy;

  _i2.ScheduledLessonTable? ___scheduledLessons;

  _i1.ManyRelation<_i2.ScheduledLessonTable>? _scheduledLessons;

  _i2.ScheduledLessonTable get __scheduledLessons {
    if (___scheduledLessons != null) return ___scheduledLessons!;
    ___scheduledLessons = _i1.createRelationTable(
      relationFieldName: '__scheduledLessons',
      field: Subject.t.id,
      foreignField: _i2.ScheduledLesson.t.subjectId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ScheduledLessonTable(tableRelation: foreignTableRelation),
    );
    return ___scheduledLessons!;
  }

  _i1.ManyRelation<_i2.ScheduledLessonTable> get scheduledLessons {
    if (_scheduledLessons != null) return _scheduledLessons!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'scheduledLessons',
      field: Subject.t.id,
      foreignField: _i2.ScheduledLesson.t.subjectId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ScheduledLessonTable(tableRelation: foreignTableRelation),
    );
    _scheduledLessons = _i1.ManyRelation<_i2.ScheduledLessonTable>(
      tableWithRelations: relationTable,
      table: _i2.ScheduledLessonTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _scheduledLessons!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        publicId,
        name,
        description,
        color,
        createdBy,
        createdAt,
        modifiedBy,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'scheduledLessons') {
      return __scheduledLessons;
    }
    return null;
  }
}

class SubjectInclude extends _i1.IncludeObject {
  SubjectInclude._({_i2.ScheduledLessonIncludeList? scheduledLessons}) {
    _scheduledLessons = scheduledLessons;
  }

  _i2.ScheduledLessonIncludeList? _scheduledLessons;

  @override
  Map<String, _i1.Include?> get includes =>
      {'scheduledLessons': _scheduledLessons};

  @override
  _i1.Table<int> get table => Subject.t;
}

class SubjectIncludeList extends _i1.IncludeList {
  SubjectIncludeList._({
    _i1.WhereExpressionBuilder<SubjectTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Subject.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => Subject.t;
}

class SubjectRepository {
  const SubjectRepository._();

  final attach = const SubjectAttachRepository._();

  final attachRow = const SubjectAttachRowRepository._();

  /// Returns a list of [Subject]s matching the given query parameters.
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
  Future<List<Subject>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SubjectTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubjectTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubjectTable>? orderByList,
    _i1.Transaction? transaction,
    SubjectInclude? include,
  }) async {
    return session.db.find<Subject>(
      where: where?.call(Subject.t),
      orderBy: orderBy?.call(Subject.t),
      orderByList: orderByList?.call(Subject.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Subject] matching the given query parameters.
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
  Future<Subject?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SubjectTable>? where,
    int? offset,
    _i1.OrderByBuilder<SubjectTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubjectTable>? orderByList,
    _i1.Transaction? transaction,
    SubjectInclude? include,
  }) async {
    return session.db.findFirstRow<Subject>(
      where: where?.call(Subject.t),
      orderBy: orderBy?.call(Subject.t),
      orderByList: orderByList?.call(Subject.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Subject] by its [id] or null if no such row exists.
  Future<Subject?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    SubjectInclude? include,
  }) async {
    return session.db.findById<Subject>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Subject]s in the list and returns the inserted rows.
  ///
  /// The returned [Subject]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Subject>> insert(
    _i1.Session session,
    List<Subject> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Subject>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Subject] and returns the inserted row.
  ///
  /// The returned [Subject] will have its `id` field set.
  Future<Subject> insertRow(
    _i1.Session session,
    Subject row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Subject>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Subject]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Subject>> update(
    _i1.Session session,
    List<Subject> rows, {
    _i1.ColumnSelections<SubjectTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Subject>(
      rows,
      columns: columns?.call(Subject.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Subject]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Subject> updateRow(
    _i1.Session session,
    Subject row, {
    _i1.ColumnSelections<SubjectTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Subject>(
      row,
      columns: columns?.call(Subject.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Subject]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Subject>> delete(
    _i1.Session session,
    List<Subject> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Subject>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Subject].
  Future<Subject> deleteRow(
    _i1.Session session,
    Subject row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Subject>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Subject>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SubjectTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Subject>(
      where: where(Subject.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SubjectTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Subject>(
      where: where?.call(Subject.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class SubjectAttachRepository {
  const SubjectAttachRepository._();

  /// Creates a relation between this [Subject] and the given [ScheduledLesson]s
  /// by setting each [ScheduledLesson]'s foreign key `subjectId` to refer to this [Subject].
  Future<void> scheduledLessons(
    _i1.Session session,
    Subject subject,
    List<_i2.ScheduledLesson> scheduledLesson, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLesson.any((e) => e.id == null)) {
      throw ArgumentError.notNull('scheduledLesson.id');
    }
    if (subject.id == null) {
      throw ArgumentError.notNull('subject.id');
    }

    var $scheduledLesson =
        scheduledLesson.map((e) => e.copyWith(subjectId: subject.id)).toList();
    await session.db.update<_i2.ScheduledLesson>(
      $scheduledLesson,
      columns: [_i2.ScheduledLesson.t.subjectId],
      transaction: transaction,
    );
  }
}

class SubjectAttachRowRepository {
  const SubjectAttachRowRepository._();

  /// Creates a relation between this [Subject] and the given [ScheduledLesson]
  /// by setting the [ScheduledLesson]'s foreign key `subjectId` to refer to this [Subject].
  Future<void> scheduledLessons(
    _i1.Session session,
    Subject subject,
    _i2.ScheduledLesson scheduledLesson, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLesson.id == null) {
      throw ArgumentError.notNull('scheduledLesson.id');
    }
    if (subject.id == null) {
      throw ArgumentError.notNull('subject.id');
    }

    var $scheduledLesson = scheduledLesson.copyWith(subjectId: subject.id);
    await session.db.updateRow<_i2.ScheduledLesson>(
      $scheduledLesson,
      columns: [_i2.ScheduledLesson.t.subjectId],
      transaction: transaction,
    );
  }
}

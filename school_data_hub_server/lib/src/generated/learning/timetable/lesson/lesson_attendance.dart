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
import '../../../learning/timetable/lesson/lesson.dart' as _i2;
import '../../../pupil_data/pupil_data.dart' as _i3;

abstract class LessonAttendance
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  LessonAttendance._({
    this.id,
    required this.lessonId,
    this.lesson,
    required this.pupilId,
    this.pupil,
    this.comment,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedBy,
    required this.modifiedAt,
  });

  factory LessonAttendance({
    int? id,
    required int lessonId,
    _i2.Lesson? lesson,
    required int pupilId,
    _i3.PupilData? pupil,
    String? comment,
    required String createdBy,
    required DateTime createdAt,
    required String modifiedBy,
    required DateTime modifiedAt,
  }) = _LessonAttendanceImpl;

  factory LessonAttendance.fromJson(Map<String, dynamic> jsonSerialization) {
    return LessonAttendance(
      id: jsonSerialization['id'] as int?,
      lessonId: jsonSerialization['lessonId'] as int,
      lesson: jsonSerialization['lesson'] == null
          ? null
          : _i2.Lesson.fromJson(
              (jsonSerialization['lesson'] as Map<String, dynamic>)),
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i3.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
      comment: jsonSerialization['comment'] as String?,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      modifiedBy: jsonSerialization['modifiedBy'] as String,
      modifiedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['modifiedAt']),
    );
  }

  static final t = LessonAttendanceTable();

  static const db = LessonAttendanceRepository._();

  @override
  int? id;

  int lessonId;

  _i2.Lesson? lesson;

  int pupilId;

  _i3.PupilData? pupil;

  String? comment;

  String createdBy;

  DateTime createdAt;

  String modifiedBy;

  DateTime modifiedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [LessonAttendance]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LessonAttendance copyWith({
    int? id,
    int? lessonId,
    _i2.Lesson? lesson,
    int? pupilId,
    _i3.PupilData? pupil,
    String? comment,
    String? createdBy,
    DateTime? createdAt,
    String? modifiedBy,
    DateTime? modifiedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'lessonId': lessonId,
      if (lesson != null) 'lesson': lesson?.toJson(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
      if (comment != null) 'comment': comment,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'modifiedBy': modifiedBy,
      'modifiedAt': modifiedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'lessonId': lessonId,
      if (lesson != null) 'lesson': lesson?.toJsonForProtocol(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJsonForProtocol(),
      if (comment != null) 'comment': comment,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'modifiedBy': modifiedBy,
      'modifiedAt': modifiedAt.toJson(),
    };
  }

  static LessonAttendanceInclude include({
    _i2.LessonInclude? lesson,
    _i3.PupilDataInclude? pupil,
  }) {
    return LessonAttendanceInclude._(
      lesson: lesson,
      pupil: pupil,
    );
  }

  static LessonAttendanceIncludeList includeList({
    _i1.WhereExpressionBuilder<LessonAttendanceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LessonAttendanceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LessonAttendanceTable>? orderByList,
    LessonAttendanceInclude? include,
  }) {
    return LessonAttendanceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LessonAttendance.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LessonAttendance.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LessonAttendanceImpl extends LessonAttendance {
  _LessonAttendanceImpl({
    int? id,
    required int lessonId,
    _i2.Lesson? lesson,
    required int pupilId,
    _i3.PupilData? pupil,
    String? comment,
    required String createdBy,
    required DateTime createdAt,
    required String modifiedBy,
    required DateTime modifiedAt,
  }) : super._(
          id: id,
          lessonId: lessonId,
          lesson: lesson,
          pupilId: pupilId,
          pupil: pupil,
          comment: comment,
          createdBy: createdBy,
          createdAt: createdAt,
          modifiedBy: modifiedBy,
          modifiedAt: modifiedAt,
        );

  /// Returns a shallow copy of this [LessonAttendance]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LessonAttendance copyWith({
    Object? id = _Undefined,
    int? lessonId,
    Object? lesson = _Undefined,
    int? pupilId,
    Object? pupil = _Undefined,
    Object? comment = _Undefined,
    String? createdBy,
    DateTime? createdAt,
    String? modifiedBy,
    DateTime? modifiedAt,
  }) {
    return LessonAttendance(
      id: id is int? ? id : this.id,
      lessonId: lessonId ?? this.lessonId,
      lesson: lesson is _i2.Lesson? ? lesson : this.lesson?.copyWith(),
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i3.PupilData? ? pupil : this.pupil?.copyWith(),
      comment: comment is String? ? comment : this.comment,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }
}

class LessonAttendanceTable extends _i1.Table<int?> {
  LessonAttendanceTable({super.tableRelation})
      : super(tableName: 'lesson_attendance') {
    lessonId = _i1.ColumnInt(
      'lessonId',
      this,
    );
    pupilId = _i1.ColumnInt(
      'pupilId',
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
    modifiedBy = _i1.ColumnString(
      'modifiedBy',
      this,
    );
    modifiedAt = _i1.ColumnDateTime(
      'modifiedAt',
      this,
    );
  }

  late final _i1.ColumnInt lessonId;

  _i2.LessonTable? _lesson;

  late final _i1.ColumnInt pupilId;

  _i3.PupilDataTable? _pupil;

  late final _i1.ColumnString comment;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnString modifiedBy;

  late final _i1.ColumnDateTime modifiedAt;

  _i2.LessonTable get lesson {
    if (_lesson != null) return _lesson!;
    _lesson = _i1.createRelationTable(
      relationFieldName: 'lesson',
      field: LessonAttendance.t.lessonId,
      foreignField: _i2.Lesson.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.LessonTable(tableRelation: foreignTableRelation),
    );
    return _lesson!;
  }

  _i3.PupilDataTable get pupil {
    if (_pupil != null) return _pupil!;
    _pupil = _i1.createRelationTable(
      relationFieldName: 'pupil',
      field: LessonAttendance.t.pupilId,
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
        lessonId,
        pupilId,
        comment,
        createdBy,
        createdAt,
        modifiedBy,
        modifiedAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'lesson') {
      return lesson;
    }
    if (relationField == 'pupil') {
      return pupil;
    }
    return null;
  }
}

class LessonAttendanceInclude extends _i1.IncludeObject {
  LessonAttendanceInclude._({
    _i2.LessonInclude? lesson,
    _i3.PupilDataInclude? pupil,
  }) {
    _lesson = lesson;
    _pupil = pupil;
  }

  _i2.LessonInclude? _lesson;

  _i3.PupilDataInclude? _pupil;

  @override
  Map<String, _i1.Include?> get includes => {
        'lesson': _lesson,
        'pupil': _pupil,
      };

  @override
  _i1.Table<int?> get table => LessonAttendance.t;
}

class LessonAttendanceIncludeList extends _i1.IncludeList {
  LessonAttendanceIncludeList._({
    _i1.WhereExpressionBuilder<LessonAttendanceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LessonAttendance.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => LessonAttendance.t;
}

class LessonAttendanceRepository {
  const LessonAttendanceRepository._();

  final attachRow = const LessonAttendanceAttachRowRepository._();

  /// Returns a list of [LessonAttendance]s matching the given query parameters.
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
  Future<List<LessonAttendance>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LessonAttendanceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LessonAttendanceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LessonAttendanceTable>? orderByList,
    _i1.Transaction? transaction,
    LessonAttendanceInclude? include,
  }) async {
    return session.db.find<LessonAttendance>(
      where: where?.call(LessonAttendance.t),
      orderBy: orderBy?.call(LessonAttendance.t),
      orderByList: orderByList?.call(LessonAttendance.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [LessonAttendance] matching the given query parameters.
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
  Future<LessonAttendance?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LessonAttendanceTable>? where,
    int? offset,
    _i1.OrderByBuilder<LessonAttendanceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LessonAttendanceTable>? orderByList,
    _i1.Transaction? transaction,
    LessonAttendanceInclude? include,
  }) async {
    return session.db.findFirstRow<LessonAttendance>(
      where: where?.call(LessonAttendance.t),
      orderBy: orderBy?.call(LessonAttendance.t),
      orderByList: orderByList?.call(LessonAttendance.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [LessonAttendance] by its [id] or null if no such row exists.
  Future<LessonAttendance?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    LessonAttendanceInclude? include,
  }) async {
    return session.db.findById<LessonAttendance>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [LessonAttendance]s in the list and returns the inserted rows.
  ///
  /// The returned [LessonAttendance]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<LessonAttendance>> insert(
    _i1.Session session,
    List<LessonAttendance> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<LessonAttendance>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [LessonAttendance] and returns the inserted row.
  ///
  /// The returned [LessonAttendance] will have its `id` field set.
  Future<LessonAttendance> insertRow(
    _i1.Session session,
    LessonAttendance row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LessonAttendance>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LessonAttendance]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LessonAttendance>> update(
    _i1.Session session,
    List<LessonAttendance> rows, {
    _i1.ColumnSelections<LessonAttendanceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LessonAttendance>(
      rows,
      columns: columns?.call(LessonAttendance.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LessonAttendance]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LessonAttendance> updateRow(
    _i1.Session session,
    LessonAttendance row, {
    _i1.ColumnSelections<LessonAttendanceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LessonAttendance>(
      row,
      columns: columns?.call(LessonAttendance.t),
      transaction: transaction,
    );
  }

  /// Deletes all [LessonAttendance]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LessonAttendance>> delete(
    _i1.Session session,
    List<LessonAttendance> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LessonAttendance>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LessonAttendance].
  Future<LessonAttendance> deleteRow(
    _i1.Session session,
    LessonAttendance row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LessonAttendance>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LessonAttendance>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<LessonAttendanceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LessonAttendance>(
      where: where(LessonAttendance.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LessonAttendanceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LessonAttendance>(
      where: where?.call(LessonAttendance.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class LessonAttendanceAttachRowRepository {
  const LessonAttendanceAttachRowRepository._();

  /// Creates a relation between the given [LessonAttendance] and [Lesson]
  /// by setting the [LessonAttendance]'s foreign key `lessonId` to refer to the [Lesson].
  Future<void> lesson(
    _i1.Session session,
    LessonAttendance lessonAttendance,
    _i2.Lesson lesson, {
    _i1.Transaction? transaction,
  }) async {
    if (lessonAttendance.id == null) {
      throw ArgumentError.notNull('lessonAttendance.id');
    }
    if (lesson.id == null) {
      throw ArgumentError.notNull('lesson.id');
    }

    var $lessonAttendance = lessonAttendance.copyWith(lessonId: lesson.id);
    await session.db.updateRow<LessonAttendance>(
      $lessonAttendance,
      columns: [LessonAttendance.t.lessonId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [LessonAttendance] and [PupilData]
  /// by setting the [LessonAttendance]'s foreign key `pupilId` to refer to the [PupilData].
  Future<void> pupil(
    _i1.Session session,
    LessonAttendance lessonAttendance,
    _i3.PupilData pupil, {
    _i1.Transaction? transaction,
  }) async {
    if (lessonAttendance.id == null) {
      throw ArgumentError.notNull('lessonAttendance.id');
    }
    if (pupil.id == null) {
      throw ArgumentError.notNull('pupil.id');
    }

    var $lessonAttendance = lessonAttendance.copyWith(pupilId: pupil.id);
    await session.db.updateRow<LessonAttendance>(
      $lessonAttendance,
      columns: [LessonAttendance.t.pupilId],
      transaction: transaction,
    );
  }
}

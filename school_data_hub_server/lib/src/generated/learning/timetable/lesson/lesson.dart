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
import '../../../learning/timetable/lesson/lesson_attendance.dart' as _i2;
import '../../../learning/timetable/lesson/lesson_subject.dart' as _i3;

abstract class Lesson implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Lesson._({
    this.id,
    required this.publicId,
    this.attendedPupils,
    required this.subjectId,
    this.subject,
  });

  factory Lesson({
    int? id,
    required String publicId,
    List<_i2.LessonAttendance>? attendedPupils,
    required int subjectId,
    _i3.LessonSubject? subject,
  }) = _LessonImpl;

  factory Lesson.fromJson(Map<String, dynamic> jsonSerialization) {
    return Lesson(
      id: jsonSerialization['id'] as int?,
      publicId: jsonSerialization['publicId'] as String,
      attendedPupils: (jsonSerialization['attendedPupils'] as List?)
          ?.map(
              (e) => _i2.LessonAttendance.fromJson((e as Map<String, dynamic>)))
          .toList(),
      subjectId: jsonSerialization['subjectId'] as int,
      subject: jsonSerialization['subject'] == null
          ? null
          : _i3.LessonSubject.fromJson(
              (jsonSerialization['subject'] as Map<String, dynamic>)),
    );
  }

  static final t = LessonTable();

  static const db = LessonRepository._();

  @override
  int? id;

  String publicId;

  List<_i2.LessonAttendance>? attendedPupils;

  int subjectId;

  _i3.LessonSubject? subject;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Lesson]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Lesson copyWith({
    int? id,
    String? publicId,
    List<_i2.LessonAttendance>? attendedPupils,
    int? subjectId,
    _i3.LessonSubject? subject,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'publicId': publicId,
      if (attendedPupils != null)
        'attendedPupils':
            attendedPupils?.toJson(valueToJson: (v) => v.toJson()),
      'subjectId': subjectId,
      if (subject != null) 'subject': subject?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'publicId': publicId,
      if (attendedPupils != null)
        'attendedPupils':
            attendedPupils?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'subjectId': subjectId,
      if (subject != null) 'subject': subject?.toJsonForProtocol(),
    };
  }

  static LessonInclude include({
    _i2.LessonAttendanceIncludeList? attendedPupils,
    _i3.LessonSubjectInclude? subject,
  }) {
    return LessonInclude._(
      attendedPupils: attendedPupils,
      subject: subject,
    );
  }

  static LessonIncludeList includeList({
    _i1.WhereExpressionBuilder<LessonTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LessonTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LessonTable>? orderByList,
    LessonInclude? include,
  }) {
    return LessonIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Lesson.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Lesson.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LessonImpl extends Lesson {
  _LessonImpl({
    int? id,
    required String publicId,
    List<_i2.LessonAttendance>? attendedPupils,
    required int subjectId,
    _i3.LessonSubject? subject,
  }) : super._(
          id: id,
          publicId: publicId,
          attendedPupils: attendedPupils,
          subjectId: subjectId,
          subject: subject,
        );

  /// Returns a shallow copy of this [Lesson]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Lesson copyWith({
    Object? id = _Undefined,
    String? publicId,
    Object? attendedPupils = _Undefined,
    int? subjectId,
    Object? subject = _Undefined,
  }) {
    return Lesson(
      id: id is int? ? id : this.id,
      publicId: publicId ?? this.publicId,
      attendedPupils: attendedPupils is List<_i2.LessonAttendance>?
          ? attendedPupils
          : this.attendedPupils?.map((e0) => e0.copyWith()).toList(),
      subjectId: subjectId ?? this.subjectId,
      subject:
          subject is _i3.LessonSubject? ? subject : this.subject?.copyWith(),
    );
  }
}

class LessonTable extends _i1.Table<int?> {
  LessonTable({super.tableRelation}) : super(tableName: 'lesson') {
    publicId = _i1.ColumnString(
      'publicId',
      this,
    );
    subjectId = _i1.ColumnInt(
      'subjectId',
      this,
    );
  }

  late final _i1.ColumnString publicId;

  _i2.LessonAttendanceTable? ___attendedPupils;

  _i1.ManyRelation<_i2.LessonAttendanceTable>? _attendedPupils;

  late final _i1.ColumnInt subjectId;

  _i3.LessonSubjectTable? _subject;

  _i2.LessonAttendanceTable get __attendedPupils {
    if (___attendedPupils != null) return ___attendedPupils!;
    ___attendedPupils = _i1.createRelationTable(
      relationFieldName: '__attendedPupils',
      field: Lesson.t.id,
      foreignField: _i2.LessonAttendance.t.lessonId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.LessonAttendanceTable(tableRelation: foreignTableRelation),
    );
    return ___attendedPupils!;
  }

  _i3.LessonSubjectTable get subject {
    if (_subject != null) return _subject!;
    _subject = _i1.createRelationTable(
      relationFieldName: 'subject',
      field: Lesson.t.subjectId,
      foreignField: _i3.LessonSubject.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.LessonSubjectTable(tableRelation: foreignTableRelation),
    );
    return _subject!;
  }

  _i1.ManyRelation<_i2.LessonAttendanceTable> get attendedPupils {
    if (_attendedPupils != null) return _attendedPupils!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'attendedPupils',
      field: Lesson.t.id,
      foreignField: _i2.LessonAttendance.t.lessonId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.LessonAttendanceTable(tableRelation: foreignTableRelation),
    );
    _attendedPupils = _i1.ManyRelation<_i2.LessonAttendanceTable>(
      tableWithRelations: relationTable,
      table: _i2.LessonAttendanceTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _attendedPupils!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        publicId,
        subjectId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'attendedPupils') {
      return __attendedPupils;
    }
    if (relationField == 'subject') {
      return subject;
    }
    return null;
  }
}

class LessonInclude extends _i1.IncludeObject {
  LessonInclude._({
    _i2.LessonAttendanceIncludeList? attendedPupils,
    _i3.LessonSubjectInclude? subject,
  }) {
    _attendedPupils = attendedPupils;
    _subject = subject;
  }

  _i2.LessonAttendanceIncludeList? _attendedPupils;

  _i3.LessonSubjectInclude? _subject;

  @override
  Map<String, _i1.Include?> get includes => {
        'attendedPupils': _attendedPupils,
        'subject': _subject,
      };

  @override
  _i1.Table<int?> get table => Lesson.t;
}

class LessonIncludeList extends _i1.IncludeList {
  LessonIncludeList._({
    _i1.WhereExpressionBuilder<LessonTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Lesson.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Lesson.t;
}

class LessonRepository {
  const LessonRepository._();

  final attach = const LessonAttachRepository._();

  final attachRow = const LessonAttachRowRepository._();

  final detach = const LessonDetachRepository._();

  final detachRow = const LessonDetachRowRepository._();

  /// Returns a list of [Lesson]s matching the given query parameters.
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
  Future<List<Lesson>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LessonTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LessonTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LessonTable>? orderByList,
    _i1.Transaction? transaction,
    LessonInclude? include,
  }) async {
    return session.db.find<Lesson>(
      where: where?.call(Lesson.t),
      orderBy: orderBy?.call(Lesson.t),
      orderByList: orderByList?.call(Lesson.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Lesson] matching the given query parameters.
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
  Future<Lesson?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LessonTable>? where,
    int? offset,
    _i1.OrderByBuilder<LessonTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LessonTable>? orderByList,
    _i1.Transaction? transaction,
    LessonInclude? include,
  }) async {
    return session.db.findFirstRow<Lesson>(
      where: where?.call(Lesson.t),
      orderBy: orderBy?.call(Lesson.t),
      orderByList: orderByList?.call(Lesson.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Lesson] by its [id] or null if no such row exists.
  Future<Lesson?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    LessonInclude? include,
  }) async {
    return session.db.findById<Lesson>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Lesson]s in the list and returns the inserted rows.
  ///
  /// The returned [Lesson]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Lesson>> insert(
    _i1.Session session,
    List<Lesson> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Lesson>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Lesson] and returns the inserted row.
  ///
  /// The returned [Lesson] will have its `id` field set.
  Future<Lesson> insertRow(
    _i1.Session session,
    Lesson row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Lesson>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Lesson]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Lesson>> update(
    _i1.Session session,
    List<Lesson> rows, {
    _i1.ColumnSelections<LessonTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Lesson>(
      rows,
      columns: columns?.call(Lesson.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Lesson]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Lesson> updateRow(
    _i1.Session session,
    Lesson row, {
    _i1.ColumnSelections<LessonTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Lesson>(
      row,
      columns: columns?.call(Lesson.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Lesson]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Lesson>> delete(
    _i1.Session session,
    List<Lesson> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Lesson>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Lesson].
  Future<Lesson> deleteRow(
    _i1.Session session,
    Lesson row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Lesson>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Lesson>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<LessonTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Lesson>(
      where: where(Lesson.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LessonTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Lesson>(
      where: where?.call(Lesson.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class LessonAttachRepository {
  const LessonAttachRepository._();

  /// Creates a relation between this [Lesson] and the given [LessonAttendance]s
  /// by setting each [LessonAttendance]'s foreign key `lessonId` to refer to this [Lesson].
  Future<void> attendedPupils(
    _i1.Session session,
    Lesson lesson,
    List<_i2.LessonAttendance> lessonAttendance, {
    _i1.Transaction? transaction,
  }) async {
    if (lessonAttendance.any((e) => e.id == null)) {
      throw ArgumentError.notNull('lessonAttendance.id');
    }
    if (lesson.id == null) {
      throw ArgumentError.notNull('lesson.id');
    }

    var $lessonAttendance =
        lessonAttendance.map((e) => e.copyWith(lessonId: lesson.id)).toList();
    await session.db.update<_i2.LessonAttendance>(
      $lessonAttendance,
      columns: [_i2.LessonAttendance.t.lessonId],
      transaction: transaction,
    );
  }
}

class LessonAttachRowRepository {
  const LessonAttachRowRepository._();

  /// Creates a relation between the given [Lesson] and [LessonSubject]
  /// by setting the [Lesson]'s foreign key `subjectId` to refer to the [LessonSubject].
  Future<void> subject(
    _i1.Session session,
    Lesson lesson,
    _i3.LessonSubject subject, {
    _i1.Transaction? transaction,
  }) async {
    if (lesson.id == null) {
      throw ArgumentError.notNull('lesson.id');
    }
    if (subject.id == null) {
      throw ArgumentError.notNull('subject.id');
    }

    var $lesson = lesson.copyWith(subjectId: subject.id);
    await session.db.updateRow<Lesson>(
      $lesson,
      columns: [Lesson.t.subjectId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Lesson] and the given [LessonAttendance]
  /// by setting the [LessonAttendance]'s foreign key `lessonId` to refer to this [Lesson].
  Future<void> attendedPupils(
    _i1.Session session,
    Lesson lesson,
    _i2.LessonAttendance lessonAttendance, {
    _i1.Transaction? transaction,
  }) async {
    if (lessonAttendance.id == null) {
      throw ArgumentError.notNull('lessonAttendance.id');
    }
    if (lesson.id == null) {
      throw ArgumentError.notNull('lesson.id');
    }

    var $lessonAttendance = lessonAttendance.copyWith(lessonId: lesson.id);
    await session.db.updateRow<_i2.LessonAttendance>(
      $lessonAttendance,
      columns: [_i2.LessonAttendance.t.lessonId],
      transaction: transaction,
    );
  }
}

class LessonDetachRepository {
  const LessonDetachRepository._();

  /// Detaches the relation between this [Lesson] and the given [LessonAttendance]
  /// by setting the [LessonAttendance]'s foreign key `lessonId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> attendedPupils(
    _i1.Session session,
    List<_i2.LessonAttendance> lessonAttendance, {
    _i1.Transaction? transaction,
  }) async {
    if (lessonAttendance.any((e) => e.id == null)) {
      throw ArgumentError.notNull('lessonAttendance.id');
    }

    var $lessonAttendance =
        lessonAttendance.map((e) => e.copyWith(lessonId: null)).toList();
    await session.db.update<_i2.LessonAttendance>(
      $lessonAttendance,
      columns: [_i2.LessonAttendance.t.lessonId],
      transaction: transaction,
    );
  }
}

class LessonDetachRowRepository {
  const LessonDetachRowRepository._();

  /// Detaches the relation between this [Lesson] and the given [LessonAttendance]
  /// by setting the [LessonAttendance]'s foreign key `lessonId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> attendedPupils(
    _i1.Session session,
    _i2.LessonAttendance lessonAttendance, {
    _i1.Transaction? transaction,
  }) async {
    if (lessonAttendance.id == null) {
      throw ArgumentError.notNull('lessonAttendance.id');
    }

    var $lessonAttendance = lessonAttendance.copyWith(lessonId: null);
    await session.db.updateRow<_i2.LessonAttendance>(
      $lessonAttendance,
      columns: [_i2.LessonAttendance.t.lessonId],
      transaction: transaction,
    );
  }
}

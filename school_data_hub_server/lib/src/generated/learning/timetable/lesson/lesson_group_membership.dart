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
import '../../../learning/timetable/lesson/lesson_group.dart' as _i2;
import '../../../pupil_data/pupil_data.dart' as _i3;

abstract class ScheduledLessonGroupMembership
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ScheduledLessonGroupMembership._({
    this.id,
    required this.lessonGroupId,
    this.lessonGroup,
    required this.pupilDataId,
    this.pupilData,
  });

  factory ScheduledLessonGroupMembership({
    int? id,
    required int lessonGroupId,
    _i2.LessonGroup? lessonGroup,
    required int pupilDataId,
    _i3.PupilData? pupilData,
  }) = _ScheduledLessonGroupMembershipImpl;

  factory ScheduledLessonGroupMembership.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return ScheduledLessonGroupMembership(
      id: jsonSerialization['id'] as int?,
      lessonGroupId: jsonSerialization['lessonGroupId'] as int,
      lessonGroup: jsonSerialization['lessonGroup'] == null
          ? null
          : _i2.LessonGroup.fromJson(
              (jsonSerialization['lessonGroup'] as Map<String, dynamic>)),
      pupilDataId: jsonSerialization['pupilDataId'] as int,
      pupilData: jsonSerialization['pupilData'] == null
          ? null
          : _i3.PupilData.fromJson(
              (jsonSerialization['pupilData'] as Map<String, dynamic>)),
    );
  }

  static final t = ScheduledLessonGroupMembershipTable();

  static const db = ScheduledLessonGroupMembershipRepository._();

  @override
  int? id;

  int lessonGroupId;

  _i2.LessonGroup? lessonGroup;

  int pupilDataId;

  _i3.PupilData? pupilData;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ScheduledLessonGroupMembership]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScheduledLessonGroupMembership copyWith({
    int? id,
    int? lessonGroupId,
    _i2.LessonGroup? lessonGroup,
    int? pupilDataId,
    _i3.PupilData? pupilData,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'lessonGroupId': lessonGroupId,
      if (lessonGroup != null) 'lessonGroup': lessonGroup?.toJson(),
      'pupilDataId': pupilDataId,
      if (pupilData != null) 'pupilData': pupilData?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'lessonGroupId': lessonGroupId,
      if (lessonGroup != null) 'lessonGroup': lessonGroup?.toJsonForProtocol(),
      'pupilDataId': pupilDataId,
      if (pupilData != null) 'pupilData': pupilData?.toJsonForProtocol(),
    };
  }

  static ScheduledLessonGroupMembershipInclude include({
    _i2.LessonGroupInclude? lessonGroup,
    _i3.PupilDataInclude? pupilData,
  }) {
    return ScheduledLessonGroupMembershipInclude._(
      lessonGroup: lessonGroup,
      pupilData: pupilData,
    );
  }

  static ScheduledLessonGroupMembershipIncludeList includeList({
    _i1.WhereExpressionBuilder<ScheduledLessonGroupMembershipTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScheduledLessonGroupMembershipTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduledLessonGroupMembershipTable>? orderByList,
    ScheduledLessonGroupMembershipInclude? include,
  }) {
    return ScheduledLessonGroupMembershipIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ScheduledLessonGroupMembership.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ScheduledLessonGroupMembership.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScheduledLessonGroupMembershipImpl
    extends ScheduledLessonGroupMembership {
  _ScheduledLessonGroupMembershipImpl({
    int? id,
    required int lessonGroupId,
    _i2.LessonGroup? lessonGroup,
    required int pupilDataId,
    _i3.PupilData? pupilData,
  }) : super._(
          id: id,
          lessonGroupId: lessonGroupId,
          lessonGroup: lessonGroup,
          pupilDataId: pupilDataId,
          pupilData: pupilData,
        );

  /// Returns a shallow copy of this [ScheduledLessonGroupMembership]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScheduledLessonGroupMembership copyWith({
    Object? id = _Undefined,
    int? lessonGroupId,
    Object? lessonGroup = _Undefined,
    int? pupilDataId,
    Object? pupilData = _Undefined,
  }) {
    return ScheduledLessonGroupMembership(
      id: id is int? ? id : this.id,
      lessonGroupId: lessonGroupId ?? this.lessonGroupId,
      lessonGroup: lessonGroup is _i2.LessonGroup?
          ? lessonGroup
          : this.lessonGroup?.copyWith(),
      pupilDataId: pupilDataId ?? this.pupilDataId,
      pupilData:
          pupilData is _i3.PupilData? ? pupilData : this.pupilData?.copyWith(),
    );
  }
}

class ScheduledLessonGroupMembershipTable extends _i1.Table<int?> {
  ScheduledLessonGroupMembershipTable({super.tableRelation})
      : super(tableName: 'lesson_group_pupil') {
    lessonGroupId = _i1.ColumnInt(
      'lessonGroupId',
      this,
    );
    pupilDataId = _i1.ColumnInt(
      'pupilDataId',
      this,
    );
  }

  late final _i1.ColumnInt lessonGroupId;

  _i2.LessonGroupTable? _lessonGroup;

  late final _i1.ColumnInt pupilDataId;

  _i3.PupilDataTable? _pupilData;

  _i2.LessonGroupTable get lessonGroup {
    if (_lessonGroup != null) return _lessonGroup!;
    _lessonGroup = _i1.createRelationTable(
      relationFieldName: 'lessonGroup',
      field: ScheduledLessonGroupMembership.t.lessonGroupId,
      foreignField: _i2.LessonGroup.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.LessonGroupTable(tableRelation: foreignTableRelation),
    );
    return _lessonGroup!;
  }

  _i3.PupilDataTable get pupilData {
    if (_pupilData != null) return _pupilData!;
    _pupilData = _i1.createRelationTable(
      relationFieldName: 'pupilData',
      field: ScheduledLessonGroupMembership.t.pupilDataId,
      foreignField: _i3.PupilData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PupilDataTable(tableRelation: foreignTableRelation),
    );
    return _pupilData!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        lessonGroupId,
        pupilDataId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'lessonGroup') {
      return lessonGroup;
    }
    if (relationField == 'pupilData') {
      return pupilData;
    }
    return null;
  }
}

class ScheduledLessonGroupMembershipInclude extends _i1.IncludeObject {
  ScheduledLessonGroupMembershipInclude._({
    _i2.LessonGroupInclude? lessonGroup,
    _i3.PupilDataInclude? pupilData,
  }) {
    _lessonGroup = lessonGroup;
    _pupilData = pupilData;
  }

  _i2.LessonGroupInclude? _lessonGroup;

  _i3.PupilDataInclude? _pupilData;

  @override
  Map<String, _i1.Include?> get includes => {
        'lessonGroup': _lessonGroup,
        'pupilData': _pupilData,
      };

  @override
  _i1.Table<int?> get table => ScheduledLessonGroupMembership.t;
}

class ScheduledLessonGroupMembershipIncludeList extends _i1.IncludeList {
  ScheduledLessonGroupMembershipIncludeList._({
    _i1.WhereExpressionBuilder<ScheduledLessonGroupMembershipTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ScheduledLessonGroupMembership.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ScheduledLessonGroupMembership.t;
}

class ScheduledLessonGroupMembershipRepository {
  const ScheduledLessonGroupMembershipRepository._();

  final attachRow = const ScheduledLessonGroupMembershipAttachRowRepository._();

  /// Returns a list of [ScheduledLessonGroupMembership]s matching the given query parameters.
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
  Future<List<ScheduledLessonGroupMembership>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScheduledLessonGroupMembershipTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScheduledLessonGroupMembershipTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduledLessonGroupMembershipTable>? orderByList,
    _i1.Transaction? transaction,
    ScheduledLessonGroupMembershipInclude? include,
  }) async {
    return session.db.find<ScheduledLessonGroupMembership>(
      where: where?.call(ScheduledLessonGroupMembership.t),
      orderBy: orderBy?.call(ScheduledLessonGroupMembership.t),
      orderByList: orderByList?.call(ScheduledLessonGroupMembership.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [ScheduledLessonGroupMembership] matching the given query parameters.
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
  Future<ScheduledLessonGroupMembership?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScheduledLessonGroupMembershipTable>? where,
    int? offset,
    _i1.OrderByBuilder<ScheduledLessonGroupMembershipTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduledLessonGroupMembershipTable>? orderByList,
    _i1.Transaction? transaction,
    ScheduledLessonGroupMembershipInclude? include,
  }) async {
    return session.db.findFirstRow<ScheduledLessonGroupMembership>(
      where: where?.call(ScheduledLessonGroupMembership.t),
      orderBy: orderBy?.call(ScheduledLessonGroupMembership.t),
      orderByList: orderByList?.call(ScheduledLessonGroupMembership.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [ScheduledLessonGroupMembership] by its [id] or null if no such row exists.
  Future<ScheduledLessonGroupMembership?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ScheduledLessonGroupMembershipInclude? include,
  }) async {
    return session.db.findById<ScheduledLessonGroupMembership>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [ScheduledLessonGroupMembership]s in the list and returns the inserted rows.
  ///
  /// The returned [ScheduledLessonGroupMembership]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ScheduledLessonGroupMembership>> insert(
    _i1.Session session,
    List<ScheduledLessonGroupMembership> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ScheduledLessonGroupMembership>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ScheduledLessonGroupMembership] and returns the inserted row.
  ///
  /// The returned [ScheduledLessonGroupMembership] will have its `id` field set.
  Future<ScheduledLessonGroupMembership> insertRow(
    _i1.Session session,
    ScheduledLessonGroupMembership row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ScheduledLessonGroupMembership>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ScheduledLessonGroupMembership]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ScheduledLessonGroupMembership>> update(
    _i1.Session session,
    List<ScheduledLessonGroupMembership> rows, {
    _i1.ColumnSelections<ScheduledLessonGroupMembershipTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ScheduledLessonGroupMembership>(
      rows,
      columns: columns?.call(ScheduledLessonGroupMembership.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ScheduledLessonGroupMembership]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ScheduledLessonGroupMembership> updateRow(
    _i1.Session session,
    ScheduledLessonGroupMembership row, {
    _i1.ColumnSelections<ScheduledLessonGroupMembershipTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ScheduledLessonGroupMembership>(
      row,
      columns: columns?.call(ScheduledLessonGroupMembership.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ScheduledLessonGroupMembership]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ScheduledLessonGroupMembership>> delete(
    _i1.Session session,
    List<ScheduledLessonGroupMembership> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ScheduledLessonGroupMembership>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ScheduledLessonGroupMembership].
  Future<ScheduledLessonGroupMembership> deleteRow(
    _i1.Session session,
    ScheduledLessonGroupMembership row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ScheduledLessonGroupMembership>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ScheduledLessonGroupMembership>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ScheduledLessonGroupMembershipTable>
        where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ScheduledLessonGroupMembership>(
      where: where(ScheduledLessonGroupMembership.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScheduledLessonGroupMembershipTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ScheduledLessonGroupMembership>(
      where: where?.call(ScheduledLessonGroupMembership.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ScheduledLessonGroupMembershipAttachRowRepository {
  const ScheduledLessonGroupMembershipAttachRowRepository._();

  /// Creates a relation between the given [ScheduledLessonGroupMembership] and [LessonGroup]
  /// by setting the [ScheduledLessonGroupMembership]'s foreign key `lessonGroupId` to refer to the [LessonGroup].
  Future<void> lessonGroup(
    _i1.Session session,
    ScheduledLessonGroupMembership scheduledLessonGroupMembership,
    _i2.LessonGroup lessonGroup, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLessonGroupMembership.id == null) {
      throw ArgumentError.notNull('scheduledLessonGroupMembership.id');
    }
    if (lessonGroup.id == null) {
      throw ArgumentError.notNull('lessonGroup.id');
    }

    var $scheduledLessonGroupMembership =
        scheduledLessonGroupMembership.copyWith(lessonGroupId: lessonGroup.id);
    await session.db.updateRow<ScheduledLessonGroupMembership>(
      $scheduledLessonGroupMembership,
      columns: [ScheduledLessonGroupMembership.t.lessonGroupId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ScheduledLessonGroupMembership] and [PupilData]
  /// by setting the [ScheduledLessonGroupMembership]'s foreign key `pupilDataId` to refer to the [PupilData].
  Future<void> pupilData(
    _i1.Session session,
    ScheduledLessonGroupMembership scheduledLessonGroupMembership,
    _i3.PupilData pupilData, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLessonGroupMembership.id == null) {
      throw ArgumentError.notNull('scheduledLessonGroupMembership.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $scheduledLessonGroupMembership =
        scheduledLessonGroupMembership.copyWith(pupilDataId: pupilData.id);
    await session.db.updateRow<ScheduledLessonGroupMembership>(
      $scheduledLessonGroupMembership,
      columns: [ScheduledLessonGroupMembership.t.pupilDataId],
      transaction: transaction,
    );
  }
}

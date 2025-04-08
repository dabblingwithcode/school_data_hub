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
import '../schoolday/schoolday.dart' as _i2;
import '../pupil_data/pupil_data.dart' as _i3;

abstract class SchooldayEvent
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  SchooldayEvent._({
    this.id,
    required this.eventId,
    required this.eventType,
    required this.eventReason,
    required this.createdBy,
    required this.processed,
    required this.processedBy,
    required this.fileId,
    required this.fileUrl,
    required this.processedFileId,
    required this.processedFileUrl,
    required this.schooldayId,
    this.schoolday,
    required this.pupilId,
    this.pupil,
  });

  factory SchooldayEvent({
    int? id,
    required String eventId,
    required String eventType,
    required String eventReason,
    required String createdBy,
    required bool processed,
    required String processedBy,
    required String fileId,
    required String fileUrl,
    required String processedFileId,
    required String processedFileUrl,
    required int schooldayId,
    _i2.Schoolday? schoolday,
    required int pupilId,
    _i3.PupilData? pupil,
  }) = _SchooldayEventImpl;

  factory SchooldayEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return SchooldayEvent(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as String,
      eventType: jsonSerialization['eventType'] as String,
      eventReason: jsonSerialization['eventReason'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      processed: jsonSerialization['processed'] as bool,
      processedBy: jsonSerialization['processedBy'] as String,
      fileId: jsonSerialization['fileId'] as String,
      fileUrl: jsonSerialization['fileUrl'] as String,
      processedFileId: jsonSerialization['processedFileId'] as String,
      processedFileUrl: jsonSerialization['processedFileUrl'] as String,
      schooldayId: jsonSerialization['schooldayId'] as int,
      schoolday: jsonSerialization['schoolday'] == null
          ? null
          : _i2.Schoolday.fromJson(
              (jsonSerialization['schoolday'] as Map<String, dynamic>)),
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i3.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
    );
  }

  static final t = SchooldayEventTable();

  static const db = SchooldayEventRepository._();

  @override
  int? id;

  String eventId;

  String eventType;

  String eventReason;

  String createdBy;

  bool processed;

  String processedBy;

  String fileId;

  String fileUrl;

  String processedFileId;

  String processedFileUrl;

  int schooldayId;

  _i2.Schoolday? schoolday;

  int pupilId;

  _i3.PupilData? pupil;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [SchooldayEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SchooldayEvent copyWith({
    int? id,
    String? eventId,
    String? eventType,
    String? eventReason,
    String? createdBy,
    bool? processed,
    String? processedBy,
    String? fileId,
    String? fileUrl,
    String? processedFileId,
    String? processedFileUrl,
    int? schooldayId,
    _i2.Schoolday? schoolday,
    int? pupilId,
    _i3.PupilData? pupil,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'eventId': eventId,
      'eventType': eventType,
      'eventReason': eventReason,
      'createdBy': createdBy,
      'processed': processed,
      'processedBy': processedBy,
      'fileId': fileId,
      'fileUrl': fileUrl,
      'processedFileId': processedFileId,
      'processedFileUrl': processedFileUrl,
      'schooldayId': schooldayId,
      if (schoolday != null) 'schoolday': schoolday?.toJson(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'eventId': eventId,
      'eventType': eventType,
      'eventReason': eventReason,
      'createdBy': createdBy,
      'processed': processed,
      'processedBy': processedBy,
      'fileId': fileId,
      'fileUrl': fileUrl,
      'processedFileId': processedFileId,
      'processedFileUrl': processedFileUrl,
      'schooldayId': schooldayId,
      if (schoolday != null) 'schoolday': schoolday?.toJsonForProtocol(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJsonForProtocol(),
    };
  }

  static SchooldayEventInclude include({
    _i2.SchooldayInclude? schoolday,
    _i3.PupilDataInclude? pupil,
  }) {
    return SchooldayEventInclude._(
      schoolday: schoolday,
      pupil: pupil,
    );
  }

  static SchooldayEventIncludeList includeList({
    _i1.WhereExpressionBuilder<SchooldayEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SchooldayEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SchooldayEventTable>? orderByList,
    SchooldayEventInclude? include,
  }) {
    return SchooldayEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SchooldayEvent.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SchooldayEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SchooldayEventImpl extends SchooldayEvent {
  _SchooldayEventImpl({
    int? id,
    required String eventId,
    required String eventType,
    required String eventReason,
    required String createdBy,
    required bool processed,
    required String processedBy,
    required String fileId,
    required String fileUrl,
    required String processedFileId,
    required String processedFileUrl,
    required int schooldayId,
    _i2.Schoolday? schoolday,
    required int pupilId,
    _i3.PupilData? pupil,
  }) : super._(
          id: id,
          eventId: eventId,
          eventType: eventType,
          eventReason: eventReason,
          createdBy: createdBy,
          processed: processed,
          processedBy: processedBy,
          fileId: fileId,
          fileUrl: fileUrl,
          processedFileId: processedFileId,
          processedFileUrl: processedFileUrl,
          schooldayId: schooldayId,
          schoolday: schoolday,
          pupilId: pupilId,
          pupil: pupil,
        );

  /// Returns a shallow copy of this [SchooldayEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SchooldayEvent copyWith({
    Object? id = _Undefined,
    String? eventId,
    String? eventType,
    String? eventReason,
    String? createdBy,
    bool? processed,
    String? processedBy,
    String? fileId,
    String? fileUrl,
    String? processedFileId,
    String? processedFileUrl,
    int? schooldayId,
    Object? schoolday = _Undefined,
    int? pupilId,
    Object? pupil = _Undefined,
  }) {
    return SchooldayEvent(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      eventType: eventType ?? this.eventType,
      eventReason: eventReason ?? this.eventReason,
      createdBy: createdBy ?? this.createdBy,
      processed: processed ?? this.processed,
      processedBy: processedBy ?? this.processedBy,
      fileId: fileId ?? this.fileId,
      fileUrl: fileUrl ?? this.fileUrl,
      processedFileId: processedFileId ?? this.processedFileId,
      processedFileUrl: processedFileUrl ?? this.processedFileUrl,
      schooldayId: schooldayId ?? this.schooldayId,
      schoolday:
          schoolday is _i2.Schoolday? ? schoolday : this.schoolday?.copyWith(),
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i3.PupilData? ? pupil : this.pupil?.copyWith(),
    );
  }
}

class SchooldayEventTable extends _i1.Table<int> {
  SchooldayEventTable({super.tableRelation})
      : super(tableName: 'schoolday_event') {
    eventId = _i1.ColumnString(
      'eventId',
      this,
    );
    eventType = _i1.ColumnString(
      'eventType',
      this,
    );
    eventReason = _i1.ColumnString(
      'eventReason',
      this,
    );
    createdBy = _i1.ColumnString(
      'createdBy',
      this,
    );
    processed = _i1.ColumnBool(
      'processed',
      this,
    );
    processedBy = _i1.ColumnString(
      'processedBy',
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
    processedFileId = _i1.ColumnString(
      'processedFileId',
      this,
    );
    processedFileUrl = _i1.ColumnString(
      'processedFileUrl',
      this,
    );
    schooldayId = _i1.ColumnInt(
      'schooldayId',
      this,
    );
    pupilId = _i1.ColumnInt(
      'pupilId',
      this,
    );
  }

  late final _i1.ColumnString eventId;

  late final _i1.ColumnString eventType;

  late final _i1.ColumnString eventReason;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnBool processed;

  late final _i1.ColumnString processedBy;

  late final _i1.ColumnString fileId;

  late final _i1.ColumnString fileUrl;

  late final _i1.ColumnString processedFileId;

  late final _i1.ColumnString processedFileUrl;

  late final _i1.ColumnInt schooldayId;

  _i2.SchooldayTable? _schoolday;

  late final _i1.ColumnInt pupilId;

  _i3.PupilDataTable? _pupil;

  _i2.SchooldayTable get schoolday {
    if (_schoolday != null) return _schoolday!;
    _schoolday = _i1.createRelationTable(
      relationFieldName: 'schoolday',
      field: SchooldayEvent.t.schooldayId,
      foreignField: _i2.Schoolday.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SchooldayTable(tableRelation: foreignTableRelation),
    );
    return _schoolday!;
  }

  _i3.PupilDataTable get pupil {
    if (_pupil != null) return _pupil!;
    _pupil = _i1.createRelationTable(
      relationFieldName: 'pupil',
      field: SchooldayEvent.t.pupilId,
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
        eventId,
        eventType,
        eventReason,
        createdBy,
        processed,
        processedBy,
        fileId,
        fileUrl,
        processedFileId,
        processedFileUrl,
        schooldayId,
        pupilId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'schoolday') {
      return schoolday;
    }
    if (relationField == 'pupil') {
      return pupil;
    }
    return null;
  }
}

class SchooldayEventInclude extends _i1.IncludeObject {
  SchooldayEventInclude._({
    _i2.SchooldayInclude? schoolday,
    _i3.PupilDataInclude? pupil,
  }) {
    _schoolday = schoolday;
    _pupil = pupil;
  }

  _i2.SchooldayInclude? _schoolday;

  _i3.PupilDataInclude? _pupil;

  @override
  Map<String, _i1.Include?> get includes => {
        'schoolday': _schoolday,
        'pupil': _pupil,
      };

  @override
  _i1.Table<int> get table => SchooldayEvent.t;
}

class SchooldayEventIncludeList extends _i1.IncludeList {
  SchooldayEventIncludeList._({
    _i1.WhereExpressionBuilder<SchooldayEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SchooldayEvent.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => SchooldayEvent.t;
}

class SchooldayEventRepository {
  const SchooldayEventRepository._();

  final attachRow = const SchooldayEventAttachRowRepository._();

  /// Returns a list of [SchooldayEvent]s matching the given query parameters.
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
  Future<List<SchooldayEvent>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SchooldayEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SchooldayEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SchooldayEventTable>? orderByList,
    _i1.Transaction? transaction,
    SchooldayEventInclude? include,
  }) async {
    return session.db.find<SchooldayEvent>(
      where: where?.call(SchooldayEvent.t),
      orderBy: orderBy?.call(SchooldayEvent.t),
      orderByList: orderByList?.call(SchooldayEvent.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [SchooldayEvent] matching the given query parameters.
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
  Future<SchooldayEvent?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SchooldayEventTable>? where,
    int? offset,
    _i1.OrderByBuilder<SchooldayEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SchooldayEventTable>? orderByList,
    _i1.Transaction? transaction,
    SchooldayEventInclude? include,
  }) async {
    return session.db.findFirstRow<SchooldayEvent>(
      where: where?.call(SchooldayEvent.t),
      orderBy: orderBy?.call(SchooldayEvent.t),
      orderByList: orderByList?.call(SchooldayEvent.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [SchooldayEvent] by its [id] or null if no such row exists.
  Future<SchooldayEvent?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    SchooldayEventInclude? include,
  }) async {
    return session.db.findById<SchooldayEvent>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [SchooldayEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [SchooldayEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SchooldayEvent>> insert(
    _i1.Session session,
    List<SchooldayEvent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SchooldayEvent>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SchooldayEvent] and returns the inserted row.
  ///
  /// The returned [SchooldayEvent] will have its `id` field set.
  Future<SchooldayEvent> insertRow(
    _i1.Session session,
    SchooldayEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SchooldayEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SchooldayEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SchooldayEvent>> update(
    _i1.Session session,
    List<SchooldayEvent> rows, {
    _i1.ColumnSelections<SchooldayEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SchooldayEvent>(
      rows,
      columns: columns?.call(SchooldayEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SchooldayEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SchooldayEvent> updateRow(
    _i1.Session session,
    SchooldayEvent row, {
    _i1.ColumnSelections<SchooldayEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SchooldayEvent>(
      row,
      columns: columns?.call(SchooldayEvent.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SchooldayEvent]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SchooldayEvent>> delete(
    _i1.Session session,
    List<SchooldayEvent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SchooldayEvent>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SchooldayEvent].
  Future<SchooldayEvent> deleteRow(
    _i1.Session session,
    SchooldayEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SchooldayEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SchooldayEvent>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SchooldayEventTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SchooldayEvent>(
      where: where(SchooldayEvent.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SchooldayEventTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SchooldayEvent>(
      where: where?.call(SchooldayEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class SchooldayEventAttachRowRepository {
  const SchooldayEventAttachRowRepository._();

  /// Creates a relation between the given [SchooldayEvent] and [Schoolday]
  /// by setting the [SchooldayEvent]'s foreign key `schooldayId` to refer to the [Schoolday].
  Future<void> schoolday(
    _i1.Session session,
    SchooldayEvent schooldayEvent,
    _i2.Schoolday schoolday, {
    _i1.Transaction? transaction,
  }) async {
    if (schooldayEvent.id == null) {
      throw ArgumentError.notNull('schooldayEvent.id');
    }
    if (schoolday.id == null) {
      throw ArgumentError.notNull('schoolday.id');
    }

    var $schooldayEvent = schooldayEvent.copyWith(schooldayId: schoolday.id);
    await session.db.updateRow<SchooldayEvent>(
      $schooldayEvent,
      columns: [SchooldayEvent.t.schooldayId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [SchooldayEvent] and [PupilData]
  /// by setting the [SchooldayEvent]'s foreign key `pupilId` to refer to the [PupilData].
  Future<void> pupil(
    _i1.Session session,
    SchooldayEvent schooldayEvent,
    _i3.PupilData pupil, {
    _i1.Transaction? transaction,
  }) async {
    if (schooldayEvent.id == null) {
      throw ArgumentError.notNull('schooldayEvent.id');
    }
    if (pupil.id == null) {
      throw ArgumentError.notNull('pupil.id');
    }

    var $schooldayEvent = schooldayEvent.copyWith(pupilId: pupil.id);
    await session.db.updateRow<SchooldayEvent>(
      $schooldayEvent,
      columns: [SchooldayEvent.t.pupilId],
      transaction: transaction,
    );
  }
}

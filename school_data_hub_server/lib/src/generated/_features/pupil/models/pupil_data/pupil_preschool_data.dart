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
import '../../../../_features/pupil/models/pupil_data/preschool/kindergarden_info.dart'
    as _i2;
import '../../../../_features/pupil/models/pupil_data/preschool/pre_school_medical.dart'
    as _i3;
import '../../../../_features/pupil/models/pupil_data/preschool/kindergarden.dart'
    as _i4;
import '../../../../_features/pupil/models/pupil_data/preschool/pre_school_test.dart'
    as _i5;

abstract class PupilPreschoolData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PupilPreschoolData._({
    this.id,
    this.kindergardenData,
    this.preSchoolMedicalId,
    this.preSchoolMedical,
    this.kindergardenId,
    this.kindergarden,
    this.preSchoolTestId,
    this.preSchoolTest,
  });

  factory PupilPreschoolData({
    int? id,
    _i2.KindergardenInfo? kindergardenData,
    int? preSchoolMedicalId,
    _i3.PreSchoolMedical? preSchoolMedical,
    int? kindergardenId,
    _i4.Kindergarden? kindergarden,
    int? preSchoolTestId,
    _i5.PreSchoolTest? preSchoolTest,
  }) = _PupilPreschoolDataImpl;

  factory PupilPreschoolData.fromJson(Map<String, dynamic> jsonSerialization) {
    return PupilPreschoolData(
      id: jsonSerialization['id'] as int?,
      kindergardenData: jsonSerialization['kindergardenData'] == null
          ? null
          : _i2.KindergardenInfo.fromJson(
              (jsonSerialization['kindergardenData'] as Map<String, dynamic>)),
      preSchoolMedicalId: jsonSerialization['preSchoolMedicalId'] as int?,
      preSchoolMedical: jsonSerialization['preSchoolMedical'] == null
          ? null
          : _i3.PreSchoolMedical.fromJson(
              (jsonSerialization['preSchoolMedical'] as Map<String, dynamic>)),
      kindergardenId: jsonSerialization['kindergardenId'] as int?,
      kindergarden: jsonSerialization['kindergarden'] == null
          ? null
          : _i4.Kindergarden.fromJson(
              (jsonSerialization['kindergarden'] as Map<String, dynamic>)),
      preSchoolTestId: jsonSerialization['preSchoolTestId'] as int?,
      preSchoolTest: jsonSerialization['preSchoolTest'] == null
          ? null
          : _i5.PreSchoolTest.fromJson(
              (jsonSerialization['preSchoolTest'] as Map<String, dynamic>)),
    );
  }

  static final t = PupilPreschoolDataTable();

  static const db = PupilPreschoolDataRepository._();

  @override
  int? id;

  _i2.KindergardenInfo? kindergardenData;

  int? preSchoolMedicalId;

  _i3.PreSchoolMedical? preSchoolMedical;

  int? kindergardenId;

  _i4.Kindergarden? kindergarden;

  int? preSchoolTestId;

  _i5.PreSchoolTest? preSchoolTest;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PupilPreschoolData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilPreschoolData copyWith({
    int? id,
    _i2.KindergardenInfo? kindergardenData,
    int? preSchoolMedicalId,
    _i3.PreSchoolMedical? preSchoolMedical,
    int? kindergardenId,
    _i4.Kindergarden? kindergarden,
    int? preSchoolTestId,
    _i5.PreSchoolTest? preSchoolTest,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (kindergardenData != null)
        'kindergardenData': kindergardenData?.toJson(),
      if (preSchoolMedicalId != null) 'preSchoolMedicalId': preSchoolMedicalId,
      if (preSchoolMedical != null)
        'preSchoolMedical': preSchoolMedical?.toJson(),
      if (kindergardenId != null) 'kindergardenId': kindergardenId,
      if (kindergarden != null) 'kindergarden': kindergarden?.toJson(),
      if (preSchoolTestId != null) 'preSchoolTestId': preSchoolTestId,
      if (preSchoolTest != null) 'preSchoolTest': preSchoolTest?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (kindergardenData != null)
        'kindergardenData': kindergardenData?.toJsonForProtocol(),
      if (preSchoolMedicalId != null) 'preSchoolMedicalId': preSchoolMedicalId,
      if (preSchoolMedical != null)
        'preSchoolMedical': preSchoolMedical?.toJsonForProtocol(),
      if (kindergardenId != null) 'kindergardenId': kindergardenId,
      if (kindergarden != null)
        'kindergarden': kindergarden?.toJsonForProtocol(),
      if (preSchoolTestId != null) 'preSchoolTestId': preSchoolTestId,
      if (preSchoolTest != null)
        'preSchoolTest': preSchoolTest?.toJsonForProtocol(),
    };
  }

  static PupilPreschoolDataInclude include({
    _i3.PreSchoolMedicalInclude? preSchoolMedical,
    _i4.KindergardenInclude? kindergarden,
    _i5.PreSchoolTestInclude? preSchoolTest,
  }) {
    return PupilPreschoolDataInclude._(
      preSchoolMedical: preSchoolMedical,
      kindergarden: kindergarden,
      preSchoolTest: preSchoolTest,
    );
  }

  static PupilPreschoolDataIncludeList includeList({
    _i1.WhereExpressionBuilder<PupilPreschoolDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PupilPreschoolDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilPreschoolDataTable>? orderByList,
    PupilPreschoolDataInclude? include,
  }) {
    return PupilPreschoolDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PupilPreschoolData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PupilPreschoolData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PupilPreschoolDataImpl extends PupilPreschoolData {
  _PupilPreschoolDataImpl({
    int? id,
    _i2.KindergardenInfo? kindergardenData,
    int? preSchoolMedicalId,
    _i3.PreSchoolMedical? preSchoolMedical,
    int? kindergardenId,
    _i4.Kindergarden? kindergarden,
    int? preSchoolTestId,
    _i5.PreSchoolTest? preSchoolTest,
  }) : super._(
          id: id,
          kindergardenData: kindergardenData,
          preSchoolMedicalId: preSchoolMedicalId,
          preSchoolMedical: preSchoolMedical,
          kindergardenId: kindergardenId,
          kindergarden: kindergarden,
          preSchoolTestId: preSchoolTestId,
          preSchoolTest: preSchoolTest,
        );

  /// Returns a shallow copy of this [PupilPreschoolData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilPreschoolData copyWith({
    Object? id = _Undefined,
    Object? kindergardenData = _Undefined,
    Object? preSchoolMedicalId = _Undefined,
    Object? preSchoolMedical = _Undefined,
    Object? kindergardenId = _Undefined,
    Object? kindergarden = _Undefined,
    Object? preSchoolTestId = _Undefined,
    Object? preSchoolTest = _Undefined,
  }) {
    return PupilPreschoolData(
      id: id is int? ? id : this.id,
      kindergardenData: kindergardenData is _i2.KindergardenInfo?
          ? kindergardenData
          : this.kindergardenData?.copyWith(),
      preSchoolMedicalId: preSchoolMedicalId is int?
          ? preSchoolMedicalId
          : this.preSchoolMedicalId,
      preSchoolMedical: preSchoolMedical is _i3.PreSchoolMedical?
          ? preSchoolMedical
          : this.preSchoolMedical?.copyWith(),
      kindergardenId:
          kindergardenId is int? ? kindergardenId : this.kindergardenId,
      kindergarden: kindergarden is _i4.Kindergarden?
          ? kindergarden
          : this.kindergarden?.copyWith(),
      preSchoolTestId:
          preSchoolTestId is int? ? preSchoolTestId : this.preSchoolTestId,
      preSchoolTest: preSchoolTest is _i5.PreSchoolTest?
          ? preSchoolTest
          : this.preSchoolTest?.copyWith(),
    );
  }
}

class PupilPreschoolDataTable extends _i1.Table<int?> {
  PupilPreschoolDataTable({super.tableRelation})
      : super(tableName: 'pupil_preschool_data') {
    kindergardenData = _i1.ColumnSerializable(
      'kindergardenData',
      this,
    );
    preSchoolMedicalId = _i1.ColumnInt(
      'preSchoolMedicalId',
      this,
    );
    kindergardenId = _i1.ColumnInt(
      'kindergardenId',
      this,
    );
    preSchoolTestId = _i1.ColumnInt(
      'preSchoolTestId',
      this,
    );
  }

  late final _i1.ColumnSerializable kindergardenData;

  late final _i1.ColumnInt preSchoolMedicalId;

  _i3.PreSchoolMedicalTable? _preSchoolMedical;

  late final _i1.ColumnInt kindergardenId;

  _i4.KindergardenTable? _kindergarden;

  late final _i1.ColumnInt preSchoolTestId;

  _i5.PreSchoolTestTable? _preSchoolTest;

  _i3.PreSchoolMedicalTable get preSchoolMedical {
    if (_preSchoolMedical != null) return _preSchoolMedical!;
    _preSchoolMedical = _i1.createRelationTable(
      relationFieldName: 'preSchoolMedical',
      field: PupilPreschoolData.t.preSchoolMedicalId,
      foreignField: _i3.PreSchoolMedical.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PreSchoolMedicalTable(tableRelation: foreignTableRelation),
    );
    return _preSchoolMedical!;
  }

  _i4.KindergardenTable get kindergarden {
    if (_kindergarden != null) return _kindergarden!;
    _kindergarden = _i1.createRelationTable(
      relationFieldName: 'kindergarden',
      field: PupilPreschoolData.t.kindergardenId,
      foreignField: _i4.Kindergarden.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.KindergardenTable(tableRelation: foreignTableRelation),
    );
    return _kindergarden!;
  }

  _i5.PreSchoolTestTable get preSchoolTest {
    if (_preSchoolTest != null) return _preSchoolTest!;
    _preSchoolTest = _i1.createRelationTable(
      relationFieldName: 'preSchoolTest',
      field: PupilPreschoolData.t.preSchoolTestId,
      foreignField: _i5.PreSchoolTest.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.PreSchoolTestTable(tableRelation: foreignTableRelation),
    );
    return _preSchoolTest!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        kindergardenData,
        preSchoolMedicalId,
        kindergardenId,
        preSchoolTestId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'preSchoolMedical') {
      return preSchoolMedical;
    }
    if (relationField == 'kindergarden') {
      return kindergarden;
    }
    if (relationField == 'preSchoolTest') {
      return preSchoolTest;
    }
    return null;
  }
}

class PupilPreschoolDataInclude extends _i1.IncludeObject {
  PupilPreschoolDataInclude._({
    _i3.PreSchoolMedicalInclude? preSchoolMedical,
    _i4.KindergardenInclude? kindergarden,
    _i5.PreSchoolTestInclude? preSchoolTest,
  }) {
    _preSchoolMedical = preSchoolMedical;
    _kindergarden = kindergarden;
    _preSchoolTest = preSchoolTest;
  }

  _i3.PreSchoolMedicalInclude? _preSchoolMedical;

  _i4.KindergardenInclude? _kindergarden;

  _i5.PreSchoolTestInclude? _preSchoolTest;

  @override
  Map<String, _i1.Include?> get includes => {
        'preSchoolMedical': _preSchoolMedical,
        'kindergarden': _kindergarden,
        'preSchoolTest': _preSchoolTest,
      };

  @override
  _i1.Table<int?> get table => PupilPreschoolData.t;
}

class PupilPreschoolDataIncludeList extends _i1.IncludeList {
  PupilPreschoolDataIncludeList._({
    _i1.WhereExpressionBuilder<PupilPreschoolDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PupilPreschoolData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PupilPreschoolData.t;
}

class PupilPreschoolDataRepository {
  const PupilPreschoolDataRepository._();

  final attachRow = const PupilPreschoolDataAttachRowRepository._();

  final detachRow = const PupilPreschoolDataDetachRowRepository._();

  /// Returns a list of [PupilPreschoolData]s matching the given query parameters.
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
  Future<List<PupilPreschoolData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilPreschoolDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PupilPreschoolDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilPreschoolDataTable>? orderByList,
    _i1.Transaction? transaction,
    PupilPreschoolDataInclude? include,
  }) async {
    return session.db.find<PupilPreschoolData>(
      where: where?.call(PupilPreschoolData.t),
      orderBy: orderBy?.call(PupilPreschoolData.t),
      orderByList: orderByList?.call(PupilPreschoolData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [PupilPreschoolData] matching the given query parameters.
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
  Future<PupilPreschoolData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilPreschoolDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<PupilPreschoolDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilPreschoolDataTable>? orderByList,
    _i1.Transaction? transaction,
    PupilPreschoolDataInclude? include,
  }) async {
    return session.db.findFirstRow<PupilPreschoolData>(
      where: where?.call(PupilPreschoolData.t),
      orderBy: orderBy?.call(PupilPreschoolData.t),
      orderByList: orderByList?.call(PupilPreschoolData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [PupilPreschoolData] by its [id] or null if no such row exists.
  Future<PupilPreschoolData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    PupilPreschoolDataInclude? include,
  }) async {
    return session.db.findById<PupilPreschoolData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [PupilPreschoolData]s in the list and returns the inserted rows.
  ///
  /// The returned [PupilPreschoolData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PupilPreschoolData>> insert(
    _i1.Session session,
    List<PupilPreschoolData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PupilPreschoolData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PupilPreschoolData] and returns the inserted row.
  ///
  /// The returned [PupilPreschoolData] will have its `id` field set.
  Future<PupilPreschoolData> insertRow(
    _i1.Session session,
    PupilPreschoolData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PupilPreschoolData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PupilPreschoolData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PupilPreschoolData>> update(
    _i1.Session session,
    List<PupilPreschoolData> rows, {
    _i1.ColumnSelections<PupilPreschoolDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PupilPreschoolData>(
      rows,
      columns: columns?.call(PupilPreschoolData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PupilPreschoolData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PupilPreschoolData> updateRow(
    _i1.Session session,
    PupilPreschoolData row, {
    _i1.ColumnSelections<PupilPreschoolDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PupilPreschoolData>(
      row,
      columns: columns?.call(PupilPreschoolData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [PupilPreschoolData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PupilPreschoolData>> delete(
    _i1.Session session,
    List<PupilPreschoolData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PupilPreschoolData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PupilPreschoolData].
  Future<PupilPreschoolData> deleteRow(
    _i1.Session session,
    PupilPreschoolData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PupilPreschoolData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PupilPreschoolData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PupilPreschoolDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PupilPreschoolData>(
      where: where(PupilPreschoolData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilPreschoolDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PupilPreschoolData>(
      where: where?.call(PupilPreschoolData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class PupilPreschoolDataAttachRowRepository {
  const PupilPreschoolDataAttachRowRepository._();

  /// Creates a relation between the given [PupilPreschoolData] and [PreSchoolMedical]
  /// by setting the [PupilPreschoolData]'s foreign key `preSchoolMedicalId` to refer to the [PreSchoolMedical].
  Future<void> preSchoolMedical(
    _i1.Session session,
    PupilPreschoolData pupilPreschoolData,
    _i3.PreSchoolMedical preSchoolMedical, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilPreschoolData.id == null) {
      throw ArgumentError.notNull('pupilPreschoolData.id');
    }
    if (preSchoolMedical.id == null) {
      throw ArgumentError.notNull('preSchoolMedical.id');
    }

    var $pupilPreschoolData =
        pupilPreschoolData.copyWith(preSchoolMedicalId: preSchoolMedical.id);
    await session.db.updateRow<PupilPreschoolData>(
      $pupilPreschoolData,
      columns: [PupilPreschoolData.t.preSchoolMedicalId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [PupilPreschoolData] and [Kindergarden]
  /// by setting the [PupilPreschoolData]'s foreign key `kindergardenId` to refer to the [Kindergarden].
  Future<void> kindergarden(
    _i1.Session session,
    PupilPreschoolData pupilPreschoolData,
    _i4.Kindergarden kindergarden, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilPreschoolData.id == null) {
      throw ArgumentError.notNull('pupilPreschoolData.id');
    }
    if (kindergarden.id == null) {
      throw ArgumentError.notNull('kindergarden.id');
    }

    var $pupilPreschoolData =
        pupilPreschoolData.copyWith(kindergardenId: kindergarden.id);
    await session.db.updateRow<PupilPreschoolData>(
      $pupilPreschoolData,
      columns: [PupilPreschoolData.t.kindergardenId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [PupilPreschoolData] and [PreSchoolTest]
  /// by setting the [PupilPreschoolData]'s foreign key `preSchoolTestId` to refer to the [PreSchoolTest].
  Future<void> preSchoolTest(
    _i1.Session session,
    PupilPreschoolData pupilPreschoolData,
    _i5.PreSchoolTest preSchoolTest, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilPreschoolData.id == null) {
      throw ArgumentError.notNull('pupilPreschoolData.id');
    }
    if (preSchoolTest.id == null) {
      throw ArgumentError.notNull('preSchoolTest.id');
    }

    var $pupilPreschoolData =
        pupilPreschoolData.copyWith(preSchoolTestId: preSchoolTest.id);
    await session.db.updateRow<PupilPreschoolData>(
      $pupilPreschoolData,
      columns: [PupilPreschoolData.t.preSchoolTestId],
      transaction: transaction,
    );
  }
}

class PupilPreschoolDataDetachRowRepository {
  const PupilPreschoolDataDetachRowRepository._();

  /// Detaches the relation between this [PupilPreschoolData] and the [PreSchoolMedical] set in `preSchoolMedical`
  /// by setting the [PupilPreschoolData]'s foreign key `preSchoolMedicalId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> preSchoolMedical(
    _i1.Session session,
    PupilPreschoolData pupilpreschooldata, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilpreschooldata.id == null) {
      throw ArgumentError.notNull('pupilpreschooldata.id');
    }

    var $pupilpreschooldata =
        pupilpreschooldata.copyWith(preSchoolMedicalId: null);
    await session.db.updateRow<PupilPreschoolData>(
      $pupilpreschooldata,
      columns: [PupilPreschoolData.t.preSchoolMedicalId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilPreschoolData] and the [Kindergarden] set in `kindergarden`
  /// by setting the [PupilPreschoolData]'s foreign key `kindergardenId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> kindergarden(
    _i1.Session session,
    PupilPreschoolData pupilpreschooldata, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilpreschooldata.id == null) {
      throw ArgumentError.notNull('pupilpreschooldata.id');
    }

    var $pupilpreschooldata = pupilpreschooldata.copyWith(kindergardenId: null);
    await session.db.updateRow<PupilPreschoolData>(
      $pupilpreschooldata,
      columns: [PupilPreschoolData.t.kindergardenId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilPreschoolData] and the [PreSchoolTest] set in `preSchoolTest`
  /// by setting the [PupilPreschoolData]'s foreign key `preSchoolTestId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> preSchoolTest(
    _i1.Session session,
    PupilPreschoolData pupilpreschooldata, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilpreschooldata.id == null) {
      throw ArgumentError.notNull('pupilpreschooldata.id');
    }

    var $pupilpreschooldata =
        pupilpreschooldata.copyWith(preSchoolTestId: null);
    await session.db.updateRow<PupilPreschoolData>(
      $pupilpreschooldata,
      columns: [PupilPreschoolData.t.preSchoolTestId],
      transaction: transaction,
    );
  }
}

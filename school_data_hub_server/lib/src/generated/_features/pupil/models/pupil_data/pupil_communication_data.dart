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
import '../../../../_features/pupil/models/pupil_data/communication/communication_skills.dart'
    as _i2;
import '../../../../_features/pupil/models/pupil_data/communication/tutor_info.dart'
    as _i3;

abstract class PupilCommunicationData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PupilCommunicationData._({
    this.id,
    this.contact,
    this.communicationPupil,
    this.specialInformation,
    this.tutorInfo,
  });

  factory PupilCommunicationData({
    int? id,
    String? contact,
    _i2.CommunicationSkills? communicationPupil,
    String? specialInformation,
    _i3.TutorInfo? tutorInfo,
  }) = _PupilCommunicationDataImpl;

  factory PupilCommunicationData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return PupilCommunicationData(
      id: jsonSerialization['id'] as int?,
      contact: jsonSerialization['contact'] as String?,
      communicationPupil: jsonSerialization['communicationPupil'] == null
          ? null
          : _i2.CommunicationSkills.fromJson(
              (jsonSerialization['communicationPupil']
                  as Map<String, dynamic>)),
      specialInformation: jsonSerialization['specialInformation'] as String?,
      tutorInfo: jsonSerialization['tutorInfo'] == null
          ? null
          : _i3.TutorInfo.fromJson(
              (jsonSerialization['tutorInfo'] as Map<String, dynamic>)),
    );
  }

  static final t = PupilCommunicationDataTable();

  static const db = PupilCommunicationDataRepository._();

  @override
  int? id;

  String? contact;

  _i2.CommunicationSkills? communicationPupil;

  String? specialInformation;

  _i3.TutorInfo? tutorInfo;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PupilCommunicationData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilCommunicationData copyWith({
    int? id,
    String? contact,
    _i2.CommunicationSkills? communicationPupil,
    String? specialInformation,
    _i3.TutorInfo? tutorInfo,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (contact != null) 'contact': contact,
      if (communicationPupil != null)
        'communicationPupil': communicationPupil?.toJson(),
      if (specialInformation != null) 'specialInformation': specialInformation,
      if (tutorInfo != null) 'tutorInfo': tutorInfo?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (contact != null) 'contact': contact,
      if (communicationPupil != null)
        'communicationPupil': communicationPupil?.toJsonForProtocol(),
      if (specialInformation != null) 'specialInformation': specialInformation,
      if (tutorInfo != null) 'tutorInfo': tutorInfo?.toJsonForProtocol(),
    };
  }

  static PupilCommunicationDataInclude include() {
    return PupilCommunicationDataInclude._();
  }

  static PupilCommunicationDataIncludeList includeList({
    _i1.WhereExpressionBuilder<PupilCommunicationDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PupilCommunicationDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilCommunicationDataTable>? orderByList,
    PupilCommunicationDataInclude? include,
  }) {
    return PupilCommunicationDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PupilCommunicationData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PupilCommunicationData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PupilCommunicationDataImpl extends PupilCommunicationData {
  _PupilCommunicationDataImpl({
    int? id,
    String? contact,
    _i2.CommunicationSkills? communicationPupil,
    String? specialInformation,
    _i3.TutorInfo? tutorInfo,
  }) : super._(
          id: id,
          contact: contact,
          communicationPupil: communicationPupil,
          specialInformation: specialInformation,
          tutorInfo: tutorInfo,
        );

  /// Returns a shallow copy of this [PupilCommunicationData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilCommunicationData copyWith({
    Object? id = _Undefined,
    Object? contact = _Undefined,
    Object? communicationPupil = _Undefined,
    Object? specialInformation = _Undefined,
    Object? tutorInfo = _Undefined,
  }) {
    return PupilCommunicationData(
      id: id is int? ? id : this.id,
      contact: contact is String? ? contact : this.contact,
      communicationPupil: communicationPupil is _i2.CommunicationSkills?
          ? communicationPupil
          : this.communicationPupil?.copyWith(),
      specialInformation: specialInformation is String?
          ? specialInformation
          : this.specialInformation,
      tutorInfo:
          tutorInfo is _i3.TutorInfo? ? tutorInfo : this.tutorInfo?.copyWith(),
    );
  }
}

class PupilCommunicationDataTable extends _i1.Table<int?> {
  PupilCommunicationDataTable({super.tableRelation})
      : super(tableName: 'pupil_communication_data') {
    contact = _i1.ColumnString(
      'contact',
      this,
    );
    communicationPupil = _i1.ColumnSerializable(
      'communicationPupil',
      this,
    );
    specialInformation = _i1.ColumnString(
      'specialInformation',
      this,
    );
    tutorInfo = _i1.ColumnSerializable(
      'tutorInfo',
      this,
    );
  }

  late final _i1.ColumnString contact;

  late final _i1.ColumnSerializable communicationPupil;

  late final _i1.ColumnString specialInformation;

  late final _i1.ColumnSerializable tutorInfo;

  @override
  List<_i1.Column> get columns => [
        id,
        contact,
        communicationPupil,
        specialInformation,
        tutorInfo,
      ];
}

class PupilCommunicationDataInclude extends _i1.IncludeObject {
  PupilCommunicationDataInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => PupilCommunicationData.t;
}

class PupilCommunicationDataIncludeList extends _i1.IncludeList {
  PupilCommunicationDataIncludeList._({
    _i1.WhereExpressionBuilder<PupilCommunicationDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PupilCommunicationData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PupilCommunicationData.t;
}

class PupilCommunicationDataRepository {
  const PupilCommunicationDataRepository._();

  /// Returns a list of [PupilCommunicationData]s matching the given query parameters.
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
  Future<List<PupilCommunicationData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilCommunicationDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PupilCommunicationDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilCommunicationDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<PupilCommunicationData>(
      where: where?.call(PupilCommunicationData.t),
      orderBy: orderBy?.call(PupilCommunicationData.t),
      orderByList: orderByList?.call(PupilCommunicationData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [PupilCommunicationData] matching the given query parameters.
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
  Future<PupilCommunicationData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilCommunicationDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<PupilCommunicationDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilCommunicationDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<PupilCommunicationData>(
      where: where?.call(PupilCommunicationData.t),
      orderBy: orderBy?.call(PupilCommunicationData.t),
      orderByList: orderByList?.call(PupilCommunicationData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [PupilCommunicationData] by its [id] or null if no such row exists.
  Future<PupilCommunicationData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<PupilCommunicationData>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [PupilCommunicationData]s in the list and returns the inserted rows.
  ///
  /// The returned [PupilCommunicationData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PupilCommunicationData>> insert(
    _i1.Session session,
    List<PupilCommunicationData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PupilCommunicationData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PupilCommunicationData] and returns the inserted row.
  ///
  /// The returned [PupilCommunicationData] will have its `id` field set.
  Future<PupilCommunicationData> insertRow(
    _i1.Session session,
    PupilCommunicationData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PupilCommunicationData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PupilCommunicationData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PupilCommunicationData>> update(
    _i1.Session session,
    List<PupilCommunicationData> rows, {
    _i1.ColumnSelections<PupilCommunicationDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PupilCommunicationData>(
      rows,
      columns: columns?.call(PupilCommunicationData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PupilCommunicationData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PupilCommunicationData> updateRow(
    _i1.Session session,
    PupilCommunicationData row, {
    _i1.ColumnSelections<PupilCommunicationDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PupilCommunicationData>(
      row,
      columns: columns?.call(PupilCommunicationData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [PupilCommunicationData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PupilCommunicationData>> delete(
    _i1.Session session,
    List<PupilCommunicationData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PupilCommunicationData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PupilCommunicationData].
  Future<PupilCommunicationData> deleteRow(
    _i1.Session session,
    PupilCommunicationData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PupilCommunicationData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PupilCommunicationData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PupilCommunicationDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PupilCommunicationData>(
      where: where(PupilCommunicationData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilCommunicationDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PupilCommunicationData>(
      where: where?.call(PupilCommunicationData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

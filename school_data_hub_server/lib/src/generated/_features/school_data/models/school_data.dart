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
import '../../../_shared/models/hub_document.dart' as _i2;

abstract class SchoolData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SchoolData._({
    this.id,
    required this.name,
    required this.officialName,
    required this.address,
    required this.schoolNumber,
    required this.telephoneNumber,
    required this.email,
    required this.website,
    this.logoId,
    this.logo,
    this.officialSealId,
    this.officialSeal,
  });

  factory SchoolData({
    int? id,
    required String name,
    required String officialName,
    required String address,
    required String schoolNumber,
    required String telephoneNumber,
    required String email,
    required String website,
    int? logoId,
    _i2.HubDocument? logo,
    int? officialSealId,
    _i2.HubDocument? officialSeal,
  }) = _SchoolDataImpl;

  factory SchoolData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SchoolData(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      officialName: jsonSerialization['officialName'] as String,
      address: jsonSerialization['address'] as String,
      schoolNumber: jsonSerialization['schoolNumber'] as String,
      telephoneNumber: jsonSerialization['telephoneNumber'] as String,
      email: jsonSerialization['email'] as String,
      website: jsonSerialization['website'] as String,
      logoId: jsonSerialization['logoId'] as int?,
      logo: jsonSerialization['logo'] == null
          ? null
          : _i2.HubDocument.fromJson(
              (jsonSerialization['logo'] as Map<String, dynamic>)),
      officialSealId: jsonSerialization['officialSealId'] as int?,
      officialSeal: jsonSerialization['officialSeal'] == null
          ? null
          : _i2.HubDocument.fromJson(
              (jsonSerialization['officialSeal'] as Map<String, dynamic>)),
    );
  }

  static final t = SchoolDataTable();

  static const db = SchoolDataRepository._();

  @override
  int? id;

  String name;

  String officialName;

  String address;

  String schoolNumber;

  String telephoneNumber;

  String email;

  String website;

  int? logoId;

  _i2.HubDocument? logo;

  int? officialSealId;

  _i2.HubDocument? officialSeal;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SchoolData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SchoolData copyWith({
    int? id,
    String? name,
    String? officialName,
    String? address,
    String? schoolNumber,
    String? telephoneNumber,
    String? email,
    String? website,
    int? logoId,
    _i2.HubDocument? logo,
    int? officialSealId,
    _i2.HubDocument? officialSeal,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'officialName': officialName,
      'address': address,
      'schoolNumber': schoolNumber,
      'telephoneNumber': telephoneNumber,
      'email': email,
      'website': website,
      if (logoId != null) 'logoId': logoId,
      if (logo != null) 'logo': logo?.toJson(),
      if (officialSealId != null) 'officialSealId': officialSealId,
      if (officialSeal != null) 'officialSeal': officialSeal?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'officialName': officialName,
      'address': address,
      'schoolNumber': schoolNumber,
      'telephoneNumber': telephoneNumber,
      'email': email,
      'website': website,
      if (logoId != null) 'logoId': logoId,
      if (logo != null) 'logo': logo?.toJsonForProtocol(),
      if (officialSealId != null) 'officialSealId': officialSealId,
      if (officialSeal != null)
        'officialSeal': officialSeal?.toJsonForProtocol(),
    };
  }

  static SchoolDataInclude include({
    _i2.HubDocumentInclude? logo,
    _i2.HubDocumentInclude? officialSeal,
  }) {
    return SchoolDataInclude._(
      logo: logo,
      officialSeal: officialSeal,
    );
  }

  static SchoolDataIncludeList includeList({
    _i1.WhereExpressionBuilder<SchoolDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SchoolDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SchoolDataTable>? orderByList,
    SchoolDataInclude? include,
  }) {
    return SchoolDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SchoolData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SchoolData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SchoolDataImpl extends SchoolData {
  _SchoolDataImpl({
    int? id,
    required String name,
    required String officialName,
    required String address,
    required String schoolNumber,
    required String telephoneNumber,
    required String email,
    required String website,
    int? logoId,
    _i2.HubDocument? logo,
    int? officialSealId,
    _i2.HubDocument? officialSeal,
  }) : super._(
          id: id,
          name: name,
          officialName: officialName,
          address: address,
          schoolNumber: schoolNumber,
          telephoneNumber: telephoneNumber,
          email: email,
          website: website,
          logoId: logoId,
          logo: logo,
          officialSealId: officialSealId,
          officialSeal: officialSeal,
        );

  /// Returns a shallow copy of this [SchoolData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SchoolData copyWith({
    Object? id = _Undefined,
    String? name,
    String? officialName,
    String? address,
    String? schoolNumber,
    String? telephoneNumber,
    String? email,
    String? website,
    Object? logoId = _Undefined,
    Object? logo = _Undefined,
    Object? officialSealId = _Undefined,
    Object? officialSeal = _Undefined,
  }) {
    return SchoolData(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      officialName: officialName ?? this.officialName,
      address: address ?? this.address,
      schoolNumber: schoolNumber ?? this.schoolNumber,
      telephoneNumber: telephoneNumber ?? this.telephoneNumber,
      email: email ?? this.email,
      website: website ?? this.website,
      logoId: logoId is int? ? logoId : this.logoId,
      logo: logo is _i2.HubDocument? ? logo : this.logo?.copyWith(),
      officialSealId:
          officialSealId is int? ? officialSealId : this.officialSealId,
      officialSeal: officialSeal is _i2.HubDocument?
          ? officialSeal
          : this.officialSeal?.copyWith(),
    );
  }
}

class SchoolDataTable extends _i1.Table<int?> {
  SchoolDataTable({super.tableRelation}) : super(tableName: 'school_data') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    officialName = _i1.ColumnString(
      'officialName',
      this,
    );
    address = _i1.ColumnString(
      'address',
      this,
    );
    schoolNumber = _i1.ColumnString(
      'schoolNumber',
      this,
    );
    telephoneNumber = _i1.ColumnString(
      'telephoneNumber',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    website = _i1.ColumnString(
      'website',
      this,
    );
    logoId = _i1.ColumnInt(
      'logoId',
      this,
    );
    officialSealId = _i1.ColumnInt(
      'officialSealId',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString officialName;

  late final _i1.ColumnString address;

  late final _i1.ColumnString schoolNumber;

  late final _i1.ColumnString telephoneNumber;

  late final _i1.ColumnString email;

  late final _i1.ColumnString website;

  late final _i1.ColumnInt logoId;

  _i2.HubDocumentTable? _logo;

  late final _i1.ColumnInt officialSealId;

  _i2.HubDocumentTable? _officialSeal;

  _i2.HubDocumentTable get logo {
    if (_logo != null) return _logo!;
    _logo = _i1.createRelationTable(
      relationFieldName: 'logo',
      field: SchoolData.t.logoId,
      foreignField: _i2.HubDocument.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.HubDocumentTable(tableRelation: foreignTableRelation),
    );
    return _logo!;
  }

  _i2.HubDocumentTable get officialSeal {
    if (_officialSeal != null) return _officialSeal!;
    _officialSeal = _i1.createRelationTable(
      relationFieldName: 'officialSeal',
      field: SchoolData.t.officialSealId,
      foreignField: _i2.HubDocument.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.HubDocumentTable(tableRelation: foreignTableRelation),
    );
    return _officialSeal!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        officialName,
        address,
        schoolNumber,
        telephoneNumber,
        email,
        website,
        logoId,
        officialSealId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'logo') {
      return logo;
    }
    if (relationField == 'officialSeal') {
      return officialSeal;
    }
    return null;
  }
}

class SchoolDataInclude extends _i1.IncludeObject {
  SchoolDataInclude._({
    _i2.HubDocumentInclude? logo,
    _i2.HubDocumentInclude? officialSeal,
  }) {
    _logo = logo;
    _officialSeal = officialSeal;
  }

  _i2.HubDocumentInclude? _logo;

  _i2.HubDocumentInclude? _officialSeal;

  @override
  Map<String, _i1.Include?> get includes => {
        'logo': _logo,
        'officialSeal': _officialSeal,
      };

  @override
  _i1.Table<int?> get table => SchoolData.t;
}

class SchoolDataIncludeList extends _i1.IncludeList {
  SchoolDataIncludeList._({
    _i1.WhereExpressionBuilder<SchoolDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SchoolData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SchoolData.t;
}

class SchoolDataRepository {
  const SchoolDataRepository._();

  final attachRow = const SchoolDataAttachRowRepository._();

  final detachRow = const SchoolDataDetachRowRepository._();

  /// Returns a list of [SchoolData]s matching the given query parameters.
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
  Future<List<SchoolData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SchoolDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SchoolDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SchoolDataTable>? orderByList,
    _i1.Transaction? transaction,
    SchoolDataInclude? include,
  }) async {
    return session.db.find<SchoolData>(
      where: where?.call(SchoolData.t),
      orderBy: orderBy?.call(SchoolData.t),
      orderByList: orderByList?.call(SchoolData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [SchoolData] matching the given query parameters.
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
  Future<SchoolData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SchoolDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<SchoolDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SchoolDataTable>? orderByList,
    _i1.Transaction? transaction,
    SchoolDataInclude? include,
  }) async {
    return session.db.findFirstRow<SchoolData>(
      where: where?.call(SchoolData.t),
      orderBy: orderBy?.call(SchoolData.t),
      orderByList: orderByList?.call(SchoolData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [SchoolData] by its [id] or null if no such row exists.
  Future<SchoolData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    SchoolDataInclude? include,
  }) async {
    return session.db.findById<SchoolData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [SchoolData]s in the list and returns the inserted rows.
  ///
  /// The returned [SchoolData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SchoolData>> insert(
    _i1.Session session,
    List<SchoolData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SchoolData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SchoolData] and returns the inserted row.
  ///
  /// The returned [SchoolData] will have its `id` field set.
  Future<SchoolData> insertRow(
    _i1.Session session,
    SchoolData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SchoolData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SchoolData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SchoolData>> update(
    _i1.Session session,
    List<SchoolData> rows, {
    _i1.ColumnSelections<SchoolDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SchoolData>(
      rows,
      columns: columns?.call(SchoolData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SchoolData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SchoolData> updateRow(
    _i1.Session session,
    SchoolData row, {
    _i1.ColumnSelections<SchoolDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SchoolData>(
      row,
      columns: columns?.call(SchoolData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SchoolData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SchoolData>> delete(
    _i1.Session session,
    List<SchoolData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SchoolData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SchoolData].
  Future<SchoolData> deleteRow(
    _i1.Session session,
    SchoolData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SchoolData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SchoolData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SchoolDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SchoolData>(
      where: where(SchoolData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SchoolDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SchoolData>(
      where: where?.call(SchoolData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class SchoolDataAttachRowRepository {
  const SchoolDataAttachRowRepository._();

  /// Creates a relation between the given [SchoolData] and [HubDocument]
  /// by setting the [SchoolData]'s foreign key `logoId` to refer to the [HubDocument].
  Future<void> logo(
    _i1.Session session,
    SchoolData schoolData,
    _i2.HubDocument logo, {
    _i1.Transaction? transaction,
  }) async {
    if (schoolData.id == null) {
      throw ArgumentError.notNull('schoolData.id');
    }
    if (logo.id == null) {
      throw ArgumentError.notNull('logo.id');
    }

    var $schoolData = schoolData.copyWith(logoId: logo.id);
    await session.db.updateRow<SchoolData>(
      $schoolData,
      columns: [SchoolData.t.logoId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [SchoolData] and [HubDocument]
  /// by setting the [SchoolData]'s foreign key `officialSealId` to refer to the [HubDocument].
  Future<void> officialSeal(
    _i1.Session session,
    SchoolData schoolData,
    _i2.HubDocument officialSeal, {
    _i1.Transaction? transaction,
  }) async {
    if (schoolData.id == null) {
      throw ArgumentError.notNull('schoolData.id');
    }
    if (officialSeal.id == null) {
      throw ArgumentError.notNull('officialSeal.id');
    }

    var $schoolData = schoolData.copyWith(officialSealId: officialSeal.id);
    await session.db.updateRow<SchoolData>(
      $schoolData,
      columns: [SchoolData.t.officialSealId],
      transaction: transaction,
    );
  }
}

class SchoolDataDetachRowRepository {
  const SchoolDataDetachRowRepository._();

  /// Detaches the relation between this [SchoolData] and the [HubDocument] set in `logo`
  /// by setting the [SchoolData]'s foreign key `logoId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> logo(
    _i1.Session session,
    SchoolData schooldata, {
    _i1.Transaction? transaction,
  }) async {
    if (schooldata.id == null) {
      throw ArgumentError.notNull('schooldata.id');
    }

    var $schooldata = schooldata.copyWith(logoId: null);
    await session.db.updateRow<SchoolData>(
      $schooldata,
      columns: [SchoolData.t.logoId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [SchoolData] and the [HubDocument] set in `officialSeal`
  /// by setting the [SchoolData]'s foreign key `officialSealId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> officialSeal(
    _i1.Session session,
    SchoolData schooldata, {
    _i1.Transaction? transaction,
  }) async {
    if (schooldata.id == null) {
      throw ArgumentError.notNull('schooldata.id');
    }

    var $schooldata = schooldata.copyWith(officialSealId: null);
    await session.db.updateRow<SchoolData>(
      $schooldata,
      columns: [SchoolData.t.officialSealId],
      transaction: transaction,
    );
  }
}

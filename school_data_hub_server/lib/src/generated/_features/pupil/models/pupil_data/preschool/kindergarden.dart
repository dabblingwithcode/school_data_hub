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
import '../../../../../_features/pupil/models/pupil_data/pupil_data.dart'
    as _i2;

abstract class Kindergarden
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Kindergarden._({
    this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
    required this.contactPerson,
    this.pupils,
  });

  factory Kindergarden({
    int? id,
    required String name,
    required String phone,
    required String address,
    required String email,
    required String contactPerson,
    List<_i2.PupilData>? pupils,
  }) = _KindergardenImpl;

  factory Kindergarden.fromJson(Map<String, dynamic> jsonSerialization) {
    return Kindergarden(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      phone: jsonSerialization['phone'] as String,
      address: jsonSerialization['address'] as String,
      email: jsonSerialization['email'] as String,
      contactPerson: jsonSerialization['contactPerson'] as String,
      pupils: (jsonSerialization['pupils'] as List?)
          ?.map((e) => _i2.PupilData.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = KindergardenTable();

  static const db = KindergardenRepository._();

  @override
  int? id;

  String name;

  String phone;

  String address;

  String email;

  String contactPerson;

  List<_i2.PupilData>? pupils;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Kindergarden]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Kindergarden copyWith({
    int? id,
    String? name,
    String? phone,
    String? address,
    String? email,
    String? contactPerson,
    List<_i2.PupilData>? pupils,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'phone': phone,
      'address': address,
      'email': email,
      'contactPerson': contactPerson,
      if (pupils != null)
        'pupils': pupils?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'phone': phone,
      'address': address,
      'email': email,
      'contactPerson': contactPerson,
      if (pupils != null)
        'pupils': pupils?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static KindergardenInclude include({_i2.PupilDataIncludeList? pupils}) {
    return KindergardenInclude._(pupils: pupils);
  }

  static KindergardenIncludeList includeList({
    _i1.WhereExpressionBuilder<KindergardenTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<KindergardenTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<KindergardenTable>? orderByList,
    KindergardenInclude? include,
  }) {
    return KindergardenIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Kindergarden.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Kindergarden.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _KindergardenImpl extends Kindergarden {
  _KindergardenImpl({
    int? id,
    required String name,
    required String phone,
    required String address,
    required String email,
    required String contactPerson,
    List<_i2.PupilData>? pupils,
  }) : super._(
          id: id,
          name: name,
          phone: phone,
          address: address,
          email: email,
          contactPerson: contactPerson,
          pupils: pupils,
        );

  /// Returns a shallow copy of this [Kindergarden]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Kindergarden copyWith({
    Object? id = _Undefined,
    String? name,
    String? phone,
    String? address,
    String? email,
    String? contactPerson,
    Object? pupils = _Undefined,
  }) {
    return Kindergarden(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      email: email ?? this.email,
      contactPerson: contactPerson ?? this.contactPerson,
      pupils: pupils is List<_i2.PupilData>?
          ? pupils
          : this.pupils?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class KindergardenTable extends _i1.Table<int?> {
  KindergardenTable({super.tableRelation}) : super(tableName: 'kindergarden') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    phone = _i1.ColumnString(
      'phone',
      this,
    );
    address = _i1.ColumnString(
      'address',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    contactPerson = _i1.ColumnString(
      'contactPerson',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString phone;

  late final _i1.ColumnString address;

  late final _i1.ColumnString email;

  late final _i1.ColumnString contactPerson;

  _i2.PupilDataTable? ___pupils;

  _i1.ManyRelation<_i2.PupilDataTable>? _pupils;

  _i2.PupilDataTable get __pupils {
    if (___pupils != null) return ___pupils!;
    ___pupils = _i1.createRelationTable(
      relationFieldName: '__pupils',
      field: Kindergarden.t.id,
      foreignField: _i2.PupilData.t.$_kindergardenPupilsKindergardenId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PupilDataTable(tableRelation: foreignTableRelation),
    );
    return ___pupils!;
  }

  _i1.ManyRelation<_i2.PupilDataTable> get pupils {
    if (_pupils != null) return _pupils!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'pupils',
      field: Kindergarden.t.id,
      foreignField: _i2.PupilData.t.$_kindergardenPupilsKindergardenId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PupilDataTable(tableRelation: foreignTableRelation),
    );
    _pupils = _i1.ManyRelation<_i2.PupilDataTable>(
      tableWithRelations: relationTable,
      table: _i2.PupilDataTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _pupils!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        phone,
        address,
        email,
        contactPerson,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'pupils') {
      return __pupils;
    }
    return null;
  }
}

class KindergardenInclude extends _i1.IncludeObject {
  KindergardenInclude._({_i2.PupilDataIncludeList? pupils}) {
    _pupils = pupils;
  }

  _i2.PupilDataIncludeList? _pupils;

  @override
  Map<String, _i1.Include?> get includes => {'pupils': _pupils};

  @override
  _i1.Table<int?> get table => Kindergarden.t;
}

class KindergardenIncludeList extends _i1.IncludeList {
  KindergardenIncludeList._({
    _i1.WhereExpressionBuilder<KindergardenTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Kindergarden.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Kindergarden.t;
}

class KindergardenRepository {
  const KindergardenRepository._();

  final attach = const KindergardenAttachRepository._();

  final attachRow = const KindergardenAttachRowRepository._();

  final detach = const KindergardenDetachRepository._();

  final detachRow = const KindergardenDetachRowRepository._();

  /// Returns a list of [Kindergarden]s matching the given query parameters.
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
  Future<List<Kindergarden>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<KindergardenTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<KindergardenTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<KindergardenTable>? orderByList,
    _i1.Transaction? transaction,
    KindergardenInclude? include,
  }) async {
    return session.db.find<Kindergarden>(
      where: where?.call(Kindergarden.t),
      orderBy: orderBy?.call(Kindergarden.t),
      orderByList: orderByList?.call(Kindergarden.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Kindergarden] matching the given query parameters.
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
  Future<Kindergarden?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<KindergardenTable>? where,
    int? offset,
    _i1.OrderByBuilder<KindergardenTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<KindergardenTable>? orderByList,
    _i1.Transaction? transaction,
    KindergardenInclude? include,
  }) async {
    return session.db.findFirstRow<Kindergarden>(
      where: where?.call(Kindergarden.t),
      orderBy: orderBy?.call(Kindergarden.t),
      orderByList: orderByList?.call(Kindergarden.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Kindergarden] by its [id] or null if no such row exists.
  Future<Kindergarden?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    KindergardenInclude? include,
  }) async {
    return session.db.findById<Kindergarden>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Kindergarden]s in the list and returns the inserted rows.
  ///
  /// The returned [Kindergarden]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Kindergarden>> insert(
    _i1.Session session,
    List<Kindergarden> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Kindergarden>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Kindergarden] and returns the inserted row.
  ///
  /// The returned [Kindergarden] will have its `id` field set.
  Future<Kindergarden> insertRow(
    _i1.Session session,
    Kindergarden row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Kindergarden>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Kindergarden]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Kindergarden>> update(
    _i1.Session session,
    List<Kindergarden> rows, {
    _i1.ColumnSelections<KindergardenTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Kindergarden>(
      rows,
      columns: columns?.call(Kindergarden.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Kindergarden]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Kindergarden> updateRow(
    _i1.Session session,
    Kindergarden row, {
    _i1.ColumnSelections<KindergardenTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Kindergarden>(
      row,
      columns: columns?.call(Kindergarden.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Kindergarden]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Kindergarden>> delete(
    _i1.Session session,
    List<Kindergarden> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Kindergarden>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Kindergarden].
  Future<Kindergarden> deleteRow(
    _i1.Session session,
    Kindergarden row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Kindergarden>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Kindergarden>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<KindergardenTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Kindergarden>(
      where: where(Kindergarden.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<KindergardenTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Kindergarden>(
      where: where?.call(Kindergarden.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class KindergardenAttachRepository {
  const KindergardenAttachRepository._();

  /// Creates a relation between this [Kindergarden] and the given [PupilData]s
  /// by setting each [PupilData]'s foreign key `_kindergardenPupilsKindergardenId` to refer to this [Kindergarden].
  Future<void> pupils(
    _i1.Session session,
    Kindergarden kindergarden,
    List<_i2.PupilData> pupilData, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('pupilData.id');
    }
    if (kindergarden.id == null) {
      throw ArgumentError.notNull('kindergarden.id');
    }

    var $pupilData = pupilData
        .map((e) => _i2.PupilDataImplicit(
              e,
              $_kindergardenPupilsKindergardenId: kindergarden.id,
            ))
        .toList();
    await session.db.update<_i2.PupilData>(
      $pupilData,
      columns: [_i2.PupilData.t.$_kindergardenPupilsKindergardenId],
      transaction: transaction,
    );
  }
}

class KindergardenAttachRowRepository {
  const KindergardenAttachRowRepository._();

  /// Creates a relation between this [Kindergarden] and the given [PupilData]
  /// by setting the [PupilData]'s foreign key `_kindergardenPupilsKindergardenId` to refer to this [Kindergarden].
  Future<void> pupils(
    _i1.Session session,
    Kindergarden kindergarden,
    _i2.PupilData pupilData, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }
    if (kindergarden.id == null) {
      throw ArgumentError.notNull('kindergarden.id');
    }

    var $pupilData = _i2.PupilDataImplicit(
      pupilData,
      $_kindergardenPupilsKindergardenId: kindergarden.id,
    );
    await session.db.updateRow<_i2.PupilData>(
      $pupilData,
      columns: [_i2.PupilData.t.$_kindergardenPupilsKindergardenId],
      transaction: transaction,
    );
  }
}

class KindergardenDetachRepository {
  const KindergardenDetachRepository._();

  /// Detaches the relation between this [Kindergarden] and the given [PupilData]
  /// by setting the [PupilData]'s foreign key `_kindergardenPupilsKindergardenId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> pupils(
    _i1.Session session,
    List<_i2.PupilData> pupilData, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $pupilData = pupilData
        .map((e) => _i2.PupilDataImplicit(
              e,
              $_kindergardenPupilsKindergardenId: null,
            ))
        .toList();
    await session.db.update<_i2.PupilData>(
      $pupilData,
      columns: [_i2.PupilData.t.$_kindergardenPupilsKindergardenId],
      transaction: transaction,
    );
  }
}

class KindergardenDetachRowRepository {
  const KindergardenDetachRowRepository._();

  /// Detaches the relation between this [Kindergarden] and the given [PupilData]
  /// by setting the [PupilData]'s foreign key `_kindergardenPupilsKindergardenId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> pupils(
    _i1.Session session,
    _i2.PupilData pupilData, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $pupilData = _i2.PupilDataImplicit(
      pupilData,
      $_kindergardenPupilsKindergardenId: null,
    );
    await session.db.updateRow<_i2.PupilData>(
      $pupilData,
      columns: [_i2.PupilData.t.$_kindergardenPupilsKindergardenId],
      transaction: transaction,
    );
  }
}

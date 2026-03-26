/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../../../_features/pupil/models/pupil_data/pupil_data.dart' as _i2;
import '../../../_features/books/models/library_book.dart' as _i3;
import '../../../_shared/models/hub_document.dart' as _i4;
import '../../../_features/user/models/staff_user.dart' as _i5;

abstract class PupilBookLending implements _i1.SerializableModel {
  PupilBookLending._({
    this.id,
    required this.lendingId,
    this.status,
    required this.score,
    this.bookScore,
    required this.lentAt,
    required this.lentBy,
    this.returnedAt,
    this.receivedBy,
    this.pupilId,
    this.pupil,
    required this.isbn,
    required this.libraryBookId,
    this.libraryBook,
    this.pupilBookLendingFiles,
    this.borrowerUserId,
    this.borrowerUser,
    this.borrowerType,
  });

  factory PupilBookLending({
    int? id,
    required String lendingId,
    String? status,
    required int score,
    int? bookScore,
    required DateTime lentAt,
    required String lentBy,
    DateTime? returnedAt,
    String? receivedBy,
    int? pupilId,
    _i2.PupilData? pupil,
    required int isbn,
    required int libraryBookId,
    _i3.LibraryBook? libraryBook,
    List<_i4.HubDocument>? pupilBookLendingFiles,
    int? borrowerUserId,
    _i5.User? borrowerUser,
    String? borrowerType,
  }) = _PupilBookLendingImpl;

  factory PupilBookLending.fromJson(Map<String, dynamic> jsonSerialization) {
    return PupilBookLending(
      id: jsonSerialization['id'] as int?,
      lendingId: jsonSerialization['lendingId'] as String,
      status: jsonSerialization['status'] as String?,
      score: jsonSerialization['score'] as int,
      bookScore: jsonSerialization['bookScore'] as int?,
      lentAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lentAt']),
      lentBy: jsonSerialization['lentBy'] as String,
      returnedAt: jsonSerialization['returnedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['returnedAt']),
      receivedBy: jsonSerialization['receivedBy'] as String?,
      pupilId: jsonSerialization['pupilId'] as int?,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i2.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
      isbn: jsonSerialization['isbn'] as int,
      libraryBookId: jsonSerialization['libraryBookId'] as int,
      libraryBook: jsonSerialization['libraryBook'] == null
          ? null
          : _i3.LibraryBook.fromJson(
              (jsonSerialization['libraryBook'] as Map<String, dynamic>)),
      pupilBookLendingFiles: (jsonSerialization['pupilBookLendingFiles']
              as List?)
          ?.map((e) => _i4.HubDocument.fromJson((e as Map<String, dynamic>)))
          .toList(),
      borrowerUserId: jsonSerialization['borrowerUserId'] as int?,
      borrowerUser: jsonSerialization['borrowerUser'] == null
          ? null
          : _i5.User.fromJson(
              (jsonSerialization['borrowerUser'] as Map<String, dynamic>)),
      borrowerType: jsonSerialization['borrowerType'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String lendingId;

  String? status;

  int score;

  int? bookScore;

  DateTime lentAt;

  String lentBy;

  DateTime? returnedAt;

  String? receivedBy;

  int? pupilId;

  _i2.PupilData? pupil;

  int isbn;

  int libraryBookId;

  _i3.LibraryBook? libraryBook;

  List<_i4.HubDocument>? pupilBookLendingFiles;

  int? borrowerUserId;

  _i5.User? borrowerUser;

  String? borrowerType;

  /// Returns a shallow copy of this [PupilBookLending]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilBookLending copyWith({
    int? id,
    String? lendingId,
    String? status,
    int? score,
    int? bookScore,
    DateTime? lentAt,
    String? lentBy,
    DateTime? returnedAt,
    String? receivedBy,
    int? pupilId,
    _i2.PupilData? pupil,
    int? isbn,
    int? libraryBookId,
    _i3.LibraryBook? libraryBook,
    List<_i4.HubDocument>? pupilBookLendingFiles,
    int? borrowerUserId,
    _i5.User? borrowerUser,
    String? borrowerType,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'lendingId': lendingId,
      if (status != null) 'status': status,
      'score': score,
      if (bookScore != null) 'bookScore': bookScore,
      'lentAt': lentAt.toJson(),
      'lentBy': lentBy,
      if (returnedAt != null) 'returnedAt': returnedAt?.toJson(),
      if (receivedBy != null) 'receivedBy': receivedBy,
      if (pupilId != null) 'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
      'isbn': isbn,
      'libraryBookId': libraryBookId,
      if (libraryBook != null) 'libraryBook': libraryBook?.toJson(),
      if (pupilBookLendingFiles != null)
        'pupilBookLendingFiles':
            pupilBookLendingFiles?.toJson(valueToJson: (v) => v.toJson()),
      if (borrowerUserId != null) 'borrowerUserId': borrowerUserId,
      if (borrowerUser != null) 'borrowerUser': borrowerUser?.toJson(),
      if (borrowerType != null) 'borrowerType': borrowerType,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PupilBookLendingImpl extends PupilBookLending {
  _PupilBookLendingImpl({
    int? id,
    required String lendingId,
    String? status,
    required int score,
    int? bookScore,
    required DateTime lentAt,
    required String lentBy,
    DateTime? returnedAt,
    String? receivedBy,
    int? pupilId,
    _i2.PupilData? pupil,
    required int isbn,
    required int libraryBookId,
    _i3.LibraryBook? libraryBook,
    List<_i4.HubDocument>? pupilBookLendingFiles,
    int? borrowerUserId,
    _i5.User? borrowerUser,
    String? borrowerType,
  }) : super._(
          id: id,
          lendingId: lendingId,
          status: status,
          score: score,
          bookScore: bookScore,
          lentAt: lentAt,
          lentBy: lentBy,
          returnedAt: returnedAt,
          receivedBy: receivedBy,
          pupilId: pupilId,
          pupil: pupil,
          isbn: isbn,
          libraryBookId: libraryBookId,
          libraryBook: libraryBook,
          pupilBookLendingFiles: pupilBookLendingFiles,
          borrowerUserId: borrowerUserId,
          borrowerUser: borrowerUser,
          borrowerType: borrowerType,
        );

  /// Returns a shallow copy of this [PupilBookLending]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilBookLending copyWith({
    Object? id = _Undefined,
    String? lendingId,
    Object? status = _Undefined,
    int? score,
    Object? bookScore = _Undefined,
    DateTime? lentAt,
    String? lentBy,
    Object? returnedAt = _Undefined,
    Object? receivedBy = _Undefined,
    Object? pupilId = _Undefined,
    Object? pupil = _Undefined,
    int? isbn,
    int? libraryBookId,
    Object? libraryBook = _Undefined,
    Object? pupilBookLendingFiles = _Undefined,
    Object? borrowerUserId = _Undefined,
    Object? borrowerUser = _Undefined,
    Object? borrowerType = _Undefined,
  }) {
    return PupilBookLending(
      id: id is int? ? id : this.id,
      lendingId: lendingId ?? this.lendingId,
      status: status is String? ? status : this.status,
      score: score ?? this.score,
      bookScore: bookScore is int? ? bookScore : this.bookScore,
      lentAt: lentAt ?? this.lentAt,
      lentBy: lentBy ?? this.lentBy,
      returnedAt: returnedAt is DateTime? ? returnedAt : this.returnedAt,
      receivedBy: receivedBy is String? ? receivedBy : this.receivedBy,
      pupilId: pupilId is int? ? pupilId : this.pupilId,
      pupil: pupil is _i2.PupilData? ? pupil : this.pupil?.copyWith(),
      isbn: isbn ?? this.isbn,
      libraryBookId: libraryBookId ?? this.libraryBookId,
      libraryBook: libraryBook is _i3.LibraryBook?
          ? libraryBook
          : this.libraryBook?.copyWith(),
      pupilBookLendingFiles: pupilBookLendingFiles is List<_i4.HubDocument>?
          ? pupilBookLendingFiles
          : this.pupilBookLendingFiles?.map((e0) => e0.copyWith()).toList(),
      borrowerUserId:
          borrowerUserId is int? ? borrowerUserId : this.borrowerUserId,
      borrowerUser: borrowerUser is _i5.User?
          ? borrowerUser
          : this.borrowerUser?.copyWith(),
      borrowerType: borrowerType is String? ? borrowerType : this.borrowerType,
    );
  }
}

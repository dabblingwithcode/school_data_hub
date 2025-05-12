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
import '../pupil_data/pupil_data.dart' as _i2;
import '../book/library_book.dart' as _i3;
import '../shared/document.dart' as _i4;

abstract class PupilBookLending implements _i1.SerializableModel {
  PupilBookLending._({
    this.id,
    required this.lendingId,
    this.status,
    this.score,
    required this.lentAt,
    required this.lentBy,
    this.returnedAt,
    this.receivedBy,
    required this.pupilId,
    this.pupil,
    required this.libraryBookId,
    this.libraryBook,
    this.pupilBookLendingFiles,
  });

  factory PupilBookLending({
    int? id,
    required String lendingId,
    String? status,
    int? score,
    required DateTime lentAt,
    required String lentBy,
    DateTime? returnedAt,
    String? receivedBy,
    required int pupilId,
    _i2.PupilData? pupil,
    required int libraryBookId,
    _i3.LibraryBook? libraryBook,
    List<_i4.HubDocument>? pupilBookLendingFiles,
  }) = _PupilBookLendingImpl;

  factory PupilBookLending.fromJson(Map<String, dynamic> jsonSerialization) {
    return PupilBookLending(
      id: jsonSerialization['id'] as int?,
      lendingId: jsonSerialization['lendingId'] as String,
      status: jsonSerialization['status'] as String?,
      score: jsonSerialization['score'] as int?,
      lentAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lentAt']),
      lentBy: jsonSerialization['lentBy'] as String,
      returnedAt: jsonSerialization['returnedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['returnedAt']),
      receivedBy: jsonSerialization['receivedBy'] as String?,
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i2.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
      libraryBookId: jsonSerialization['libraryBookId'] as int,
      libraryBook: jsonSerialization['libraryBook'] == null
          ? null
          : _i3.LibraryBook.fromJson(
              (jsonSerialization['libraryBook'] as Map<String, dynamic>)),
      pupilBookLendingFiles: (jsonSerialization['pupilBookLendingFiles']
              as List?)
          ?.map((e) => _i4.HubDocument.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String lendingId;

  String? status;

  int? score;

  DateTime lentAt;

  String lentBy;

  DateTime? returnedAt;

  String? receivedBy;

  int pupilId;

  _i2.PupilData? pupil;

  int libraryBookId;

  _i3.LibraryBook? libraryBook;

  List<_i4.HubDocument>? pupilBookLendingFiles;

  /// Returns a shallow copy of this [PupilBookLending]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilBookLending copyWith({
    int? id,
    String? lendingId,
    String? status,
    int? score,
    DateTime? lentAt,
    String? lentBy,
    DateTime? returnedAt,
    String? receivedBy,
    int? pupilId,
    _i2.PupilData? pupil,
    int? libraryBookId,
    _i3.LibraryBook? libraryBook,
    List<_i4.HubDocument>? pupilBookLendingFiles,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'lendingId': lendingId,
      if (status != null) 'status': status,
      if (score != null) 'score': score,
      'lentAt': lentAt.toJson(),
      'lentBy': lentBy,
      if (returnedAt != null) 'returnedAt': returnedAt?.toJson(),
      if (receivedBy != null) 'receivedBy': receivedBy,
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
      'libraryBookId': libraryBookId,
      if (libraryBook != null) 'libraryBook': libraryBook?.toJson(),
      if (pupilBookLendingFiles != null)
        'pupilBookLendingFiles':
            pupilBookLendingFiles?.toJson(valueToJson: (v) => v.toJson()),
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
    int? score,
    required DateTime lentAt,
    required String lentBy,
    DateTime? returnedAt,
    String? receivedBy,
    required int pupilId,
    _i2.PupilData? pupil,
    required int libraryBookId,
    _i3.LibraryBook? libraryBook,
    List<_i4.HubDocument>? pupilBookLendingFiles,
  }) : super._(
          id: id,
          lendingId: lendingId,
          status: status,
          score: score,
          lentAt: lentAt,
          lentBy: lentBy,
          returnedAt: returnedAt,
          receivedBy: receivedBy,
          pupilId: pupilId,
          pupil: pupil,
          libraryBookId: libraryBookId,
          libraryBook: libraryBook,
          pupilBookLendingFiles: pupilBookLendingFiles,
        );

  /// Returns a shallow copy of this [PupilBookLending]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilBookLending copyWith({
    Object? id = _Undefined,
    String? lendingId,
    Object? status = _Undefined,
    Object? score = _Undefined,
    DateTime? lentAt,
    String? lentBy,
    Object? returnedAt = _Undefined,
    Object? receivedBy = _Undefined,
    int? pupilId,
    Object? pupil = _Undefined,
    int? libraryBookId,
    Object? libraryBook = _Undefined,
    Object? pupilBookLendingFiles = _Undefined,
  }) {
    return PupilBookLending(
      id: id is int? ? id : this.id,
      lendingId: lendingId ?? this.lendingId,
      status: status is String? ? status : this.status,
      score: score is int? ? score : this.score,
      lentAt: lentAt ?? this.lentAt,
      lentBy: lentBy ?? this.lentBy,
      returnedAt: returnedAt is DateTime? ? returnedAt : this.returnedAt,
      receivedBy: receivedBy is String? ? receivedBy : this.receivedBy,
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i2.PupilData? ? pupil : this.pupil?.copyWith(),
      libraryBookId: libraryBookId ?? this.libraryBookId,
      libraryBook: libraryBook is _i3.LibraryBook?
          ? libraryBook
          : this.libraryBook?.copyWith(),
      pupilBookLendingFiles: pupilBookLendingFiles is List<_i4.HubDocument>?
          ? pupilBookLendingFiles
          : this.pupilBookLendingFiles?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

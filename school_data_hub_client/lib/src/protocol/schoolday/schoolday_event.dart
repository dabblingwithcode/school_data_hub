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
import '../schoolday/schoolday.dart' as _i2;
import '../pupil_data/pupil_data.dart' as _i3;

abstract class SchooldayEvent implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

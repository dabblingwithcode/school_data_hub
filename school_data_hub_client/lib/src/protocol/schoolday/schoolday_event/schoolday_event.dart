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
import '../../schoolday/schoolday_event/schoolday_event_type.dart' as _i2;
import '../../shared/document.dart' as _i3;
import '../../schoolday/schoolday.dart' as _i4;
import '../../pupil_data/pupil_data.dart' as _i5;

abstract class SchooldayEvent implements _i1.SerializableModel {
  SchooldayEvent._({
    this.id,
    required this.eventId,
    required this.eventType,
    required this.eventReason,
    required this.createdBy,
    required this.processed,
    this.processedBy,
    this.processedAt,
    this.documentId,
    this.document,
    this.processedDocumentId,
    this.processedDocument,
    required this.schooldayId,
    this.schoolday,
    required this.pupilId,
    this.pupil,
  });

  factory SchooldayEvent({
    int? id,
    required String eventId,
    required _i2.SchooldayEventType eventType,
    required String eventReason,
    required String createdBy,
    required bool processed,
    String? processedBy,
    DateTime? processedAt,
    int? documentId,
    _i3.HubDocument? document,
    int? processedDocumentId,
    _i3.HubDocument? processedDocument,
    required int schooldayId,
    _i4.Schoolday? schoolday,
    required int pupilId,
    _i5.PupilData? pupil,
  }) = _SchooldayEventImpl;

  factory SchooldayEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return SchooldayEvent(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as String,
      eventType: _i2.SchooldayEventType.fromJson(
          (jsonSerialization['eventType'] as String)),
      eventReason: jsonSerialization['eventReason'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      processed: jsonSerialization['processed'] as bool,
      processedBy: jsonSerialization['processedBy'] as String?,
      processedAt: jsonSerialization['processedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['processedAt']),
      documentId: jsonSerialization['documentId'] as int?,
      document: jsonSerialization['document'] == null
          ? null
          : _i3.HubDocument.fromJson(
              (jsonSerialization['document'] as Map<String, dynamic>)),
      processedDocumentId: jsonSerialization['processedDocumentId'] as int?,
      processedDocument: jsonSerialization['processedDocument'] == null
          ? null
          : _i3.HubDocument.fromJson(
              (jsonSerialization['processedDocument'] as Map<String, dynamic>)),
      schooldayId: jsonSerialization['schooldayId'] as int,
      schoolday: jsonSerialization['schoolday'] == null
          ? null
          : _i4.Schoolday.fromJson(
              (jsonSerialization['schoolday'] as Map<String, dynamic>)),
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i5.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String eventId;

  _i2.SchooldayEventType eventType;

  String eventReason;

  String createdBy;

  bool processed;

  String? processedBy;

  DateTime? processedAt;

  int? documentId;

  _i3.HubDocument? document;

  int? processedDocumentId;

  _i3.HubDocument? processedDocument;

  int schooldayId;

  _i4.Schoolday? schoolday;

  int pupilId;

  _i5.PupilData? pupil;

  /// Returns a shallow copy of this [SchooldayEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SchooldayEvent copyWith({
    int? id,
    String? eventId,
    _i2.SchooldayEventType? eventType,
    String? eventReason,
    String? createdBy,
    bool? processed,
    String? processedBy,
    DateTime? processedAt,
    int? documentId,
    _i3.HubDocument? document,
    int? processedDocumentId,
    _i3.HubDocument? processedDocument,
    int? schooldayId,
    _i4.Schoolday? schoolday,
    int? pupilId,
    _i5.PupilData? pupil,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'eventId': eventId,
      'eventType': eventType.toJson(),
      'eventReason': eventReason,
      'createdBy': createdBy,
      'processed': processed,
      if (processedBy != null) 'processedBy': processedBy,
      if (processedAt != null) 'processedAt': processedAt?.toJson(),
      if (documentId != null) 'documentId': documentId,
      if (document != null) 'document': document?.toJson(),
      if (processedDocumentId != null)
        'processedDocumentId': processedDocumentId,
      if (processedDocument != null)
        'processedDocument': processedDocument?.toJson(),
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
    required _i2.SchooldayEventType eventType,
    required String eventReason,
    required String createdBy,
    required bool processed,
    String? processedBy,
    DateTime? processedAt,
    int? documentId,
    _i3.HubDocument? document,
    int? processedDocumentId,
    _i3.HubDocument? processedDocument,
    required int schooldayId,
    _i4.Schoolday? schoolday,
    required int pupilId,
    _i5.PupilData? pupil,
  }) : super._(
          id: id,
          eventId: eventId,
          eventType: eventType,
          eventReason: eventReason,
          createdBy: createdBy,
          processed: processed,
          processedBy: processedBy,
          processedAt: processedAt,
          documentId: documentId,
          document: document,
          processedDocumentId: processedDocumentId,
          processedDocument: processedDocument,
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
    _i2.SchooldayEventType? eventType,
    String? eventReason,
    String? createdBy,
    bool? processed,
    Object? processedBy = _Undefined,
    Object? processedAt = _Undefined,
    Object? documentId = _Undefined,
    Object? document = _Undefined,
    Object? processedDocumentId = _Undefined,
    Object? processedDocument = _Undefined,
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
      processedBy: processedBy is String? ? processedBy : this.processedBy,
      processedAt: processedAt is DateTime? ? processedAt : this.processedAt,
      documentId: documentId is int? ? documentId : this.documentId,
      document:
          document is _i3.HubDocument? ? document : this.document?.copyWith(),
      processedDocumentId: processedDocumentId is int?
          ? processedDocumentId
          : this.processedDocumentId,
      processedDocument: processedDocument is _i3.HubDocument?
          ? processedDocument
          : this.processedDocument?.copyWith(),
      schooldayId: schooldayId ?? this.schooldayId,
      schoolday:
          schoolday is _i4.Schoolday? ? schoolday : this.schoolday?.copyWith(),
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i5.PupilData? ? pupil : this.pupil?.copyWith(),
    );
  }
}

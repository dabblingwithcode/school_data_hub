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
import '../learning_support/support_level.dart' as _i2;
import '../pupil_data/pupil_data_parent_info.dart' as _i3;
import '../pupil_data/pupil_enums.dart' as _i4;
import '../authorization/pupil_authorization.dart' as _i5;
import '../schoolday/missed_class.dart' as _i6;
import '../schoolday/schoolday_event.dart' as _i7;
import '../workbook/workbook.dart' as _i8;
import '../learning_support/support_goal/support_goal.dart' as _i9;
import '../learning_support/support_category_status.dart' as _i10;
import '../workbook/pupil_workbook.dart' as _i11;
import '../book/pupil_book_lending.dart' as _i12;
import '../learning/competence_goal.dart' as _i13;
import '../learning/competence_check.dart' as _i14;
import '../learning/competence_report.dart' as _i15;
import '../learning/competence_report_check.dart' as _i16;
import '../school_list/pupil_list.dart' as _i17;

/// Pupil class
abstract class PupilData implements _i1.SerializableModel {
  PupilData._({
    this.id,
    required this.internalId,
    this.contact,
    required this.credit,
    required this.creditEarned,
    required this.ogs,
    this.pickUpTime,
    this.ogsInfo,
    required this.latestSupportLevel,
    required this.repeater,
    required this.swimmer,
    required this.communicationPupil,
    this.pupilDataParentInfo,
    required this.preSchoolRevision,
    this.authorizations,
    this.missedClasses,
    this.schooldayEvents,
    this.workbooks,
    this.supportGoals,
    this.supportCategoryStatuses,
    this.pupilWorkbooks,
    this.pupilBookLendings,
    this.competenceGoals,
    this.competenceChecks,
    this.competenceReports,
    this.competenceReportChecks,
    this.pupilLists,
  });

  factory PupilData({
    int? id,
    required int internalId,
    String? contact,
    required int credit,
    required int creditEarned,
    required bool ogs,
    String? pickUpTime,
    String? ogsInfo,
    required _i2.SupportLevel latestSupportLevel,
    required DateTime repeater,
    required String swimmer,
    required String communicationPupil,
    _i3.PupilDataParentInfo? pupilDataParentInfo,
    required _i4.PreSchoolRevision preSchoolRevision,
    List<_i5.PupilAuthorization>? authorizations,
    List<_i6.MissedClass>? missedClasses,
    List<_i7.SchooldayEvent>? schooldayEvents,
    List<_i8.Workbook>? workbooks,
    List<_i9.SupportGoal>? supportGoals,
    List<_i10.SupportCategoryStatus>? supportCategoryStatuses,
    List<_i11.PupilWorkbook>? pupilWorkbooks,
    List<_i12.PupilBookLending>? pupilBookLendings,
    List<_i13.CompetenceGoal>? competenceGoals,
    List<_i14.CompetenceCheck>? competenceChecks,
    List<_i15.CompetenceReport>? competenceReports,
    List<_i16.CompetenceReportCheck>? competenceReportChecks,
    List<_i17.PupilList>? pupilLists,
  }) = _PupilDataImpl;

  factory PupilData.fromJson(Map<String, dynamic> jsonSerialization) {
    return PupilData(
      id: jsonSerialization['id'] as int?,
      internalId: jsonSerialization['internalId'] as int,
      contact: jsonSerialization['contact'] as String?,
      credit: jsonSerialization['credit'] as int,
      creditEarned: jsonSerialization['creditEarned'] as int,
      ogs: jsonSerialization['ogs'] as bool,
      pickUpTime: jsonSerialization['pickUpTime'] as String?,
      ogsInfo: jsonSerialization['ogsInfo'] as String?,
      latestSupportLevel: _i2.SupportLevel.fromJson(
          (jsonSerialization['latestSupportLevel'] as String)),
      repeater:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['repeater']),
      swimmer: jsonSerialization['swimmer'] as String,
      communicationPupil: jsonSerialization['communicationPupil'] as String,
      pupilDataParentInfo: jsonSerialization['pupilDataParentInfo'] == null
          ? null
          : _i3.PupilDataParentInfo.fromJson(
              (jsonSerialization['pupilDataParentInfo']
                  as Map<String, dynamic>)),
      preSchoolRevision: _i4.PreSchoolRevision.fromJson(
          (jsonSerialization['preSchoolRevision'] as String)),
      authorizations: (jsonSerialization['authorizations'] as List?)
          ?.map((e) =>
              _i5.PupilAuthorization.fromJson((e as Map<String, dynamic>)))
          .toList(),
      missedClasses: (jsonSerialization['missedClasses'] as List?)
          ?.map((e) => _i6.MissedClass.fromJson((e as Map<String, dynamic>)))
          .toList(),
      schooldayEvents: (jsonSerialization['schooldayEvents'] as List?)
          ?.map((e) => _i7.SchooldayEvent.fromJson((e as Map<String, dynamic>)))
          .toList(),
      workbooks: (jsonSerialization['workbooks'] as List?)
          ?.map((e) => _i8.Workbook.fromJson((e as Map<String, dynamic>)))
          .toList(),
      supportGoals: (jsonSerialization['supportGoals'] as List?)
          ?.map((e) => _i9.SupportGoal.fromJson((e as Map<String, dynamic>)))
          .toList(),
      supportCategoryStatuses: (jsonSerialization['supportCategoryStatuses']
              as List?)
          ?.map((e) =>
              _i10.SupportCategoryStatus.fromJson((e as Map<String, dynamic>)))
          .toList(),
      pupilWorkbooks: (jsonSerialization['pupilWorkbooks'] as List?)
          ?.map((e) => _i11.PupilWorkbook.fromJson((e as Map<String, dynamic>)))
          .toList(),
      pupilBookLendings: (jsonSerialization['pupilBookLendings'] as List?)
          ?.map((e) =>
              _i12.PupilBookLending.fromJson((e as Map<String, dynamic>)))
          .toList(),
      competenceGoals: (jsonSerialization['competenceGoals'] as List?)
          ?.map(
              (e) => _i13.CompetenceGoal.fromJson((e as Map<String, dynamic>)))
          .toList(),
      competenceChecks: (jsonSerialization['competenceChecks'] as List?)
          ?.map(
              (e) => _i14.CompetenceCheck.fromJson((e as Map<String, dynamic>)))
          .toList(),
      competenceReports: (jsonSerialization['competenceReports'] as List?)
          ?.map((e) =>
              _i15.CompetenceReport.fromJson((e as Map<String, dynamic>)))
          .toList(),
      competenceReportChecks: (jsonSerialization['competenceReportChecks']
              as List?)
          ?.map((e) =>
              _i16.CompetenceReportCheck.fromJson((e as Map<String, dynamic>)))
          .toList(),
      pupilLists: (jsonSerialization['pupilLists'] as List?)
          ?.map((e) => _i17.PupilList.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int internalId;

  String? contact;

  int credit;

  int creditEarned;

  bool ogs;

  String? pickUpTime;

  String? ogsInfo;

  _i2.SupportLevel latestSupportLevel;

  DateTime repeater;

  String swimmer;

  String communicationPupil;

  _i3.PupilDataParentInfo? pupilDataParentInfo;

  _i4.PreSchoolRevision preSchoolRevision;

  List<_i5.PupilAuthorization>? authorizations;

  List<_i6.MissedClass>? missedClasses;

  List<_i7.SchooldayEvent>? schooldayEvents;

  List<_i8.Workbook>? workbooks;

  List<_i9.SupportGoal>? supportGoals;

  List<_i10.SupportCategoryStatus>? supportCategoryStatuses;

  List<_i11.PupilWorkbook>? pupilWorkbooks;

  List<_i12.PupilBookLending>? pupilBookLendings;

  List<_i13.CompetenceGoal>? competenceGoals;

  List<_i14.CompetenceCheck>? competenceChecks;

  List<_i15.CompetenceReport>? competenceReports;

  List<_i16.CompetenceReportCheck>? competenceReportChecks;

  List<_i17.PupilList>? pupilLists;

  /// Returns a shallow copy of this [PupilData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilData copyWith({
    int? id,
    int? internalId,
    String? contact,
    int? credit,
    int? creditEarned,
    bool? ogs,
    String? pickUpTime,
    String? ogsInfo,
    _i2.SupportLevel? latestSupportLevel,
    DateTime? repeater,
    String? swimmer,
    String? communicationPupil,
    _i3.PupilDataParentInfo? pupilDataParentInfo,
    _i4.PreSchoolRevision? preSchoolRevision,
    List<_i5.PupilAuthorization>? authorizations,
    List<_i6.MissedClass>? missedClasses,
    List<_i7.SchooldayEvent>? schooldayEvents,
    List<_i8.Workbook>? workbooks,
    List<_i9.SupportGoal>? supportGoals,
    List<_i10.SupportCategoryStatus>? supportCategoryStatuses,
    List<_i11.PupilWorkbook>? pupilWorkbooks,
    List<_i12.PupilBookLending>? pupilBookLendings,
    List<_i13.CompetenceGoal>? competenceGoals,
    List<_i14.CompetenceCheck>? competenceChecks,
    List<_i15.CompetenceReport>? competenceReports,
    List<_i16.CompetenceReportCheck>? competenceReportChecks,
    List<_i17.PupilList>? pupilLists,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'internalId': internalId,
      if (contact != null) 'contact': contact,
      'credit': credit,
      'creditEarned': creditEarned,
      'ogs': ogs,
      if (pickUpTime != null) 'pickUpTime': pickUpTime,
      if (ogsInfo != null) 'ogsInfo': ogsInfo,
      'latestSupportLevel': latestSupportLevel.toJson(),
      'repeater': repeater.toJson(),
      'swimmer': swimmer,
      'communicationPupil': communicationPupil,
      if (pupilDataParentInfo != null)
        'pupilDataParentInfo': pupilDataParentInfo?.toJson(),
      'preSchoolRevision': preSchoolRevision.toJson(),
      if (authorizations != null)
        'authorizations':
            authorizations?.toJson(valueToJson: (v) => v.toJson()),
      if (missedClasses != null)
        'missedClasses': missedClasses?.toJson(valueToJson: (v) => v.toJson()),
      if (schooldayEvents != null)
        'schooldayEvents':
            schooldayEvents?.toJson(valueToJson: (v) => v.toJson()),
      if (workbooks != null)
        'workbooks': workbooks?.toJson(valueToJson: (v) => v.toJson()),
      if (supportGoals != null)
        'supportGoals': supportGoals?.toJson(valueToJson: (v) => v.toJson()),
      if (supportCategoryStatuses != null)
        'supportCategoryStatuses':
            supportCategoryStatuses?.toJson(valueToJson: (v) => v.toJson()),
      if (pupilWorkbooks != null)
        'pupilWorkbooks':
            pupilWorkbooks?.toJson(valueToJson: (v) => v.toJson()),
      if (pupilBookLendings != null)
        'pupilBookLendings':
            pupilBookLendings?.toJson(valueToJson: (v) => v.toJson()),
      if (competenceGoals != null)
        'competenceGoals':
            competenceGoals?.toJson(valueToJson: (v) => v.toJson()),
      if (competenceChecks != null)
        'competenceChecks':
            competenceChecks?.toJson(valueToJson: (v) => v.toJson()),
      if (competenceReports != null)
        'competenceReports':
            competenceReports?.toJson(valueToJson: (v) => v.toJson()),
      if (competenceReportChecks != null)
        'competenceReportChecks':
            competenceReportChecks?.toJson(valueToJson: (v) => v.toJson()),
      if (pupilLists != null)
        'pupilLists': pupilLists?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PupilDataImpl extends PupilData {
  _PupilDataImpl({
    int? id,
    required int internalId,
    String? contact,
    required int credit,
    required int creditEarned,
    required bool ogs,
    String? pickUpTime,
    String? ogsInfo,
    required _i2.SupportLevel latestSupportLevel,
    required DateTime repeater,
    required String swimmer,
    required String communicationPupil,
    _i3.PupilDataParentInfo? pupilDataParentInfo,
    required _i4.PreSchoolRevision preSchoolRevision,
    List<_i5.PupilAuthorization>? authorizations,
    List<_i6.MissedClass>? missedClasses,
    List<_i7.SchooldayEvent>? schooldayEvents,
    List<_i8.Workbook>? workbooks,
    List<_i9.SupportGoal>? supportGoals,
    List<_i10.SupportCategoryStatus>? supportCategoryStatuses,
    List<_i11.PupilWorkbook>? pupilWorkbooks,
    List<_i12.PupilBookLending>? pupilBookLendings,
    List<_i13.CompetenceGoal>? competenceGoals,
    List<_i14.CompetenceCheck>? competenceChecks,
    List<_i15.CompetenceReport>? competenceReports,
    List<_i16.CompetenceReportCheck>? competenceReportChecks,
    List<_i17.PupilList>? pupilLists,
  }) : super._(
          id: id,
          internalId: internalId,
          contact: contact,
          credit: credit,
          creditEarned: creditEarned,
          ogs: ogs,
          pickUpTime: pickUpTime,
          ogsInfo: ogsInfo,
          latestSupportLevel: latestSupportLevel,
          repeater: repeater,
          swimmer: swimmer,
          communicationPupil: communicationPupil,
          pupilDataParentInfo: pupilDataParentInfo,
          preSchoolRevision: preSchoolRevision,
          authorizations: authorizations,
          missedClasses: missedClasses,
          schooldayEvents: schooldayEvents,
          workbooks: workbooks,
          supportGoals: supportGoals,
          supportCategoryStatuses: supportCategoryStatuses,
          pupilWorkbooks: pupilWorkbooks,
          pupilBookLendings: pupilBookLendings,
          competenceGoals: competenceGoals,
          competenceChecks: competenceChecks,
          competenceReports: competenceReports,
          competenceReportChecks: competenceReportChecks,
          pupilLists: pupilLists,
        );

  /// Returns a shallow copy of this [PupilData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilData copyWith({
    Object? id = _Undefined,
    int? internalId,
    Object? contact = _Undefined,
    int? credit,
    int? creditEarned,
    bool? ogs,
    Object? pickUpTime = _Undefined,
    Object? ogsInfo = _Undefined,
    _i2.SupportLevel? latestSupportLevel,
    DateTime? repeater,
    String? swimmer,
    String? communicationPupil,
    Object? pupilDataParentInfo = _Undefined,
    _i4.PreSchoolRevision? preSchoolRevision,
    Object? authorizations = _Undefined,
    Object? missedClasses = _Undefined,
    Object? schooldayEvents = _Undefined,
    Object? workbooks = _Undefined,
    Object? supportGoals = _Undefined,
    Object? supportCategoryStatuses = _Undefined,
    Object? pupilWorkbooks = _Undefined,
    Object? pupilBookLendings = _Undefined,
    Object? competenceGoals = _Undefined,
    Object? competenceChecks = _Undefined,
    Object? competenceReports = _Undefined,
    Object? competenceReportChecks = _Undefined,
    Object? pupilLists = _Undefined,
  }) {
    return PupilData(
      id: id is int? ? id : this.id,
      internalId: internalId ?? this.internalId,
      contact: contact is String? ? contact : this.contact,
      credit: credit ?? this.credit,
      creditEarned: creditEarned ?? this.creditEarned,
      ogs: ogs ?? this.ogs,
      pickUpTime: pickUpTime is String? ? pickUpTime : this.pickUpTime,
      ogsInfo: ogsInfo is String? ? ogsInfo : this.ogsInfo,
      latestSupportLevel: latestSupportLevel ?? this.latestSupportLevel,
      repeater: repeater ?? this.repeater,
      swimmer: swimmer ?? this.swimmer,
      communicationPupil: communicationPupil ?? this.communicationPupil,
      pupilDataParentInfo: pupilDataParentInfo is _i3.PupilDataParentInfo?
          ? pupilDataParentInfo
          : this.pupilDataParentInfo?.copyWith(),
      preSchoolRevision: preSchoolRevision ?? this.preSchoolRevision,
      authorizations: authorizations is List<_i5.PupilAuthorization>?
          ? authorizations
          : this.authorizations?.map((e0) => e0.copyWith()).toList(),
      missedClasses: missedClasses is List<_i6.MissedClass>?
          ? missedClasses
          : this.missedClasses?.map((e0) => e0.copyWith()).toList(),
      schooldayEvents: schooldayEvents is List<_i7.SchooldayEvent>?
          ? schooldayEvents
          : this.schooldayEvents?.map((e0) => e0.copyWith()).toList(),
      workbooks: workbooks is List<_i8.Workbook>?
          ? workbooks
          : this.workbooks?.map((e0) => e0.copyWith()).toList(),
      supportGoals: supportGoals is List<_i9.SupportGoal>?
          ? supportGoals
          : this.supportGoals?.map((e0) => e0.copyWith()).toList(),
      supportCategoryStatuses: supportCategoryStatuses
              is List<_i10.SupportCategoryStatus>?
          ? supportCategoryStatuses
          : this.supportCategoryStatuses?.map((e0) => e0.copyWith()).toList(),
      pupilWorkbooks: pupilWorkbooks is List<_i11.PupilWorkbook>?
          ? pupilWorkbooks
          : this.pupilWorkbooks?.map((e0) => e0.copyWith()).toList(),
      pupilBookLendings: pupilBookLendings is List<_i12.PupilBookLending>?
          ? pupilBookLendings
          : this.pupilBookLendings?.map((e0) => e0.copyWith()).toList(),
      competenceGoals: competenceGoals is List<_i13.CompetenceGoal>?
          ? competenceGoals
          : this.competenceGoals?.map((e0) => e0.copyWith()).toList(),
      competenceChecks: competenceChecks is List<_i14.CompetenceCheck>?
          ? competenceChecks
          : this.competenceChecks?.map((e0) => e0.copyWith()).toList(),
      competenceReports: competenceReports is List<_i15.CompetenceReport>?
          ? competenceReports
          : this.competenceReports?.map((e0) => e0.copyWith()).toList(),
      competenceReportChecks: competenceReportChecks
              is List<_i16.CompetenceReportCheck>?
          ? competenceReportChecks
          : this.competenceReportChecks?.map((e0) => e0.copyWith()).toList(),
      pupilLists: pupilLists is List<_i17.PupilList>?
          ? pupilLists
          : this.pupilLists?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

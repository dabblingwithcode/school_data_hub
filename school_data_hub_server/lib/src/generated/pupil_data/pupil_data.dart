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
abstract class PupilData
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
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

  static final t = PupilDataTable();

  static const db = PupilDataRepository._();

  @override
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

  @override
  _i1.Table<int> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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
        'pupilDataParentInfo': pupilDataParentInfo?.toJsonForProtocol(),
      'preSchoolRevision': preSchoolRevision.toJson(),
      if (authorizations != null)
        'authorizations':
            authorizations?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (missedClasses != null)
        'missedClasses':
            missedClasses?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (schooldayEvents != null)
        'schooldayEvents':
            schooldayEvents?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (workbooks != null)
        'workbooks':
            workbooks?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (supportGoals != null)
        'supportGoals':
            supportGoals?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (supportCategoryStatuses != null)
        'supportCategoryStatuses': supportCategoryStatuses?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (pupilWorkbooks != null)
        'pupilWorkbooks':
            pupilWorkbooks?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (pupilBookLendings != null)
        'pupilBookLendings': pupilBookLendings?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (competenceGoals != null)
        'competenceGoals':
            competenceGoals?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (competenceChecks != null)
        'competenceChecks':
            competenceChecks?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (competenceReports != null)
        'competenceReports': competenceReports?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (competenceReportChecks != null)
        'competenceReportChecks': competenceReportChecks?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (pupilLists != null)
        'pupilLists':
            pupilLists?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static PupilDataInclude include({
    _i5.PupilAuthorizationIncludeList? authorizations,
    _i6.MissedClassIncludeList? missedClasses,
    _i7.SchooldayEventIncludeList? schooldayEvents,
    _i8.WorkbookIncludeList? workbooks,
    _i9.SupportGoalIncludeList? supportGoals,
    _i10.SupportCategoryStatusIncludeList? supportCategoryStatuses,
    _i11.PupilWorkbookIncludeList? pupilWorkbooks,
    _i12.PupilBookLendingIncludeList? pupilBookLendings,
    _i13.CompetenceGoalIncludeList? competenceGoals,
    _i14.CompetenceCheckIncludeList? competenceChecks,
    _i15.CompetenceReportIncludeList? competenceReports,
    _i16.CompetenceReportCheckIncludeList? competenceReportChecks,
    _i17.PupilListIncludeList? pupilLists,
  }) {
    return PupilDataInclude._(
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
  }

  static PupilDataIncludeList includeList({
    _i1.WhereExpressionBuilder<PupilDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PupilDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilDataTable>? orderByList,
    PupilDataInclude? include,
  }) {
    return PupilDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PupilData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PupilData.t),
      include: include,
    );
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

class PupilDataTable extends _i1.Table<int> {
  PupilDataTable({super.tableRelation}) : super(tableName: 'pupil_data') {
    internalId = _i1.ColumnInt(
      'internalId',
      this,
    );
    contact = _i1.ColumnString(
      'contact',
      this,
    );
    credit = _i1.ColumnInt(
      'credit',
      this,
    );
    creditEarned = _i1.ColumnInt(
      'creditEarned',
      this,
    );
    ogs = _i1.ColumnBool(
      'ogs',
      this,
    );
    pickUpTime = _i1.ColumnString(
      'pickUpTime',
      this,
    );
    ogsInfo = _i1.ColumnString(
      'ogsInfo',
      this,
    );
    latestSupportLevel = _i1.ColumnEnum(
      'latestSupportLevel',
      this,
      _i1.EnumSerialization.byName,
    );
    repeater = _i1.ColumnDateTime(
      'repeater',
      this,
    );
    swimmer = _i1.ColumnString(
      'swimmer',
      this,
    );
    communicationPupil = _i1.ColumnString(
      'communicationPupil',
      this,
    );
    pupilDataParentInfo = _i1.ColumnSerializable(
      'pupilDataParentInfo',
      this,
    );
    preSchoolRevision = _i1.ColumnEnum(
      'preSchoolRevision',
      this,
      _i1.EnumSerialization.byName,
    );
  }

  late final _i1.ColumnInt internalId;

  late final _i1.ColumnString contact;

  late final _i1.ColumnInt credit;

  late final _i1.ColumnInt creditEarned;

  late final _i1.ColumnBool ogs;

  late final _i1.ColumnString pickUpTime;

  late final _i1.ColumnString ogsInfo;

  late final _i1.ColumnEnum<_i2.SupportLevel> latestSupportLevel;

  late final _i1.ColumnDateTime repeater;

  late final _i1.ColumnString swimmer;

  late final _i1.ColumnString communicationPupil;

  late final _i1.ColumnSerializable pupilDataParentInfo;

  late final _i1.ColumnEnum<_i4.PreSchoolRevision> preSchoolRevision;

  _i5.PupilAuthorizationTable? ___authorizations;

  _i1.ManyRelation<_i5.PupilAuthorizationTable>? _authorizations;

  _i6.MissedClassTable? ___missedClasses;

  _i1.ManyRelation<_i6.MissedClassTable>? _missedClasses;

  _i7.SchooldayEventTable? ___schooldayEvents;

  _i1.ManyRelation<_i7.SchooldayEventTable>? _schooldayEvents;

  _i8.WorkbookTable? ___workbooks;

  _i1.ManyRelation<_i8.WorkbookTable>? _workbooks;

  _i9.SupportGoalTable? ___supportGoals;

  _i1.ManyRelation<_i9.SupportGoalTable>? _supportGoals;

  _i10.SupportCategoryStatusTable? ___supportCategoryStatuses;

  _i1.ManyRelation<_i10.SupportCategoryStatusTable>? _supportCategoryStatuses;

  _i11.PupilWorkbookTable? ___pupilWorkbooks;

  _i1.ManyRelation<_i11.PupilWorkbookTable>? _pupilWorkbooks;

  _i12.PupilBookLendingTable? ___pupilBookLendings;

  _i1.ManyRelation<_i12.PupilBookLendingTable>? _pupilBookLendings;

  _i13.CompetenceGoalTable? ___competenceGoals;

  _i1.ManyRelation<_i13.CompetenceGoalTable>? _competenceGoals;

  _i14.CompetenceCheckTable? ___competenceChecks;

  _i1.ManyRelation<_i14.CompetenceCheckTable>? _competenceChecks;

  _i15.CompetenceReportTable? ___competenceReports;

  _i1.ManyRelation<_i15.CompetenceReportTable>? _competenceReports;

  _i16.CompetenceReportCheckTable? ___competenceReportChecks;

  _i1.ManyRelation<_i16.CompetenceReportCheckTable>? _competenceReportChecks;

  _i17.PupilListTable? ___pupilLists;

  _i1.ManyRelation<_i17.PupilListTable>? _pupilLists;

  _i5.PupilAuthorizationTable get __authorizations {
    if (___authorizations != null) return ___authorizations!;
    ___authorizations = _i1.createRelationTable(
      relationFieldName: '__authorizations',
      field: PupilData.t.id,
      foreignField: _i5.PupilAuthorization.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.PupilAuthorizationTable(tableRelation: foreignTableRelation),
    );
    return ___authorizations!;
  }

  _i6.MissedClassTable get __missedClasses {
    if (___missedClasses != null) return ___missedClasses!;
    ___missedClasses = _i1.createRelationTable(
      relationFieldName: '__missedClasses',
      field: PupilData.t.id,
      foreignField: _i6.MissedClass.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i6.MissedClassTable(tableRelation: foreignTableRelation),
    );
    return ___missedClasses!;
  }

  _i7.SchooldayEventTable get __schooldayEvents {
    if (___schooldayEvents != null) return ___schooldayEvents!;
    ___schooldayEvents = _i1.createRelationTable(
      relationFieldName: '__schooldayEvents',
      field: PupilData.t.id,
      foreignField: _i7.SchooldayEvent.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i7.SchooldayEventTable(tableRelation: foreignTableRelation),
    );
    return ___schooldayEvents!;
  }

  _i8.WorkbookTable get __workbooks {
    if (___workbooks != null) return ___workbooks!;
    ___workbooks = _i1.createRelationTable(
      relationFieldName: '__workbooks',
      field: PupilData.t.id,
      foreignField: _i8.Workbook.t.$_pupilDataWorkbooksPupilDataId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i8.WorkbookTable(tableRelation: foreignTableRelation),
    );
    return ___workbooks!;
  }

  _i9.SupportGoalTable get __supportGoals {
    if (___supportGoals != null) return ___supportGoals!;
    ___supportGoals = _i1.createRelationTable(
      relationFieldName: '__supportGoals',
      field: PupilData.t.id,
      foreignField: _i9.SupportGoal.t.$_pupilDataSupportgoalsPupilDataId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i9.SupportGoalTable(tableRelation: foreignTableRelation),
    );
    return ___supportGoals!;
  }

  _i10.SupportCategoryStatusTable get __supportCategoryStatuses {
    if (___supportCategoryStatuses != null) return ___supportCategoryStatuses!;
    ___supportCategoryStatuses = _i1.createRelationTable(
      relationFieldName: '__supportCategoryStatuses',
      field: PupilData.t.id,
      foreignField: _i10.SupportCategoryStatus.t
          .$_pupilDataSupportcategorystatusesPupilDataId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i10.SupportCategoryStatusTable(tableRelation: foreignTableRelation),
    );
    return ___supportCategoryStatuses!;
  }

  _i11.PupilWorkbookTable get __pupilWorkbooks {
    if (___pupilWorkbooks != null) return ___pupilWorkbooks!;
    ___pupilWorkbooks = _i1.createRelationTable(
      relationFieldName: '__pupilWorkbooks',
      field: PupilData.t.id,
      foreignField: _i11.PupilWorkbook.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i11.PupilWorkbookTable(tableRelation: foreignTableRelation),
    );
    return ___pupilWorkbooks!;
  }

  _i12.PupilBookLendingTable get __pupilBookLendings {
    if (___pupilBookLendings != null) return ___pupilBookLendings!;
    ___pupilBookLendings = _i1.createRelationTable(
      relationFieldName: '__pupilBookLendings',
      field: PupilData.t.id,
      foreignField: _i12.PupilBookLending.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i12.PupilBookLendingTable(tableRelation: foreignTableRelation),
    );
    return ___pupilBookLendings!;
  }

  _i13.CompetenceGoalTable get __competenceGoals {
    if (___competenceGoals != null) return ___competenceGoals!;
    ___competenceGoals = _i1.createRelationTable(
      relationFieldName: '__competenceGoals',
      field: PupilData.t.id,
      foreignField: _i13.CompetenceGoal.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i13.CompetenceGoalTable(tableRelation: foreignTableRelation),
    );
    return ___competenceGoals!;
  }

  _i14.CompetenceCheckTable get __competenceChecks {
    if (___competenceChecks != null) return ___competenceChecks!;
    ___competenceChecks = _i1.createRelationTable(
      relationFieldName: '__competenceChecks',
      field: PupilData.t.id,
      foreignField: _i14.CompetenceCheck.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i14.CompetenceCheckTable(tableRelation: foreignTableRelation),
    );
    return ___competenceChecks!;
  }

  _i15.CompetenceReportTable get __competenceReports {
    if (___competenceReports != null) return ___competenceReports!;
    ___competenceReports = _i1.createRelationTable(
      relationFieldName: '__competenceReports',
      field: PupilData.t.id,
      foreignField: _i15.CompetenceReport.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i15.CompetenceReportTable(tableRelation: foreignTableRelation),
    );
    return ___competenceReports!;
  }

  _i16.CompetenceReportCheckTable get __competenceReportChecks {
    if (___competenceReportChecks != null) return ___competenceReportChecks!;
    ___competenceReportChecks = _i1.createRelationTable(
      relationFieldName: '__competenceReportChecks',
      field: PupilData.t.id,
      foreignField: _i16.CompetenceReportCheck.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i16.CompetenceReportCheckTable(tableRelation: foreignTableRelation),
    );
    return ___competenceReportChecks!;
  }

  _i17.PupilListTable get __pupilLists {
    if (___pupilLists != null) return ___pupilLists!;
    ___pupilLists = _i1.createRelationTable(
      relationFieldName: '__pupilLists',
      field: PupilData.t.id,
      foreignField: _i17.PupilList.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i17.PupilListTable(tableRelation: foreignTableRelation),
    );
    return ___pupilLists!;
  }

  _i1.ManyRelation<_i5.PupilAuthorizationTable> get authorizations {
    if (_authorizations != null) return _authorizations!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'authorizations',
      field: PupilData.t.id,
      foreignField: _i5.PupilAuthorization.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.PupilAuthorizationTable(tableRelation: foreignTableRelation),
    );
    _authorizations = _i1.ManyRelation<_i5.PupilAuthorizationTable>(
      tableWithRelations: relationTable,
      table: _i5.PupilAuthorizationTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _authorizations!;
  }

  _i1.ManyRelation<_i6.MissedClassTable> get missedClasses {
    if (_missedClasses != null) return _missedClasses!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'missedClasses',
      field: PupilData.t.id,
      foreignField: _i6.MissedClass.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i6.MissedClassTable(tableRelation: foreignTableRelation),
    );
    _missedClasses = _i1.ManyRelation<_i6.MissedClassTable>(
      tableWithRelations: relationTable,
      table: _i6.MissedClassTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _missedClasses!;
  }

  _i1.ManyRelation<_i7.SchooldayEventTable> get schooldayEvents {
    if (_schooldayEvents != null) return _schooldayEvents!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'schooldayEvents',
      field: PupilData.t.id,
      foreignField: _i7.SchooldayEvent.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i7.SchooldayEventTable(tableRelation: foreignTableRelation),
    );
    _schooldayEvents = _i1.ManyRelation<_i7.SchooldayEventTable>(
      tableWithRelations: relationTable,
      table: _i7.SchooldayEventTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _schooldayEvents!;
  }

  _i1.ManyRelation<_i8.WorkbookTable> get workbooks {
    if (_workbooks != null) return _workbooks!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'workbooks',
      field: PupilData.t.id,
      foreignField: _i8.Workbook.t.$_pupilDataWorkbooksPupilDataId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i8.WorkbookTable(tableRelation: foreignTableRelation),
    );
    _workbooks = _i1.ManyRelation<_i8.WorkbookTable>(
      tableWithRelations: relationTable,
      table: _i8.WorkbookTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _workbooks!;
  }

  _i1.ManyRelation<_i9.SupportGoalTable> get supportGoals {
    if (_supportGoals != null) return _supportGoals!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'supportGoals',
      field: PupilData.t.id,
      foreignField: _i9.SupportGoal.t.$_pupilDataSupportgoalsPupilDataId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i9.SupportGoalTable(tableRelation: foreignTableRelation),
    );
    _supportGoals = _i1.ManyRelation<_i9.SupportGoalTable>(
      tableWithRelations: relationTable,
      table: _i9.SupportGoalTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _supportGoals!;
  }

  _i1.ManyRelation<_i10.SupportCategoryStatusTable>
      get supportCategoryStatuses {
    if (_supportCategoryStatuses != null) return _supportCategoryStatuses!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'supportCategoryStatuses',
      field: PupilData.t.id,
      foreignField: _i10.SupportCategoryStatus.t
          .$_pupilDataSupportcategorystatusesPupilDataId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i10.SupportCategoryStatusTable(tableRelation: foreignTableRelation),
    );
    _supportCategoryStatuses =
        _i1.ManyRelation<_i10.SupportCategoryStatusTable>(
      tableWithRelations: relationTable,
      table: _i10.SupportCategoryStatusTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _supportCategoryStatuses!;
  }

  _i1.ManyRelation<_i11.PupilWorkbookTable> get pupilWorkbooks {
    if (_pupilWorkbooks != null) return _pupilWorkbooks!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'pupilWorkbooks',
      field: PupilData.t.id,
      foreignField: _i11.PupilWorkbook.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i11.PupilWorkbookTable(tableRelation: foreignTableRelation),
    );
    _pupilWorkbooks = _i1.ManyRelation<_i11.PupilWorkbookTable>(
      tableWithRelations: relationTable,
      table: _i11.PupilWorkbookTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _pupilWorkbooks!;
  }

  _i1.ManyRelation<_i12.PupilBookLendingTable> get pupilBookLendings {
    if (_pupilBookLendings != null) return _pupilBookLendings!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'pupilBookLendings',
      field: PupilData.t.id,
      foreignField: _i12.PupilBookLending.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i12.PupilBookLendingTable(tableRelation: foreignTableRelation),
    );
    _pupilBookLendings = _i1.ManyRelation<_i12.PupilBookLendingTable>(
      tableWithRelations: relationTable,
      table: _i12.PupilBookLendingTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _pupilBookLendings!;
  }

  _i1.ManyRelation<_i13.CompetenceGoalTable> get competenceGoals {
    if (_competenceGoals != null) return _competenceGoals!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'competenceGoals',
      field: PupilData.t.id,
      foreignField: _i13.CompetenceGoal.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i13.CompetenceGoalTable(tableRelation: foreignTableRelation),
    );
    _competenceGoals = _i1.ManyRelation<_i13.CompetenceGoalTable>(
      tableWithRelations: relationTable,
      table: _i13.CompetenceGoalTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _competenceGoals!;
  }

  _i1.ManyRelation<_i14.CompetenceCheckTable> get competenceChecks {
    if (_competenceChecks != null) return _competenceChecks!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'competenceChecks',
      field: PupilData.t.id,
      foreignField: _i14.CompetenceCheck.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i14.CompetenceCheckTable(tableRelation: foreignTableRelation),
    );
    _competenceChecks = _i1.ManyRelation<_i14.CompetenceCheckTable>(
      tableWithRelations: relationTable,
      table: _i14.CompetenceCheckTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _competenceChecks!;
  }

  _i1.ManyRelation<_i15.CompetenceReportTable> get competenceReports {
    if (_competenceReports != null) return _competenceReports!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'competenceReports',
      field: PupilData.t.id,
      foreignField: _i15.CompetenceReport.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i15.CompetenceReportTable(tableRelation: foreignTableRelation),
    );
    _competenceReports = _i1.ManyRelation<_i15.CompetenceReportTable>(
      tableWithRelations: relationTable,
      table: _i15.CompetenceReportTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _competenceReports!;
  }

  _i1.ManyRelation<_i16.CompetenceReportCheckTable> get competenceReportChecks {
    if (_competenceReportChecks != null) return _competenceReportChecks!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'competenceReportChecks',
      field: PupilData.t.id,
      foreignField: _i16.CompetenceReportCheck.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i16.CompetenceReportCheckTable(tableRelation: foreignTableRelation),
    );
    _competenceReportChecks = _i1.ManyRelation<_i16.CompetenceReportCheckTable>(
      tableWithRelations: relationTable,
      table: _i16.CompetenceReportCheckTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _competenceReportChecks!;
  }

  _i1.ManyRelation<_i17.PupilListTable> get pupilLists {
    if (_pupilLists != null) return _pupilLists!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'pupilLists',
      field: PupilData.t.id,
      foreignField: _i17.PupilList.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i17.PupilListTable(tableRelation: foreignTableRelation),
    );
    _pupilLists = _i1.ManyRelation<_i17.PupilListTable>(
      tableWithRelations: relationTable,
      table: _i17.PupilListTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _pupilLists!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        internalId,
        contact,
        credit,
        creditEarned,
        ogs,
        pickUpTime,
        ogsInfo,
        latestSupportLevel,
        repeater,
        swimmer,
        communicationPupil,
        pupilDataParentInfo,
        preSchoolRevision,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'authorizations') {
      return __authorizations;
    }
    if (relationField == 'missedClasses') {
      return __missedClasses;
    }
    if (relationField == 'schooldayEvents') {
      return __schooldayEvents;
    }
    if (relationField == 'workbooks') {
      return __workbooks;
    }
    if (relationField == 'supportGoals') {
      return __supportGoals;
    }
    if (relationField == 'supportCategoryStatuses') {
      return __supportCategoryStatuses;
    }
    if (relationField == 'pupilWorkbooks') {
      return __pupilWorkbooks;
    }
    if (relationField == 'pupilBookLendings') {
      return __pupilBookLendings;
    }
    if (relationField == 'competenceGoals') {
      return __competenceGoals;
    }
    if (relationField == 'competenceChecks') {
      return __competenceChecks;
    }
    if (relationField == 'competenceReports') {
      return __competenceReports;
    }
    if (relationField == 'competenceReportChecks') {
      return __competenceReportChecks;
    }
    if (relationField == 'pupilLists') {
      return __pupilLists;
    }
    return null;
  }
}

class PupilDataInclude extends _i1.IncludeObject {
  PupilDataInclude._({
    _i5.PupilAuthorizationIncludeList? authorizations,
    _i6.MissedClassIncludeList? missedClasses,
    _i7.SchooldayEventIncludeList? schooldayEvents,
    _i8.WorkbookIncludeList? workbooks,
    _i9.SupportGoalIncludeList? supportGoals,
    _i10.SupportCategoryStatusIncludeList? supportCategoryStatuses,
    _i11.PupilWorkbookIncludeList? pupilWorkbooks,
    _i12.PupilBookLendingIncludeList? pupilBookLendings,
    _i13.CompetenceGoalIncludeList? competenceGoals,
    _i14.CompetenceCheckIncludeList? competenceChecks,
    _i15.CompetenceReportIncludeList? competenceReports,
    _i16.CompetenceReportCheckIncludeList? competenceReportChecks,
    _i17.PupilListIncludeList? pupilLists,
  }) {
    _authorizations = authorizations;
    _missedClasses = missedClasses;
    _schooldayEvents = schooldayEvents;
    _workbooks = workbooks;
    _supportGoals = supportGoals;
    _supportCategoryStatuses = supportCategoryStatuses;
    _pupilWorkbooks = pupilWorkbooks;
    _pupilBookLendings = pupilBookLendings;
    _competenceGoals = competenceGoals;
    _competenceChecks = competenceChecks;
    _competenceReports = competenceReports;
    _competenceReportChecks = competenceReportChecks;
    _pupilLists = pupilLists;
  }

  _i5.PupilAuthorizationIncludeList? _authorizations;

  _i6.MissedClassIncludeList? _missedClasses;

  _i7.SchooldayEventIncludeList? _schooldayEvents;

  _i8.WorkbookIncludeList? _workbooks;

  _i9.SupportGoalIncludeList? _supportGoals;

  _i10.SupportCategoryStatusIncludeList? _supportCategoryStatuses;

  _i11.PupilWorkbookIncludeList? _pupilWorkbooks;

  _i12.PupilBookLendingIncludeList? _pupilBookLendings;

  _i13.CompetenceGoalIncludeList? _competenceGoals;

  _i14.CompetenceCheckIncludeList? _competenceChecks;

  _i15.CompetenceReportIncludeList? _competenceReports;

  _i16.CompetenceReportCheckIncludeList? _competenceReportChecks;

  _i17.PupilListIncludeList? _pupilLists;

  @override
  Map<String, _i1.Include?> get includes => {
        'authorizations': _authorizations,
        'missedClasses': _missedClasses,
        'schooldayEvents': _schooldayEvents,
        'workbooks': _workbooks,
        'supportGoals': _supportGoals,
        'supportCategoryStatuses': _supportCategoryStatuses,
        'pupilWorkbooks': _pupilWorkbooks,
        'pupilBookLendings': _pupilBookLendings,
        'competenceGoals': _competenceGoals,
        'competenceChecks': _competenceChecks,
        'competenceReports': _competenceReports,
        'competenceReportChecks': _competenceReportChecks,
        'pupilLists': _pupilLists,
      };

  @override
  _i1.Table<int> get table => PupilData.t;
}

class PupilDataIncludeList extends _i1.IncludeList {
  PupilDataIncludeList._({
    _i1.WhereExpressionBuilder<PupilDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PupilData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => PupilData.t;
}

class PupilDataRepository {
  const PupilDataRepository._();

  final attach = const PupilDataAttachRepository._();

  final attachRow = const PupilDataAttachRowRepository._();

  final detach = const PupilDataDetachRepository._();

  final detachRow = const PupilDataDetachRowRepository._();

  /// Returns a list of [PupilData]s matching the given query parameters.
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
  Future<List<PupilData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PupilDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilDataTable>? orderByList,
    _i1.Transaction? transaction,
    PupilDataInclude? include,
  }) async {
    return session.db.find<PupilData>(
      where: where?.call(PupilData.t),
      orderBy: orderBy?.call(PupilData.t),
      orderByList: orderByList?.call(PupilData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [PupilData] matching the given query parameters.
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
  Future<PupilData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<PupilDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilDataTable>? orderByList,
    _i1.Transaction? transaction,
    PupilDataInclude? include,
  }) async {
    return session.db.findFirstRow<PupilData>(
      where: where?.call(PupilData.t),
      orderBy: orderBy?.call(PupilData.t),
      orderByList: orderByList?.call(PupilData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [PupilData] by its [id] or null if no such row exists.
  Future<PupilData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    PupilDataInclude? include,
  }) async {
    return session.db.findById<PupilData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [PupilData]s in the list and returns the inserted rows.
  ///
  /// The returned [PupilData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PupilData>> insert(
    _i1.Session session,
    List<PupilData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PupilData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PupilData] and returns the inserted row.
  ///
  /// The returned [PupilData] will have its `id` field set.
  Future<PupilData> insertRow(
    _i1.Session session,
    PupilData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PupilData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PupilData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PupilData>> update(
    _i1.Session session,
    List<PupilData> rows, {
    _i1.ColumnSelections<PupilDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PupilData>(
      rows,
      columns: columns?.call(PupilData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PupilData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PupilData> updateRow(
    _i1.Session session,
    PupilData row, {
    _i1.ColumnSelections<PupilDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PupilData>(
      row,
      columns: columns?.call(PupilData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [PupilData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PupilData>> delete(
    _i1.Session session,
    List<PupilData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PupilData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PupilData].
  Future<PupilData> deleteRow(
    _i1.Session session,
    PupilData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PupilData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PupilData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PupilDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PupilData>(
      where: where(PupilData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PupilData>(
      where: where?.call(PupilData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class PupilDataAttachRepository {
  const PupilDataAttachRepository._();

  /// Creates a relation between this [PupilData] and the given [PupilAuthorization]s
  /// by setting each [PupilAuthorization]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> authorizations(
    _i1.Session session,
    PupilData pupilData,
    List<_i5.PupilAuthorization> pupilAuthorization, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilAuthorization.any((e) => e.id == null)) {
      throw ArgumentError.notNull('pupilAuthorization.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $pupilAuthorization = pupilAuthorization
        .map((e) => e.copyWith(pupilId: pupilData.id))
        .toList();
    await session.db.update<_i5.PupilAuthorization>(
      $pupilAuthorization,
      columns: [_i5.PupilAuthorization.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [MissedClass]s
  /// by setting each [MissedClass]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> missedClasses(
    _i1.Session session,
    PupilData pupilData,
    List<_i6.MissedClass> missedClass, {
    _i1.Transaction? transaction,
  }) async {
    if (missedClass.any((e) => e.id == null)) {
      throw ArgumentError.notNull('missedClass.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $missedClass =
        missedClass.map((e) => e.copyWith(pupilId: pupilData.id)).toList();
    await session.db.update<_i6.MissedClass>(
      $missedClass,
      columns: [_i6.MissedClass.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [SchooldayEvent]s
  /// by setting each [SchooldayEvent]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> schooldayEvents(
    _i1.Session session,
    PupilData pupilData,
    List<_i7.SchooldayEvent> schooldayEvent, {
    _i1.Transaction? transaction,
  }) async {
    if (schooldayEvent.any((e) => e.id == null)) {
      throw ArgumentError.notNull('schooldayEvent.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $schooldayEvent =
        schooldayEvent.map((e) => e.copyWith(pupilId: pupilData.id)).toList();
    await session.db.update<_i7.SchooldayEvent>(
      $schooldayEvent,
      columns: [_i7.SchooldayEvent.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [Workbook]s
  /// by setting each [Workbook]'s foreign key `_pupilDataWorkbooksPupilDataId` to refer to this [PupilData].
  Future<void> workbooks(
    _i1.Session session,
    PupilData pupilData,
    List<_i8.Workbook> workbook, {
    _i1.Transaction? transaction,
  }) async {
    if (workbook.any((e) => e.id == null)) {
      throw ArgumentError.notNull('workbook.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $workbook = workbook
        .map((e) => _i8.WorkbookImplicit(
              e,
              $_pupilDataWorkbooksPupilDataId: pupilData.id,
            ))
        .toList();
    await session.db.update<_i8.Workbook>(
      $workbook,
      columns: [_i8.Workbook.t.$_pupilDataWorkbooksPupilDataId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [SupportGoal]s
  /// by setting each [SupportGoal]'s foreign key `_pupilDataSupportgoalsPupilDataId` to refer to this [PupilData].
  Future<void> supportGoals(
    _i1.Session session,
    PupilData pupilData,
    List<_i9.SupportGoal> supportGoal, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoal.any((e) => e.id == null)) {
      throw ArgumentError.notNull('supportGoal.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $supportGoal = supportGoal
        .map((e) => _i9.SupportGoalImplicit(
              e,
              $_pupilDataSupportgoalsPupilDataId: pupilData.id,
            ))
        .toList();
    await session.db.update<_i9.SupportGoal>(
      $supportGoal,
      columns: [_i9.SupportGoal.t.$_pupilDataSupportgoalsPupilDataId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [SupportCategoryStatus]s
  /// by setting each [SupportCategoryStatus]'s foreign key `_pupilDataSupportcategorystatusesPupilDataId` to refer to this [PupilData].
  Future<void> supportCategoryStatuses(
    _i1.Session session,
    PupilData pupilData,
    List<_i10.SupportCategoryStatus> supportCategoryStatus, {
    _i1.Transaction? transaction,
  }) async {
    if (supportCategoryStatus.any((e) => e.id == null)) {
      throw ArgumentError.notNull('supportCategoryStatus.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $supportCategoryStatus = supportCategoryStatus
        .map((e) => _i10.SupportCategoryStatusImplicit(
              e,
              $_pupilDataSupportcategorystatusesPupilDataId: pupilData.id,
            ))
        .toList();
    await session.db.update<_i10.SupportCategoryStatus>(
      $supportCategoryStatus,
      columns: [
        _i10.SupportCategoryStatus.t
            .$_pupilDataSupportcategorystatusesPupilDataId
      ],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [PupilWorkbook]s
  /// by setting each [PupilWorkbook]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> pupilWorkbooks(
    _i1.Session session,
    PupilData pupilData,
    List<_i11.PupilWorkbook> pupilWorkbook, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilWorkbook.any((e) => e.id == null)) {
      throw ArgumentError.notNull('pupilWorkbook.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $pupilWorkbook =
        pupilWorkbook.map((e) => e.copyWith(pupilId: pupilData.id)).toList();
    await session.db.update<_i11.PupilWorkbook>(
      $pupilWorkbook,
      columns: [_i11.PupilWorkbook.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [PupilBookLending]s
  /// by setting each [PupilBookLending]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> pupilBookLendings(
    _i1.Session session,
    PupilData pupilData,
    List<_i12.PupilBookLending> pupilBookLending, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilBookLending.any((e) => e.id == null)) {
      throw ArgumentError.notNull('pupilBookLending.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $pupilBookLending =
        pupilBookLending.map((e) => e.copyWith(pupilId: pupilData.id)).toList();
    await session.db.update<_i12.PupilBookLending>(
      $pupilBookLending,
      columns: [_i12.PupilBookLending.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [CompetenceGoal]s
  /// by setting each [CompetenceGoal]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> competenceGoals(
    _i1.Session session,
    PupilData pupilData,
    List<_i13.CompetenceGoal> competenceGoal, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceGoal.any((e) => e.id == null)) {
      throw ArgumentError.notNull('competenceGoal.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $competenceGoal =
        competenceGoal.map((e) => e.copyWith(pupilId: pupilData.id)).toList();
    await session.db.update<_i13.CompetenceGoal>(
      $competenceGoal,
      columns: [_i13.CompetenceGoal.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [CompetenceCheck]s
  /// by setting each [CompetenceCheck]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> competenceChecks(
    _i1.Session session,
    PupilData pupilData,
    List<_i14.CompetenceCheck> competenceCheck, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceCheck.any((e) => e.id == null)) {
      throw ArgumentError.notNull('competenceCheck.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $competenceCheck =
        competenceCheck.map((e) => e.copyWith(pupilId: pupilData.id)).toList();
    await session.db.update<_i14.CompetenceCheck>(
      $competenceCheck,
      columns: [_i14.CompetenceCheck.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [CompetenceReport]s
  /// by setting each [CompetenceReport]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> competenceReports(
    _i1.Session session,
    PupilData pupilData,
    List<_i15.CompetenceReport> competenceReport, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceReport.any((e) => e.id == null)) {
      throw ArgumentError.notNull('competenceReport.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $competenceReport =
        competenceReport.map((e) => e.copyWith(pupilId: pupilData.id)).toList();
    await session.db.update<_i15.CompetenceReport>(
      $competenceReport,
      columns: [_i15.CompetenceReport.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [CompetenceReportCheck]s
  /// by setting each [CompetenceReportCheck]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> competenceReportChecks(
    _i1.Session session,
    PupilData pupilData,
    List<_i16.CompetenceReportCheck> competenceReportCheck, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceReportCheck.any((e) => e.id == null)) {
      throw ArgumentError.notNull('competenceReportCheck.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $competenceReportCheck = competenceReportCheck
        .map((e) => e.copyWith(pupilId: pupilData.id))
        .toList();
    await session.db.update<_i16.CompetenceReportCheck>(
      $competenceReportCheck,
      columns: [_i16.CompetenceReportCheck.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [PupilList]s
  /// by setting each [PupilList]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> pupilLists(
    _i1.Session session,
    PupilData pupilData,
    List<_i17.PupilList> pupilList, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilList.any((e) => e.id == null)) {
      throw ArgumentError.notNull('pupilList.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $pupilList =
        pupilList.map((e) => e.copyWith(pupilId: pupilData.id)).toList();
    await session.db.update<_i17.PupilList>(
      $pupilList,
      columns: [_i17.PupilList.t.pupilId],
      transaction: transaction,
    );
  }
}

class PupilDataAttachRowRepository {
  const PupilDataAttachRowRepository._();

  /// Creates a relation between this [PupilData] and the given [PupilAuthorization]
  /// by setting the [PupilAuthorization]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> authorizations(
    _i1.Session session,
    PupilData pupilData,
    _i5.PupilAuthorization pupilAuthorization, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilAuthorization.id == null) {
      throw ArgumentError.notNull('pupilAuthorization.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $pupilAuthorization =
        pupilAuthorization.copyWith(pupilId: pupilData.id);
    await session.db.updateRow<_i5.PupilAuthorization>(
      $pupilAuthorization,
      columns: [_i5.PupilAuthorization.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [MissedClass]
  /// by setting the [MissedClass]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> missedClasses(
    _i1.Session session,
    PupilData pupilData,
    _i6.MissedClass missedClass, {
    _i1.Transaction? transaction,
  }) async {
    if (missedClass.id == null) {
      throw ArgumentError.notNull('missedClass.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $missedClass = missedClass.copyWith(pupilId: pupilData.id);
    await session.db.updateRow<_i6.MissedClass>(
      $missedClass,
      columns: [_i6.MissedClass.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [SchooldayEvent]
  /// by setting the [SchooldayEvent]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> schooldayEvents(
    _i1.Session session,
    PupilData pupilData,
    _i7.SchooldayEvent schooldayEvent, {
    _i1.Transaction? transaction,
  }) async {
    if (schooldayEvent.id == null) {
      throw ArgumentError.notNull('schooldayEvent.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $schooldayEvent = schooldayEvent.copyWith(pupilId: pupilData.id);
    await session.db.updateRow<_i7.SchooldayEvent>(
      $schooldayEvent,
      columns: [_i7.SchooldayEvent.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [Workbook]
  /// by setting the [Workbook]'s foreign key `_pupilDataWorkbooksPupilDataId` to refer to this [PupilData].
  Future<void> workbooks(
    _i1.Session session,
    PupilData pupilData,
    _i8.Workbook workbook, {
    _i1.Transaction? transaction,
  }) async {
    if (workbook.id == null) {
      throw ArgumentError.notNull('workbook.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $workbook = _i8.WorkbookImplicit(
      workbook,
      $_pupilDataWorkbooksPupilDataId: pupilData.id,
    );
    await session.db.updateRow<_i8.Workbook>(
      $workbook,
      columns: [_i8.Workbook.t.$_pupilDataWorkbooksPupilDataId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [SupportGoal]
  /// by setting the [SupportGoal]'s foreign key `_pupilDataSupportgoalsPupilDataId` to refer to this [PupilData].
  Future<void> supportGoals(
    _i1.Session session,
    PupilData pupilData,
    _i9.SupportGoal supportGoal, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoal.id == null) {
      throw ArgumentError.notNull('supportGoal.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $supportGoal = _i9.SupportGoalImplicit(
      supportGoal,
      $_pupilDataSupportgoalsPupilDataId: pupilData.id,
    );
    await session.db.updateRow<_i9.SupportGoal>(
      $supportGoal,
      columns: [_i9.SupportGoal.t.$_pupilDataSupportgoalsPupilDataId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [SupportCategoryStatus]
  /// by setting the [SupportCategoryStatus]'s foreign key `_pupilDataSupportcategorystatusesPupilDataId` to refer to this [PupilData].
  Future<void> supportCategoryStatuses(
    _i1.Session session,
    PupilData pupilData,
    _i10.SupportCategoryStatus supportCategoryStatus, {
    _i1.Transaction? transaction,
  }) async {
    if (supportCategoryStatus.id == null) {
      throw ArgumentError.notNull('supportCategoryStatus.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $supportCategoryStatus = _i10.SupportCategoryStatusImplicit(
      supportCategoryStatus,
      $_pupilDataSupportcategorystatusesPupilDataId: pupilData.id,
    );
    await session.db.updateRow<_i10.SupportCategoryStatus>(
      $supportCategoryStatus,
      columns: [
        _i10.SupportCategoryStatus.t
            .$_pupilDataSupportcategorystatusesPupilDataId
      ],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [PupilWorkbook]
  /// by setting the [PupilWorkbook]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> pupilWorkbooks(
    _i1.Session session,
    PupilData pupilData,
    _i11.PupilWorkbook pupilWorkbook, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilWorkbook.id == null) {
      throw ArgumentError.notNull('pupilWorkbook.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $pupilWorkbook = pupilWorkbook.copyWith(pupilId: pupilData.id);
    await session.db.updateRow<_i11.PupilWorkbook>(
      $pupilWorkbook,
      columns: [_i11.PupilWorkbook.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [PupilBookLending]
  /// by setting the [PupilBookLending]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> pupilBookLendings(
    _i1.Session session,
    PupilData pupilData,
    _i12.PupilBookLending pupilBookLending, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilBookLending.id == null) {
      throw ArgumentError.notNull('pupilBookLending.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $pupilBookLending = pupilBookLending.copyWith(pupilId: pupilData.id);
    await session.db.updateRow<_i12.PupilBookLending>(
      $pupilBookLending,
      columns: [_i12.PupilBookLending.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [CompetenceGoal]
  /// by setting the [CompetenceGoal]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> competenceGoals(
    _i1.Session session,
    PupilData pupilData,
    _i13.CompetenceGoal competenceGoal, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceGoal.id == null) {
      throw ArgumentError.notNull('competenceGoal.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $competenceGoal = competenceGoal.copyWith(pupilId: pupilData.id);
    await session.db.updateRow<_i13.CompetenceGoal>(
      $competenceGoal,
      columns: [_i13.CompetenceGoal.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [CompetenceCheck]
  /// by setting the [CompetenceCheck]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> competenceChecks(
    _i1.Session session,
    PupilData pupilData,
    _i14.CompetenceCheck competenceCheck, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceCheck.id == null) {
      throw ArgumentError.notNull('competenceCheck.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $competenceCheck = competenceCheck.copyWith(pupilId: pupilData.id);
    await session.db.updateRow<_i14.CompetenceCheck>(
      $competenceCheck,
      columns: [_i14.CompetenceCheck.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [CompetenceReport]
  /// by setting the [CompetenceReport]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> competenceReports(
    _i1.Session session,
    PupilData pupilData,
    _i15.CompetenceReport competenceReport, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceReport.id == null) {
      throw ArgumentError.notNull('competenceReport.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $competenceReport = competenceReport.copyWith(pupilId: pupilData.id);
    await session.db.updateRow<_i15.CompetenceReport>(
      $competenceReport,
      columns: [_i15.CompetenceReport.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [CompetenceReportCheck]
  /// by setting the [CompetenceReportCheck]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> competenceReportChecks(
    _i1.Session session,
    PupilData pupilData,
    _i16.CompetenceReportCheck competenceReportCheck, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceReportCheck.id == null) {
      throw ArgumentError.notNull('competenceReportCheck.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $competenceReportCheck =
        competenceReportCheck.copyWith(pupilId: pupilData.id);
    await session.db.updateRow<_i16.CompetenceReportCheck>(
      $competenceReportCheck,
      columns: [_i16.CompetenceReportCheck.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [PupilList]
  /// by setting the [PupilList]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> pupilLists(
    _i1.Session session,
    PupilData pupilData,
    _i17.PupilList pupilList, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilList.id == null) {
      throw ArgumentError.notNull('pupilList.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $pupilList = pupilList.copyWith(pupilId: pupilData.id);
    await session.db.updateRow<_i17.PupilList>(
      $pupilList,
      columns: [_i17.PupilList.t.pupilId],
      transaction: transaction,
    );
  }
}

class PupilDataDetachRepository {
  const PupilDataDetachRepository._();

  /// Detaches the relation between this [PupilData] and the given [MissedClass]
  /// by setting the [MissedClass]'s foreign key `pupilId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> missedClasses(
    _i1.Session session,
    List<_i6.MissedClass> missedClass, {
    _i1.Transaction? transaction,
  }) async {
    if (missedClass.any((e) => e.id == null)) {
      throw ArgumentError.notNull('missedClass.id');
    }

    var $missedClass =
        missedClass.map((e) => e.copyWith(pupilId: null)).toList();
    await session.db.update<_i6.MissedClass>(
      $missedClass,
      columns: [_i6.MissedClass.t.pupilId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilData] and the given [SchooldayEvent]
  /// by setting the [SchooldayEvent]'s foreign key `pupilId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> schooldayEvents(
    _i1.Session session,
    List<_i7.SchooldayEvent> schooldayEvent, {
    _i1.Transaction? transaction,
  }) async {
    if (schooldayEvent.any((e) => e.id == null)) {
      throw ArgumentError.notNull('schooldayEvent.id');
    }

    var $schooldayEvent =
        schooldayEvent.map((e) => e.copyWith(pupilId: null)).toList();
    await session.db.update<_i7.SchooldayEvent>(
      $schooldayEvent,
      columns: [_i7.SchooldayEvent.t.pupilId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilData] and the given [Workbook]
  /// by setting the [Workbook]'s foreign key `_pupilDataWorkbooksPupilDataId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> workbooks(
    _i1.Session session,
    List<_i8.Workbook> workbook, {
    _i1.Transaction? transaction,
  }) async {
    if (workbook.any((e) => e.id == null)) {
      throw ArgumentError.notNull('workbook.id');
    }

    var $workbook = workbook
        .map((e) => _i8.WorkbookImplicit(
              e,
              $_pupilDataWorkbooksPupilDataId: null,
            ))
        .toList();
    await session.db.update<_i8.Workbook>(
      $workbook,
      columns: [_i8.Workbook.t.$_pupilDataWorkbooksPupilDataId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilData] and the given [SupportGoal]
  /// by setting the [SupportGoal]'s foreign key `_pupilDataSupportgoalsPupilDataId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> supportGoals(
    _i1.Session session,
    List<_i9.SupportGoal> supportGoal, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoal.any((e) => e.id == null)) {
      throw ArgumentError.notNull('supportGoal.id');
    }

    var $supportGoal = supportGoal
        .map((e) => _i9.SupportGoalImplicit(
              e,
              $_pupilDataSupportgoalsPupilDataId: null,
            ))
        .toList();
    await session.db.update<_i9.SupportGoal>(
      $supportGoal,
      columns: [_i9.SupportGoal.t.$_pupilDataSupportgoalsPupilDataId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilData] and the given [SupportCategoryStatus]
  /// by setting the [SupportCategoryStatus]'s foreign key `_pupilDataSupportcategorystatusesPupilDataId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> supportCategoryStatuses(
    _i1.Session session,
    List<_i10.SupportCategoryStatus> supportCategoryStatus, {
    _i1.Transaction? transaction,
  }) async {
    if (supportCategoryStatus.any((e) => e.id == null)) {
      throw ArgumentError.notNull('supportCategoryStatus.id');
    }

    var $supportCategoryStatus = supportCategoryStatus
        .map((e) => _i10.SupportCategoryStatusImplicit(
              e,
              $_pupilDataSupportcategorystatusesPupilDataId: null,
            ))
        .toList();
    await session.db.update<_i10.SupportCategoryStatus>(
      $supportCategoryStatus,
      columns: [
        _i10.SupportCategoryStatus.t
            .$_pupilDataSupportcategorystatusesPupilDataId
      ],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilData] and the given [PupilWorkbook]
  /// by setting the [PupilWorkbook]'s foreign key `pupilId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> pupilWorkbooks(
    _i1.Session session,
    List<_i11.PupilWorkbook> pupilWorkbook, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilWorkbook.any((e) => e.id == null)) {
      throw ArgumentError.notNull('pupilWorkbook.id');
    }

    var $pupilWorkbook =
        pupilWorkbook.map((e) => e.copyWith(pupilId: null)).toList();
    await session.db.update<_i11.PupilWorkbook>(
      $pupilWorkbook,
      columns: [_i11.PupilWorkbook.t.pupilId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilData] and the given [PupilList]
  /// by setting the [PupilList]'s foreign key `pupilId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> pupilLists(
    _i1.Session session,
    List<_i17.PupilList> pupilList, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilList.any((e) => e.id == null)) {
      throw ArgumentError.notNull('pupilList.id');
    }

    var $pupilList = pupilList.map((e) => e.copyWith(pupilId: null)).toList();
    await session.db.update<_i17.PupilList>(
      $pupilList,
      columns: [_i17.PupilList.t.pupilId],
      transaction: transaction,
    );
  }
}

class PupilDataDetachRowRepository {
  const PupilDataDetachRowRepository._();

  /// Detaches the relation between this [PupilData] and the given [MissedClass]
  /// by setting the [MissedClass]'s foreign key `pupilId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> missedClasses(
    _i1.Session session,
    _i6.MissedClass missedClass, {
    _i1.Transaction? transaction,
  }) async {
    if (missedClass.id == null) {
      throw ArgumentError.notNull('missedClass.id');
    }

    var $missedClass = missedClass.copyWith(pupilId: null);
    await session.db.updateRow<_i6.MissedClass>(
      $missedClass,
      columns: [_i6.MissedClass.t.pupilId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilData] and the given [SchooldayEvent]
  /// by setting the [SchooldayEvent]'s foreign key `pupilId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> schooldayEvents(
    _i1.Session session,
    _i7.SchooldayEvent schooldayEvent, {
    _i1.Transaction? transaction,
  }) async {
    if (schooldayEvent.id == null) {
      throw ArgumentError.notNull('schooldayEvent.id');
    }

    var $schooldayEvent = schooldayEvent.copyWith(pupilId: null);
    await session.db.updateRow<_i7.SchooldayEvent>(
      $schooldayEvent,
      columns: [_i7.SchooldayEvent.t.pupilId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilData] and the given [Workbook]
  /// by setting the [Workbook]'s foreign key `_pupilDataWorkbooksPupilDataId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> workbooks(
    _i1.Session session,
    _i8.Workbook workbook, {
    _i1.Transaction? transaction,
  }) async {
    if (workbook.id == null) {
      throw ArgumentError.notNull('workbook.id');
    }

    var $workbook = _i8.WorkbookImplicit(
      workbook,
      $_pupilDataWorkbooksPupilDataId: null,
    );
    await session.db.updateRow<_i8.Workbook>(
      $workbook,
      columns: [_i8.Workbook.t.$_pupilDataWorkbooksPupilDataId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilData] and the given [SupportGoal]
  /// by setting the [SupportGoal]'s foreign key `_pupilDataSupportgoalsPupilDataId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> supportGoals(
    _i1.Session session,
    _i9.SupportGoal supportGoal, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoal.id == null) {
      throw ArgumentError.notNull('supportGoal.id');
    }

    var $supportGoal = _i9.SupportGoalImplicit(
      supportGoal,
      $_pupilDataSupportgoalsPupilDataId: null,
    );
    await session.db.updateRow<_i9.SupportGoal>(
      $supportGoal,
      columns: [_i9.SupportGoal.t.$_pupilDataSupportgoalsPupilDataId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilData] and the given [SupportCategoryStatus]
  /// by setting the [SupportCategoryStatus]'s foreign key `_pupilDataSupportcategorystatusesPupilDataId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> supportCategoryStatuses(
    _i1.Session session,
    _i10.SupportCategoryStatus supportCategoryStatus, {
    _i1.Transaction? transaction,
  }) async {
    if (supportCategoryStatus.id == null) {
      throw ArgumentError.notNull('supportCategoryStatus.id');
    }

    var $supportCategoryStatus = _i10.SupportCategoryStatusImplicit(
      supportCategoryStatus,
      $_pupilDataSupportcategorystatusesPupilDataId: null,
    );
    await session.db.updateRow<_i10.SupportCategoryStatus>(
      $supportCategoryStatus,
      columns: [
        _i10.SupportCategoryStatus.t
            .$_pupilDataSupportcategorystatusesPupilDataId
      ],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilData] and the given [PupilWorkbook]
  /// by setting the [PupilWorkbook]'s foreign key `pupilId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> pupilWorkbooks(
    _i1.Session session,
    _i11.PupilWorkbook pupilWorkbook, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilWorkbook.id == null) {
      throw ArgumentError.notNull('pupilWorkbook.id');
    }

    var $pupilWorkbook = pupilWorkbook.copyWith(pupilId: null);
    await session.db.updateRow<_i11.PupilWorkbook>(
      $pupilWorkbook,
      columns: [_i11.PupilWorkbook.t.pupilId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilData] and the given [PupilList]
  /// by setting the [PupilList]'s foreign key `pupilId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> pupilLists(
    _i1.Session session,
    _i17.PupilList pupilList, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilList.id == null) {
      throw ArgumentError.notNull('pupilList.id');
    }

    var $pupilList = pupilList.copyWith(pupilId: null);
    await session.db.updateRow<_i17.PupilList>(
      $pupilList,
      columns: [_i17.PupilList.t.pupilId],
      transaction: transaction,
    );
  }
}

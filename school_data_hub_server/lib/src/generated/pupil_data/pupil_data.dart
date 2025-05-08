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
import '../pupil_data/pupil_objects/preschool/pre_school_medical.dart' as _i2;
import '../pupil_data/pupil_objects/preschool/pre_school_test.dart' as _i3;
import '../shared/document.dart' as _i4;
import '../pupil_data/pupil_objects/communication/public_media_auth.dart'
    as _i5;
import '../pupil_data/pupil_objects/communication/communication_skills.dart'
    as _i6;
import '../pupil_data/pupil_objects/communication/tutor_info.dart' as _i7;
import '../authorization/pupil_authorization.dart' as _i8;
import '../pupil_data/pupil_objects/after_school_care/after_school_care.dart'
    as _i9;
import '../user/credit_transaction.dart' as _i10;
import '../learning/timetable/lesson/lesson_group_membership.dart' as _i11;
import '../learning/timetable/lesson/lesson_attendance.dart' as _i12;
import '../learning/competence_goal.dart' as _i13;
import '../learning/competence_check.dart' as _i14;
import '../learning/competence_report.dart' as _i15;
import '../learning/competence_report_check.dart' as _i16;
import '../workbook/pupil_workbook.dart' as _i17;
import '../book/pupil_book_lending.dart' as _i18;
import '../learning_support/support_level.dart' as _i19;
import '../learning_support/support_category_status.dart' as _i20;
import '../learning_support/support_goal/support_goal.dart' as _i21;
import '../schoolday/missed_class/missed_class.dart' as _i22;
import '../schoolday/schoolday_event/schoolday_event.dart' as _i23;
import '../school_list/pupil_entry.dart' as _i24;

/// Pupil class
abstract class PupilData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PupilData._({
    this.id,
    required this.active,
    required this.internalId,
    this.preSchoolMedicalId,
    this.preSchoolMedical,
    this.kindergarden,
    this.preSchoolTestId,
    this.preSchoolTest,
    this.avatarId,
    this.avatar,
    this.avatarAuthId,
    this.avatarAuth,
    required this.publicMediaAuth,
    this.publicMediaAuthDocumentId,
    this.publicMediaAuthDocument,
    this.contact,
    this.communicationPupil,
    this.specialInformation,
    this.tutorInfo,
    this.authorizations,
    this.afterSchoolCare,
    required this.credit,
    required this.creditEarned,
    this.creditTransactions,
    this.lessonGroupMemberships,
    this.lessonsAttended,
    this.competenceGoals,
    this.competenceChecks,
    this.competenceReports,
    this.competenceReportChecks,
    this.pupilWorkbooks,
    this.pupilBookLendings,
    this.schoolyearHeldBackAt,
    this.supportLevelHistory,
    this.supportCategoryStatuses,
    this.supportGoals,
    this.missedClasses,
    this.schooldayEvents,
    this.swimmer,
    this.pupilListEntries,
  });

  factory PupilData({
    int? id,
    required bool active,
    required int internalId,
    int? preSchoolMedicalId,
    _i2.PreSchoolMedical? preSchoolMedical,
    String? kindergarden,
    int? preSchoolTestId,
    _i3.PreSchoolTest? preSchoolTest,
    int? avatarId,
    _i4.HubDocument? avatar,
    int? avatarAuthId,
    _i4.HubDocument? avatarAuth,
    required _i5.PublicMediaAuth publicMediaAuth,
    int? publicMediaAuthDocumentId,
    _i4.HubDocument? publicMediaAuthDocument,
    String? contact,
    _i6.CommunicationSkills? communicationPupil,
    String? specialInformation,
    _i7.TutorInfo? tutorInfo,
    List<_i8.PupilAuthorization>? authorizations,
    _i9.AfterSchoolCare? afterSchoolCare,
    required int credit,
    required int creditEarned,
    List<_i10.CreditTransaction>? creditTransactions,
    List<_i11.ScheduledLessonGroupMembership>? lessonGroupMemberships,
    List<_i12.LessonAttendance>? lessonsAttended,
    List<_i13.CompetenceGoal>? competenceGoals,
    List<_i14.CompetenceCheck>? competenceChecks,
    List<_i15.CompetenceReport>? competenceReports,
    List<_i16.CompetenceReportCheck>? competenceReportChecks,
    List<_i17.PupilWorkbook>? pupilWorkbooks,
    List<_i18.PupilBookLending>? pupilBookLendings,
    DateTime? schoolyearHeldBackAt,
    List<_i19.SupportLevel>? supportLevelHistory,
    List<_i20.SupportCategoryStatus>? supportCategoryStatuses,
    List<_i21.SupportGoal>? supportGoals,
    List<_i22.MissedClass>? missedClasses,
    List<_i23.SchooldayEvent>? schooldayEvents,
    String? swimmer,
    List<_i24.PupilListEntry>? pupilListEntries,
  }) = _PupilDataImpl;

  factory PupilData.fromJson(Map<String, dynamic> jsonSerialization) {
    return PupilData(
      id: jsonSerialization['id'] as int?,
      active: jsonSerialization['active'] as bool,
      internalId: jsonSerialization['internalId'] as int,
      preSchoolMedicalId: jsonSerialization['preSchoolMedicalId'] as int?,
      preSchoolMedical: jsonSerialization['preSchoolMedical'] == null
          ? null
          : _i2.PreSchoolMedical.fromJson(
              (jsonSerialization['preSchoolMedical'] as Map<String, dynamic>)),
      kindergarden: jsonSerialization['kindergarden'] as String?,
      preSchoolTestId: jsonSerialization['preSchoolTestId'] as int?,
      preSchoolTest: jsonSerialization['preSchoolTest'] == null
          ? null
          : _i3.PreSchoolTest.fromJson(
              (jsonSerialization['preSchoolTest'] as Map<String, dynamic>)),
      avatarId: jsonSerialization['avatarId'] as int?,
      avatar: jsonSerialization['avatar'] == null
          ? null
          : _i4.HubDocument.fromJson(
              (jsonSerialization['avatar'] as Map<String, dynamic>)),
      avatarAuthId: jsonSerialization['avatarAuthId'] as int?,
      avatarAuth: jsonSerialization['avatarAuth'] == null
          ? null
          : _i4.HubDocument.fromJson(
              (jsonSerialization['avatarAuth'] as Map<String, dynamic>)),
      publicMediaAuth: _i5.PublicMediaAuth.fromJson(
          (jsonSerialization['publicMediaAuth'] as Map<String, dynamic>)),
      publicMediaAuthDocumentId:
          jsonSerialization['publicMediaAuthDocumentId'] as int?,
      publicMediaAuthDocument:
          jsonSerialization['publicMediaAuthDocument'] == null
              ? null
              : _i4.HubDocument.fromJson(
                  (jsonSerialization['publicMediaAuthDocument']
                      as Map<String, dynamic>)),
      contact: jsonSerialization['contact'] as String?,
      communicationPupil: jsonSerialization['communicationPupil'] == null
          ? null
          : _i6.CommunicationSkills.fromJson(
              (jsonSerialization['communicationPupil']
                  as Map<String, dynamic>)),
      specialInformation: jsonSerialization['specialInformation'] as String?,
      tutorInfo: jsonSerialization['tutorInfo'] == null
          ? null
          : _i7.TutorInfo.fromJson(
              (jsonSerialization['tutorInfo'] as Map<String, dynamic>)),
      authorizations: (jsonSerialization['authorizations'] as List?)
          ?.map((e) =>
              _i8.PupilAuthorization.fromJson((e as Map<String, dynamic>)))
          .toList(),
      afterSchoolCare: jsonSerialization['afterSchoolCare'] == null
          ? null
          : _i9.AfterSchoolCare.fromJson(
              (jsonSerialization['afterSchoolCare'] as Map<String, dynamic>)),
      credit: jsonSerialization['credit'] as int,
      creditEarned: jsonSerialization['creditEarned'] as int,
      creditTransactions: (jsonSerialization['creditTransactions'] as List?)
          ?.map((e) =>
              _i10.CreditTransaction.fromJson((e as Map<String, dynamic>)))
          .toList(),
      lessonGroupMemberships:
          (jsonSerialization['lessonGroupMemberships'] as List?)
              ?.map((e) => _i11.ScheduledLessonGroupMembership.fromJson(
                  (e as Map<String, dynamic>)))
              .toList(),
      lessonsAttended: (jsonSerialization['lessonsAttended'] as List?)
          ?.map((e) =>
              _i12.LessonAttendance.fromJson((e as Map<String, dynamic>)))
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
      pupilWorkbooks: (jsonSerialization['pupilWorkbooks'] as List?)
          ?.map((e) => _i17.PupilWorkbook.fromJson((e as Map<String, dynamic>)))
          .toList(),
      pupilBookLendings: (jsonSerialization['pupilBookLendings'] as List?)
          ?.map((e) =>
              _i18.PupilBookLending.fromJson((e as Map<String, dynamic>)))
          .toList(),
      schoolyearHeldBackAt: jsonSerialization['schoolyearHeldBackAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['schoolyearHeldBackAt']),
      supportLevelHistory: (jsonSerialization['supportLevelHistory'] as List?)
          ?.map((e) => _i19.SupportLevel.fromJson((e as Map<String, dynamic>)))
          .toList(),
      supportCategoryStatuses: (jsonSerialization['supportCategoryStatuses']
              as List?)
          ?.map((e) =>
              _i20.SupportCategoryStatus.fromJson((e as Map<String, dynamic>)))
          .toList(),
      supportGoals: (jsonSerialization['supportGoals'] as List?)
          ?.map((e) => _i21.SupportGoal.fromJson((e as Map<String, dynamic>)))
          .toList(),
      missedClasses: (jsonSerialization['missedClasses'] as List?)
          ?.map((e) => _i22.MissedClass.fromJson((e as Map<String, dynamic>)))
          .toList(),
      schooldayEvents: (jsonSerialization['schooldayEvents'] as List?)
          ?.map(
              (e) => _i23.SchooldayEvent.fromJson((e as Map<String, dynamic>)))
          .toList(),
      swimmer: jsonSerialization['swimmer'] as String?,
      pupilListEntries: (jsonSerialization['pupilListEntries'] as List?)
          ?.map(
              (e) => _i24.PupilListEntry.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = PupilDataTable();

  static const db = PupilDataRepository._();

  @override
  int? id;

  bool active;

  int internalId;

  int? preSchoolMedicalId;

  _i2.PreSchoolMedical? preSchoolMedical;

  String? kindergarden;

  int? preSchoolTestId;

  _i3.PreSchoolTest? preSchoolTest;

  int? avatarId;

  _i4.HubDocument? avatar;

  int? avatarAuthId;

  _i4.HubDocument? avatarAuth;

  _i5.PublicMediaAuth publicMediaAuth;

  int? publicMediaAuthDocumentId;

  _i4.HubDocument? publicMediaAuthDocument;

  String? contact;

  _i6.CommunicationSkills? communicationPupil;

  String? specialInformation;

  _i7.TutorInfo? tutorInfo;

  List<_i8.PupilAuthorization>? authorizations;

  _i9.AfterSchoolCare? afterSchoolCare;

  int credit;

  int creditEarned;

  List<_i10.CreditTransaction>? creditTransactions;

  List<_i11.ScheduledLessonGroupMembership>? lessonGroupMemberships;

  List<_i12.LessonAttendance>? lessonsAttended;

  List<_i13.CompetenceGoal>? competenceGoals;

  List<_i14.CompetenceCheck>? competenceChecks;

  List<_i15.CompetenceReport>? competenceReports;

  List<_i16.CompetenceReportCheck>? competenceReportChecks;

  List<_i17.PupilWorkbook>? pupilWorkbooks;

  List<_i18.PupilBookLending>? pupilBookLendings;

  DateTime? schoolyearHeldBackAt;

  List<_i19.SupportLevel>? supportLevelHistory;

  List<_i20.SupportCategoryStatus>? supportCategoryStatuses;

  List<_i21.SupportGoal>? supportGoals;

  List<_i22.MissedClass>? missedClasses;

  List<_i23.SchooldayEvent>? schooldayEvents;

  String? swimmer;

  List<_i24.PupilListEntry>? pupilListEntries;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PupilData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilData copyWith({
    int? id,
    bool? active,
    int? internalId,
    int? preSchoolMedicalId,
    _i2.PreSchoolMedical? preSchoolMedical,
    String? kindergarden,
    int? preSchoolTestId,
    _i3.PreSchoolTest? preSchoolTest,
    int? avatarId,
    _i4.HubDocument? avatar,
    int? avatarAuthId,
    _i4.HubDocument? avatarAuth,
    _i5.PublicMediaAuth? publicMediaAuth,
    int? publicMediaAuthDocumentId,
    _i4.HubDocument? publicMediaAuthDocument,
    String? contact,
    _i6.CommunicationSkills? communicationPupil,
    String? specialInformation,
    _i7.TutorInfo? tutorInfo,
    List<_i8.PupilAuthorization>? authorizations,
    _i9.AfterSchoolCare? afterSchoolCare,
    int? credit,
    int? creditEarned,
    List<_i10.CreditTransaction>? creditTransactions,
    List<_i11.ScheduledLessonGroupMembership>? lessonGroupMemberships,
    List<_i12.LessonAttendance>? lessonsAttended,
    List<_i13.CompetenceGoal>? competenceGoals,
    List<_i14.CompetenceCheck>? competenceChecks,
    List<_i15.CompetenceReport>? competenceReports,
    List<_i16.CompetenceReportCheck>? competenceReportChecks,
    List<_i17.PupilWorkbook>? pupilWorkbooks,
    List<_i18.PupilBookLending>? pupilBookLendings,
    DateTime? schoolyearHeldBackAt,
    List<_i19.SupportLevel>? supportLevelHistory,
    List<_i20.SupportCategoryStatus>? supportCategoryStatuses,
    List<_i21.SupportGoal>? supportGoals,
    List<_i22.MissedClass>? missedClasses,
    List<_i23.SchooldayEvent>? schooldayEvents,
    String? swimmer,
    List<_i24.PupilListEntry>? pupilListEntries,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'active': active,
      'internalId': internalId,
      if (preSchoolMedicalId != null) 'preSchoolMedicalId': preSchoolMedicalId,
      if (preSchoolMedical != null)
        'preSchoolMedical': preSchoolMedical?.toJson(),
      if (kindergarden != null) 'kindergarden': kindergarden,
      if (preSchoolTestId != null) 'preSchoolTestId': preSchoolTestId,
      if (preSchoolTest != null) 'preSchoolTest': preSchoolTest?.toJson(),
      if (avatarId != null) 'avatarId': avatarId,
      if (avatar != null) 'avatar': avatar?.toJson(),
      if (avatarAuthId != null) 'avatarAuthId': avatarAuthId,
      if (avatarAuth != null) 'avatarAuth': avatarAuth?.toJson(),
      'publicMediaAuth': publicMediaAuth.toJson(),
      if (publicMediaAuthDocumentId != null)
        'publicMediaAuthDocumentId': publicMediaAuthDocumentId,
      if (publicMediaAuthDocument != null)
        'publicMediaAuthDocument': publicMediaAuthDocument?.toJson(),
      if (contact != null) 'contact': contact,
      if (communicationPupil != null)
        'communicationPupil': communicationPupil?.toJson(),
      if (specialInformation != null) 'specialInformation': specialInformation,
      if (tutorInfo != null) 'tutorInfo': tutorInfo?.toJson(),
      if (authorizations != null)
        'authorizations':
            authorizations?.toJson(valueToJson: (v) => v.toJson()),
      if (afterSchoolCare != null) 'afterSchoolCare': afterSchoolCare?.toJson(),
      'credit': credit,
      'creditEarned': creditEarned,
      if (creditTransactions != null)
        'creditTransactions':
            creditTransactions?.toJson(valueToJson: (v) => v.toJson()),
      if (lessonGroupMemberships != null)
        'lessonGroupMemberships':
            lessonGroupMemberships?.toJson(valueToJson: (v) => v.toJson()),
      if (lessonsAttended != null)
        'lessonsAttended':
            lessonsAttended?.toJson(valueToJson: (v) => v.toJson()),
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
      if (pupilWorkbooks != null)
        'pupilWorkbooks':
            pupilWorkbooks?.toJson(valueToJson: (v) => v.toJson()),
      if (pupilBookLendings != null)
        'pupilBookLendings':
            pupilBookLendings?.toJson(valueToJson: (v) => v.toJson()),
      if (schoolyearHeldBackAt != null)
        'schoolyearHeldBackAt': schoolyearHeldBackAt?.toJson(),
      if (supportLevelHistory != null)
        'supportLevelHistory':
            supportLevelHistory?.toJson(valueToJson: (v) => v.toJson()),
      if (supportCategoryStatuses != null)
        'supportCategoryStatuses':
            supportCategoryStatuses?.toJson(valueToJson: (v) => v.toJson()),
      if (supportGoals != null)
        'supportGoals': supportGoals?.toJson(valueToJson: (v) => v.toJson()),
      if (missedClasses != null)
        'missedClasses': missedClasses?.toJson(valueToJson: (v) => v.toJson()),
      if (schooldayEvents != null)
        'schooldayEvents':
            schooldayEvents?.toJson(valueToJson: (v) => v.toJson()),
      if (swimmer != null) 'swimmer': swimmer,
      if (pupilListEntries != null)
        'pupilListEntries':
            pupilListEntries?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'active': active,
      'internalId': internalId,
      if (preSchoolMedicalId != null) 'preSchoolMedicalId': preSchoolMedicalId,
      if (preSchoolMedical != null)
        'preSchoolMedical': preSchoolMedical?.toJsonForProtocol(),
      if (kindergarden != null) 'kindergarden': kindergarden,
      if (preSchoolTestId != null) 'preSchoolTestId': preSchoolTestId,
      if (preSchoolTest != null)
        'preSchoolTest': preSchoolTest?.toJsonForProtocol(),
      if (avatarId != null) 'avatarId': avatarId,
      if (avatar != null) 'avatar': avatar?.toJsonForProtocol(),
      if (avatarAuthId != null) 'avatarAuthId': avatarAuthId,
      if (avatarAuth != null) 'avatarAuth': avatarAuth?.toJsonForProtocol(),
      'publicMediaAuth': publicMediaAuth.toJsonForProtocol(),
      if (publicMediaAuthDocumentId != null)
        'publicMediaAuthDocumentId': publicMediaAuthDocumentId,
      if (publicMediaAuthDocument != null)
        'publicMediaAuthDocument': publicMediaAuthDocument?.toJsonForProtocol(),
      if (contact != null) 'contact': contact,
      if (communicationPupil != null)
        'communicationPupil': communicationPupil?.toJsonForProtocol(),
      if (specialInformation != null) 'specialInformation': specialInformation,
      if (tutorInfo != null) 'tutorInfo': tutorInfo?.toJsonForProtocol(),
      if (authorizations != null)
        'authorizations':
            authorizations?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (afterSchoolCare != null)
        'afterSchoolCare': afterSchoolCare?.toJsonForProtocol(),
      'credit': credit,
      'creditEarned': creditEarned,
      if (creditTransactions != null)
        'creditTransactions': creditTransactions?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (lessonGroupMemberships != null)
        'lessonGroupMemberships': lessonGroupMemberships?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (lessonsAttended != null)
        'lessonsAttended':
            lessonsAttended?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
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
      if (pupilWorkbooks != null)
        'pupilWorkbooks':
            pupilWorkbooks?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (pupilBookLendings != null)
        'pupilBookLendings': pupilBookLendings?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (schoolyearHeldBackAt != null)
        'schoolyearHeldBackAt': schoolyearHeldBackAt?.toJson(),
      if (supportLevelHistory != null)
        'supportLevelHistory': supportLevelHistory?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (supportCategoryStatuses != null)
        'supportCategoryStatuses': supportCategoryStatuses?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (supportGoals != null)
        'supportGoals':
            supportGoals?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (missedClasses != null)
        'missedClasses':
            missedClasses?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (schooldayEvents != null)
        'schooldayEvents':
            schooldayEvents?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (swimmer != null) 'swimmer': swimmer,
      if (pupilListEntries != null)
        'pupilListEntries':
            pupilListEntries?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static PupilDataInclude include({
    _i2.PreSchoolMedicalInclude? preSchoolMedical,
    _i3.PreSchoolTestInclude? preSchoolTest,
    _i4.HubDocumentInclude? avatar,
    _i4.HubDocumentInclude? avatarAuth,
    _i4.HubDocumentInclude? publicMediaAuthDocument,
    _i8.PupilAuthorizationIncludeList? authorizations,
    _i10.CreditTransactionIncludeList? creditTransactions,
    _i11.ScheduledLessonGroupMembershipIncludeList? lessonGroupMemberships,
    _i12.LessonAttendanceIncludeList? lessonsAttended,
    _i13.CompetenceGoalIncludeList? competenceGoals,
    _i14.CompetenceCheckIncludeList? competenceChecks,
    _i15.CompetenceReportIncludeList? competenceReports,
    _i16.CompetenceReportCheckIncludeList? competenceReportChecks,
    _i17.PupilWorkbookIncludeList? pupilWorkbooks,
    _i18.PupilBookLendingIncludeList? pupilBookLendings,
    _i19.SupportLevelIncludeList? supportLevelHistory,
    _i20.SupportCategoryStatusIncludeList? supportCategoryStatuses,
    _i21.SupportGoalIncludeList? supportGoals,
    _i22.MissedClassIncludeList? missedClasses,
    _i23.SchooldayEventIncludeList? schooldayEvents,
    _i24.PupilListEntryIncludeList? pupilListEntries,
  }) {
    return PupilDataInclude._(
      preSchoolMedical: preSchoolMedical,
      preSchoolTest: preSchoolTest,
      avatar: avatar,
      avatarAuth: avatarAuth,
      publicMediaAuthDocument: publicMediaAuthDocument,
      authorizations: authorizations,
      creditTransactions: creditTransactions,
      lessonGroupMemberships: lessonGroupMemberships,
      lessonsAttended: lessonsAttended,
      competenceGoals: competenceGoals,
      competenceChecks: competenceChecks,
      competenceReports: competenceReports,
      competenceReportChecks: competenceReportChecks,
      pupilWorkbooks: pupilWorkbooks,
      pupilBookLendings: pupilBookLendings,
      supportLevelHistory: supportLevelHistory,
      supportCategoryStatuses: supportCategoryStatuses,
      supportGoals: supportGoals,
      missedClasses: missedClasses,
      schooldayEvents: schooldayEvents,
      pupilListEntries: pupilListEntries,
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
    required bool active,
    required int internalId,
    int? preSchoolMedicalId,
    _i2.PreSchoolMedical? preSchoolMedical,
    String? kindergarden,
    int? preSchoolTestId,
    _i3.PreSchoolTest? preSchoolTest,
    int? avatarId,
    _i4.HubDocument? avatar,
    int? avatarAuthId,
    _i4.HubDocument? avatarAuth,
    required _i5.PublicMediaAuth publicMediaAuth,
    int? publicMediaAuthDocumentId,
    _i4.HubDocument? publicMediaAuthDocument,
    String? contact,
    _i6.CommunicationSkills? communicationPupil,
    String? specialInformation,
    _i7.TutorInfo? tutorInfo,
    List<_i8.PupilAuthorization>? authorizations,
    _i9.AfterSchoolCare? afterSchoolCare,
    required int credit,
    required int creditEarned,
    List<_i10.CreditTransaction>? creditTransactions,
    List<_i11.ScheduledLessonGroupMembership>? lessonGroupMemberships,
    List<_i12.LessonAttendance>? lessonsAttended,
    List<_i13.CompetenceGoal>? competenceGoals,
    List<_i14.CompetenceCheck>? competenceChecks,
    List<_i15.CompetenceReport>? competenceReports,
    List<_i16.CompetenceReportCheck>? competenceReportChecks,
    List<_i17.PupilWorkbook>? pupilWorkbooks,
    List<_i18.PupilBookLending>? pupilBookLendings,
    DateTime? schoolyearHeldBackAt,
    List<_i19.SupportLevel>? supportLevelHistory,
    List<_i20.SupportCategoryStatus>? supportCategoryStatuses,
    List<_i21.SupportGoal>? supportGoals,
    List<_i22.MissedClass>? missedClasses,
    List<_i23.SchooldayEvent>? schooldayEvents,
    String? swimmer,
    List<_i24.PupilListEntry>? pupilListEntries,
  }) : super._(
          id: id,
          active: active,
          internalId: internalId,
          preSchoolMedicalId: preSchoolMedicalId,
          preSchoolMedical: preSchoolMedical,
          kindergarden: kindergarden,
          preSchoolTestId: preSchoolTestId,
          preSchoolTest: preSchoolTest,
          avatarId: avatarId,
          avatar: avatar,
          avatarAuthId: avatarAuthId,
          avatarAuth: avatarAuth,
          publicMediaAuth: publicMediaAuth,
          publicMediaAuthDocumentId: publicMediaAuthDocumentId,
          publicMediaAuthDocument: publicMediaAuthDocument,
          contact: contact,
          communicationPupil: communicationPupil,
          specialInformation: specialInformation,
          tutorInfo: tutorInfo,
          authorizations: authorizations,
          afterSchoolCare: afterSchoolCare,
          credit: credit,
          creditEarned: creditEarned,
          creditTransactions: creditTransactions,
          lessonGroupMemberships: lessonGroupMemberships,
          lessonsAttended: lessonsAttended,
          competenceGoals: competenceGoals,
          competenceChecks: competenceChecks,
          competenceReports: competenceReports,
          competenceReportChecks: competenceReportChecks,
          pupilWorkbooks: pupilWorkbooks,
          pupilBookLendings: pupilBookLendings,
          schoolyearHeldBackAt: schoolyearHeldBackAt,
          supportLevelHistory: supportLevelHistory,
          supportCategoryStatuses: supportCategoryStatuses,
          supportGoals: supportGoals,
          missedClasses: missedClasses,
          schooldayEvents: schooldayEvents,
          swimmer: swimmer,
          pupilListEntries: pupilListEntries,
        );

  /// Returns a shallow copy of this [PupilData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilData copyWith({
    Object? id = _Undefined,
    bool? active,
    int? internalId,
    Object? preSchoolMedicalId = _Undefined,
    Object? preSchoolMedical = _Undefined,
    Object? kindergarden = _Undefined,
    Object? preSchoolTestId = _Undefined,
    Object? preSchoolTest = _Undefined,
    Object? avatarId = _Undefined,
    Object? avatar = _Undefined,
    Object? avatarAuthId = _Undefined,
    Object? avatarAuth = _Undefined,
    _i5.PublicMediaAuth? publicMediaAuth,
    Object? publicMediaAuthDocumentId = _Undefined,
    Object? publicMediaAuthDocument = _Undefined,
    Object? contact = _Undefined,
    Object? communicationPupil = _Undefined,
    Object? specialInformation = _Undefined,
    Object? tutorInfo = _Undefined,
    Object? authorizations = _Undefined,
    Object? afterSchoolCare = _Undefined,
    int? credit,
    int? creditEarned,
    Object? creditTransactions = _Undefined,
    Object? lessonGroupMemberships = _Undefined,
    Object? lessonsAttended = _Undefined,
    Object? competenceGoals = _Undefined,
    Object? competenceChecks = _Undefined,
    Object? competenceReports = _Undefined,
    Object? competenceReportChecks = _Undefined,
    Object? pupilWorkbooks = _Undefined,
    Object? pupilBookLendings = _Undefined,
    Object? schoolyearHeldBackAt = _Undefined,
    Object? supportLevelHistory = _Undefined,
    Object? supportCategoryStatuses = _Undefined,
    Object? supportGoals = _Undefined,
    Object? missedClasses = _Undefined,
    Object? schooldayEvents = _Undefined,
    Object? swimmer = _Undefined,
    Object? pupilListEntries = _Undefined,
  }) {
    return PupilData(
      id: id is int? ? id : this.id,
      active: active ?? this.active,
      internalId: internalId ?? this.internalId,
      preSchoolMedicalId: preSchoolMedicalId is int?
          ? preSchoolMedicalId
          : this.preSchoolMedicalId,
      preSchoolMedical: preSchoolMedical is _i2.PreSchoolMedical?
          ? preSchoolMedical
          : this.preSchoolMedical?.copyWith(),
      kindergarden: kindergarden is String? ? kindergarden : this.kindergarden,
      preSchoolTestId:
          preSchoolTestId is int? ? preSchoolTestId : this.preSchoolTestId,
      preSchoolTest: preSchoolTest is _i3.PreSchoolTest?
          ? preSchoolTest
          : this.preSchoolTest?.copyWith(),
      avatarId: avatarId is int? ? avatarId : this.avatarId,
      avatar: avatar is _i4.HubDocument? ? avatar : this.avatar?.copyWith(),
      avatarAuthId: avatarAuthId is int? ? avatarAuthId : this.avatarAuthId,
      avatarAuth: avatarAuth is _i4.HubDocument?
          ? avatarAuth
          : this.avatarAuth?.copyWith(),
      publicMediaAuth: publicMediaAuth ?? this.publicMediaAuth.copyWith(),
      publicMediaAuthDocumentId: publicMediaAuthDocumentId is int?
          ? publicMediaAuthDocumentId
          : this.publicMediaAuthDocumentId,
      publicMediaAuthDocument: publicMediaAuthDocument is _i4.HubDocument?
          ? publicMediaAuthDocument
          : this.publicMediaAuthDocument?.copyWith(),
      contact: contact is String? ? contact : this.contact,
      communicationPupil: communicationPupil is _i6.CommunicationSkills?
          ? communicationPupil
          : this.communicationPupil?.copyWith(),
      specialInformation: specialInformation is String?
          ? specialInformation
          : this.specialInformation,
      tutorInfo:
          tutorInfo is _i7.TutorInfo? ? tutorInfo : this.tutorInfo?.copyWith(),
      authorizations: authorizations is List<_i8.PupilAuthorization>?
          ? authorizations
          : this.authorizations?.map((e0) => e0.copyWith()).toList(),
      afterSchoolCare: afterSchoolCare is _i9.AfterSchoolCare?
          ? afterSchoolCare
          : this.afterSchoolCare?.copyWith(),
      credit: credit ?? this.credit,
      creditEarned: creditEarned ?? this.creditEarned,
      creditTransactions: creditTransactions is List<_i10.CreditTransaction>?
          ? creditTransactions
          : this.creditTransactions?.map((e0) => e0.copyWith()).toList(),
      lessonGroupMemberships: lessonGroupMemberships
              is List<_i11.ScheduledLessonGroupMembership>?
          ? lessonGroupMemberships
          : this.lessonGroupMemberships?.map((e0) => e0.copyWith()).toList(),
      lessonsAttended: lessonsAttended is List<_i12.LessonAttendance>?
          ? lessonsAttended
          : this.lessonsAttended?.map((e0) => e0.copyWith()).toList(),
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
      pupilWorkbooks: pupilWorkbooks is List<_i17.PupilWorkbook>?
          ? pupilWorkbooks
          : this.pupilWorkbooks?.map((e0) => e0.copyWith()).toList(),
      pupilBookLendings: pupilBookLendings is List<_i18.PupilBookLending>?
          ? pupilBookLendings
          : this.pupilBookLendings?.map((e0) => e0.copyWith()).toList(),
      schoolyearHeldBackAt: schoolyearHeldBackAt is DateTime?
          ? schoolyearHeldBackAt
          : this.schoolyearHeldBackAt,
      supportLevelHistory: supportLevelHistory is List<_i19.SupportLevel>?
          ? supportLevelHistory
          : this.supportLevelHistory?.map((e0) => e0.copyWith()).toList(),
      supportCategoryStatuses: supportCategoryStatuses
              is List<_i20.SupportCategoryStatus>?
          ? supportCategoryStatuses
          : this.supportCategoryStatuses?.map((e0) => e0.copyWith()).toList(),
      supportGoals: supportGoals is List<_i21.SupportGoal>?
          ? supportGoals
          : this.supportGoals?.map((e0) => e0.copyWith()).toList(),
      missedClasses: missedClasses is List<_i22.MissedClass>?
          ? missedClasses
          : this.missedClasses?.map((e0) => e0.copyWith()).toList(),
      schooldayEvents: schooldayEvents is List<_i23.SchooldayEvent>?
          ? schooldayEvents
          : this.schooldayEvents?.map((e0) => e0.copyWith()).toList(),
      swimmer: swimmer is String? ? swimmer : this.swimmer,
      pupilListEntries: pupilListEntries is List<_i24.PupilListEntry>?
          ? pupilListEntries
          : this.pupilListEntries?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class PupilDataTable extends _i1.Table<int?> {
  PupilDataTable({super.tableRelation}) : super(tableName: 'pupil_data') {
    active = _i1.ColumnBool(
      'active',
      this,
    );
    internalId = _i1.ColumnInt(
      'internalId',
      this,
    );
    preSchoolMedicalId = _i1.ColumnInt(
      'preSchoolMedicalId',
      this,
    );
    kindergarden = _i1.ColumnString(
      'kindergarden',
      this,
    );
    preSchoolTestId = _i1.ColumnInt(
      'preSchoolTestId',
      this,
    );
    avatarId = _i1.ColumnInt(
      'avatarId',
      this,
    );
    avatarAuthId = _i1.ColumnInt(
      'avatarAuthId',
      this,
    );
    publicMediaAuth = _i1.ColumnSerializable(
      'publicMediaAuth',
      this,
    );
    publicMediaAuthDocumentId = _i1.ColumnInt(
      'publicMediaAuthDocumentId',
      this,
    );
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
    afterSchoolCare = _i1.ColumnSerializable(
      'afterSchoolCare',
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
    schoolyearHeldBackAt = _i1.ColumnDateTime(
      'schoolyearHeldBackAt',
      this,
    );
    swimmer = _i1.ColumnString(
      'swimmer',
      this,
    );
  }

  late final _i1.ColumnBool active;

  late final _i1.ColumnInt internalId;

  late final _i1.ColumnInt preSchoolMedicalId;

  _i2.PreSchoolMedicalTable? _preSchoolMedical;

  late final _i1.ColumnString kindergarden;

  late final _i1.ColumnInt preSchoolTestId;

  _i3.PreSchoolTestTable? _preSchoolTest;

  late final _i1.ColumnInt avatarId;

  _i4.HubDocumentTable? _avatar;

  late final _i1.ColumnInt avatarAuthId;

  _i4.HubDocumentTable? _avatarAuth;

  late final _i1.ColumnSerializable publicMediaAuth;

  late final _i1.ColumnInt publicMediaAuthDocumentId;

  _i4.HubDocumentTable? _publicMediaAuthDocument;

  late final _i1.ColumnString contact;

  late final _i1.ColumnSerializable communicationPupil;

  late final _i1.ColumnString specialInformation;

  late final _i1.ColumnSerializable tutorInfo;

  _i8.PupilAuthorizationTable? ___authorizations;

  _i1.ManyRelation<_i8.PupilAuthorizationTable>? _authorizations;

  late final _i1.ColumnSerializable afterSchoolCare;

  late final _i1.ColumnInt credit;

  late final _i1.ColumnInt creditEarned;

  _i10.CreditTransactionTable? ___creditTransactions;

  _i1.ManyRelation<_i10.CreditTransactionTable>? _creditTransactions;

  _i11.ScheduledLessonGroupMembershipTable? ___lessonGroupMemberships;

  _i1.ManyRelation<_i11.ScheduledLessonGroupMembershipTable>?
      _lessonGroupMemberships;

  _i12.LessonAttendanceTable? ___lessonsAttended;

  _i1.ManyRelation<_i12.LessonAttendanceTable>? _lessonsAttended;

  _i13.CompetenceGoalTable? ___competenceGoals;

  _i1.ManyRelation<_i13.CompetenceGoalTable>? _competenceGoals;

  _i14.CompetenceCheckTable? ___competenceChecks;

  _i1.ManyRelation<_i14.CompetenceCheckTable>? _competenceChecks;

  _i15.CompetenceReportTable? ___competenceReports;

  _i1.ManyRelation<_i15.CompetenceReportTable>? _competenceReports;

  _i16.CompetenceReportCheckTable? ___competenceReportChecks;

  _i1.ManyRelation<_i16.CompetenceReportCheckTable>? _competenceReportChecks;

  _i17.PupilWorkbookTable? ___pupilWorkbooks;

  _i1.ManyRelation<_i17.PupilWorkbookTable>? _pupilWorkbooks;

  _i18.PupilBookLendingTable? ___pupilBookLendings;

  _i1.ManyRelation<_i18.PupilBookLendingTable>? _pupilBookLendings;

  late final _i1.ColumnDateTime schoolyearHeldBackAt;

  _i19.SupportLevelTable? ___supportLevelHistory;

  _i1.ManyRelation<_i19.SupportLevelTable>? _supportLevelHistory;

  _i20.SupportCategoryStatusTable? ___supportCategoryStatuses;

  _i1.ManyRelation<_i20.SupportCategoryStatusTable>? _supportCategoryStatuses;

  _i21.SupportGoalTable? ___supportGoals;

  _i1.ManyRelation<_i21.SupportGoalTable>? _supportGoals;

  _i22.MissedClassTable? ___missedClasses;

  _i1.ManyRelation<_i22.MissedClassTable>? _missedClasses;

  _i23.SchooldayEventTable? ___schooldayEvents;

  _i1.ManyRelation<_i23.SchooldayEventTable>? _schooldayEvents;

  late final _i1.ColumnString swimmer;

  _i24.PupilListEntryTable? ___pupilListEntries;

  _i1.ManyRelation<_i24.PupilListEntryTable>? _pupilListEntries;

  _i2.PreSchoolMedicalTable get preSchoolMedical {
    if (_preSchoolMedical != null) return _preSchoolMedical!;
    _preSchoolMedical = _i1.createRelationTable(
      relationFieldName: 'preSchoolMedical',
      field: PupilData.t.preSchoolMedicalId,
      foreignField: _i2.PreSchoolMedical.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PreSchoolMedicalTable(tableRelation: foreignTableRelation),
    );
    return _preSchoolMedical!;
  }

  _i3.PreSchoolTestTable get preSchoolTest {
    if (_preSchoolTest != null) return _preSchoolTest!;
    _preSchoolTest = _i1.createRelationTable(
      relationFieldName: 'preSchoolTest',
      field: PupilData.t.preSchoolTestId,
      foreignField: _i3.PreSchoolTest.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PreSchoolTestTable(tableRelation: foreignTableRelation),
    );
    return _preSchoolTest!;
  }

  _i4.HubDocumentTable get avatar {
    if (_avatar != null) return _avatar!;
    _avatar = _i1.createRelationTable(
      relationFieldName: 'avatar',
      field: PupilData.t.avatarId,
      foreignField: _i4.HubDocument.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.HubDocumentTable(tableRelation: foreignTableRelation),
    );
    return _avatar!;
  }

  _i4.HubDocumentTable get avatarAuth {
    if (_avatarAuth != null) return _avatarAuth!;
    _avatarAuth = _i1.createRelationTable(
      relationFieldName: 'avatarAuth',
      field: PupilData.t.avatarAuthId,
      foreignField: _i4.HubDocument.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.HubDocumentTable(tableRelation: foreignTableRelation),
    );
    return _avatarAuth!;
  }

  _i4.HubDocumentTable get publicMediaAuthDocument {
    if (_publicMediaAuthDocument != null) return _publicMediaAuthDocument!;
    _publicMediaAuthDocument = _i1.createRelationTable(
      relationFieldName: 'publicMediaAuthDocument',
      field: PupilData.t.publicMediaAuthDocumentId,
      foreignField: _i4.HubDocument.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.HubDocumentTable(tableRelation: foreignTableRelation),
    );
    return _publicMediaAuthDocument!;
  }

  _i8.PupilAuthorizationTable get __authorizations {
    if (___authorizations != null) return ___authorizations!;
    ___authorizations = _i1.createRelationTable(
      relationFieldName: '__authorizations',
      field: PupilData.t.id,
      foreignField: _i8.PupilAuthorization.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i8.PupilAuthorizationTable(tableRelation: foreignTableRelation),
    );
    return ___authorizations!;
  }

  _i10.CreditTransactionTable get __creditTransactions {
    if (___creditTransactions != null) return ___creditTransactions!;
    ___creditTransactions = _i1.createRelationTable(
      relationFieldName: '__creditTransactions',
      field: PupilData.t.id,
      foreignField:
          _i10.CreditTransaction.t.$_pupilDataCredittransactionsPupilDataId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i10.CreditTransactionTable(tableRelation: foreignTableRelation),
    );
    return ___creditTransactions!;
  }

  _i11.ScheduledLessonGroupMembershipTable get __lessonGroupMemberships {
    if (___lessonGroupMemberships != null) return ___lessonGroupMemberships!;
    ___lessonGroupMemberships = _i1.createRelationTable(
      relationFieldName: '__lessonGroupMemberships',
      field: PupilData.t.id,
      foreignField: _i11.ScheduledLessonGroupMembership.t.pupilDataId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i11.ScheduledLessonGroupMembershipTable(
              tableRelation: foreignTableRelation),
    );
    return ___lessonGroupMemberships!;
  }

  _i12.LessonAttendanceTable get __lessonsAttended {
    if (___lessonsAttended != null) return ___lessonsAttended!;
    ___lessonsAttended = _i1.createRelationTable(
      relationFieldName: '__lessonsAttended',
      field: PupilData.t.id,
      foreignField: _i12.LessonAttendance.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i12.LessonAttendanceTable(tableRelation: foreignTableRelation),
    );
    return ___lessonsAttended!;
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

  _i17.PupilWorkbookTable get __pupilWorkbooks {
    if (___pupilWorkbooks != null) return ___pupilWorkbooks!;
    ___pupilWorkbooks = _i1.createRelationTable(
      relationFieldName: '__pupilWorkbooks',
      field: PupilData.t.id,
      foreignField: _i17.PupilWorkbook.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i17.PupilWorkbookTable(tableRelation: foreignTableRelation),
    );
    return ___pupilWorkbooks!;
  }

  _i18.PupilBookLendingTable get __pupilBookLendings {
    if (___pupilBookLendings != null) return ___pupilBookLendings!;
    ___pupilBookLendings = _i1.createRelationTable(
      relationFieldName: '__pupilBookLendings',
      field: PupilData.t.id,
      foreignField: _i18.PupilBookLending.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i18.PupilBookLendingTable(tableRelation: foreignTableRelation),
    );
    return ___pupilBookLendings!;
  }

  _i19.SupportLevelTable get __supportLevelHistory {
    if (___supportLevelHistory != null) return ___supportLevelHistory!;
    ___supportLevelHistory = _i1.createRelationTable(
      relationFieldName: '__supportLevelHistory',
      field: PupilData.t.id,
      foreignField: _i19.SupportLevel.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i19.SupportLevelTable(tableRelation: foreignTableRelation),
    );
    return ___supportLevelHistory!;
  }

  _i20.SupportCategoryStatusTable get __supportCategoryStatuses {
    if (___supportCategoryStatuses != null) return ___supportCategoryStatuses!;
    ___supportCategoryStatuses = _i1.createRelationTable(
      relationFieldName: '__supportCategoryStatuses',
      field: PupilData.t.id,
      foreignField: _i20.SupportCategoryStatus.t
          .$_pupilDataSupportcategorystatusesPupilDataId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i20.SupportCategoryStatusTable(tableRelation: foreignTableRelation),
    );
    return ___supportCategoryStatuses!;
  }

  _i21.SupportGoalTable get __supportGoals {
    if (___supportGoals != null) return ___supportGoals!;
    ___supportGoals = _i1.createRelationTable(
      relationFieldName: '__supportGoals',
      field: PupilData.t.id,
      foreignField: _i21.SupportGoal.t.$_pupilDataSupportgoalsPupilDataId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i21.SupportGoalTable(tableRelation: foreignTableRelation),
    );
    return ___supportGoals!;
  }

  _i22.MissedClassTable get __missedClasses {
    if (___missedClasses != null) return ___missedClasses!;
    ___missedClasses = _i1.createRelationTable(
      relationFieldName: '__missedClasses',
      field: PupilData.t.id,
      foreignField: _i22.MissedClass.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i22.MissedClassTable(tableRelation: foreignTableRelation),
    );
    return ___missedClasses!;
  }

  _i23.SchooldayEventTable get __schooldayEvents {
    if (___schooldayEvents != null) return ___schooldayEvents!;
    ___schooldayEvents = _i1.createRelationTable(
      relationFieldName: '__schooldayEvents',
      field: PupilData.t.id,
      foreignField: _i23.SchooldayEvent.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i23.SchooldayEventTable(tableRelation: foreignTableRelation),
    );
    return ___schooldayEvents!;
  }

  _i24.PupilListEntryTable get __pupilListEntries {
    if (___pupilListEntries != null) return ___pupilListEntries!;
    ___pupilListEntries = _i1.createRelationTable(
      relationFieldName: '__pupilListEntries',
      field: PupilData.t.id,
      foreignField: _i24.PupilListEntry.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i24.PupilListEntryTable(tableRelation: foreignTableRelation),
    );
    return ___pupilListEntries!;
  }

  _i1.ManyRelation<_i8.PupilAuthorizationTable> get authorizations {
    if (_authorizations != null) return _authorizations!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'authorizations',
      field: PupilData.t.id,
      foreignField: _i8.PupilAuthorization.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i8.PupilAuthorizationTable(tableRelation: foreignTableRelation),
    );
    _authorizations = _i1.ManyRelation<_i8.PupilAuthorizationTable>(
      tableWithRelations: relationTable,
      table: _i8.PupilAuthorizationTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _authorizations!;
  }

  _i1.ManyRelation<_i10.CreditTransactionTable> get creditTransactions {
    if (_creditTransactions != null) return _creditTransactions!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'creditTransactions',
      field: PupilData.t.id,
      foreignField:
          _i10.CreditTransaction.t.$_pupilDataCredittransactionsPupilDataId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i10.CreditTransactionTable(tableRelation: foreignTableRelation),
    );
    _creditTransactions = _i1.ManyRelation<_i10.CreditTransactionTable>(
      tableWithRelations: relationTable,
      table: _i10.CreditTransactionTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _creditTransactions!;
  }

  _i1.ManyRelation<_i11.ScheduledLessonGroupMembershipTable>
      get lessonGroupMemberships {
    if (_lessonGroupMemberships != null) return _lessonGroupMemberships!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'lessonGroupMemberships',
      field: PupilData.t.id,
      foreignField: _i11.ScheduledLessonGroupMembership.t.pupilDataId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i11.ScheduledLessonGroupMembershipTable(
              tableRelation: foreignTableRelation),
    );
    _lessonGroupMemberships =
        _i1.ManyRelation<_i11.ScheduledLessonGroupMembershipTable>(
      tableWithRelations: relationTable,
      table: _i11.ScheduledLessonGroupMembershipTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _lessonGroupMemberships!;
  }

  _i1.ManyRelation<_i12.LessonAttendanceTable> get lessonsAttended {
    if (_lessonsAttended != null) return _lessonsAttended!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'lessonsAttended',
      field: PupilData.t.id,
      foreignField: _i12.LessonAttendance.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i12.LessonAttendanceTable(tableRelation: foreignTableRelation),
    );
    _lessonsAttended = _i1.ManyRelation<_i12.LessonAttendanceTable>(
      tableWithRelations: relationTable,
      table: _i12.LessonAttendanceTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _lessonsAttended!;
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

  _i1.ManyRelation<_i17.PupilWorkbookTable> get pupilWorkbooks {
    if (_pupilWorkbooks != null) return _pupilWorkbooks!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'pupilWorkbooks',
      field: PupilData.t.id,
      foreignField: _i17.PupilWorkbook.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i17.PupilWorkbookTable(tableRelation: foreignTableRelation),
    );
    _pupilWorkbooks = _i1.ManyRelation<_i17.PupilWorkbookTable>(
      tableWithRelations: relationTable,
      table: _i17.PupilWorkbookTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _pupilWorkbooks!;
  }

  _i1.ManyRelation<_i18.PupilBookLendingTable> get pupilBookLendings {
    if (_pupilBookLendings != null) return _pupilBookLendings!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'pupilBookLendings',
      field: PupilData.t.id,
      foreignField: _i18.PupilBookLending.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i18.PupilBookLendingTable(tableRelation: foreignTableRelation),
    );
    _pupilBookLendings = _i1.ManyRelation<_i18.PupilBookLendingTable>(
      tableWithRelations: relationTable,
      table: _i18.PupilBookLendingTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _pupilBookLendings!;
  }

  _i1.ManyRelation<_i19.SupportLevelTable> get supportLevelHistory {
    if (_supportLevelHistory != null) return _supportLevelHistory!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'supportLevelHistory',
      field: PupilData.t.id,
      foreignField: _i19.SupportLevel.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i19.SupportLevelTable(tableRelation: foreignTableRelation),
    );
    _supportLevelHistory = _i1.ManyRelation<_i19.SupportLevelTable>(
      tableWithRelations: relationTable,
      table: _i19.SupportLevelTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _supportLevelHistory!;
  }

  _i1.ManyRelation<_i20.SupportCategoryStatusTable>
      get supportCategoryStatuses {
    if (_supportCategoryStatuses != null) return _supportCategoryStatuses!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'supportCategoryStatuses',
      field: PupilData.t.id,
      foreignField: _i20.SupportCategoryStatus.t
          .$_pupilDataSupportcategorystatusesPupilDataId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i20.SupportCategoryStatusTable(tableRelation: foreignTableRelation),
    );
    _supportCategoryStatuses =
        _i1.ManyRelation<_i20.SupportCategoryStatusTable>(
      tableWithRelations: relationTable,
      table: _i20.SupportCategoryStatusTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _supportCategoryStatuses!;
  }

  _i1.ManyRelation<_i21.SupportGoalTable> get supportGoals {
    if (_supportGoals != null) return _supportGoals!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'supportGoals',
      field: PupilData.t.id,
      foreignField: _i21.SupportGoal.t.$_pupilDataSupportgoalsPupilDataId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i21.SupportGoalTable(tableRelation: foreignTableRelation),
    );
    _supportGoals = _i1.ManyRelation<_i21.SupportGoalTable>(
      tableWithRelations: relationTable,
      table: _i21.SupportGoalTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _supportGoals!;
  }

  _i1.ManyRelation<_i22.MissedClassTable> get missedClasses {
    if (_missedClasses != null) return _missedClasses!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'missedClasses',
      field: PupilData.t.id,
      foreignField: _i22.MissedClass.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i22.MissedClassTable(tableRelation: foreignTableRelation),
    );
    _missedClasses = _i1.ManyRelation<_i22.MissedClassTable>(
      tableWithRelations: relationTable,
      table: _i22.MissedClassTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _missedClasses!;
  }

  _i1.ManyRelation<_i23.SchooldayEventTable> get schooldayEvents {
    if (_schooldayEvents != null) return _schooldayEvents!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'schooldayEvents',
      field: PupilData.t.id,
      foreignField: _i23.SchooldayEvent.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i23.SchooldayEventTable(tableRelation: foreignTableRelation),
    );
    _schooldayEvents = _i1.ManyRelation<_i23.SchooldayEventTable>(
      tableWithRelations: relationTable,
      table: _i23.SchooldayEventTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _schooldayEvents!;
  }

  _i1.ManyRelation<_i24.PupilListEntryTable> get pupilListEntries {
    if (_pupilListEntries != null) return _pupilListEntries!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'pupilListEntries',
      field: PupilData.t.id,
      foreignField: _i24.PupilListEntry.t.pupilId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i24.PupilListEntryTable(tableRelation: foreignTableRelation),
    );
    _pupilListEntries = _i1.ManyRelation<_i24.PupilListEntryTable>(
      tableWithRelations: relationTable,
      table: _i24.PupilListEntryTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _pupilListEntries!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        active,
        internalId,
        preSchoolMedicalId,
        kindergarden,
        preSchoolTestId,
        avatarId,
        avatarAuthId,
        publicMediaAuth,
        publicMediaAuthDocumentId,
        contact,
        communicationPupil,
        specialInformation,
        tutorInfo,
        afterSchoolCare,
        credit,
        creditEarned,
        schoolyearHeldBackAt,
        swimmer,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'preSchoolMedical') {
      return preSchoolMedical;
    }
    if (relationField == 'preSchoolTest') {
      return preSchoolTest;
    }
    if (relationField == 'avatar') {
      return avatar;
    }
    if (relationField == 'avatarAuth') {
      return avatarAuth;
    }
    if (relationField == 'publicMediaAuthDocument') {
      return publicMediaAuthDocument;
    }
    if (relationField == 'authorizations') {
      return __authorizations;
    }
    if (relationField == 'creditTransactions') {
      return __creditTransactions;
    }
    if (relationField == 'lessonGroupMemberships') {
      return __lessonGroupMemberships;
    }
    if (relationField == 'lessonsAttended') {
      return __lessonsAttended;
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
    if (relationField == 'pupilWorkbooks') {
      return __pupilWorkbooks;
    }
    if (relationField == 'pupilBookLendings') {
      return __pupilBookLendings;
    }
    if (relationField == 'supportLevelHistory') {
      return __supportLevelHistory;
    }
    if (relationField == 'supportCategoryStatuses') {
      return __supportCategoryStatuses;
    }
    if (relationField == 'supportGoals') {
      return __supportGoals;
    }
    if (relationField == 'missedClasses') {
      return __missedClasses;
    }
    if (relationField == 'schooldayEvents') {
      return __schooldayEvents;
    }
    if (relationField == 'pupilListEntries') {
      return __pupilListEntries;
    }
    return null;
  }
}

class PupilDataInclude extends _i1.IncludeObject {
  PupilDataInclude._({
    _i2.PreSchoolMedicalInclude? preSchoolMedical,
    _i3.PreSchoolTestInclude? preSchoolTest,
    _i4.HubDocumentInclude? avatar,
    _i4.HubDocumentInclude? avatarAuth,
    _i4.HubDocumentInclude? publicMediaAuthDocument,
    _i8.PupilAuthorizationIncludeList? authorizations,
    _i10.CreditTransactionIncludeList? creditTransactions,
    _i11.ScheduledLessonGroupMembershipIncludeList? lessonGroupMemberships,
    _i12.LessonAttendanceIncludeList? lessonsAttended,
    _i13.CompetenceGoalIncludeList? competenceGoals,
    _i14.CompetenceCheckIncludeList? competenceChecks,
    _i15.CompetenceReportIncludeList? competenceReports,
    _i16.CompetenceReportCheckIncludeList? competenceReportChecks,
    _i17.PupilWorkbookIncludeList? pupilWorkbooks,
    _i18.PupilBookLendingIncludeList? pupilBookLendings,
    _i19.SupportLevelIncludeList? supportLevelHistory,
    _i20.SupportCategoryStatusIncludeList? supportCategoryStatuses,
    _i21.SupportGoalIncludeList? supportGoals,
    _i22.MissedClassIncludeList? missedClasses,
    _i23.SchooldayEventIncludeList? schooldayEvents,
    _i24.PupilListEntryIncludeList? pupilListEntries,
  }) {
    _preSchoolMedical = preSchoolMedical;
    _preSchoolTest = preSchoolTest;
    _avatar = avatar;
    _avatarAuth = avatarAuth;
    _publicMediaAuthDocument = publicMediaAuthDocument;
    _authorizations = authorizations;
    _creditTransactions = creditTransactions;
    _lessonGroupMemberships = lessonGroupMemberships;
    _lessonsAttended = lessonsAttended;
    _competenceGoals = competenceGoals;
    _competenceChecks = competenceChecks;
    _competenceReports = competenceReports;
    _competenceReportChecks = competenceReportChecks;
    _pupilWorkbooks = pupilWorkbooks;
    _pupilBookLendings = pupilBookLendings;
    _supportLevelHistory = supportLevelHistory;
    _supportCategoryStatuses = supportCategoryStatuses;
    _supportGoals = supportGoals;
    _missedClasses = missedClasses;
    _schooldayEvents = schooldayEvents;
    _pupilListEntries = pupilListEntries;
  }

  _i2.PreSchoolMedicalInclude? _preSchoolMedical;

  _i3.PreSchoolTestInclude? _preSchoolTest;

  _i4.HubDocumentInclude? _avatar;

  _i4.HubDocumentInclude? _avatarAuth;

  _i4.HubDocumentInclude? _publicMediaAuthDocument;

  _i8.PupilAuthorizationIncludeList? _authorizations;

  _i10.CreditTransactionIncludeList? _creditTransactions;

  _i11.ScheduledLessonGroupMembershipIncludeList? _lessonGroupMemberships;

  _i12.LessonAttendanceIncludeList? _lessonsAttended;

  _i13.CompetenceGoalIncludeList? _competenceGoals;

  _i14.CompetenceCheckIncludeList? _competenceChecks;

  _i15.CompetenceReportIncludeList? _competenceReports;

  _i16.CompetenceReportCheckIncludeList? _competenceReportChecks;

  _i17.PupilWorkbookIncludeList? _pupilWorkbooks;

  _i18.PupilBookLendingIncludeList? _pupilBookLendings;

  _i19.SupportLevelIncludeList? _supportLevelHistory;

  _i20.SupportCategoryStatusIncludeList? _supportCategoryStatuses;

  _i21.SupportGoalIncludeList? _supportGoals;

  _i22.MissedClassIncludeList? _missedClasses;

  _i23.SchooldayEventIncludeList? _schooldayEvents;

  _i24.PupilListEntryIncludeList? _pupilListEntries;

  @override
  Map<String, _i1.Include?> get includes => {
        'preSchoolMedical': _preSchoolMedical,
        'preSchoolTest': _preSchoolTest,
        'avatar': _avatar,
        'avatarAuth': _avatarAuth,
        'publicMediaAuthDocument': _publicMediaAuthDocument,
        'authorizations': _authorizations,
        'creditTransactions': _creditTransactions,
        'lessonGroupMemberships': _lessonGroupMemberships,
        'lessonsAttended': _lessonsAttended,
        'competenceGoals': _competenceGoals,
        'competenceChecks': _competenceChecks,
        'competenceReports': _competenceReports,
        'competenceReportChecks': _competenceReportChecks,
        'pupilWorkbooks': _pupilWorkbooks,
        'pupilBookLendings': _pupilBookLendings,
        'supportLevelHistory': _supportLevelHistory,
        'supportCategoryStatuses': _supportCategoryStatuses,
        'supportGoals': _supportGoals,
        'missedClasses': _missedClasses,
        'schooldayEvents': _schooldayEvents,
        'pupilListEntries': _pupilListEntries,
      };

  @override
  _i1.Table<int?> get table => PupilData.t;
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
  _i1.Table<int?> get table => PupilData.t;
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
    List<_i8.PupilAuthorization> pupilAuthorization, {
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
    await session.db.update<_i8.PupilAuthorization>(
      $pupilAuthorization,
      columns: [_i8.PupilAuthorization.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [CreditTransaction]s
  /// by setting each [CreditTransaction]'s foreign key `_pupilDataCredittransactionsPupilDataId` to refer to this [PupilData].
  Future<void> creditTransactions(
    _i1.Session session,
    PupilData pupilData,
    List<_i10.CreditTransaction> creditTransaction, {
    _i1.Transaction? transaction,
  }) async {
    if (creditTransaction.any((e) => e.id == null)) {
      throw ArgumentError.notNull('creditTransaction.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $creditTransaction = creditTransaction
        .map((e) => _i10.CreditTransactionImplicit(
              e,
              $_pupilDataCredittransactionsPupilDataId: pupilData.id,
            ))
        .toList();
    await session.db.update<_i10.CreditTransaction>(
      $creditTransaction,
      columns: [
        _i10.CreditTransaction.t.$_pupilDataCredittransactionsPupilDataId
      ],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [ScheduledLessonGroupMembership]s
  /// by setting each [ScheduledLessonGroupMembership]'s foreign key `pupilDataId` to refer to this [PupilData].
  Future<void> lessonGroupMemberships(
    _i1.Session session,
    PupilData pupilData,
    List<_i11.ScheduledLessonGroupMembership> scheduledLessonGroupMembership, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLessonGroupMembership.any((e) => e.id == null)) {
      throw ArgumentError.notNull('scheduledLessonGroupMembership.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $scheduledLessonGroupMembership = scheduledLessonGroupMembership
        .map((e) => e.copyWith(pupilDataId: pupilData.id))
        .toList();
    await session.db.update<_i11.ScheduledLessonGroupMembership>(
      $scheduledLessonGroupMembership,
      columns: [_i11.ScheduledLessonGroupMembership.t.pupilDataId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [LessonAttendance]s
  /// by setting each [LessonAttendance]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> lessonsAttended(
    _i1.Session session,
    PupilData pupilData,
    List<_i12.LessonAttendance> lessonAttendance, {
    _i1.Transaction? transaction,
  }) async {
    if (lessonAttendance.any((e) => e.id == null)) {
      throw ArgumentError.notNull('lessonAttendance.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $lessonAttendance =
        lessonAttendance.map((e) => e.copyWith(pupilId: pupilData.id)).toList();
    await session.db.update<_i12.LessonAttendance>(
      $lessonAttendance,
      columns: [_i12.LessonAttendance.t.pupilId],
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

  /// Creates a relation between this [PupilData] and the given [PupilWorkbook]s
  /// by setting each [PupilWorkbook]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> pupilWorkbooks(
    _i1.Session session,
    PupilData pupilData,
    List<_i17.PupilWorkbook> pupilWorkbook, {
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
    await session.db.update<_i17.PupilWorkbook>(
      $pupilWorkbook,
      columns: [_i17.PupilWorkbook.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [PupilBookLending]s
  /// by setting each [PupilBookLending]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> pupilBookLendings(
    _i1.Session session,
    PupilData pupilData,
    List<_i18.PupilBookLending> pupilBookLending, {
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
    await session.db.update<_i18.PupilBookLending>(
      $pupilBookLending,
      columns: [_i18.PupilBookLending.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [SupportLevel]s
  /// by setting each [SupportLevel]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> supportLevelHistory(
    _i1.Session session,
    PupilData pupilData,
    List<_i19.SupportLevel> supportLevel, {
    _i1.Transaction? transaction,
  }) async {
    if (supportLevel.any((e) => e.id == null)) {
      throw ArgumentError.notNull('supportLevel.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $supportLevel =
        supportLevel.map((e) => e.copyWith(pupilId: pupilData.id)).toList();
    await session.db.update<_i19.SupportLevel>(
      $supportLevel,
      columns: [_i19.SupportLevel.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [SupportCategoryStatus]s
  /// by setting each [SupportCategoryStatus]'s foreign key `_pupilDataSupportcategorystatusesPupilDataId` to refer to this [PupilData].
  Future<void> supportCategoryStatuses(
    _i1.Session session,
    PupilData pupilData,
    List<_i20.SupportCategoryStatus> supportCategoryStatus, {
    _i1.Transaction? transaction,
  }) async {
    if (supportCategoryStatus.any((e) => e.id == null)) {
      throw ArgumentError.notNull('supportCategoryStatus.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $supportCategoryStatus = supportCategoryStatus
        .map((e) => _i20.SupportCategoryStatusImplicit(
              e,
              $_pupilDataSupportcategorystatusesPupilDataId: pupilData.id,
            ))
        .toList();
    await session.db.update<_i20.SupportCategoryStatus>(
      $supportCategoryStatus,
      columns: [
        _i20.SupportCategoryStatus.t
            .$_pupilDataSupportcategorystatusesPupilDataId
      ],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [SupportGoal]s
  /// by setting each [SupportGoal]'s foreign key `_pupilDataSupportgoalsPupilDataId` to refer to this [PupilData].
  Future<void> supportGoals(
    _i1.Session session,
    PupilData pupilData,
    List<_i21.SupportGoal> supportGoal, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoal.any((e) => e.id == null)) {
      throw ArgumentError.notNull('supportGoal.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $supportGoal = supportGoal
        .map((e) => _i21.SupportGoalImplicit(
              e,
              $_pupilDataSupportgoalsPupilDataId: pupilData.id,
            ))
        .toList();
    await session.db.update<_i21.SupportGoal>(
      $supportGoal,
      columns: [_i21.SupportGoal.t.$_pupilDataSupportgoalsPupilDataId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [MissedClass]s
  /// by setting each [MissedClass]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> missedClasses(
    _i1.Session session,
    PupilData pupilData,
    List<_i22.MissedClass> missedClass, {
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
    await session.db.update<_i22.MissedClass>(
      $missedClass,
      columns: [_i22.MissedClass.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [SchooldayEvent]s
  /// by setting each [SchooldayEvent]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> schooldayEvents(
    _i1.Session session,
    PupilData pupilData,
    List<_i23.SchooldayEvent> schooldayEvent, {
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
    await session.db.update<_i23.SchooldayEvent>(
      $schooldayEvent,
      columns: [_i23.SchooldayEvent.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [PupilListEntry]s
  /// by setting each [PupilListEntry]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> pupilListEntries(
    _i1.Session session,
    PupilData pupilData,
    List<_i24.PupilListEntry> pupilListEntry, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilListEntry.any((e) => e.id == null)) {
      throw ArgumentError.notNull('pupilListEntry.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $pupilListEntry =
        pupilListEntry.map((e) => e.copyWith(pupilId: pupilData.id)).toList();
    await session.db.update<_i24.PupilListEntry>(
      $pupilListEntry,
      columns: [_i24.PupilListEntry.t.pupilId],
      transaction: transaction,
    );
  }
}

class PupilDataAttachRowRepository {
  const PupilDataAttachRowRepository._();

  /// Creates a relation between the given [PupilData] and [PreSchoolMedical]
  /// by setting the [PupilData]'s foreign key `preSchoolMedicalId` to refer to the [PreSchoolMedical].
  Future<void> preSchoolMedical(
    _i1.Session session,
    PupilData pupilData,
    _i2.PreSchoolMedical preSchoolMedical, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }
    if (preSchoolMedical.id == null) {
      throw ArgumentError.notNull('preSchoolMedical.id');
    }

    var $pupilData =
        pupilData.copyWith(preSchoolMedicalId: preSchoolMedical.id);
    await session.db.updateRow<PupilData>(
      $pupilData,
      columns: [PupilData.t.preSchoolMedicalId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [PupilData] and [PreSchoolTest]
  /// by setting the [PupilData]'s foreign key `preSchoolTestId` to refer to the [PreSchoolTest].
  Future<void> preSchoolTest(
    _i1.Session session,
    PupilData pupilData,
    _i3.PreSchoolTest preSchoolTest, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }
    if (preSchoolTest.id == null) {
      throw ArgumentError.notNull('preSchoolTest.id');
    }

    var $pupilData = pupilData.copyWith(preSchoolTestId: preSchoolTest.id);
    await session.db.updateRow<PupilData>(
      $pupilData,
      columns: [PupilData.t.preSchoolTestId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [PupilData] and [HubDocument]
  /// by setting the [PupilData]'s foreign key `avatarId` to refer to the [HubDocument].
  Future<void> avatar(
    _i1.Session session,
    PupilData pupilData,
    _i4.HubDocument avatar, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }
    if (avatar.id == null) {
      throw ArgumentError.notNull('avatar.id');
    }

    var $pupilData = pupilData.copyWith(avatarId: avatar.id);
    await session.db.updateRow<PupilData>(
      $pupilData,
      columns: [PupilData.t.avatarId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [PupilData] and [HubDocument]
  /// by setting the [PupilData]'s foreign key `avatarAuthId` to refer to the [HubDocument].
  Future<void> avatarAuth(
    _i1.Session session,
    PupilData pupilData,
    _i4.HubDocument avatarAuth, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }
    if (avatarAuth.id == null) {
      throw ArgumentError.notNull('avatarAuth.id');
    }

    var $pupilData = pupilData.copyWith(avatarAuthId: avatarAuth.id);
    await session.db.updateRow<PupilData>(
      $pupilData,
      columns: [PupilData.t.avatarAuthId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [PupilData] and [HubDocument]
  /// by setting the [PupilData]'s foreign key `publicMediaAuthDocumentId` to refer to the [HubDocument].
  Future<void> publicMediaAuthDocument(
    _i1.Session session,
    PupilData pupilData,
    _i4.HubDocument publicMediaAuthDocument, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }
    if (publicMediaAuthDocument.id == null) {
      throw ArgumentError.notNull('publicMediaAuthDocument.id');
    }

    var $pupilData = pupilData.copyWith(
        publicMediaAuthDocumentId: publicMediaAuthDocument.id);
    await session.db.updateRow<PupilData>(
      $pupilData,
      columns: [PupilData.t.publicMediaAuthDocumentId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [PupilAuthorization]
  /// by setting the [PupilAuthorization]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> authorizations(
    _i1.Session session,
    PupilData pupilData,
    _i8.PupilAuthorization pupilAuthorization, {
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
    await session.db.updateRow<_i8.PupilAuthorization>(
      $pupilAuthorization,
      columns: [_i8.PupilAuthorization.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [CreditTransaction]
  /// by setting the [CreditTransaction]'s foreign key `_pupilDataCredittransactionsPupilDataId` to refer to this [PupilData].
  Future<void> creditTransactions(
    _i1.Session session,
    PupilData pupilData,
    _i10.CreditTransaction creditTransaction, {
    _i1.Transaction? transaction,
  }) async {
    if (creditTransaction.id == null) {
      throw ArgumentError.notNull('creditTransaction.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $creditTransaction = _i10.CreditTransactionImplicit(
      creditTransaction,
      $_pupilDataCredittransactionsPupilDataId: pupilData.id,
    );
    await session.db.updateRow<_i10.CreditTransaction>(
      $creditTransaction,
      columns: [
        _i10.CreditTransaction.t.$_pupilDataCredittransactionsPupilDataId
      ],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [ScheduledLessonGroupMembership]
  /// by setting the [ScheduledLessonGroupMembership]'s foreign key `pupilDataId` to refer to this [PupilData].
  Future<void> lessonGroupMemberships(
    _i1.Session session,
    PupilData pupilData,
    _i11.ScheduledLessonGroupMembership scheduledLessonGroupMembership, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLessonGroupMembership.id == null) {
      throw ArgumentError.notNull('scheduledLessonGroupMembership.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $scheduledLessonGroupMembership =
        scheduledLessonGroupMembership.copyWith(pupilDataId: pupilData.id);
    await session.db.updateRow<_i11.ScheduledLessonGroupMembership>(
      $scheduledLessonGroupMembership,
      columns: [_i11.ScheduledLessonGroupMembership.t.pupilDataId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [LessonAttendance]
  /// by setting the [LessonAttendance]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> lessonsAttended(
    _i1.Session session,
    PupilData pupilData,
    _i12.LessonAttendance lessonAttendance, {
    _i1.Transaction? transaction,
  }) async {
    if (lessonAttendance.id == null) {
      throw ArgumentError.notNull('lessonAttendance.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $lessonAttendance = lessonAttendance.copyWith(pupilId: pupilData.id);
    await session.db.updateRow<_i12.LessonAttendance>(
      $lessonAttendance,
      columns: [_i12.LessonAttendance.t.pupilId],
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

  /// Creates a relation between this [PupilData] and the given [PupilWorkbook]
  /// by setting the [PupilWorkbook]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> pupilWorkbooks(
    _i1.Session session,
    PupilData pupilData,
    _i17.PupilWorkbook pupilWorkbook, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilWorkbook.id == null) {
      throw ArgumentError.notNull('pupilWorkbook.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $pupilWorkbook = pupilWorkbook.copyWith(pupilId: pupilData.id);
    await session.db.updateRow<_i17.PupilWorkbook>(
      $pupilWorkbook,
      columns: [_i17.PupilWorkbook.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [PupilBookLending]
  /// by setting the [PupilBookLending]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> pupilBookLendings(
    _i1.Session session,
    PupilData pupilData,
    _i18.PupilBookLending pupilBookLending, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilBookLending.id == null) {
      throw ArgumentError.notNull('pupilBookLending.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $pupilBookLending = pupilBookLending.copyWith(pupilId: pupilData.id);
    await session.db.updateRow<_i18.PupilBookLending>(
      $pupilBookLending,
      columns: [_i18.PupilBookLending.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [SupportLevel]
  /// by setting the [SupportLevel]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> supportLevelHistory(
    _i1.Session session,
    PupilData pupilData,
    _i19.SupportLevel supportLevel, {
    _i1.Transaction? transaction,
  }) async {
    if (supportLevel.id == null) {
      throw ArgumentError.notNull('supportLevel.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $supportLevel = supportLevel.copyWith(pupilId: pupilData.id);
    await session.db.updateRow<_i19.SupportLevel>(
      $supportLevel,
      columns: [_i19.SupportLevel.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [SupportCategoryStatus]
  /// by setting the [SupportCategoryStatus]'s foreign key `_pupilDataSupportcategorystatusesPupilDataId` to refer to this [PupilData].
  Future<void> supportCategoryStatuses(
    _i1.Session session,
    PupilData pupilData,
    _i20.SupportCategoryStatus supportCategoryStatus, {
    _i1.Transaction? transaction,
  }) async {
    if (supportCategoryStatus.id == null) {
      throw ArgumentError.notNull('supportCategoryStatus.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $supportCategoryStatus = _i20.SupportCategoryStatusImplicit(
      supportCategoryStatus,
      $_pupilDataSupportcategorystatusesPupilDataId: pupilData.id,
    );
    await session.db.updateRow<_i20.SupportCategoryStatus>(
      $supportCategoryStatus,
      columns: [
        _i20.SupportCategoryStatus.t
            .$_pupilDataSupportcategorystatusesPupilDataId
      ],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [SupportGoal]
  /// by setting the [SupportGoal]'s foreign key `_pupilDataSupportgoalsPupilDataId` to refer to this [PupilData].
  Future<void> supportGoals(
    _i1.Session session,
    PupilData pupilData,
    _i21.SupportGoal supportGoal, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoal.id == null) {
      throw ArgumentError.notNull('supportGoal.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $supportGoal = _i21.SupportGoalImplicit(
      supportGoal,
      $_pupilDataSupportgoalsPupilDataId: pupilData.id,
    );
    await session.db.updateRow<_i21.SupportGoal>(
      $supportGoal,
      columns: [_i21.SupportGoal.t.$_pupilDataSupportgoalsPupilDataId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [MissedClass]
  /// by setting the [MissedClass]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> missedClasses(
    _i1.Session session,
    PupilData pupilData,
    _i22.MissedClass missedClass, {
    _i1.Transaction? transaction,
  }) async {
    if (missedClass.id == null) {
      throw ArgumentError.notNull('missedClass.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $missedClass = missedClass.copyWith(pupilId: pupilData.id);
    await session.db.updateRow<_i22.MissedClass>(
      $missedClass,
      columns: [_i22.MissedClass.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [SchooldayEvent]
  /// by setting the [SchooldayEvent]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> schooldayEvents(
    _i1.Session session,
    PupilData pupilData,
    _i23.SchooldayEvent schooldayEvent, {
    _i1.Transaction? transaction,
  }) async {
    if (schooldayEvent.id == null) {
      throw ArgumentError.notNull('schooldayEvent.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $schooldayEvent = schooldayEvent.copyWith(pupilId: pupilData.id);
    await session.db.updateRow<_i23.SchooldayEvent>(
      $schooldayEvent,
      columns: [_i23.SchooldayEvent.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilData] and the given [PupilListEntry]
  /// by setting the [PupilListEntry]'s foreign key `pupilId` to refer to this [PupilData].
  Future<void> pupilListEntries(
    _i1.Session session,
    PupilData pupilData,
    _i24.PupilListEntry pupilListEntry, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilListEntry.id == null) {
      throw ArgumentError.notNull('pupilListEntry.id');
    }
    if (pupilData.id == null) {
      throw ArgumentError.notNull('pupilData.id');
    }

    var $pupilListEntry = pupilListEntry.copyWith(pupilId: pupilData.id);
    await session.db.updateRow<_i24.PupilListEntry>(
      $pupilListEntry,
      columns: [_i24.PupilListEntry.t.pupilId],
      transaction: transaction,
    );
  }
}

class PupilDataDetachRepository {
  const PupilDataDetachRepository._();

  /// Detaches the relation between this [PupilData] and the given [CreditTransaction]
  /// by setting the [CreditTransaction]'s foreign key `_pupilDataCredittransactionsPupilDataId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> creditTransactions(
    _i1.Session session,
    List<_i10.CreditTransaction> creditTransaction, {
    _i1.Transaction? transaction,
  }) async {
    if (creditTransaction.any((e) => e.id == null)) {
      throw ArgumentError.notNull('creditTransaction.id');
    }

    var $creditTransaction = creditTransaction
        .map((e) => _i10.CreditTransactionImplicit(
              e,
              $_pupilDataCredittransactionsPupilDataId: null,
            ))
        .toList();
    await session.db.update<_i10.CreditTransaction>(
      $creditTransaction,
      columns: [
        _i10.CreditTransaction.t.$_pupilDataCredittransactionsPupilDataId
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
    List<_i17.PupilWorkbook> pupilWorkbook, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilWorkbook.any((e) => e.id == null)) {
      throw ArgumentError.notNull('pupilWorkbook.id');
    }

    var $pupilWorkbook =
        pupilWorkbook.map((e) => e.copyWith(pupilId: null)).toList();
    await session.db.update<_i17.PupilWorkbook>(
      $pupilWorkbook,
      columns: [_i17.PupilWorkbook.t.pupilId],
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
    List<_i20.SupportCategoryStatus> supportCategoryStatus, {
    _i1.Transaction? transaction,
  }) async {
    if (supportCategoryStatus.any((e) => e.id == null)) {
      throw ArgumentError.notNull('supportCategoryStatus.id');
    }

    var $supportCategoryStatus = supportCategoryStatus
        .map((e) => _i20.SupportCategoryStatusImplicit(
              e,
              $_pupilDataSupportcategorystatusesPupilDataId: null,
            ))
        .toList();
    await session.db.update<_i20.SupportCategoryStatus>(
      $supportCategoryStatus,
      columns: [
        _i20.SupportCategoryStatus.t
            .$_pupilDataSupportcategorystatusesPupilDataId
      ],
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
    List<_i21.SupportGoal> supportGoal, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoal.any((e) => e.id == null)) {
      throw ArgumentError.notNull('supportGoal.id');
    }

    var $supportGoal = supportGoal
        .map((e) => _i21.SupportGoalImplicit(
              e,
              $_pupilDataSupportgoalsPupilDataId: null,
            ))
        .toList();
    await session.db.update<_i21.SupportGoal>(
      $supportGoal,
      columns: [_i21.SupportGoal.t.$_pupilDataSupportgoalsPupilDataId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilData] and the given [MissedClass]
  /// by setting the [MissedClass]'s foreign key `pupilId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> missedClasses(
    _i1.Session session,
    List<_i22.MissedClass> missedClass, {
    _i1.Transaction? transaction,
  }) async {
    if (missedClass.any((e) => e.id == null)) {
      throw ArgumentError.notNull('missedClass.id');
    }

    var $missedClass =
        missedClass.map((e) => e.copyWith(pupilId: null)).toList();
    await session.db.update<_i22.MissedClass>(
      $missedClass,
      columns: [_i22.MissedClass.t.pupilId],
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
    List<_i23.SchooldayEvent> schooldayEvent, {
    _i1.Transaction? transaction,
  }) async {
    if (schooldayEvent.any((e) => e.id == null)) {
      throw ArgumentError.notNull('schooldayEvent.id');
    }

    var $schooldayEvent =
        schooldayEvent.map((e) => e.copyWith(pupilId: null)).toList();
    await session.db.update<_i23.SchooldayEvent>(
      $schooldayEvent,
      columns: [_i23.SchooldayEvent.t.pupilId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilData] and the given [PupilListEntry]
  /// by setting the [PupilListEntry]'s foreign key `pupilId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> pupilListEntries(
    _i1.Session session,
    List<_i24.PupilListEntry> pupilListEntry, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilListEntry.any((e) => e.id == null)) {
      throw ArgumentError.notNull('pupilListEntry.id');
    }

    var $pupilListEntry =
        pupilListEntry.map((e) => e.copyWith(pupilId: null)).toList();
    await session.db.update<_i24.PupilListEntry>(
      $pupilListEntry,
      columns: [_i24.PupilListEntry.t.pupilId],
      transaction: transaction,
    );
  }
}

class PupilDataDetachRowRepository {
  const PupilDataDetachRowRepository._();

  /// Detaches the relation between this [PupilData] and the [PreSchoolMedical] set in `preSchoolMedical`
  /// by setting the [PupilData]'s foreign key `preSchoolMedicalId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> preSchoolMedical(
    _i1.Session session,
    PupilData pupildata, {
    _i1.Transaction? transaction,
  }) async {
    if (pupildata.id == null) {
      throw ArgumentError.notNull('pupildata.id');
    }

    var $pupildata = pupildata.copyWith(preSchoolMedicalId: null);
    await session.db.updateRow<PupilData>(
      $pupildata,
      columns: [PupilData.t.preSchoolMedicalId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilData] and the [PreSchoolTest] set in `preSchoolTest`
  /// by setting the [PupilData]'s foreign key `preSchoolTestId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> preSchoolTest(
    _i1.Session session,
    PupilData pupildata, {
    _i1.Transaction? transaction,
  }) async {
    if (pupildata.id == null) {
      throw ArgumentError.notNull('pupildata.id');
    }

    var $pupildata = pupildata.copyWith(preSchoolTestId: null);
    await session.db.updateRow<PupilData>(
      $pupildata,
      columns: [PupilData.t.preSchoolTestId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilData] and the [HubDocument] set in `avatar`
  /// by setting the [PupilData]'s foreign key `avatarId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> avatar(
    _i1.Session session,
    PupilData pupildata, {
    _i1.Transaction? transaction,
  }) async {
    if (pupildata.id == null) {
      throw ArgumentError.notNull('pupildata.id');
    }

    var $pupildata = pupildata.copyWith(avatarId: null);
    await session.db.updateRow<PupilData>(
      $pupildata,
      columns: [PupilData.t.avatarId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilData] and the [HubDocument] set in `avatarAuth`
  /// by setting the [PupilData]'s foreign key `avatarAuthId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> avatarAuth(
    _i1.Session session,
    PupilData pupildata, {
    _i1.Transaction? transaction,
  }) async {
    if (pupildata.id == null) {
      throw ArgumentError.notNull('pupildata.id');
    }

    var $pupildata = pupildata.copyWith(avatarAuthId: null);
    await session.db.updateRow<PupilData>(
      $pupildata,
      columns: [PupilData.t.avatarAuthId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilData] and the [HubDocument] set in `publicMediaAuthDocument`
  /// by setting the [PupilData]'s foreign key `publicMediaAuthDocumentId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> publicMediaAuthDocument(
    _i1.Session session,
    PupilData pupildata, {
    _i1.Transaction? transaction,
  }) async {
    if (pupildata.id == null) {
      throw ArgumentError.notNull('pupildata.id');
    }

    var $pupildata = pupildata.copyWith(publicMediaAuthDocumentId: null);
    await session.db.updateRow<PupilData>(
      $pupildata,
      columns: [PupilData.t.publicMediaAuthDocumentId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilData] and the given [CreditTransaction]
  /// by setting the [CreditTransaction]'s foreign key `_pupilDataCredittransactionsPupilDataId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> creditTransactions(
    _i1.Session session,
    _i10.CreditTransaction creditTransaction, {
    _i1.Transaction? transaction,
  }) async {
    if (creditTransaction.id == null) {
      throw ArgumentError.notNull('creditTransaction.id');
    }

    var $creditTransaction = _i10.CreditTransactionImplicit(
      creditTransaction,
      $_pupilDataCredittransactionsPupilDataId: null,
    );
    await session.db.updateRow<_i10.CreditTransaction>(
      $creditTransaction,
      columns: [
        _i10.CreditTransaction.t.$_pupilDataCredittransactionsPupilDataId
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
    _i17.PupilWorkbook pupilWorkbook, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilWorkbook.id == null) {
      throw ArgumentError.notNull('pupilWorkbook.id');
    }

    var $pupilWorkbook = pupilWorkbook.copyWith(pupilId: null);
    await session.db.updateRow<_i17.PupilWorkbook>(
      $pupilWorkbook,
      columns: [_i17.PupilWorkbook.t.pupilId],
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
    _i20.SupportCategoryStatus supportCategoryStatus, {
    _i1.Transaction? transaction,
  }) async {
    if (supportCategoryStatus.id == null) {
      throw ArgumentError.notNull('supportCategoryStatus.id');
    }

    var $supportCategoryStatus = _i20.SupportCategoryStatusImplicit(
      supportCategoryStatus,
      $_pupilDataSupportcategorystatusesPupilDataId: null,
    );
    await session.db.updateRow<_i20.SupportCategoryStatus>(
      $supportCategoryStatus,
      columns: [
        _i20.SupportCategoryStatus.t
            .$_pupilDataSupportcategorystatusesPupilDataId
      ],
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
    _i21.SupportGoal supportGoal, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoal.id == null) {
      throw ArgumentError.notNull('supportGoal.id');
    }

    var $supportGoal = _i21.SupportGoalImplicit(
      supportGoal,
      $_pupilDataSupportgoalsPupilDataId: null,
    );
    await session.db.updateRow<_i21.SupportGoal>(
      $supportGoal,
      columns: [_i21.SupportGoal.t.$_pupilDataSupportgoalsPupilDataId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilData] and the given [MissedClass]
  /// by setting the [MissedClass]'s foreign key `pupilId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> missedClasses(
    _i1.Session session,
    _i22.MissedClass missedClass, {
    _i1.Transaction? transaction,
  }) async {
    if (missedClass.id == null) {
      throw ArgumentError.notNull('missedClass.id');
    }

    var $missedClass = missedClass.copyWith(pupilId: null);
    await session.db.updateRow<_i22.MissedClass>(
      $missedClass,
      columns: [_i22.MissedClass.t.pupilId],
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
    _i23.SchooldayEvent schooldayEvent, {
    _i1.Transaction? transaction,
  }) async {
    if (schooldayEvent.id == null) {
      throw ArgumentError.notNull('schooldayEvent.id');
    }

    var $schooldayEvent = schooldayEvent.copyWith(pupilId: null);
    await session.db.updateRow<_i23.SchooldayEvent>(
      $schooldayEvent,
      columns: [_i23.SchooldayEvent.t.pupilId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PupilData] and the given [PupilListEntry]
  /// by setting the [PupilListEntry]'s foreign key `pupilId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> pupilListEntries(
    _i1.Session session,
    _i24.PupilListEntry pupilListEntry, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilListEntry.id == null) {
      throw ArgumentError.notNull('pupilListEntry.id');
    }

    var $pupilListEntry = pupilListEntry.copyWith(pupilId: null);
    await session.db.updateRow<_i24.PupilListEntry>(
      $pupilListEntry,
      columns: [_i24.PupilListEntry.t.pupilId],
      transaction: transaction,
    );
  }
}

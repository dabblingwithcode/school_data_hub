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
import '../school_list/pupil_list.dart' as _i24;

/// Pupil class
abstract class PupilData implements _i1.SerializableModel {
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
    this.latestSupportLevel,
    this.supportLevelHistory,
    this.supportCategoryStatuses,
    this.supportGoals,
    this.missedClasses,
    this.schooldayEvents,
    this.swimmer,
    this.pupilLists,
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
    _i19.SupportLevel? latestSupportLevel,
    List<_i19.SupportLevel>? supportLevelHistory,
    List<_i20.SupportCategoryStatus>? supportCategoryStatuses,
    List<_i21.SupportGoal>? supportGoals,
    List<_i22.MissedClass>? missedClasses,
    List<_i23.SchooldayEvent>? schooldayEvents,
    String? swimmer,
    List<_i24.PupilList>? pupilLists,
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
      latestSupportLevel: jsonSerialization['latestSupportLevel'] == null
          ? null
          : _i19.SupportLevel.fromJson((jsonSerialization['latestSupportLevel']
              as Map<String, dynamic>)),
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
      pupilLists: (jsonSerialization['pupilLists'] as List?)
          ?.map((e) => _i24.PupilList.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  _i19.SupportLevel? latestSupportLevel;

  List<_i19.SupportLevel>? supportLevelHistory;

  List<_i20.SupportCategoryStatus>? supportCategoryStatuses;

  List<_i21.SupportGoal>? supportGoals;

  List<_i22.MissedClass>? missedClasses;

  List<_i23.SchooldayEvent>? schooldayEvents;

  String? swimmer;

  List<_i24.PupilList>? pupilLists;

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
    _i19.SupportLevel? latestSupportLevel,
    List<_i19.SupportLevel>? supportLevelHistory,
    List<_i20.SupportCategoryStatus>? supportCategoryStatuses,
    List<_i21.SupportGoal>? supportGoals,
    List<_i22.MissedClass>? missedClasses,
    List<_i23.SchooldayEvent>? schooldayEvents,
    String? swimmer,
    List<_i24.PupilList>? pupilLists,
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
      if (latestSupportLevel != null)
        'latestSupportLevel': latestSupportLevel?.toJson(),
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
    _i19.SupportLevel? latestSupportLevel,
    List<_i19.SupportLevel>? supportLevelHistory,
    List<_i20.SupportCategoryStatus>? supportCategoryStatuses,
    List<_i21.SupportGoal>? supportGoals,
    List<_i22.MissedClass>? missedClasses,
    List<_i23.SchooldayEvent>? schooldayEvents,
    String? swimmer,
    List<_i24.PupilList>? pupilLists,
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
          latestSupportLevel: latestSupportLevel,
          supportLevelHistory: supportLevelHistory,
          supportCategoryStatuses: supportCategoryStatuses,
          supportGoals: supportGoals,
          missedClasses: missedClasses,
          schooldayEvents: schooldayEvents,
          swimmer: swimmer,
          pupilLists: pupilLists,
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
    Object? latestSupportLevel = _Undefined,
    Object? supportLevelHistory = _Undefined,
    Object? supportCategoryStatuses = _Undefined,
    Object? supportGoals = _Undefined,
    Object? missedClasses = _Undefined,
    Object? schooldayEvents = _Undefined,
    Object? swimmer = _Undefined,
    Object? pupilLists = _Undefined,
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
      latestSupportLevel: latestSupportLevel is _i19.SupportLevel?
          ? latestSupportLevel
          : this.latestSupportLevel?.copyWith(),
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
      pupilLists: pupilLists is List<_i24.PupilList>?
          ? pupilLists
          : this.pupilLists?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

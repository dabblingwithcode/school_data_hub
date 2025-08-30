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
import '../../../../_features/pupil/models/pupil_data/pupil_status.dart' as _i2;
import '../../../../_features/pupil/models/pupil_data/preschool/pre_school_medical.dart'
    as _i3;
import '../../../../_features/pupil/models/pupil_data/preschool/kindergarden.dart'
    as _i4;
import '../../../../_features/pupil/models/pupil_data/preschool/kindergarden_info.dart'
    as _i5;
import '../../../../_features/pupil/models/pupil_data/preschool/pre_school_test.dart'
    as _i6;
import '../../../../_shared/models/hub_document.dart' as _i7;
import '../../../../_features/pupil/models/pupil_data/communication/public_media_auth.dart'
    as _i8;
import '../../../../_features/pupil/models/pupil_data/communication/communication_skills.dart'
    as _i9;
import '../../../../_features/pupil/models/pupil_data/communication/tutor_info.dart'
    as _i10;
import '../../../../_features/authorizations/models/pupil_authorization.dart'
    as _i11;
import '../../../../_features/pupil/models/pupil_data/after_school_care/after_school_care.dart'
    as _i12;
import '../../../../_features/pupil/models/pupil_data/credit_transaction.dart'
    as _i13;
import '../../../../_features/timetable/models/scheduled_lesson/lesson_group_membership.dart'
    as _i14;
import '../../../../_features/timetable/models/lesson/lesson_attendance.dart'
    as _i15;
import '../../../../_features/learning/models/competence_goal.dart' as _i16;
import '../../../../_features/learning/models/competence_check.dart' as _i17;
import '../../../../_features/learning/models/competence_report.dart' as _i18;
import '../../../../_features/learning/models/competence_report_check.dart'
    as _i19;
import '../../../../_features/workbooks/models/pupil_workbook.dart' as _i20;
import '../../../../_features/books/models/pupil_book_lending.dart' as _i21;
import '../../../../_features/learning_support/models/support_level.dart'
    as _i22;
import '../../../../_features/learning_support/models/support_category_status.dart'
    as _i23;
import '../../../../_features/learning_support/models/support_goal/support_goal.dart'
    as _i24;
import '../../../../_features/learning_support/models/learning_support_plan.dart'
    as _i25;
import '../../../../_features/attendance/models/missed_schoolday.dart' as _i26;
import '../../../../_features/schoolday_events/models/schoolday_event.dart'
    as _i27;
import '../../../../_features/school_lists/models/pupil_entry.dart' as _i28;

abstract class PupilData implements _i1.SerializableModel {
  PupilData._({
    this.id,
    required this.status,
    required this.internalId,
    this.preSchoolMedicalId,
    this.preSchoolMedical,
    this.kindergardenId,
    this.kindergarden,
    this.kindergardenData,
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
    this.learningSupportPlans,
    this.missedSchooldays,
    this.schooldayEvents,
    this.swimmer,
    this.pupilListEntries,
  });

  factory PupilData({
    int? id,
    required _i2.PupilStatus status,
    required int internalId,
    int? preSchoolMedicalId,
    _i3.PreSchoolMedical? preSchoolMedical,
    int? kindergardenId,
    _i4.Kindergarden? kindergarden,
    _i5.KindergardenInfo? kindergardenData,
    int? preSchoolTestId,
    _i6.PreSchoolTest? preSchoolTest,
    int? avatarId,
    _i7.HubDocument? avatar,
    int? avatarAuthId,
    _i7.HubDocument? avatarAuth,
    required _i8.PublicMediaAuth publicMediaAuth,
    int? publicMediaAuthDocumentId,
    _i7.HubDocument? publicMediaAuthDocument,
    String? contact,
    _i9.CommunicationSkills? communicationPupil,
    String? specialInformation,
    _i10.TutorInfo? tutorInfo,
    List<_i11.PupilAuthorization>? authorizations,
    _i12.AfterSchoolCare? afterSchoolCare,
    required int credit,
    required int creditEarned,
    List<_i13.CreditTransaction>? creditTransactions,
    List<_i14.ScheduledLessonGroupMembership>? lessonGroupMemberships,
    List<_i15.LessonAttendance>? lessonsAttended,
    List<_i16.CompetenceGoal>? competenceGoals,
    List<_i17.CompetenceCheck>? competenceChecks,
    List<_i18.CompetenceReport>? competenceReports,
    List<_i19.CompetenceReportCheck>? competenceReportChecks,
    List<_i20.PupilWorkbook>? pupilWorkbooks,
    List<_i21.PupilBookLending>? pupilBookLendings,
    DateTime? schoolyearHeldBackAt,
    List<_i22.SupportLevel>? supportLevelHistory,
    List<_i23.SupportCategoryStatus>? supportCategoryStatuses,
    List<_i24.SupportGoal>? supportGoals,
    List<_i25.LearningSupportPlan>? learningSupportPlans,
    List<_i26.MissedSchoolday>? missedSchooldays,
    List<_i27.SchooldayEvent>? schooldayEvents,
    String? swimmer,
    List<_i28.PupilListEntry>? pupilListEntries,
  }) = _PupilDataImpl;

  factory PupilData.fromJson(Map<String, dynamic> jsonSerialization) {
    return PupilData(
      id: jsonSerialization['id'] as int?,
      status: _i2.PupilStatus.fromJson((jsonSerialization['status'] as String)),
      internalId: jsonSerialization['internalId'] as int,
      preSchoolMedicalId: jsonSerialization['preSchoolMedicalId'] as int?,
      preSchoolMedical: jsonSerialization['preSchoolMedical'] == null
          ? null
          : _i3.PreSchoolMedical.fromJson(
              (jsonSerialization['preSchoolMedical'] as Map<String, dynamic>)),
      kindergardenId: jsonSerialization['kindergardenId'] as int?,
      kindergarden: jsonSerialization['kindergarden'] == null
          ? null
          : _i4.Kindergarden.fromJson(
              (jsonSerialization['kindergarden'] as Map<String, dynamic>)),
      kindergardenData: jsonSerialization['kindergardenData'] == null
          ? null
          : _i5.KindergardenInfo.fromJson(
              (jsonSerialization['kindergardenData'] as Map<String, dynamic>)),
      preSchoolTestId: jsonSerialization['preSchoolTestId'] as int?,
      preSchoolTest: jsonSerialization['preSchoolTest'] == null
          ? null
          : _i6.PreSchoolTest.fromJson(
              (jsonSerialization['preSchoolTest'] as Map<String, dynamic>)),
      avatarId: jsonSerialization['avatarId'] as int?,
      avatar: jsonSerialization['avatar'] == null
          ? null
          : _i7.HubDocument.fromJson(
              (jsonSerialization['avatar'] as Map<String, dynamic>)),
      avatarAuthId: jsonSerialization['avatarAuthId'] as int?,
      avatarAuth: jsonSerialization['avatarAuth'] == null
          ? null
          : _i7.HubDocument.fromJson(
              (jsonSerialization['avatarAuth'] as Map<String, dynamic>)),
      publicMediaAuth: _i8.PublicMediaAuth.fromJson(
          (jsonSerialization['publicMediaAuth'] as Map<String, dynamic>)),
      publicMediaAuthDocumentId:
          jsonSerialization['publicMediaAuthDocumentId'] as int?,
      publicMediaAuthDocument:
          jsonSerialization['publicMediaAuthDocument'] == null
              ? null
              : _i7.HubDocument.fromJson(
                  (jsonSerialization['publicMediaAuthDocument']
                      as Map<String, dynamic>)),
      contact: jsonSerialization['contact'] as String?,
      communicationPupil: jsonSerialization['communicationPupil'] == null
          ? null
          : _i9.CommunicationSkills.fromJson(
              (jsonSerialization['communicationPupil']
                  as Map<String, dynamic>)),
      specialInformation: jsonSerialization['specialInformation'] as String?,
      tutorInfo: jsonSerialization['tutorInfo'] == null
          ? null
          : _i10.TutorInfo.fromJson(
              (jsonSerialization['tutorInfo'] as Map<String, dynamic>)),
      authorizations: (jsonSerialization['authorizations'] as List?)
          ?.map((e) =>
              _i11.PupilAuthorization.fromJson((e as Map<String, dynamic>)))
          .toList(),
      afterSchoolCare: jsonSerialization['afterSchoolCare'] == null
          ? null
          : _i12.AfterSchoolCare.fromJson(
              (jsonSerialization['afterSchoolCare'] as Map<String, dynamic>)),
      credit: jsonSerialization['credit'] as int,
      creditEarned: jsonSerialization['creditEarned'] as int,
      creditTransactions: (jsonSerialization['creditTransactions'] as List?)
          ?.map((e) =>
              _i13.CreditTransaction.fromJson((e as Map<String, dynamic>)))
          .toList(),
      lessonGroupMemberships:
          (jsonSerialization['lessonGroupMemberships'] as List?)
              ?.map((e) => _i14.ScheduledLessonGroupMembership.fromJson(
                  (e as Map<String, dynamic>)))
              .toList(),
      lessonsAttended: (jsonSerialization['lessonsAttended'] as List?)
          ?.map((e) =>
              _i15.LessonAttendance.fromJson((e as Map<String, dynamic>)))
          .toList(),
      competenceGoals: (jsonSerialization['competenceGoals'] as List?)
          ?.map(
              (e) => _i16.CompetenceGoal.fromJson((e as Map<String, dynamic>)))
          .toList(),
      competenceChecks: (jsonSerialization['competenceChecks'] as List?)
          ?.map(
              (e) => _i17.CompetenceCheck.fromJson((e as Map<String, dynamic>)))
          .toList(),
      competenceReports: (jsonSerialization['competenceReports'] as List?)
          ?.map((e) =>
              _i18.CompetenceReport.fromJson((e as Map<String, dynamic>)))
          .toList(),
      competenceReportChecks: (jsonSerialization['competenceReportChecks']
              as List?)
          ?.map((e) =>
              _i19.CompetenceReportCheck.fromJson((e as Map<String, dynamic>)))
          .toList(),
      pupilWorkbooks: (jsonSerialization['pupilWorkbooks'] as List?)
          ?.map((e) => _i20.PupilWorkbook.fromJson((e as Map<String, dynamic>)))
          .toList(),
      pupilBookLendings: (jsonSerialization['pupilBookLendings'] as List?)
          ?.map((e) =>
              _i21.PupilBookLending.fromJson((e as Map<String, dynamic>)))
          .toList(),
      schoolyearHeldBackAt: jsonSerialization['schoolyearHeldBackAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['schoolyearHeldBackAt']),
      supportLevelHistory: (jsonSerialization['supportLevelHistory'] as List?)
          ?.map((e) => _i22.SupportLevel.fromJson((e as Map<String, dynamic>)))
          .toList(),
      supportCategoryStatuses: (jsonSerialization['supportCategoryStatuses']
              as List?)
          ?.map((e) =>
              _i23.SupportCategoryStatus.fromJson((e as Map<String, dynamic>)))
          .toList(),
      supportGoals: (jsonSerialization['supportGoals'] as List?)
          ?.map((e) => _i24.SupportGoal.fromJson((e as Map<String, dynamic>)))
          .toList(),
      learningSupportPlans: (jsonSerialization['learningSupportPlans'] as List?)
          ?.map((e) =>
              _i25.LearningSupportPlan.fromJson((e as Map<String, dynamic>)))
          .toList(),
      missedSchooldays: (jsonSerialization['missedSchooldays'] as List?)
          ?.map(
              (e) => _i26.MissedSchoolday.fromJson((e as Map<String, dynamic>)))
          .toList(),
      schooldayEvents: (jsonSerialization['schooldayEvents'] as List?)
          ?.map(
              (e) => _i27.SchooldayEvent.fromJson((e as Map<String, dynamic>)))
          .toList(),
      swimmer: jsonSerialization['swimmer'] as String?,
      pupilListEntries: (jsonSerialization['pupilListEntries'] as List?)
          ?.map(
              (e) => _i28.PupilListEntry.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i2.PupilStatus status;

  int internalId;

  int? preSchoolMedicalId;

  _i3.PreSchoolMedical? preSchoolMedical;

  int? kindergardenId;

  _i4.Kindergarden? kindergarden;

  _i5.KindergardenInfo? kindergardenData;

  int? preSchoolTestId;

  _i6.PreSchoolTest? preSchoolTest;

  int? avatarId;

  _i7.HubDocument? avatar;

  int? avatarAuthId;

  _i7.HubDocument? avatarAuth;

  _i8.PublicMediaAuth publicMediaAuth;

  int? publicMediaAuthDocumentId;

  _i7.HubDocument? publicMediaAuthDocument;

  String? contact;

  _i9.CommunicationSkills? communicationPupil;

  String? specialInformation;

  _i10.TutorInfo? tutorInfo;

  List<_i11.PupilAuthorization>? authorizations;

  _i12.AfterSchoolCare? afterSchoolCare;

  int credit;

  int creditEarned;

  List<_i13.CreditTransaction>? creditTransactions;

  List<_i14.ScheduledLessonGroupMembership>? lessonGroupMemberships;

  List<_i15.LessonAttendance>? lessonsAttended;

  List<_i16.CompetenceGoal>? competenceGoals;

  List<_i17.CompetenceCheck>? competenceChecks;

  List<_i18.CompetenceReport>? competenceReports;

  List<_i19.CompetenceReportCheck>? competenceReportChecks;

  List<_i20.PupilWorkbook>? pupilWorkbooks;

  List<_i21.PupilBookLending>? pupilBookLendings;

  DateTime? schoolyearHeldBackAt;

  List<_i22.SupportLevel>? supportLevelHistory;

  List<_i23.SupportCategoryStatus>? supportCategoryStatuses;

  List<_i24.SupportGoal>? supportGoals;

  List<_i25.LearningSupportPlan>? learningSupportPlans;

  List<_i26.MissedSchoolday>? missedSchooldays;

  List<_i27.SchooldayEvent>? schooldayEvents;

  String? swimmer;

  List<_i28.PupilListEntry>? pupilListEntries;

  /// Returns a shallow copy of this [PupilData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilData copyWith({
    int? id,
    _i2.PupilStatus? status,
    int? internalId,
    int? preSchoolMedicalId,
    _i3.PreSchoolMedical? preSchoolMedical,
    int? kindergardenId,
    _i4.Kindergarden? kindergarden,
    _i5.KindergardenInfo? kindergardenData,
    int? preSchoolTestId,
    _i6.PreSchoolTest? preSchoolTest,
    int? avatarId,
    _i7.HubDocument? avatar,
    int? avatarAuthId,
    _i7.HubDocument? avatarAuth,
    _i8.PublicMediaAuth? publicMediaAuth,
    int? publicMediaAuthDocumentId,
    _i7.HubDocument? publicMediaAuthDocument,
    String? contact,
    _i9.CommunicationSkills? communicationPupil,
    String? specialInformation,
    _i10.TutorInfo? tutorInfo,
    List<_i11.PupilAuthorization>? authorizations,
    _i12.AfterSchoolCare? afterSchoolCare,
    int? credit,
    int? creditEarned,
    List<_i13.CreditTransaction>? creditTransactions,
    List<_i14.ScheduledLessonGroupMembership>? lessonGroupMemberships,
    List<_i15.LessonAttendance>? lessonsAttended,
    List<_i16.CompetenceGoal>? competenceGoals,
    List<_i17.CompetenceCheck>? competenceChecks,
    List<_i18.CompetenceReport>? competenceReports,
    List<_i19.CompetenceReportCheck>? competenceReportChecks,
    List<_i20.PupilWorkbook>? pupilWorkbooks,
    List<_i21.PupilBookLending>? pupilBookLendings,
    DateTime? schoolyearHeldBackAt,
    List<_i22.SupportLevel>? supportLevelHistory,
    List<_i23.SupportCategoryStatus>? supportCategoryStatuses,
    List<_i24.SupportGoal>? supportGoals,
    List<_i25.LearningSupportPlan>? learningSupportPlans,
    List<_i26.MissedSchoolday>? missedSchooldays,
    List<_i27.SchooldayEvent>? schooldayEvents,
    String? swimmer,
    List<_i28.PupilListEntry>? pupilListEntries,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'status': status.toJson(),
      'internalId': internalId,
      if (preSchoolMedicalId != null) 'preSchoolMedicalId': preSchoolMedicalId,
      if (preSchoolMedical != null)
        'preSchoolMedical': preSchoolMedical?.toJson(),
      if (kindergardenId != null) 'kindergardenId': kindergardenId,
      if (kindergarden != null) 'kindergarden': kindergarden?.toJson(),
      if (kindergardenData != null)
        'kindergardenData': kindergardenData?.toJson(),
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
      if (learningSupportPlans != null)
        'learningSupportPlans':
            learningSupportPlans?.toJson(valueToJson: (v) => v.toJson()),
      if (missedSchooldays != null)
        'missedSchooldays':
            missedSchooldays?.toJson(valueToJson: (v) => v.toJson()),
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
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PupilDataImpl extends PupilData {
  _PupilDataImpl({
    int? id,
    required _i2.PupilStatus status,
    required int internalId,
    int? preSchoolMedicalId,
    _i3.PreSchoolMedical? preSchoolMedical,
    int? kindergardenId,
    _i4.Kindergarden? kindergarden,
    _i5.KindergardenInfo? kindergardenData,
    int? preSchoolTestId,
    _i6.PreSchoolTest? preSchoolTest,
    int? avatarId,
    _i7.HubDocument? avatar,
    int? avatarAuthId,
    _i7.HubDocument? avatarAuth,
    required _i8.PublicMediaAuth publicMediaAuth,
    int? publicMediaAuthDocumentId,
    _i7.HubDocument? publicMediaAuthDocument,
    String? contact,
    _i9.CommunicationSkills? communicationPupil,
    String? specialInformation,
    _i10.TutorInfo? tutorInfo,
    List<_i11.PupilAuthorization>? authorizations,
    _i12.AfterSchoolCare? afterSchoolCare,
    required int credit,
    required int creditEarned,
    List<_i13.CreditTransaction>? creditTransactions,
    List<_i14.ScheduledLessonGroupMembership>? lessonGroupMemberships,
    List<_i15.LessonAttendance>? lessonsAttended,
    List<_i16.CompetenceGoal>? competenceGoals,
    List<_i17.CompetenceCheck>? competenceChecks,
    List<_i18.CompetenceReport>? competenceReports,
    List<_i19.CompetenceReportCheck>? competenceReportChecks,
    List<_i20.PupilWorkbook>? pupilWorkbooks,
    List<_i21.PupilBookLending>? pupilBookLendings,
    DateTime? schoolyearHeldBackAt,
    List<_i22.SupportLevel>? supportLevelHistory,
    List<_i23.SupportCategoryStatus>? supportCategoryStatuses,
    List<_i24.SupportGoal>? supportGoals,
    List<_i25.LearningSupportPlan>? learningSupportPlans,
    List<_i26.MissedSchoolday>? missedSchooldays,
    List<_i27.SchooldayEvent>? schooldayEvents,
    String? swimmer,
    List<_i28.PupilListEntry>? pupilListEntries,
  }) : super._(
          id: id,
          status: status,
          internalId: internalId,
          preSchoolMedicalId: preSchoolMedicalId,
          preSchoolMedical: preSchoolMedical,
          kindergardenId: kindergardenId,
          kindergarden: kindergarden,
          kindergardenData: kindergardenData,
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
          learningSupportPlans: learningSupportPlans,
          missedSchooldays: missedSchooldays,
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
    _i2.PupilStatus? status,
    int? internalId,
    Object? preSchoolMedicalId = _Undefined,
    Object? preSchoolMedical = _Undefined,
    Object? kindergardenId = _Undefined,
    Object? kindergarden = _Undefined,
    Object? kindergardenData = _Undefined,
    Object? preSchoolTestId = _Undefined,
    Object? preSchoolTest = _Undefined,
    Object? avatarId = _Undefined,
    Object? avatar = _Undefined,
    Object? avatarAuthId = _Undefined,
    Object? avatarAuth = _Undefined,
    _i8.PublicMediaAuth? publicMediaAuth,
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
    Object? learningSupportPlans = _Undefined,
    Object? missedSchooldays = _Undefined,
    Object? schooldayEvents = _Undefined,
    Object? swimmer = _Undefined,
    Object? pupilListEntries = _Undefined,
  }) {
    return PupilData(
      id: id is int? ? id : this.id,
      status: status ?? this.status,
      internalId: internalId ?? this.internalId,
      preSchoolMedicalId: preSchoolMedicalId is int?
          ? preSchoolMedicalId
          : this.preSchoolMedicalId,
      preSchoolMedical: preSchoolMedical is _i3.PreSchoolMedical?
          ? preSchoolMedical
          : this.preSchoolMedical?.copyWith(),
      kindergardenId:
          kindergardenId is int? ? kindergardenId : this.kindergardenId,
      kindergarden: kindergarden is _i4.Kindergarden?
          ? kindergarden
          : this.kindergarden?.copyWith(),
      kindergardenData: kindergardenData is _i5.KindergardenInfo?
          ? kindergardenData
          : this.kindergardenData?.copyWith(),
      preSchoolTestId:
          preSchoolTestId is int? ? preSchoolTestId : this.preSchoolTestId,
      preSchoolTest: preSchoolTest is _i6.PreSchoolTest?
          ? preSchoolTest
          : this.preSchoolTest?.copyWith(),
      avatarId: avatarId is int? ? avatarId : this.avatarId,
      avatar: avatar is _i7.HubDocument? ? avatar : this.avatar?.copyWith(),
      avatarAuthId: avatarAuthId is int? ? avatarAuthId : this.avatarAuthId,
      avatarAuth: avatarAuth is _i7.HubDocument?
          ? avatarAuth
          : this.avatarAuth?.copyWith(),
      publicMediaAuth: publicMediaAuth ?? this.publicMediaAuth.copyWith(),
      publicMediaAuthDocumentId: publicMediaAuthDocumentId is int?
          ? publicMediaAuthDocumentId
          : this.publicMediaAuthDocumentId,
      publicMediaAuthDocument: publicMediaAuthDocument is _i7.HubDocument?
          ? publicMediaAuthDocument
          : this.publicMediaAuthDocument?.copyWith(),
      contact: contact is String? ? contact : this.contact,
      communicationPupil: communicationPupil is _i9.CommunicationSkills?
          ? communicationPupil
          : this.communicationPupil?.copyWith(),
      specialInformation: specialInformation is String?
          ? specialInformation
          : this.specialInformation,
      tutorInfo:
          tutorInfo is _i10.TutorInfo? ? tutorInfo : this.tutorInfo?.copyWith(),
      authorizations: authorizations is List<_i11.PupilAuthorization>?
          ? authorizations
          : this.authorizations?.map((e0) => e0.copyWith()).toList(),
      afterSchoolCare: afterSchoolCare is _i12.AfterSchoolCare?
          ? afterSchoolCare
          : this.afterSchoolCare?.copyWith(),
      credit: credit ?? this.credit,
      creditEarned: creditEarned ?? this.creditEarned,
      creditTransactions: creditTransactions is List<_i13.CreditTransaction>?
          ? creditTransactions
          : this.creditTransactions?.map((e0) => e0.copyWith()).toList(),
      lessonGroupMemberships: lessonGroupMemberships
              is List<_i14.ScheduledLessonGroupMembership>?
          ? lessonGroupMemberships
          : this.lessonGroupMemberships?.map((e0) => e0.copyWith()).toList(),
      lessonsAttended: lessonsAttended is List<_i15.LessonAttendance>?
          ? lessonsAttended
          : this.lessonsAttended?.map((e0) => e0.copyWith()).toList(),
      competenceGoals: competenceGoals is List<_i16.CompetenceGoal>?
          ? competenceGoals
          : this.competenceGoals?.map((e0) => e0.copyWith()).toList(),
      competenceChecks: competenceChecks is List<_i17.CompetenceCheck>?
          ? competenceChecks
          : this.competenceChecks?.map((e0) => e0.copyWith()).toList(),
      competenceReports: competenceReports is List<_i18.CompetenceReport>?
          ? competenceReports
          : this.competenceReports?.map((e0) => e0.copyWith()).toList(),
      competenceReportChecks: competenceReportChecks
              is List<_i19.CompetenceReportCheck>?
          ? competenceReportChecks
          : this.competenceReportChecks?.map((e0) => e0.copyWith()).toList(),
      pupilWorkbooks: pupilWorkbooks is List<_i20.PupilWorkbook>?
          ? pupilWorkbooks
          : this.pupilWorkbooks?.map((e0) => e0.copyWith()).toList(),
      pupilBookLendings: pupilBookLendings is List<_i21.PupilBookLending>?
          ? pupilBookLendings
          : this.pupilBookLendings?.map((e0) => e0.copyWith()).toList(),
      schoolyearHeldBackAt: schoolyearHeldBackAt is DateTime?
          ? schoolyearHeldBackAt
          : this.schoolyearHeldBackAt,
      supportLevelHistory: supportLevelHistory is List<_i22.SupportLevel>?
          ? supportLevelHistory
          : this.supportLevelHistory?.map((e0) => e0.copyWith()).toList(),
      supportCategoryStatuses: supportCategoryStatuses
              is List<_i23.SupportCategoryStatus>?
          ? supportCategoryStatuses
          : this.supportCategoryStatuses?.map((e0) => e0.copyWith()).toList(),
      supportGoals: supportGoals is List<_i24.SupportGoal>?
          ? supportGoals
          : this.supportGoals?.map((e0) => e0.copyWith()).toList(),
      learningSupportPlans:
          learningSupportPlans is List<_i25.LearningSupportPlan>?
              ? learningSupportPlans
              : this.learningSupportPlans?.map((e0) => e0.copyWith()).toList(),
      missedSchooldays: missedSchooldays is List<_i26.MissedSchoolday>?
          ? missedSchooldays
          : this.missedSchooldays?.map((e0) => e0.copyWith()).toList(),
      schooldayEvents: schooldayEvents is List<_i27.SchooldayEvent>?
          ? schooldayEvents
          : this.schooldayEvents?.map((e0) => e0.copyWith()).toList(),
      swimmer: swimmer is String? ? swimmer : this.swimmer,
      pupilListEntries: pupilListEntries is List<_i28.PupilListEntry>?
          ? pupilListEntries
          : this.pupilListEntries?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

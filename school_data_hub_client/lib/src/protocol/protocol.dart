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
import '_features/attendance/models/contacted_type.dart' as _i2;
import '_features/attendance/models/missed_class.dart' as _i3;
import '_features/attendance/models/missed_class_dto.dart' as _i4;
import '_features/attendance/models/missed_type.dart' as _i5;
import '_features/authorizations/models/authorization.dart' as _i6;
import '_features/authorizations/models/pupil_authorization.dart' as _i7;
import '_features/books/models/book.dart' as _i8;
import '_features/books/models/book_tagging/book_tag.dart' as _i9;
import '_features/books/models/book_tagging/book_tagging.dart' as _i10;
import '_features/books/models/library_book.dart' as _i11;
import '_features/books/models/library_book_location.dart' as _i12;
import '_features/books/models/library_book_query.dart' as _i13;
import '_features/books/models/pupil_book_lending.dart' as _i14;
import '_features/learning/models/competence.dart' as _i15;
import '_features/learning/models/competence_check.dart' as _i16;
import '_features/learning/models/competence_goal.dart' as _i17;
import '_features/learning/models/competence_report.dart' as _i18;
import '_features/learning/models/competence_report_check.dart' as _i19;
import '_features/learning_support/models/learning_support_plan.dart' as _i20;
import '_features/learning_support/models/support_category.dart' as _i21;
import '_features/learning_support/models/support_category_status.dart' as _i22;
import '_features/learning_support/models/support_goal/support_goal.dart'
    as _i23;
import '_features/learning_support/models/support_goal/support_goal_check.dart'
    as _i24;
import '_features/learning_support/models/support_level.dart' as _i25;
import '_features/pupil/models/pupil_data/after_school_care/after_school_care.dart'
    as _i26;
import '_features/pupil/models/pupil_data/after_school_care/after_school_pickup_times.dart'
    as _i27;
import '_features/pupil/models/pupil_data/after_school_care/pick_up_info.dart'
    as _i28;
import '_features/pupil/models/pupil_data/communication/communication_skills.dart'
    as _i29;
import '_features/pupil/models/pupil_data/communication/public_media_auth.dart'
    as _i30;
import '_features/pupil/models/pupil_data/communication/tutor_info.dart'
    as _i31;
import '_features/pupil/models/pupil_data/credit_transaction.dart' as _i32;
import '_features/pupil/models/pupil_data/dto/pupil_document_type.dart' as _i33;
import '_features/pupil/models/pupil_data/dto/siblings_tutor_info_dto.dart'
    as _i34;
import '_features/pupil/models/pupil_data/preschool/kindergarden.dart' as _i35;
import '_features/pupil/models/pupil_data/preschool/kindergarden_info.dart'
    as _i36;
import '_features/pupil/models/pupil_data/preschool/pre_school_medical.dart'
    as _i37;
import '_features/pupil/models/pupil_data/preschool/pre_school_medical_status.dart'
    as _i38;
import '_features/pupil/models/pupil_data/preschool/pre_school_test.dart'
    as _i39;
import '_features/pupil/models/pupil_data/pupil_data.dart' as _i40;
import '_features/pupil/models/pupil_identity/pupil_identity.dart' as _i41;
import '_features/pupil/models/pupil_identity/school_grade.dart' as _i42;
import '_features/school_lists/models/pupil_entry.dart' as _i43;
import '_features/school_lists/models/school_list.dart' as _i44;
import '_features/schoolday/models/school_semester.dart' as _i45;
import '_features/schoolday/models/schoolday.dart' as _i46;
import '_features/schoolday_events/models/schoolday_event.dart' as _i47;
import '_features/schoolday_events/models/schoolday_event_type.dart' as _i48;
import '_features/timetable/models/classroom.dart' as _i49;
import '_features/timetable/models/lesson/lesson.dart' as _i50;
import '_features/timetable/models/lesson/lesson_attendance.dart' as _i51;
import '_features/timetable/models/lesson/lesson_group.dart' as _i52;
import '_features/timetable/models/lesson/lesson_group_membership.dart' as _i53;
import '_features/timetable/models/lesson/lesson_subject.dart' as _i54;
import '_features/timetable/models/lesson/subject.dart' as _i55;
import '_features/timetable/models/scheduled_lesson.dart' as _i56;
import '_features/timetable/models/timetable_slot.dart' as _i57;
import '_features/timetable/models/weekday_enum.dart' as _i58;
import '_features/user/models/device_info.dart' as _i59;
import '_features/user/models/roles.dart' as _i60;
import '_features/user/models/staff_user.dart' as _i61;
import '_features/user/models/user_device.dart' as _i62;
import '_features/user/models/user_flags.dart' as _i63;
import '_features/workbooks/models/pupil_workbook.dart' as _i64;
import '_features/workbooks/models/workbook.dart' as _i65;
import '_shared/models/exceptions/test_exception.dart' as _i66;
import '_shared/models/hub_document.dart' as _i67;
import '_shared/models/member_operation.dart' as _i68;
import 'package:school_data_hub_client/src/protocol/_features/user/models/staff_user.dart'
    as _i69;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/pupil_data.dart'
    as _i70;
import 'package:school_data_hub_client/src/protocol/_features/attendance/models/missed_class.dart'
    as _i71;
import 'package:school_data_hub_client/src/protocol/_features/authorizations/models/authorization.dart'
    as _i72;
import 'package:school_data_hub_client/src/protocol/_shared/models/member_operation.dart'
    as _i73;
import 'package:school_data_hub_client/src/protocol/_features/books/models/book_tagging/book_tag.dart'
    as _i74;
import 'package:school_data_hub_client/src/protocol/_features/books/models/book.dart'
    as _i75;
import 'package:school_data_hub_client/src/protocol/_features/books/models/library_book_location.dart'
    as _i76;
import 'package:school_data_hub_client/src/protocol/_features/books/models/library_book.dart'
    as _i77;
import 'package:school_data_hub_client/src/protocol/_features/books/models/pupil_book_lending.dart'
    as _i78;
import 'package:school_data_hub_client/src/protocol/_features/learning/models/competence.dart'
    as _i79;
import 'package:school_data_hub_client/src/protocol/_features/learning_support/models/learning_support_plan.dart'
    as _i80;
import 'package:school_data_hub_client/src/protocol/_features/learning_support/models/support_category_status.dart'
    as _i81;
import 'package:school_data_hub_client/src/protocol/_features/learning_support/models/support_category.dart'
    as _i82;
import 'package:school_data_hub_client/src/protocol/_features/school_lists/models/school_list.dart'
    as _i83;
import 'package:school_data_hub_client/src/protocol/_features/schoolday/models/school_semester.dart'
    as _i84;
import 'package:school_data_hub_client/src/protocol/_features/schoolday/models/schoolday.dart'
    as _i85;
import 'package:school_data_hub_client/src/protocol/_features/schoolday_events/models/schoolday_event.dart'
    as _i86;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i87;
import 'package:school_data_hub_client/src/protocol/_features/user/models/user_device.dart'
    as _i88;
import 'package:school_data_hub_client/src/protocol/_features/workbooks/models/pupil_workbook.dart'
    as _i89;
import 'package:school_data_hub_client/src/protocol/_features/workbooks/models/workbook.dart'
    as _i90;
export '_features/attendance/models/contacted_type.dart';
export '_features/attendance/models/missed_class.dart';
export '_features/attendance/models/missed_class_dto.dart';
export '_features/attendance/models/missed_type.dart';
export '_features/authorizations/models/authorization.dart';
export '_features/authorizations/models/pupil_authorization.dart';
export '_features/books/models/book.dart';
export '_features/books/models/book_tagging/book_tag.dart';
export '_features/books/models/book_tagging/book_tagging.dart';
export '_features/books/models/library_book.dart';
export '_features/books/models/library_book_location.dart';
export '_features/books/models/library_book_query.dart';
export '_features/books/models/pupil_book_lending.dart';
export '_features/learning/models/competence.dart';
export '_features/learning/models/competence_check.dart';
export '_features/learning/models/competence_goal.dart';
export '_features/learning/models/competence_report.dart';
export '_features/learning/models/competence_report_check.dart';
export '_features/learning_support/models/learning_support_plan.dart';
export '_features/learning_support/models/support_category.dart';
export '_features/learning_support/models/support_category_status.dart';
export '_features/learning_support/models/support_goal/support_goal.dart';
export '_features/learning_support/models/support_goal/support_goal_check.dart';
export '_features/learning_support/models/support_level.dart';
export '_features/pupil/models/pupil_data/after_school_care/after_school_care.dart';
export '_features/pupil/models/pupil_data/after_school_care/after_school_pickup_times.dart';
export '_features/pupil/models/pupil_data/after_school_care/pick_up_info.dart';
export '_features/pupil/models/pupil_data/communication/communication_skills.dart';
export '_features/pupil/models/pupil_data/communication/public_media_auth.dart';
export '_features/pupil/models/pupil_data/communication/tutor_info.dart';
export '_features/pupil/models/pupil_data/credit_transaction.dart';
export '_features/pupil/models/pupil_data/dto/pupil_document_type.dart';
export '_features/pupil/models/pupil_data/dto/siblings_tutor_info_dto.dart';
export '_features/pupil/models/pupil_data/preschool/kindergarden.dart';
export '_features/pupil/models/pupil_data/preschool/kindergarden_info.dart';
export '_features/pupil/models/pupil_data/preschool/pre_school_medical.dart';
export '_features/pupil/models/pupil_data/preschool/pre_school_medical_status.dart';
export '_features/pupil/models/pupil_data/preschool/pre_school_test.dart';
export '_features/pupil/models/pupil_data/pupil_data.dart';
export '_features/pupil/models/pupil_identity/pupil_identity.dart';
export '_features/pupil/models/pupil_identity/school_grade.dart';
export '_features/school_lists/models/pupil_entry.dart';
export '_features/school_lists/models/school_list.dart';
export '_features/schoolday/models/school_semester.dart';
export '_features/schoolday/models/schoolday.dart';
export '_features/schoolday_events/models/schoolday_event.dart';
export '_features/schoolday_events/models/schoolday_event_type.dart';
export '_features/timetable/models/classroom.dart';
export '_features/timetable/models/lesson/lesson.dart';
export '_features/timetable/models/lesson/lesson_attendance.dart';
export '_features/timetable/models/lesson/lesson_group.dart';
export '_features/timetable/models/lesson/lesson_group_membership.dart';
export '_features/timetable/models/lesson/lesson_subject.dart';
export '_features/timetable/models/lesson/subject.dart';
export '_features/timetable/models/scheduled_lesson.dart';
export '_features/timetable/models/timetable_slot.dart';
export '_features/timetable/models/weekday_enum.dart';
export '_features/user/models/device_info.dart';
export '_features/user/models/roles.dart';
export '_features/user/models/staff_user.dart';
export '_features/user/models/user_device.dart';
export '_features/user/models/user_flags.dart';
export '_features/workbooks/models/pupil_workbook.dart';
export '_features/workbooks/models/workbook.dart';
export '_shared/models/exceptions/test_exception.dart';
export '_shared/models/hub_document.dart';
export '_shared/models/member_operation.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.ContactedType) {
      return _i2.ContactedType.fromJson(data) as T;
    }
    if (t == _i3.MissedClass) {
      return _i3.MissedClass.fromJson(data) as T;
    }
    if (t == _i4.MissedClassDto) {
      return _i4.MissedClassDto.fromJson(data) as T;
    }
    if (t == _i5.MissedType) {
      return _i5.MissedType.fromJson(data) as T;
    }
    if (t == _i6.Authorization) {
      return _i6.Authorization.fromJson(data) as T;
    }
    if (t == _i7.PupilAuthorization) {
      return _i7.PupilAuthorization.fromJson(data) as T;
    }
    if (t == _i8.Book) {
      return _i8.Book.fromJson(data) as T;
    }
    if (t == _i9.BookTag) {
      return _i9.BookTag.fromJson(data) as T;
    }
    if (t == _i10.BookTagging) {
      return _i10.BookTagging.fromJson(data) as T;
    }
    if (t == _i11.LibraryBook) {
      return _i11.LibraryBook.fromJson(data) as T;
    }
    if (t == _i12.LibraryBookLocation) {
      return _i12.LibraryBookLocation.fromJson(data) as T;
    }
    if (t == _i13.LibraryBookQuery) {
      return _i13.LibraryBookQuery.fromJson(data) as T;
    }
    if (t == _i14.PupilBookLending) {
      return _i14.PupilBookLending.fromJson(data) as T;
    }
    if (t == _i15.Competence) {
      return _i15.Competence.fromJson(data) as T;
    }
    if (t == _i16.CompetenceCheck) {
      return _i16.CompetenceCheck.fromJson(data) as T;
    }
    if (t == _i17.CompetenceGoal) {
      return _i17.CompetenceGoal.fromJson(data) as T;
    }
    if (t == _i18.CompetenceReport) {
      return _i18.CompetenceReport.fromJson(data) as T;
    }
    if (t == _i19.CompetenceReportCheck) {
      return _i19.CompetenceReportCheck.fromJson(data) as T;
    }
    if (t == _i20.LearningSupportPlan) {
      return _i20.LearningSupportPlan.fromJson(data) as T;
    }
    if (t == _i21.SupportCategory) {
      return _i21.SupportCategory.fromJson(data) as T;
    }
    if (t == _i22.SupportCategoryStatus) {
      return _i22.SupportCategoryStatus.fromJson(data) as T;
    }
    if (t == _i23.SupportGoal) {
      return _i23.SupportGoal.fromJson(data) as T;
    }
    if (t == _i24.SupportGoalCheck) {
      return _i24.SupportGoalCheck.fromJson(data) as T;
    }
    if (t == _i25.SupportLevel) {
      return _i25.SupportLevel.fromJson(data) as T;
    }
    if (t == _i26.AfterSchoolCare) {
      return _i26.AfterSchoolCare.fromJson(data) as T;
    }
    if (t == _i27.AfterSchoolCarePickUpTimes) {
      return _i27.AfterSchoolCarePickUpTimes.fromJson(data) as T;
    }
    if (t == _i28.PickUpInfo) {
      return _i28.PickUpInfo.fromJson(data) as T;
    }
    if (t == _i29.CommunicationSkills) {
      return _i29.CommunicationSkills.fromJson(data) as T;
    }
    if (t == _i30.PublicMediaAuth) {
      return _i30.PublicMediaAuth.fromJson(data) as T;
    }
    if (t == _i31.TutorInfo) {
      return _i31.TutorInfo.fromJson(data) as T;
    }
    if (t == _i32.CreditTransaction) {
      return _i32.CreditTransaction.fromJson(data) as T;
    }
    if (t == _i33.PupilDocumentType) {
      return _i33.PupilDocumentType.fromJson(data) as T;
    }
    if (t == _i34.SiblingsTutorInfo) {
      return _i34.SiblingsTutorInfo.fromJson(data) as T;
    }
    if (t == _i35.Kindergarden) {
      return _i35.Kindergarden.fromJson(data) as T;
    }
    if (t == _i36.KindergardenInfo) {
      return _i36.KindergardenInfo.fromJson(data) as T;
    }
    if (t == _i37.PreSchoolMedical) {
      return _i37.PreSchoolMedical.fromJson(data) as T;
    }
    if (t == _i38.PreSchoolMedicalStatus) {
      return _i38.PreSchoolMedicalStatus.fromJson(data) as T;
    }
    if (t == _i39.PreSchoolTest) {
      return _i39.PreSchoolTest.fromJson(data) as T;
    }
    if (t == _i40.PupilData) {
      return _i40.PupilData.fromJson(data) as T;
    }
    if (t == _i41.PupilIdentity) {
      return _i41.PupilIdentity.fromJson(data) as T;
    }
    if (t == _i42.SchoolGrade) {
      return _i42.SchoolGrade.fromJson(data) as T;
    }
    if (t == _i43.PupilListEntry) {
      return _i43.PupilListEntry.fromJson(data) as T;
    }
    if (t == _i44.SchoolList) {
      return _i44.SchoolList.fromJson(data) as T;
    }
    if (t == _i45.SchoolSemester) {
      return _i45.SchoolSemester.fromJson(data) as T;
    }
    if (t == _i46.Schoolday) {
      return _i46.Schoolday.fromJson(data) as T;
    }
    if (t == _i47.SchooldayEvent) {
      return _i47.SchooldayEvent.fromJson(data) as T;
    }
    if (t == _i48.SchooldayEventType) {
      return _i48.SchooldayEventType.fromJson(data) as T;
    }
    if (t == _i49.Classroom) {
      return _i49.Classroom.fromJson(data) as T;
    }
    if (t == _i50.Lesson) {
      return _i50.Lesson.fromJson(data) as T;
    }
    if (t == _i51.LessonAttendance) {
      return _i51.LessonAttendance.fromJson(data) as T;
    }
    if (t == _i52.LessonGroup) {
      return _i52.LessonGroup.fromJson(data) as T;
    }
    if (t == _i53.ScheduledLessonGroupMembership) {
      return _i53.ScheduledLessonGroupMembership.fromJson(data) as T;
    }
    if (t == _i54.LessonSubject) {
      return _i54.LessonSubject.fromJson(data) as T;
    }
    if (t == _i55.Subject) {
      return _i55.Subject.fromJson(data) as T;
    }
    if (t == _i56.ScheduledLesson) {
      return _i56.ScheduledLesson.fromJson(data) as T;
    }
    if (t == _i57.TimetableSlot) {
      return _i57.TimetableSlot.fromJson(data) as T;
    }
    if (t == _i58.Weekday) {
      return _i58.Weekday.fromJson(data) as T;
    }
    if (t == _i59.DeviceInfo) {
      return _i59.DeviceInfo.fromJson(data) as T;
    }
    if (t == _i60.Role) {
      return _i60.Role.fromJson(data) as T;
    }
    if (t == _i61.User) {
      return _i61.User.fromJson(data) as T;
    }
    if (t == _i62.UserDevice) {
      return _i62.UserDevice.fromJson(data) as T;
    }
    if (t == _i63.UserFlags) {
      return _i63.UserFlags.fromJson(data) as T;
    }
    if (t == _i64.PupilWorkbook) {
      return _i64.PupilWorkbook.fromJson(data) as T;
    }
    if (t == _i65.Workbook) {
      return _i65.Workbook.fromJson(data) as T;
    }
    if (t == _i66.MyException) {
      return _i66.MyException.fromJson(data) as T;
    }
    if (t == _i67.HubDocument) {
      return _i67.HubDocument.fromJson(data) as T;
    }
    if (t == _i68.MemberOperation) {
      return _i68.MemberOperation.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.ContactedType?>()) {
      return (data != null ? _i2.ContactedType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.MissedClass?>()) {
      return (data != null ? _i3.MissedClass.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.MissedClassDto?>()) {
      return (data != null ? _i4.MissedClassDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.MissedType?>()) {
      return (data != null ? _i5.MissedType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Authorization?>()) {
      return (data != null ? _i6.Authorization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.PupilAuthorization?>()) {
      return (data != null ? _i7.PupilAuthorization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Book?>()) {
      return (data != null ? _i8.Book.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.BookTag?>()) {
      return (data != null ? _i9.BookTag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.BookTagging?>()) {
      return (data != null ? _i10.BookTagging.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.LibraryBook?>()) {
      return (data != null ? _i11.LibraryBook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.LibraryBookLocation?>()) {
      return (data != null ? _i12.LibraryBookLocation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.LibraryBookQuery?>()) {
      return (data != null ? _i13.LibraryBookQuery.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.PupilBookLending?>()) {
      return (data != null ? _i14.PupilBookLending.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.Competence?>()) {
      return (data != null ? _i15.Competence.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.CompetenceCheck?>()) {
      return (data != null ? _i16.CompetenceCheck.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.CompetenceGoal?>()) {
      return (data != null ? _i17.CompetenceGoal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.CompetenceReport?>()) {
      return (data != null ? _i18.CompetenceReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.CompetenceReportCheck?>()) {
      return (data != null ? _i19.CompetenceReportCheck.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.LearningSupportPlan?>()) {
      return (data != null ? _i20.LearningSupportPlan.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.SupportCategory?>()) {
      return (data != null ? _i21.SupportCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.SupportCategoryStatus?>()) {
      return (data != null ? _i22.SupportCategoryStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.SupportGoal?>()) {
      return (data != null ? _i23.SupportGoal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.SupportGoalCheck?>()) {
      return (data != null ? _i24.SupportGoalCheck.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.SupportLevel?>()) {
      return (data != null ? _i25.SupportLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.AfterSchoolCare?>()) {
      return (data != null ? _i26.AfterSchoolCare.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.AfterSchoolCarePickUpTimes?>()) {
      return (data != null
          ? _i27.AfterSchoolCarePickUpTimes.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i28.PickUpInfo?>()) {
      return (data != null ? _i28.PickUpInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.CommunicationSkills?>()) {
      return (data != null ? _i29.CommunicationSkills.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i30.PublicMediaAuth?>()) {
      return (data != null ? _i30.PublicMediaAuth.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.TutorInfo?>()) {
      return (data != null ? _i31.TutorInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.CreditTransaction?>()) {
      return (data != null ? _i32.CreditTransaction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.PupilDocumentType?>()) {
      return (data != null ? _i33.PupilDocumentType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.SiblingsTutorInfo?>()) {
      return (data != null ? _i34.SiblingsTutorInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.Kindergarden?>()) {
      return (data != null ? _i35.Kindergarden.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.KindergardenInfo?>()) {
      return (data != null ? _i36.KindergardenInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.PreSchoolMedical?>()) {
      return (data != null ? _i37.PreSchoolMedical.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.PreSchoolMedicalStatus?>()) {
      return (data != null ? _i38.PreSchoolMedicalStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i39.PreSchoolTest?>()) {
      return (data != null ? _i39.PreSchoolTest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.PupilData?>()) {
      return (data != null ? _i40.PupilData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.PupilIdentity?>()) {
      return (data != null ? _i41.PupilIdentity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.SchoolGrade?>()) {
      return (data != null ? _i42.SchoolGrade.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.PupilListEntry?>()) {
      return (data != null ? _i43.PupilListEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.SchoolList?>()) {
      return (data != null ? _i44.SchoolList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.SchoolSemester?>()) {
      return (data != null ? _i45.SchoolSemester.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.Schoolday?>()) {
      return (data != null ? _i46.Schoolday.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.SchooldayEvent?>()) {
      return (data != null ? _i47.SchooldayEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.SchooldayEventType?>()) {
      return (data != null ? _i48.SchooldayEventType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i49.Classroom?>()) {
      return (data != null ? _i49.Classroom.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.Lesson?>()) {
      return (data != null ? _i50.Lesson.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.LessonAttendance?>()) {
      return (data != null ? _i51.LessonAttendance.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.LessonGroup?>()) {
      return (data != null ? _i52.LessonGroup.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.ScheduledLessonGroupMembership?>()) {
      return (data != null
          ? _i53.ScheduledLessonGroupMembership.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i54.LessonSubject?>()) {
      return (data != null ? _i54.LessonSubject.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.Subject?>()) {
      return (data != null ? _i55.Subject.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.ScheduledLesson?>()) {
      return (data != null ? _i56.ScheduledLesson.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.TimetableSlot?>()) {
      return (data != null ? _i57.TimetableSlot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.Weekday?>()) {
      return (data != null ? _i58.Weekday.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.DeviceInfo?>()) {
      return (data != null ? _i59.DeviceInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i60.Role?>()) {
      return (data != null ? _i60.Role.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.User?>()) {
      return (data != null ? _i61.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.UserDevice?>()) {
      return (data != null ? _i62.UserDevice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.UserFlags?>()) {
      return (data != null ? _i63.UserFlags.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.PupilWorkbook?>()) {
      return (data != null ? _i64.PupilWorkbook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.Workbook?>()) {
      return (data != null ? _i65.Workbook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i66.MyException?>()) {
      return (data != null ? _i66.MyException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.HubDocument?>()) {
      return (data != null ? _i67.HubDocument.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.MemberOperation?>()) {
      return (data != null ? _i68.MemberOperation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<List<_i7.PupilAuthorization>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i7.PupilAuthorization>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i10.BookTagging>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i10.BookTagging>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i11.LibraryBook>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i11.LibraryBook>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i10.BookTagging>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i10.BookTagging>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i14.PupilBookLending>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i14.PupilBookLending>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i11.LibraryBook>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i11.LibraryBook>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i10.BookTagging>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i10.BookTagging>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i67.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i67.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i17.CompetenceGoal>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i17.CompetenceGoal>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i16.CompetenceCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i16.CompetenceCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i19.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.CompetenceReportCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i67.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i67.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i67.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i67.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i19.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.CompetenceReportCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i22.SupportCategoryStatus>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i22.SupportCategoryStatus>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i23.SupportGoal>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i23.SupportGoal>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i23.SupportGoal>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i23.SupportGoal>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i22.SupportCategoryStatus>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i22.SupportCategoryStatus>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i67.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i67.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i24.SupportGoalCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i24.SupportGoalCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i67.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i67.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i20.LearningSupportPlan>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i20.LearningSupportPlan>(e))
              .toList()
          : null) as T;
    }
    if (t == Set<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toSet() as T;
    }
    if (t == _i1.getType<List<_i40.PupilData>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i40.PupilData>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i67.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i67.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i67.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i67.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i7.PupilAuthorization>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i7.PupilAuthorization>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i32.CreditTransaction>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i32.CreditTransaction>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i53.ScheduledLessonGroupMembership>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i53.ScheduledLessonGroupMembership>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i51.LessonAttendance>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i51.LessonAttendance>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i17.CompetenceGoal>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i17.CompetenceGoal>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i16.CompetenceCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i16.CompetenceCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i18.CompetenceReport>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i18.CompetenceReport>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i19.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.CompetenceReportCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i64.PupilWorkbook>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i64.PupilWorkbook>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i14.PupilBookLending>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i14.PupilBookLending>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i25.SupportLevel>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i25.SupportLevel>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i22.SupportCategoryStatus>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i22.SupportCategoryStatus>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i23.SupportGoal>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i23.SupportGoal>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i20.LearningSupportPlan>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i20.LearningSupportPlan>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i3.MissedClass>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i3.MissedClass>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i47.SchooldayEvent>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i47.SchooldayEvent>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i43.PupilListEntry>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i43.PupilListEntry>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i43.PupilListEntry>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i43.PupilListEntry>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i46.Schoolday>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i46.Schoolday>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i18.CompetenceReport>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i18.CompetenceReport>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i20.LearningSupportPlan>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i20.LearningSupportPlan>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i3.MissedClass>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i3.MissedClass>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i47.SchooldayEvent>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i47.SchooldayEvent>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i56.ScheduledLesson>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i56.ScheduledLesson>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i51.LessonAttendance>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i51.LessonAttendance>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i56.ScheduledLesson>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i56.ScheduledLesson>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i53.ScheduledLessonGroupMembership>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i53.ScheduledLessonGroupMembership>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i50.Lesson>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i50.Lesson>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i56.ScheduledLesson>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i56.ScheduledLesson>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<({int testint, String testString})?>()) {
      return (data == null)
          ? null as T
          : (
              testint: deserialize<int>(((data as Map)['n'] as Map)['testint']),
              testString: deserialize<String>(data['n']['testString']),
            ) as T;
    }
    if (t == _i1.getType<Set<int>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<int>(e)).toSet()
          : null) as T;
    }
    if (t == _i1.getType<List<_i64.PupilWorkbook>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i64.PupilWorkbook>(e))
              .toList()
          : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i69.User>) {
      return (data as List).map((e) => deserialize<_i69.User>(e)).toList() as T;
    }
    if (t == Set<_i70.PupilData>) {
      return (data as List).map((e) => deserialize<_i70.PupilData>(e)).toSet()
          as T;
    }
    if (t == List<_i71.MissedClass>) {
      return (data as List)
          .map((e) => deserialize<_i71.MissedClass>(e))
          .toList() as T;
    }
    if (t == List<_i72.Authorization>) {
      return (data as List)
          .map((e) => deserialize<_i72.Authorization>(e))
          .toList() as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t ==
        _i1.getType<
            ({_i73.MemberOperation operation, List<int> pupilIds})?>()) {
      return (data == null)
          ? null as T
          : (
              operation: deserialize<_i73.MemberOperation>(
                  ((data as Map)['n'] as Map)['operation']),
              pupilIds: deserialize<List<int>>(data['n']['pupilIds']),
            ) as T;
    }
    if (t == List<_i74.BookTag>) {
      return (data as List).map((e) => deserialize<_i74.BookTag>(e)).toList()
          as T;
    }
    if (t == List<_i75.Book>) {
      return (data as List).map((e) => deserialize<_i75.Book>(e)).toList() as T;
    }
    if (t == List<_i76.LibraryBookLocation>) {
      return (data as List)
          .map((e) => deserialize<_i76.LibraryBookLocation>(e))
          .toList() as T;
    }
    if (t == List<_i77.LibraryBook>) {
      return (data as List)
          .map((e) => deserialize<_i77.LibraryBook>(e))
          .toList() as T;
    }
    if (t == List<_i78.PupilBookLending>) {
      return (data as List)
          .map((e) => deserialize<_i78.PupilBookLending>(e))
          .toList() as T;
    }
    if (t == List<_i79.Competence>) {
      return (data as List).map((e) => deserialize<_i79.Competence>(e)).toList()
          as T;
    }
    if (t == List<_i80.LearningSupportPlan>) {
      return (data as List)
          .map((e) => deserialize<_i80.LearningSupportPlan>(e))
          .toList() as T;
    }
    if (t == List<_i81.SupportCategoryStatus>) {
      return (data as List)
          .map((e) => deserialize<_i81.SupportCategoryStatus>(e))
          .toList() as T;
    }
    if (t == List<_i82.SupportCategory>) {
      return (data as List)
          .map((e) => deserialize<_i82.SupportCategory>(e))
          .toList() as T;
    }
    if (t == List<_i70.PupilData>) {
      return (data as List).map((e) => deserialize<_i70.PupilData>(e)).toList()
          as T;
    }
    if (t == Set<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toSet() as T;
    }
    if (t == _i1.getType<({DateTime? value})>()) {
      return (
        value: ((data as Map)['n'] as Map)['value'] == null
            ? null
            : deserialize<DateTime>(data['n']['value']),
      ) as T;
    }
    if (t == List<_i83.SchoolList>) {
      return (data as List).map((e) => deserialize<_i83.SchoolList>(e)).toList()
          as T;
    }
    if (t == List<_i84.SchoolSemester>) {
      return (data as List)
          .map((e) => deserialize<_i84.SchoolSemester>(e))
          .toList() as T;
    }
    if (t == List<_i85.Schoolday>) {
      return (data as List).map((e) => deserialize<_i85.Schoolday>(e)).toList()
          as T;
    }
    if (t == List<DateTime>) {
      return (data as List).map((e) => deserialize<DateTime>(e)).toList() as T;
    }
    if (t == List<_i86.SchooldayEvent>) {
      return (data as List)
          .map((e) => deserialize<_i86.SchooldayEvent>(e))
          .toList() as T;
    }
    if (t ==
        _i1.getType<
            ({
              _i87.AuthenticationResponse response,
              _i88.UserDevice? userDevice
            })>()) {
      return (
        response: deserialize<_i87.AuthenticationResponse>(
            ((data as Map)['n'] as Map)['response']),
        userDevice: ((data)['n'] as Map)['userDevice'] == null
            ? null
            : deserialize<_i88.UserDevice>(data['n']['userDevice']),
      ) as T;
    }
    if (t == List<_i89.PupilWorkbook>) {
      return (data as List)
          .map((e) => deserialize<_i89.PupilWorkbook>(e))
          .toList() as T;
    }
    if (t == List<_i90.Workbook>) {
      return (data as List).map((e) => deserialize<_i90.Workbook>(e)).toList()
          as T;
    }
    if (t == _i1.getType<({int testint, String testString})?>()) {
      return (data == null)
          ? null as T
          : (
              testint: deserialize<int>(((data as Map)['n'] as Map)['testint']),
              testString: deserialize<String>(data['n']['testString']),
            ) as T;
    }
    try {
      return _i87.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.ContactedType) {
      return 'ContactedType';
    }
    if (data is _i3.MissedClass) {
      return 'MissedClass';
    }
    if (data is _i4.MissedClassDto) {
      return 'MissedClassDto';
    }
    if (data is _i5.MissedType) {
      return 'MissedType';
    }
    if (data is _i6.Authorization) {
      return 'Authorization';
    }
    if (data is _i7.PupilAuthorization) {
      return 'PupilAuthorization';
    }
    if (data is _i8.Book) {
      return 'Book';
    }
    if (data is _i9.BookTag) {
      return 'BookTag';
    }
    if (data is _i10.BookTagging) {
      return 'BookTagging';
    }
    if (data is _i11.LibraryBook) {
      return 'LibraryBook';
    }
    if (data is _i12.LibraryBookLocation) {
      return 'LibraryBookLocation';
    }
    if (data is _i13.LibraryBookQuery) {
      return 'LibraryBookQuery';
    }
    if (data is _i14.PupilBookLending) {
      return 'PupilBookLending';
    }
    if (data is _i15.Competence) {
      return 'Competence';
    }
    if (data is _i16.CompetenceCheck) {
      return 'CompetenceCheck';
    }
    if (data is _i17.CompetenceGoal) {
      return 'CompetenceGoal';
    }
    if (data is _i18.CompetenceReport) {
      return 'CompetenceReport';
    }
    if (data is _i19.CompetenceReportCheck) {
      return 'CompetenceReportCheck';
    }
    if (data is _i20.LearningSupportPlan) {
      return 'LearningSupportPlan';
    }
    if (data is _i21.SupportCategory) {
      return 'SupportCategory';
    }
    if (data is _i22.SupportCategoryStatus) {
      return 'SupportCategoryStatus';
    }
    if (data is _i23.SupportGoal) {
      return 'SupportGoal';
    }
    if (data is _i24.SupportGoalCheck) {
      return 'SupportGoalCheck';
    }
    if (data is _i25.SupportLevel) {
      return 'SupportLevel';
    }
    if (data is _i26.AfterSchoolCare) {
      return 'AfterSchoolCare';
    }
    if (data is _i27.AfterSchoolCarePickUpTimes) {
      return 'AfterSchoolCarePickUpTimes';
    }
    if (data is _i28.PickUpInfo) {
      return 'PickUpInfo';
    }
    if (data is _i29.CommunicationSkills) {
      return 'CommunicationSkills';
    }
    if (data is _i30.PublicMediaAuth) {
      return 'PublicMediaAuth';
    }
    if (data is _i31.TutorInfo) {
      return 'TutorInfo';
    }
    if (data is _i32.CreditTransaction) {
      return 'CreditTransaction';
    }
    if (data is _i33.PupilDocumentType) {
      return 'PupilDocumentType';
    }
    if (data is _i34.SiblingsTutorInfo) {
      return 'SiblingsTutorInfo';
    }
    if (data is _i35.Kindergarden) {
      return 'Kindergarden';
    }
    if (data is _i36.KindergardenInfo) {
      return 'KindergardenInfo';
    }
    if (data is _i37.PreSchoolMedical) {
      return 'PreSchoolMedical';
    }
    if (data is _i38.PreSchoolMedicalStatus) {
      return 'PreSchoolMedicalStatus';
    }
    if (data is _i39.PreSchoolTest) {
      return 'PreSchoolTest';
    }
    if (data is _i40.PupilData) {
      return 'PupilData';
    }
    if (data is _i41.PupilIdentity) {
      return 'PupilIdentity';
    }
    if (data is _i42.SchoolGrade) {
      return 'SchoolGrade';
    }
    if (data is _i43.PupilListEntry) {
      return 'PupilListEntry';
    }
    if (data is _i44.SchoolList) {
      return 'SchoolList';
    }
    if (data is _i45.SchoolSemester) {
      return 'SchoolSemester';
    }
    if (data is _i46.Schoolday) {
      return 'Schoolday';
    }
    if (data is _i47.SchooldayEvent) {
      return 'SchooldayEvent';
    }
    if (data is _i48.SchooldayEventType) {
      return 'SchooldayEventType';
    }
    if (data is _i49.Classroom) {
      return 'Classroom';
    }
    if (data is _i50.Lesson) {
      return 'Lesson';
    }
    if (data is _i51.LessonAttendance) {
      return 'LessonAttendance';
    }
    if (data is _i52.LessonGroup) {
      return 'LessonGroup';
    }
    if (data is _i53.ScheduledLessonGroupMembership) {
      return 'ScheduledLessonGroupMembership';
    }
    if (data is _i54.LessonSubject) {
      return 'LessonSubject';
    }
    if (data is _i55.Subject) {
      return 'Subject';
    }
    if (data is _i56.ScheduledLesson) {
      return 'ScheduledLesson';
    }
    if (data is _i57.TimetableSlot) {
      return 'TimetableSlot';
    }
    if (data is _i58.Weekday) {
      return 'Weekday';
    }
    if (data is _i59.DeviceInfo) {
      return 'DeviceInfo';
    }
    if (data is _i60.Role) {
      return 'Role';
    }
    if (data is _i61.User) {
      return 'User';
    }
    if (data is _i62.UserDevice) {
      return 'UserDevice';
    }
    if (data is _i63.UserFlags) {
      return 'UserFlags';
    }
    if (data is _i64.PupilWorkbook) {
      return 'PupilWorkbook';
    }
    if (data is _i65.Workbook) {
      return 'Workbook';
    }
    if (data is _i66.MyException) {
      return 'MyException';
    }
    if (data is _i67.HubDocument) {
      return 'HubDocument';
    }
    if (data is _i68.MemberOperation) {
      return 'MemberOperation';
    }
    className = _i87.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    if (data is List<_i70.PupilData>) {
      return 'List<PupilData>';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'ContactedType') {
      return deserialize<_i2.ContactedType>(data['data']);
    }
    if (dataClassName == 'MissedClass') {
      return deserialize<_i3.MissedClass>(data['data']);
    }
    if (dataClassName == 'MissedClassDto') {
      return deserialize<_i4.MissedClassDto>(data['data']);
    }
    if (dataClassName == 'MissedType') {
      return deserialize<_i5.MissedType>(data['data']);
    }
    if (dataClassName == 'Authorization') {
      return deserialize<_i6.Authorization>(data['data']);
    }
    if (dataClassName == 'PupilAuthorization') {
      return deserialize<_i7.PupilAuthorization>(data['data']);
    }
    if (dataClassName == 'Book') {
      return deserialize<_i8.Book>(data['data']);
    }
    if (dataClassName == 'BookTag') {
      return deserialize<_i9.BookTag>(data['data']);
    }
    if (dataClassName == 'BookTagging') {
      return deserialize<_i10.BookTagging>(data['data']);
    }
    if (dataClassName == 'LibraryBook') {
      return deserialize<_i11.LibraryBook>(data['data']);
    }
    if (dataClassName == 'LibraryBookLocation') {
      return deserialize<_i12.LibraryBookLocation>(data['data']);
    }
    if (dataClassName == 'LibraryBookQuery') {
      return deserialize<_i13.LibraryBookQuery>(data['data']);
    }
    if (dataClassName == 'PupilBookLending') {
      return deserialize<_i14.PupilBookLending>(data['data']);
    }
    if (dataClassName == 'Competence') {
      return deserialize<_i15.Competence>(data['data']);
    }
    if (dataClassName == 'CompetenceCheck') {
      return deserialize<_i16.CompetenceCheck>(data['data']);
    }
    if (dataClassName == 'CompetenceGoal') {
      return deserialize<_i17.CompetenceGoal>(data['data']);
    }
    if (dataClassName == 'CompetenceReport') {
      return deserialize<_i18.CompetenceReport>(data['data']);
    }
    if (dataClassName == 'CompetenceReportCheck') {
      return deserialize<_i19.CompetenceReportCheck>(data['data']);
    }
    if (dataClassName == 'LearningSupportPlan') {
      return deserialize<_i20.LearningSupportPlan>(data['data']);
    }
    if (dataClassName == 'SupportCategory') {
      return deserialize<_i21.SupportCategory>(data['data']);
    }
    if (dataClassName == 'SupportCategoryStatus') {
      return deserialize<_i22.SupportCategoryStatus>(data['data']);
    }
    if (dataClassName == 'SupportGoal') {
      return deserialize<_i23.SupportGoal>(data['data']);
    }
    if (dataClassName == 'SupportGoalCheck') {
      return deserialize<_i24.SupportGoalCheck>(data['data']);
    }
    if (dataClassName == 'SupportLevel') {
      return deserialize<_i25.SupportLevel>(data['data']);
    }
    if (dataClassName == 'AfterSchoolCare') {
      return deserialize<_i26.AfterSchoolCare>(data['data']);
    }
    if (dataClassName == 'AfterSchoolCarePickUpTimes') {
      return deserialize<_i27.AfterSchoolCarePickUpTimes>(data['data']);
    }
    if (dataClassName == 'PickUpInfo') {
      return deserialize<_i28.PickUpInfo>(data['data']);
    }
    if (dataClassName == 'CommunicationSkills') {
      return deserialize<_i29.CommunicationSkills>(data['data']);
    }
    if (dataClassName == 'PublicMediaAuth') {
      return deserialize<_i30.PublicMediaAuth>(data['data']);
    }
    if (dataClassName == 'TutorInfo') {
      return deserialize<_i31.TutorInfo>(data['data']);
    }
    if (dataClassName == 'CreditTransaction') {
      return deserialize<_i32.CreditTransaction>(data['data']);
    }
    if (dataClassName == 'PupilDocumentType') {
      return deserialize<_i33.PupilDocumentType>(data['data']);
    }
    if (dataClassName == 'SiblingsTutorInfo') {
      return deserialize<_i34.SiblingsTutorInfo>(data['data']);
    }
    if (dataClassName == 'Kindergarden') {
      return deserialize<_i35.Kindergarden>(data['data']);
    }
    if (dataClassName == 'KindergardenInfo') {
      return deserialize<_i36.KindergardenInfo>(data['data']);
    }
    if (dataClassName == 'PreSchoolMedical') {
      return deserialize<_i37.PreSchoolMedical>(data['data']);
    }
    if (dataClassName == 'PreSchoolMedicalStatus') {
      return deserialize<_i38.PreSchoolMedicalStatus>(data['data']);
    }
    if (dataClassName == 'PreSchoolTest') {
      return deserialize<_i39.PreSchoolTest>(data['data']);
    }
    if (dataClassName == 'PupilData') {
      return deserialize<_i40.PupilData>(data['data']);
    }
    if (dataClassName == 'PupilIdentity') {
      return deserialize<_i41.PupilIdentity>(data['data']);
    }
    if (dataClassName == 'SchoolGrade') {
      return deserialize<_i42.SchoolGrade>(data['data']);
    }
    if (dataClassName == 'PupilListEntry') {
      return deserialize<_i43.PupilListEntry>(data['data']);
    }
    if (dataClassName == 'SchoolList') {
      return deserialize<_i44.SchoolList>(data['data']);
    }
    if (dataClassName == 'SchoolSemester') {
      return deserialize<_i45.SchoolSemester>(data['data']);
    }
    if (dataClassName == 'Schoolday') {
      return deserialize<_i46.Schoolday>(data['data']);
    }
    if (dataClassName == 'SchooldayEvent') {
      return deserialize<_i47.SchooldayEvent>(data['data']);
    }
    if (dataClassName == 'SchooldayEventType') {
      return deserialize<_i48.SchooldayEventType>(data['data']);
    }
    if (dataClassName == 'Classroom') {
      return deserialize<_i49.Classroom>(data['data']);
    }
    if (dataClassName == 'Lesson') {
      return deserialize<_i50.Lesson>(data['data']);
    }
    if (dataClassName == 'LessonAttendance') {
      return deserialize<_i51.LessonAttendance>(data['data']);
    }
    if (dataClassName == 'LessonGroup') {
      return deserialize<_i52.LessonGroup>(data['data']);
    }
    if (dataClassName == 'ScheduledLessonGroupMembership') {
      return deserialize<_i53.ScheduledLessonGroupMembership>(data['data']);
    }
    if (dataClassName == 'LessonSubject') {
      return deserialize<_i54.LessonSubject>(data['data']);
    }
    if (dataClassName == 'Subject') {
      return deserialize<_i55.Subject>(data['data']);
    }
    if (dataClassName == 'ScheduledLesson') {
      return deserialize<_i56.ScheduledLesson>(data['data']);
    }
    if (dataClassName == 'TimetableSlot') {
      return deserialize<_i57.TimetableSlot>(data['data']);
    }
    if (dataClassName == 'Weekday') {
      return deserialize<_i58.Weekday>(data['data']);
    }
    if (dataClassName == 'DeviceInfo') {
      return deserialize<_i59.DeviceInfo>(data['data']);
    }
    if (dataClassName == 'Role') {
      return deserialize<_i60.Role>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i61.User>(data['data']);
    }
    if (dataClassName == 'UserDevice') {
      return deserialize<_i62.UserDevice>(data['data']);
    }
    if (dataClassName == 'UserFlags') {
      return deserialize<_i63.UserFlags>(data['data']);
    }
    if (dataClassName == 'PupilWorkbook') {
      return deserialize<_i64.PupilWorkbook>(data['data']);
    }
    if (dataClassName == 'Workbook') {
      return deserialize<_i65.Workbook>(data['data']);
    }
    if (dataClassName == 'MyException') {
      return deserialize<_i66.MyException>(data['data']);
    }
    if (dataClassName == 'HubDocument') {
      return deserialize<_i67.HubDocument>(data['data']);
    }
    if (dataClassName == 'MemberOperation') {
      return deserialize<_i68.MemberOperation>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i87.Protocol().deserializeByClassName(data);
    }
    if (dataClassName == 'List<PupilData>') {
      return deserialize<List<_i70.PupilData>>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}

/// Maps any `Record`s known to this [Protocol] to their JSON representation
///
/// Throws in case the record type is not known.
///
/// This method will return `null` (only) for `null` inputs.
Map<String, dynamic>? mapRecordToJson(Record? record) {
  if (record == null) {
    return null;
  }
  if (record is ({_i73.MemberOperation operation, List<int> pupilIds})) {
    return {
      "n": {
        "operation": record.operation,
        "pupilIds": record.pupilIds,
      },
    };
  }
  if (record is ({DateTime? value})) {
    return {
      "n": {
        "value": record.value,
      },
    };
  }
  if (record is ({
    _i87.AuthenticationResponse response,
    _i88.UserDevice? userDevice
  })) {
    return {
      "n": {
        "response": record.response,
        "userDevice": record.userDevice,
      },
    };
  }
  if (record is ({int testint, String testString})) {
    return {
      "n": {
        "testint": record.testint,
        "testString": record.testString,
      },
    };
  }
  throw Exception('Unsupported record type ${record.runtimeType}');
}

/// Maps container types (like [List], [Map], [Set]) containing [Record]s to their JSON representation.
///
/// It should not be called for [SerializableModel] types. These handle the "[Record] in container" mapping internally already.
///
/// It is only supposed to be called from generated protocol code.
///
/// Returns either a `List<dynamic>` (for List, Sets, and Maps with non-String keys) or a `Map<String, dynamic>` in case the input was a `Map<String, …>`.
Object? mapRecordContainingContainerToJson(Object obj) {
  if (obj is! Iterable && obj is! Map) {
    throw ArgumentError.value(
      obj,
      'obj',
      'The object to serialize should be of type List, Map, or Set',
    );
  }

  dynamic mapIfNeeded(Object? obj) {
    return switch (obj) {
      Record record => mapRecordToJson(record),
      Iterable iterable => mapRecordContainingContainerToJson(iterable),
      Map map => mapRecordContainingContainerToJson(map),
      Object? value => value,
    };
  }

  switch (obj) {
    case Map<String, dynamic>():
      return {
        for (var entry in obj.entries) entry.key: mapIfNeeded(entry.value),
      };
    case Map():
      return [
        for (var entry in obj.entries)
          {
            'k': mapIfNeeded(entry.key),
            'v': mapIfNeeded(entry.value),
          }
      ];

    case Iterable():
      return [
        for (var e in obj) mapIfNeeded(e),
      ];
  }

  return obj;
}

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
import 'authorization/authorization.dart' as _i2;
import 'authorization/pupil_authorization.dart' as _i3;
import 'book/book.dart' as _i4;
import 'book/book_tagging/book_tag.dart' as _i5;
import 'book/book_tagging/book_tagging.dart' as _i6;
import 'book/library_book/library_book.dart' as _i7;
import 'book/library_book/library_book_query.dart' as _i8;
import 'book/library_book/location/library_book_location.dart' as _i9;
import 'book/pupil_book_lending.dart' as _i10;
import 'learning/competence.dart' as _i11;
import 'learning/competence_check.dart' as _i12;
import 'learning/competence_goal.dart' as _i13;
import 'learning/competence_report.dart' as _i14;
import 'learning/competence_report_check.dart' as _i15;
import 'learning/timetable/lesson/lesson.dart' as _i16;
import 'learning/timetable/lesson/lesson_attendance.dart' as _i17;
import 'learning/timetable/lesson/lesson_group.dart' as _i18;
import 'learning/timetable/lesson/lesson_group_membership.dart' as _i19;
import 'learning/timetable/lesson/lesson_subject.dart' as _i20;
import 'learning/timetable/lesson/scheduled_lesson.dart' as _i21;
import 'learning/timetable/lesson/subject.dart' as _i22;
import 'learning/timetable/lesson/timetable_slot.dart' as _i23;
import 'learning/timetable/lesson/weekday_enum.dart' as _i24;
import 'learning/timetable/room.dart' as _i25;
import 'learning_support/support_category.dart' as _i26;
import 'learning_support/support_category_status.dart' as _i27;
import 'learning_support/support_goal/support_goal.dart' as _i28;
import 'learning_support/support_goal/support_goal_check.dart' as _i29;
import 'learning_support/support_level.dart' as _i30;
import 'pupil_data/dto/pupil_document_type.dart' as _i31;
import 'pupil_data/dto/siblings_tutor_info_dto.dart' as _i32;
import 'pupil_data/pupil_data.dart' as _i33;
import 'pupil_data/pupil_objects/after_school_care/after_school_care.dart'
    as _i34;
import 'pupil_data/pupil_objects/after_school_care/after_school_pickup_times.dart'
    as _i35;
import 'pupil_data/pupil_objects/after_school_care/pick_up_info.dart' as _i36;
import 'pupil_data/pupil_objects/communication/communication_skills.dart'
    as _i37;
import 'pupil_data/pupil_objects/communication/language.dart' as _i38;
import 'pupil_data/pupil_objects/communication/public_media_auth.dart' as _i39;
import 'pupil_data/pupil_objects/communication/tutor_info.dart' as _i40;
import 'pupil_data/pupil_objects/preschool/kindergarden_info.dart' as _i41;
import 'pupil_data/pupil_objects/preschool/pre_school_medical.dart' as _i42;
import 'pupil_data/pupil_objects/preschool/pre_school_medical_status.dart'
    as _i43;
import 'pupil_data/pupil_objects/preschool/pre_school_test.dart' as _i44;
import 'school_list/pupil_entry.dart' as _i45;
import 'school_list/school_list.dart' as _i46;
import 'schoolday/missed_class/contacted_type.dart' as _i47;
import 'schoolday/missed_class/missed_class.dart' as _i48;
import 'schoolday/missed_class/missed_class_dto.dart' as _i49;
import 'schoolday/missed_class/missed_type.dart' as _i50;
import 'schoolday/school_semester.dart' as _i51;
import 'schoolday/schoolday.dart' as _i52;
import 'schoolday/schoolday_event/schoolday_event.dart' as _i53;
import 'schoolday/schoolday_event/schoolday_event_type.dart' as _i54;
import 'shared/document.dart' as _i55;
import 'shared/member_operation.dart' as _i56;
import 'stats/language_stats.dart' as _i57;
import 'user/credit_transaction.dart' as _i58;
import 'user/device_info.dart' as _i59;
import 'user/roles/roles.dart' as _i60;
import 'user/staff_user.dart' as _i61;
import 'user/user_device.dart' as _i62;
import 'user/user_flags.dart' as _i63;
import 'workbook/pupil_workbook.dart' as _i64;
import 'workbook/workbook.dart' as _i65;
import 'package:school_data_hub_client/src/protocol/user/staff_user.dart'
    as _i66;
import 'package:school_data_hub_client/src/protocol/pupil_data/pupil_data.dart'
    as _i67;
import 'package:school_data_hub_client/src/protocol/schoolday/missed_class/missed_class.dart'
    as _i68;
import 'package:school_data_hub_client/src/protocol/user/device_info.dart'
    as _i69;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i70;
import 'package:school_data_hub_client/src/protocol/authorization/authorization.dart'
    as _i71;
import 'package:school_data_hub_client/src/protocol/shared/member_operation.dart'
    as _i72;
import 'package:school_data_hub_client/src/protocol/book/book_tagging/book_tag.dart'
    as _i73;
import 'package:school_data_hub_client/src/protocol/book/book.dart' as _i74;
import 'package:school_data_hub_client/src/protocol/book/library_book/location/library_book_location.dart'
    as _i75;
import 'package:school_data_hub_client/src/protocol/book/library_book/library_book.dart'
    as _i76;
import 'package:school_data_hub_client/src/protocol/book/pupil_book_lending.dart'
    as _i77;
import 'package:school_data_hub_client/src/protocol/learning/competence.dart'
    as _i78;
import 'package:school_data_hub_client/src/protocol/learning_support/support_category.dart'
    as _i79;
import 'package:school_data_hub_client/src/protocol/learning_support/support_category_status.dart'
    as _i80;
import 'package:school_data_hub_client/src/protocol/school_list/school_list.dart'
    as _i81;
import 'package:school_data_hub_client/src/protocol/schoolday/school_semester.dart'
    as _i82;
import 'package:school_data_hub_client/src/protocol/schoolday/schoolday.dart'
    as _i83;
import 'package:school_data_hub_client/src/protocol/schoolday/schoolday_event/schoolday_event.dart'
    as _i84;
export 'authorization/authorization.dart';
export 'authorization/pupil_authorization.dart';
export 'book/book.dart';
export 'book/book_tagging/book_tag.dart';
export 'book/book_tagging/book_tagging.dart';
export 'book/library_book/library_book.dart';
export 'book/library_book/library_book_query.dart';
export 'book/library_book/location/library_book_location.dart';
export 'book/pupil_book_lending.dart';
export 'learning/competence.dart';
export 'learning/competence_check.dart';
export 'learning/competence_goal.dart';
export 'learning/competence_report.dart';
export 'learning/competence_report_check.dart';
export 'learning/timetable/lesson/lesson.dart';
export 'learning/timetable/lesson/lesson_attendance.dart';
export 'learning/timetable/lesson/lesson_group.dart';
export 'learning/timetable/lesson/lesson_group_membership.dart';
export 'learning/timetable/lesson/lesson_subject.dart';
export 'learning/timetable/lesson/scheduled_lesson.dart';
export 'learning/timetable/lesson/subject.dart';
export 'learning/timetable/lesson/timetable_slot.dart';
export 'learning/timetable/lesson/weekday_enum.dart';
export 'learning/timetable/room.dart';
export 'learning_support/support_category.dart';
export 'learning_support/support_category_status.dart';
export 'learning_support/support_goal/support_goal.dart';
export 'learning_support/support_goal/support_goal_check.dart';
export 'learning_support/support_level.dart';
export 'pupil_data/dto/pupil_document_type.dart';
export 'pupil_data/dto/siblings_tutor_info_dto.dart';
export 'pupil_data/pupil_data.dart';
export 'pupil_data/pupil_objects/after_school_care/after_school_care.dart';
export 'pupil_data/pupil_objects/after_school_care/after_school_pickup_times.dart';
export 'pupil_data/pupil_objects/after_school_care/pick_up_info.dart';
export 'pupil_data/pupil_objects/communication/communication_skills.dart';
export 'pupil_data/pupil_objects/communication/language.dart';
export 'pupil_data/pupil_objects/communication/public_media_auth.dart';
export 'pupil_data/pupil_objects/communication/tutor_info.dart';
export 'pupil_data/pupil_objects/preschool/kindergarden_info.dart';
export 'pupil_data/pupil_objects/preschool/pre_school_medical.dart';
export 'pupil_data/pupil_objects/preschool/pre_school_medical_status.dart';
export 'pupil_data/pupil_objects/preschool/pre_school_test.dart';
export 'school_list/pupil_entry.dart';
export 'school_list/school_list.dart';
export 'schoolday/missed_class/contacted_type.dart';
export 'schoolday/missed_class/missed_class.dart';
export 'schoolday/missed_class/missed_class_dto.dart';
export 'schoolday/missed_class/missed_type.dart';
export 'schoolday/school_semester.dart';
export 'schoolday/schoolday.dart';
export 'schoolday/schoolday_event/schoolday_event.dart';
export 'schoolday/schoolday_event/schoolday_event_type.dart';
export 'shared/document.dart';
export 'shared/member_operation.dart';
export 'stats/language_stats.dart';
export 'user/credit_transaction.dart';
export 'user/device_info.dart';
export 'user/roles/roles.dart';
export 'user/staff_user.dart';
export 'user/user_device.dart';
export 'user/user_flags.dart';
export 'workbook/pupil_workbook.dart';
export 'workbook/workbook.dart';
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
    if (t == _i2.Authorization) {
      return _i2.Authorization.fromJson(data) as T;
    }
    if (t == _i3.PupilAuthorization) {
      return _i3.PupilAuthorization.fromJson(data) as T;
    }
    if (t == _i4.Book) {
      return _i4.Book.fromJson(data) as T;
    }
    if (t == _i5.BookTag) {
      return _i5.BookTag.fromJson(data) as T;
    }
    if (t == _i6.BookTagging) {
      return _i6.BookTagging.fromJson(data) as T;
    }
    if (t == _i7.LibraryBook) {
      return _i7.LibraryBook.fromJson(data) as T;
    }
    if (t == _i8.LibraryBookQuery) {
      return _i8.LibraryBookQuery.fromJson(data) as T;
    }
    if (t == _i9.LibraryBookLocation) {
      return _i9.LibraryBookLocation.fromJson(data) as T;
    }
    if (t == _i10.PupilBookLending) {
      return _i10.PupilBookLending.fromJson(data) as T;
    }
    if (t == _i11.Competence) {
      return _i11.Competence.fromJson(data) as T;
    }
    if (t == _i12.CompetenceCheck) {
      return _i12.CompetenceCheck.fromJson(data) as T;
    }
    if (t == _i13.CompetenceGoal) {
      return _i13.CompetenceGoal.fromJson(data) as T;
    }
    if (t == _i14.CompetenceReport) {
      return _i14.CompetenceReport.fromJson(data) as T;
    }
    if (t == _i15.CompetenceReportCheck) {
      return _i15.CompetenceReportCheck.fromJson(data) as T;
    }
    if (t == _i16.Lesson) {
      return _i16.Lesson.fromJson(data) as T;
    }
    if (t == _i17.LessonAttendance) {
      return _i17.LessonAttendance.fromJson(data) as T;
    }
    if (t == _i18.LessonGroup) {
      return _i18.LessonGroup.fromJson(data) as T;
    }
    if (t == _i19.ScheduledLessonGroupMembership) {
      return _i19.ScheduledLessonGroupMembership.fromJson(data) as T;
    }
    if (t == _i20.LessonSubject) {
      return _i20.LessonSubject.fromJson(data) as T;
    }
    if (t == _i21.ScheduledLesson) {
      return _i21.ScheduledLesson.fromJson(data) as T;
    }
    if (t == _i22.Subject) {
      return _i22.Subject.fromJson(data) as T;
    }
    if (t == _i23.TimetableSlot) {
      return _i23.TimetableSlot.fromJson(data) as T;
    }
    if (t == _i24.Weekday) {
      return _i24.Weekday.fromJson(data) as T;
    }
    if (t == _i25.Room) {
      return _i25.Room.fromJson(data) as T;
    }
    if (t == _i26.SupportCategory) {
      return _i26.SupportCategory.fromJson(data) as T;
    }
    if (t == _i27.SupportCategoryStatus) {
      return _i27.SupportCategoryStatus.fromJson(data) as T;
    }
    if (t == _i28.SupportGoal) {
      return _i28.SupportGoal.fromJson(data) as T;
    }
    if (t == _i29.SupportGoalCheck) {
      return _i29.SupportGoalCheck.fromJson(data) as T;
    }
    if (t == _i30.SupportLevel) {
      return _i30.SupportLevel.fromJson(data) as T;
    }
    if (t == _i31.PupilDocumentType) {
      return _i31.PupilDocumentType.fromJson(data) as T;
    }
    if (t == _i32.SiblingsTutorInfo) {
      return _i32.SiblingsTutorInfo.fromJson(data) as T;
    }
    if (t == _i33.PupilData) {
      return _i33.PupilData.fromJson(data) as T;
    }
    if (t == _i34.AfterSchoolCare) {
      return _i34.AfterSchoolCare.fromJson(data) as T;
    }
    if (t == _i35.AfterSchoolCarePickUpTimes) {
      return _i35.AfterSchoolCarePickUpTimes.fromJson(data) as T;
    }
    if (t == _i36.PickUpInfo) {
      return _i36.PickUpInfo.fromJson(data) as T;
    }
    if (t == _i37.CommunicationSkills) {
      return _i37.CommunicationSkills.fromJson(data) as T;
    }
    if (t == _i38.Language) {
      return _i38.Language.fromJson(data) as T;
    }
    if (t == _i39.PublicMediaAuth) {
      return _i39.PublicMediaAuth.fromJson(data) as T;
    }
    if (t == _i40.TutorInfo) {
      return _i40.TutorInfo.fromJson(data) as T;
    }
    if (t == _i41.KindergardenInfo) {
      return _i41.KindergardenInfo.fromJson(data) as T;
    }
    if (t == _i42.PreSchoolMedical) {
      return _i42.PreSchoolMedical.fromJson(data) as T;
    }
    if (t == _i43.PreSchoolMedicalStatus) {
      return _i43.PreSchoolMedicalStatus.fromJson(data) as T;
    }
    if (t == _i44.PreSchoolTest) {
      return _i44.PreSchoolTest.fromJson(data) as T;
    }
    if (t == _i45.PupilListEntry) {
      return _i45.PupilListEntry.fromJson(data) as T;
    }
    if (t == _i46.SchoolList) {
      return _i46.SchoolList.fromJson(data) as T;
    }
    if (t == _i47.ContactedType) {
      return _i47.ContactedType.fromJson(data) as T;
    }
    if (t == _i48.MissedClass) {
      return _i48.MissedClass.fromJson(data) as T;
    }
    if (t == _i49.MissedClassDto) {
      return _i49.MissedClassDto.fromJson(data) as T;
    }
    if (t == _i50.MissedType) {
      return _i50.MissedType.fromJson(data) as T;
    }
    if (t == _i51.SchoolSemester) {
      return _i51.SchoolSemester.fromJson(data) as T;
    }
    if (t == _i52.Schoolday) {
      return _i52.Schoolday.fromJson(data) as T;
    }
    if (t == _i53.SchooldayEvent) {
      return _i53.SchooldayEvent.fromJson(data) as T;
    }
    if (t == _i54.SchooldayEventType) {
      return _i54.SchooldayEventType.fromJson(data) as T;
    }
    if (t == _i55.HubDocument) {
      return _i55.HubDocument.fromJson(data) as T;
    }
    if (t == _i56.MemberOperation) {
      return _i56.MemberOperation.fromJson(data) as T;
    }
    if (t == _i57.LanguageStats) {
      return _i57.LanguageStats.fromJson(data) as T;
    }
    if (t == _i58.CreditTransaction) {
      return _i58.CreditTransaction.fromJson(data) as T;
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
    if (t == _i1.getType<_i2.Authorization?>()) {
      return (data != null ? _i2.Authorization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.PupilAuthorization?>()) {
      return (data != null ? _i3.PupilAuthorization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Book?>()) {
      return (data != null ? _i4.Book.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.BookTag?>()) {
      return (data != null ? _i5.BookTag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.BookTagging?>()) {
      return (data != null ? _i6.BookTagging.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.LibraryBook?>()) {
      return (data != null ? _i7.LibraryBook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.LibraryBookQuery?>()) {
      return (data != null ? _i8.LibraryBookQuery.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.LibraryBookLocation?>()) {
      return (data != null ? _i9.LibraryBookLocation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.PupilBookLending?>()) {
      return (data != null ? _i10.PupilBookLending.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.Competence?>()) {
      return (data != null ? _i11.Competence.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.CompetenceCheck?>()) {
      return (data != null ? _i12.CompetenceCheck.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.CompetenceGoal?>()) {
      return (data != null ? _i13.CompetenceGoal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.CompetenceReport?>()) {
      return (data != null ? _i14.CompetenceReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.CompetenceReportCheck?>()) {
      return (data != null ? _i15.CompetenceReportCheck.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.Lesson?>()) {
      return (data != null ? _i16.Lesson.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.LessonAttendance?>()) {
      return (data != null ? _i17.LessonAttendance.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.LessonGroup?>()) {
      return (data != null ? _i18.LessonGroup.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.ScheduledLessonGroupMembership?>()) {
      return (data != null
          ? _i19.ScheduledLessonGroupMembership.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i20.LessonSubject?>()) {
      return (data != null ? _i20.LessonSubject.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.ScheduledLesson?>()) {
      return (data != null ? _i21.ScheduledLesson.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.Subject?>()) {
      return (data != null ? _i22.Subject.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.TimetableSlot?>()) {
      return (data != null ? _i23.TimetableSlot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.Weekday?>()) {
      return (data != null ? _i24.Weekday.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.Room?>()) {
      return (data != null ? _i25.Room.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.SupportCategory?>()) {
      return (data != null ? _i26.SupportCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.SupportCategoryStatus?>()) {
      return (data != null ? _i27.SupportCategoryStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i28.SupportGoal?>()) {
      return (data != null ? _i28.SupportGoal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.SupportGoalCheck?>()) {
      return (data != null ? _i29.SupportGoalCheck.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.SupportLevel?>()) {
      return (data != null ? _i30.SupportLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.PupilDocumentType?>()) {
      return (data != null ? _i31.PupilDocumentType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.SiblingsTutorInfo?>()) {
      return (data != null ? _i32.SiblingsTutorInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.PupilData?>()) {
      return (data != null ? _i33.PupilData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.AfterSchoolCare?>()) {
      return (data != null ? _i34.AfterSchoolCare.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.AfterSchoolCarePickUpTimes?>()) {
      return (data != null
          ? _i35.AfterSchoolCarePickUpTimes.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i36.PickUpInfo?>()) {
      return (data != null ? _i36.PickUpInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.CommunicationSkills?>()) {
      return (data != null ? _i37.CommunicationSkills.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i38.Language?>()) {
      return (data != null ? _i38.Language.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.PublicMediaAuth?>()) {
      return (data != null ? _i39.PublicMediaAuth.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.TutorInfo?>()) {
      return (data != null ? _i40.TutorInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.KindergardenInfo?>()) {
      return (data != null ? _i41.KindergardenInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.PreSchoolMedical?>()) {
      return (data != null ? _i42.PreSchoolMedical.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.PreSchoolMedicalStatus?>()) {
      return (data != null ? _i43.PreSchoolMedicalStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i44.PreSchoolTest?>()) {
      return (data != null ? _i44.PreSchoolTest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.PupilListEntry?>()) {
      return (data != null ? _i45.PupilListEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.SchoolList?>()) {
      return (data != null ? _i46.SchoolList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.ContactedType?>()) {
      return (data != null ? _i47.ContactedType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.MissedClass?>()) {
      return (data != null ? _i48.MissedClass.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.MissedClassDto?>()) {
      return (data != null ? _i49.MissedClassDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.MissedType?>()) {
      return (data != null ? _i50.MissedType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.SchoolSemester?>()) {
      return (data != null ? _i51.SchoolSemester.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.Schoolday?>()) {
      return (data != null ? _i52.Schoolday.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.SchooldayEvent?>()) {
      return (data != null ? _i53.SchooldayEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.SchooldayEventType?>()) {
      return (data != null ? _i54.SchooldayEventType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i55.HubDocument?>()) {
      return (data != null ? _i55.HubDocument.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.MemberOperation?>()) {
      return (data != null ? _i56.MemberOperation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.LanguageStats?>()) {
      return (data != null ? _i57.LanguageStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.CreditTransaction?>()) {
      return (data != null ? _i58.CreditTransaction.fromJson(data) : null) as T;
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
    if (t == _i1.getType<List<_i3.PupilAuthorization>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i3.PupilAuthorization>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i6.BookTagging>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i6.BookTagging>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i7.LibraryBook>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i7.LibraryBook>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i6.BookTagging>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i6.BookTagging>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i10.PupilBookLending>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i10.PupilBookLending>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i6.BookTagging>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i6.BookTagging>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i7.LibraryBook>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i7.LibraryBook>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i55.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i55.HubDocument>(e)).toList()
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
    if (t == _i1.getType<List<_i13.CompetenceGoal>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i13.CompetenceGoal>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i12.CompetenceCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i12.CompetenceCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i15.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i15.CompetenceReportCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i55.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i55.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i55.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i55.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i15.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i15.CompetenceReportCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i17.LessonAttendance>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i17.LessonAttendance>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i21.ScheduledLesson>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i21.ScheduledLesson>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i19.ScheduledLessonGroupMembership>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.ScheduledLessonGroupMembership>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i16.Lesson>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i16.Lesson>(e)).toList()
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
    if (t == _i1.getType<List<_i21.ScheduledLesson>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i21.ScheduledLesson>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i21.ScheduledLesson>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i21.ScheduledLesson>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i28.SupportGoal>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i28.SupportGoal>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i27.SupportCategoryStatus>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i27.SupportCategoryStatus>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i55.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i55.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i29.SupportGoalCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i29.SupportGoalCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i55.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i55.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == Set<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toSet() as T;
    }
    if (t == _i1.getType<List<_i3.PupilAuthorization>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i3.PupilAuthorization>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i58.CreditTransaction>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i58.CreditTransaction>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i19.ScheduledLessonGroupMembership>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.ScheduledLessonGroupMembership>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i17.LessonAttendance>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i17.LessonAttendance>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i13.CompetenceGoal>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i13.CompetenceGoal>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i12.CompetenceCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i12.CompetenceCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i14.CompetenceReport>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i14.CompetenceReport>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i15.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i15.CompetenceReportCheck>(e))
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
    if (t == _i1.getType<List<_i10.PupilBookLending>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i10.PupilBookLending>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i30.SupportLevel>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i30.SupportLevel>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i27.SupportCategoryStatus>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i27.SupportCategoryStatus>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i28.SupportGoal>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i28.SupportGoal>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i48.MissedClass>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i48.MissedClass>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i53.SchooldayEvent>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i53.SchooldayEvent>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i45.PupilListEntry>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i45.PupilListEntry>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i55.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i55.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i55.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i55.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i45.PupilListEntry>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i45.PupilListEntry>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i52.Schoolday>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i52.Schoolday>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i14.CompetenceReport>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i14.CompetenceReport>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i48.MissedClass>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i48.MissedClass>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i53.SchooldayEvent>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i53.SchooldayEvent>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Set<_i38.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i38.Language>(e)).toSet()
          : null) as T;
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
    if (t == List<_i66.User>) {
      return (data as List).map((e) => deserialize<_i66.User>(e)).toList() as T;
    }
    if (t == Set<_i67.PupilData>) {
      return (data as List).map((e) => deserialize<_i67.PupilData>(e)).toSet()
          as T;
    }
    if (t == List<_i68.MissedClass>) {
      return (data as List)
          .map((e) => deserialize<_i68.MissedClass>(e))
          .toList() as T;
    }
    if (t ==
        _i1.getType<
            ({
              _i69.DeviceInfo? deviceInfo,
              _i70.AuthenticationResponse response
            })>()) {
      return (
        deviceInfo: ((data as Map)['n'] as Map)['deviceInfo'] == null
            ? null
            : deserialize<_i69.DeviceInfo>(data['n']['deviceInfo']),
        response:
            deserialize<_i70.AuthenticationResponse>(data['n']['response']),
      ) as T;
    }
    if (t == List<_i71.Authorization>) {
      return (data as List)
          .map((e) => deserialize<_i71.Authorization>(e))
          .toList() as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t ==
        _i1.getType<
            ({_i72.MemberOperation operation, List<int> pupilIds})?>()) {
      return (data == null)
          ? null as T
          : (
              operation: deserialize<_i72.MemberOperation>(
                  ((data as Map)['n'] as Map)['operation']),
              pupilIds: deserialize<List<int>>(data['n']['pupilIds']),
            ) as T;
    }
    if (t == List<_i73.BookTag>) {
      return (data as List).map((e) => deserialize<_i73.BookTag>(e)).toList()
          as T;
    }
    if (t == List<_i74.Book>) {
      return (data as List).map((e) => deserialize<_i74.Book>(e)).toList() as T;
    }
    if (t == List<_i75.LibraryBookLocation>) {
      return (data as List)
          .map((e) => deserialize<_i75.LibraryBookLocation>(e))
          .toList() as T;
    }
    if (t == List<_i76.LibraryBook>) {
      return (data as List)
          .map((e) => deserialize<_i76.LibraryBook>(e))
          .toList() as T;
    }
    if (t == List<_i77.PupilBookLending>) {
      return (data as List)
          .map((e) => deserialize<_i77.PupilBookLending>(e))
          .toList() as T;
    }
    if (t == List<_i78.Competence>) {
      return (data as List).map((e) => deserialize<_i78.Competence>(e)).toList()
          as T;
    }
    if (t == List<_i79.SupportCategory>) {
      return (data as List)
          .map((e) => deserialize<_i79.SupportCategory>(e))
          .toList() as T;
    }
    if (t == List<_i80.SupportCategoryStatus>) {
      return (data as List)
          .map((e) => deserialize<_i80.SupportCategoryStatus>(e))
          .toList() as T;
    }
    if (t == List<_i67.PupilData>) {
      return (data as List).map((e) => deserialize<_i67.PupilData>(e)).toList()
          as T;
    }
    if (t == Set<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toSet() as T;
    }
    if (t == List<_i81.SchoolList>) {
      return (data as List).map((e) => deserialize<_i81.SchoolList>(e)).toList()
          as T;
    }
    if (t == List<_i82.SchoolSemester>) {
      return (data as List)
          .map((e) => deserialize<_i82.SchoolSemester>(e))
          .toList() as T;
    }
    if (t == List<_i83.Schoolday>) {
      return (data as List).map((e) => deserialize<_i83.Schoolday>(e)).toList()
          as T;
    }
    if (t == List<DateTime>) {
      return (data as List).map((e) => deserialize<DateTime>(e)).toList() as T;
    }
    if (t == List<_i84.SchooldayEvent>) {
      return (data as List)
          .map((e) => deserialize<_i84.SchooldayEvent>(e))
          .toList() as T;
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
      return _i70.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.Authorization) {
      return 'Authorization';
    }
    if (data is _i3.PupilAuthorization) {
      return 'PupilAuthorization';
    }
    if (data is _i4.Book) {
      return 'Book';
    }
    if (data is _i5.BookTag) {
      return 'BookTag';
    }
    if (data is _i6.BookTagging) {
      return 'BookTagging';
    }
    if (data is _i7.LibraryBook) {
      return 'LibraryBook';
    }
    if (data is _i8.LibraryBookQuery) {
      return 'LibraryBookQuery';
    }
    if (data is _i9.LibraryBookLocation) {
      return 'LibraryBookLocation';
    }
    if (data is _i10.PupilBookLending) {
      return 'PupilBookLending';
    }
    if (data is _i11.Competence) {
      return 'Competence';
    }
    if (data is _i12.CompetenceCheck) {
      return 'CompetenceCheck';
    }
    if (data is _i13.CompetenceGoal) {
      return 'CompetenceGoal';
    }
    if (data is _i14.CompetenceReport) {
      return 'CompetenceReport';
    }
    if (data is _i15.CompetenceReportCheck) {
      return 'CompetenceReportCheck';
    }
    if (data is _i16.Lesson) {
      return 'Lesson';
    }
    if (data is _i17.LessonAttendance) {
      return 'LessonAttendance';
    }
    if (data is _i18.LessonGroup) {
      return 'LessonGroup';
    }
    if (data is _i19.ScheduledLessonGroupMembership) {
      return 'ScheduledLessonGroupMembership';
    }
    if (data is _i20.LessonSubject) {
      return 'LessonSubject';
    }
    if (data is _i21.ScheduledLesson) {
      return 'ScheduledLesson';
    }
    if (data is _i22.Subject) {
      return 'Subject';
    }
    if (data is _i23.TimetableSlot) {
      return 'TimetableSlot';
    }
    if (data is _i24.Weekday) {
      return 'Weekday';
    }
    if (data is _i25.Room) {
      return 'Room';
    }
    if (data is _i26.SupportCategory) {
      return 'SupportCategory';
    }
    if (data is _i27.SupportCategoryStatus) {
      return 'SupportCategoryStatus';
    }
    if (data is _i28.SupportGoal) {
      return 'SupportGoal';
    }
    if (data is _i29.SupportGoalCheck) {
      return 'SupportGoalCheck';
    }
    if (data is _i30.SupportLevel) {
      return 'SupportLevel';
    }
    if (data is _i31.PupilDocumentType) {
      return 'PupilDocumentType';
    }
    if (data is _i32.SiblingsTutorInfo) {
      return 'SiblingsTutorInfo';
    }
    if (data is _i33.PupilData) {
      return 'PupilData';
    }
    if (data is _i34.AfterSchoolCare) {
      return 'AfterSchoolCare';
    }
    if (data is _i35.AfterSchoolCarePickUpTimes) {
      return 'AfterSchoolCarePickUpTimes';
    }
    if (data is _i36.PickUpInfo) {
      return 'PickUpInfo';
    }
    if (data is _i37.CommunicationSkills) {
      return 'CommunicationSkills';
    }
    if (data is _i38.Language) {
      return 'Language';
    }
    if (data is _i39.PublicMediaAuth) {
      return 'PublicMediaAuth';
    }
    if (data is _i40.TutorInfo) {
      return 'TutorInfo';
    }
    if (data is _i41.KindergardenInfo) {
      return 'KindergardenInfo';
    }
    if (data is _i42.PreSchoolMedical) {
      return 'PreSchoolMedical';
    }
    if (data is _i43.PreSchoolMedicalStatus) {
      return 'PreSchoolMedicalStatus';
    }
    if (data is _i44.PreSchoolTest) {
      return 'PreSchoolTest';
    }
    if (data is _i45.PupilListEntry) {
      return 'PupilListEntry';
    }
    if (data is _i46.SchoolList) {
      return 'SchoolList';
    }
    if (data is _i47.ContactedType) {
      return 'ContactedType';
    }
    if (data is _i48.MissedClass) {
      return 'MissedClass';
    }
    if (data is _i49.MissedClassDto) {
      return 'MissedClassDto';
    }
    if (data is _i50.MissedType) {
      return 'MissedType';
    }
    if (data is _i51.SchoolSemester) {
      return 'SchoolSemester';
    }
    if (data is _i52.Schoolday) {
      return 'Schoolday';
    }
    if (data is _i53.SchooldayEvent) {
      return 'SchooldayEvent';
    }
    if (data is _i54.SchooldayEventType) {
      return 'SchooldayEventType';
    }
    if (data is _i55.HubDocument) {
      return 'HubDocument';
    }
    if (data is _i56.MemberOperation) {
      return 'MemberOperation';
    }
    if (data is _i57.LanguageStats) {
      return 'LanguageStats';
    }
    if (data is _i58.CreditTransaction) {
      return 'CreditTransaction';
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
    className = _i70.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    if (data is List<_i67.PupilData>) {
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
    if (dataClassName == 'Authorization') {
      return deserialize<_i2.Authorization>(data['data']);
    }
    if (dataClassName == 'PupilAuthorization') {
      return deserialize<_i3.PupilAuthorization>(data['data']);
    }
    if (dataClassName == 'Book') {
      return deserialize<_i4.Book>(data['data']);
    }
    if (dataClassName == 'BookTag') {
      return deserialize<_i5.BookTag>(data['data']);
    }
    if (dataClassName == 'BookTagging') {
      return deserialize<_i6.BookTagging>(data['data']);
    }
    if (dataClassName == 'LibraryBook') {
      return deserialize<_i7.LibraryBook>(data['data']);
    }
    if (dataClassName == 'LibraryBookQuery') {
      return deserialize<_i8.LibraryBookQuery>(data['data']);
    }
    if (dataClassName == 'LibraryBookLocation') {
      return deserialize<_i9.LibraryBookLocation>(data['data']);
    }
    if (dataClassName == 'PupilBookLending') {
      return deserialize<_i10.PupilBookLending>(data['data']);
    }
    if (dataClassName == 'Competence') {
      return deserialize<_i11.Competence>(data['data']);
    }
    if (dataClassName == 'CompetenceCheck') {
      return deserialize<_i12.CompetenceCheck>(data['data']);
    }
    if (dataClassName == 'CompetenceGoal') {
      return deserialize<_i13.CompetenceGoal>(data['data']);
    }
    if (dataClassName == 'CompetenceReport') {
      return deserialize<_i14.CompetenceReport>(data['data']);
    }
    if (dataClassName == 'CompetenceReportCheck') {
      return deserialize<_i15.CompetenceReportCheck>(data['data']);
    }
    if (dataClassName == 'Lesson') {
      return deserialize<_i16.Lesson>(data['data']);
    }
    if (dataClassName == 'LessonAttendance') {
      return deserialize<_i17.LessonAttendance>(data['data']);
    }
    if (dataClassName == 'LessonGroup') {
      return deserialize<_i18.LessonGroup>(data['data']);
    }
    if (dataClassName == 'ScheduledLessonGroupMembership') {
      return deserialize<_i19.ScheduledLessonGroupMembership>(data['data']);
    }
    if (dataClassName == 'LessonSubject') {
      return deserialize<_i20.LessonSubject>(data['data']);
    }
    if (dataClassName == 'ScheduledLesson') {
      return deserialize<_i21.ScheduledLesson>(data['data']);
    }
    if (dataClassName == 'Subject') {
      return deserialize<_i22.Subject>(data['data']);
    }
    if (dataClassName == 'TimetableSlot') {
      return deserialize<_i23.TimetableSlot>(data['data']);
    }
    if (dataClassName == 'Weekday') {
      return deserialize<_i24.Weekday>(data['data']);
    }
    if (dataClassName == 'Room') {
      return deserialize<_i25.Room>(data['data']);
    }
    if (dataClassName == 'SupportCategory') {
      return deserialize<_i26.SupportCategory>(data['data']);
    }
    if (dataClassName == 'SupportCategoryStatus') {
      return deserialize<_i27.SupportCategoryStatus>(data['data']);
    }
    if (dataClassName == 'SupportGoal') {
      return deserialize<_i28.SupportGoal>(data['data']);
    }
    if (dataClassName == 'SupportGoalCheck') {
      return deserialize<_i29.SupportGoalCheck>(data['data']);
    }
    if (dataClassName == 'SupportLevel') {
      return deserialize<_i30.SupportLevel>(data['data']);
    }
    if (dataClassName == 'PupilDocumentType') {
      return deserialize<_i31.PupilDocumentType>(data['data']);
    }
    if (dataClassName == 'SiblingsTutorInfo') {
      return deserialize<_i32.SiblingsTutorInfo>(data['data']);
    }
    if (dataClassName == 'PupilData') {
      return deserialize<_i33.PupilData>(data['data']);
    }
    if (dataClassName == 'AfterSchoolCare') {
      return deserialize<_i34.AfterSchoolCare>(data['data']);
    }
    if (dataClassName == 'AfterSchoolCarePickUpTimes') {
      return deserialize<_i35.AfterSchoolCarePickUpTimes>(data['data']);
    }
    if (dataClassName == 'PickUpInfo') {
      return deserialize<_i36.PickUpInfo>(data['data']);
    }
    if (dataClassName == 'CommunicationSkills') {
      return deserialize<_i37.CommunicationSkills>(data['data']);
    }
    if (dataClassName == 'Language') {
      return deserialize<_i38.Language>(data['data']);
    }
    if (dataClassName == 'PublicMediaAuth') {
      return deserialize<_i39.PublicMediaAuth>(data['data']);
    }
    if (dataClassName == 'TutorInfo') {
      return deserialize<_i40.TutorInfo>(data['data']);
    }
    if (dataClassName == 'KindergardenInfo') {
      return deserialize<_i41.KindergardenInfo>(data['data']);
    }
    if (dataClassName == 'PreSchoolMedical') {
      return deserialize<_i42.PreSchoolMedical>(data['data']);
    }
    if (dataClassName == 'PreSchoolMedicalStatus') {
      return deserialize<_i43.PreSchoolMedicalStatus>(data['data']);
    }
    if (dataClassName == 'PreSchoolTest') {
      return deserialize<_i44.PreSchoolTest>(data['data']);
    }
    if (dataClassName == 'PupilListEntry') {
      return deserialize<_i45.PupilListEntry>(data['data']);
    }
    if (dataClassName == 'SchoolList') {
      return deserialize<_i46.SchoolList>(data['data']);
    }
    if (dataClassName == 'ContactedType') {
      return deserialize<_i47.ContactedType>(data['data']);
    }
    if (dataClassName == 'MissedClass') {
      return deserialize<_i48.MissedClass>(data['data']);
    }
    if (dataClassName == 'MissedClassDto') {
      return deserialize<_i49.MissedClassDto>(data['data']);
    }
    if (dataClassName == 'MissedType') {
      return deserialize<_i50.MissedType>(data['data']);
    }
    if (dataClassName == 'SchoolSemester') {
      return deserialize<_i51.SchoolSemester>(data['data']);
    }
    if (dataClassName == 'Schoolday') {
      return deserialize<_i52.Schoolday>(data['data']);
    }
    if (dataClassName == 'SchooldayEvent') {
      return deserialize<_i53.SchooldayEvent>(data['data']);
    }
    if (dataClassName == 'SchooldayEventType') {
      return deserialize<_i54.SchooldayEventType>(data['data']);
    }
    if (dataClassName == 'HubDocument') {
      return deserialize<_i55.HubDocument>(data['data']);
    }
    if (dataClassName == 'MemberOperation') {
      return deserialize<_i56.MemberOperation>(data['data']);
    }
    if (dataClassName == 'LanguageStats') {
      return deserialize<_i57.LanguageStats>(data['data']);
    }
    if (dataClassName == 'CreditTransaction') {
      return deserialize<_i58.CreditTransaction>(data['data']);
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
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i70.Protocol().deserializeByClassName(data);
    }
    if (dataClassName == 'List<PupilData>') {
      return deserialize<List<_i67.PupilData>>(data['data']);
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
  if (record is ({
    _i69.DeviceInfo? deviceInfo,
    _i70.AuthenticationResponse response
  })) {
    return {
      "n": {
        "deviceInfo": record.deviceInfo,
        "response": record.response,
      },
    };
  }
  if (record is ({_i72.MemberOperation operation, List<int> pupilIds})) {
    return {
      "n": {
        "operation": record.operation,
        "pupilIds": record.pupilIds,
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

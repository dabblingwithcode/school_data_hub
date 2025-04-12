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
import 'book/library_book.dart' as _i7;
import 'book/location/library_book_location.dart' as _i8;
import 'book/pupil_book_lending.dart' as _i9;
import 'book/pupil_book_lending_file.dart' as _i10;
import 'example.dart' as _i11;
import 'learning/competence.dart' as _i12;
import 'learning/competence_check.dart' as _i13;
import 'learning/competence_goal.dart' as _i14;
import 'learning/competence_report.dart' as _i15;
import 'learning/competence_report_check.dart' as _i16;
import 'learning/timetable/lesson/lesson.dart' as _i17;
import 'learning/timetable/lesson/lesson_attendance.dart' as _i18;
import 'learning/timetable/lesson/lesson_group.dart' as _i19;
import 'learning/timetable/lesson/lesson_group_membership.dart' as _i20;
import 'learning/timetable/lesson/lesson_subject.dart' as _i21;
import 'learning/timetable/lesson/scheduled_lesson.dart' as _i22;
import 'learning/timetable/lesson/subject.dart' as _i23;
import 'learning/timetable/lesson/timetable_slot.dart' as _i24;
import 'learning/timetable/lesson/weekday_enum.dart' as _i25;
import 'learning/timetable/room.dart' as _i26;
import 'learning_support/support_category.dart' as _i27;
import 'learning_support/support_category_status.dart' as _i28;
import 'learning_support/support_goal/support_goal.dart' as _i29;
import 'learning_support/support_goal/support_goal_check.dart' as _i30;
import 'learning_support/support_goal/support_goal_check_file.dart' as _i31;
import 'learning_support/support_level.dart' as _i32;
import 'pupil_data/dto/siblings_parent_info_dto.dart' as _i33;
import 'pupil_data/pupil_data.dart' as _i34;
import 'pupil_data/pupil_objects/after_school_care/after_school_care.dart'
    as _i35;
import 'pupil_data/pupil_objects/after_school_care/after_school_pickup_times.dart'
    as _i36;
import 'pupil_data/pupil_objects/after_school_care/pick_up_info.dart' as _i37;
import 'pupil_data/pupil_objects/communication/communication_skills.dart'
    as _i38;
import 'pupil_data/pupil_objects/communication/language.dart' as _i39;
import 'pupil_data/pupil_objects/communication/public_media_auth.dart' as _i40;
import 'pupil_data/pupil_objects/communication/pupil_data_tutor_info.dart'
    as _i41;
import 'pupil_data/pupil_objects/preschool/kindergarden_info.dart' as _i42;
import 'pupil_data/pupil_objects/preschool/pre_school_medical.dart' as _i43;
import 'pupil_data/pupil_objects/preschool/pre_school_medical_status.dart'
    as _i44;
import 'pupil_data/pupil_objects/preschool/pre_school_test.dart' as _i45;
import 'school_list/pupil_list.dart' as _i46;
import 'school_list/school_list.dart' as _i47;
import 'schoolday/missed_class.dart' as _i48;
import 'schoolday/school_semester.dart' as _i49;
import 'schoolday/schoolday.dart' as _i50;
import 'schoolday/schoolday_event.dart' as _i51;
import 'shared/document.dart' as _i52;
import 'stats/language_stats.dart' as _i53;
import 'user/credit_transaction.dart' as _i54;
import 'user/device_info.dart' as _i55;
import 'user/roles/roles.dart' as _i56;
import 'user/staff_user.dart' as _i57;
import 'user/user_device.dart' as _i58;
import 'user/user_flags.dart' as _i59;
import 'workbook/pupil_workbook.dart' as _i60;
import 'workbook/workbook.dart' as _i61;
import 'package:school_data_hub_client/src/protocol/user/staff_user.dart'
    as _i62;
import 'package:school_data_hub_client/src/protocol/user/device_info.dart'
    as _i63;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i64;
import 'package:school_data_hub_client/src/protocol/learning/competence.dart'
    as _i65;
import 'package:school_data_hub_client/src/protocol/schoolday/missed_class.dart'
    as _i66;
import 'package:school_data_hub_client/src/protocol/pupil_data/pupil_data.dart'
    as _i67;
import 'package:school_data_hub_client/src/protocol/schoolday/school_semester.dart'
    as _i68;
import 'package:school_data_hub_client/src/protocol/schoolday/schoolday.dart'
    as _i69;
import 'package:school_data_hub_client/src/protocol/learning_support/support_category.dart'
    as _i70;
export 'authorization/authorization.dart';
export 'authorization/pupil_authorization.dart';
export 'book/book.dart';
export 'book/book_tagging/book_tag.dart';
export 'book/book_tagging/book_tagging.dart';
export 'book/library_book.dart';
export 'book/location/library_book_location.dart';
export 'book/pupil_book_lending.dart';
export 'book/pupil_book_lending_file.dart';
export 'example.dart';
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
export 'learning_support/support_goal/support_goal_check_file.dart';
export 'learning_support/support_level.dart';
export 'pupil_data/dto/siblings_parent_info_dto.dart';
export 'pupil_data/pupil_data.dart';
export 'pupil_data/pupil_objects/after_school_care/after_school_care.dart';
export 'pupil_data/pupil_objects/after_school_care/after_school_pickup_times.dart';
export 'pupil_data/pupil_objects/after_school_care/pick_up_info.dart';
export 'pupil_data/pupil_objects/communication/communication_skills.dart';
export 'pupil_data/pupil_objects/communication/language.dart';
export 'pupil_data/pupil_objects/communication/public_media_auth.dart';
export 'pupil_data/pupil_objects/communication/pupil_data_tutor_info.dart';
export 'pupil_data/pupil_objects/preschool/kindergarden_info.dart';
export 'pupil_data/pupil_objects/preschool/pre_school_medical.dart';
export 'pupil_data/pupil_objects/preschool/pre_school_medical_status.dart';
export 'pupil_data/pupil_objects/preschool/pre_school_test.dart';
export 'school_list/pupil_list.dart';
export 'school_list/school_list.dart';
export 'schoolday/missed_class.dart';
export 'schoolday/school_semester.dart';
export 'schoolday/schoolday.dart';
export 'schoolday/schoolday_event.dart';
export 'shared/document.dart';
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
    if (t == _i8.LibraryBookLocation) {
      return _i8.LibraryBookLocation.fromJson(data) as T;
    }
    if (t == _i9.PupilBookLending) {
      return _i9.PupilBookLending.fromJson(data) as T;
    }
    if (t == _i10.PupilBookLendingFile) {
      return _i10.PupilBookLendingFile.fromJson(data) as T;
    }
    if (t == _i11.Example) {
      return _i11.Example.fromJson(data) as T;
    }
    if (t == _i12.Competence) {
      return _i12.Competence.fromJson(data) as T;
    }
    if (t == _i13.CompetenceCheck) {
      return _i13.CompetenceCheck.fromJson(data) as T;
    }
    if (t == _i14.CompetenceGoal) {
      return _i14.CompetenceGoal.fromJson(data) as T;
    }
    if (t == _i15.CompetenceReport) {
      return _i15.CompetenceReport.fromJson(data) as T;
    }
    if (t == _i16.CompetenceReportCheck) {
      return _i16.CompetenceReportCheck.fromJson(data) as T;
    }
    if (t == _i17.Lesson) {
      return _i17.Lesson.fromJson(data) as T;
    }
    if (t == _i18.LessonAttendance) {
      return _i18.LessonAttendance.fromJson(data) as T;
    }
    if (t == _i19.LessonGroup) {
      return _i19.LessonGroup.fromJson(data) as T;
    }
    if (t == _i20.ScheduledLessonGroupMembership) {
      return _i20.ScheduledLessonGroupMembership.fromJson(data) as T;
    }
    if (t == _i21.LessonSubject) {
      return _i21.LessonSubject.fromJson(data) as T;
    }
    if (t == _i22.ScheduledLesson) {
      return _i22.ScheduledLesson.fromJson(data) as T;
    }
    if (t == _i23.Subject) {
      return _i23.Subject.fromJson(data) as T;
    }
    if (t == _i24.TimetableSlot) {
      return _i24.TimetableSlot.fromJson(data) as T;
    }
    if (t == _i25.Weekday) {
      return _i25.Weekday.fromJson(data) as T;
    }
    if (t == _i26.Room) {
      return _i26.Room.fromJson(data) as T;
    }
    if (t == _i27.SupportCategory) {
      return _i27.SupportCategory.fromJson(data) as T;
    }
    if (t == _i28.SupportCategoryStatus) {
      return _i28.SupportCategoryStatus.fromJson(data) as T;
    }
    if (t == _i29.SupportGoal) {
      return _i29.SupportGoal.fromJson(data) as T;
    }
    if (t == _i30.SupportGoalCheck) {
      return _i30.SupportGoalCheck.fromJson(data) as T;
    }
    if (t == _i31.SupportGoalCheckFile) {
      return _i31.SupportGoalCheckFile.fromJson(data) as T;
    }
    if (t == _i32.SupportLevel) {
      return _i32.SupportLevel.fromJson(data) as T;
    }
    if (t == _i33.SiblingsParentInfo) {
      return _i33.SiblingsParentInfo.fromJson(data) as T;
    }
    if (t == _i34.PupilData) {
      return _i34.PupilData.fromJson(data) as T;
    }
    if (t == _i35.AfterSchoolCare) {
      return _i35.AfterSchoolCare.fromJson(data) as T;
    }
    if (t == _i36.AfterSchoolCarePickUpTimes) {
      return _i36.AfterSchoolCarePickUpTimes.fromJson(data) as T;
    }
    if (t == _i37.PickUpInfo) {
      return _i37.PickUpInfo.fromJson(data) as T;
    }
    if (t == _i38.CommunicationSkills) {
      return _i38.CommunicationSkills.fromJson(data) as T;
    }
    if (t == _i39.Language) {
      return _i39.Language.fromJson(data) as T;
    }
    if (t == _i40.PublicMediaAuth) {
      return _i40.PublicMediaAuth.fromJson(data) as T;
    }
    if (t == _i41.PupilDataTutorInfo) {
      return _i41.PupilDataTutorInfo.fromJson(data) as T;
    }
    if (t == _i42.KindergardenInfo) {
      return _i42.KindergardenInfo.fromJson(data) as T;
    }
    if (t == _i43.PreSchoolMedical) {
      return _i43.PreSchoolMedical.fromJson(data) as T;
    }
    if (t == _i44.PreSchoolMedicalStatus) {
      return _i44.PreSchoolMedicalStatus.fromJson(data) as T;
    }
    if (t == _i45.PreSchoolTest) {
      return _i45.PreSchoolTest.fromJson(data) as T;
    }
    if (t == _i46.PupilList) {
      return _i46.PupilList.fromJson(data) as T;
    }
    if (t == _i47.SchoolList) {
      return _i47.SchoolList.fromJson(data) as T;
    }
    if (t == _i48.MissedClass) {
      return _i48.MissedClass.fromJson(data) as T;
    }
    if (t == _i49.SchoolSemester) {
      return _i49.SchoolSemester.fromJson(data) as T;
    }
    if (t == _i50.Schoolday) {
      return _i50.Schoolday.fromJson(data) as T;
    }
    if (t == _i51.SchooldayEvent) {
      return _i51.SchooldayEvent.fromJson(data) as T;
    }
    if (t == _i52.HubDocument) {
      return _i52.HubDocument.fromJson(data) as T;
    }
    if (t == _i53.LanguageStats) {
      return _i53.LanguageStats.fromJson(data) as T;
    }
    if (t == _i54.CreditTransaction) {
      return _i54.CreditTransaction.fromJson(data) as T;
    }
    if (t == _i55.DeviceInfo) {
      return _i55.DeviceInfo.fromJson(data) as T;
    }
    if (t == _i56.Role) {
      return _i56.Role.fromJson(data) as T;
    }
    if (t == _i57.User) {
      return _i57.User.fromJson(data) as T;
    }
    if (t == _i58.UserDevice) {
      return _i58.UserDevice.fromJson(data) as T;
    }
    if (t == _i59.UserFlags) {
      return _i59.UserFlags.fromJson(data) as T;
    }
    if (t == _i60.PupilWorkbook) {
      return _i60.PupilWorkbook.fromJson(data) as T;
    }
    if (t == _i61.Workbook) {
      return _i61.Workbook.fromJson(data) as T;
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
    if (t == _i1.getType<_i8.LibraryBookLocation?>()) {
      return (data != null ? _i8.LibraryBookLocation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.PupilBookLending?>()) {
      return (data != null ? _i9.PupilBookLending.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.PupilBookLendingFile?>()) {
      return (data != null ? _i10.PupilBookLendingFile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.Example?>()) {
      return (data != null ? _i11.Example.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.Competence?>()) {
      return (data != null ? _i12.Competence.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.CompetenceCheck?>()) {
      return (data != null ? _i13.CompetenceCheck.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.CompetenceGoal?>()) {
      return (data != null ? _i14.CompetenceGoal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.CompetenceReport?>()) {
      return (data != null ? _i15.CompetenceReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.CompetenceReportCheck?>()) {
      return (data != null ? _i16.CompetenceReportCheck.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.Lesson?>()) {
      return (data != null ? _i17.Lesson.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.LessonAttendance?>()) {
      return (data != null ? _i18.LessonAttendance.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.LessonGroup?>()) {
      return (data != null ? _i19.LessonGroup.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.ScheduledLessonGroupMembership?>()) {
      return (data != null
          ? _i20.ScheduledLessonGroupMembership.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i21.LessonSubject?>()) {
      return (data != null ? _i21.LessonSubject.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.ScheduledLesson?>()) {
      return (data != null ? _i22.ScheduledLesson.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.Subject?>()) {
      return (data != null ? _i23.Subject.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.TimetableSlot?>()) {
      return (data != null ? _i24.TimetableSlot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.Weekday?>()) {
      return (data != null ? _i25.Weekday.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.Room?>()) {
      return (data != null ? _i26.Room.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.SupportCategory?>()) {
      return (data != null ? _i27.SupportCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.SupportCategoryStatus?>()) {
      return (data != null ? _i28.SupportCategoryStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i29.SupportGoal?>()) {
      return (data != null ? _i29.SupportGoal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.SupportGoalCheck?>()) {
      return (data != null ? _i30.SupportGoalCheck.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.SupportGoalCheckFile?>()) {
      return (data != null ? _i31.SupportGoalCheckFile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i32.SupportLevel?>()) {
      return (data != null ? _i32.SupportLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.SiblingsParentInfo?>()) {
      return (data != null ? _i33.SiblingsParentInfo.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i34.PupilData?>()) {
      return (data != null ? _i34.PupilData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.AfterSchoolCare?>()) {
      return (data != null ? _i35.AfterSchoolCare.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.AfterSchoolCarePickUpTimes?>()) {
      return (data != null
          ? _i36.AfterSchoolCarePickUpTimes.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i37.PickUpInfo?>()) {
      return (data != null ? _i37.PickUpInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.CommunicationSkills?>()) {
      return (data != null ? _i38.CommunicationSkills.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i39.Language?>()) {
      return (data != null ? _i39.Language.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.PublicMediaAuth?>()) {
      return (data != null ? _i40.PublicMediaAuth.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.PupilDataTutorInfo?>()) {
      return (data != null ? _i41.PupilDataTutorInfo.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i42.KindergardenInfo?>()) {
      return (data != null ? _i42.KindergardenInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.PreSchoolMedical?>()) {
      return (data != null ? _i43.PreSchoolMedical.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.PreSchoolMedicalStatus?>()) {
      return (data != null ? _i44.PreSchoolMedicalStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i45.PreSchoolTest?>()) {
      return (data != null ? _i45.PreSchoolTest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.PupilList?>()) {
      return (data != null ? _i46.PupilList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.SchoolList?>()) {
      return (data != null ? _i47.SchoolList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.MissedClass?>()) {
      return (data != null ? _i48.MissedClass.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.SchoolSemester?>()) {
      return (data != null ? _i49.SchoolSemester.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.Schoolday?>()) {
      return (data != null ? _i50.Schoolday.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.SchooldayEvent?>()) {
      return (data != null ? _i51.SchooldayEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.HubDocument?>()) {
      return (data != null ? _i52.HubDocument.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.LanguageStats?>()) {
      return (data != null ? _i53.LanguageStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.CreditTransaction?>()) {
      return (data != null ? _i54.CreditTransaction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.DeviceInfo?>()) {
      return (data != null ? _i55.DeviceInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.Role?>()) {
      return (data != null ? _i56.Role.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.User?>()) {
      return (data != null ? _i57.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.UserDevice?>()) {
      return (data != null ? _i58.UserDevice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.UserFlags?>()) {
      return (data != null ? _i59.UserFlags.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i60.PupilWorkbook?>()) {
      return (data != null ? _i60.PupilWorkbook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.Workbook?>()) {
      return (data != null ? _i61.Workbook.fromJson(data) : null) as T;
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
    if (t == _i1.getType<List<_i9.PupilBookLending>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i9.PupilBookLending>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i7.LibraryBook>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i7.LibraryBook>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i10.PupilBookLendingFile>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i10.PupilBookLendingFile>(e))
              .toList()
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
    if (t == _i1.getType<List<_i14.CompetenceGoal>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i14.CompetenceGoal>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i13.CompetenceCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i13.CompetenceCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i16.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i16.CompetenceReportCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i52.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i52.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i52.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i52.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i16.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i16.CompetenceReportCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i18.LessonAttendance>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i18.LessonAttendance>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i22.ScheduledLesson>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i22.ScheduledLesson>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i20.ScheduledLessonGroupMembership>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i20.ScheduledLessonGroupMembership>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i17.Lesson>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i17.Lesson>(e)).toList()
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
    if (t == _i1.getType<List<_i22.ScheduledLesson>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i22.ScheduledLesson>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i22.ScheduledLesson>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i22.ScheduledLesson>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i29.SupportGoal>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i29.SupportGoal>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i28.SupportCategoryStatus>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i28.SupportCategoryStatus>(e))
              .toList()
          : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<List<_i30.SupportGoalCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i30.SupportGoalCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i31.SupportGoalCheckFile>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i31.SupportGoalCheckFile>(e))
              .toList()
          : null) as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _i1.getType<List<_i3.PupilAuthorization>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i3.PupilAuthorization>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i54.CreditTransaction>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i54.CreditTransaction>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i20.ScheduledLessonGroupMembership>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i20.ScheduledLessonGroupMembership>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i18.LessonAttendance>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i18.LessonAttendance>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i14.CompetenceGoal>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i14.CompetenceGoal>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i13.CompetenceCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i13.CompetenceCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i15.CompetenceReport>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i15.CompetenceReport>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i16.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i16.CompetenceReportCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i60.PupilWorkbook>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i60.PupilWorkbook>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i9.PupilBookLending>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i9.PupilBookLending>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i32.SupportLevel>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i32.SupportLevel>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i28.SupportCategoryStatus>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i28.SupportCategoryStatus>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i29.SupportGoal>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i29.SupportGoal>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i48.MissedClass>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i48.MissedClass>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i51.SchooldayEvent>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i51.SchooldayEvent>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i46.PupilList>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i46.PupilList>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i52.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i52.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i52.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i52.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Set<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toSet()
          : null) as T;
    }
    if (t == _i1.getType<List<_i46.PupilList>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i46.PupilList>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i50.Schoolday>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i50.Schoolday>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i15.CompetenceReport>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i15.CompetenceReport>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i48.MissedClass>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i48.MissedClass>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i51.SchooldayEvent>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i51.SchooldayEvent>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Set<_i39.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i39.Language>(e)).toSet()
          : null) as T;
    }
    if (t == _i1.getType<Set<int>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<int>(e)).toSet()
          : null) as T;
    }
    if (t == _i1.getType<List<_i60.PupilWorkbook>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i60.PupilWorkbook>(e))
              .toList()
          : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i62.User>) {
      return (data as List).map((e) => deserialize<_i62.User>(e)).toList() as T;
    }
    if (t ==
        _i1.getType<
            ({
              _i63.DeviceInfo? deviceInfo,
              _i64.AuthenticationResponse response
            })>()) {
      return (
        deviceInfo: ((data as Map)['n'] as Map)['deviceInfo'] == null
            ? null
            : deserialize<_i63.DeviceInfo>(data['n']['deviceInfo']),
        response:
            deserialize<_i64.AuthenticationResponse>(data['n']['response']),
      ) as T;
    }
    if (t == List<_i65.Competence>) {
      return (data as List).map((e) => deserialize<_i65.Competence>(e)).toList()
          as T;
    }
    if (t == List<_i66.MissedClass>) {
      return (data as List)
          .map((e) => deserialize<_i66.MissedClass>(e))
          .toList() as T;
    }
    if (t == List<_i67.PupilData>) {
      return (data as List).map((e) => deserialize<_i67.PupilData>(e)).toList()
          as T;
    }
    if (t == List<_i68.SchoolSemester>) {
      return (data as List)
          .map((e) => deserialize<_i68.SchoolSemester>(e))
          .toList() as T;
    }
    if (t == List<_i69.Schoolday>) {
      return (data as List).map((e) => deserialize<_i69.Schoolday>(e)).toList()
          as T;
    }
    if (t == List<DateTime>) {
      return (data as List).map((e) => deserialize<DateTime>(e)).toList() as T;
    }
    if (t == List<_i70.SupportCategory>) {
      return (data as List)
          .map((e) => deserialize<_i70.SupportCategory>(e))
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
      return _i64.Protocol().deserialize<T>(data, t);
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
    if (data is _i8.LibraryBookLocation) {
      return 'LibraryBookLocation';
    }
    if (data is _i9.PupilBookLending) {
      return 'PupilBookLending';
    }
    if (data is _i10.PupilBookLendingFile) {
      return 'PupilBookLendingFile';
    }
    if (data is _i11.Example) {
      return 'Example';
    }
    if (data is _i12.Competence) {
      return 'Competence';
    }
    if (data is _i13.CompetenceCheck) {
      return 'CompetenceCheck';
    }
    if (data is _i14.CompetenceGoal) {
      return 'CompetenceGoal';
    }
    if (data is _i15.CompetenceReport) {
      return 'CompetenceReport';
    }
    if (data is _i16.CompetenceReportCheck) {
      return 'CompetenceReportCheck';
    }
    if (data is _i17.Lesson) {
      return 'Lesson';
    }
    if (data is _i18.LessonAttendance) {
      return 'LessonAttendance';
    }
    if (data is _i19.LessonGroup) {
      return 'LessonGroup';
    }
    if (data is _i20.ScheduledLessonGroupMembership) {
      return 'ScheduledLessonGroupMembership';
    }
    if (data is _i21.LessonSubject) {
      return 'LessonSubject';
    }
    if (data is _i22.ScheduledLesson) {
      return 'ScheduledLesson';
    }
    if (data is _i23.Subject) {
      return 'Subject';
    }
    if (data is _i24.TimetableSlot) {
      return 'TimetableSlot';
    }
    if (data is _i25.Weekday) {
      return 'Weekday';
    }
    if (data is _i26.Room) {
      return 'Room';
    }
    if (data is _i27.SupportCategory) {
      return 'SupportCategory';
    }
    if (data is _i28.SupportCategoryStatus) {
      return 'SupportCategoryStatus';
    }
    if (data is _i29.SupportGoal) {
      return 'SupportGoal';
    }
    if (data is _i30.SupportGoalCheck) {
      return 'SupportGoalCheck';
    }
    if (data is _i31.SupportGoalCheckFile) {
      return 'SupportGoalCheckFile';
    }
    if (data is _i32.SupportLevel) {
      return 'SupportLevel';
    }
    if (data is _i33.SiblingsParentInfo) {
      return 'SiblingsParentInfo';
    }
    if (data is _i34.PupilData) {
      return 'PupilData';
    }
    if (data is _i35.AfterSchoolCare) {
      return 'AfterSchoolCare';
    }
    if (data is _i36.AfterSchoolCarePickUpTimes) {
      return 'AfterSchoolCarePickUpTimes';
    }
    if (data is _i37.PickUpInfo) {
      return 'PickUpInfo';
    }
    if (data is _i38.CommunicationSkills) {
      return 'CommunicationSkills';
    }
    if (data is _i39.Language) {
      return 'Language';
    }
    if (data is _i40.PublicMediaAuth) {
      return 'PublicMediaAuth';
    }
    if (data is _i41.PupilDataTutorInfo) {
      return 'PupilDataTutorInfo';
    }
    if (data is _i42.KindergardenInfo) {
      return 'KindergardenInfo';
    }
    if (data is _i43.PreSchoolMedical) {
      return 'PreSchoolMedical';
    }
    if (data is _i44.PreSchoolMedicalStatus) {
      return 'PreSchoolMedicalStatus';
    }
    if (data is _i45.PreSchoolTest) {
      return 'PreSchoolTest';
    }
    if (data is _i46.PupilList) {
      return 'PupilList';
    }
    if (data is _i47.SchoolList) {
      return 'SchoolList';
    }
    if (data is _i48.MissedClass) {
      return 'MissedClass';
    }
    if (data is _i49.SchoolSemester) {
      return 'SchoolSemester';
    }
    if (data is _i50.Schoolday) {
      return 'Schoolday';
    }
    if (data is _i51.SchooldayEvent) {
      return 'SchooldayEvent';
    }
    if (data is _i52.HubDocument) {
      return 'HubDocument';
    }
    if (data is _i53.LanguageStats) {
      return 'LanguageStats';
    }
    if (data is _i54.CreditTransaction) {
      return 'CreditTransaction';
    }
    if (data is _i55.DeviceInfo) {
      return 'DeviceInfo';
    }
    if (data is _i56.Role) {
      return 'Role';
    }
    if (data is _i57.User) {
      return 'User';
    }
    if (data is _i58.UserDevice) {
      return 'UserDevice';
    }
    if (data is _i59.UserFlags) {
      return 'UserFlags';
    }
    if (data is _i60.PupilWorkbook) {
      return 'PupilWorkbook';
    }
    if (data is _i61.Workbook) {
      return 'Workbook';
    }
    className = _i64.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'LibraryBookLocation') {
      return deserialize<_i8.LibraryBookLocation>(data['data']);
    }
    if (dataClassName == 'PupilBookLending') {
      return deserialize<_i9.PupilBookLending>(data['data']);
    }
    if (dataClassName == 'PupilBookLendingFile') {
      return deserialize<_i10.PupilBookLendingFile>(data['data']);
    }
    if (dataClassName == 'Example') {
      return deserialize<_i11.Example>(data['data']);
    }
    if (dataClassName == 'Competence') {
      return deserialize<_i12.Competence>(data['data']);
    }
    if (dataClassName == 'CompetenceCheck') {
      return deserialize<_i13.CompetenceCheck>(data['data']);
    }
    if (dataClassName == 'CompetenceGoal') {
      return deserialize<_i14.CompetenceGoal>(data['data']);
    }
    if (dataClassName == 'CompetenceReport') {
      return deserialize<_i15.CompetenceReport>(data['data']);
    }
    if (dataClassName == 'CompetenceReportCheck') {
      return deserialize<_i16.CompetenceReportCheck>(data['data']);
    }
    if (dataClassName == 'Lesson') {
      return deserialize<_i17.Lesson>(data['data']);
    }
    if (dataClassName == 'LessonAttendance') {
      return deserialize<_i18.LessonAttendance>(data['data']);
    }
    if (dataClassName == 'LessonGroup') {
      return deserialize<_i19.LessonGroup>(data['data']);
    }
    if (dataClassName == 'ScheduledLessonGroupMembership') {
      return deserialize<_i20.ScheduledLessonGroupMembership>(data['data']);
    }
    if (dataClassName == 'LessonSubject') {
      return deserialize<_i21.LessonSubject>(data['data']);
    }
    if (dataClassName == 'ScheduledLesson') {
      return deserialize<_i22.ScheduledLesson>(data['data']);
    }
    if (dataClassName == 'Subject') {
      return deserialize<_i23.Subject>(data['data']);
    }
    if (dataClassName == 'TimetableSlot') {
      return deserialize<_i24.TimetableSlot>(data['data']);
    }
    if (dataClassName == 'Weekday') {
      return deserialize<_i25.Weekday>(data['data']);
    }
    if (dataClassName == 'Room') {
      return deserialize<_i26.Room>(data['data']);
    }
    if (dataClassName == 'SupportCategory') {
      return deserialize<_i27.SupportCategory>(data['data']);
    }
    if (dataClassName == 'SupportCategoryStatus') {
      return deserialize<_i28.SupportCategoryStatus>(data['data']);
    }
    if (dataClassName == 'SupportGoal') {
      return deserialize<_i29.SupportGoal>(data['data']);
    }
    if (dataClassName == 'SupportGoalCheck') {
      return deserialize<_i30.SupportGoalCheck>(data['data']);
    }
    if (dataClassName == 'SupportGoalCheckFile') {
      return deserialize<_i31.SupportGoalCheckFile>(data['data']);
    }
    if (dataClassName == 'SupportLevel') {
      return deserialize<_i32.SupportLevel>(data['data']);
    }
    if (dataClassName == 'SiblingsParentInfo') {
      return deserialize<_i33.SiblingsParentInfo>(data['data']);
    }
    if (dataClassName == 'PupilData') {
      return deserialize<_i34.PupilData>(data['data']);
    }
    if (dataClassName == 'AfterSchoolCare') {
      return deserialize<_i35.AfterSchoolCare>(data['data']);
    }
    if (dataClassName == 'AfterSchoolCarePickUpTimes') {
      return deserialize<_i36.AfterSchoolCarePickUpTimes>(data['data']);
    }
    if (dataClassName == 'PickUpInfo') {
      return deserialize<_i37.PickUpInfo>(data['data']);
    }
    if (dataClassName == 'CommunicationSkills') {
      return deserialize<_i38.CommunicationSkills>(data['data']);
    }
    if (dataClassName == 'Language') {
      return deserialize<_i39.Language>(data['data']);
    }
    if (dataClassName == 'PublicMediaAuth') {
      return deserialize<_i40.PublicMediaAuth>(data['data']);
    }
    if (dataClassName == 'PupilDataTutorInfo') {
      return deserialize<_i41.PupilDataTutorInfo>(data['data']);
    }
    if (dataClassName == 'KindergardenInfo') {
      return deserialize<_i42.KindergardenInfo>(data['data']);
    }
    if (dataClassName == 'PreSchoolMedical') {
      return deserialize<_i43.PreSchoolMedical>(data['data']);
    }
    if (dataClassName == 'PreSchoolMedicalStatus') {
      return deserialize<_i44.PreSchoolMedicalStatus>(data['data']);
    }
    if (dataClassName == 'PreSchoolTest') {
      return deserialize<_i45.PreSchoolTest>(data['data']);
    }
    if (dataClassName == 'PupilList') {
      return deserialize<_i46.PupilList>(data['data']);
    }
    if (dataClassName == 'SchoolList') {
      return deserialize<_i47.SchoolList>(data['data']);
    }
    if (dataClassName == 'MissedClass') {
      return deserialize<_i48.MissedClass>(data['data']);
    }
    if (dataClassName == 'SchoolSemester') {
      return deserialize<_i49.SchoolSemester>(data['data']);
    }
    if (dataClassName == 'Schoolday') {
      return deserialize<_i50.Schoolday>(data['data']);
    }
    if (dataClassName == 'SchooldayEvent') {
      return deserialize<_i51.SchooldayEvent>(data['data']);
    }
    if (dataClassName == 'HubDocument') {
      return deserialize<_i52.HubDocument>(data['data']);
    }
    if (dataClassName == 'LanguageStats') {
      return deserialize<_i53.LanguageStats>(data['data']);
    }
    if (dataClassName == 'CreditTransaction') {
      return deserialize<_i54.CreditTransaction>(data['data']);
    }
    if (dataClassName == 'DeviceInfo') {
      return deserialize<_i55.DeviceInfo>(data['data']);
    }
    if (dataClassName == 'Role') {
      return deserialize<_i56.Role>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i57.User>(data['data']);
    }
    if (dataClassName == 'UserDevice') {
      return deserialize<_i58.UserDevice>(data['data']);
    }
    if (dataClassName == 'UserFlags') {
      return deserialize<_i59.UserFlags>(data['data']);
    }
    if (dataClassName == 'PupilWorkbook') {
      return deserialize<_i60.PupilWorkbook>(data['data']);
    }
    if (dataClassName == 'Workbook') {
      return deserialize<_i61.Workbook>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i64.Protocol().deserializeByClassName(data);
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
    _i63.DeviceInfo? deviceInfo,
    _i64.AuthenticationResponse response
  })) {
    return {
      "n": {
        "deviceInfo": record.deviceInfo,
        "response": record.response,
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

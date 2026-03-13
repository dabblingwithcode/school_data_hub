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
import '_features/learning/competence/models/competence_check.dart' as _i2;
import '_features/admin/models/batch_create_user_event.dart' as _i3;
import '_features/admin/models/batch_create_users_response.dart' as _i4;
import '_features/admin/models/create_user_request.dart' as _i5;
import '_features/admin/models/created_user_credential.dart' as _i6;
import '_features/admin/models/hub_log_entry.dart' as _i7;
import '_features/admin/models/hub_query_log_entry.dart' as _i8;
import '_features/admin/models/hub_session_log_entry.dart' as _i9;
import '_features/admin/models/hub_session_log_filter.dart' as _i10;
import '_features/admin/models/hub_session_log_info.dart' as _i11;
import '_features/admin/models/hub_session_log_result.dart' as _i12;
import '_features/attendance/models/contacted_type.dart' as _i13;
import '_features/attendance/models/missed_schoolday.dart' as _i14;
import '_features/attendance/models/missed_type.dart' as _i15;
import '_features/auth/models/device_info.dart' as _i16;
import '_features/auth/models/user_device.dart' as _i17;
import '_features/authorizations/models/authorization.dart' as _i18;
import '_features/authorizations/models/pupil_authorization.dart' as _i19;
import '_features/books/models/book.dart' as _i20;
import '_features/books/models/book_stats_dto.dart' as _i21;
import '_features/books/models/book_tagging/book_tag.dart' as _i22;
import '_features/books/models/book_tagging/book_tagging.dart' as _i23;
import '_features/books/models/library_book.dart' as _i24;
import '_features/books/models/library_book_location.dart' as _i25;
import '_features/books/models/library_book_query.dart' as _i26;
import '_features/books/models/pupil_book_lending.dart' as _i27;
import '_features/hub/models/force_logout_event.dart' as _i28;
import '_features/hub/models/hub_delete_event.dart' as _i29;
import '_features/hub/models/hub_object_type.dart' as _i30;
import '_features/hub/models/hub_type_last_update.dart' as _i31;
import '_features/learning/competence/models/competence.dart' as _i32;
import '_features/admin/models/batch_create_user_error.dart' as _i33;
import '_features/learning/competence/models/competence_goal.dart' as _i34;
import '_features/learning/competence_report/models/competence_report.dart'
    as _i35;
import '_features/learning/competence_report/models/competence_report_check.dart'
    as _i36;
import '_features/learning/competence_report/models/competence_report_item.dart'
    as _i37;
import '_features/learning_support/models/learning_support_plan.dart' as _i38;
import '_features/learning_support/models/support_category.dart' as _i39;
import '_features/learning_support/models/support_category_status.dart' as _i40;
import '_features/learning_support/models/support_goal/support_goal.dart'
    as _i41;
import '_features/learning_support/models/support_goal/support_goal_check.dart'
    as _i42;
import '_features/learning_support/models/support_level.dart' as _i43;
import '_features/learning_support/models/support_level_legacy_dto.dart'
    as _i44;
import '_features/matrix/compulsory_room.dart' as _i45;
import '_features/matrix/matrix_room_type.dart' as _i46;
import '_features/pupil/models/pupil_data/after_school_care/after_school_care.dart'
    as _i47;
import '_features/pupil/models/pupil_data/after_school_care/after_school_pickup_times.dart'
    as _i48;
import '_features/pupil/models/pupil_data/after_school_care/pick_up_info.dart'
    as _i49;
import '_features/pupil/models/pupil_data/communication/communication_skills.dart'
    as _i50;
import '_features/pupil/models/pupil_data/communication/public_media_auth.dart'
    as _i51;
import '_features/pupil/models/pupil_data/communication/tutor_info.dart'
    as _i52;
import '_features/pupil/models/pupil_data/credit_transaction.dart' as _i53;
import '_features/pupil/models/pupil_data/dto/pupil_document_type.dart' as _i54;
import '_features/pupil/models/pupil_data/dto/siblings_tutor_info_dto.dart'
    as _i55;
import '_features/pupil/models/pupil_data/preschool/kindergarden.dart' as _i56;
import '_features/pupil/models/pupil_data/preschool/kindergarden_info.dart'
    as _i57;
import '_features/pupil/models/pupil_data/preschool/pre_school_medical.dart'
    as _i58;
import '_features/pupil/models/pupil_data/preschool/pre_school_medical_status.dart'
    as _i59;
import '_features/pupil/models/pupil_data/preschool/pre_school_test.dart'
    as _i60;
import '_features/pupil/models/pupil_data/pupil_data.dart' as _i61;
import '_features/pupil/models/pupil_data/pupil_status.dart' as _i62;
import '_shared/models/member_operation.dart' as _i63;
import '_features/pupil/models/pupil_identity/pupil_identity.dart' as _i64;
import '_features/pupil/models/pupil_identity/pupil_identity_dto.dart' as _i65;
import '_features/pupil/models/pupil_identity/school_grade.dart' as _i66;
import '_features/school_data/models/school_data.dart' as _i67;
import '_features/school_lists/models/pupil_entry.dart' as _i68;
import '_features/school_lists/models/school_list.dart' as _i69;
import '_features/schoolday/models/school_semester.dart' as _i70;
import '_features/schoolday/models/schoolday.dart' as _i71;
import '_features/schoolday_events/models/schoolday_event.dart' as _i72;
import '_features/schoolday_events/models/schoolday_event_type.dart' as _i73;
import '_features/timetable/models/classroom.dart' as _i74;
import '_features/timetable/models/junction_models/lesson_teacher.dart' as _i75;
import '_features/timetable/models/junction_models/scheduled_lesson_teacher.dart'
    as _i76;
import '_features/timetable/models/lesson/lesson.dart' as _i77;
import '_features/timetable/models/lesson/lesson_attendance.dart' as _i78;
import '_features/timetable/models/lesson/lesson_group.dart' as _i79;
import '_features/timetable/models/scheduled_lesson/lesson_group_membership.dart'
    as _i80;
import '_features/timetable/models/scheduled_lesson/scheduled_lesson.dart'
    as _i81;
import '_features/timetable/models/scheduled_lesson/subject.dart' as _i82;
import '_features/timetable/models/scheduled_lesson/timetable_slot.dart'
    as _i83;
import '_features/timetable/models/scheduled_lesson/weekday_enum.dart' as _i84;
import '_features/timetable/models/timetable.dart' as _i85;
import '_features/user/models/roles.dart' as _i86;
import '_features/user/models/staff_user.dart' as _i87;
import '_features/user/models/user_flags.dart' as _i88;
import '_features/user/models/user_with_devices.dart' as _i89;
import '_features/workbooks/models/pupil_workbook.dart' as _i90;
import '_features/workbooks/models/workbook.dart' as _i91;
import '_shared/models/exceptions/test_exception.dart' as _i92;
import '_shared/models/hub_document.dart' as _i93;
import '_features/pupil/models/pupil_identity/last_pupil_identities_update.dart'
    as _i94;
import 'package:school_data_hub_client/src/protocol/_features/learning/competence/models/competence.dart'
    as _i95;
import 'package:school_data_hub_client/src/protocol/_features/learning_support/models/support_category.dart'
    as _i96;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/pupil_data.dart'
    as _i97;
import 'package:school_data_hub_client/src/protocol/_features/schoolday/models/schoolday.dart'
    as _i98;
import 'package:school_data_hub_client/src/protocol/_features/admin/models/create_user_request.dart'
    as _i99;
import 'package:school_data_hub_client/src/protocol/_features/attendance/models/missed_schoolday.dart'
    as _i100;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i101;
import 'package:school_data_hub_client/src/protocol/_features/auth/models/user_device.dart'
    as _i102;
import 'package:school_data_hub_client/src/protocol/_features/authorizations/models/authorization.dart'
    as _i103;
import 'package:school_data_hub_client/src/protocol/_shared/models/member_operation.dart'
    as _i104;
import 'package:school_data_hub_client/src/protocol/_features/books/models/book_tagging/book_tag.dart'
    as _i105;
import 'package:school_data_hub_client/src/protocol/_features/books/models/book.dart'
    as _i106;
import 'package:school_data_hub_client/src/protocol/_features/books/models/library_book_location.dart'
    as _i107;
import 'package:school_data_hub_client/src/protocol/_features/books/models/library_book.dart'
    as _i108;
import 'package:school_data_hub_client/src/protocol/_features/books/models/pupil_book_lending.dart'
    as _i109;
import 'package:school_data_hub_client/src/protocol/_features/hub/models/hub_type_last_update.dart'
    as _i110;
import 'package:school_data_hub_client/src/protocol/_features/learning/competence/models/competence_goal.dart'
    as _i111;
import 'package:school_data_hub_client/src/protocol/_features/learning/competence_report/models/competence_report.dart'
    as _i112;
import 'package:school_data_hub_client/src/protocol/_features/learning/competence_report/models/competence_report_item.dart'
    as _i113;
import 'package:school_data_hub_client/src/protocol/_features/learning_support/models/support_goal/support_goal.dart'
    as _i114;
import 'package:school_data_hub_client/src/protocol/_features/learning_support/models/learning_support_plan.dart'
    as _i115;
import 'package:school_data_hub_client/src/protocol/_features/learning_support/models/support_category_status.dart'
    as _i116;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/preschool/pre_school_medical.dart'
    as _i117;
import 'package:school_data_hub_client/src/protocol/_features/matrix/compulsory_room.dart'
    as _i118;
import 'package:school_data_hub_client/src/protocol/_features/learning_support/models/support_level_legacy_dto.dart'
    as _i119;
import 'package:school_data_hub_client/src/protocol/_features/school_lists/models/school_list.dart'
    as _i120;
import 'package:school_data_hub_client/src/protocol/_features/schoolday/models/school_semester.dart'
    as _i121;
import 'package:school_data_hub_client/src/protocol/_features/schoolday_events/models/schoolday_event.dart'
    as _i122;
import 'package:school_data_hub_client/src/protocol/_features/timetable/models/classroom.dart'
    as _i123;
import 'package:school_data_hub_client/src/protocol/_features/timetable/models/lesson/lesson_group.dart'
    as _i124;
import 'package:school_data_hub_client/src/protocol/_features/timetable/models/scheduled_lesson/scheduled_lesson.dart'
    as _i125;
import 'package:school_data_hub_client/src/protocol/_features/timetable/models/scheduled_lesson/lesson_group_membership.dart'
    as _i126;
import 'package:school_data_hub_client/src/protocol/_features/timetable/models/scheduled_lesson/subject.dart'
    as _i127;
import 'package:school_data_hub_client/src/protocol/_features/timetable/models/timetable.dart'
    as _i128;
import 'package:school_data_hub_client/src/protocol/_features/timetable/models/scheduled_lesson/timetable_slot.dart'
    as _i129;
import 'package:school_data_hub_client/src/protocol/_features/user/models/staff_user.dart'
    as _i130;
import 'package:school_data_hub_client/src/protocol/_features/user/models/user_with_devices.dart'
    as _i131;
import 'package:school_data_hub_client/src/protocol/_features/workbooks/models/pupil_workbook.dart'
    as _i132;
import 'package:school_data_hub_client/src/protocol/_features/workbooks/models/workbook.dart'
    as _i133;
export '_features/admin/models/batch_create_user_error.dart';
export '_features/admin/models/batch_create_user_event.dart';
export '_features/admin/models/batch_create_users_response.dart';
export '_features/admin/models/create_user_request.dart';
export '_features/admin/models/created_user_credential.dart';
export '_features/admin/models/hub_log_entry.dart';
export '_features/admin/models/hub_query_log_entry.dart';
export '_features/admin/models/hub_session_log_entry.dart';
export '_features/admin/models/hub_session_log_filter.dart';
export '_features/admin/models/hub_session_log_info.dart';
export '_features/admin/models/hub_session_log_result.dart';
export '_features/attendance/models/contacted_type.dart';
export '_features/attendance/models/missed_schoolday.dart';
export '_features/attendance/models/missed_type.dart';
export '_features/auth/models/device_info.dart';
export '_features/auth/models/user_device.dart';
export '_features/authorizations/models/authorization.dart';
export '_features/authorizations/models/pupil_authorization.dart';
export '_features/books/models/book.dart';
export '_features/books/models/book_stats_dto.dart';
export '_features/books/models/book_tagging/book_tag.dart';
export '_features/books/models/book_tagging/book_tagging.dart';
export '_features/books/models/library_book.dart';
export '_features/books/models/library_book_location.dart';
export '_features/books/models/library_book_query.dart';
export '_features/books/models/pupil_book_lending.dart';
export '_features/hub/models/force_logout_event.dart';
export '_features/hub/models/hub_delete_event.dart';
export '_features/hub/models/hub_object_type.dart';
export '_features/hub/models/hub_type_last_update.dart';
export '_features/learning/competence/models/competence.dart';
export '_features/learning/competence/models/competence_check.dart';
export '_features/learning/competence/models/competence_goal.dart';
export '_features/learning/competence_report/models/competence_report.dart';
export '_features/learning/competence_report/models/competence_report_check.dart';
export '_features/learning/competence_report/models/competence_report_item.dart';
export '_features/learning_support/models/learning_support_plan.dart';
export '_features/learning_support/models/support_category.dart';
export '_features/learning_support/models/support_category_status.dart';
export '_features/learning_support/models/support_goal/support_goal.dart';
export '_features/learning_support/models/support_goal/support_goal_check.dart';
export '_features/learning_support/models/support_level.dart';
export '_features/learning_support/models/support_level_legacy_dto.dart';
export '_features/matrix/compulsory_room.dart';
export '_features/matrix/matrix_room_type.dart';
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
export '_features/pupil/models/pupil_data/pupil_status.dart';
export '_features/pupil/models/pupil_identity/last_pupil_identities_update.dart';
export '_features/pupil/models/pupil_identity/pupil_identity.dart';
export '_features/pupil/models/pupil_identity/pupil_identity_dto.dart';
export '_features/pupil/models/pupil_identity/school_grade.dart';
export '_features/school_data/models/school_data.dart';
export '_features/school_lists/models/pupil_entry.dart';
export '_features/school_lists/models/school_list.dart';
export '_features/schoolday/models/school_semester.dart';
export '_features/schoolday/models/schoolday.dart';
export '_features/schoolday_events/models/schoolday_event.dart';
export '_features/schoolday_events/models/schoolday_event_type.dart';
export '_features/timetable/models/classroom.dart';
export '_features/timetable/models/junction_models/lesson_teacher.dart';
export '_features/timetable/models/junction_models/scheduled_lesson_teacher.dart';
export '_features/timetable/models/lesson/lesson.dart';
export '_features/timetable/models/lesson/lesson_attendance.dart';
export '_features/timetable/models/lesson/lesson_group.dart';
export '_features/timetable/models/scheduled_lesson/lesson_group_membership.dart';
export '_features/timetable/models/scheduled_lesson/scheduled_lesson.dart';
export '_features/timetable/models/scheduled_lesson/subject.dart';
export '_features/timetable/models/scheduled_lesson/timetable_slot.dart';
export '_features/timetable/models/scheduled_lesson/weekday_enum.dart';
export '_features/timetable/models/timetable.dart';
export '_features/user/models/roles.dart';
export '_features/user/models/staff_user.dart';
export '_features/user/models/user_flags.dart';
export '_features/user/models/user_with_devices.dart';
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
    if (t == _i2.CompetenceCheck) {
      return _i2.CompetenceCheck.fromJson(data) as T;
    }
    if (t == _i3.BatchCreateUserEvent) {
      return _i3.BatchCreateUserEvent.fromJson(data) as T;
    }
    if (t == _i4.BatchCreateUsersResponse) {
      return _i4.BatchCreateUsersResponse.fromJson(data) as T;
    }
    if (t == _i5.CreateUserRequest) {
      return _i5.CreateUserRequest.fromJson(data) as T;
    }
    if (t == _i6.CreatedUserCredential) {
      return _i6.CreatedUserCredential.fromJson(data) as T;
    }
    if (t == _i7.HubLogEntry) {
      return _i7.HubLogEntry.fromJson(data) as T;
    }
    if (t == _i8.HubQueryLogEntry) {
      return _i8.HubQueryLogEntry.fromJson(data) as T;
    }
    if (t == _i9.HubSessionLogEntry) {
      return _i9.HubSessionLogEntry.fromJson(data) as T;
    }
    if (t == _i10.HubSessionLogFilter) {
      return _i10.HubSessionLogFilter.fromJson(data) as T;
    }
    if (t == _i11.HubSessionLogInfo) {
      return _i11.HubSessionLogInfo.fromJson(data) as T;
    }
    if (t == _i12.HubSessionLogResult) {
      return _i12.HubSessionLogResult.fromJson(data) as T;
    }
    if (t == _i13.ContactedType) {
      return _i13.ContactedType.fromJson(data) as T;
    }
    if (t == _i14.MissedSchoolday) {
      return _i14.MissedSchoolday.fromJson(data) as T;
    }
    if (t == _i15.MissedType) {
      return _i15.MissedType.fromJson(data) as T;
    }
    if (t == _i16.DeviceInfo) {
      return _i16.DeviceInfo.fromJson(data) as T;
    }
    if (t == _i17.UserDevice) {
      return _i17.UserDevice.fromJson(data) as T;
    }
    if (t == _i18.Authorization) {
      return _i18.Authorization.fromJson(data) as T;
    }
    if (t == _i19.PupilAuthorization) {
      return _i19.PupilAuthorization.fromJson(data) as T;
    }
    if (t == _i20.Book) {
      return _i20.Book.fromJson(data) as T;
    }
    if (t == _i21.LibraryBookStatsDto) {
      return _i21.LibraryBookStatsDto.fromJson(data) as T;
    }
    if (t == _i22.BookTag) {
      return _i22.BookTag.fromJson(data) as T;
    }
    if (t == _i23.BookTagging) {
      return _i23.BookTagging.fromJson(data) as T;
    }
    if (t == _i24.LibraryBook) {
      return _i24.LibraryBook.fromJson(data) as T;
    }
    if (t == _i25.LibraryBookLocation) {
      return _i25.LibraryBookLocation.fromJson(data) as T;
    }
    if (t == _i26.LibraryBookQuery) {
      return _i26.LibraryBookQuery.fromJson(data) as T;
    }
    if (t == _i27.PupilBookLending) {
      return _i27.PupilBookLending.fromJson(data) as T;
    }
    if (t == _i28.ForceLogoutEvent) {
      return _i28.ForceLogoutEvent.fromJson(data) as T;
    }
    if (t == _i29.HubDeleteEvent) {
      return _i29.HubDeleteEvent.fromJson(data) as T;
    }
    if (t == _i30.HubObjectType) {
      return _i30.HubObjectType.fromJson(data) as T;
    }
    if (t == _i31.HubTypeLastUpdate) {
      return _i31.HubTypeLastUpdate.fromJson(data) as T;
    }
    if (t == _i32.Competence) {
      return _i32.Competence.fromJson(data) as T;
    }
    if (t == _i33.BatchCreateUserError) {
      return _i33.BatchCreateUserError.fromJson(data) as T;
    }
    if (t == _i34.CompetenceGoal) {
      return _i34.CompetenceGoal.fromJson(data) as T;
    }
    if (t == _i35.CompetenceReport) {
      return _i35.CompetenceReport.fromJson(data) as T;
    }
    if (t == _i36.CompetenceReportCheck) {
      return _i36.CompetenceReportCheck.fromJson(data) as T;
    }
    if (t == _i37.CompetenceReportItem) {
      return _i37.CompetenceReportItem.fromJson(data) as T;
    }
    if (t == _i38.LearningSupportPlan) {
      return _i38.LearningSupportPlan.fromJson(data) as T;
    }
    if (t == _i39.SupportCategory) {
      return _i39.SupportCategory.fromJson(data) as T;
    }
    if (t == _i40.SupportCategoryStatus) {
      return _i40.SupportCategoryStatus.fromJson(data) as T;
    }
    if (t == _i41.SupportGoal) {
      return _i41.SupportGoal.fromJson(data) as T;
    }
    if (t == _i42.SupportGoalCheck) {
      return _i42.SupportGoalCheck.fromJson(data) as T;
    }
    if (t == _i43.SupportLevel) {
      return _i43.SupportLevel.fromJson(data) as T;
    }
    if (t == _i44.SupportLevelLegacyDto) {
      return _i44.SupportLevelLegacyDto.fromJson(data) as T;
    }
    if (t == _i45.CompulsoryRoom) {
      return _i45.CompulsoryRoom.fromJson(data) as T;
    }
    if (t == _i46.MatrixRoomType) {
      return _i46.MatrixRoomType.fromJson(data) as T;
    }
    if (t == _i47.AfterSchoolCare) {
      return _i47.AfterSchoolCare.fromJson(data) as T;
    }
    if (t == _i48.AfterSchoolCarePickUpTimes) {
      return _i48.AfterSchoolCarePickUpTimes.fromJson(data) as T;
    }
    if (t == _i49.PickUpInfo) {
      return _i49.PickUpInfo.fromJson(data) as T;
    }
    if (t == _i50.CommunicationSkills) {
      return _i50.CommunicationSkills.fromJson(data) as T;
    }
    if (t == _i51.PublicMediaAuth) {
      return _i51.PublicMediaAuth.fromJson(data) as T;
    }
    if (t == _i52.TutorInfo) {
      return _i52.TutorInfo.fromJson(data) as T;
    }
    if (t == _i53.CreditTransaction) {
      return _i53.CreditTransaction.fromJson(data) as T;
    }
    if (t == _i54.PupilDocumentType) {
      return _i54.PupilDocumentType.fromJson(data) as T;
    }
    if (t == _i55.SiblingsTutorInfo) {
      return _i55.SiblingsTutorInfo.fromJson(data) as T;
    }
    if (t == _i56.Kindergarden) {
      return _i56.Kindergarden.fromJson(data) as T;
    }
    if (t == _i57.KindergardenInfo) {
      return _i57.KindergardenInfo.fromJson(data) as T;
    }
    if (t == _i58.PreSchoolMedical) {
      return _i58.PreSchoolMedical.fromJson(data) as T;
    }
    if (t == _i59.PreSchoolMedicalStatus) {
      return _i59.PreSchoolMedicalStatus.fromJson(data) as T;
    }
    if (t == _i60.PreSchoolTest) {
      return _i60.PreSchoolTest.fromJson(data) as T;
    }
    if (t == _i61.PupilData) {
      return _i61.PupilData.fromJson(data) as T;
    }
    if (t == _i62.PupilStatus) {
      return _i62.PupilStatus.fromJson(data) as T;
    }
    if (t == _i63.MemberOperation) {
      return _i63.MemberOperation.fromJson(data) as T;
    }
    if (t == _i64.PupilIdentity) {
      return _i64.PupilIdentity.fromJson(data) as T;
    }
    if (t == _i65.PupilIdentityDto) {
      return _i65.PupilIdentityDto.fromJson(data) as T;
    }
    if (t == _i66.SchoolGrade) {
      return _i66.SchoolGrade.fromJson(data) as T;
    }
    if (t == _i67.SchoolData) {
      return _i67.SchoolData.fromJson(data) as T;
    }
    if (t == _i68.PupilListEntry) {
      return _i68.PupilListEntry.fromJson(data) as T;
    }
    if (t == _i69.SchoolList) {
      return _i69.SchoolList.fromJson(data) as T;
    }
    if (t == _i70.SchoolSemester) {
      return _i70.SchoolSemester.fromJson(data) as T;
    }
    if (t == _i71.Schoolday) {
      return _i71.Schoolday.fromJson(data) as T;
    }
    if (t == _i72.SchooldayEvent) {
      return _i72.SchooldayEvent.fromJson(data) as T;
    }
    if (t == _i73.SchooldayEventType) {
      return _i73.SchooldayEventType.fromJson(data) as T;
    }
    if (t == _i74.Classroom) {
      return _i74.Classroom.fromJson(data) as T;
    }
    if (t == _i75.LessonTeacher) {
      return _i75.LessonTeacher.fromJson(data) as T;
    }
    if (t == _i76.ScheduledLessonTeacher) {
      return _i76.ScheduledLessonTeacher.fromJson(data) as T;
    }
    if (t == _i77.Lesson) {
      return _i77.Lesson.fromJson(data) as T;
    }
    if (t == _i78.LessonAttendance) {
      return _i78.LessonAttendance.fromJson(data) as T;
    }
    if (t == _i79.LessonGroup) {
      return _i79.LessonGroup.fromJson(data) as T;
    }
    if (t == _i80.ScheduledLessonGroupMembership) {
      return _i80.ScheduledLessonGroupMembership.fromJson(data) as T;
    }
    if (t == _i81.ScheduledLesson) {
      return _i81.ScheduledLesson.fromJson(data) as T;
    }
    if (t == _i82.Subject) {
      return _i82.Subject.fromJson(data) as T;
    }
    if (t == _i83.TimetableSlot) {
      return _i83.TimetableSlot.fromJson(data) as T;
    }
    if (t == _i84.Weekday) {
      return _i84.Weekday.fromJson(data) as T;
    }
    if (t == _i85.Timetable) {
      return _i85.Timetable.fromJson(data) as T;
    }
    if (t == _i86.Role) {
      return _i86.Role.fromJson(data) as T;
    }
    if (t == _i87.User) {
      return _i87.User.fromJson(data) as T;
    }
    if (t == _i88.UserFlags) {
      return _i88.UserFlags.fromJson(data) as T;
    }
    if (t == _i89.UserWithDevices) {
      return _i89.UserWithDevices.fromJson(data) as T;
    }
    if (t == _i90.PupilWorkbook) {
      return _i90.PupilWorkbook.fromJson(data) as T;
    }
    if (t == _i91.Workbook) {
      return _i91.Workbook.fromJson(data) as T;
    }
    if (t == _i92.MyException) {
      return _i92.MyException.fromJson(data) as T;
    }
    if (t == _i93.HubDocument) {
      return _i93.HubDocument.fromJson(data) as T;
    }
    if (t == _i94.LastPupilIdentiesUpdate) {
      return _i94.LastPupilIdentiesUpdate.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.CompetenceCheck?>()) {
      return (data != null ? _i2.CompetenceCheck.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.BatchCreateUserEvent?>()) {
      return (data != null ? _i3.BatchCreateUserEvent.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i4.BatchCreateUsersResponse?>()) {
      return (data != null ? _i4.BatchCreateUsersResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i5.CreateUserRequest?>()) {
      return (data != null ? _i5.CreateUserRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.CreatedUserCredential?>()) {
      return (data != null ? _i6.CreatedUserCredential.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i7.HubLogEntry?>()) {
      return (data != null ? _i7.HubLogEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.HubQueryLogEntry?>()) {
      return (data != null ? _i8.HubQueryLogEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.HubSessionLogEntry?>()) {
      return (data != null ? _i9.HubSessionLogEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.HubSessionLogFilter?>()) {
      return (data != null ? _i10.HubSessionLogFilter.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.HubSessionLogInfo?>()) {
      return (data != null ? _i11.HubSessionLogInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.HubSessionLogResult?>()) {
      return (data != null ? _i12.HubSessionLogResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.ContactedType?>()) {
      return (data != null ? _i13.ContactedType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.MissedSchoolday?>()) {
      return (data != null ? _i14.MissedSchoolday.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.MissedType?>()) {
      return (data != null ? _i15.MissedType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.DeviceInfo?>()) {
      return (data != null ? _i16.DeviceInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.UserDevice?>()) {
      return (data != null ? _i17.UserDevice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.Authorization?>()) {
      return (data != null ? _i18.Authorization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.PupilAuthorization?>()) {
      return (data != null ? _i19.PupilAuthorization.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.Book?>()) {
      return (data != null ? _i20.Book.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.LibraryBookStatsDto?>()) {
      return (data != null ? _i21.LibraryBookStatsDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.BookTag?>()) {
      return (data != null ? _i22.BookTag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.BookTagging?>()) {
      return (data != null ? _i23.BookTagging.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.LibraryBook?>()) {
      return (data != null ? _i24.LibraryBook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.LibraryBookLocation?>()) {
      return (data != null ? _i25.LibraryBookLocation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.LibraryBookQuery?>()) {
      return (data != null ? _i26.LibraryBookQuery.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.PupilBookLending?>()) {
      return (data != null ? _i27.PupilBookLending.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.ForceLogoutEvent?>()) {
      return (data != null ? _i28.ForceLogoutEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.HubDeleteEvent?>()) {
      return (data != null ? _i29.HubDeleteEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.HubObjectType?>()) {
      return (data != null ? _i30.HubObjectType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.HubTypeLastUpdate?>()) {
      return (data != null ? _i31.HubTypeLastUpdate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.Competence?>()) {
      return (data != null ? _i32.Competence.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.BatchCreateUserError?>()) {
      return (data != null ? _i33.BatchCreateUserError.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i34.CompetenceGoal?>()) {
      return (data != null ? _i34.CompetenceGoal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.CompetenceReport?>()) {
      return (data != null ? _i35.CompetenceReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.CompetenceReportCheck?>()) {
      return (data != null ? _i36.CompetenceReportCheck.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i37.CompetenceReportItem?>()) {
      return (data != null ? _i37.CompetenceReportItem.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i38.LearningSupportPlan?>()) {
      return (data != null ? _i38.LearningSupportPlan.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i39.SupportCategory?>()) {
      return (data != null ? _i39.SupportCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.SupportCategoryStatus?>()) {
      return (data != null ? _i40.SupportCategoryStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i41.SupportGoal?>()) {
      return (data != null ? _i41.SupportGoal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.SupportGoalCheck?>()) {
      return (data != null ? _i42.SupportGoalCheck.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.SupportLevel?>()) {
      return (data != null ? _i43.SupportLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.SupportLevelLegacyDto?>()) {
      return (data != null ? _i44.SupportLevelLegacyDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i45.CompulsoryRoom?>()) {
      return (data != null ? _i45.CompulsoryRoom.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.MatrixRoomType?>()) {
      return (data != null ? _i46.MatrixRoomType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.AfterSchoolCare?>()) {
      return (data != null ? _i47.AfterSchoolCare.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.AfterSchoolCarePickUpTimes?>()) {
      return (data != null
          ? _i48.AfterSchoolCarePickUpTimes.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i49.PickUpInfo?>()) {
      return (data != null ? _i49.PickUpInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.CommunicationSkills?>()) {
      return (data != null ? _i50.CommunicationSkills.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i51.PublicMediaAuth?>()) {
      return (data != null ? _i51.PublicMediaAuth.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.TutorInfo?>()) {
      return (data != null ? _i52.TutorInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.CreditTransaction?>()) {
      return (data != null ? _i53.CreditTransaction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.PupilDocumentType?>()) {
      return (data != null ? _i54.PupilDocumentType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.SiblingsTutorInfo?>()) {
      return (data != null ? _i55.SiblingsTutorInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.Kindergarden?>()) {
      return (data != null ? _i56.Kindergarden.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.KindergardenInfo?>()) {
      return (data != null ? _i57.KindergardenInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.PreSchoolMedical?>()) {
      return (data != null ? _i58.PreSchoolMedical.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.PreSchoolMedicalStatus?>()) {
      return (data != null ? _i59.PreSchoolMedicalStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i60.PreSchoolTest?>()) {
      return (data != null ? _i60.PreSchoolTest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.PupilData?>()) {
      return (data != null ? _i61.PupilData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.PupilStatus?>()) {
      return (data != null ? _i62.PupilStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.MemberOperation?>()) {
      return (data != null ? _i63.MemberOperation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.PupilIdentity?>()) {
      return (data != null ? _i64.PupilIdentity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.PupilIdentityDto?>()) {
      return (data != null ? _i65.PupilIdentityDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i66.SchoolGrade?>()) {
      return (data != null ? _i66.SchoolGrade.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.SchoolData?>()) {
      return (data != null ? _i67.SchoolData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.PupilListEntry?>()) {
      return (data != null ? _i68.PupilListEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i69.SchoolList?>()) {
      return (data != null ? _i69.SchoolList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i70.SchoolSemester?>()) {
      return (data != null ? _i70.SchoolSemester.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i71.Schoolday?>()) {
      return (data != null ? _i71.Schoolday.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i72.SchooldayEvent?>()) {
      return (data != null ? _i72.SchooldayEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i73.SchooldayEventType?>()) {
      return (data != null ? _i73.SchooldayEventType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i74.Classroom?>()) {
      return (data != null ? _i74.Classroom.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i75.LessonTeacher?>()) {
      return (data != null ? _i75.LessonTeacher.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i76.ScheduledLessonTeacher?>()) {
      return (data != null ? _i76.ScheduledLessonTeacher.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i77.Lesson?>()) {
      return (data != null ? _i77.Lesson.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i78.LessonAttendance?>()) {
      return (data != null ? _i78.LessonAttendance.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i79.LessonGroup?>()) {
      return (data != null ? _i79.LessonGroup.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i80.ScheduledLessonGroupMembership?>()) {
      return (data != null
          ? _i80.ScheduledLessonGroupMembership.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i81.ScheduledLesson?>()) {
      return (data != null ? _i81.ScheduledLesson.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i82.Subject?>()) {
      return (data != null ? _i82.Subject.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i83.TimetableSlot?>()) {
      return (data != null ? _i83.TimetableSlot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i84.Weekday?>()) {
      return (data != null ? _i84.Weekday.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i85.Timetable?>()) {
      return (data != null ? _i85.Timetable.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i86.Role?>()) {
      return (data != null ? _i86.Role.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i87.User?>()) {
      return (data != null ? _i87.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i88.UserFlags?>()) {
      return (data != null ? _i88.UserFlags.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i89.UserWithDevices?>()) {
      return (data != null ? _i89.UserWithDevices.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i90.PupilWorkbook?>()) {
      return (data != null ? _i90.PupilWorkbook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i91.Workbook?>()) {
      return (data != null ? _i91.Workbook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i92.MyException?>()) {
      return (data != null ? _i92.MyException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i93.HubDocument?>()) {
      return (data != null ? _i93.HubDocument.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i94.LastPupilIdentiesUpdate?>()) {
      return (data != null ? _i94.LastPupilIdentiesUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<List<_i93.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i93.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == List<_i6.CreatedUserCredential>) {
      return (data as List)
          .map((e) => deserialize<_i6.CreatedUserCredential>(e))
          .toList() as T;
    }
    if (t == List<_i33.BatchCreateUserError>) {
      return (data as List)
          .map((e) => deserialize<_i33.BatchCreateUserError>(e))
          .toList() as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<Set<int>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<int>(e)).toSet()
          : null) as T;
    }
    if (t == List<_i7.HubLogEntry>) {
      return (data as List).map((e) => deserialize<_i7.HubLogEntry>(e)).toList()
          as T;
    }
    if (t == List<_i8.HubQueryLogEntry>) {
      return (data as List)
          .map((e) => deserialize<_i8.HubQueryLogEntry>(e))
          .toList() as T;
    }
    if (t == List<_i11.HubSessionLogInfo>) {
      return (data as List)
          .map((e) => deserialize<_i11.HubSessionLogInfo>(e))
          .toList() as T;
    }
    if (t == _i1.getType<List<_i19.PupilAuthorization>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.PupilAuthorization>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i23.BookTagging>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i23.BookTagging>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i24.LibraryBook>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i24.LibraryBook>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i23.BookTagging>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i23.BookTagging>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i27.PupilBookLending>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i27.PupilBookLending>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i24.LibraryBook>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i24.LibraryBook>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i22.BookTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i22.BookTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i93.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i93.HubDocument>(e)).toList()
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
    if (t == _i1.getType<List<_i34.CompetenceGoal>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i34.CompetenceGoal>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i2.CompetenceCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i2.CompetenceCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i93.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i93.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i36.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i36.CompetenceReportCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i36.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i36.CompetenceReportCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i40.SupportCategoryStatus>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i40.SupportCategoryStatus>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i41.SupportGoal>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i41.SupportGoal>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i41.SupportGoal>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i41.SupportGoal>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i40.SupportCategoryStatus>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i40.SupportCategoryStatus>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i93.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i93.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i42.SupportGoalCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i42.SupportGoalCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i93.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i93.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i38.LearningSupportPlan>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i38.LearningSupportPlan>(e))
              .toList()
          : null) as T;
    }
    if (t == Set<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toSet() as T;
    }
    if (t == _i1.getType<List<_i61.PupilData>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i61.PupilData>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i93.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i93.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i93.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i93.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i19.PupilAuthorization>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.PupilAuthorization>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i53.CreditTransaction>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i53.CreditTransaction>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i80.ScheduledLessonGroupMembership>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i80.ScheduledLessonGroupMembership>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i78.LessonAttendance>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i78.LessonAttendance>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i34.CompetenceGoal>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i34.CompetenceGoal>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i2.CompetenceCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i2.CompetenceCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i35.CompetenceReport>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i35.CompetenceReport>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i36.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i36.CompetenceReportCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i90.PupilWorkbook>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i90.PupilWorkbook>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i27.PupilBookLending>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i27.PupilBookLending>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i43.SupportLevel>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i43.SupportLevel>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i40.SupportCategoryStatus>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i40.SupportCategoryStatus>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i41.SupportGoal>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i41.SupportGoal>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i38.LearningSupportPlan>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i38.LearningSupportPlan>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i14.MissedSchoolday>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i14.MissedSchoolday>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i72.SchooldayEvent>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i72.SchooldayEvent>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i68.PupilListEntry>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i68.PupilListEntry>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i68.PupilListEntry>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i68.PupilListEntry>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i85.Timetable>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i85.Timetable>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i71.Schoolday>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i71.Schoolday>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i35.CompetenceReport>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i35.CompetenceReport>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i38.LearningSupportPlan>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i38.LearningSupportPlan>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i14.MissedSchoolday>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i14.MissedSchoolday>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i72.SchooldayEvent>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i72.SchooldayEvent>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i81.ScheduledLesson>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i81.ScheduledLesson>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i78.LessonAttendance>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i78.LessonAttendance>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i75.LessonTeacher>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i75.LessonTeacher>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i81.ScheduledLesson>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i81.ScheduledLesson>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i80.ScheduledLessonGroupMembership>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i80.ScheduledLessonGroupMembership>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i76.ScheduledLessonTeacher>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i76.ScheduledLessonTeacher>(e))
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
    if (t == _i1.getType<List<_i81.ScheduledLesson>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i81.ScheduledLesson>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i77.Lesson>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i77.Lesson>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i81.ScheduledLesson>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i81.ScheduledLesson>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i83.TimetableSlot>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i83.TimetableSlot>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i79.LessonGroup>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i79.LessonGroup>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<({String modifiedBy, DateTime modifiedAt})>?>()) {
      return (data != null
          ? (data as List)
              .map((e) =>
                  deserialize<({String modifiedBy, DateTime modifiedAt})>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<({String modifiedBy, DateTime modifiedAt})>()) {
      return (
        modifiedBy:
            deserialize<String>(((data as Map)['n'] as Map)['modifiedBy']),
        modifiedAt: deserialize<DateTime>(data['n']['modifiedAt']),
      ) as T;
    }
    if (t == _i1.getType<List<_i76.ScheduledLessonTeacher>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i76.ScheduledLessonTeacher>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i75.LessonTeacher>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i75.LessonTeacher>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Set<int>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<int>(e)).toSet()
          : null) as T;
    }
    if (t == List<_i17.UserDevice>) {
      return (data as List).map((e) => deserialize<_i17.UserDevice>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i90.PupilWorkbook>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i90.PupilWorkbook>(e))
              .toList()
          : null) as T;
    }
    if (t == List<_i95.Competence>) {
      return (data as List).map((e) => deserialize<_i95.Competence>(e)).toList()
          as T;
    }
    if (t == List<_i96.SupportCategory>) {
      return (data as List)
          .map((e) => deserialize<_i96.SupportCategory>(e))
          .toList() as T;
    }
    if (t == Set<_i97.PupilData>) {
      return (data as List).map((e) => deserialize<_i97.PupilData>(e)).toSet()
          as T;
    }
    if (t == List<_i98.Schoolday>) {
      return (data as List).map((e) => deserialize<_i98.Schoolday>(e)).toList()
          as T;
    }
    if (t == List<DateTime>) {
      return (data as List).map((e) => deserialize<DateTime>(e)).toList() as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<Set<int>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<int>(e)).toSet()
          : null) as T;
    }
    if (t == List<_i99.CreateUserRequest>) {
      return (data as List)
          .map((e) => deserialize<_i99.CreateUserRequest>(e))
          .toList() as T;
    }
    if (t == Set<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toSet() as T;
    }
    if (t == List<_i100.MissedSchoolday>) {
      return (data as List)
          .map((e) => deserialize<_i100.MissedSchoolday>(e))
          .toList() as T;
    }
    if (t ==
        _i1.getType<
            ({
              _i101.AuthenticationResponse response,
              _i102.UserDevice? userDevice
            })>()) {
      return (
        response: deserialize<_i101.AuthenticationResponse>(
            ((data as Map)['n'] as Map)['response']),
        userDevice: ((data)['n'] as Map)['userDevice'] == null
            ? null
            : deserialize<_i102.UserDevice>(data['n']['userDevice']),
      ) as T;
    }
    if (t == List<_i103.Authorization>) {
      return (data as List)
          .map((e) => deserialize<_i103.Authorization>(e))
          .toList() as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t ==
        _i1.getType<
            ({_i104.MemberOperation operation, List<int> pupilIds})?>()) {
      return (data == null)
          ? null as T
          : (
              operation: deserialize<_i104.MemberOperation>(
                  ((data as Map)['n'] as Map)['operation']),
              pupilIds: deserialize<List<int>>(data['n']['pupilIds']),
            ) as T;
    }
    if (t == List<_i105.BookTag>) {
      return (data as List).map((e) => deserialize<_i105.BookTag>(e)).toList()
          as T;
    }
    if (t == List<_i106.Book>) {
      return (data as List).map((e) => deserialize<_i106.Book>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i105.BookTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i105.BookTag>(e)).toList()
          : null) as T;
    }
    if (t == List<_i107.LibraryBookLocation>) {
      return (data as List)
          .map((e) => deserialize<_i107.LibraryBookLocation>(e))
          .toList() as T;
    }
    if (t == List<_i108.LibraryBook>) {
      return (data as List)
          .map((e) => deserialize<_i108.LibraryBook>(e))
          .toList() as T;
    }
    if (t == List<_i109.PupilBookLending>) {
      return (data as List)
          .map((e) => deserialize<_i109.PupilBookLending>(e))
          .toList() as T;
    }
    if (t == List<_i110.HubTypeLastUpdate>) {
      return (data as List)
          .map((e) => deserialize<_i110.HubTypeLastUpdate>(e))
          .toList() as T;
    }
    if (t == _i1.getType<({int value})?>()) {
      return (data == null)
          ? null as T
          : (value: deserialize<int>(((data as Map)['n'] as Map)['value']),)
              as T;
    }
    if (t == _i1.getType<({double value})?>()) {
      return (data == null)
          ? null as T
          : (value: deserialize<double>(((data as Map)['n'] as Map)['value']),)
              as T;
    }
    if (t == _i1.getType<({String value})?>()) {
      return (data == null)
          ? null as T
          : (value: deserialize<String>(((data as Map)['n'] as Map)['value']),)
              as T;
    }
    if (t == _i1.getType<({String? value})?>()) {
      return (data == null)
          ? null as T
          : (
              value: ((data as Map)['n'] as Map)['value'] == null
                  ? null
                  : deserialize<String>(data['n']['value']),
            ) as T;
    }
    if (t == List<_i111.CompetenceGoal>) {
      return (data as List)
          .map((e) => deserialize<_i111.CompetenceGoal>(e))
          .toList() as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<({List<String>? value})?>()) {
      return (data == null)
          ? null as T
          : (
              value: ((data as Map)['n'] as Map)['value'] == null
                  ? null
                  : deserialize<List<String>>(data['n']['value']),
            ) as T;
    }
    if (t == _i1.getType<({int? value})?>()) {
      return (data == null)
          ? null as T
          : (
              value: ((data as Map)['n'] as Map)['value'] == null
                  ? null
                  : deserialize<int>(data['n']['value']),
            ) as T;
    }
    if (t == _i1.getType<({DateTime? value})?>()) {
      return (data == null)
          ? null as T
          : (
              value: ((data as Map)['n'] as Map)['value'] == null
                  ? null
                  : deserialize<DateTime>(data['n']['value']),
            ) as T;
    }
    if (t == _i1.getType<({bool? value})?>()) {
      return (data == null)
          ? null as T
          : (
              value: ((data as Map)['n'] as Map)['value'] == null
                  ? null
                  : deserialize<bool>(data['n']['value']),
            ) as T;
    }
    if (t == List<_i112.CompetenceReport>) {
      return (data as List)
          .map((e) => deserialize<_i112.CompetenceReport>(e))
          .toList() as T;
    }
    if (t == _i1.getType<({DateTime value})?>()) {
      return (data == null)
          ? null as T
          : (
              value:
                  deserialize<DateTime>(((data as Map)['n'] as Map)['value']),
            ) as T;
    }
    if (t == List<_i113.CompetenceReportItem>) {
      return (data as List)
          .map((e) => deserialize<_i113.CompetenceReportItem>(e))
          .toList() as T;
    }
    if (t == List<_i114.SupportGoal>) {
      return (data as List)
          .map((e) => deserialize<_i114.SupportGoal>(e))
          .toList() as T;
    }
    if (t == List<_i115.LearningSupportPlan>) {
      return (data as List)
          .map((e) => deserialize<_i115.LearningSupportPlan>(e))
          .toList() as T;
    }
    if (t == List<_i116.SupportCategoryStatus>) {
      return (data as List)
          .map((e) => deserialize<_i116.SupportCategoryStatus>(e))
          .toList() as T;
    }
    if (t == List<_i117.PreSchoolMedical>) {
      return (data as List)
          .map((e) => deserialize<_i117.PreSchoolMedical>(e))
          .toList() as T;
    }
    if (t == _i1.getType<List<_i118.CompulsoryRoom>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i118.CompulsoryRoom>(e))
              .toList()
          : null) as T;
    }
    if (t == List<_i118.CompulsoryRoom>) {
      return (data as List)
          .map((e) => deserialize<_i118.CompulsoryRoom>(e))
          .toList() as T;
    }
    if (t == List<_i97.PupilData>) {
      return (data as List).map((e) => deserialize<_i97.PupilData>(e)).toList()
          as T;
    }
    if (t == List<_i119.SupportLevelLegacyDto>) {
      return (data as List)
          .map((e) => deserialize<_i119.SupportLevelLegacyDto>(e))
          .toList() as T;
    }
    if (t == _i1.getType<({DateTime? value})>()) {
      return (
        value: ((data as Map)['n'] as Map)['value'] == null
            ? null
            : deserialize<DateTime>(data['n']['value']),
      ) as T;
    }
    if (t == List<_i120.SchoolList>) {
      return (data as List)
          .map((e) => deserialize<_i120.SchoolList>(e))
          .toList() as T;
    }
    if (t == List<_i121.SchoolSemester>) {
      return (data as List)
          .map((e) => deserialize<_i121.SchoolSemester>(e))
          .toList() as T;
    }
    if (t == List<_i122.SchooldayEvent>) {
      return (data as List)
          .map((e) => deserialize<_i122.SchooldayEvent>(e))
          .toList() as T;
    }
    if (t == List<_i123.Classroom>) {
      return (data as List).map((e) => deserialize<_i123.Classroom>(e)).toList()
          as T;
    }
    if (t == List<_i124.LessonGroup>) {
      return (data as List)
          .map((e) => deserialize<_i124.LessonGroup>(e))
          .toList() as T;
    }
    if (t == List<_i125.ScheduledLesson>) {
      return (data as List)
          .map((e) => deserialize<_i125.ScheduledLesson>(e))
          .toList() as T;
    }
    if (t == List<_i126.ScheduledLessonGroupMembership>) {
      return (data as List)
          .map((e) => deserialize<_i126.ScheduledLessonGroupMembership>(e))
          .toList() as T;
    }
    if (t == List<_i127.Subject>) {
      return (data as List).map((e) => deserialize<_i127.Subject>(e)).toList()
          as T;
    }
    if (t == List<_i128.Timetable>) {
      return (data as List).map((e) => deserialize<_i128.Timetable>(e)).toList()
          as T;
    }
    if (t == List<_i129.TimetableSlot>) {
      return (data as List)
          .map((e) => deserialize<_i129.TimetableSlot>(e))
          .toList() as T;
    }
    if (t == List<_i130.User>) {
      return (data as List).map((e) => deserialize<_i130.User>(e)).toList()
          as T;
    }
    if (t == List<_i131.UserWithDevices>) {
      return (data as List)
          .map((e) => deserialize<_i131.UserWithDevices>(e))
          .toList() as T;
    }
    if (t == List<_i132.PupilWorkbook>) {
      return (data as List)
          .map((e) => deserialize<_i132.PupilWorkbook>(e))
          .toList() as T;
    }
    if (t == List<_i133.Workbook>) {
      return (data as List).map((e) => deserialize<_i133.Workbook>(e)).toList()
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
    if (t == _i1.getType<List<({String modifiedBy, DateTime modifiedAt})>?>()) {
      return (data != null
          ? (data as List)
              .map((e) =>
                  deserialize<({String modifiedBy, DateTime modifiedAt})>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<({String modifiedBy, DateTime modifiedAt})>()) {
      return (
        modifiedBy:
            deserialize<String>(((data as Map)['n'] as Map)['modifiedBy']),
        modifiedAt: deserialize<DateTime>(data['n']['modifiedAt']),
      ) as T;
    }
    if (t == _i1.getType<({String modifiedBy, DateTime modifiedAt})>()) {
      return (
        modifiedBy:
            deserialize<String>(((data as Map)['n'] as Map)['modifiedBy']),
        modifiedAt: deserialize<DateTime>(data['n']['modifiedAt']),
      ) as T;
    }
    try {
      return _i101.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.CompetenceCheck) {
      return 'CompetenceCheck';
    }
    if (data is _i3.BatchCreateUserEvent) {
      return 'BatchCreateUserEvent';
    }
    if (data is _i4.BatchCreateUsersResponse) {
      return 'BatchCreateUsersResponse';
    }
    if (data is _i5.CreateUserRequest) {
      return 'CreateUserRequest';
    }
    if (data is _i6.CreatedUserCredential) {
      return 'CreatedUserCredential';
    }
    if (data is _i7.HubLogEntry) {
      return 'HubLogEntry';
    }
    if (data is _i8.HubQueryLogEntry) {
      return 'HubQueryLogEntry';
    }
    if (data is _i9.HubSessionLogEntry) {
      return 'HubSessionLogEntry';
    }
    if (data is _i10.HubSessionLogFilter) {
      return 'HubSessionLogFilter';
    }
    if (data is _i11.HubSessionLogInfo) {
      return 'HubSessionLogInfo';
    }
    if (data is _i12.HubSessionLogResult) {
      return 'HubSessionLogResult';
    }
    if (data is _i13.ContactedType) {
      return 'ContactedType';
    }
    if (data is _i14.MissedSchoolday) {
      return 'MissedSchoolday';
    }
    if (data is _i15.MissedType) {
      return 'MissedType';
    }
    if (data is _i16.DeviceInfo) {
      return 'DeviceInfo';
    }
    if (data is _i17.UserDevice) {
      return 'UserDevice';
    }
    if (data is _i18.Authorization) {
      return 'Authorization';
    }
    if (data is _i19.PupilAuthorization) {
      return 'PupilAuthorization';
    }
    if (data is _i20.Book) {
      return 'Book';
    }
    if (data is _i21.LibraryBookStatsDto) {
      return 'LibraryBookStatsDto';
    }
    if (data is _i22.BookTag) {
      return 'BookTag';
    }
    if (data is _i23.BookTagging) {
      return 'BookTagging';
    }
    if (data is _i24.LibraryBook) {
      return 'LibraryBook';
    }
    if (data is _i25.LibraryBookLocation) {
      return 'LibraryBookLocation';
    }
    if (data is _i26.LibraryBookQuery) {
      return 'LibraryBookQuery';
    }
    if (data is _i27.PupilBookLending) {
      return 'PupilBookLending';
    }
    if (data is _i28.ForceLogoutEvent) {
      return 'ForceLogoutEvent';
    }
    if (data is _i29.HubDeleteEvent) {
      return 'HubDeleteEvent';
    }
    if (data is _i30.HubObjectType) {
      return 'HubObjectType';
    }
    if (data is _i31.HubTypeLastUpdate) {
      return 'HubTypeLastUpdate';
    }
    if (data is _i32.Competence) {
      return 'Competence';
    }
    if (data is _i33.BatchCreateUserError) {
      return 'BatchCreateUserError';
    }
    if (data is _i34.CompetenceGoal) {
      return 'CompetenceGoal';
    }
    if (data is _i35.CompetenceReport) {
      return 'CompetenceReport';
    }
    if (data is _i36.CompetenceReportCheck) {
      return 'CompetenceReportCheck';
    }
    if (data is _i37.CompetenceReportItem) {
      return 'CompetenceReportItem';
    }
    if (data is _i38.LearningSupportPlan) {
      return 'LearningSupportPlan';
    }
    if (data is _i39.SupportCategory) {
      return 'SupportCategory';
    }
    if (data is _i40.SupportCategoryStatus) {
      return 'SupportCategoryStatus';
    }
    if (data is _i41.SupportGoal) {
      return 'SupportGoal';
    }
    if (data is _i42.SupportGoalCheck) {
      return 'SupportGoalCheck';
    }
    if (data is _i43.SupportLevel) {
      return 'SupportLevel';
    }
    if (data is _i44.SupportLevelLegacyDto) {
      return 'SupportLevelLegacyDto';
    }
    if (data is _i45.CompulsoryRoom) {
      return 'CompulsoryRoom';
    }
    if (data is _i46.MatrixRoomType) {
      return 'MatrixRoomType';
    }
    if (data is _i47.AfterSchoolCare) {
      return 'AfterSchoolCare';
    }
    if (data is _i48.AfterSchoolCarePickUpTimes) {
      return 'AfterSchoolCarePickUpTimes';
    }
    if (data is _i49.PickUpInfo) {
      return 'PickUpInfo';
    }
    if (data is _i50.CommunicationSkills) {
      return 'CommunicationSkills';
    }
    if (data is _i51.PublicMediaAuth) {
      return 'PublicMediaAuth';
    }
    if (data is _i52.TutorInfo) {
      return 'TutorInfo';
    }
    if (data is _i53.CreditTransaction) {
      return 'CreditTransaction';
    }
    if (data is _i54.PupilDocumentType) {
      return 'PupilDocumentType';
    }
    if (data is _i55.SiblingsTutorInfo) {
      return 'SiblingsTutorInfo';
    }
    if (data is _i56.Kindergarden) {
      return 'Kindergarden';
    }
    if (data is _i57.KindergardenInfo) {
      return 'KindergardenInfo';
    }
    if (data is _i58.PreSchoolMedical) {
      return 'PreSchoolMedical';
    }
    if (data is _i59.PreSchoolMedicalStatus) {
      return 'PreSchoolMedicalStatus';
    }
    if (data is _i60.PreSchoolTest) {
      return 'PreSchoolTest';
    }
    if (data is _i61.PupilData) {
      return 'PupilData';
    }
    if (data is _i62.PupilStatus) {
      return 'PupilStatus';
    }
    if (data is _i63.MemberOperation) {
      return 'MemberOperation';
    }
    if (data is _i64.PupilIdentity) {
      return 'PupilIdentity';
    }
    if (data is _i65.PupilIdentityDto) {
      return 'PupilIdentityDto';
    }
    if (data is _i66.SchoolGrade) {
      return 'SchoolGrade';
    }
    if (data is _i67.SchoolData) {
      return 'SchoolData';
    }
    if (data is _i68.PupilListEntry) {
      return 'PupilListEntry';
    }
    if (data is _i69.SchoolList) {
      return 'SchoolList';
    }
    if (data is _i70.SchoolSemester) {
      return 'SchoolSemester';
    }
    if (data is _i71.Schoolday) {
      return 'Schoolday';
    }
    if (data is _i72.SchooldayEvent) {
      return 'SchooldayEvent';
    }
    if (data is _i73.SchooldayEventType) {
      return 'SchooldayEventType';
    }
    if (data is _i74.Classroom) {
      return 'Classroom';
    }
    if (data is _i75.LessonTeacher) {
      return 'LessonTeacher';
    }
    if (data is _i76.ScheduledLessonTeacher) {
      return 'ScheduledLessonTeacher';
    }
    if (data is _i77.Lesson) {
      return 'Lesson';
    }
    if (data is _i78.LessonAttendance) {
      return 'LessonAttendance';
    }
    if (data is _i79.LessonGroup) {
      return 'LessonGroup';
    }
    if (data is _i80.ScheduledLessonGroupMembership) {
      return 'ScheduledLessonGroupMembership';
    }
    if (data is _i81.ScheduledLesson) {
      return 'ScheduledLesson';
    }
    if (data is _i82.Subject) {
      return 'Subject';
    }
    if (data is _i83.TimetableSlot) {
      return 'TimetableSlot';
    }
    if (data is _i84.Weekday) {
      return 'Weekday';
    }
    if (data is _i85.Timetable) {
      return 'Timetable';
    }
    if (data is _i86.Role) {
      return 'Role';
    }
    if (data is _i87.User) {
      return 'User';
    }
    if (data is _i88.UserFlags) {
      return 'UserFlags';
    }
    if (data is _i89.UserWithDevices) {
      return 'UserWithDevices';
    }
    if (data is _i90.PupilWorkbook) {
      return 'PupilWorkbook';
    }
    if (data is _i91.Workbook) {
      return 'Workbook';
    }
    if (data is _i92.MyException) {
      return 'MyException';
    }
    if (data is _i93.HubDocument) {
      return 'HubDocument';
    }
    if (data is _i94.LastPupilIdentiesUpdate) {
      return 'LastPupilIdentiesUpdate';
    }
    className = _i101.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    if (data is List<_i97.PupilData>) {
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
    if (dataClassName == 'CompetenceCheck') {
      return deserialize<_i2.CompetenceCheck>(data['data']);
    }
    if (dataClassName == 'BatchCreateUserEvent') {
      return deserialize<_i3.BatchCreateUserEvent>(data['data']);
    }
    if (dataClassName == 'BatchCreateUsersResponse') {
      return deserialize<_i4.BatchCreateUsersResponse>(data['data']);
    }
    if (dataClassName == 'CreateUserRequest') {
      return deserialize<_i5.CreateUserRequest>(data['data']);
    }
    if (dataClassName == 'CreatedUserCredential') {
      return deserialize<_i6.CreatedUserCredential>(data['data']);
    }
    if (dataClassName == 'HubLogEntry') {
      return deserialize<_i7.HubLogEntry>(data['data']);
    }
    if (dataClassName == 'HubQueryLogEntry') {
      return deserialize<_i8.HubQueryLogEntry>(data['data']);
    }
    if (dataClassName == 'HubSessionLogEntry') {
      return deserialize<_i9.HubSessionLogEntry>(data['data']);
    }
    if (dataClassName == 'HubSessionLogFilter') {
      return deserialize<_i10.HubSessionLogFilter>(data['data']);
    }
    if (dataClassName == 'HubSessionLogInfo') {
      return deserialize<_i11.HubSessionLogInfo>(data['data']);
    }
    if (dataClassName == 'HubSessionLogResult') {
      return deserialize<_i12.HubSessionLogResult>(data['data']);
    }
    if (dataClassName == 'ContactedType') {
      return deserialize<_i13.ContactedType>(data['data']);
    }
    if (dataClassName == 'MissedSchoolday') {
      return deserialize<_i14.MissedSchoolday>(data['data']);
    }
    if (dataClassName == 'MissedType') {
      return deserialize<_i15.MissedType>(data['data']);
    }
    if (dataClassName == 'DeviceInfo') {
      return deserialize<_i16.DeviceInfo>(data['data']);
    }
    if (dataClassName == 'UserDevice') {
      return deserialize<_i17.UserDevice>(data['data']);
    }
    if (dataClassName == 'Authorization') {
      return deserialize<_i18.Authorization>(data['data']);
    }
    if (dataClassName == 'PupilAuthorization') {
      return deserialize<_i19.PupilAuthorization>(data['data']);
    }
    if (dataClassName == 'Book') {
      return deserialize<_i20.Book>(data['data']);
    }
    if (dataClassName == 'LibraryBookStatsDto') {
      return deserialize<_i21.LibraryBookStatsDto>(data['data']);
    }
    if (dataClassName == 'BookTag') {
      return deserialize<_i22.BookTag>(data['data']);
    }
    if (dataClassName == 'BookTagging') {
      return deserialize<_i23.BookTagging>(data['data']);
    }
    if (dataClassName == 'LibraryBook') {
      return deserialize<_i24.LibraryBook>(data['data']);
    }
    if (dataClassName == 'LibraryBookLocation') {
      return deserialize<_i25.LibraryBookLocation>(data['data']);
    }
    if (dataClassName == 'LibraryBookQuery') {
      return deserialize<_i26.LibraryBookQuery>(data['data']);
    }
    if (dataClassName == 'PupilBookLending') {
      return deserialize<_i27.PupilBookLending>(data['data']);
    }
    if (dataClassName == 'ForceLogoutEvent') {
      return deserialize<_i28.ForceLogoutEvent>(data['data']);
    }
    if (dataClassName == 'HubDeleteEvent') {
      return deserialize<_i29.HubDeleteEvent>(data['data']);
    }
    if (dataClassName == 'HubObjectType') {
      return deserialize<_i30.HubObjectType>(data['data']);
    }
    if (dataClassName == 'HubTypeLastUpdate') {
      return deserialize<_i31.HubTypeLastUpdate>(data['data']);
    }
    if (dataClassName == 'Competence') {
      return deserialize<_i32.Competence>(data['data']);
    }
    if (dataClassName == 'BatchCreateUserError') {
      return deserialize<_i33.BatchCreateUserError>(data['data']);
    }
    if (dataClassName == 'CompetenceGoal') {
      return deserialize<_i34.CompetenceGoal>(data['data']);
    }
    if (dataClassName == 'CompetenceReport') {
      return deserialize<_i35.CompetenceReport>(data['data']);
    }
    if (dataClassName == 'CompetenceReportCheck') {
      return deserialize<_i36.CompetenceReportCheck>(data['data']);
    }
    if (dataClassName == 'CompetenceReportItem') {
      return deserialize<_i37.CompetenceReportItem>(data['data']);
    }
    if (dataClassName == 'LearningSupportPlan') {
      return deserialize<_i38.LearningSupportPlan>(data['data']);
    }
    if (dataClassName == 'SupportCategory') {
      return deserialize<_i39.SupportCategory>(data['data']);
    }
    if (dataClassName == 'SupportCategoryStatus') {
      return deserialize<_i40.SupportCategoryStatus>(data['data']);
    }
    if (dataClassName == 'SupportGoal') {
      return deserialize<_i41.SupportGoal>(data['data']);
    }
    if (dataClassName == 'SupportGoalCheck') {
      return deserialize<_i42.SupportGoalCheck>(data['data']);
    }
    if (dataClassName == 'SupportLevel') {
      return deserialize<_i43.SupportLevel>(data['data']);
    }
    if (dataClassName == 'SupportLevelLegacyDto') {
      return deserialize<_i44.SupportLevelLegacyDto>(data['data']);
    }
    if (dataClassName == 'CompulsoryRoom') {
      return deserialize<_i45.CompulsoryRoom>(data['data']);
    }
    if (dataClassName == 'MatrixRoomType') {
      return deserialize<_i46.MatrixRoomType>(data['data']);
    }
    if (dataClassName == 'AfterSchoolCare') {
      return deserialize<_i47.AfterSchoolCare>(data['data']);
    }
    if (dataClassName == 'AfterSchoolCarePickUpTimes') {
      return deserialize<_i48.AfterSchoolCarePickUpTimes>(data['data']);
    }
    if (dataClassName == 'PickUpInfo') {
      return deserialize<_i49.PickUpInfo>(data['data']);
    }
    if (dataClassName == 'CommunicationSkills') {
      return deserialize<_i50.CommunicationSkills>(data['data']);
    }
    if (dataClassName == 'PublicMediaAuth') {
      return deserialize<_i51.PublicMediaAuth>(data['data']);
    }
    if (dataClassName == 'TutorInfo') {
      return deserialize<_i52.TutorInfo>(data['data']);
    }
    if (dataClassName == 'CreditTransaction') {
      return deserialize<_i53.CreditTransaction>(data['data']);
    }
    if (dataClassName == 'PupilDocumentType') {
      return deserialize<_i54.PupilDocumentType>(data['data']);
    }
    if (dataClassName == 'SiblingsTutorInfo') {
      return deserialize<_i55.SiblingsTutorInfo>(data['data']);
    }
    if (dataClassName == 'Kindergarden') {
      return deserialize<_i56.Kindergarden>(data['data']);
    }
    if (dataClassName == 'KindergardenInfo') {
      return deserialize<_i57.KindergardenInfo>(data['data']);
    }
    if (dataClassName == 'PreSchoolMedical') {
      return deserialize<_i58.PreSchoolMedical>(data['data']);
    }
    if (dataClassName == 'PreSchoolMedicalStatus') {
      return deserialize<_i59.PreSchoolMedicalStatus>(data['data']);
    }
    if (dataClassName == 'PreSchoolTest') {
      return deserialize<_i60.PreSchoolTest>(data['data']);
    }
    if (dataClassName == 'PupilData') {
      return deserialize<_i61.PupilData>(data['data']);
    }
    if (dataClassName == 'PupilStatus') {
      return deserialize<_i62.PupilStatus>(data['data']);
    }
    if (dataClassName == 'MemberOperation') {
      return deserialize<_i63.MemberOperation>(data['data']);
    }
    if (dataClassName == 'PupilIdentity') {
      return deserialize<_i64.PupilIdentity>(data['data']);
    }
    if (dataClassName == 'PupilIdentityDto') {
      return deserialize<_i65.PupilIdentityDto>(data['data']);
    }
    if (dataClassName == 'SchoolGrade') {
      return deserialize<_i66.SchoolGrade>(data['data']);
    }
    if (dataClassName == 'SchoolData') {
      return deserialize<_i67.SchoolData>(data['data']);
    }
    if (dataClassName == 'PupilListEntry') {
      return deserialize<_i68.PupilListEntry>(data['data']);
    }
    if (dataClassName == 'SchoolList') {
      return deserialize<_i69.SchoolList>(data['data']);
    }
    if (dataClassName == 'SchoolSemester') {
      return deserialize<_i70.SchoolSemester>(data['data']);
    }
    if (dataClassName == 'Schoolday') {
      return deserialize<_i71.Schoolday>(data['data']);
    }
    if (dataClassName == 'SchooldayEvent') {
      return deserialize<_i72.SchooldayEvent>(data['data']);
    }
    if (dataClassName == 'SchooldayEventType') {
      return deserialize<_i73.SchooldayEventType>(data['data']);
    }
    if (dataClassName == 'Classroom') {
      return deserialize<_i74.Classroom>(data['data']);
    }
    if (dataClassName == 'LessonTeacher') {
      return deserialize<_i75.LessonTeacher>(data['data']);
    }
    if (dataClassName == 'ScheduledLessonTeacher') {
      return deserialize<_i76.ScheduledLessonTeacher>(data['data']);
    }
    if (dataClassName == 'Lesson') {
      return deserialize<_i77.Lesson>(data['data']);
    }
    if (dataClassName == 'LessonAttendance') {
      return deserialize<_i78.LessonAttendance>(data['data']);
    }
    if (dataClassName == 'LessonGroup') {
      return deserialize<_i79.LessonGroup>(data['data']);
    }
    if (dataClassName == 'ScheduledLessonGroupMembership') {
      return deserialize<_i80.ScheduledLessonGroupMembership>(data['data']);
    }
    if (dataClassName == 'ScheduledLesson') {
      return deserialize<_i81.ScheduledLesson>(data['data']);
    }
    if (dataClassName == 'Subject') {
      return deserialize<_i82.Subject>(data['data']);
    }
    if (dataClassName == 'TimetableSlot') {
      return deserialize<_i83.TimetableSlot>(data['data']);
    }
    if (dataClassName == 'Weekday') {
      return deserialize<_i84.Weekday>(data['data']);
    }
    if (dataClassName == 'Timetable') {
      return deserialize<_i85.Timetable>(data['data']);
    }
    if (dataClassName == 'Role') {
      return deserialize<_i86.Role>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i87.User>(data['data']);
    }
    if (dataClassName == 'UserFlags') {
      return deserialize<_i88.UserFlags>(data['data']);
    }
    if (dataClassName == 'UserWithDevices') {
      return deserialize<_i89.UserWithDevices>(data['data']);
    }
    if (dataClassName == 'PupilWorkbook') {
      return deserialize<_i90.PupilWorkbook>(data['data']);
    }
    if (dataClassName == 'Workbook') {
      return deserialize<_i91.Workbook>(data['data']);
    }
    if (dataClassName == 'MyException') {
      return deserialize<_i92.MyException>(data['data']);
    }
    if (dataClassName == 'HubDocument') {
      return deserialize<_i93.HubDocument>(data['data']);
    }
    if (dataClassName == 'LastPupilIdentiesUpdate') {
      return deserialize<_i94.LastPupilIdentiesUpdate>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i101.Protocol().deserializeByClassName(data);
    }
    if (dataClassName == 'List<PupilData>') {
      return deserialize<List<_i97.PupilData>>(data['data']);
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
    _i101.AuthenticationResponse response,
    _i102.UserDevice? userDevice
  })) {
    return {
      "n": {
        "response": record.response,
        "userDevice": record.userDevice,
      },
    };
  }
  if (record is ({_i104.MemberOperation operation, List<int> pupilIds})) {
    return {
      "n": {
        "operation": record.operation,
        "pupilIds": record.pupilIds,
      },
    };
  }
  if (record is ({int value})) {
    return {
      "n": {
        "value": record.value,
      },
    };
  }
  if (record is ({double value})) {
    return {
      "n": {
        "value": record.value,
      },
    };
  }
  if (record is ({String value})) {
    return {
      "n": {
        "value": record.value,
      },
    };
  }
  if (record is ({String? value})) {
    return {
      "n": {
        "value": record.value,
      },
    };
  }
  if (record is ({List<String>? value})) {
    return {
      "n": {
        "value": record.value,
      },
    };
  }
  if (record is ({int? value})) {
    return {
      "n": {
        "value": record.value,
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
  if (record is ({bool? value})) {
    return {
      "n": {
        "value": record.value,
      },
    };
  }
  if (record is ({DateTime value})) {
    return {
      "n": {
        "value": record.value,
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
  if (record is ({String modifiedBy, DateTime modifiedAt})) {
    return {
      "n": {
        "modifiedBy": record.modifiedBy,
        "modifiedAt": record.modifiedAt,
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

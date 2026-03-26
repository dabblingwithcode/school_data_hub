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
import 'dart:async' as _i2;
import 'package:school_data_hub_client/src/protocol/_features/learning/competence/models/competence.dart'
    as _i3;
import 'package:school_data_hub_client/src/protocol/_features/learning_support/models/support_category.dart'
    as _i4;
import 'package:school_data_hub_client/src/protocol/_features/admin/models/hub_session_log_result.dart'
    as _i5;
import 'package:school_data_hub_client/src/protocol/_features/admin/models/hub_session_log_filter.dart'
    as _i6;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/pupil_data.dart'
    as _i7;
import 'package:school_data_hub_client/src/protocol/_features/school_data/models/school_data.dart'
    as _i8;
import 'package:school_data_hub_client/src/protocol/_features/schoolday/models/school_semester.dart'
    as _i9;
import 'package:school_data_hub_client/src/protocol/_features/schoolday/models/schoolday.dart'
    as _i10;
import 'package:school_data_hub_client/src/protocol/_features/user/models/staff_user.dart'
    as _i11;
import 'package:school_data_hub_client/src/protocol/_features/user/models/roles.dart'
    as _i12;
import 'package:school_data_hub_client/src/protocol/_features/admin/models/batch_create_users_response.dart'
    as _i13;
import 'package:school_data_hub_client/src/protocol/_features/admin/models/create_user_request.dart'
    as _i14;
import 'package:school_data_hub_client/src/protocol/_features/admin/models/batch_create_user_event.dart'
    as _i15;
import 'package:school_data_hub_client/src/protocol/_features/user/models/user_with_devices.dart'
    as _i16;
import 'package:school_data_hub_client/src/protocol/_features/auth/models/user_device.dart'
    as _i17;
import 'package:school_data_hub_client/src/protocol/_features/attendance/models/missed_schoolday.dart'
    as _i18;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i19;
import 'package:school_data_hub_client/src/protocol/_features/auth/models/device_info.dart'
    as _i20;
import 'package:school_data_hub_client/src/protocol/_features/authorizations/models/authorization.dart'
    as _i21;
import 'package:school_data_hub_client/src/protocol/_shared/models/member_operation.dart'
    as _i22;
import 'package:school_data_hub_client/src/protocol/protocol.dart' as _i23;
import 'package:school_data_hub_client/src/protocol/_features/authorizations/models/pupil_authorization.dart'
    as _i24;
import 'package:school_data_hub_client/src/protocol/_features/books/models/book_tagging/book_tag.dart'
    as _i25;
import 'package:school_data_hub_client/src/protocol/_features/books/models/book.dart'
    as _i26;
import 'package:school_data_hub_client/src/protocol/_features/books/models/book_stats_dto.dart'
    as _i27;
import 'package:school_data_hub_client/src/protocol/_features/books/models/library_book_location.dart'
    as _i28;
import 'package:school_data_hub_client/src/protocol/_features/books/models/library_book.dart'
    as _i29;
import 'package:school_data_hub_client/src/protocol/_features/books/models/library_book_query.dart'
    as _i30;
import 'package:school_data_hub_client/src/protocol/_features/books/models/pupil_book_lending.dart'
    as _i31;
import 'package:school_data_hub_client/src/protocol/_features/hub/models/hub_type_last_update.dart'
    as _i32;
import 'package:school_data_hub_client/src/protocol/_features/learning/competence/models/competence_check.dart'
    as _i33;
import 'package:school_data_hub_client/src/protocol/_features/learning/competence/models/competence_goal.dart'
    as _i34;
import 'package:school_data_hub_client/src/protocol/_features/learning/competence_report/models/competence_report_check.dart'
    as _i35;
import 'package:school_data_hub_client/src/protocol/_features/learning/competence_report/models/competence_report.dart'
    as _i36;
import 'package:school_data_hub_client/src/protocol/_features/learning/competence_report/models/competence_report_item.dart'
    as _i37;
import 'package:school_data_hub_client/src/protocol/_features/learning_support/models/support_goal/support_goal.dart'
    as _i38;
import 'package:school_data_hub_client/src/protocol/_features/learning_support/models/learning_support_plan.dart'
    as _i39;
import 'package:school_data_hub_client/src/protocol/_features/learning_support/models/support_category_status.dart'
    as _i40;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/preschool/pre_school_medical.dart'
    as _i41;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/preschool/pre_school_medical_status.dart'
    as _i42;
import 'package:school_data_hub_client/src/protocol/_features/matrix/compulsory_room.dart'
    as _i43;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/pupil_communication_data.dart'
    as _i44;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/pupil_preschool_data.dart'
    as _i45;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/pupil_media_data.dart'
    as _i46;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/dto/pupil_document_type.dart'
    as _i47;
import 'package:school_data_hub_client/src/protocol/_features/learning_support/models/support_level_legacy_dto.dart'
    as _i48;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_identity/pupil_identity_dto.dart'
    as _i49;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/communication/communication_skills.dart'
    as _i50;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/communication/tutor_info.dart'
    as _i51;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/preschool/kindergarden_info.dart'
    as _i52;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/dto/siblings_tutor_info_dto.dart'
    as _i53;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/communication/public_media_auth.dart'
    as _i54;
import 'package:school_data_hub_client/src/protocol/_features/learning_support/models/support_level.dart'
    as _i55;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/after_school_care/after_school_care.dart'
    as _i56;
import 'package:school_data_hub_client/src/protocol/_features/school_lists/models/school_list.dart'
    as _i57;
import 'package:school_data_hub_client/src/protocol/_features/school_lists/models/pupil_entry.dart'
    as _i58;
import 'package:school_data_hub_client/src/protocol/_features/schoolday_events/models/schoolday_event.dart'
    as _i59;
import 'package:school_data_hub_client/src/protocol/_features/schoolday_events/models/schoolday_event_type.dart'
    as _i60;
import 'package:school_data_hub_client/src/protocol/_features/timetable/models/classroom.dart'
    as _i61;
import 'package:school_data_hub_client/src/protocol/_features/timetable/models/lesson/lesson_group.dart'
    as _i62;
import 'package:school_data_hub_client/src/protocol/_features/timetable/models/scheduled_lesson/scheduled_lesson.dart'
    as _i63;
import 'package:school_data_hub_client/src/protocol/_features/timetable/models/scheduled_lesson/lesson_group_membership.dart'
    as _i64;
import 'package:school_data_hub_client/src/protocol/_features/timetable/models/scheduled_lesson/subject.dart'
    as _i65;
import 'package:school_data_hub_client/src/protocol/_features/timetable/models/timetable.dart'
    as _i66;
import 'package:school_data_hub_client/src/protocol/_features/timetable/models/scheduled_lesson/timetable_slot.dart'
    as _i67;
import 'package:school_data_hub_client/src/protocol/_features/timetable/models/scheduled_lesson/weekday_enum.dart'
    as _i68;
import 'package:school_data_hub_client/src/protocol/_features/workbooks/models/pupil_workbook.dart'
    as _i69;
import 'package:school_data_hub_client/src/protocol/_features/workbooks/models/workbook.dart'
    as _i70;
import 'dart:typed_data' as _i71;
import 'protocol.dart' as _i72;

/// {@category Endpoint}
class EndpointAdminCategories extends _i1.EndpointRef {
  EndpointAdminCategories(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'adminCategories';

  _i2.Future<List<_i3.Competence>> importCompetencesFromJsonFile(
          String filePath) =>
      caller.callServerEndpoint<List<_i3.Competence>>(
        'adminCategories',
        'importCompetencesFromJsonFile',
        {'filePath': filePath},
      );

  _i2.Future<List<_i4.SupportCategory>> importSupportCategoriesFromJsonFile(
          String filePath) =>
      caller.callServerEndpoint<List<_i4.SupportCategory>>(
        'adminCategories',
        'importSupportCategoriesFromJsonFile',
        {'filePath': filePath},
      );
}

/// {@category Endpoint}
class EndpointAdminLogs extends _i1.EndpointRef {
  EndpointAdminLogs(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'adminLogs';

  _i2.Future<_i5.HubSessionLogResult> getSessionLogs(
          _i6.HubSessionLogFilter filter) =>
      caller.callServerEndpoint<_i5.HubSessionLogResult>(
        'adminLogs',
        'getSessionLogs',
        {'filter': filter},
      );

  _i2.Future<void> deleteSessionLog(int sessionLogId) =>
      caller.callServerEndpoint<void>(
        'adminLogs',
        'deleteSessionLog',
        {'sessionLogId': sessionLogId},
      );

  _i2.Future<void> deleteAllSessionLogs() => caller.callServerEndpoint<void>(
        'adminLogs',
        'deleteAllSessionLogs',
        {},
      );
}

/// Endpoint for admin-only pupil operations (e.g. updating backend from external source).
/// {@category Endpoint}
class EndpointAdminPupil extends _i1.EndpointRef {
  EndpointAdminPupil(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'adminPupil';

  /// Updates backend pupil state from reduced sync content. Admin only.
  /// [reducedContent] is newline-separated lines, each line "internalId,afterSchoolCare"
  /// with afterSchoolCare as "true" or "false".
  _i2.Future<Set<_i7.PupilData>> updateBackendPupilDataState(
          String reducedContent) =>
      caller.callServerEndpoint<Set<_i7.PupilData>>(
        'adminPupil',
        'updateBackendPupilDataState',
        {'reducedContent': reducedContent},
      );
}

/// {@category Endpoint}
class EndpointAdminSchoolData extends _i1.EndpointRef {
  EndpointAdminSchoolData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'adminSchoolData';

  _i2.Future<_i8.SchoolData> postSchoolData(_i8.SchoolData schoolData) =>
      caller.callServerEndpoint<_i8.SchoolData>(
        'adminSchoolData',
        'postSchoolData',
        {'schoolData': schoolData},
      );

  /// Update existing school data
  _i2.Future<_i8.SchoolData> updateSchoolData(_i8.SchoolData schoolData) =>
      caller.callServerEndpoint<_i8.SchoolData>(
        'adminSchoolData',
        'updateSchoolData',
        {'schoolData': schoolData},
      );

  /// Upload a logo image and link it to the SchoolData record
  _i2.Future<_i8.SchoolData> uploadLogo(
    int schoolDataId,
    String filePath,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i8.SchoolData>(
        'adminSchoolData',
        'uploadLogo',
        {
          'schoolDataId': schoolDataId,
          'filePath': filePath,
          'createdBy': createdBy,
        },
      );

  /// Upload an official seal image and link it to the SchoolData record
  _i2.Future<_i8.SchoolData> uploadOfficialSeal(
    int schoolDataId,
    String filePath,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i8.SchoolData>(
        'adminSchoolData',
        'uploadOfficialSeal',
        {
          'schoolDataId': schoolDataId,
          'filePath': filePath,
          'createdBy': createdBy,
        },
      );

  /// Delete the logo from SchoolData
  _i2.Future<_i8.SchoolData> deleteLogo(int schoolDataId) =>
      caller.callServerEndpoint<_i8.SchoolData>(
        'adminSchoolData',
        'deleteLogo',
        {'schoolDataId': schoolDataId},
      );

  /// Delete the official seal from SchoolData
  _i2.Future<_i8.SchoolData> deleteOfficialSeal(int schoolDataId) =>
      caller.callServerEndpoint<_i8.SchoolData>(
        'adminSchoolData',
        'deleteOfficialSeal',
        {'schoolDataId': schoolDataId},
      );
}

/// {@category Endpoint}
class EndpointAdminSchoolDay extends _i1.EndpointRef {
  EndpointAdminSchoolDay(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'adminSchoolDay';

  _i2.Future<_i9.SchoolSemester> createSchoolSemester(
    String schoolYearName,
    DateTime startDate,
    DateTime endDate,
    bool isFirst,
    DateTime? classConferenceDate,
    DateTime? supportConferenceDate,
    DateTime? reportConferenceDate,
    DateTime? reportSignedDate,
  ) =>
      caller.callServerEndpoint<_i9.SchoolSemester>(
        'adminSchoolDay',
        'createSchoolSemester',
        {
          'schoolYearName': schoolYearName,
          'startDate': startDate,
          'endDate': endDate,
          'isFirst': isFirst,
          'classConferenceDate': classConferenceDate,
          'supportConferenceDate': supportConferenceDate,
          'reportConferenceDate': reportConferenceDate,
          'reportSignedDate': reportSignedDate,
        },
      );

  _i2.Future<_i9.SchoolSemester?> updateSchoolSemester(
          _i9.SchoolSemester schoolSemester) =>
      caller.callServerEndpoint<_i9.SchoolSemester?>(
        'adminSchoolDay',
        'updateSchoolSemester',
        {'schoolSemester': schoolSemester},
      );

  _i2.Future<bool> deleteSchoolSemester(_i9.SchoolSemester semester) =>
      caller.callServerEndpoint<bool>(
        'adminSchoolDay',
        'deleteSchoolSemester',
        {'semester': semester},
      );

  _i2.Future<_i10.Schoolday?> createSchoolday(DateTime date) =>
      caller.callServerEndpoint<_i10.Schoolday?>(
        'adminSchoolDay',
        'createSchoolday',
        {'date': date},
      );

  _i2.Future<List<_i10.Schoolday>> createSchooldays(List<DateTime> dates) =>
      caller.callServerEndpoint<List<_i10.Schoolday>>(
        'adminSchoolDay',
        'createSchooldays',
        {'dates': dates},
      );

  _i2.Future<_i10.Schoolday> updateSchoolday(_i10.Schoolday schoolday) =>
      caller.callServerEndpoint<_i10.Schoolday>(
        'adminSchoolDay',
        'updateSchoolday',
        {'schoolday': schoolday},
      );

  _i2.Future<bool> deleteSchoolday(DateTime date) =>
      caller.callServerEndpoint<bool>(
        'adminSchoolDay',
        'deleteSchoolday',
        {'date': date},
      );
}

/// The endpoint for admin operations.
/// This endpoint requires the user to be logged in and have admin scope.
/// {@category Endpoint}
class EndpointAdminUser extends _i1.EndpointRef {
  EndpointAdminUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'adminUser';

  _i2.Future<_i11.User> createUser({
    required String userName,
    required String fullName,
    required String email,
    required String password,
    required _i12.Role role,
    required int timeUnits,
    required int reliefTimeUnits,
    required List<String> scopeNames,
    required bool isTester,
    String? schooldayEventsProcessingTeam,
    String? matrixUserId,
    int? credit,
    Set<int>? pupilsAuth,
  }) =>
      caller.callServerEndpoint<_i11.User>(
        'adminUser',
        'createUser',
        {
          'userName': userName,
          'fullName': fullName,
          'email': email,
          'password': password,
          'role': role,
          'timeUnits': timeUnits,
          'reliefTimeUnits': reliefTimeUnits,
          'scopeNames': scopeNames,
          'isTester': isTester,
          'schooldayEventsProcessingTeam': schooldayEventsProcessingTeam,
          'matrixUserId': matrixUserId,
          'credit': credit,
          'pupilsAuth': pupilsAuth,
        },
      );

  /// Batch-creates users sequentially. Returns credentials for successes and errors for skipped/failed rows.
  /// Duplicates are detected by the DB (unique constraint); we catch 23505 and report a friendly message.
  _i2.Future<_i13.BatchCreateUsersResponse> batchCreateUsers(
          List<_i14.CreateUserRequest> requests) =>
      caller.callServerEndpoint<_i13.BatchCreateUsersResponse>(
        'adminUser',
        'batchCreateUsers',
        {'requests': requests},
      );

  /// Streams batch create results one-by-one to avoid HTTP timeout. Duplicates are detected by the DB; we catch 23505 and yield a friendly error event.
  _i2.Stream<_i15.BatchCreateUserEvent> batchCreateUsersStream(
          List<_i14.CreateUserRequest> requests) =>
      caller.callStreamingServerEndpoint<_i2.Stream<_i15.BatchCreateUserEvent>,
          _i15.BatchCreateUserEvent>(
        'adminUser',
        'batchCreateUsersStream',
        {'requests': requests},
        {},
      );

  /// Updates both User and UserInfo in one go. [userId] is the UserInfo id.
  _i2.Future<_i11.User> updateUser(
    int userId, {
    required String userName,
    required String fullName,
    required String email,
    required _i12.Role role,
    String? matrixUserId,
    required int timeUnits,
    required int reliefTimeUnits,
    required int credit,
    required bool isTester,
    Set<int>? pupilsAuth,
  }) =>
      caller.callServerEndpoint<_i11.User>(
        'adminUser',
        'updateUser',
        {
          'userId': userId,
          'userName': userName,
          'fullName': fullName,
          'email': email,
          'role': role,
          'matrixUserId': matrixUserId,
          'timeUnits': timeUnits,
          'reliefTimeUnits': reliefTimeUnits,
          'credit': credit,
          'isTester': isTester,
          'pupilsAuth': pupilsAuth,
        },
      );

  _i2.Future<bool> resetPassword(
    String userEmail,
    String newPassword,
  ) =>
      caller.callServerEndpoint<bool>(
        'adminUser',
        'resetPassword',
        {
          'userEmail': userEmail,
          'newPassword': newPassword,
        },
      );

  _i2.Future<_i16.UserWithDevices?> deleteAuthKeyAssociatedWithDevice(
          _i17.UserDevice device) =>
      caller.callServerEndpoint<_i16.UserWithDevices?>(
        'adminUser',
        'deleteAuthKeyAssociatedWithDevice',
        {'device': device},
      );

  _i2.Future<void> deleteUser(int userId) => caller.callServerEndpoint<void>(
        'adminUser',
        'deleteUser',
        {'userId': userId},
      );

  _i2.Future<void> promoteUserScope(
    int userId,
    String scopeName,
  ) =>
      caller.callServerEndpoint<void>(
        'adminUser',
        'promoteUserScope',
        {
          'userId': userId,
          'scopeName': scopeName,
        },
      );

  _i2.Future<void> demoteUserScope(
    int userId,
    String scopeName,
  ) =>
      caller.callServerEndpoint<void>(
        'adminUser',
        'demoteUserScope',
        {
          'userId': userId,
          'scopeName': scopeName,
        },
      );

  _i2.Future<_i11.User?> getUserById(int userId) =>
      caller.callServerEndpoint<_i11.User?>(
        'adminUser',
        'getUserById',
        {'userId': userId},
      );

  /// Sets the pupilsAuth value for the authenticated user.
  /// [pupilIds] is a set of pupil IDs that the user is authorized to access.
  _i2.Future<_i11.User?> setUserPupilsAuth(Set<int> pupilIds) =>
      caller.callServerEndpoint<_i11.User?>(
        'adminUser',
        'setUserPupilsAuth',
        {'pupilIds': pupilIds},
      );
}

/// {@category Endpoint}
class EndpointMissedSchoolday extends _i1.EndpointRef {
  EndpointMissedSchoolday(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'missedSchoolday';

  _i2.Future<_i18.MissedSchoolday> postMissedSchoolday(
          _i18.MissedSchoolday missedClass) =>
      caller.callServerEndpoint<_i18.MissedSchoolday>(
        'missedSchoolday',
        'postMissedSchoolday',
        {'missedClass': missedClass},
      );

  _i2.Future<List<_i18.MissedSchoolday>> postMissedSchooldays(
          List<_i18.MissedSchoolday> missedClasses) =>
      caller.callServerEndpoint<List<_i18.MissedSchoolday>>(
        'missedSchoolday',
        'postMissedSchooldays',
        {'missedClasses': missedClasses},
      );

  _i2.Future<List<_i18.MissedSchoolday>> fetchAllMissedSchooldays() =>
      caller.callServerEndpoint<List<_i18.MissedSchoolday>>(
        'missedSchoolday',
        'fetchAllMissedSchooldays',
        {},
      );

  _i2.Future<List<_i18.MissedSchoolday>> fetchMissedSchooldaysOnASchoolday(
          DateTime schoolday) =>
      caller.callServerEndpoint<List<_i18.MissedSchoolday>>(
        'missedSchoolday',
        'fetchMissedSchooldaysOnASchoolday',
        {'schoolday': schoolday},
      );

  _i2.Future<bool> deleteMissedSchoolday(
    int pupilId,
    int schooldayId,
  ) =>
      caller.callServerEndpoint<bool>(
        'missedSchoolday',
        'deleteMissedSchoolday',
        {
          'pupilId': pupilId,
          'schooldayId': schooldayId,
        },
      );

  _i2.Future<_i18.MissedSchoolday> updateMissedSchoolday(
          _i18.MissedSchoolday missedSchoolday) =>
      caller.callServerEndpoint<_i18.MissedSchoolday>(
        'missedSchoolday',
        'updateMissedSchoolday',
        {'missedSchoolday': missedSchoolday},
      );
}

/// {@category Endpoint}
class EndpointAuth extends _i1.EndpointRef {
  EndpointAuth(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  _i2.Future<
          ({_i19.AuthenticationResponse response, _i17.UserDevice? userDevice})>
      login(
    String email,
    String password,
    _i20.DeviceInfo deviceInfo,
  ) =>
          caller.callServerEndpoint<
              ({
                _i19.AuthenticationResponse response,
                _i17.UserDevice? userDevice
              })>(
            'auth',
            'login',
            {
              'email': email,
              'password': password,
              'deviceInfo': deviceInfo,
            },
          );

  _i2.Future<bool> logOut(String keyId) => caller.callServerEndpoint<bool>(
        'auth',
        'logOut',
        {'keyId': keyId},
      );
}

/// {@category Endpoint}
class EndpointAuthorization extends _i1.EndpointRef {
  EndpointAuthorization(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'authorization';

  _i2.Future<List<_i21.Authorization>> fetchAuthorizations() =>
      caller.callServerEndpoint<List<_i21.Authorization>>(
        'authorization',
        'fetchAuthorizations',
        {},
      );

  _i2.Future<_i21.Authorization?> fetchAuthorizationById(int id) =>
      caller.callServerEndpoint<_i21.Authorization?>(
        'authorization',
        'fetchAuthorizationById',
        {'id': id},
      );

  _i2.Future<_i21.Authorization> postAuthorizationWithPupils(
    String name,
    String description,
    String createdBy,
    List<int> pupilIds,
  ) =>
      caller.callServerEndpoint<_i21.Authorization>(
        'authorization',
        'postAuthorizationWithPupils',
        {
          'name': name,
          'description': description,
          'createdBy': createdBy,
          'pupilIds': pupilIds,
        },
      );

  _i2.Future<_i21.Authorization> updateAuthorization(
    int authId,
    String? name,
    String? description,
    ({_i22.MemberOperation operation, List<int> pupilIds})? updateMembers,
  ) =>
      caller.callServerEndpoint<_i21.Authorization>(
        'authorization',
        'updateAuthorization',
        {
          'authId': authId,
          'name': name,
          'description': description,
          'updateMembers': _i23.mapRecordToJson(updateMembers),
        },
      );

  _i2.Future<bool> deleteAuthorization(int authId) =>
      caller.callServerEndpoint<bool>(
        'authorization',
        'deleteAuthorization',
        {'authId': authId},
      );
}

/// {@category Endpoint}
class EndpointPupilAuthorization extends _i1.EndpointRef {
  EndpointPupilAuthorization(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'pupilAuthorization';

  _i2.Future<_i24.PupilAuthorization> updatePupilAuthorization(
          _i24.PupilAuthorization authorization) =>
      caller.callServerEndpoint<_i24.PupilAuthorization>(
        'pupilAuthorization',
        'updatePupilAuthorization',
        {'authorization': authorization},
      );

  _i2.Future<_i24.PupilAuthorization> addFileToPupilAuthorization(
    int pupilAuthId,
    String filePath,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i24.PupilAuthorization>(
        'pupilAuthorization',
        'addFileToPupilAuthorization',
        {
          'pupilAuthId': pupilAuthId,
          'filePath': filePath,
          'createdBy': createdBy,
        },
      );

  _i2.Future<_i24.PupilAuthorization> removeFileFromPupilAuthorization(
          int pupilAuthId) =>
      caller.callServerEndpoint<_i24.PupilAuthorization>(
        'pupilAuthorization',
        'removeFileFromPupilAuthorization',
        {'pupilAuthId': pupilAuthId},
      );
}

/// {@category Endpoint}
class EndpointBookTags extends _i1.EndpointRef {
  EndpointBookTags(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'bookTags';

  _i2.Future<_i25.BookTag> postBookTag(_i25.BookTag bookTag) =>
      caller.callServerEndpoint<_i25.BookTag>(
        'bookTags',
        'postBookTag',
        {'bookTag': bookTag},
      );

  _i2.Future<List<_i25.BookTag>> fetchBookTags() =>
      caller.callServerEndpoint<List<_i25.BookTag>>(
        'bookTags',
        'fetchBookTags',
        {},
      );

  _i2.Future<_i25.BookTag> updateBookTag(_i25.BookTag bookTag) =>
      caller.callServerEndpoint<_i25.BookTag>(
        'bookTags',
        'updateBookTag',
        {'bookTag': bookTag},
      );

  _i2.Future<bool> deleteBookTag(_i25.BookTag bookTag) =>
      caller.callServerEndpoint<bool>(
        'bookTags',
        'deleteBookTag',
        {'bookTag': bookTag},
      );
}

/// {@category Endpoint}
class EndpointBooks extends _i1.EndpointRef {
  EndpointBooks(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'books';

  _i2.Future<_i26.Book> postBook(_i26.Book book) =>
      caller.callServerEndpoint<_i26.Book>(
        'books',
        'postBook',
        {'book': book},
      );

  _i2.Future<List<_i26.Book>> fetchBooks() =>
      caller.callServerEndpoint<List<_i26.Book>>(
        'books',
        'fetchBooks',
        {},
      );

  _i2.Future<_i27.LibraryBookStatsDto> getBookStats() =>
      caller.callServerEndpoint<_i27.LibraryBookStatsDto>(
        'books',
        'getBookStats',
        {},
      );

  _i2.Future<_i26.Book?> fetchBookByIsbn(int isbn) =>
      caller.callServerEndpoint<_i26.Book?>(
        'books',
        'fetchBookByIsbn',
        {'isbn': isbn},
      );

  _i2.Future<_i26.Book> updateBookImage(
    int isbn,
    String imagePath,
  ) =>
      caller.callServerEndpoint<_i26.Book>(
        'books',
        'updateBookImage',
        {
          'isbn': isbn,
          'imagePath': imagePath,
        },
      );

  _i2.Future<_i26.Book> updateBookTags(
    int isbn, {
    List<_i25.BookTag>? tags,
  }) =>
      caller.callServerEndpoint<_i26.Book>(
        'books',
        'updateBookTags',
        {
          'isbn': isbn,
          'tags': tags,
        },
      );

  _i2.Future<bool> deleteBook(int id) => caller.callServerEndpoint<bool>(
        'books',
        'deleteBook',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointLibraryBookLocations extends _i1.EndpointRef {
  EndpointLibraryBookLocations(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'libraryBookLocations';

  _i2.Future<_i28.LibraryBookLocation> postLibraryBookLocation(
          _i28.LibraryBookLocation libraryBookLocation) =>
      caller.callServerEndpoint<_i28.LibraryBookLocation>(
        'libraryBookLocations',
        'postLibraryBookLocation',
        {'libraryBookLocation': libraryBookLocation},
      );

  _i2.Future<List<_i28.LibraryBookLocation>> fetchLibraryBookLocations() =>
      caller.callServerEndpoint<List<_i28.LibraryBookLocation>>(
        'libraryBookLocations',
        'fetchLibraryBookLocations',
        {},
      );

  _i2.Future<_i28.LibraryBookLocation> updateLibraryBookLocation(
          _i28.LibraryBookLocation libraryBookLocation) =>
      caller.callServerEndpoint<_i28.LibraryBookLocation>(
        'libraryBookLocations',
        'updateLibraryBookLocation',
        {'libraryBookLocation': libraryBookLocation},
      );

  _i2.Future<bool> deleteLibraryBookLocation(
          _i28.LibraryBookLocation location) =>
      caller.callServerEndpoint<bool>(
        'libraryBookLocations',
        'deleteLibraryBookLocation',
        {'location': location},
      );
}

/// {@category Endpoint}
class EndpointLibraryBooks extends _i1.EndpointRef {
  EndpointLibraryBooks(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'libraryBooks';

  _i2.Future<_i29.LibraryBook> postLibraryBook(
    int isbn,
    String libraryId,
    _i28.LibraryBookLocation location,
  ) =>
      caller.callServerEndpoint<_i29.LibraryBook>(
        'libraryBooks',
        'postLibraryBook',
        {
          'isbn': isbn,
          'libraryId': libraryId,
          'location': location,
        },
      );

  _i2.Future<List<_i29.LibraryBook>> fetchLibraryBooks() =>
      caller.callServerEndpoint<List<_i29.LibraryBook>>(
        'libraryBooks',
        'fetchLibraryBooks',
        {},
      );

  _i2.Future<_i29.LibraryBook?> fetchLibraryBookByIsbn(int isbn) =>
      caller.callServerEndpoint<_i29.LibraryBook?>(
        'libraryBooks',
        'fetchLibraryBookByIsbn',
        {'isbn': isbn},
      );

  _i2.Future<_i29.LibraryBook?> fetchLibraryBookByLibraryId(String libraryId) =>
      caller.callServerEndpoint<_i29.LibraryBook?>(
        'libraryBooks',
        'fetchLibraryBookByLibraryId',
        {'libraryId': libraryId},
      );

  _i2.Future<List<_i29.LibraryBook>> fetchLibraryBooksMatchingQuery(
          _i30.LibraryBookQuery libraryBookQuery) =>
      caller.callServerEndpoint<List<_i29.LibraryBook>>(
        'libraryBooks',
        'fetchLibraryBooksMatchingQuery',
        {'libraryBookQuery': libraryBookQuery},
      );

  _i2.Future<_i29.LibraryBook> updateLibraryBookAndRelatedBook(
    int isbn,
    String libraryId,
    bool? available,
    _i28.LibraryBookLocation? location,
    String? title,
    String? author,
    String? description,
    String? readingLevel,
    List<_i25.BookTag>? tags,
  ) =>
      caller.callServerEndpoint<_i29.LibraryBook>(
        'libraryBooks',
        'updateLibraryBookAndRelatedBook',
        {
          'isbn': isbn,
          'libraryId': libraryId,
          'available': available,
          'location': location,
          'title': title,
          'author': author,
          'description': description,
          'readingLevel': readingLevel,
          'tags': tags,
        },
      );

  _i2.Future<bool> deleteLibraryBook(int libraryBookId) =>
      caller.callServerEndpoint<bool>(
        'libraryBooks',
        'deleteLibraryBook',
        {'libraryBookId': libraryBookId},
      );
}

/// {@category Endpoint}
class EndpointPupilBookLending extends _i1.EndpointRef {
  EndpointPupilBookLending(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'pupilBookLending';

  _i2.Future<_i31.PupilBookLending> postPupilBookLending(
    int pupilId,
    String libraryId,
    String lentBy,
  ) =>
      caller.callServerEndpoint<_i31.PupilBookLending>(
        'pupilBookLending',
        'postPupilBookLending',
        {
          'pupilId': pupilId,
          'libraryId': libraryId,
          'lentBy': lentBy,
        },
      );

  _i2.Future<List<_i31.PupilBookLending>> fetchPupilBookLendings() =>
      caller.callServerEndpoint<List<_i31.PupilBookLending>>(
        'pupilBookLending',
        'fetchPupilBookLendings',
        {},
      );

  _i2.Future<_i31.PupilBookLending?> fetchPupilBookLendingByLendingId(
          String lendingId) =>
      caller.callServerEndpoint<_i31.PupilBookLending?>(
        'pupilBookLending',
        'fetchPupilBookLendingByLendingId',
        {'lendingId': lendingId},
      );

  _i2.Future<_i31.PupilBookLending> updatePupilBookLending(
          _i31.PupilBookLending pupilBookLending) =>
      caller.callServerEndpoint<_i31.PupilBookLending>(
        'pupilBookLending',
        'updatePupilBookLending',
        {'pupilBookLending': pupilBookLending},
      );

  _i2.Future<bool> deletePupilBookLending(String lendingId) =>
      caller.callServerEndpoint<bool>(
        'pupilBookLending',
        'deletePupilBookLending',
        {'lendingId': lendingId},
      );

  /// Add a file to a PupilBookLending record
  _i2.Future<_i31.PupilBookLending> addFileToPupilBookLending(
    String lendingId,
    String filePath,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i31.PupilBookLending>(
        'pupilBookLending',
        'addFileToPupilBookLending',
        {
          'lendingId': lendingId,
          'filePath': filePath,
          'createdBy': createdBy,
        },
      );

  /// Remove a file from a PupilBookLending record
  _i2.Future<bool> removeFileFromPupilBookLending(
    String lendingId,
    String documentId,
  ) =>
      caller.callServerEndpoint<bool>(
        'pupilBookLending',
        'removeFileFromPupilBookLending',
        {
          'lendingId': lendingId,
          'documentId': documentId,
        },
      );
}

/// {@category Endpoint}
class EndpointHub extends _i1.EndpointRef {
  EndpointHub(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'hub';

  _i2.Stream<dynamic> streamHubEvents() =>
      caller.callStreamingServerEndpoint<_i2.Stream<dynamic>, dynamic>(
        'hub',
        'streamHubEvents',
        {},
        {},
      );

  _i2.Future<List<_i32.HubTypeLastUpdate>> getLastChangeTimes() =>
      caller.callServerEndpoint<List<_i32.HubTypeLastUpdate>>(
        'hub',
        'getLastChangeTimes',
        {},
      );
}

/// {@category Endpoint}
class EndpointCompetenceCheck extends _i1.EndpointRef {
  EndpointCompetenceCheck(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'competenceCheck';

  /// Batch-create competence checks for multiple pupils in a single transaction.
  /// Returns the list of affected PupilData objects with full includes.
  _i2.Future<List<_i7.PupilData>> postCompetenceChecks(
          {required List<_i33.CompetenceCheck> checks}) =>
      caller.callServerEndpoint<List<_i7.PupilData>>(
        'competenceCheck',
        'postCompetenceChecks',
        {'checks': checks},
      );

  _i2.Future<_i7.PupilData> postCompetenceCheck({
    required int competenceId,
    required int pupilId,
    required int score,
    String? comment,
    required double valueFactor,
    required String createdBy,
    String? groupCheckId,
    String? groupCheckName,
  }) =>
      caller.callServerEndpoint<_i7.PupilData>(
        'competenceCheck',
        'postCompetenceCheck',
        {
          'competenceId': competenceId,
          'pupilId': pupilId,
          'score': score,
          'comment': comment,
          'valueFactor': valueFactor,
          'createdBy': createdBy,
          'groupCheckId': groupCheckId,
          'groupCheckName': groupCheckName,
        },
      );

  _i2.Future<_i7.PupilData> updateCompetenceCheck(
    String checkId, {
    ({int value})? score,
    ({double value})? valueFactor,
    ({String value})? createdBy,
    ({String? value})? comment,
  }) =>
      caller.callServerEndpoint<_i7.PupilData>(
        'competenceCheck',
        'updateCompetenceCheck',
        {
          'checkId': checkId,
          'score': _i23.mapRecordToJson(score),
          'valueFactor': _i23.mapRecordToJson(valueFactor),
          'createdBy': _i23.mapRecordToJson(createdBy),
          'comment': _i23.mapRecordToJson(comment),
        },
      );

  _i2.Future<_i7.PupilData> deleteCompetenceCheck(String checkId) =>
      caller.callServerEndpoint<_i7.PupilData>(
        'competenceCheck',
        'deleteCompetenceCheck',
        {'checkId': checkId},
      );

  _i2.Future<_i7.PupilData> addFileToCompetenceCheck(
    String checkId,
    String filePath,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i7.PupilData>(
        'competenceCheck',
        'addFileToCompetenceCheck',
        {
          'checkId': checkId,
          'filePath': filePath,
          'createdBy': createdBy,
        },
      );

  _i2.Future<_i7.PupilData> removeFileFromCompetenceCheck(
    String checkId,
    String documentId,
  ) =>
      caller.callServerEndpoint<_i7.PupilData>(
        'competenceCheck',
        'removeFileFromCompetenceCheck',
        {
          'checkId': checkId,
          'documentId': documentId,
        },
      );
}

/// {@category Endpoint}
class EndpointCompetence extends _i1.EndpointRef {
  EndpointCompetence(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'competence';

  _i2.Future<_i3.Competence> postCompetence({
    int? parentCompetence,
    required String name,
    required List<String> level,
    required List<String> indicators,
  }) =>
      caller.callServerEndpoint<_i3.Competence>(
        'competence',
        'postCompetence',
        {
          'parentCompetence': parentCompetence,
          'name': name,
          'level': level,
          'indicators': indicators,
        },
      );

  _i2.Future<List<_i3.Competence>> getAllCompetences() =>
      caller.callServerEndpoint<List<_i3.Competence>>(
        'competence',
        'getAllCompetences',
        {},
      );

  _i2.Future<_i3.Competence> updateCompetence(_i3.Competence competence) =>
      caller.callServerEndpoint<_i3.Competence>(
        'competence',
        'updateCompetence',
        {'competence': competence},
      );

  _i2.Future<bool> deleteCompetence(int publicId) =>
      caller.callServerEndpoint<bool>(
        'competence',
        'deleteCompetence',
        {'publicId': publicId},
      );
}

/// {@category Endpoint}
class EndpointCompetenceGoal extends _i1.EndpointRef {
  EndpointCompetenceGoal(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'competenceGoal';

  /// Fetch all competence goals (used for reconnect / bulk loads).
  _i2.Future<List<_i34.CompetenceGoal>> fetchAllCompetenceGoals() =>
      caller.callServerEndpoint<List<_i34.CompetenceGoal>>(
        'competenceGoal',
        'fetchAllCompetenceGoals',
        {},
      );

  /// Fetch competence goals for a single pupil (lazy loading).
  _i2.Future<List<_i34.CompetenceGoal>> fetchCompetenceGoalsForPupil(
          int pupilId) =>
      caller.callServerEndpoint<List<_i34.CompetenceGoal>>(
        'competenceGoal',
        'fetchCompetenceGoalsForPupil',
        {'pupilId': pupilId},
      );

  _i2.Future<bool> postCompetenceGoal({
    required int competenceId,
    required int pupilId,
    required String description,
    List<String>? strategies,
    required String createdBy,
    String? modifiedBy,
    int? score,
    DateTime? achievedAt,
  }) =>
      caller.callServerEndpoint<bool>(
        'competenceGoal',
        'postCompetenceGoal',
        {
          'competenceId': competenceId,
          'pupilId': pupilId,
          'description': description,
          'strategies': strategies,
          'createdBy': createdBy,
          'modifiedBy': modifiedBy,
          'score': score,
          'achievedAt': achievedAt,
        },
      );

  _i2.Future<bool> updateCompetenceGoal(
    String publicId, {
    ({String value})? description,
    ({List<String>? value})? strategies,
    ({String? value})? modifiedBy,
    ({int? value})? score,
    ({DateTime? value})? achievedAt,
  }) =>
      caller.callServerEndpoint<bool>(
        'competenceGoal',
        'updateCompetenceGoal',
        {
          'publicId': publicId,
          'description': _i23.mapRecordToJson(description),
          'strategies': _i23.mapRecordToJson(strategies),
          'modifiedBy': _i23.mapRecordToJson(modifiedBy),
          'score': _i23.mapRecordToJson(score),
          'achievedAt': _i23.mapRecordToJson(achievedAt),
        },
      );

  _i2.Future<bool> deleteCompetenceGoal(String publicId) =>
      caller.callServerEndpoint<bool>(
        'competenceGoal',
        'deleteCompetenceGoal',
        {'publicId': publicId},
      );

  _i2.Future<bool> addFileToCompetenceGoal(
    String publicId,
    String filePath,
    String createdBy,
  ) =>
      caller.callServerEndpoint<bool>(
        'competenceGoal',
        'addFileToCompetenceGoal',
        {
          'publicId': publicId,
          'filePath': filePath,
          'createdBy': createdBy,
        },
      );

  _i2.Future<bool> removeFileFromCompetenceGoal(
    String publicId,
    String documentId,
  ) =>
      caller.callServerEndpoint<bool>(
        'competenceGoal',
        'removeFileFromCompetenceGoal',
        {
          'publicId': publicId,
          'documentId': documentId,
        },
      );
}

/// {@category Endpoint}
class EndpointCompetenceReportCheck extends _i1.EndpointRef {
  EndpointCompetenceReportCheck(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'competenceReportCheck';

  _i2.Future<_i35.CompetenceReportCheck> postCompetenceReportCheck({
    required int pupilId,
    required int competenceReportItemId,
    required int competenceReportId,
    required int achievement,
    required String comment,
    required String createdBy,
    bool? shouldPrint,
  }) =>
      caller.callServerEndpoint<_i35.CompetenceReportCheck>(
        'competenceReportCheck',
        'postCompetenceReportCheck',
        {
          'pupilId': pupilId,
          'competenceReportItemId': competenceReportItemId,
          'competenceReportId': competenceReportId,
          'achievement': achievement,
          'comment': comment,
          'createdBy': createdBy,
          'shouldPrint': shouldPrint,
        },
      );

  _i2.Future<_i35.CompetenceReportCheck> updateCompetenceReportCheck(
    String publicId, {
    ({int value})? achievement,
    ({String value})? comment,
    ({bool? value})? shouldPrint,
  }) =>
      caller.callServerEndpoint<_i35.CompetenceReportCheck>(
        'competenceReportCheck',
        'updateCompetenceReportCheck',
        {
          'publicId': publicId,
          'achievement': _i23.mapRecordToJson(achievement),
          'comment': _i23.mapRecordToJson(comment),
          'shouldPrint': _i23.mapRecordToJson(shouldPrint),
        },
      );

  _i2.Future<bool> deleteCompetenceReportCheck(String publicId) =>
      caller.callServerEndpoint<bool>(
        'competenceReportCheck',
        'deleteCompetenceReportCheck',
        {'publicId': publicId},
      );
}

/// {@category Endpoint}
class EndpointCompetenceReport extends _i1.EndpointRef {
  EndpointCompetenceReport(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'competenceReport';

  _i2.Future<_i36.CompetenceReport> postCompetenceReport({
    required int pupilId,
    required int schoolSemesterId,
    required String achievement,
    required DateTime achievedAt,
    required String createdBy,
  }) =>
      caller.callServerEndpoint<_i36.CompetenceReport>(
        'competenceReport',
        'postCompetenceReport',
        {
          'pupilId': pupilId,
          'schoolSemesterId': schoolSemesterId,
          'achievement': achievement,
          'achievedAt': achievedAt,
          'createdBy': createdBy,
        },
      );

  _i2.Future<List<_i36.CompetenceReport>> fetchCompetenceReports(int pupilId) =>
      caller.callServerEndpoint<List<_i36.CompetenceReport>>(
        'competenceReport',
        'fetchCompetenceReports',
        {'pupilId': pupilId},
      );

  _i2.Future<_i36.CompetenceReport> updateCompetenceReport(
    String reportId, {
    ({String value})? achievement,
    ({DateTime value})? achievedAt,
    ({String value})? modifiedBy,
    ({DateTime? value})? modifiedAt,
  }) =>
      caller.callServerEndpoint<_i36.CompetenceReport>(
        'competenceReport',
        'updateCompetenceReport',
        {
          'reportId': reportId,
          'achievement': _i23.mapRecordToJson(achievement),
          'achievedAt': _i23.mapRecordToJson(achievedAt),
          'modifiedBy': _i23.mapRecordToJson(modifiedBy),
          'modifiedAt': _i23.mapRecordToJson(modifiedAt),
        },
      );

  _i2.Future<bool> deleteCompetenceReport(String reportId) =>
      caller.callServerEndpoint<bool>(
        'competenceReport',
        'deleteCompetenceReport',
        {'reportId': reportId},
      );
}

/// {@category Endpoint}
class EndpointCompetenceReportItem extends _i1.EndpointRef {
  EndpointCompetenceReportItem(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'competenceReportItem';

  _i2.Future<_i37.CompetenceReportItem> postCompetenceReportItem({
    int? parentItem,
    required String name,
    List<String>? level,
    int? order,
  }) =>
      caller.callServerEndpoint<_i37.CompetenceReportItem>(
        'competenceReportItem',
        'postCompetenceReportItem',
        {
          'parentItem': parentItem,
          'name': name,
          'level': level,
          'order': order,
        },
      );

  _i2.Future<List<_i37.CompetenceReportItem>> fetchAllCompetenceReportItems() =>
      caller.callServerEndpoint<List<_i37.CompetenceReportItem>>(
        'competenceReportItem',
        'fetchAllCompetenceReportItems',
        {},
      );

  _i2.Future<_i37.CompetenceReportItem> updateCompetenceReportItem(
          _i37.CompetenceReportItem competenceReportItem) =>
      caller.callServerEndpoint<_i37.CompetenceReportItem>(
        'competenceReportItem',
        'updateCompetenceReportItem',
        {'competenceReportItem': competenceReportItem},
      );

  _i2.Future<bool> deleteCompetenceReportItem(int publicId) =>
      caller.callServerEndpoint<bool>(
        'competenceReportItem',
        'deleteCompetenceReportItem',
        {'publicId': publicId},
      );
}

/// {@category Endpoint}
class EndpointLearningSupportPlan extends _i1.EndpointRef {
  EndpointLearningSupportPlan(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'learningSupportPlan';

  /// Fetch all support goals (used for reconnect / bulk loads).
  _i2.Future<List<_i38.SupportGoal>> fetchAllSupportGoals() =>
      caller.callServerEndpoint<List<_i38.SupportGoal>>(
        'learningSupportPlan',
        'fetchAllSupportGoals',
        {},
      );

  /// Fetch support goals for a single pupil (lazy loading).
  _i2.Future<List<_i38.SupportGoal>> fetchSupportGoalsForPupil(int pupilId) =>
      caller.callServerEndpoint<List<_i38.SupportGoal>>(
        'learningSupportPlan',
        'fetchSupportGoalsForPupil',
        {'pupilId': pupilId},
      );

  _i2.Future<List<_i39.LearningSupportPlan>> fetchLearningSupportPlans() =>
      caller.callServerEndpoint<List<_i39.LearningSupportPlan>>(
        'learningSupportPlan',
        'fetchLearningSupportPlans',
        {},
      );

  _i2.Future<_i39.LearningSupportPlan> createLearningSupportPlan(
          _i39.LearningSupportPlan plan) =>
      caller.callServerEndpoint<_i39.LearningSupportPlan>(
        'learningSupportPlan',
        'createLearningSupportPlan',
        {'plan': plan},
      );

  _i2.Future<bool> updateLearningSupportPlan(_i39.LearningSupportPlan plan) =>
      caller.callServerEndpoint<bool>(
        'learningSupportPlan',
        'updateLearningSupportPlan',
        {'plan': plan},
      );

  _i2.Future<bool> deleteLearningSupportPlan(_i39.LearningSupportPlan plan) =>
      caller.callServerEndpoint<bool>(
        'learningSupportPlan',
        'deleteLearningSupportPlan',
        {'plan': plan},
      );

  _i2.Future<_i7.PupilData> postSupportCategoryStatus(
    int pupilId,
    int supportCategoryId,
    int learningSupportPlanId,
    int status,
    String? comment,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i7.PupilData>(
        'learningSupportPlan',
        'postSupportCategoryStatus',
        {
          'pupilId': pupilId,
          'supportCategoryId': supportCategoryId,
          'learningSupportPlanId': learningSupportPlanId,
          'status': status,
          'comment': comment,
          'createdBy': createdBy,
        },
      );

  _i2.Future<List<_i40.SupportCategoryStatus>> fetchSupportCategoryStatus(
          int pupilId) =>
      caller.callServerEndpoint<List<_i40.SupportCategoryStatus>>(
        'learningSupportPlan',
        'fetchSupportCategoryStatus',
        {'pupilId': pupilId},
      );

  _i2.Future<List<_i40.SupportCategoryStatus>>
      fetchSupportCategoryStatusFromPupil(int pupilId) =>
          caller.callServerEndpoint<List<_i40.SupportCategoryStatus>>(
            'learningSupportPlan',
            'fetchSupportCategoryStatusFromPupil',
            {'pupilId': pupilId},
          );

  _i2.Future<_i40.SupportCategoryStatus> updateCategoryStatus(
    int pupilId,
    int statusId,
    int? status,
    String? comment,
    String? createdBy,
    DateTime? createdAt,
  ) =>
      caller.callServerEndpoint<_i40.SupportCategoryStatus>(
        'learningSupportPlan',
        'updateCategoryStatus',
        {
          'pupilId': pupilId,
          'statusId': statusId,
          'status': status,
          'comment': comment,
          'createdBy': createdBy,
          'createdAt': createdAt,
        },
      );

  _i2.Future<_i7.PupilData> deleteSupportCategoryStatus(
    int pupilId,
    int statusId,
  ) =>
      caller.callServerEndpoint<_i7.PupilData>(
        'learningSupportPlan',
        'deleteSupportCategoryStatus',
        {
          'pupilId': pupilId,
          'statusId': statusId,
        },
      );

  _i2.Future<bool> postCategoryGoal(
    int pupilId,
    int supportCategoryId,
    String description,
    String strategies,
    String createdBy,
  ) =>
      caller.callServerEndpoint<bool>(
        'learningSupportPlan',
        'postCategoryGoal',
        {
          'pupilId': pupilId,
          'supportCategoryId': supportCategoryId,
          'description': description,
          'strategies': strategies,
          'createdBy': createdBy,
        },
      );

  _i2.Future<bool> updateCategoryGoal(
    int pupilId,
    int supportGoalId,
    String? description,
    String? strategies,
    int? supportCategoryId,
  ) =>
      caller.callServerEndpoint<bool>(
        'learningSupportPlan',
        'updateCategoryGoal',
        {
          'pupilId': pupilId,
          'supportGoalId': supportGoalId,
          'description': description,
          'strategies': strategies,
          'supportCategoryId': supportCategoryId,
        },
      );

  _i2.Future<bool> deleteCategoryGoal(
    int pupilId,
    int supportGoalId,
  ) =>
      caller.callServerEndpoint<bool>(
        'learningSupportPlan',
        'deleteCategoryGoal',
        {
          'pupilId': pupilId,
          'supportGoalId': supportGoalId,
        },
      );

  _i2.Future<bool> postSupportGoalCheck(
    int supportGoalId,
    int score,
    String comment,
    String createdBy,
  ) =>
      caller.callServerEndpoint<bool>(
        'learningSupportPlan',
        'postSupportGoalCheck',
        {
          'supportGoalId': supportGoalId,
          'score': score,
          'comment': comment,
          'createdBy': createdBy,
        },
      );

  _i2.Future<bool> updateSupportGoalCheck(
    int supportGoalCheckId,
    int? score,
    String? comment,
    String? createdBy,
    DateTime? createdAt,
  ) =>
      caller.callServerEndpoint<bool>(
        'learningSupportPlan',
        'updateSupportGoalCheck',
        {
          'supportGoalCheckId': supportGoalCheckId,
          'score': score,
          'comment': comment,
          'createdBy': createdBy,
          'createdAt': createdAt,
        },
      );

  _i2.Future<bool> deleteSupportGoalCheck(
    int supportGoalId,
    int supportGoalCheckId,
  ) =>
      caller.callServerEndpoint<bool>(
        'learningSupportPlan',
        'deleteSupportGoalCheck',
        {
          'supportGoalId': supportGoalId,
          'supportGoalCheckId': supportGoalCheckId,
        },
      );

  _i2.Future<bool> addFileToSupportGoalCheck(
    int supportGoalId,
    int supportGoalCheckId,
    String filePath,
    String createdBy,
  ) =>
      caller.callServerEndpoint<bool>(
        'learningSupportPlan',
        'addFileToSupportGoalCheck',
        {
          'supportGoalId': supportGoalId,
          'supportGoalCheckId': supportGoalCheckId,
          'filePath': filePath,
          'createdBy': createdBy,
        },
      );

  _i2.Future<bool> removeFileFromSupportGoalCheck(
    int supportGoalId,
    int supportGoalCheckId,
    String documentId,
  ) =>
      caller.callServerEndpoint<bool>(
        'learningSupportPlan',
        'removeFileFromSupportGoalCheck',
        {
          'supportGoalId': supportGoalId,
          'supportGoalCheckId': supportGoalCheckId,
          'documentId': documentId,
        },
      );
}

/// {@category Endpoint}
class EndpointPreSchoolMedical extends _i1.EndpointRef {
  EndpointPreSchoolMedical(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'preSchoolMedical';

  /// Create a new PreSchoolMedical record for a pupil
  _i2.Future<_i41.PreSchoolMedical> createPreSchoolMedical(
    int pupilId,
    _i42.PreSchoolMedicalStatus? preschoolMedicalStatus,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i41.PreSchoolMedical>(
        'preSchoolMedical',
        'createPreSchoolMedical',
        {
          'pupilId': pupilId,
          'preschoolMedicalStatus': preschoolMedicalStatus,
          'createdBy': createdBy,
        },
      );

  /// Update an existing PreSchoolMedical record
  _i2.Future<_i41.PreSchoolMedical> updatePreSchoolMedical(
    int preSchoolMedicalId,
    _i42.PreSchoolMedicalStatus? preschoolMedicalStatus,
    String updatedBy,
  ) =>
      caller.callServerEndpoint<_i41.PreSchoolMedical>(
        'preSchoolMedical',
        'updatePreSchoolMedical',
        {
          'preSchoolMedicalId': preSchoolMedicalId,
          'preschoolMedicalStatus': preschoolMedicalStatus,
          'updatedBy': updatedBy,
        },
      );

  /// Get a PreSchoolMedical record by ID
  _i2.Future<_i41.PreSchoolMedical?> getPreSchoolMedical(
          int preSchoolMedicalId) =>
      caller.callServerEndpoint<_i41.PreSchoolMedical?>(
        'preSchoolMedical',
        'getPreSchoolMedical',
        {'preSchoolMedicalId': preSchoolMedicalId},
      );

  /// Get PreSchoolMedical record for a specific pupil
  _i2.Future<_i41.PreSchoolMedical?> getPreSchoolMedicalByPupilId(
          int pupilId) =>
      caller.callServerEndpoint<_i41.PreSchoolMedical?>(
        'preSchoolMedical',
        'getPreSchoolMedicalByPupilId',
        {'pupilId': pupilId},
      );

  /// Delete a PreSchoolMedical record
  _i2.Future<bool> deletePreSchoolMedical(int preSchoolMedicalId) =>
      caller.callServerEndpoint<bool>(
        'preSchoolMedical',
        'deletePreSchoolMedical',
        {'preSchoolMedicalId': preSchoolMedicalId},
      );

  /// Add a file to a PreSchoolMedical record
  _i2.Future<_i41.PreSchoolMedical> addFileToPreSchoolMedical(
    int preSchoolMedicalId,
    String filePath,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i41.PreSchoolMedical>(
        'preSchoolMedical',
        'addFileToPreSchoolMedical',
        {
          'preSchoolMedicalId': preSchoolMedicalId,
          'filePath': filePath,
          'createdBy': createdBy,
        },
      );

  /// Remove a file from a PreSchoolMedical record
  _i2.Future<bool> removeFileFromPreSchoolMedical(
    int preSchoolMedicalId,
    String documentId,
  ) =>
      caller.callServerEndpoint<bool>(
        'preSchoolMedical',
        'removeFileFromPreSchoolMedical',
        {
          'preSchoolMedicalId': preSchoolMedicalId,
          'documentId': documentId,
        },
      );

  /// Get all PreSchoolMedical records (for admin purposes)
  _i2.Future<List<_i41.PreSchoolMedical>> getAllPreSchoolMedicalRecords() =>
      caller.callServerEndpoint<List<_i41.PreSchoolMedical>>(
        'preSchoolMedical',
        'getAllPreSchoolMedicalRecords',
        {},
      );

  /// Get PreSchoolMedical records with specific status
  _i2.Future<List<_i41.PreSchoolMedical>> getPreSchoolMedicalByStatus(
          _i42.PreSchoolMedicalStatus status) =>
      caller.callServerEndpoint<List<_i41.PreSchoolMedical>>(
        'preSchoolMedical',
        'getPreSchoolMedicalByStatus',
        {'status': status},
      );
}

/// {@category Endpoint}
class EndpointSupportCategory extends _i1.EndpointRef {
  EndpointSupportCategory(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'supportCategory';

  _i2.Future<List<_i4.SupportCategory>> fetchSupportCategories() =>
      caller.callServerEndpoint<List<_i4.SupportCategory>>(
        'supportCategory',
        'fetchSupportCategories',
        {},
      );

  _i2.Future<List<_i4.SupportCategory>> importSupportCategoriesFromJsonFile(
          String jsonFilePath) =>
      caller.callServerEndpoint<List<_i4.SupportCategory>>(
        'supportCategory',
        'importSupportCategoriesFromJsonFile',
        {'jsonFilePath': jsonFilePath},
      );

  _i2.Future<bool> createSupportCategory(_i4.SupportCategory category) =>
      caller.callServerEndpoint<bool>(
        'supportCategory',
        'createSupportCategory',
        {'category': category},
      );

  _i2.Future<bool> updateSupportCategory(_i4.SupportCategory category) =>
      caller.callServerEndpoint<bool>(
        'supportCategory',
        'updateSupportCategory',
        {'category': category},
      );

  _i2.Future<bool> deleteSupportCategory(_i4.SupportCategory category) =>
      caller.callServerEndpoint<bool>(
        'supportCategory',
        'deleteSupportCategory',
        {'category': category},
      );
}

/// {@category Endpoint}
class EndpointMatrix extends _i1.EndpointRef {
  EndpointMatrix(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'matrix';

  _i2.Future<List<_i43.CompulsoryRoom>?> getCompulsoryRooms() =>
      caller.callServerEndpoint<List<_i43.CompulsoryRoom>?>(
        'matrix',
        'getCompulsoryRooms',
        {},
      );

  _i2.Future<_i43.CompulsoryRoom?> createCompulsoryRoom(
          _i43.CompulsoryRoom compulsoryRoom) =>
      caller.callServerEndpoint<_i43.CompulsoryRoom?>(
        'matrix',
        'createCompulsoryRoom',
        {'compulsoryRoom': compulsoryRoom},
      );

  _i2.Future<List<_i43.CompulsoryRoom>> setCompulsoryRooms(
          List<_i43.CompulsoryRoom> compulsoryRooms) =>
      caller.callServerEndpoint<List<_i43.CompulsoryRoom>>(
        'matrix',
        'setCompulsoryRooms',
        {'compulsoryRooms': compulsoryRooms},
      );

  _i2.Future<void> deleteCompulsoryRoom(String roomId) =>
      caller.callServerEndpoint<void>(
        'matrix',
        'deleteCompulsoryRoom',
        {'roomId': roomId},
      );
}

/// {@category Endpoint}
class EndpointPupil extends _i1.EndpointRef {
  EndpointPupil(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'pupil';

  _i2.Stream<List<_i7.PupilData>> fetchPupilsAsStream() =>
      caller.callStreamingServerEndpoint<_i2.Stream<List<_i7.PupilData>>,
          List<_i7.PupilData>>(
        'pupil',
        'fetchPupilsAsStream',
        {},
        {},
      );

  _i2.Future<List<_i7.PupilData>> fetchPupils() =>
      caller.callServerEndpoint<List<_i7.PupilData>>(
        'pupil',
        'fetchPupils',
        {},
      );

  /// Lightweight fetch for startup — returns only avatar + support level
  /// relations. Use fetchPupilsById for full detail on individual pupils.
  _i2.Future<List<_i7.PupilData>> fetchPupilsList(Set<int> internalIds) =>
      caller.callServerEndpoint<List<_i7.PupilData>>(
        'pupil',
        'fetchPupilsList',
        {'internalIds': internalIds},
      );

  /// Fetch communication data for a pupil (contact, tutorInfo, etc.).
  _i2.Future<_i44.PupilCommunicationData?> fetchPupilCommunicationData(
          int pupilId) =>
      caller.callServerEndpoint<_i44.PupilCommunicationData?>(
        'pupil',
        'fetchPupilCommunicationData',
        {'pupilId': pupilId},
      );

  /// Fetch preschool data for a pupil (kindergarden, medical, test).
  _i2.Future<_i45.PupilPreschoolData?> fetchPupilPreschoolData(int pupilId) =>
      caller.callServerEndpoint<_i45.PupilPreschoolData?>(
        'pupil',
        'fetchPupilPreschoolData',
        {'pupilId': pupilId},
      );

  /// Fetch media data for a pupil (avatar, auth, publicMediaAuth).
  _i2.Future<_i46.PupilMediaData?> fetchPupilMediaData(int pupilId) =>
      caller.callServerEndpoint<_i46.PupilMediaData?>(
        'pupil',
        'fetchPupilMediaData',
        {'pupilId': pupilId},
      );

  _i2.Future<List<_i7.PupilData>> fetchPupilsById(Set<int> internalIds) =>
      caller.callServerEndpoint<List<_i7.PupilData>>(
        'pupil',
        'fetchPupilsById',
        {'internalIds': internalIds},
      );

  _i2.Future<_i7.PupilData> deletePupilDocument(
    int pupilId,
    _i47.PupilDocumentType documentType,
  ) =>
      caller.callServerEndpoint<_i7.PupilData>(
        'pupil',
        'deletePupilDocument',
        {
          'pupilId': pupilId,
          'documentType': documentType,
        },
      );

  _i2.Future<_i7.PupilData> resetPublicMediaAuth(
    int pupilId,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i7.PupilData>(
        'pupil',
        'resetPublicMediaAuth',
        {
          'pupilId': pupilId,
          'createdBy': createdBy,
        },
      );

  _i2.Future<_i7.PupilData> deleteSupportLevelHistoryItem(
    int pupilId,
    int supportLevelId,
  ) =>
      caller.callServerEndpoint<_i7.PupilData>(
        'pupil',
        'deleteSupportLevelHistoryItem',
        {
          'pupilId': pupilId,
          'supportLevelId': supportLevelId,
        },
      );

  _i2.Future<bool> bulkAddSupportLevels(
          List<_i48.SupportLevelLegacyDto> supportLevelData) =>
      caller.callServerEndpoint<bool>(
        'pupil',
        'bulkAddSupportLevels',
        {'supportLevelData': supportLevelData},
      );
}

/// {@category Endpoint}
class EndpointPupilIdentity extends _i1.EndpointRef {
  EndpointPupilIdentity(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'pupilIdentity';

  _i2.Stream<_i49.PupilIdentityDto> streamEncryptedPupilIds(
          String channelName) =>
      caller.callStreamingServerEndpoint<_i2.Stream<_i49.PupilIdentityDto>,
          _i49.PupilIdentityDto>(
        'pupilIdentity',
        'streamEncryptedPupilIds',
        {'channelName': channelName},
        {},
      );

  _i2.Future<bool> sendPupilIdentityMessage(
    String pupilIdentityChannel,
    _i49.PupilIdentityDto pupilIdentityMessage,
  ) =>
      caller.callServerEndpoint<bool>(
        'pupilIdentity',
        'sendPupilIdentityMessage',
        {
          'pupilIdentityChannel': pupilIdentityChannel,
          'pupilIdentityMessage': pupilIdentityMessage,
        },
      );

  _i2.Future<DateTime?> fetchLastPupilIdentitiesUpdate() =>
      caller.callServerEndpoint<DateTime?>(
        'pupilIdentity',
        'fetchLastPupilIdentitiesUpdate',
        {},
      );

  _i2.Future<DateTime?> insertLastPupilIdentitiesUpdate(DateTime date) =>
      caller.callServerEndpoint<DateTime?>(
        'pupilIdentity',
        'insertLastPupilIdentitiesUpdate',
        {'date': date},
      );

  _i2.Future<bool> deleteLastPupilIdentitiesUpdate() =>
      caller.callServerEndpoint<bool>(
        'pupilIdentity',
        'deleteLastPupilIdentitiesUpdate',
        {},
      );
}

/// {@category Endpoint}
class EndpointPupilUpdate extends _i1.EndpointRef {
  EndpointPupilUpdate(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'pupilUpdate';

  _i2.Future<_i7.PupilData> updatePupil(_i7.PupilData pupil) =>
      caller.callServerEndpoint<_i7.PupilData>(
        'pupilUpdate',
        'updatePupil',
        {'pupil': pupil},
      );

  _i2.Future<_i7.PupilData> updateCommunicationSkills({
    required int pupilId,
    required _i50.CommunicationSkills? communicationSkills,
  }) =>
      caller.callServerEndpoint<_i7.PupilData>(
        'pupilUpdate',
        'updateCommunicationSkills',
        {
          'pupilId': pupilId,
          'communicationSkills': communicationSkills,
        },
      );

  _i2.Future<_i7.PupilData> updateTutorInfo(
    int pupilId,
    _i51.TutorInfo? tutorInfo,
  ) =>
      caller.callServerEndpoint<_i7.PupilData>(
        'pupilUpdate',
        'updateTutorInfo',
        {
          'pupilId': pupilId,
          'tutorInfo': tutorInfo,
        },
      );

  _i2.Future<_i7.PupilData> updateKindergardenData(
    int pupilId,
    _i52.KindergardenInfo? kindergardenData,
  ) =>
      caller.callServerEndpoint<_i7.PupilData>(
        'pupilUpdate',
        'updateKindergardenData',
        {
          'pupilId': pupilId,
          'kindergardenData': kindergardenData,
        },
      );

  _i2.Future<List<_i7.PupilData>> updateSiblingsTutorInfo(
          _i53.SiblingsTutorInfo siblingsTutorInfo) =>
      caller.callServerEndpoint<List<_i7.PupilData>>(
        'pupilUpdate',
        'updateSiblingsTutorInfo',
        {'siblingsTutorInfo': siblingsTutorInfo},
      );

  _i2.Future<_i7.PupilData> updatePupilDocument(
    int pupilId,
    String filePath,
    String createdBy,
    _i47.PupilDocumentType documentType,
  ) =>
      caller.callServerEndpoint<_i7.PupilData>(
        'pupilUpdate',
        'updatePupilDocument',
        {
          'pupilId': pupilId,
          'filePath': filePath,
          'createdBy': createdBy,
          'documentType': documentType,
        },
      );

  _i2.Future<_i7.PupilData> updateStringProperty(
    int pupilId,
    String property,
    ({String? value})? propertyValue,
  ) =>
      caller.callServerEndpoint<_i7.PupilData>(
        'pupilUpdate',
        'updateStringProperty',
        {
          'pupilId': pupilId,
          'property': property,
          'propertyValue': _i23.mapRecordToJson(propertyValue),
        },
      );

  _i2.Future<_i7.PupilData> updateCredit(
    int pupilId,
    int value,
    String? description,
    String sender,
  ) =>
      caller.callServerEndpoint<_i7.PupilData>(
        'pupilUpdate',
        'updateCredit',
        {
          'pupilId': pupilId,
          'value': value,
          'description': description,
          'sender': sender,
        },
      );

  _i2.Future<_i7.PupilData> updatePreSchoolMedicalStatus(
    int pupilId,
    _i42.PreSchoolMedicalStatus preSchoolMedicalStatus,
    String updatedBy,
  ) =>
      caller.callServerEndpoint<_i7.PupilData>(
        'pupilUpdate',
        'updatePreSchoolMedicalStatus',
        {
          'pupilId': pupilId,
          'preSchoolMedicalStatus': preSchoolMedicalStatus,
          'updatedBy': updatedBy,
        },
      );

  _i2.Future<_i7.PupilData> updatePublicMediaAuth(
    int pupilId,
    _i54.PublicMediaAuth publicMediaAuth,
  ) =>
      caller.callServerEndpoint<_i7.PupilData>(
        'pupilUpdate',
        'updatePublicMediaAuth',
        {
          'pupilId': pupilId,
          'publicMediaAuth': publicMediaAuth,
        },
      );

  _i2.Future<_i7.PupilData> updateSupportLevel(
    _i55.SupportLevel supportLevel,
    int pupilId,
  ) =>
      caller.callServerEndpoint<_i7.PupilData>(
        'pupilUpdate',
        'updateSupportLevel',
        {
          'supportLevel': supportLevel,
          'pupilId': pupilId,
        },
      );

  _i2.Future<_i7.PupilData> updateSchoolyearHeldBackDate(
    int pupilId,
    ({DateTime? value}) schoolyearHeldBackDate,
  ) =>
      caller.callServerEndpoint<_i7.PupilData>(
        'pupilUpdate',
        'updateSchoolyearHeldBackDate',
        {
          'pupilId': pupilId,
          'schoolyearHeldBackDate':
              _i23.mapRecordToJson(schoolyearHeldBackDate),
        },
      );

  _i2.Future<_i7.PupilData> updateAfterSchoolCare(
    int pupilId,
    _i56.AfterSchoolCare afterSchoolCare,
  ) =>
      caller.callServerEndpoint<_i7.PupilData>(
        'pupilUpdate',
        'updateAfterSchoolCare',
        {
          'pupilId': pupilId,
          'afterSchoolCare': afterSchoolCare,
        },
      );
}

/// {@category Endpoint}
class EndpointSchoolData extends _i1.EndpointRef {
  EndpointSchoolData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'schoolData';

  _i2.Future<_i8.SchoolData?> getSchoolData() =>
      caller.callServerEndpoint<_i8.SchoolData?>(
        'schoolData',
        'getSchoolData',
        {},
      );
}

/// {@category Endpoint}
class EndpointSchoolList extends _i1.EndpointRef {
  EndpointSchoolList(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'schoolList';

  _i2.Future<List<_i57.SchoolList>> fetchSchoolLists(String userName) =>
      caller.callServerEndpoint<List<_i57.SchoolList>>(
        'schoolList',
        'fetchSchoolLists',
        {'userName': userName},
      );

  _i2.Future<_i57.SchoolList> postSchoolList(
    String name,
    String description,
    List<int> pupilIds,
    bool public,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i57.SchoolList>(
        'schoolList',
        'postSchoolList',
        {
          'name': name,
          'description': description,
          'pupilIds': pupilIds,
          'public': public,
          'createdBy': createdBy,
        },
      );

  _i2.Future<_i57.SchoolList> updateSchoolList(
    int listId,
    String? name,
    String? description,
    ({String? value})? authorizedUsers,
    bool? public,
    ({_i22.MemberOperation operation, List<int> pupilIds})? updateMembers,
  ) =>
      caller.callServerEndpoint<_i57.SchoolList>(
        'schoolList',
        'updateSchoolList',
        {
          'listId': listId,
          'name': name,
          'description': description,
          'authorizedUsers': _i23.mapRecordToJson(authorizedUsers),
          'public': public,
          'updateMembers': _i23.mapRecordToJson(updateMembers),
        },
      );

  _i2.Future<bool> deleteSchoolList(int listId) =>
      caller.callServerEndpoint<bool>(
        'schoolList',
        'deleteSchoolList',
        {'listId': listId},
      );

  _i2.Future<_i58.PupilListEntry> updatePupilListEntry(
          _i58.PupilListEntry entry) =>
      caller.callServerEndpoint<_i58.PupilListEntry>(
        'schoolList',
        'updatePupilListEntry',
        {'entry': entry},
      );
}

/// {@category Endpoint}
class EndpointSchoolday extends _i1.EndpointRef {
  EndpointSchoolday(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'schoolday';

  _i2.Future<List<_i9.SchoolSemester>> getSchoolSemesters() =>
      caller.callServerEndpoint<List<_i9.SchoolSemester>>(
        'schoolday',
        'getSchoolSemesters',
        {},
      );

  _i2.Future<_i9.SchoolSemester?> getCurrentSchoolSemester() =>
      caller.callServerEndpoint<_i9.SchoolSemester?>(
        'schoolday',
        'getCurrentSchoolSemester',
        {},
      );

  _i2.Future<List<_i10.Schoolday>> getSchooldays() =>
      caller.callServerEndpoint<List<_i10.Schoolday>>(
        'schoolday',
        'getSchooldays',
        {},
      );
}

/// {@category Endpoint}
class EndpointSchooldayEvent extends _i1.EndpointRef {
  EndpointSchooldayEvent(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'schooldayEvent';

  _i2.Future<List<_i59.SchooldayEvent>> fetchSchooldayEvents(
          {DateTime? sinceDate}) =>
      caller.callServerEndpoint<List<_i59.SchooldayEvent>>(
        'schooldayEvent',
        'fetchSchooldayEvents',
        {'sinceDate': sinceDate},
      );

  _i2.Future<_i59.SchooldayEvent> createSchooldayEvent({
    required int pupilId,
    required String pupilNameAndGroup,
    required String dateAsString,
    required int schooldayId,
    required _i60.SchooldayEventType type,
    required String reason,
    required String createdBy,
    required String eventTime,
    required String tutor,
  }) =>
      caller.callServerEndpoint<_i59.SchooldayEvent>(
        'schooldayEvent',
        'createSchooldayEvent',
        {
          'pupilId': pupilId,
          'pupilNameAndGroup': pupilNameAndGroup,
          'dateAsString': dateAsString,
          'schooldayId': schooldayId,
          'type': type,
          'reason': reason,
          'createdBy': createdBy,
          'eventTime': eventTime,
          'tutor': tutor,
        },
      );

  _i2.Future<_i59.SchooldayEvent> updateSchooldayEvent(
    _i59.SchooldayEvent schooldayEvent,
    bool changedProcessedStatus,
    String pupilNameAndGroup,
    String tutor,
    String modifiedBy,
    String dateTimeAsString,
  ) =>
      caller.callServerEndpoint<_i59.SchooldayEvent>(
        'schooldayEvent',
        'updateSchooldayEvent',
        {
          'schooldayEvent': schooldayEvent,
          'changedProcessedStatus': changedProcessedStatus,
          'pupilNameAndGroup': pupilNameAndGroup,
          'tutor': tutor,
          'modifiedBy': modifiedBy,
          'dateTimeAsString': dateTimeAsString,
        },
      );

  _i2.Future<bool> deleteSchooldayEvent(int schooldayEventId) =>
      caller.callServerEndpoint<bool>(
        'schooldayEvent',
        'deleteSchooldayEvent',
        {'schooldayEventId': schooldayEventId},
      );

  _i2.Future<_i59.SchooldayEvent> updateSchooldayEventFile(
    int schooldayEventId,
    String filePath,
    String createdBy,
    bool isprocessed,
  ) =>
      caller.callServerEndpoint<_i59.SchooldayEvent>(
        'schooldayEvent',
        'updateSchooldayEventFile',
        {
          'schooldayEventId': schooldayEventId,
          'filePath': filePath,
          'createdBy': createdBy,
          'isprocessed': isprocessed,
        },
      );

  _i2.Future<_i59.SchooldayEvent> deleteSchooldayEventFile(
    int schooldayEventId,
    bool isProcessed,
  ) =>
      caller.callServerEndpoint<_i59.SchooldayEvent>(
        'schooldayEvent',
        'deleteSchooldayEventFile',
        {
          'schooldayEventId': schooldayEventId,
          'isProcessed': isProcessed,
        },
      );
}

/// {@category Endpoint}
class EndpointClassroom extends _i1.EndpointRef {
  EndpointClassroom(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'classroom';

  _i2.Future<_i61.Classroom> createClassroom(_i61.Classroom classroom) =>
      caller.callServerEndpoint<_i61.Classroom>(
        'classroom',
        'createClassroom',
        {'classroom': classroom},
      );

  _i2.Future<List<_i61.Classroom>> fetchClassrooms() =>
      caller.callServerEndpoint<List<_i61.Classroom>>(
        'classroom',
        'fetchClassrooms',
        {},
      );

  _i2.Future<_i61.Classroom?> fetchClassroomById(int id) =>
      caller.callServerEndpoint<_i61.Classroom?>(
        'classroom',
        'fetchClassroomById',
        {'id': id},
      );

  _i2.Future<_i61.Classroom?> fetchClassroomByRoomCode(String roomCode) =>
      caller.callServerEndpoint<_i61.Classroom?>(
        'classroom',
        'fetchClassroomByRoomCode',
        {'roomCode': roomCode},
      );

  _i2.Future<List<_i61.Classroom>> fetchClassroomsByRoomName(String roomName) =>
      caller.callServerEndpoint<List<_i61.Classroom>>(
        'classroom',
        'fetchClassroomsByRoomName',
        {'roomName': roomName},
      );

  _i2.Future<_i61.Classroom> updateClassroom(_i61.Classroom classroom) =>
      caller.callServerEndpoint<_i61.Classroom>(
        'classroom',
        'updateClassroom',
        {'classroom': classroom},
      );

  _i2.Future<bool> deleteClassroom(int id) => caller.callServerEndpoint<bool>(
        'classroom',
        'deleteClassroom',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointLearningGroup extends _i1.EndpointRef {
  EndpointLearningGroup(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'learningGroup';

  _i2.Future<_i62.LessonGroup> createLessonGroup(
          _i62.LessonGroup lessonGroup) =>
      caller.callServerEndpoint<_i62.LessonGroup>(
        'learningGroup',
        'createLessonGroup',
        {'lessonGroup': lessonGroup},
      );

  _i2.Future<List<_i62.LessonGroup>> fetchLessonGroups() =>
      caller.callServerEndpoint<List<_i62.LessonGroup>>(
        'learningGroup',
        'fetchLessonGroups',
        {},
      );

  _i2.Future<_i62.LessonGroup?> fetchLessonGroupById(int id) =>
      caller.callServerEndpoint<_i62.LessonGroup?>(
        'learningGroup',
        'fetchLessonGroupById',
        {'id': id},
      );

  _i2.Future<_i62.LessonGroup?> fetchLessonGroupByPublicId(String publicId) =>
      caller.callServerEndpoint<_i62.LessonGroup?>(
        'learningGroup',
        'fetchLessonGroupByPublicId',
        {'publicId': publicId},
      );

  _i2.Future<List<_i62.LessonGroup>> fetchLessonGroupsByName(String name) =>
      caller.callServerEndpoint<List<_i62.LessonGroup>>(
        'learningGroup',
        'fetchLessonGroupsByName',
        {'name': name},
      );

  _i2.Future<List<_i62.LessonGroup>> fetchLessonGroupsByCreator(
          String createdBy) =>
      caller.callServerEndpoint<List<_i62.LessonGroup>>(
        'learningGroup',
        'fetchLessonGroupsByCreator',
        {'createdBy': createdBy},
      );

  _i2.Future<List<_i62.LessonGroup>> fetchLessonGroupsByTimetable(
          int timetableId) =>
      caller.callServerEndpoint<List<_i62.LessonGroup>>(
        'learningGroup',
        'fetchLessonGroupsByTimetable',
        {'timetableId': timetableId},
      );

  _i2.Future<_i62.LessonGroup> updateLessonGroup(
          _i62.LessonGroup lessonGroup) =>
      caller.callServerEndpoint<_i62.LessonGroup>(
        'learningGroup',
        'updateLessonGroup',
        {'lessonGroup': lessonGroup},
      );

  _i2.Future<bool> deleteLessonGroup(int id) => caller.callServerEndpoint<bool>(
        'learningGroup',
        'deleteLessonGroup',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointScheduledLesson extends _i1.EndpointRef {
  EndpointScheduledLesson(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'scheduledLesson';

  _i2.Future<_i63.ScheduledLesson?> createScheduledLesson(
          _i63.ScheduledLesson scheduledLesson) =>
      caller.callServerEndpoint<_i63.ScheduledLesson?>(
        'scheduledLesson',
        'createScheduledLesson',
        {'scheduledLesson': scheduledLesson},
      );

  _i2.Future<List<_i63.ScheduledLesson>> fetchScheduledLessons() =>
      caller.callServerEndpoint<List<_i63.ScheduledLesson>>(
        'scheduledLesson',
        'fetchScheduledLessons',
        {},
      );

  _i2.Future<_i63.ScheduledLesson?> fetchScheduledLessonById(int id) =>
      caller.callServerEndpoint<_i63.ScheduledLesson?>(
        'scheduledLesson',
        'fetchScheduledLessonById',
        {'id': id},
      );

  _i2.Future<List<_i63.ScheduledLesson>> fetchScheduledLessonsByTimetable(
          int timetableId) =>
      caller.callServerEndpoint<List<_i63.ScheduledLesson>>(
        'scheduledLesson',
        'fetchScheduledLessonsByTimetable',
        {'timetableId': timetableId},
      );

  _i2.Future<List<_i63.ScheduledLesson>> fetchScheduledLessonsBySubject(
          int subjectId) =>
      caller.callServerEndpoint<List<_i63.ScheduledLesson>>(
        'scheduledLesson',
        'fetchScheduledLessonsBySubject',
        {'subjectId': subjectId},
      );

  _i2.Future<List<_i63.ScheduledLesson>> fetchScheduledLessonsByRoom(
          int roomId) =>
      caller.callServerEndpoint<List<_i63.ScheduledLesson>>(
        'scheduledLesson',
        'fetchScheduledLessonsByRoom',
        {'roomId': roomId},
      );

  _i2.Future<List<_i63.ScheduledLesson>> fetchScheduledLessonsBySlotId(
          int slotId) =>
      caller.callServerEndpoint<List<_i63.ScheduledLesson>>(
        'scheduledLesson',
        'fetchScheduledLessonsBySlotId',
        {'slotId': slotId},
      );

  _i2.Future<List<_i63.ScheduledLesson>> fetchActiveScheduledLessons() =>
      caller.callServerEndpoint<List<_i63.ScheduledLesson>>(
        'scheduledLesson',
        'fetchActiveScheduledLessons',
        {},
      );

  _i2.Future<_i63.ScheduledLesson?> updateScheduledLesson(
          _i63.ScheduledLesson scheduledLesson) =>
      caller.callServerEndpoint<_i63.ScheduledLesson?>(
        'scheduledLesson',
        'updateScheduledLesson',
        {'scheduledLesson': scheduledLesson},
      );

  _i2.Future<_i63.ScheduledLesson?> deactivateScheduledLesson(int id) =>
      caller.callServerEndpoint<_i63.ScheduledLesson?>(
        'scheduledLesson',
        'deactivateScheduledLesson',
        {'id': id},
      );

  _i2.Future<bool> deleteScheduledLesson(int id) =>
      caller.callServerEndpoint<bool>(
        'scheduledLesson',
        'deleteScheduledLesson',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointScheduledLessonGroupMembership extends _i1.EndpointRef {
  EndpointScheduledLessonGroupMembership(_i1.EndpointCaller caller)
      : super(caller);

  @override
  String get name => 'scheduledLessonGroupMembership';

  _i2.Future<_i64.ScheduledLessonGroupMembership>
      createScheduledLessonGroupMembership(
              _i64.ScheduledLessonGroupMembership membership) =>
          caller.callServerEndpoint<_i64.ScheduledLessonGroupMembership>(
            'scheduledLessonGroupMembership',
            'createScheduledLessonGroupMembership',
            {'membership': membership},
          );

  _i2.Future<List<_i64.ScheduledLessonGroupMembership>>
      fetchScheduledLessonGroupMemberships() =>
          caller.callServerEndpoint<List<_i64.ScheduledLessonGroupMembership>>(
            'scheduledLessonGroupMembership',
            'fetchScheduledLessonGroupMemberships',
            {},
          );

  _i2.Future<_i64.ScheduledLessonGroupMembership?>
      fetchScheduledLessonGroupMembershipById(int id) =>
          caller.callServerEndpoint<_i64.ScheduledLessonGroupMembership?>(
            'scheduledLessonGroupMembership',
            'fetchScheduledLessonGroupMembershipById',
            {'id': id},
          );

  _i2.Future<List<_i64.ScheduledLessonGroupMembership>>
      fetchMembershipsByLessonGroupId(int lessonGroupId) =>
          caller.callServerEndpoint<List<_i64.ScheduledLessonGroupMembership>>(
            'scheduledLessonGroupMembership',
            'fetchMembershipsByLessonGroupId',
            {'lessonGroupId': lessonGroupId},
          );

  _i2.Future<List<_i64.ScheduledLessonGroupMembership>>
      fetchMembershipsByPupilDataId(int pupilDataId) =>
          caller.callServerEndpoint<List<_i64.ScheduledLessonGroupMembership>>(
            'scheduledLessonGroupMembership',
            'fetchMembershipsByPupilDataId',
            {'pupilDataId': pupilDataId},
          );

  _i2.Future<_i64.ScheduledLessonGroupMembership?>
      fetchMembershipByLessonGroupAndPupil(
    int lessonGroupId,
    int pupilDataId,
  ) =>
          caller.callServerEndpoint<_i64.ScheduledLessonGroupMembership?>(
            'scheduledLessonGroupMembership',
            'fetchMembershipByLessonGroupAndPupil',
            {
              'lessonGroupId': lessonGroupId,
              'pupilDataId': pupilDataId,
            },
          );

  _i2.Future<_i64.ScheduledLessonGroupMembership>
      updateScheduledLessonGroupMembership(
              _i64.ScheduledLessonGroupMembership membership) =>
          caller.callServerEndpoint<_i64.ScheduledLessonGroupMembership>(
            'scheduledLessonGroupMembership',
            'updateScheduledLessonGroupMembership',
            {'membership': membership},
          );

  _i2.Future<bool> deleteScheduledLessonGroupMembership(int id) =>
      caller.callServerEndpoint<bool>(
        'scheduledLessonGroupMembership',
        'deleteScheduledLessonGroupMembership',
        {'id': id},
      );

  _i2.Future<bool> deletePupilFromLessonGroup(
    int lessonGroupId,
    int pupilDataId,
  ) =>
      caller.callServerEndpoint<bool>(
        'scheduledLessonGroupMembership',
        'deletePupilFromLessonGroup',
        {
          'lessonGroupId': lessonGroupId,
          'pupilDataId': pupilDataId,
        },
      );

  _i2.Future<bool> updatePupilMembershipsForLessonGroup(
    int lessonGroupId,
    List<int> pupilDataIds,
  ) =>
      caller.callServerEndpoint<bool>(
        'scheduledLessonGroupMembership',
        'updatePupilMembershipsForLessonGroup',
        {
          'lessonGroupId': lessonGroupId,
          'pupilDataIds': pupilDataIds,
        },
      );
}

/// {@category Endpoint}
class EndpointSubject extends _i1.EndpointRef {
  EndpointSubject(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'subject';

  _i2.Future<_i65.Subject> createSubject(_i65.Subject subject) =>
      caller.callServerEndpoint<_i65.Subject>(
        'subject',
        'createSubject',
        {'subject': subject},
      );

  _i2.Future<List<_i65.Subject>> fetchSubjects() =>
      caller.callServerEndpoint<List<_i65.Subject>>(
        'subject',
        'fetchSubjects',
        {},
      );

  _i2.Future<_i65.Subject?> fetchSubjectById(int id) =>
      caller.callServerEndpoint<_i65.Subject?>(
        'subject',
        'fetchSubjectById',
        {'id': id},
      );

  _i2.Future<_i65.Subject?> fetchSubjectByPublicId(String publicId) =>
      caller.callServerEndpoint<_i65.Subject?>(
        'subject',
        'fetchSubjectByPublicId',
        {'publicId': publicId},
      );

  _i2.Future<List<_i65.Subject>> fetchSubjectsByName(String name) =>
      caller.callServerEndpoint<List<_i65.Subject>>(
        'subject',
        'fetchSubjectsByName',
        {'name': name},
      );

  _i2.Future<List<_i65.Subject>> fetchSubjectsByCreator(String createdBy) =>
      caller.callServerEndpoint<List<_i65.Subject>>(
        'subject',
        'fetchSubjectsByCreator',
        {'createdBy': createdBy},
      );

  _i2.Future<_i65.Subject> updateSubject(_i65.Subject subject) =>
      caller.callServerEndpoint<_i65.Subject>(
        'subject',
        'updateSubject',
        {'subject': subject},
      );

  _i2.Future<bool> deleteSubject(int id) => caller.callServerEndpoint<bool>(
        'subject',
        'deleteSubject',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointTimetable extends _i1.EndpointRef {
  EndpointTimetable(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'timetable';

  _i2.Future<_i66.Timetable> createTimetable(_i66.Timetable timetable) =>
      caller.callServerEndpoint<_i66.Timetable>(
        'timetable',
        'createTimetable',
        {'timetable': timetable},
      );

  _i2.Future<List<_i66.Timetable>> fetchTimetables() =>
      caller.callServerEndpoint<List<_i66.Timetable>>(
        'timetable',
        'fetchTimetables',
        {},
      );

  _i2.Future<_i66.Timetable?> fetchTimetableById(int id) =>
      caller.callServerEndpoint<_i66.Timetable?>(
        'timetable',
        'fetchTimetableById',
        {'id': id},
      );

  _i2.Future<_i66.Timetable?> fetchTimetable() =>
      caller.callServerEndpoint<_i66.Timetable?>(
        'timetable',
        'fetchTimetable',
        {},
      );

  _i2.Future<_i66.Timetable?> fetchCompleteTimetableData() =>
      caller.callServerEndpoint<_i66.Timetable?>(
        'timetable',
        'fetchCompleteTimetableData',
        {},
      );

  _i2.Future<List<_i66.Timetable>> fetchActiveTimetables() =>
      caller.callServerEndpoint<List<_i66.Timetable>>(
        'timetable',
        'fetchActiveTimetables',
        {},
      );

  _i2.Future<List<_i66.Timetable>> fetchTimetablesBySemester(
          int schoolSemesterId) =>
      caller.callServerEndpoint<List<_i66.Timetable>>(
        'timetable',
        'fetchTimetablesBySemester',
        {'schoolSemesterId': schoolSemesterId},
      );

  _i2.Future<_i66.Timetable> updateTimetable(_i66.Timetable timetable) =>
      caller.callServerEndpoint<_i66.Timetable>(
        'timetable',
        'updateTimetable',
        {'timetable': timetable},
      );

  _i2.Future<_i66.Timetable> deactivateTimetable(int id) =>
      caller.callServerEndpoint<_i66.Timetable>(
        'timetable',
        'deactivateTimetable',
        {'id': id},
      );

  _i2.Future<bool> deleteTimetable(int id) => caller.callServerEndpoint<bool>(
        'timetable',
        'deleteTimetable',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointTimetableSlot extends _i1.EndpointRef {
  EndpointTimetableSlot(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'timetableSlot';

  _i2.Future<_i67.TimetableSlot> createTimetableSlot(
          _i67.TimetableSlot timetableSlot) =>
      caller.callServerEndpoint<_i67.TimetableSlot>(
        'timetableSlot',
        'createTimetableSlot',
        {'timetableSlot': timetableSlot},
      );

  _i2.Future<List<_i67.TimetableSlot>> fetchTimetableSlots() =>
      caller.callServerEndpoint<List<_i67.TimetableSlot>>(
        'timetableSlot',
        'fetchTimetableSlots',
        {},
      );

  _i2.Future<_i67.TimetableSlot?> fetchTimetableSlotById(int id) =>
      caller.callServerEndpoint<_i67.TimetableSlot?>(
        'timetableSlot',
        'fetchTimetableSlotById',
        {'id': id},
      );

  _i2.Future<List<_i67.TimetableSlot>> fetchTimetableSlotsByTimetableId(
          int timetableId) =>
      caller.callServerEndpoint<List<_i67.TimetableSlot>>(
        'timetableSlot',
        'fetchTimetableSlotsByTimetableId',
        {'timetableId': timetableId},
      );

  _i2.Future<List<_i67.TimetableSlot>> fetchTimetableSlotsByDay(
          _i68.Weekday day) =>
      caller.callServerEndpoint<List<_i67.TimetableSlot>>(
        'timetableSlot',
        'fetchTimetableSlotsByDay',
        {'day': day},
      );

  _i2.Future<_i67.TimetableSlot> updateTimetableSlot(
          _i67.TimetableSlot timetableSlot) =>
      caller.callServerEndpoint<_i67.TimetableSlot>(
        'timetableSlot',
        'updateTimetableSlot',
        {'timetableSlot': timetableSlot},
      );

  _i2.Future<bool> deleteTimetableSlot(int id) =>
      caller.callServerEndpoint<bool>(
        'timetableSlot',
        'deleteTimetableSlot',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointUser extends _i1.EndpointRef {
  EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  _i2.Future<_i11.User?> getCurrentUser() =>
      caller.callServerEndpoint<_i11.User?>(
        'user',
        'getCurrentUser',
        {},
      );

  _i2.Future<List<_i11.User>> getAllUsers() =>
      caller.callServerEndpoint<List<_i11.User>>(
        'user',
        'getAllUsers',
        {},
      );

  _i2.Future<List<_i16.UserWithDevices>> getAllUsersWithDevices() =>
      caller.callServerEndpoint<List<_i16.UserWithDevices>>(
        'user',
        'getAllUsersWithDevices',
        {},
      );

  _i2.Future<bool> changePassword(
    String oldPassword,
    String newPassword,
  ) =>
      caller.callServerEndpoint<bool>(
        'user',
        'changePassword',
        {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        },
      );

  _i2.Future<bool> increaseStaffCredit() => caller.callServerEndpoint<bool>(
        'user',
        'increaseStaffCredit',
        {},
      );
}

/// {@category Endpoint}
class EndpointPupilWorkbooks extends _i1.EndpointRef {
  EndpointPupilWorkbooks(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'pupilWorkbooks';

  _i2.Future<_i69.PupilWorkbook?> postPupilWorkbook(
    int isbn,
    int pupilId,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i69.PupilWorkbook?>(
        'pupilWorkbooks',
        'postPupilWorkbook',
        {
          'isbn': isbn,
          'pupilId': pupilId,
          'createdBy': createdBy,
        },
      );

  _i2.Future<List<_i69.PupilWorkbook>> fetchPupilWorkbooks() =>
      caller.callServerEndpoint<List<_i69.PupilWorkbook>>(
        'pupilWorkbooks',
        'fetchPupilWorkbooks',
        {},
      );

  _i2.Future<List<_i69.PupilWorkbook>> fetchPupilWorkbooksFromPupil(
          int pupilId) =>
      caller.callServerEndpoint<List<_i69.PupilWorkbook>>(
        'pupilWorkbooks',
        'fetchPupilWorkbooksFromPupil',
        {'pupilId': pupilId},
      );

  _i2.Future<_i69.PupilWorkbook> updatePupilWorkbook(
          _i69.PupilWorkbook pupilWorkbook) =>
      caller.callServerEndpoint<_i69.PupilWorkbook>(
        'pupilWorkbooks',
        'updatePupilWorkbook',
        {'pupilWorkbook': pupilWorkbook},
      );

  _i2.Future<bool> deletePupilWorkbook(int pupilWorkbookId) =>
      caller.callServerEndpoint<bool>(
        'pupilWorkbooks',
        'deletePupilWorkbook',
        {'pupilWorkbookId': pupilWorkbookId},
      );
}

/// {@category Endpoint}
class EndpointWorkbooks extends _i1.EndpointRef {
  EndpointWorkbooks(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'workbooks';

  _i2.Future<_i70.Workbook> postWorkbook(_i70.Workbook workbook) =>
      caller.callServerEndpoint<_i70.Workbook>(
        'workbooks',
        'postWorkbook',
        {'workbook': workbook},
      );

  _i2.Future<_i70.Workbook> fetchWorkbookByIsbn(int isbn) =>
      caller.callServerEndpoint<_i70.Workbook>(
        'workbooks',
        'fetchWorkbookByIsbn',
        {'isbn': isbn},
      );

  _i2.Future<List<_i70.Workbook>> fetchWorkbooks() =>
      caller.callServerEndpoint<List<_i70.Workbook>>(
        'workbooks',
        'fetchWorkbooks',
        {},
      );

  _i2.Future<_i70.Workbook> updateWorkbookImage(
    int isbn,
    String imageUrl,
  ) =>
      caller.callServerEndpoint<_i70.Workbook>(
        'workbooks',
        'updateWorkbookImage',
        {
          'isbn': isbn,
          'imageUrl': imageUrl,
        },
      );

  _i2.Future<_i70.Workbook> deleteWorkbookImage(int isbn) =>
      caller.callServerEndpoint<_i70.Workbook>(
        'workbooks',
        'deleteWorkbookImage',
        {'isbn': isbn},
      );

  _i2.Future<_i70.Workbook> updateWorkbook(_i70.Workbook workbook) =>
      caller.callServerEndpoint<_i70.Workbook>(
        'workbooks',
        'updateWorkbook',
        {'workbook': workbook},
      );

  _i2.Future<bool> deleteWorkbook(int id) => caller.callServerEndpoint<bool>(
        'workbooks',
        'deleteWorkbook',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointFiles extends _i1.EndpointRef {
  EndpointFiles(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'files';

  /// [getUploadDescription]
  /// as described in https://docs.serverpod.dev/concepts/file-uploads#client-side-code
  _i2.Future<String?> getUploadDescription(
    String storageId,
    String path,
  ) =>
      caller.callServerEndpoint<String?>(
        'files',
        'getUploadDescription',
        {
          'storageId': storageId,
          'path': path,
        },
      );

  /// [verifyUpload]
  /// as described in https://docs.serverpod.dev/concepts/file-uploads#client-side-code
  _i2.Future<bool> verifyUpload(
    String storageId,
    String path,
  ) =>
      caller.callServerEndpoint<bool>(
        'files',
        'verifyUpload',
        {
          'storageId': storageId,
          'path': path,
        },
      );

  /// As described in https://docs.serverpod.dev/concepts/file-uploads#client-side-code
  _i2.Future<_i71.ByteData?> getImage(String documentId) =>
      caller.callServerEndpoint<_i71.ByteData?>(
        'files',
        'getImage',
        {'documentId': documentId},
      );

  _i2.Future<_i71.ByteData?> getUnencryptedImage(String path) =>
      caller.callServerEndpoint<_i71.ByteData?>(
        'files',
        'getUnencryptedImage',
        {'path': path},
      );

  /// Overwrites the stored bytes for the file identified by [documentId] with
  /// [newEncryptedBytes] without touching the [HubDocument] record
  /// (preserves [createdBy], [createdAt], etc.).
  _i2.Future<bool> replaceEncryptedFileBytes(
    String documentId,
    _i71.ByteData newEncryptedBytes,
  ) =>
      caller.callServerEndpoint<bool>(
        'files',
        'replaceEncryptedFileBytes',
        {
          'documentId': documentId,
          'newEncryptedBytes': newEncryptedBytes,
        },
      );
}

class Modules {
  Modules(Client client) {
    auth = _i19.Caller(client);
  }

  late final _i19.Caller auth;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i72.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    adminCategories = EndpointAdminCategories(this);
    adminLogs = EndpointAdminLogs(this);
    adminPupil = EndpointAdminPupil(this);
    adminSchoolData = EndpointAdminSchoolData(this);
    adminSchoolDay = EndpointAdminSchoolDay(this);
    adminUser = EndpointAdminUser(this);
    missedSchoolday = EndpointMissedSchoolday(this);
    auth = EndpointAuth(this);
    authorization = EndpointAuthorization(this);
    pupilAuthorization = EndpointPupilAuthorization(this);
    bookTags = EndpointBookTags(this);
    books = EndpointBooks(this);
    libraryBookLocations = EndpointLibraryBookLocations(this);
    libraryBooks = EndpointLibraryBooks(this);
    pupilBookLending = EndpointPupilBookLending(this);
    hub = EndpointHub(this);
    competenceCheck = EndpointCompetenceCheck(this);
    competence = EndpointCompetence(this);
    competenceGoal = EndpointCompetenceGoal(this);
    competenceReportCheck = EndpointCompetenceReportCheck(this);
    competenceReport = EndpointCompetenceReport(this);
    competenceReportItem = EndpointCompetenceReportItem(this);
    learningSupportPlan = EndpointLearningSupportPlan(this);
    preSchoolMedical = EndpointPreSchoolMedical(this);
    supportCategory = EndpointSupportCategory(this);
    matrix = EndpointMatrix(this);
    pupil = EndpointPupil(this);
    pupilIdentity = EndpointPupilIdentity(this);
    pupilUpdate = EndpointPupilUpdate(this);
    schoolData = EndpointSchoolData(this);
    schoolList = EndpointSchoolList(this);
    schoolday = EndpointSchoolday(this);
    schooldayEvent = EndpointSchooldayEvent(this);
    classroom = EndpointClassroom(this);
    learningGroup = EndpointLearningGroup(this);
    scheduledLesson = EndpointScheduledLesson(this);
    scheduledLessonGroupMembership =
        EndpointScheduledLessonGroupMembership(this);
    subject = EndpointSubject(this);
    timetable = EndpointTimetable(this);
    timetableSlot = EndpointTimetableSlot(this);
    user = EndpointUser(this);
    pupilWorkbooks = EndpointPupilWorkbooks(this);
    workbooks = EndpointWorkbooks(this);
    files = EndpointFiles(this);
    modules = Modules(this);
  }

  late final EndpointAdminCategories adminCategories;

  late final EndpointAdminLogs adminLogs;

  late final EndpointAdminPupil adminPupil;

  late final EndpointAdminSchoolData adminSchoolData;

  late final EndpointAdminSchoolDay adminSchoolDay;

  late final EndpointAdminUser adminUser;

  late final EndpointMissedSchoolday missedSchoolday;

  late final EndpointAuth auth;

  late final EndpointAuthorization authorization;

  late final EndpointPupilAuthorization pupilAuthorization;

  late final EndpointBookTags bookTags;

  late final EndpointBooks books;

  late final EndpointLibraryBookLocations libraryBookLocations;

  late final EndpointLibraryBooks libraryBooks;

  late final EndpointPupilBookLending pupilBookLending;

  late final EndpointHub hub;

  late final EndpointCompetenceCheck competenceCheck;

  late final EndpointCompetence competence;

  late final EndpointCompetenceGoal competenceGoal;

  late final EndpointCompetenceReportCheck competenceReportCheck;

  late final EndpointCompetenceReport competenceReport;

  late final EndpointCompetenceReportItem competenceReportItem;

  late final EndpointLearningSupportPlan learningSupportPlan;

  late final EndpointPreSchoolMedical preSchoolMedical;

  late final EndpointSupportCategory supportCategory;

  late final EndpointMatrix matrix;

  late final EndpointPupil pupil;

  late final EndpointPupilIdentity pupilIdentity;

  late final EndpointPupilUpdate pupilUpdate;

  late final EndpointSchoolData schoolData;

  late final EndpointSchoolList schoolList;

  late final EndpointSchoolday schoolday;

  late final EndpointSchooldayEvent schooldayEvent;

  late final EndpointClassroom classroom;

  late final EndpointLearningGroup learningGroup;

  late final EndpointScheduledLesson scheduledLesson;

  late final EndpointScheduledLessonGroupMembership
      scheduledLessonGroupMembership;

  late final EndpointSubject subject;

  late final EndpointTimetable timetable;

  late final EndpointTimetableSlot timetableSlot;

  late final EndpointUser user;

  late final EndpointPupilWorkbooks pupilWorkbooks;

  late final EndpointWorkbooks workbooks;

  late final EndpointFiles files;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'adminCategories': adminCategories,
        'adminLogs': adminLogs,
        'adminPupil': adminPupil,
        'adminSchoolData': adminSchoolData,
        'adminSchoolDay': adminSchoolDay,
        'adminUser': adminUser,
        'missedSchoolday': missedSchoolday,
        'auth': auth,
        'authorization': authorization,
        'pupilAuthorization': pupilAuthorization,
        'bookTags': bookTags,
        'books': books,
        'libraryBookLocations': libraryBookLocations,
        'libraryBooks': libraryBooks,
        'pupilBookLending': pupilBookLending,
        'hub': hub,
        'competenceCheck': competenceCheck,
        'competence': competence,
        'competenceGoal': competenceGoal,
        'competenceReportCheck': competenceReportCheck,
        'competenceReport': competenceReport,
        'competenceReportItem': competenceReportItem,
        'learningSupportPlan': learningSupportPlan,
        'preSchoolMedical': preSchoolMedical,
        'supportCategory': supportCategory,
        'matrix': matrix,
        'pupil': pupil,
        'pupilIdentity': pupilIdentity,
        'pupilUpdate': pupilUpdate,
        'schoolData': schoolData,
        'schoolList': schoolList,
        'schoolday': schoolday,
        'schooldayEvent': schooldayEvent,
        'classroom': classroom,
        'learningGroup': learningGroup,
        'scheduledLesson': scheduledLesson,
        'scheduledLessonGroupMembership': scheduledLessonGroupMembership,
        'subject': subject,
        'timetable': timetable,
        'timetableSlot': timetableSlot,
        'user': user,
        'pupilWorkbooks': pupilWorkbooks,
        'workbooks': workbooks,
        'files': files,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}

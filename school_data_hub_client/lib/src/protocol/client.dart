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
import 'package:school_data_hub_client/src/protocol/user/staff_user.dart'
    as _i3;
import 'package:school_data_hub_client/src/protocol/user/roles/roles.dart'
    as _i4;
import 'package:school_data_hub_client/src/protocol/pupil_data/pupil_data.dart'
    as _i5;
import 'dart:io' as _i6;
import 'package:school_data_hub_client/src/protocol/schoolday/missed_class/missed_class.dart'
    as _i7;
import 'package:school_data_hub_client/src/protocol/user/device_info.dart'
    as _i8;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i9;
import 'package:school_data_hub_client/src/protocol/learning/competence.dart'
    as _i10;
import 'dart:typed_data' as _i11;
import 'package:school_data_hub_client/src/protocol/schoolday/missed_class/missed_class_dto.dart'
    as _i12;
import 'package:school_data_hub_client/src/protocol/pupil_data/pupil_objects/communication/communication_skills.dart'
    as _i13;
import 'package:school_data_hub_client/src/protocol/pupil_data/pupil_objects/communication/tutor_info.dart'
    as _i14;
import 'package:school_data_hub_client/src/protocol/pupil_data/dto/siblings_tutor_info_dto.dart'
    as _i15;
import 'package:school_data_hub_client/src/protocol/learning_support/support_level.dart'
    as _i16;
import 'package:school_data_hub_client/src/protocol/schoolday/school_semester.dart'
    as _i17;
import 'package:school_data_hub_client/src/protocol/schoolday/schoolday.dart'
    as _i18;
import 'package:school_data_hub_client/src/protocol/schoolday/schoolday_event/schoolday_event.dart'
    as _i19;
import 'package:school_data_hub_client/src/protocol/schoolday/schoolday_event/schoolday_event_type.dart'
    as _i20;
import 'package:school_data_hub_client/src/protocol/learning_support/support_category.dart'
    as _i21;
import 'protocol.dart' as _i22;

/// The endpoint for admin operations.
/// This endpoint requires the user to be logged in and have admin scope.
/// {@category Endpoint}
class EndpointAdmin extends _i1.EndpointRef {
  EndpointAdmin(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  _i2.Future<_i3.User> createUser({
    required String userName,
    required String fullName,
    required String email,
    required String password,
    required _i4.Role role,
    required int timeUnits,
    required List<String> scopeNames,
  }) =>
      caller.callServerEndpoint<_i3.User>(
        'admin',
        'createUser',
        {
          'userName': userName,
          'fullName': fullName,
          'email': email,
          'password': password,
          'role': role,
          'timeUnits': timeUnits,
          'scopeNames': scopeNames,
        },
      );

  _i2.Future<void> deleteUser(int userId) => caller.callServerEndpoint<void>(
        'admin',
        'deleteUser',
        {'userId': userId},
      );

  _i2.Future<void> promoteUserScope(
    int userId,
    String scopeName,
  ) =>
      caller.callServerEndpoint<void>(
        'admin',
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
        'admin',
        'demoteUserScope',
        {
          'userId': userId,
          'scopeName': scopeName,
        },
      );

  _i2.Future<List<_i3.User>> getAllUsers() =>
      caller.callServerEndpoint<List<_i3.User>>(
        'admin',
        'getAllUsers',
        {},
      );

  _i2.Future<_i3.User?> getUserById(int userId) =>
      caller.callServerEndpoint<_i3.User?>(
        'admin',
        'getUserById',
        {'userId': userId},
      );

  _i2.Future<Set<_i5.PupilData>> updateBackendPupilDataState(_i6.File file) =>
      caller.callServerEndpoint<Set<_i5.PupilData>>(
        'admin',
        'updateBackendPupilDataState',
        {'file': file},
      );
}

/// {@category Endpoint}
class EndpointAttendance extends _i1.EndpointRef {
  EndpointAttendance(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'attendance';

  _i2.Future<List<_i7.MissedClass>> fetchMissedClassesOnASchoolday(
          DateTime schoolday) =>
      caller.callServerEndpoint<List<_i7.MissedClass>>(
        'attendance',
        'fetchMissedClassesOnASchoolday',
        {'schoolday': schoolday},
      );

  _i2.Future<List<_i7.MissedClass>> fetchMissedClasses() =>
      caller.callServerEndpoint<List<_i7.MissedClass>>(
        'attendance',
        'fetchMissedClasses',
        {},
      );

  _i2.Future<bool> createMissedClass(_i7.MissedClass missedClass) =>
      caller.callServerEndpoint<bool>(
        'attendance',
        'createMissedClass',
        {'missedClass': missedClass},
      );

  _i2.Future<bool> deleteMissedClass(_i7.MissedClass missedClass) =>
      caller.callServerEndpoint<bool>(
        'attendance',
        'deleteMissedClass',
        {'missedClass': missedClass},
      );
}

/// {@category Endpoint}
class EndpointAuth extends _i1.EndpointRef {
  EndpointAuth(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  _i2.Future<
      ({
        _i8.DeviceInfo? deviceInfo,
        _i9.AuthenticationResponse response
      })> login(
    String email,
    String password,
    _i8.DeviceInfo deviceInfo,
  ) =>
      caller.callServerEndpoint<
          ({_i8.DeviceInfo? deviceInfo, _i9.AuthenticationResponse response})>(
        'auth',
        'login',
        {
          'email': email,
          'password': password,
          'deviceInfo': deviceInfo,
        },
      );

  _i2.Future<bool> verifyPassword(
    int userId,
    String password,
  ) =>
      caller.callServerEndpoint<bool>(
        'auth',
        'verifyPassword',
        {
          'userId': userId,
          'password': password,
        },
      );

  _i2.Future<bool> logOut(String keyId) => caller.callServerEndpoint<bool>(
        'auth',
        'logOut',
        {'keyId': keyId},
      );
}

/// {@category Endpoint}
class EndpointCompetence extends _i1.EndpointRef {
  EndpointCompetence(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'competence';

  _i2.Future<List<_i10.Competence>> importCompetencesFromJsonFile(
          _i6.File jsonFile) =>
      caller.callServerEndpoint<List<_i10.Competence>>(
        'competence',
        'importCompetencesFromJsonFile',
        {'jsonFile': jsonFile},
      );

  _i2.Future<_i10.Competence> postCompetence({
    int? parentCompetence,
    required String name,
    required List<String> level,
    required List<String> indicators,
  }) =>
      caller.callServerEndpoint<_i10.Competence>(
        'competence',
        'postCompetence',
        {
          'parentCompetence': parentCompetence,
          'name': name,
          'level': level,
          'indicators': indicators,
        },
      );

  _i2.Future<List<_i10.Competence>> getAllCompetences() =>
      caller.callServerEndpoint<List<_i10.Competence>>(
        'competence',
        'getAllCompetences',
        {},
      );

  _i2.Future<_i10.Competence> updateCompetence(_i10.Competence competence) =>
      caller.callServerEndpoint<_i10.Competence>(
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
  _i2.Future<_i11.ByteData?> getImage(String documentId) =>
      caller.callServerEndpoint<_i11.ByteData?>(
        'files',
        'getImage',
        {'documentId': documentId},
      );
}

/// {@category Endpoint}
class EndpointMissedClass extends _i1.EndpointRef {
  EndpointMissedClass(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'missedClass';

  _i2.Stream<_i12.MissedClassDto> streamMyModels() =>
      caller.callStreamingServerEndpoint<_i2.Stream<_i12.MissedClassDto>,
          _i12.MissedClassDto>(
        'missedClass',
        'streamMyModels',
        {},
        {},
      );

  _i2.Future<_i7.MissedClass> postMissedClass(_i7.MissedClass missedClass) =>
      caller.callServerEndpoint<_i7.MissedClass>(
        'missedClass',
        'postMissedClass',
        {'missedClass': missedClass},
      );

  _i2.Future<List<_i7.MissedClass>> postMissedClasses(
          List<_i7.MissedClass> missedClasses) =>
      caller.callServerEndpoint<List<_i7.MissedClass>>(
        'missedClass',
        'postMissedClasses',
        {'missedClasses': missedClasses},
      );

  _i2.Future<List<_i7.MissedClass>> fetchAllMissedClasses() =>
      caller.callServerEndpoint<List<_i7.MissedClass>>(
        'missedClass',
        'fetchAllMissedClasses',
        {},
      );

  _i2.Future<List<_i7.MissedClass>> fetchMissedClassesOnASchoolday(
          DateTime schoolday) =>
      caller.callServerEndpoint<List<_i7.MissedClass>>(
        'missedClass',
        'fetchMissedClassesOnASchoolday',
        {'schoolday': schoolday},
      );

  _i2.Future<bool> deleteMissedClass(
    int pupilId,
    int schooldayId,
  ) =>
      caller.callServerEndpoint<bool>(
        'missedClass',
        'deleteMissedClass',
        {
          'pupilId': pupilId,
          'schooldayId': schooldayId,
        },
      );

  _i2.Future<_i7.MissedClass> updateMissedClass(_i7.MissedClass missedClass) =>
      caller.callServerEndpoint<_i7.MissedClass>(
        'missedClass',
        'updateMissedClass',
        {'missedClass': missedClass},
      );
}

/// {@category Endpoint}
class EndpointPupil extends _i1.EndpointRef {
  EndpointPupil(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'pupil';

  _i2.Stream<List<_i5.PupilData>> fetchPupilsAsStream() =>
      caller.callStreamingServerEndpoint<_i2.Stream<List<_i5.PupilData>>,
          List<_i5.PupilData>>(
        'pupil',
        'fetchPupilsAsStream',
        {},
        {},
      );

  _i2.Future<List<_i5.PupilData>> fetchPupils() =>
      caller.callServerEndpoint<List<_i5.PupilData>>(
        'pupil',
        'fetchPupils',
        {},
      );

  _i2.Future<List<_i5.PupilData>> fetchPupilsById(Set<int> internalIds) =>
      caller.callServerEndpoint<List<_i5.PupilData>>(
        'pupil',
        'fetchPupilsById',
        {'internalIds': internalIds},
      );

  _i2.Future<_i5.PupilData> deleteAvatar(int internalId) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupil',
        'deleteAvatar',
        {'internalId': internalId},
      );

  _i2.Future<_i5.PupilData> deleteAvatarAuth(int internalId) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupil',
        'deleteAvatarAuth',
        {'internalId': internalId},
      );

  _i2.Future<_i5.PupilData> resetPublicMediaAuth(int internalId) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupil',
        'resetPublicMediaAuth',
        {'internalId': internalId},
      );

  _i2.Future<_i5.PupilData> deleteSupportLevelHistoryItem(
    int internalId,
    int supportLevelId,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupil',
        'deleteSupportLevelHistoryItem',
        {
          'internalId': internalId,
          'supportLevelId': supportLevelId,
        },
      );
}

/// {@category Endpoint}
class EndpointPupilUpdate extends _i1.EndpointRef {
  EndpointPupilUpdate(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'pupilUpdate';

  _i2.Future<_i5.PupilData> updatePupil(_i5.PupilData pupil) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupilUpdate',
        'updatePupil',
        {'pupil': pupil},
      );

  _i2.Future<_i5.PupilData> updateCommunicationSkills({
    required int pupilId,
    required _i13.CommunicationSkills? communicationSkills,
  }) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupilUpdate',
        'updateCommunicationSkills',
        {
          'pupilId': pupilId,
          'communicationSkills': communicationSkills,
        },
      );

  _i2.Future<_i5.PupilData> updateTutorInfo(
    int pupilId,
    _i14.TutorInfo tutorInfo,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupilUpdate',
        'updateTutorInfo',
        {
          'pupilId': pupilId,
          'tutorInfo': tutorInfo,
        },
      );

  _i2.Future<List<_i5.PupilData>> updateSiblingsTutorInfo(
          _i15.SiblingsTutorInfo siblingsTutorInfo) =>
      caller.callServerEndpoint<List<_i5.PupilData>>(
        'pupilUpdate',
        'updateSiblingsTutorInfo',
        {'siblingsTutorInfo': siblingsTutorInfo},
      );

  _i2.Future<_i5.PupilData> updatePupilAvatar(
    int pupilId,
    String filePath,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupilUpdate',
        'updatePupilAvatar',
        {
          'pupilId': pupilId,
          'filePath': filePath,
        },
      );

  _i2.Future<_i5.PupilData> updateStringProperty(
    int pupilId,
    String property,
    String? value,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupilUpdate',
        'updateStringProperty',
        {
          'pupilId': pupilId,
          'property': property,
          'value': value,
        },
      );

  _i2.Future<_i5.PupilData> updateCredit(
    int pupilId,
    int value,
    String? description,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupilUpdate',
        'updateCredit',
        {
          'pupilId': pupilId,
          'value': value,
          'description': description,
        },
      );

  _i2.Future<_i5.PupilData> updatePupilAvatarAuth(
    int pupilId,
    _i11.ByteData avatarAuthBytes,
    String path,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupilUpdate',
        'updatePupilAvatarAuth',
        {
          'pupilId': pupilId,
          'avatarAuthBytes': avatarAuthBytes,
          'path': path,
        },
      );

  _i2.Future<_i5.PupilData> updatePupilWithPublicMediaAuth(
    int pupilId,
    _i11.ByteData publicMediaAuthFBytes,
    String path,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupilUpdate',
        'updatePupilWithPublicMediaAuth',
        {
          'pupilId': pupilId,
          'publicMediaAuthFBytes': publicMediaAuthFBytes,
          'path': path,
        },
      );

  _i2.Future<_i5.PupilData> updateSupportLevel(
          _i16.SupportLevel supportLevel) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupilUpdate',
        'updateSupportLevel',
        {'supportLevel': supportLevel},
      );
}

/// {@category Endpoint}
class EndpointSchooldayAdmin extends _i1.EndpointRef {
  EndpointSchooldayAdmin(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'schooldayAdmin';

  _i2.Future<_i17.SchoolSemester> createSchoolSemester(
    DateTime startDate,
    DateTime endDate,
    bool isFirst,
    DateTime classConferenceDate,
    DateTime supportConferenceDate,
    DateTime reportSignedDate,
  ) =>
      caller.callServerEndpoint<_i17.SchoolSemester>(
        'schooldayAdmin',
        'createSchoolSemester',
        {
          'startDate': startDate,
          'endDate': endDate,
          'isFirst': isFirst,
          'classConferenceDate': classConferenceDate,
          'supportConferenceDate': supportConferenceDate,
          'reportSignedDate': reportSignedDate,
        },
      );

  _i2.Future<List<_i17.SchoolSemester>> getAllSchoolSemesters() =>
      caller.callServerEndpoint<List<_i17.SchoolSemester>>(
        'schooldayAdmin',
        'getAllSchoolSemesters',
        {},
      );

  _i2.Future<_i17.SchoolSemester?> getCurrentSchoolSemester() =>
      caller.callServerEndpoint<_i17.SchoolSemester?>(
        'schooldayAdmin',
        'getCurrentSchoolSemester',
        {},
      );

  _i2.Future<bool> updateSchoolSemester(_i17.SchoolSemester schoolSemester) =>
      caller.callServerEndpoint<bool>(
        'schooldayAdmin',
        'updateSchoolSemester',
        {'schoolSemester': schoolSemester},
      );

  _i2.Future<bool> deleteSchoolSemester(_i17.SchoolSemester semester) =>
      caller.callServerEndpoint<bool>(
        'schooldayAdmin',
        'deleteSchoolSemester',
        {'semester': semester},
      );

  _i2.Future<_i18.Schoolday?> createSchoolday(DateTime date) =>
      caller.callServerEndpoint<_i18.Schoolday?>(
        'schooldayAdmin',
        'createSchoolday',
        {'date': date},
      );

  _i2.Future<List<_i18.Schoolday>> createSchooldays(List<DateTime> dates) =>
      caller.callServerEndpoint<List<_i18.Schoolday>>(
        'schooldayAdmin',
        'createSchooldays',
        {'dates': dates},
      );

  _i2.Future<bool> deleteSchoolday(DateTime date) =>
      caller.callServerEndpoint<bool>(
        'schooldayAdmin',
        'deleteSchoolday',
        {'date': date},
      );

  _i2.Future<bool> updateSchoolday(_i18.Schoolday schoolday) =>
      caller.callServerEndpoint<bool>(
        'schooldayAdmin',
        'updateSchoolday',
        {'schoolday': schoolday},
      );
}

/// {@category Endpoint}
class EndpointSchoolday extends _i1.EndpointRef {
  EndpointSchoolday(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'schoolday';

  _i2.Future<List<_i17.SchoolSemester>> getSchoolSemesters() =>
      caller.callServerEndpoint<List<_i17.SchoolSemester>>(
        'schoolday',
        'getSchoolSemesters',
        {},
      );

  _i2.Future<List<_i18.Schoolday>> getSchooldays() =>
      caller.callServerEndpoint<List<_i18.Schoolday>>(
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

  _i2.Future<List<_i19.SchooldayEvent>> fetchSchooldayEvents() =>
      caller.callServerEndpoint<List<_i19.SchooldayEvent>>(
        'schooldayEvent',
        'fetchSchooldayEvents',
        {},
      );

  _i2.Future<_i19.SchooldayEvent> createSchooldayEvent({
    required int pupilId,
    required int schooldayId,
    required _i20.SchooldayEventType type,
    required String reason,
    required String createdBy,
  }) =>
      caller.callServerEndpoint<_i19.SchooldayEvent>(
        'schooldayEvent',
        'createSchooldayEvent',
        {
          'pupilId': pupilId,
          'schooldayId': schooldayId,
          'type': type,
          'reason': reason,
          'createdBy': createdBy,
        },
      );

  _i2.Future<_i19.SchooldayEvent> updateSchooldayEvent(
    _i19.SchooldayEvent schooldayEvent,
    bool changedProcessedToFalse,
  ) =>
      caller.callServerEndpoint<_i19.SchooldayEvent>(
        'schooldayEvent',
        'updateSchooldayEvent',
        {
          'schooldayEvent': schooldayEvent,
          'changedProcessedToFalse': changedProcessedToFalse,
        },
      );

  _i2.Future<bool> deleteSchooldayEvent(int schooldayEventId) =>
      caller.callServerEndpoint<bool>(
        'schooldayEvent',
        'deleteSchooldayEvent',
        {'schooldayEventId': schooldayEventId},
      );

  _i2.Future<_i19.SchooldayEvent> updateSchooldayEventFile(
    int schooldayEventId,
    String filePath,
    String createdBy,
    bool isprocessed,
  ) =>
      caller.callServerEndpoint<_i19.SchooldayEvent>(
        'schooldayEvent',
        'updateSchooldayEventFile',
        {
          'schooldayEventId': schooldayEventId,
          'filePath': filePath,
          'createdBy': createdBy,
          'isprocessed': isprocessed,
        },
      );

  _i2.Future<_i19.SchooldayEvent> deleteSchooldayEventFile(
    int schooldayEventId,
    bool isProcessed,
  ) =>
      caller.callServerEndpoint<_i19.SchooldayEvent>(
        'schooldayEvent',
        'deleteSchooldayEventFile',
        {
          'schooldayEventId': schooldayEventId,
          'isProcessed': isProcessed,
        },
      );
}

/// {@category Endpoint}
class EndpointSupportCategory extends _i1.EndpointRef {
  EndpointSupportCategory(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'supportCategory';

  _i2.Future<List<_i21.SupportCategory>> getSupportCategories() =>
      caller.callServerEndpoint<List<_i21.SupportCategory>>(
        'supportCategory',
        'getSupportCategories',
        {},
      );

  _i2.Future<List<_i21.SupportCategory>> importSupportCategoriesFromJsonFile(
          String jsonFilePath) =>
      caller.callServerEndpoint<List<_i21.SupportCategory>>(
        'supportCategory',
        'importSupportCategoriesFromJsonFile',
        {'jsonFilePath': jsonFilePath},
      );

  _i2.Future<bool> createSupportCategory(_i21.SupportCategory category) =>
      caller.callServerEndpoint<bool>(
        'supportCategory',
        'createSupportCategory',
        {'category': category},
      );

  _i2.Future<bool> updateSupportCategory(_i21.SupportCategory category) =>
      caller.callServerEndpoint<bool>(
        'supportCategory',
        'updateSupportCategory',
        {'category': category},
      );

  _i2.Future<bool> deleteSupportCategory(_i21.SupportCategory category) =>
      caller.callServerEndpoint<bool>(
        'supportCategory',
        'deleteSupportCategory',
        {'category': category},
      );
}

/// {@category Endpoint}
class EndpointUser extends _i1.EndpointRef {
  EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  _i2.Future<_i3.User?> getCurrentUser() =>
      caller.callServerEndpoint<_i3.User?>(
        'user',
        'getCurrentUser',
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

class Modules {
  Modules(Client client) {
    auth = _i9.Caller(client);
  }

  late final _i9.Caller auth;
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
          _i22.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    admin = EndpointAdmin(this);
    attendance = EndpointAttendance(this);
    auth = EndpointAuth(this);
    competence = EndpointCompetence(this);
    files = EndpointFiles(this);
    missedClass = EndpointMissedClass(this);
    pupil = EndpointPupil(this);
    pupilUpdate = EndpointPupilUpdate(this);
    schooldayAdmin = EndpointSchooldayAdmin(this);
    schoolday = EndpointSchoolday(this);
    schooldayEvent = EndpointSchooldayEvent(this);
    supportCategory = EndpointSupportCategory(this);
    user = EndpointUser(this);
    modules = Modules(this);
  }

  late final EndpointAdmin admin;

  late final EndpointAttendance attendance;

  late final EndpointAuth auth;

  late final EndpointCompetence competence;

  late final EndpointFiles files;

  late final EndpointMissedClass missedClass;

  late final EndpointPupil pupil;

  late final EndpointPupilUpdate pupilUpdate;

  late final EndpointSchooldayAdmin schooldayAdmin;

  late final EndpointSchoolday schoolday;

  late final EndpointSchooldayEvent schooldayEvent;

  late final EndpointSupportCategory supportCategory;

  late final EndpointUser user;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'admin': admin,
        'attendance': attendance,
        'auth': auth,
        'competence': competence,
        'files': files,
        'missedClass': missedClass,
        'pupil': pupil,
        'pupilUpdate': pupilUpdate,
        'schooldayAdmin': schooldayAdmin,
        'schoolday': schoolday,
        'schooldayEvent': schooldayEvent,
        'supportCategory': supportCategory,
        'user': user,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}

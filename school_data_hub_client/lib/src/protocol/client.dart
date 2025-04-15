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
import 'package:school_data_hub_client/src/protocol/user/device_info.dart'
    as _i7;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i8;
import 'package:school_data_hub_client/src/protocol/learning/competence.dart'
    as _i9;
import 'dart:typed_data' as _i10;
import 'package:school_data_hub_client/src/protocol/schoolday/missed_class.dart'
    as _i11;
import 'package:school_data_hub_client/src/protocol/pupil_data/dto/siblings_tutor_info_dto.dart'
    as _i12;
import 'package:school_data_hub_client/src/protocol/learning_support/support_level.dart'
    as _i13;
import 'package:school_data_hub_client/src/protocol/schoolday/school_semester.dart'
    as _i14;
import 'package:school_data_hub_client/src/protocol/schoolday/schoolday.dart'
    as _i15;
import 'package:school_data_hub_client/src/protocol/learning_support/support_category.dart'
    as _i16;
import 'protocol.dart' as _i17;

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
class EndpointAuth extends _i1.EndpointRef {
  EndpointAuth(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  _i2.Future<
      ({
        _i7.DeviceInfo? deviceInfo,
        _i8.AuthenticationResponse response
      })> login(
    String email,
    String password,
    _i7.DeviceInfo deviceInfo,
  ) =>
      caller.callServerEndpoint<
          ({_i7.DeviceInfo? deviceInfo, _i8.AuthenticationResponse response})>(
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

  _i2.Future<List<_i9.Competence>> importCompetencesFromJsonFile(
          _i6.File jsonFile) =>
      caller.callServerEndpoint<List<_i9.Competence>>(
        'competence',
        'importCompetencesFromJsonFile',
        {'jsonFile': jsonFile},
      );

  _i2.Future<_i9.Competence> postCompetence({
    int? parentCompetence,
    required String name,
    required List<String> level,
    required List<String> indicators,
  }) =>
      caller.callServerEndpoint<_i9.Competence>(
        'competence',
        'postCompetence',
        {
          'parentCompetence': parentCompetence,
          'name': name,
          'level': level,
          'indicators': indicators,
        },
      );

  _i2.Future<List<_i9.Competence>> getAllCompetences() =>
      caller.callServerEndpoint<List<_i9.Competence>>(
        'competence',
        'getAllCompetences',
        {},
      );

  _i2.Future<_i9.Competence> updateCompetence(_i9.Competence competence) =>
      caller.callServerEndpoint<_i9.Competence>(
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
class EndpointExample extends _i1.EndpointRef {
  EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
      );
}

/// {@category Endpoint}
class EndpointFiles extends _i1.EndpointRef {
  EndpointFiles(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'files';

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

  _i2.Future<_i10.ByteData?> getImage(String documentId) =>
      caller.callServerEndpoint<_i10.ByteData?>(
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

  _i2.Future<bool> createMissedClass(_i11.MissedClass missedClass) =>
      caller.callServerEndpoint<bool>(
        'missedClass',
        'createMissedClass',
        {'missedClass': missedClass},
      );

  _i2.Future<List<_i11.MissedClass>> getAllMissedClasses() =>
      caller.callServerEndpoint<List<_i11.MissedClass>>(
        'missedClass',
        'getAllMissedClasses',
        {},
      );

  _i2.Future<_i11.MissedClass?> getMissedClassesOnDate(
          DateTime schooldayDate) =>
      caller.callServerEndpoint<_i11.MissedClass?>(
        'missedClass',
        'getMissedClassesOnDate',
        {'schooldayDate': schooldayDate},
      );

  _i2.Future<bool> updateMissedClass(_i11.MissedClass missedClass) =>
      caller.callServerEndpoint<bool>(
        'missedClass',
        'updateMissedClass',
        {'missedClass': missedClass},
      );

  _i2.Future<bool> deleteMissedClass(_i11.MissedClass missedClass) =>
      caller.callServerEndpoint<bool>(
        'missedClass',
        'deleteMissedClass',
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

  _i2.Future<bool> createPupil(_i5.PupilData pupil) =>
      caller.callServerEndpoint<bool>(
        'pupil',
        'createPupil',
        {'pupil': pupil},
      );

  _i2.Future<List<_i5.PupilData>> updateSiblingsTutorInfo(
          _i12.SiblingsTutorInfo siblingsTutorInfo) =>
      caller.callServerEndpoint<List<_i5.PupilData>>(
        'pupil',
        'updateSiblingsTutorInfo',
        {'siblingsTutorInfo': siblingsTutorInfo},
      );

  _i2.Future<_i5.PupilData> updatePupilProperty(
    int internalId,
    String property,
    dynamic value,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupil',
        'updatePupilProperty',
        {
          'internalId': internalId,
          'property': property,
          'value': value,
        },
      );

  _i2.Future<_i5.PupilData> updatePupilAvatar(
    int internalId,
    _i10.ByteData avatarByteData,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupil',
        'updatePupilAvatar',
        {
          'internalId': internalId,
          'avatarByteData': avatarByteData,
        },
      );

  _i2.Future<_i5.PupilData> updatePupilAvatarAuth(
    int internalId,
    _i10.ByteData avatarAuthBytes,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupil',
        'updatePupilAvatarAuth',
        {
          'internalId': internalId,
          'avatarAuthBytes': avatarAuthBytes,
        },
      );

  _i2.Future<_i5.PupilData> updatePupilWithPublicMediaAuth(
    int internalId,
    _i10.ByteData publicMediaAuthFBytes,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupil',
        'updatePupilWithPublicMediaAuth',
        {
          'internalId': internalId,
          'publicMediaAuthFBytes': publicMediaAuthFBytes,
        },
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

  _i2.Future<_i5.PupilData> updateSupportLevel(
          _i13.SupportLevel supportLevel) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupil',
        'updateSupportLevel',
        {'supportLevel': supportLevel},
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
class EndpointSchooldayAdmin extends _i1.EndpointRef {
  EndpointSchooldayAdmin(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'schooldayAdmin';

  _i2.Future<_i14.SchoolSemester> createSchoolSemester(
    DateTime startDate,
    DateTime endDate,
    bool isFirst,
    DateTime classConferenceDate,
    DateTime supportConferenceDate,
    DateTime reportSignedDate,
  ) =>
      caller.callServerEndpoint<_i14.SchoolSemester>(
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

  _i2.Future<List<_i14.SchoolSemester>> getAllSchoolSemesters() =>
      caller.callServerEndpoint<List<_i14.SchoolSemester>>(
        'schooldayAdmin',
        'getAllSchoolSemesters',
        {},
      );

  _i2.Future<_i14.SchoolSemester?> getCurrentSchoolSemester() =>
      caller.callServerEndpoint<_i14.SchoolSemester?>(
        'schooldayAdmin',
        'getCurrentSchoolSemester',
        {},
      );

  _i2.Future<bool> updateSchoolSemester(_i14.SchoolSemester schoolSemester) =>
      caller.callServerEndpoint<bool>(
        'schooldayAdmin',
        'updateSchoolSemester',
        {'schoolSemester': schoolSemester},
      );

  _i2.Future<bool> deleteSchoolSemester(_i14.SchoolSemester semester) =>
      caller.callServerEndpoint<bool>(
        'schooldayAdmin',
        'deleteSchoolSemester',
        {'semester': semester},
      );

  _i2.Future<_i15.Schoolday?> createSchoolday(DateTime date) =>
      caller.callServerEndpoint<_i15.Schoolday?>(
        'schooldayAdmin',
        'createSchoolday',
        {'date': date},
      );

  _i2.Future<List<_i15.Schoolday>> createSchooldays(List<DateTime> dates) =>
      caller.callServerEndpoint<List<_i15.Schoolday>>(
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

  _i2.Future<bool> updateSchoolday(_i15.Schoolday schoolday) =>
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

  _i2.Future<List<_i14.SchoolSemester>> getSchoolSemesters() =>
      caller.callServerEndpoint<List<_i14.SchoolSemester>>(
        'schoolday',
        'getSchoolSemesters',
        {},
      );

  _i2.Future<List<_i15.Schoolday>> getSchooldays() =>
      caller.callServerEndpoint<List<_i15.Schoolday>>(
        'schoolday',
        'getSchooldays',
        {},
      );
}

/// {@category Endpoint}
class EndpointSupportCategory extends _i1.EndpointRef {
  EndpointSupportCategory(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'supportCategory';

  _i2.Future<List<_i16.SupportCategory>> getSupportCategories() =>
      caller.callServerEndpoint<List<_i16.SupportCategory>>(
        'supportCategory',
        'getSupportCategories',
        {},
      );

  _i2.Future<List<_i16.SupportCategory>> importSupportCategoriesFromJsonFile(
          String jsonFilePath) =>
      caller.callServerEndpoint<List<_i16.SupportCategory>>(
        'supportCategory',
        'importSupportCategoriesFromJsonFile',
        {'jsonFilePath': jsonFilePath},
      );

  _i2.Future<bool> createSupportCategory(_i16.SupportCategory category) =>
      caller.callServerEndpoint<bool>(
        'supportCategory',
        'createSupportCategory',
        {'category': category},
      );

  _i2.Future<bool> updateSupportCategory(_i16.SupportCategory category) =>
      caller.callServerEndpoint<bool>(
        'supportCategory',
        'updateSupportCategory',
        {'category': category},
      );

  _i2.Future<bool> deleteSupportCategory(_i16.SupportCategory category) =>
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
    auth = _i8.Caller(client);
  }

  late final _i8.Caller auth;
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
          _i17.Protocol(),
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
    auth = EndpointAuth(this);
    competence = EndpointCompetence(this);
    example = EndpointExample(this);
    files = EndpointFiles(this);
    missedClass = EndpointMissedClass(this);
    pupil = EndpointPupil(this);
    schooldayAdmin = EndpointSchooldayAdmin(this);
    schoolday = EndpointSchoolday(this);
    supportCategory = EndpointSupportCategory(this);
    user = EndpointUser(this);
    modules = Modules(this);
  }

  late final EndpointAdmin admin;

  late final EndpointAuth auth;

  late final EndpointCompetence competence;

  late final EndpointExample example;

  late final EndpointFiles files;

  late final EndpointMissedClass missedClass;

  late final EndpointPupil pupil;

  late final EndpointSchooldayAdmin schooldayAdmin;

  late final EndpointSchoolday schoolday;

  late final EndpointSupportCategory supportCategory;

  late final EndpointUser user;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'admin': admin,
        'auth': auth,
        'competence': competence,
        'example': example,
        'files': files,
        'missedClass': missedClass,
        'pupil': pupil,
        'schooldayAdmin': schooldayAdmin,
        'schoolday': schoolday,
        'supportCategory': supportCategory,
        'user': user,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}

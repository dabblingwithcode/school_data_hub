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
import 'package:school_data_hub_client/src/protocol/schoolday/missed_class.dart'
    as _i5;
import 'package:school_data_hub_client/src/protocol/pupil_data/pupil_data.dart'
    as _i6;
import 'package:school_data_hub_client/src/protocol/pupil_data/dto/siblings_parent_info_dto.dart'
    as _i7;
import 'package:school_data_hub_client/src/protocol/schoolday/school_semester.dart'
    as _i8;
import 'package:school_data_hub_client/src/protocol/schoolday/schoolday.dart'
    as _i9;
import 'package:school_data_hub_client/src/protocol/user/device_info.dart'
    as _i10;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i11;
import 'protocol.dart' as _i12;

/// The endpoint for admin operations.
/// This endpoint requires the user to be logged in and have admin scope.
/// {@category Endpoint}
class EndpointAdmin extends _i1.EndpointRef {
  EndpointAdmin(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  _i2.Future<_i3.StaffUser> createUser({
    required String userName,
    required String fullName,
    required String email,
    required String password,
    required _i4.Role role,
    required int timeUnits,
    required List<String> scopeNames,
  }) =>
      caller.callServerEndpoint<_i3.StaffUser>(
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

  _i2.Future<List<_i3.StaffUser>> getAllUsers() =>
      caller.callServerEndpoint<List<_i3.StaffUser>>(
        'admin',
        'getAllUsers',
        {},
      );

  _i2.Future<_i3.StaffUser?> getUserById(int userId) =>
      caller.callServerEndpoint<_i3.StaffUser?>(
        'admin',
        'getUserById',
        {'userId': userId},
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
class EndpointMissedClass extends _i1.EndpointRef {
  EndpointMissedClass(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'missedClass';

  _i2.Future<bool> createMissedClass(_i5.MissedClass missedClass) =>
      caller.callServerEndpoint<bool>(
        'missedClass',
        'createMissedClass',
        {'missedClass': missedClass},
      );

  _i2.Future<List<_i5.MissedClass>> getAllMissedClasses() =>
      caller.callServerEndpoint<List<_i5.MissedClass>>(
        'missedClass',
        'getAllMissedClasses',
        {},
      );

  _i2.Future<_i5.MissedClass?> getMissedClassesOnDate(DateTime schooldayDate) =>
      caller.callServerEndpoint<_i5.MissedClass?>(
        'missedClass',
        'getMissedClassesOnDate',
        {'schooldayDate': schooldayDate},
      );

  _i2.Future<bool> updateMissedClass(_i5.MissedClass missedClass) =>
      caller.callServerEndpoint<bool>(
        'missedClass',
        'updateMissedClass',
        {'missedClass': missedClass},
      );

  _i2.Future<bool> deleteMissedClass(_i5.MissedClass missedClass) =>
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

  _i2.Stream<List<_i6.PupilData>> getPupils() =>
      caller.callStreamingServerEndpoint<_i2.Stream<List<_i6.PupilData>>,
          List<_i6.PupilData>>(
        'pupil',
        'getPupils',
        {},
        {},
      );

  _i2.Future<bool> createPupil(_i6.PupilData pupil) =>
      caller.callServerEndpoint<bool>(
        'pupil',
        'createPupil',
        {'pupil': pupil},
      );

  _i2.Future<void> updateParentInfo(_i7.SiblingsParentInfo parentInfo) =>
      caller.callServerEndpoint<void>(
        'pupil',
        'updateParentInfo',
        {'parentInfo': parentInfo},
      );
}

/// {@category Endpoint}
class EndpointSchooldayAdmin extends _i1.EndpointRef {
  EndpointSchooldayAdmin(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'schooldayAdmin';

  _i2.Future<_i8.SchoolSemester> createSchoolSemester(
    DateTime startDate,
    DateTime endDate,
    bool isFirst,
    DateTime classConferenceDate,
    DateTime supportConferenceDate,
    DateTime reportSignedDate,
  ) =>
      caller.callServerEndpoint<_i8.SchoolSemester>(
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

  _i2.Future<List<_i8.SchoolSemester>> getAllSchoolSemesters() =>
      caller.callServerEndpoint<List<_i8.SchoolSemester>>(
        'schooldayAdmin',
        'getAllSchoolSemesters',
        {},
      );

  _i2.Future<_i8.SchoolSemester?> getCurrentSchoolSemester() =>
      caller.callServerEndpoint<_i8.SchoolSemester?>(
        'schooldayAdmin',
        'getCurrentSchoolSemester',
        {},
      );

  _i2.Future<bool> updateSchoolSemester(_i8.SchoolSemester schoolSemester) =>
      caller.callServerEndpoint<bool>(
        'schooldayAdmin',
        'updateSchoolSemester',
        {'schoolSemester': schoolSemester},
      );

  _i2.Future<bool> deleteSchoolSemester(_i8.SchoolSemester semester) =>
      caller.callServerEndpoint<bool>(
        'schooldayAdmin',
        'deleteSchoolSemester',
        {'semester': semester},
      );

  _i2.Future<_i9.Schoolday?> createSchoolday(DateTime date) =>
      caller.callServerEndpoint<_i9.Schoolday?>(
        'schooldayAdmin',
        'createSchoolday',
        {'date': date},
      );

  _i2.Future<List<_i9.Schoolday>> createSchooldays(List<DateTime> dates) =>
      caller.callServerEndpoint<List<_i9.Schoolday>>(
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

  _i2.Future<bool> updateSchoolday(_i9.Schoolday schoolday) =>
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

  _i2.Future<List<_i8.SchoolSemester>> getSchoolSemesters() =>
      caller.callServerEndpoint<List<_i8.SchoolSemester>>(
        'schoolday',
        'getSchoolSemesters',
        {},
      );

  _i2.Future<List<_i9.Schoolday>> getSchooldays() =>
      caller.callServerEndpoint<List<_i9.Schoolday>>(
        'schoolday',
        'getSchooldays',
        {},
      );
}

/// {@category Endpoint}
class EndpointAuth extends _i1.EndpointRef {
  EndpointAuth(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  _i2.Future<
          ({_i10.DeviceInfo? deviceInfo, _i11.AuthenticationResponse response})>
      login(
    String email,
    String password,
    _i10.DeviceInfo deviceInfo,
  ) =>
          caller.callServerEndpoint<
              ({
                _i10.DeviceInfo? deviceInfo,
                _i11.AuthenticationResponse response
              })>(
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
class EndpointUser extends _i1.EndpointRef {
  EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

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
}

class Modules {
  Modules(Client client) {
    auth = _i11.Caller(client);
  }

  late final _i11.Caller auth;
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
          _i12.Protocol(),
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
    example = EndpointExample(this);
    missedClass = EndpointMissedClass(this);
    pupil = EndpointPupil(this);
    schooldayAdmin = EndpointSchooldayAdmin(this);
    schoolday = EndpointSchoolday(this);
    auth = EndpointAuth(this);
    user = EndpointUser(this);
    modules = Modules(this);
  }

  late final EndpointAdmin admin;

  late final EndpointExample example;

  late final EndpointMissedClass missedClass;

  late final EndpointPupil pupil;

  late final EndpointSchooldayAdmin schooldayAdmin;

  late final EndpointSchoolday schoolday;

  late final EndpointAuth auth;

  late final EndpointUser user;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'admin': admin,
        'example': example,
        'missedClass': missedClass,
        'pupil': pupil,
        'schooldayAdmin': schooldayAdmin,
        'schoolday': schoolday,
        'auth': auth,
        'user': user,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}

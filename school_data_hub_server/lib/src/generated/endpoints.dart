/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/admin_endpoint.dart' as _i2;
import '../endpoints/attendance_endpoint.dart' as _i3;
import '../endpoints/auth_endpoint.dart' as _i4;
import '../endpoints/competence_endpoint.dart' as _i5;
import '../endpoints/file_endpoints.dart' as _i6;
import '../endpoints/missed_class_endpoint.dart' as _i7;
import '../endpoints/pupil/pupil_endpoint.dart' as _i8;
import '../endpoints/pupil/pupil_update_endpoint.dart' as _i9;
import '../endpoints/school_list/school_list_endpoint.dart' as _i10;
import '../endpoints/schoolday_admin_endpoint.dart' as _i11;
import '../endpoints/schoolday_event/schoolday_event_endpoint.dart' as _i12;
import '../endpoints/support_category_endpoint.dart' as _i13;
import '../endpoints/user_endpoints.dart' as _i14;
import 'package:school_data_hub_server/src/generated/user/roles/roles.dart'
    as _i15;
import 'dart:io' as _i16;
import 'package:school_data_hub_server/src/generated/schoolday/missed_class/missed_class.dart'
    as _i17;
import 'package:school_data_hub_server/src/generated/user/device_info.dart'
    as _i18;
import 'package:school_data_hub_server/src/generated/protocol.dart' as _i19;
import 'package:school_data_hub_server/src/generated/learning/competence.dart'
    as _i20;
import 'package:school_data_hub_server/src/generated/pupil_data/pupil_data.dart'
    as _i21;
import 'package:school_data_hub_server/src/generated/pupil_data/pupil_objects/communication/communication_skills.dart'
    as _i22;
import 'package:school_data_hub_server/src/generated/pupil_data/pupil_objects/communication/tutor_info.dart'
    as _i23;
import 'package:school_data_hub_server/src/generated/pupil_data/dto/siblings_tutor_info_dto.dart'
    as _i24;
import 'package:school_data_hub_server/src/generated/learning_support/support_level.dart'
    as _i25;
import 'package:school_data_hub_server/src/generated/shared/member_operation.dart'
    as _i26;
import 'package:school_data_hub_server/src/generated/school_list/pupil_entry.dart'
    as _i27;
import 'package:school_data_hub_server/src/generated/schoolday/school_semester.dart'
    as _i28;
import 'package:school_data_hub_server/src/generated/schoolday/schoolday.dart'
    as _i29;
import 'package:school_data_hub_server/src/generated/schoolday/schoolday_event/schoolday_event_type.dart'
    as _i30;
import 'package:school_data_hub_server/src/generated/schoolday/schoolday_event/schoolday_event.dart'
    as _i31;
import 'package:school_data_hub_server/src/generated/learning_support/support_category.dart'
    as _i32;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i33;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'admin': _i2.AdminEndpoint()
        ..initialize(
          server,
          'admin',
          null,
        ),
      'attendance': _i3.AttendanceEndpoint()
        ..initialize(
          server,
          'attendance',
          null,
        ),
      'auth': _i4.AuthEndpoint()
        ..initialize(
          server,
          'auth',
          null,
        ),
      'competence': _i5.CompetenceEndpoint()
        ..initialize(
          server,
          'competence',
          null,
        ),
      'files': _i6.FilesEndpoint()
        ..initialize(
          server,
          'files',
          null,
        ),
      'missedClass': _i7.MissedClassEndpoint()
        ..initialize(
          server,
          'missedClass',
          null,
        ),
      'pupil': _i8.PupilEndpoint()
        ..initialize(
          server,
          'pupil',
          null,
        ),
      'pupilUpdate': _i9.PupilUpdateEndpoint()
        ..initialize(
          server,
          'pupilUpdate',
          null,
        ),
      'schoolList': _i10.SchoolListEndpoint()
        ..initialize(
          server,
          'schoolList',
          null,
        ),
      'schooldayAdmin': _i11.SchooldayAdminEndpoint()
        ..initialize(
          server,
          'schooldayAdmin',
          null,
        ),
      'schoolday': _i11.SchooldayEndpoint()
        ..initialize(
          server,
          'schoolday',
          null,
        ),
      'schooldayEvent': _i12.SchooldayEventEndpoint()
        ..initialize(
          server,
          'schooldayEvent',
          null,
        ),
      'supportCategory': _i13.SupportCategoryEndpoint()
        ..initialize(
          server,
          'supportCategory',
          null,
        ),
      'user': _i14.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
    };
    connectors['admin'] = _i1.EndpointConnector(
      name: 'admin',
      endpoint: endpoints['admin']!,
      methodConnectors: {
        'createUser': _i1.MethodConnector(
          name: 'createUser',
          params: {
            'userName': _i1.ParameterDescription(
              name: 'userName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'fullName': _i1.ParameterDescription(
              name: 'fullName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<_i15.Role>(),
              nullable: false,
            ),
            'timeUnits': _i1.ParameterDescription(
              name: 'timeUnits',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'scopeNames': _i1.ParameterDescription(
              name: 'scopeNames',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['admin'] as _i2.AdminEndpoint).createUser(
            session,
            userName: params['userName'],
            fullName: params['fullName'],
            email: params['email'],
            password: params['password'],
            role: params['role'],
            timeUnits: params['timeUnits'],
            scopeNames: params['scopeNames'],
          ),
        ),
        'deleteUser': _i1.MethodConnector(
          name: 'deleteUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['admin'] as _i2.AdminEndpoint).deleteUser(
            session,
            params['userId'],
          ),
        ),
        'promoteUserScope': _i1.MethodConnector(
          name: 'promoteUserScope',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'scopeName': _i1.ParameterDescription(
              name: 'scopeName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['admin'] as _i2.AdminEndpoint).promoteUserScope(
            session,
            params['userId'],
            params['scopeName'],
          ),
        ),
        'demoteUserScope': _i1.MethodConnector(
          name: 'demoteUserScope',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'scopeName': _i1.ParameterDescription(
              name: 'scopeName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['admin'] as _i2.AdminEndpoint).demoteUserScope(
            session,
            params['userId'],
            params['scopeName'],
          ),
        ),
        'getAllUsers': _i1.MethodConnector(
          name: 'getAllUsers',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['admin'] as _i2.AdminEndpoint).getAllUsers(session),
        ),
        'getUserById': _i1.MethodConnector(
          name: 'getUserById',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['admin'] as _i2.AdminEndpoint).getUserById(
            session,
            params['userId'],
          ),
        ),
        'updateBackendPupilDataState': _i1.MethodConnector(
          name: 'updateBackendPupilDataState',
          params: {
            'file': _i1.ParameterDescription(
              name: 'file',
              type: _i1.getType<_i16.File>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['admin'] as _i2.AdminEndpoint)
                  .updateBackendPupilDataState(
            session,
            params['file'],
          ),
        ),
      },
    );
    connectors['attendance'] = _i1.EndpointConnector(
      name: 'attendance',
      endpoint: endpoints['attendance']!,
      methodConnectors: {
        'fetchMissedClassesOnASchoolday': _i1.MethodConnector(
          name: 'fetchMissedClassesOnASchoolday',
          params: {
            'schoolday': _i1.ParameterDescription(
              name: 'schoolday',
              type: _i1.getType<DateTime>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['attendance'] as _i3.AttendanceEndpoint)
                  .fetchMissedClassesOnASchoolday(
            session,
            params['schoolday'],
          ),
        ),
        'fetchMissedClasses': _i1.MethodConnector(
          name: 'fetchMissedClasses',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['attendance'] as _i3.AttendanceEndpoint)
                  .fetchMissedClasses(session),
        ),
        'createMissedClass': _i1.MethodConnector(
          name: 'createMissedClass',
          params: {
            'missedClass': _i1.ParameterDescription(
              name: 'missedClass',
              type: _i1.getType<_i17.MissedClass>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['attendance'] as _i3.AttendanceEndpoint)
                  .createMissedClass(
            session,
            params['missedClass'],
          ),
        ),
        'deleteMissedClass': _i1.MethodConnector(
          name: 'deleteMissedClass',
          params: {
            'missedClass': _i1.ParameterDescription(
              name: 'missedClass',
              type: _i1.getType<_i17.MissedClass>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['attendance'] as _i3.AttendanceEndpoint)
                  .deleteMissedClass(
            session,
            params['missedClass'],
          ),
        ),
      },
    );
    connectors['auth'] = _i1.EndpointConnector(
      name: 'auth',
      endpoint: endpoints['auth']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'deviceInfo': _i1.ParameterDescription(
              name: 'deviceInfo',
              type: _i1.getType<_i18.DeviceInfo>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i4.AuthEndpoint)
                  .login(
                    session,
                    params['email'],
                    params['password'],
                    params['deviceInfo'],
                  )
                  .then((record) => _i19.mapRecordToJson(record)),
        ),
        'verifyPassword': _i1.MethodConnector(
          name: 'verifyPassword',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i4.AuthEndpoint).verifyPassword(
            session,
            params['userId'],
            params['password'],
          ),
        ),
        'logOut': _i1.MethodConnector(
          name: 'logOut',
          params: {
            'keyId': _i1.ParameterDescription(
              name: 'keyId',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i4.AuthEndpoint).logOut(
            session,
            params['keyId'],
          ),
        ),
      },
    );
    connectors['competence'] = _i1.EndpointConnector(
      name: 'competence',
      endpoint: endpoints['competence']!,
      methodConnectors: {
        'importCompetencesFromJsonFile': _i1.MethodConnector(
          name: 'importCompetencesFromJsonFile',
          params: {
            'jsonFile': _i1.ParameterDescription(
              name: 'jsonFile',
              type: _i1.getType<_i16.File>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['competence'] as _i5.CompetenceEndpoint)
                  .importCompetencesFromJsonFile(
            session,
            params['jsonFile'],
          ),
        ),
        'postCompetence': _i1.MethodConnector(
          name: 'postCompetence',
          params: {
            'parentCompetence': _i1.ParameterDescription(
              name: 'parentCompetence',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'level': _i1.ParameterDescription(
              name: 'level',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
            'indicators': _i1.ParameterDescription(
              name: 'indicators',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['competence'] as _i5.CompetenceEndpoint)
                  .postCompetence(
            session,
            parentCompetence: params['parentCompetence'],
            name: params['name'],
            level: params['level'],
            indicators: params['indicators'],
          ),
        ),
        'getAllCompetences': _i1.MethodConnector(
          name: 'getAllCompetences',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['competence'] as _i5.CompetenceEndpoint)
                  .getAllCompetences(session),
        ),
        'updateCompetence': _i1.MethodConnector(
          name: 'updateCompetence',
          params: {
            'competence': _i1.ParameterDescription(
              name: 'competence',
              type: _i1.getType<_i20.Competence>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['competence'] as _i5.CompetenceEndpoint)
                  .updateCompetence(
            session,
            params['competence'],
          ),
        ),
        'deleteCompetence': _i1.MethodConnector(
          name: 'deleteCompetence',
          params: {
            'publicId': _i1.ParameterDescription(
              name: 'publicId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['competence'] as _i5.CompetenceEndpoint)
                  .deleteCompetence(
            session,
            params['publicId'],
          ),
        ),
      },
    );
    connectors['files'] = _i1.EndpointConnector(
      name: 'files',
      endpoint: endpoints['files']!,
      methodConnectors: {
        'getUploadDescription': _i1.MethodConnector(
          name: 'getUploadDescription',
          params: {
            'storageId': _i1.ParameterDescription(
              name: 'storageId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['files'] as _i6.FilesEndpoint).getUploadDescription(
            session,
            params['storageId'],
            params['path'],
          ),
        ),
        'verifyUpload': _i1.MethodConnector(
          name: 'verifyUpload',
          params: {
            'storageId': _i1.ParameterDescription(
              name: 'storageId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['files'] as _i6.FilesEndpoint).verifyUpload(
            session,
            params['storageId'],
            params['path'],
          ),
        ),
        'getImage': _i1.MethodConnector(
          name: 'getImage',
          params: {
            'documentId': _i1.ParameterDescription(
              name: 'documentId',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['files'] as _i6.FilesEndpoint).getImage(
            session,
            params['documentId'],
          ),
        ),
      },
    );
    connectors['missedClass'] = _i1.EndpointConnector(
      name: 'missedClass',
      endpoint: endpoints['missedClass']!,
      methodConnectors: {
        'postMissedClass': _i1.MethodConnector(
          name: 'postMissedClass',
          params: {
            'missedClass': _i1.ParameterDescription(
              name: 'missedClass',
              type: _i1.getType<_i17.MissedClass>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['missedClass'] as _i7.MissedClassEndpoint)
                  .postMissedClass(
            session,
            params['missedClass'],
          ),
        ),
        'postMissedClasses': _i1.MethodConnector(
          name: 'postMissedClasses',
          params: {
            'missedClasses': _i1.ParameterDescription(
              name: 'missedClasses',
              type: _i1.getType<List<_i17.MissedClass>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['missedClass'] as _i7.MissedClassEndpoint)
                  .postMissedClasses(
            session,
            params['missedClasses'],
          ),
        ),
        'fetchAllMissedClasses': _i1.MethodConnector(
          name: 'fetchAllMissedClasses',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['missedClass'] as _i7.MissedClassEndpoint)
                  .fetchAllMissedClasses(session),
        ),
        'fetchMissedClassesOnASchoolday': _i1.MethodConnector(
          name: 'fetchMissedClassesOnASchoolday',
          params: {
            'schoolday': _i1.ParameterDescription(
              name: 'schoolday',
              type: _i1.getType<DateTime>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['missedClass'] as _i7.MissedClassEndpoint)
                  .fetchMissedClassesOnASchoolday(
            session,
            params['schoolday'],
          ),
        ),
        'deleteMissedClass': _i1.MethodConnector(
          name: 'deleteMissedClass',
          params: {
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'schooldayId': _i1.ParameterDescription(
              name: 'schooldayId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['missedClass'] as _i7.MissedClassEndpoint)
                  .deleteMissedClass(
            session,
            params['pupilId'],
            params['schooldayId'],
          ),
        ),
        'updateMissedClass': _i1.MethodConnector(
          name: 'updateMissedClass',
          params: {
            'missedClass': _i1.ParameterDescription(
              name: 'missedClass',
              type: _i1.getType<_i17.MissedClass>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['missedClass'] as _i7.MissedClassEndpoint)
                  .updateMissedClass(
            session,
            params['missedClass'],
          ),
        ),
        'streamMyModels': _i1.MethodStreamConnector(
          name: 'streamMyModels',
          params: {},
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
            Map<String, Stream> streamParams,
          ) =>
              (endpoints['missedClass'] as _i7.MissedClassEndpoint)
                  .streamMyModels(session),
        ),
      },
    );
    connectors['pupil'] = _i1.EndpointConnector(
      name: 'pupil',
      endpoint: endpoints['pupil']!,
      methodConnectors: {
        'fetchPupils': _i1.MethodConnector(
          name: 'fetchPupils',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupil'] as _i8.PupilEndpoint).fetchPupils(session),
        ),
        'fetchPupilsById': _i1.MethodConnector(
          name: 'fetchPupilsById',
          params: {
            'internalIds': _i1.ParameterDescription(
              name: 'internalIds',
              type: _i1.getType<Set<int>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupil'] as _i8.PupilEndpoint).fetchPupilsById(
            session,
            params['internalIds'],
          ),
        ),
        'deleteAvatar': _i1.MethodConnector(
          name: 'deleteAvatar',
          params: {
            'internalId': _i1.ParameterDescription(
              name: 'internalId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupil'] as _i8.PupilEndpoint).deleteAvatar(
            session,
            params['internalId'],
          ),
        ),
        'deleteAvatarAuth': _i1.MethodConnector(
          name: 'deleteAvatarAuth',
          params: {
            'internalId': _i1.ParameterDescription(
              name: 'internalId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupil'] as _i8.PupilEndpoint).deleteAvatarAuth(
            session,
            params['internalId'],
          ),
        ),
        'resetPublicMediaAuth': _i1.MethodConnector(
          name: 'resetPublicMediaAuth',
          params: {
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'createdBy': _i1.ParameterDescription(
              name: 'createdBy',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupil'] as _i8.PupilEndpoint).resetPublicMediaAuth(
            session,
            params['pupilId'],
            params['createdBy'],
          ),
        ),
        'deleteSupportLevelHistoryItem': _i1.MethodConnector(
          name: 'deleteSupportLevelHistoryItem',
          params: {
            'internalId': _i1.ParameterDescription(
              name: 'internalId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'supportLevelId': _i1.ParameterDescription(
              name: 'supportLevelId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupil'] as _i8.PupilEndpoint)
                  .deleteSupportLevelHistoryItem(
            session,
            params['internalId'],
            params['supportLevelId'],
          ),
        ),
        'fetchPupilsAsStream': _i1.MethodStreamConnector(
          name: 'fetchPupilsAsStream',
          params: {},
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
            Map<String, Stream> streamParams,
          ) =>
              (endpoints['pupil'] as _i8.PupilEndpoint)
                  .fetchPupilsAsStream(session),
        ),
      },
    );
    connectors['pupilUpdate'] = _i1.EndpointConnector(
      name: 'pupilUpdate',
      endpoint: endpoints['pupilUpdate']!,
      methodConnectors: {
        'updatePupil': _i1.MethodConnector(
          name: 'updatePupil',
          params: {
            'pupil': _i1.ParameterDescription(
              name: 'pupil',
              type: _i1.getType<_i21.PupilData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i9.PupilUpdateEndpoint).updatePupil(
            session,
            params['pupil'],
          ),
        ),
        'updateCommunicationSkills': _i1.MethodConnector(
          name: 'updateCommunicationSkills',
          params: {
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'communicationSkills': _i1.ParameterDescription(
              name: 'communicationSkills',
              type: _i1.getType<_i22.CommunicationSkills?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i9.PupilUpdateEndpoint)
                  .updateCommunicationSkills(
            session,
            pupilId: params['pupilId'],
            communicationSkills: params['communicationSkills'],
          ),
        ),
        'updateTutorInfo': _i1.MethodConnector(
          name: 'updateTutorInfo',
          params: {
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'tutorInfo': _i1.ParameterDescription(
              name: 'tutorInfo',
              type: _i1.getType<_i23.TutorInfo>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i9.PupilUpdateEndpoint)
                  .updateTutorInfo(
            session,
            params['pupilId'],
            params['tutorInfo'],
          ),
        ),
        'updateSiblingsTutorInfo': _i1.MethodConnector(
          name: 'updateSiblingsTutorInfo',
          params: {
            'siblingsTutorInfo': _i1.ParameterDescription(
              name: 'siblingsTutorInfo',
              type: _i1.getType<_i24.SiblingsTutorInfo>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i9.PupilUpdateEndpoint)
                  .updateSiblingsTutorInfo(
            session,
            params['siblingsTutorInfo'],
          ),
        ),
        'updatePupilAvatar': _i1.MethodConnector(
          name: 'updatePupilAvatar',
          params: {
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'filePath': _i1.ParameterDescription(
              name: 'filePath',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'createdBy': _i1.ParameterDescription(
              name: 'createdBy',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i9.PupilUpdateEndpoint)
                  .updatePupilAvatar(
            session,
            params['pupilId'],
            params['filePath'],
            params['createdBy'],
          ),
        ),
        'updatePupilAvatarAuth': _i1.MethodConnector(
          name: 'updatePupilAvatarAuth',
          params: {
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'filePath': _i1.ParameterDescription(
              name: 'filePath',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'createdBy': _i1.ParameterDescription(
              name: 'createdBy',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i9.PupilUpdateEndpoint)
                  .updatePupilAvatarAuth(
            session,
            params['pupilId'],
            params['filePath'],
            params['createdBy'],
          ),
        ),
        'updateStringProperty': _i1.MethodConnector(
          name: 'updateStringProperty',
          params: {
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'property': _i1.ParameterDescription(
              name: 'property',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'value': _i1.ParameterDescription(
              name: 'value',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i9.PupilUpdateEndpoint)
                  .updateStringProperty(
            session,
            params['pupilId'],
            params['property'],
            params['value'],
          ),
        ),
        'updateCredit': _i1.MethodConnector(
          name: 'updateCredit',
          params: {
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'value': _i1.ParameterDescription(
              name: 'value',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'sender': _i1.ParameterDescription(
              name: 'sender',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i9.PupilUpdateEndpoint)
                  .updateCredit(
            session,
            params['pupilId'],
            params['value'],
            params['description'],
            params['sender'],
          ),
        ),
        'updatePupilPublicMediaAuth': _i1.MethodConnector(
          name: 'updatePupilPublicMediaAuth',
          params: {
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'filePath': _i1.ParameterDescription(
              name: 'filePath',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'createdBy': _i1.ParameterDescription(
              name: 'createdBy',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i9.PupilUpdateEndpoint)
                  .updatePupilPublicMediaAuth(
            session,
            params['pupilId'],
            params['filePath'],
            params['createdBy'],
          ),
        ),
        'updateSupportLevel': _i1.MethodConnector(
          name: 'updateSupportLevel',
          params: {
            'supportLevel': _i1.ParameterDescription(
              name: 'supportLevel',
              type: _i1.getType<_i25.SupportLevel>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i9.PupilUpdateEndpoint)
                  .updateSupportLevel(
            session,
            params['supportLevel'],
          ),
        ),
      },
    );
    connectors['schoolList'] = _i1.EndpointConnector(
      name: 'schoolList',
      endpoint: endpoints['schoolList']!,
      methodConnectors: {
        'fetchSchoolLists': _i1.MethodConnector(
          name: 'fetchSchoolLists',
          params: {
            'userName': _i1.ParameterDescription(
              name: 'userName',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schoolList'] as _i10.SchoolListEndpoint)
                  .fetchSchoolLists(
            session,
            params['userName'],
          ),
        ),
        'postSchoolList': _i1.MethodConnector(
          name: 'postSchoolList',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'pupilIds': _i1.ParameterDescription(
              name: 'pupilIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
            'public': _i1.ParameterDescription(
              name: 'public',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'createdBy': _i1.ParameterDescription(
              name: 'createdBy',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schoolList'] as _i10.SchoolListEndpoint)
                  .postSchoolList(
            session,
            params['name'],
            params['description'],
            params['pupilIds'],
            params['public'],
            params['createdBy'],
          ),
        ),
        'updateSchoolList': _i1.MethodConnector(
          name: 'updateSchoolList',
          params: {
            'listId': _i1.ParameterDescription(
              name: 'listId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'public': _i1.ParameterDescription(
              name: 'public',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'updateMembers': _i1.ParameterDescription(
              name: 'updateMembers',
              type: _i1.getType<
                  ({_i26.MemberOperation operation, List<int> pupilIds})?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schoolList'] as _i10.SchoolListEndpoint)
                  .updateSchoolList(
            session,
            params['listId'],
            params['name'],
            params['description'],
            params['public'],
            params['updateMembers'],
          ),
        ),
        'deleteSchoolList': _i1.MethodConnector(
          name: 'deleteSchoolList',
          params: {
            'listId': _i1.ParameterDescription(
              name: 'listId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schoolList'] as _i10.SchoolListEndpoint)
                  .deleteSchoolList(
            session,
            params['listId'],
          ),
        ),
        'updatePupilListEntry': _i1.MethodConnector(
          name: 'updatePupilListEntry',
          params: {
            'entry': _i1.ParameterDescription(
              name: 'entry',
              type: _i1.getType<_i27.PupilListEntry>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schoolList'] as _i10.SchoolListEndpoint)
                  .updatePupilListEntry(
            session,
            params['entry'],
          ),
        ),
      },
    );
    connectors['schooldayAdmin'] = _i1.EndpointConnector(
      name: 'schooldayAdmin',
      endpoint: endpoints['schooldayAdmin']!,
      methodConnectors: {
        'createSchoolSemester': _i1.MethodConnector(
          name: 'createSchoolSemester',
          params: {
            'startDate': _i1.ParameterDescription(
              name: 'startDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'isFirst': _i1.ParameterDescription(
              name: 'isFirst',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'classConferenceDate': _i1.ParameterDescription(
              name: 'classConferenceDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'supportConferenceDate': _i1.ParameterDescription(
              name: 'supportConferenceDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'reportSignedDate': _i1.ParameterDescription(
              name: 'reportSignedDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayAdmin'] as _i11.SchooldayAdminEndpoint)
                  .createSchoolSemester(
            session,
            params['startDate'],
            params['endDate'],
            params['isFirst'],
            params['classConferenceDate'],
            params['supportConferenceDate'],
            params['reportSignedDate'],
          ),
        ),
        'getAllSchoolSemesters': _i1.MethodConnector(
          name: 'getAllSchoolSemesters',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayAdmin'] as _i11.SchooldayAdminEndpoint)
                  .getAllSchoolSemesters(session),
        ),
        'getCurrentSchoolSemester': _i1.MethodConnector(
          name: 'getCurrentSchoolSemester',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayAdmin'] as _i11.SchooldayAdminEndpoint)
                  .getCurrentSchoolSemester(session),
        ),
        'updateSchoolSemester': _i1.MethodConnector(
          name: 'updateSchoolSemester',
          params: {
            'schoolSemester': _i1.ParameterDescription(
              name: 'schoolSemester',
              type: _i1.getType<_i28.SchoolSemester>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayAdmin'] as _i11.SchooldayAdminEndpoint)
                  .updateSchoolSemester(
            session,
            params['schoolSemester'],
          ),
        ),
        'deleteSchoolSemester': _i1.MethodConnector(
          name: 'deleteSchoolSemester',
          params: {
            'semester': _i1.ParameterDescription(
              name: 'semester',
              type: _i1.getType<_i28.SchoolSemester>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayAdmin'] as _i11.SchooldayAdminEndpoint)
                  .deleteSchoolSemester(
            session,
            params['semester'],
          ),
        ),
        'createSchoolday': _i1.MethodConnector(
          name: 'createSchoolday',
          params: {
            'date': _i1.ParameterDescription(
              name: 'date',
              type: _i1.getType<DateTime>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayAdmin'] as _i11.SchooldayAdminEndpoint)
                  .createSchoolday(
            session,
            params['date'],
          ),
        ),
        'createSchooldays': _i1.MethodConnector(
          name: 'createSchooldays',
          params: {
            'dates': _i1.ParameterDescription(
              name: 'dates',
              type: _i1.getType<List<DateTime>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayAdmin'] as _i11.SchooldayAdminEndpoint)
                  .createSchooldays(
            session,
            params['dates'],
          ),
        ),
        'deleteSchoolday': _i1.MethodConnector(
          name: 'deleteSchoolday',
          params: {
            'date': _i1.ParameterDescription(
              name: 'date',
              type: _i1.getType<DateTime>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayAdmin'] as _i11.SchooldayAdminEndpoint)
                  .deleteSchoolday(
            session,
            params['date'],
          ),
        ),
        'updateSchoolday': _i1.MethodConnector(
          name: 'updateSchoolday',
          params: {
            'schoolday': _i1.ParameterDescription(
              name: 'schoolday',
              type: _i1.getType<_i29.Schoolday>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayAdmin'] as _i11.SchooldayAdminEndpoint)
                  .updateSchoolday(
            session,
            params['schoolday'],
          ),
        ),
      },
    );
    connectors['schoolday'] = _i1.EndpointConnector(
      name: 'schoolday',
      endpoint: endpoints['schoolday']!,
      methodConnectors: {
        'getSchoolSemesters': _i1.MethodConnector(
          name: 'getSchoolSemesters',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schoolday'] as _i11.SchooldayEndpoint)
                  .getSchoolSemesters(session),
        ),
        'getSchooldays': _i1.MethodConnector(
          name: 'getSchooldays',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schoolday'] as _i11.SchooldayEndpoint)
                  .getSchooldays(session),
        ),
      },
    );
    connectors['schooldayEvent'] = _i1.EndpointConnector(
      name: 'schooldayEvent',
      endpoint: endpoints['schooldayEvent']!,
      methodConnectors: {
        'fetchSchooldayEvents': _i1.MethodConnector(
          name: 'fetchSchooldayEvents',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayEvent'] as _i12.SchooldayEventEndpoint)
                  .fetchSchooldayEvents(session),
        ),
        'createSchooldayEvent': _i1.MethodConnector(
          name: 'createSchooldayEvent',
          params: {
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'schooldayId': _i1.ParameterDescription(
              name: 'schooldayId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<_i30.SchooldayEventType>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'createdBy': _i1.ParameterDescription(
              name: 'createdBy',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayEvent'] as _i12.SchooldayEventEndpoint)
                  .createSchooldayEvent(
            session,
            pupilId: params['pupilId'],
            schooldayId: params['schooldayId'],
            type: params['type'],
            reason: params['reason'],
            createdBy: params['createdBy'],
          ),
        ),
        'updateSchooldayEvent': _i1.MethodConnector(
          name: 'updateSchooldayEvent',
          params: {
            'schooldayEvent': _i1.ParameterDescription(
              name: 'schooldayEvent',
              type: _i1.getType<_i31.SchooldayEvent>(),
              nullable: false,
            ),
            'changedProcessedToFalse': _i1.ParameterDescription(
              name: 'changedProcessedToFalse',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayEvent'] as _i12.SchooldayEventEndpoint)
                  .updateSchooldayEvent(
            session,
            params['schooldayEvent'],
            params['changedProcessedToFalse'],
          ),
        ),
        'deleteSchooldayEvent': _i1.MethodConnector(
          name: 'deleteSchooldayEvent',
          params: {
            'schooldayEventId': _i1.ParameterDescription(
              name: 'schooldayEventId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayEvent'] as _i12.SchooldayEventEndpoint)
                  .deleteSchooldayEvent(
            session,
            params['schooldayEventId'],
          ),
        ),
        'updateSchooldayEventFile': _i1.MethodConnector(
          name: 'updateSchooldayEventFile',
          params: {
            'schooldayEventId': _i1.ParameterDescription(
              name: 'schooldayEventId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'filePath': _i1.ParameterDescription(
              name: 'filePath',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'createdBy': _i1.ParameterDescription(
              name: 'createdBy',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'isprocessed': _i1.ParameterDescription(
              name: 'isprocessed',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayEvent'] as _i12.SchooldayEventEndpoint)
                  .updateSchooldayEventFile(
            session,
            params['schooldayEventId'],
            params['filePath'],
            params['createdBy'],
            params['isprocessed'],
          ),
        ),
        'deleteSchooldayEventFile': _i1.MethodConnector(
          name: 'deleteSchooldayEventFile',
          params: {
            'schooldayEventId': _i1.ParameterDescription(
              name: 'schooldayEventId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'isProcessed': _i1.ParameterDescription(
              name: 'isProcessed',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayEvent'] as _i12.SchooldayEventEndpoint)
                  .deleteSchooldayEventFile(
            session,
            params['schooldayEventId'],
            params['isProcessed'],
          ),
        ),
      },
    );
    connectors['supportCategory'] = _i1.EndpointConnector(
      name: 'supportCategory',
      endpoint: endpoints['supportCategory']!,
      methodConnectors: {
        'getSupportCategories': _i1.MethodConnector(
          name: 'getSupportCategories',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['supportCategory'] as _i13.SupportCategoryEndpoint)
                  .getSupportCategories(session),
        ),
        'importSupportCategoriesFromJsonFile': _i1.MethodConnector(
          name: 'importSupportCategoriesFromJsonFile',
          params: {
            'jsonFilePath': _i1.ParameterDescription(
              name: 'jsonFilePath',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['supportCategory'] as _i13.SupportCategoryEndpoint)
                  .importSupportCategoriesFromJsonFile(
            session,
            params['jsonFilePath'],
          ),
        ),
        'createSupportCategory': _i1.MethodConnector(
          name: 'createSupportCategory',
          params: {
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<_i32.SupportCategory>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['supportCategory'] as _i13.SupportCategoryEndpoint)
                  .createSupportCategory(
            session,
            params['category'],
          ),
        ),
        'updateSupportCategory': _i1.MethodConnector(
          name: 'updateSupportCategory',
          params: {
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<_i32.SupportCategory>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['supportCategory'] as _i13.SupportCategoryEndpoint)
                  .updateSupportCategory(
            session,
            params['category'],
          ),
        ),
        'deleteSupportCategory': _i1.MethodConnector(
          name: 'deleteSupportCategory',
          params: {
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<_i32.SupportCategory>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['supportCategory'] as _i13.SupportCategoryEndpoint)
                  .deleteSupportCategory(
            session,
            params['category'],
          ),
        ),
      },
    );
    connectors['user'] = _i1.EndpointConnector(
      name: 'user',
      endpoint: endpoints['user']!,
      methodConnectors: {
        'getCurrentUser': _i1.MethodConnector(
          name: 'getCurrentUser',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i14.UserEndpoint).getCurrentUser(session),
        ),
        'changePassword': _i1.MethodConnector(
          name: 'changePassword',
          params: {
            'oldPassword': _i1.ParameterDescription(
              name: 'oldPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i14.UserEndpoint).changePassword(
            session,
            params['oldPassword'],
            params['newPassword'],
          ),
        ),
        'increaseStaffCredit': _i1.MethodConnector(
          name: 'increaseStaffCredit',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i14.UserEndpoint)
                  .increaseStaffCredit(session),
        ),
      },
    );
    modules['serverpod_auth'] = _i33.Endpoints()..initializeEndpoints(server);
  }
}

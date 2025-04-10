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
import '../endpoints/auth_endpoint.dart' as _i3;
import '../endpoints/competence_endpoint.dart' as _i4;
import '../endpoints/example_endpoint.dart' as _i5;
import '../endpoints/missed_class_endpoint.dart' as _i6;
import '../endpoints/pupil_endpoint.dart' as _i7;
import '../endpoints/schoolday_endpoint.dart' as _i8;
import '../endpoints/support_category_endpoint.dart' as _i9;
import '../endpoints/user_endpoints.dart' as _i10;
import 'package:school_data_hub_server/src/generated/user/roles/roles.dart'
    as _i11;
import 'package:school_data_hub_server/src/generated/user/device_info.dart'
    as _i12;
import 'package:school_data_hub_server/src/generated/protocol.dart' as _i13;
import 'dart:io' as _i14;
import 'package:school_data_hub_server/src/generated/learning/competence.dart'
    as _i15;
import 'package:school_data_hub_server/src/generated/schoolday/missed_class.dart'
    as _i16;
import 'package:school_data_hub_server/src/generated/pupil_data/pupil_data.dart'
    as _i17;
import 'package:school_data_hub_server/src/generated/pupil_data/dto/siblings_parent_info_dto.dart'
    as _i18;
import 'package:school_data_hub_server/src/generated/schoolday/school_semester.dart'
    as _i19;
import 'package:school_data_hub_server/src/generated/schoolday/schoolday.dart'
    as _i20;
import 'package:school_data_hub_server/src/generated/learning_support/support_category.dart'
    as _i21;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i22;

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
      'auth': _i3.AuthEndpoint()
        ..initialize(
          server,
          'auth',
          null,
        ),
      'competence': _i4.CompetenceEndpoint()
        ..initialize(
          server,
          'competence',
          null,
        ),
      'example': _i5.ExampleEndpoint()
        ..initialize(
          server,
          'example',
          null,
        ),
      'missedClass': _i6.MissedClassEndpoint()
        ..initialize(
          server,
          'missedClass',
          null,
        ),
      'pupil': _i7.PupilEndpoint()
        ..initialize(
          server,
          'pupil',
          null,
        ),
      'schooldayAdmin': _i8.SchooldayAdminEndpoint()
        ..initialize(
          server,
          'schooldayAdmin',
          null,
        ),
      'schoolday': _i8.SchooldayEndpoint()
        ..initialize(
          server,
          'schoolday',
          null,
        ),
      'supportCategory': _i9.SupportCategoryEndpoint()
        ..initialize(
          server,
          'supportCategory',
          null,
        ),
      'user': _i10.UserEndpoint()
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
              type: _i1.getType<_i11.Role>(),
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
              type: _i1.getType<_i12.DeviceInfo>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i3.AuthEndpoint)
                  .login(
                    session,
                    params['email'],
                    params['password'],
                    params['deviceInfo'],
                  )
                  .then((record) => _i13.mapRecordToJson(record)),
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
              (endpoints['auth'] as _i3.AuthEndpoint).verifyPassword(
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
              (endpoints['auth'] as _i3.AuthEndpoint).logOut(
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
              type: _i1.getType<_i14.File>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['competence'] as _i4.CompetenceEndpoint)
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
              (endpoints['competence'] as _i4.CompetenceEndpoint)
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
              (endpoints['competence'] as _i4.CompetenceEndpoint)
                  .getAllCompetences(session),
        ),
        'updateCompetence': _i1.MethodConnector(
          name: 'updateCompetence',
          params: {
            'competence': _i1.ParameterDescription(
              name: 'competence',
              type: _i1.getType<_i15.Competence>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['competence'] as _i4.CompetenceEndpoint)
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
              (endpoints['competence'] as _i4.CompetenceEndpoint)
                  .deleteCompetence(
            session,
            params['publicId'],
          ),
        ),
      },
    );
    connectors['example'] = _i1.EndpointConnector(
      name: 'example',
      endpoint: endpoints['example']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['example'] as _i5.ExampleEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
    connectors['missedClass'] = _i1.EndpointConnector(
      name: 'missedClass',
      endpoint: endpoints['missedClass']!,
      methodConnectors: {
        'createMissedClass': _i1.MethodConnector(
          name: 'createMissedClass',
          params: {
            'missedClass': _i1.ParameterDescription(
              name: 'missedClass',
              type: _i1.getType<_i16.MissedClass>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['missedClass'] as _i6.MissedClassEndpoint)
                  .createMissedClass(
            session,
            params['missedClass'],
          ),
        ),
        'getAllMissedClasses': _i1.MethodConnector(
          name: 'getAllMissedClasses',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['missedClass'] as _i6.MissedClassEndpoint)
                  .getAllMissedClasses(session),
        ),
        'getMissedClassesOnDate': _i1.MethodConnector(
          name: 'getMissedClassesOnDate',
          params: {
            'schooldayDate': _i1.ParameterDescription(
              name: 'schooldayDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['missedClass'] as _i6.MissedClassEndpoint)
                  .getMissedClassesOnDate(
            session,
            params['schooldayDate'],
          ),
        ),
        'updateMissedClass': _i1.MethodConnector(
          name: 'updateMissedClass',
          params: {
            'missedClass': _i1.ParameterDescription(
              name: 'missedClass',
              type: _i1.getType<_i16.MissedClass>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['missedClass'] as _i6.MissedClassEndpoint)
                  .updateMissedClass(
            session,
            params['missedClass'],
          ),
        ),
        'deleteMissedClass': _i1.MethodConnector(
          name: 'deleteMissedClass',
          params: {
            'missedClass': _i1.ParameterDescription(
              name: 'missedClass',
              type: _i1.getType<_i16.MissedClass>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['missedClass'] as _i6.MissedClassEndpoint)
                  .deleteMissedClass(
            session,
            params['missedClass'],
          ),
        ),
      },
    );
    connectors['pupil'] = _i1.EndpointConnector(
      name: 'pupil',
      endpoint: endpoints['pupil']!,
      methodConnectors: {
        'createPupil': _i1.MethodConnector(
          name: 'createPupil',
          params: {
            'pupil': _i1.ParameterDescription(
              name: 'pupil',
              type: _i1.getType<_i17.PupilData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupil'] as _i7.PupilEndpoint).createPupil(
            session,
            params['pupil'],
          ),
        ),
        'updateParentInfo': _i1.MethodConnector(
          name: 'updateParentInfo',
          params: {
            'parentInfo': _i1.ParameterDescription(
              name: 'parentInfo',
              type: _i1.getType<_i18.SiblingsParentInfo>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupil'] as _i7.PupilEndpoint).updateParentInfo(
            session,
            params['parentInfo'],
          ),
        ),
        'refreshPupilDataState': _i1.MethodConnector(
          name: 'refreshPupilDataState',
          params: {
            'file': _i1.ParameterDescription(
              name: 'file',
              type: _i1.getType<_i14.File>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupil'] as _i7.PupilEndpoint).refreshPupilDataState(
            session,
            params['file'],
          ),
        ),
        'getPupils': _i1.MethodStreamConnector(
          name: 'getPupils',
          params: {},
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
            Map<String, Stream> streamParams,
          ) =>
              (endpoints['pupil'] as _i7.PupilEndpoint).getPupils(session),
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
              (endpoints['schooldayAdmin'] as _i8.SchooldayAdminEndpoint)
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
              (endpoints['schooldayAdmin'] as _i8.SchooldayAdminEndpoint)
                  .getAllSchoolSemesters(session),
        ),
        'getCurrentSchoolSemester': _i1.MethodConnector(
          name: 'getCurrentSchoolSemester',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayAdmin'] as _i8.SchooldayAdminEndpoint)
                  .getCurrentSchoolSemester(session),
        ),
        'updateSchoolSemester': _i1.MethodConnector(
          name: 'updateSchoolSemester',
          params: {
            'schoolSemester': _i1.ParameterDescription(
              name: 'schoolSemester',
              type: _i1.getType<_i19.SchoolSemester>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayAdmin'] as _i8.SchooldayAdminEndpoint)
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
              type: _i1.getType<_i19.SchoolSemester>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayAdmin'] as _i8.SchooldayAdminEndpoint)
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
              (endpoints['schooldayAdmin'] as _i8.SchooldayAdminEndpoint)
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
              (endpoints['schooldayAdmin'] as _i8.SchooldayAdminEndpoint)
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
              (endpoints['schooldayAdmin'] as _i8.SchooldayAdminEndpoint)
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
              type: _i1.getType<_i20.Schoolday>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayAdmin'] as _i8.SchooldayAdminEndpoint)
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
              (endpoints['schoolday'] as _i8.SchooldayEndpoint)
                  .getSchoolSemesters(session),
        ),
        'getSchooldays': _i1.MethodConnector(
          name: 'getSchooldays',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schoolday'] as _i8.SchooldayEndpoint)
                  .getSchooldays(session),
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
              (endpoints['supportCategory'] as _i9.SupportCategoryEndpoint)
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
              (endpoints['supportCategory'] as _i9.SupportCategoryEndpoint)
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
              type: _i1.getType<_i21.SupportCategory>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['supportCategory'] as _i9.SupportCategoryEndpoint)
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
              type: _i1.getType<_i21.SupportCategory>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['supportCategory'] as _i9.SupportCategoryEndpoint)
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
              type: _i1.getType<_i21.SupportCategory>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['supportCategory'] as _i9.SupportCategoryEndpoint)
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
              (endpoints['user'] as _i10.UserEndpoint).changePassword(
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
              (endpoints['user'] as _i10.UserEndpoint)
                  .increaseStaffCredit(session),
        ),
      },
    );
    modules['serverpod_auth'] = _i22.Endpoints()..initializeEndpoints(server);
  }
}

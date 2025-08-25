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
import '../_features/admin/endpoints/admin_endpoint.dart' as _i2;
import '../_features/admin/endpoints/dev_ops_endpoint.dart' as _i3;
import '../_features/attendance/endpoints/missed_schoolday_endpoint.dart'
    as _i4;
import '../_features/auth/endpoints/auth_endpoint.dart' as _i5;
import '../_features/authorizations/endpoints/authorization_endpoint.dart'
    as _i6;
import '../_features/authorizations/endpoints/pupil_authorization_endpoint.dart'
    as _i7;
import '../_features/books/endpoints/books/book_tags_endpoint.dart' as _i8;
import '../_features/books/endpoints/books/books_endpoint.dart' as _i9;
import '../_features/books/endpoints/library_books/library_book_locations_endpoint.dart'
    as _i10;
import '../_features/books/endpoints/library_books/library_books_endpoint.dart'
    as _i11;
import '../_features/books/endpoints/pupil_book_lending_endpoint.dart' as _i12;
import '../_features/learning/endpoints/competence_check_endpoint.dart' as _i13;
import '../_features/learning/endpoints/competence_endpoint.dart' as _i14;
import '../_features/learning_support/endpoints/learning_support_plan_endpoint.dart'
    as _i15;
import '../_features/learning_support/endpoints/support_category_endpoint.dart'
    as _i16;
import '../_features/matrix/matrix_endpoint.dart' as _i17;
import '../_features/pupil/endpooints/pupil_endpoint.dart' as _i18;
import '../_features/pupil/endpooints/pupil_identity_enpoint.dart' as _i19;
import '../_features/pupil/endpooints/pupil_update_endpoint.dart' as _i20;
import '../_features/school_lists/endpoints/school_list_endpoint.dart' as _i21;
import '../_features/schoolday/endpoints/schoolday_admin_endpoint.dart' as _i22;
import '../_features/schoolday_events/endpoints/schoolday_event_endpoint.dart'
    as _i23;
import '../_features/user/endpoints/user_endpoints.dart' as _i24;
import '../_features/workbooks/endpoints/pupil_workbooks_endpoint.dart' as _i25;
import '../_features/workbooks/endpoints/workbooks_endpoint.dart' as _i26;
import '../_shared/endpoints/file_endpoints.dart' as _i27;
import 'package:school_data_hub_server/src/generated/_features/user/models/roles.dart'
    as _i28;
import 'package:school_data_hub_server/src/generated/_features/attendance/models/missed_schoolday.dart'
    as _i29;
import 'package:school_data_hub_server/src/generated/_features/auth/models/device_info.dart'
    as _i30;
import 'package:school_data_hub_server/src/generated/protocol.dart' as _i31;
import 'package:school_data_hub_server/src/generated/_shared/models/member_operation.dart'
    as _i32;
import 'package:school_data_hub_server/src/generated/_features/authorizations/models/pupil_authorization.dart'
    as _i33;
import 'package:school_data_hub_server/src/generated/_features/books/models/book_tagging/book_tag.dart'
    as _i34;
import 'package:school_data_hub_server/src/generated/_features/books/models/book.dart'
    as _i35;
import 'package:school_data_hub_server/src/generated/_features/books/models/library_book_location.dart'
    as _i36;
import 'package:school_data_hub_server/src/generated/_features/books/models/library_book_query.dart'
    as _i37;
import 'package:school_data_hub_server/src/generated/_features/books/models/pupil_book_lending.dart'
    as _i38;
import 'dart:io' as _i39;
import 'package:school_data_hub_server/src/generated/_features/learning/models/competence.dart'
    as _i40;
import 'package:school_data_hub_server/src/generated/_features/learning_support/models/learning_support_plan.dart'
    as _i41;
import 'package:school_data_hub_server/src/generated/_features/learning_support/models/support_category.dart'
    as _i42;
import 'package:school_data_hub_server/src/generated/_features/matrix/compulsory_room.dart'
    as _i43;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_data/dto/pupil_document_type.dart'
    as _i44;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_identity/pupil_identity_dto.dart'
    as _i45;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_data/pupil_data.dart'
    as _i46;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_data/communication/communication_skills.dart'
    as _i47;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_data/communication/tutor_info.dart'
    as _i48;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_data/dto/siblings_tutor_info_dto.dart'
    as _i49;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_data/preschool/pre_school_medical_status.dart'
    as _i50;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_data/communication/public_media_auth.dart'
    as _i51;
import 'package:school_data_hub_server/src/generated/_features/learning_support/models/support_level.dart'
    as _i52;
import 'package:school_data_hub_server/src/generated/_features/school_lists/models/pupil_entry.dart'
    as _i53;
import 'package:school_data_hub_server/src/generated/_features/schoolday/models/school_semester.dart'
    as _i54;
import 'package:school_data_hub_server/src/generated/_features/schoolday/models/schoolday.dart'
    as _i55;
import 'package:school_data_hub_server/src/generated/_features/schoolday_events/models/schoolday_event_type.dart'
    as _i56;
import 'package:school_data_hub_server/src/generated/_features/schoolday_events/models/schoolday_event.dart'
    as _i57;
import 'package:school_data_hub_server/src/generated/_features/workbooks/models/pupil_workbook.dart'
    as _i58;
import 'package:school_data_hub_server/src/generated/_features/workbooks/models/workbook.dart'
    as _i59;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i60;

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
      'devOps': _i3.DevOpsEndpoint()
        ..initialize(
          server,
          'devOps',
          null,
        ),
      'missedSchoolday': _i4.MissedSchooldayEndpoint()
        ..initialize(
          server,
          'missedSchoolday',
          null,
        ),
      'auth': _i5.AuthEndpoint()
        ..initialize(
          server,
          'auth',
          null,
        ),
      'authorization': _i6.AuthorizationEndpoint()
        ..initialize(
          server,
          'authorization',
          null,
        ),
      'pupilAuthorization': _i7.PupilAuthorizationEndpoint()
        ..initialize(
          server,
          'pupilAuthorization',
          null,
        ),
      'bookTags': _i8.BookTagsEndpoint()
        ..initialize(
          server,
          'bookTags',
          null,
        ),
      'books': _i9.BooksEndpoint()
        ..initialize(
          server,
          'books',
          null,
        ),
      'libraryBookLocations': _i10.LibraryBookLocationsEndpoint()
        ..initialize(
          server,
          'libraryBookLocations',
          null,
        ),
      'libraryBooks': _i11.LibraryBooksEndpoint()
        ..initialize(
          server,
          'libraryBooks',
          null,
        ),
      'pupilBookLending': _i12.PupilBookLendingEndpoint()
        ..initialize(
          server,
          'pupilBookLending',
          null,
        ),
      'competenceCheck': _i13.CompetenceCheckEndpoint()
        ..initialize(
          server,
          'competenceCheck',
          null,
        ),
      'competence': _i14.CompetenceEndpoint()
        ..initialize(
          server,
          'competence',
          null,
        ),
      'learningSupportPlan': _i15.LearningSupportPlanEndpoint()
        ..initialize(
          server,
          'learningSupportPlan',
          null,
        ),
      'supportCategory': _i16.SupportCategoryEndpoint()
        ..initialize(
          server,
          'supportCategory',
          null,
        ),
      'matrix': _i17.MatrixEndpoint()
        ..initialize(
          server,
          'matrix',
          null,
        ),
      'pupil': _i18.PupilEndpoint()
        ..initialize(
          server,
          'pupil',
          null,
        ),
      'pupilIdentity': _i19.PupilIdentityEndpoint()
        ..initialize(
          server,
          'pupilIdentity',
          null,
        ),
      'pupilUpdate': _i20.PupilUpdateEndpoint()
        ..initialize(
          server,
          'pupilUpdate',
          null,
        ),
      'schoolList': _i21.SchoolListEndpoint()
        ..initialize(
          server,
          'schoolList',
          null,
        ),
      'schooldayAdmin': _i22.SchooldayAdminEndpoint()
        ..initialize(
          server,
          'schooldayAdmin',
          null,
        ),
      'schoolday': _i22.SchooldayEndpoint()
        ..initialize(
          server,
          'schoolday',
          null,
        ),
      'schooldayEvent': _i23.SchooldayEventEndpoint()
        ..initialize(
          server,
          'schooldayEvent',
          null,
        ),
      'user': _i24.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
      'pupilWorkbooks': _i25.PupilWorkbooksEndpoint()
        ..initialize(
          server,
          'pupilWorkbooks',
          null,
        ),
      'workbooks': _i26.WorkbooksEndpoint()
        ..initialize(
          server,
          'workbooks',
          null,
        ),
      'files': _i27.FilesEndpoint()
        ..initialize(
          server,
          'files',
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
              type: _i1.getType<_i28.Role>(),
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
            'filePath': _i1.ParameterDescription(
              name: 'filePath',
              type: _i1.getType<String>(),
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
            params['filePath'],
          ),
        ),
      },
    );
    connectors['devOps'] = _i1.EndpointConnector(
      name: 'devOps',
      endpoint: endpoints['devOps']!,
      methodConnectors: {
        'resetDatabaseAndCreateAdmin': _i1.MethodConnector(
          name: 'resetDatabaseAndCreateAdmin',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['devOps'] as _i3.DevOpsEndpoint)
                  .resetDatabaseAndCreateAdmin(session),
        )
      },
    );
    connectors['missedSchoolday'] = _i1.EndpointConnector(
      name: 'missedSchoolday',
      endpoint: endpoints['missedSchoolday']!,
      methodConnectors: {
        'postMissedSchoolday': _i1.MethodConnector(
          name: 'postMissedSchoolday',
          params: {
            'missedClass': _i1.ParameterDescription(
              name: 'missedClass',
              type: _i1.getType<_i29.MissedSchoolday>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['missedSchoolday'] as _i4.MissedSchooldayEndpoint)
                  .postMissedSchoolday(
            session,
            params['missedClass'],
          ),
        ),
        'postMissedSchooldays': _i1.MethodConnector(
          name: 'postMissedSchooldays',
          params: {
            'missedClasses': _i1.ParameterDescription(
              name: 'missedClasses',
              type: _i1.getType<List<_i29.MissedSchoolday>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['missedSchoolday'] as _i4.MissedSchooldayEndpoint)
                  .postMissedSchooldays(
            session,
            params['missedClasses'],
          ),
        ),
        'fetchAllMissedSchooldays': _i1.MethodConnector(
          name: 'fetchAllMissedSchooldays',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['missedSchoolday'] as _i4.MissedSchooldayEndpoint)
                  .fetchAllMissedSchooldays(session),
        ),
        'fetchMissedSchooldaysOnASchoolday': _i1.MethodConnector(
          name: 'fetchMissedSchooldaysOnASchoolday',
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
              (endpoints['missedSchoolday'] as _i4.MissedSchooldayEndpoint)
                  .fetchMissedSchooldaysOnASchoolday(
            session,
            params['schoolday'],
          ),
        ),
        'deleteMissedSchoolday': _i1.MethodConnector(
          name: 'deleteMissedSchoolday',
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
              (endpoints['missedSchoolday'] as _i4.MissedSchooldayEndpoint)
                  .deleteMissedSchoolday(
            session,
            params['pupilId'],
            params['schooldayId'],
          ),
        ),
        'updateMissedSchoolday': _i1.MethodConnector(
          name: 'updateMissedSchoolday',
          params: {
            'missedSchoolday': _i1.ParameterDescription(
              name: 'missedSchoolday',
              type: _i1.getType<_i29.MissedSchoolday>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['missedSchoolday'] as _i4.MissedSchooldayEndpoint)
                  .updateMissedSchoolday(
            session,
            params['missedSchoolday'],
          ),
        ),
        'streamMissedSchooldays': _i1.MethodStreamConnector(
          name: 'streamMissedSchooldays',
          params: {},
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
            Map<String, Stream> streamParams,
          ) =>
              (endpoints['missedSchoolday'] as _i4.MissedSchooldayEndpoint)
                  .streamMissedSchooldays(session),
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
              type: _i1.getType<_i30.DeviceInfo>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i5.AuthEndpoint)
                  .login(
                    session,
                    params['email'],
                    params['password'],
                    params['deviceInfo'],
                  )
                  .then((record) => _i31.mapRecordToJson(record)),
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
              (endpoints['auth'] as _i5.AuthEndpoint).logOut(
            session,
            params['keyId'],
          ),
        ),
      },
    );
    connectors['authorization'] = _i1.EndpointConnector(
      name: 'authorization',
      endpoint: endpoints['authorization']!,
      methodConnectors: {
        'fetchAuthorizations': _i1.MethodConnector(
          name: 'fetchAuthorizations',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['authorization'] as _i6.AuthorizationEndpoint)
                  .fetchAuthorizations(session),
        ),
        'fetchAuthorizationById': _i1.MethodConnector(
          name: 'fetchAuthorizationById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['authorization'] as _i6.AuthorizationEndpoint)
                  .fetchAuthorizationById(
            session,
            params['id'],
          ),
        ),
        'postAuthorizationWithPupils': _i1.MethodConnector(
          name: 'postAuthorizationWithPupils',
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
            'createdBy': _i1.ParameterDescription(
              name: 'createdBy',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'pupilIds': _i1.ParameterDescription(
              name: 'pupilIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['authorization'] as _i6.AuthorizationEndpoint)
                  .postAuthorizationWithPupils(
            session,
            params['name'],
            params['description'],
            params['createdBy'],
            params['pupilIds'],
          ),
        ),
        'updateAuthorization': _i1.MethodConnector(
          name: 'updateAuthorization',
          params: {
            'authId': _i1.ParameterDescription(
              name: 'authId',
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
            'updateMembers': _i1.ParameterDescription(
              name: 'updateMembers',
              type: _i1.getType<
                  ({_i32.MemberOperation operation, List<int> pupilIds})?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['authorization'] as _i6.AuthorizationEndpoint)
                  .updateAuthorization(
            session,
            params['authId'],
            params['name'],
            params['description'],
            params['updateMembers'],
          ),
        ),
        'deleteAuthorization': _i1.MethodConnector(
          name: 'deleteAuthorization',
          params: {
            'authId': _i1.ParameterDescription(
              name: 'authId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['authorization'] as _i6.AuthorizationEndpoint)
                  .deleteAuthorization(
            session,
            params['authId'],
          ),
        ),
      },
    );
    connectors['pupilAuthorization'] = _i1.EndpointConnector(
      name: 'pupilAuthorization',
      endpoint: endpoints['pupilAuthorization']!,
      methodConnectors: {
        'updatePupilAuthorization': _i1.MethodConnector(
          name: 'updatePupilAuthorization',
          params: {
            'authorization': _i1.ParameterDescription(
              name: 'authorization',
              type: _i1.getType<_i33.PupilAuthorization>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilAuthorization']
                      as _i7.PupilAuthorizationEndpoint)
                  .updatePupilAuthorization(
            session,
            params['authorization'],
          ),
        ),
        'addFileToPupilAuthorization': _i1.MethodConnector(
          name: 'addFileToPupilAuthorization',
          params: {
            'pupilAuthId': _i1.ParameterDescription(
              name: 'pupilAuthId',
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
              (endpoints['pupilAuthorization']
                      as _i7.PupilAuthorizationEndpoint)
                  .addFileToPupilAuthorization(
            session,
            params['pupilAuthId'],
            params['filePath'],
            params['createdBy'],
          ),
        ),
        'removeFileFromPupilAuthorization': _i1.MethodConnector(
          name: 'removeFileFromPupilAuthorization',
          params: {
            'pupilAuthId': _i1.ParameterDescription(
              name: 'pupilAuthId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilAuthorization']
                      as _i7.PupilAuthorizationEndpoint)
                  .removeFileFromPupilAuthorization(
            session,
            params['pupilAuthId'],
          ),
        ),
      },
    );
    connectors['bookTags'] = _i1.EndpointConnector(
      name: 'bookTags',
      endpoint: endpoints['bookTags']!,
      methodConnectors: {
        'postBookTag': _i1.MethodConnector(
          name: 'postBookTag',
          params: {
            'bookTag': _i1.ParameterDescription(
              name: 'bookTag',
              type: _i1.getType<_i34.BookTag>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['bookTags'] as _i8.BookTagsEndpoint).postBookTag(
            session,
            params['bookTag'],
          ),
        ),
        'fetchBookTags': _i1.MethodConnector(
          name: 'fetchBookTags',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['bookTags'] as _i8.BookTagsEndpoint)
                  .fetchBookTags(session),
        ),
        'updateBookTag': _i1.MethodConnector(
          name: 'updateBookTag',
          params: {
            'bookTag': _i1.ParameterDescription(
              name: 'bookTag',
              type: _i1.getType<_i34.BookTag>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['bookTags'] as _i8.BookTagsEndpoint).updateBookTag(
            session,
            params['bookTag'],
          ),
        ),
        'deleteBookTag': _i1.MethodConnector(
          name: 'deleteBookTag',
          params: {
            'bookTag': _i1.ParameterDescription(
              name: 'bookTag',
              type: _i1.getType<_i34.BookTag>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['bookTags'] as _i8.BookTagsEndpoint).deleteBookTag(
            session,
            params['bookTag'],
          ),
        ),
      },
    );
    connectors['books'] = _i1.EndpointConnector(
      name: 'books',
      endpoint: endpoints['books']!,
      methodConnectors: {
        'postBook': _i1.MethodConnector(
          name: 'postBook',
          params: {
            'book': _i1.ParameterDescription(
              name: 'book',
              type: _i1.getType<_i35.Book>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['books'] as _i9.BooksEndpoint).postBook(
            session,
            params['book'],
          ),
        ),
        'fetchBooks': _i1.MethodConnector(
          name: 'fetchBooks',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['books'] as _i9.BooksEndpoint).fetchBooks(session),
        ),
        'fetchBookByIsbn': _i1.MethodConnector(
          name: 'fetchBookByIsbn',
          params: {
            'isbn': _i1.ParameterDescription(
              name: 'isbn',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['books'] as _i9.BooksEndpoint).fetchBookByIsbn(
            session,
            params['isbn'],
          ),
        ),
        'updateBook': _i1.MethodConnector(
          name: 'updateBook',
          params: {
            'book': _i1.ParameterDescription(
              name: 'book',
              type: _i1.getType<_i35.Book>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['books'] as _i9.BooksEndpoint).updateBook(
            session,
            params['book'],
          ),
        ),
        'updateBookTags': _i1.MethodConnector(
          name: 'updateBookTags',
          params: {
            'book': _i1.ParameterDescription(
              name: 'book',
              type: _i1.getType<_i35.Book>(),
              nullable: false,
            ),
            'tags': _i1.ParameterDescription(
              name: 'tags',
              type: _i1.getType<List<_i34.BookTag>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['books'] as _i9.BooksEndpoint).updateBookTags(
            session,
            params['book'],
            params['tags'],
          ),
        ),
        'deleteBook': _i1.MethodConnector(
          name: 'deleteBook',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['books'] as _i9.BooksEndpoint).deleteBook(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['libraryBookLocations'] = _i1.EndpointConnector(
      name: 'libraryBookLocations',
      endpoint: endpoints['libraryBookLocations']!,
      methodConnectors: {
        'postLibraryBookLocation': _i1.MethodConnector(
          name: 'postLibraryBookLocation',
          params: {
            'libraryBookLocation': _i1.ParameterDescription(
              name: 'libraryBookLocation',
              type: _i1.getType<_i36.LibraryBookLocation>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['libraryBookLocations']
                      as _i10.LibraryBookLocationsEndpoint)
                  .postLibraryBookLocation(
            session,
            params['libraryBookLocation'],
          ),
        ),
        'fetchLibraryBookLocations': _i1.MethodConnector(
          name: 'fetchLibraryBookLocations',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['libraryBookLocations']
                      as _i10.LibraryBookLocationsEndpoint)
                  .fetchLibraryBookLocations(session),
        ),
        'updateLibraryBookLocation': _i1.MethodConnector(
          name: 'updateLibraryBookLocation',
          params: {
            'libraryBookLocation': _i1.ParameterDescription(
              name: 'libraryBookLocation',
              type: _i1.getType<_i36.LibraryBookLocation>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['libraryBookLocations']
                      as _i10.LibraryBookLocationsEndpoint)
                  .updateLibraryBookLocation(
            session,
            params['libraryBookLocation'],
          ),
        ),
        'deleteLibraryBookLocation': _i1.MethodConnector(
          name: 'deleteLibraryBookLocation',
          params: {
            'location': _i1.ParameterDescription(
              name: 'location',
              type: _i1.getType<_i36.LibraryBookLocation>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['libraryBookLocations']
                      as _i10.LibraryBookLocationsEndpoint)
                  .deleteLibraryBookLocation(
            session,
            params['location'],
          ),
        ),
      },
    );
    connectors['libraryBooks'] = _i1.EndpointConnector(
      name: 'libraryBooks',
      endpoint: endpoints['libraryBooks']!,
      methodConnectors: {
        'postLibraryBook': _i1.MethodConnector(
          name: 'postLibraryBook',
          params: {
            'isbn': _i1.ParameterDescription(
              name: 'isbn',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'libraryId': _i1.ParameterDescription(
              name: 'libraryId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'location': _i1.ParameterDescription(
              name: 'location',
              type: _i1.getType<_i36.LibraryBookLocation>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['libraryBooks'] as _i11.LibraryBooksEndpoint)
                  .postLibraryBook(
            session,
            params['isbn'],
            params['libraryId'],
            params['location'],
          ),
        ),
        'fetchLibraryBooks': _i1.MethodConnector(
          name: 'fetchLibraryBooks',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['libraryBooks'] as _i11.LibraryBooksEndpoint)
                  .fetchLibraryBooks(session),
        ),
        'fetchLibraryBookByIsbn': _i1.MethodConnector(
          name: 'fetchLibraryBookByIsbn',
          params: {
            'isbn': _i1.ParameterDescription(
              name: 'isbn',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['libraryBooks'] as _i11.LibraryBooksEndpoint)
                  .fetchLibraryBookByIsbn(
            session,
            params['isbn'],
          ),
        ),
        'fetchLibraryBookByLibraryId': _i1.MethodConnector(
          name: 'fetchLibraryBookByLibraryId',
          params: {
            'libraryId': _i1.ParameterDescription(
              name: 'libraryId',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['libraryBooks'] as _i11.LibraryBooksEndpoint)
                  .fetchLibraryBookByLibraryId(
            session,
            params['libraryId'],
          ),
        ),
        'fetchLibraryBooksMatchingQuery': _i1.MethodConnector(
          name: 'fetchLibraryBooksMatchingQuery',
          params: {
            'libraryBookQuery': _i1.ParameterDescription(
              name: 'libraryBookQuery',
              type: _i1.getType<_i37.LibraryBookQuery>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['libraryBooks'] as _i11.LibraryBooksEndpoint)
                  .fetchLibraryBooksMatchingQuery(
            session,
            params['libraryBookQuery'],
          ),
        ),
        'updateLibraryBook': _i1.MethodConnector(
          name: 'updateLibraryBook',
          params: {
            'isbn': _i1.ParameterDescription(
              name: 'isbn',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'libraryId': _i1.ParameterDescription(
              name: 'libraryId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'available': _i1.ParameterDescription(
              name: 'available',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'location': _i1.ParameterDescription(
              name: 'location',
              type: _i1.getType<_i36.LibraryBookLocation?>(),
              nullable: true,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'author': _i1.ParameterDescription(
              name: 'author',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'readingLevel': _i1.ParameterDescription(
              name: 'readingLevel',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['libraryBooks'] as _i11.LibraryBooksEndpoint)
                  .updateLibraryBook(
            session,
            params['isbn'],
            params['libraryId'],
            params['available'],
            params['location'],
            params['title'],
            params['author'],
            params['description'],
            params['readingLevel'],
          ),
        ),
        'deleteLibraryBook': _i1.MethodConnector(
          name: 'deleteLibraryBook',
          params: {
            'libraryBookId': _i1.ParameterDescription(
              name: 'libraryBookId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['libraryBooks'] as _i11.LibraryBooksEndpoint)
                  .deleteLibraryBook(
            session,
            params['libraryBookId'],
          ),
        ),
      },
    );
    connectors['pupilBookLending'] = _i1.EndpointConnector(
      name: 'pupilBookLending',
      endpoint: endpoints['pupilBookLending']!,
      methodConnectors: {
        'postPupilBookLending': _i1.MethodConnector(
          name: 'postPupilBookLending',
          params: {
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'libraryId': _i1.ParameterDescription(
              name: 'libraryId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'lentBy': _i1.ParameterDescription(
              name: 'lentBy',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilBookLending'] as _i12.PupilBookLendingEndpoint)
                  .postPupilBookLending(
            session,
            params['pupilId'],
            params['libraryId'],
            params['lentBy'],
          ),
        ),
        'fetchPupilBookLendings': _i1.MethodConnector(
          name: 'fetchPupilBookLendings',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilBookLending'] as _i12.PupilBookLendingEndpoint)
                  .fetchPupilBookLendings(session),
        ),
        'fetchPupilBookLendingById': _i1.MethodConnector(
          name: 'fetchPupilBookLendingById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilBookLending'] as _i12.PupilBookLendingEndpoint)
                  .fetchPupilBookLendingById(
            session,
            params['id'],
          ),
        ),
        'updatePupilBookLending': _i1.MethodConnector(
          name: 'updatePupilBookLending',
          params: {
            'pupilBookLending': _i1.ParameterDescription(
              name: 'pupilBookLending',
              type: _i1.getType<_i38.PupilBookLending>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilBookLending'] as _i12.PupilBookLendingEndpoint)
                  .updatePupilBookLending(
            session,
            params['pupilBookLending'],
          ),
        ),
        'deletePupilBookLending': _i1.MethodConnector(
          name: 'deletePupilBookLending',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilBookLending'] as _i12.PupilBookLendingEndpoint)
                  .deletePupilBookLending(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['competenceCheck'] = _i1.EndpointConnector(
      name: 'competenceCheck',
      endpoint: endpoints['competenceCheck']!,
      methodConnectors: {
        'postCompetenceCheck': _i1.MethodConnector(
          name: 'postCompetenceCheck',
          params: {
            'competenceId': _i1.ParameterDescription(
              name: 'competenceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'score': _i1.ParameterDescription(
              name: 'score',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'comment': _i1.ParameterDescription(
              name: 'comment',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'valueFactor': _i1.ParameterDescription(
              name: 'valueFactor',
              type: _i1.getType<double>(),
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
              (endpoints['competenceCheck'] as _i13.CompetenceCheckEndpoint)
                  .postCompetenceCheck(
            session,
            competenceId: params['competenceId'],
            pupilId: params['pupilId'],
            score: params['score'],
            comment: params['comment'],
            valueFactor: params['valueFactor'],
            createdBy: params['createdBy'],
          ),
        )
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
              type: _i1.getType<_i39.File>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['competence'] as _i14.CompetenceEndpoint)
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
              (endpoints['competence'] as _i14.CompetenceEndpoint)
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
              (endpoints['competence'] as _i14.CompetenceEndpoint)
                  .getAllCompetences(session),
        ),
        'updateCompetence': _i1.MethodConnector(
          name: 'updateCompetence',
          params: {
            'competence': _i1.ParameterDescription(
              name: 'competence',
              type: _i1.getType<_i40.Competence>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['competence'] as _i14.CompetenceEndpoint)
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
              (endpoints['competence'] as _i14.CompetenceEndpoint)
                  .deleteCompetence(
            session,
            params['publicId'],
          ),
        ),
      },
    );
    connectors['learningSupportPlan'] = _i1.EndpointConnector(
      name: 'learningSupportPlan',
      endpoint: endpoints['learningSupportPlan']!,
      methodConnectors: {
        'fetchLearningSupportPlans': _i1.MethodConnector(
          name: 'fetchLearningSupportPlans',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['learningSupportPlan']
                      as _i15.LearningSupportPlanEndpoint)
                  .fetchLearningSupportPlans(session),
        ),
        'createLearningSupportPlan': _i1.MethodConnector(
          name: 'createLearningSupportPlan',
          params: {
            'plan': _i1.ParameterDescription(
              name: 'plan',
              type: _i1.getType<_i41.LearningSupportPlan>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['learningSupportPlan']
                      as _i15.LearningSupportPlanEndpoint)
                  .createLearningSupportPlan(
            session,
            params['plan'],
          ),
        ),
        'updateLearningSupportPlan': _i1.MethodConnector(
          name: 'updateLearningSupportPlan',
          params: {
            'plan': _i1.ParameterDescription(
              name: 'plan',
              type: _i1.getType<_i41.LearningSupportPlan>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['learningSupportPlan']
                      as _i15.LearningSupportPlanEndpoint)
                  .updateLearningSupportPlan(
            session,
            params['plan'],
          ),
        ),
        'deleteLearningSupportPlan': _i1.MethodConnector(
          name: 'deleteLearningSupportPlan',
          params: {
            'plan': _i1.ParameterDescription(
              name: 'plan',
              type: _i1.getType<_i41.LearningSupportPlan>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['learningSupportPlan']
                      as _i15.LearningSupportPlanEndpoint)
                  .deleteLearningSupportPlan(
            session,
            params['plan'],
          ),
        ),
        'postSupportCategoryStatus': _i1.MethodConnector(
          name: 'postSupportCategoryStatus',
          params: {
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'supportCategoryId': _i1.ParameterDescription(
              name: 'supportCategoryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'learningSupportPlanId': _i1.ParameterDescription(
              name: 'learningSupportPlanId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'comment': _i1.ParameterDescription(
              name: 'comment',
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
              (endpoints['learningSupportPlan']
                      as _i15.LearningSupportPlanEndpoint)
                  .postSupportCategoryStatus(
            session,
            params['pupilId'],
            params['supportCategoryId'],
            params['learningSupportPlanId'],
            params['status'],
            params['comment'],
            params['createdBy'],
          ),
        ),
        'fetchSupportCategoryStatus': _i1.MethodConnector(
          name: 'fetchSupportCategoryStatus',
          params: {
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['learningSupportPlan']
                      as _i15.LearningSupportPlanEndpoint)
                  .fetchSupportCategoryStatus(
            session,
            params['pupilId'],
          ),
        ),
        'fetchSupportCategoryStatusFromPupil': _i1.MethodConnector(
          name: 'fetchSupportCategoryStatusFromPupil',
          params: {
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['learningSupportPlan']
                      as _i15.LearningSupportPlanEndpoint)
                  .fetchSupportCategoryStatusFromPupil(
            session,
            params['pupilId'],
          ),
        ),
        'updateCategoryStatus': _i1.MethodConnector(
          name: 'updateCategoryStatus',
          params: {
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'supportCategoryId': _i1.ParameterDescription(
              name: 'supportCategoryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'comment': _i1.ParameterDescription(
              name: 'comment',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'createdBy': _i1.ParameterDescription(
              name: 'createdBy',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'createdAt': _i1.ParameterDescription(
              name: 'createdAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['learningSupportPlan']
                      as _i15.LearningSupportPlanEndpoint)
                  .updateCategoryStatus(
            session,
            params['pupilId'],
            params['supportCategoryId'],
            params['status'],
            params['comment'],
            params['createdBy'],
            params['createdAt'],
          ),
        ),
        'deleteSupportCategoryStatus': _i1.MethodConnector(
          name: 'deleteSupportCategoryStatus',
          params: {
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'statusId': _i1.ParameterDescription(
              name: 'statusId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['learningSupportPlan']
                      as _i15.LearningSupportPlanEndpoint)
                  .deleteSupportCategoryStatus(
            session,
            params['pupilId'],
            params['statusId'],
          ),
        ),
        'postCategoryGoal': _i1.MethodConnector(
          name: 'postCategoryGoal',
          params: {
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'supportCategoryId': _i1.ParameterDescription(
              name: 'supportCategoryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'strategies': _i1.ParameterDescription(
              name: 'strategies',
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
              (endpoints['learningSupportPlan']
                      as _i15.LearningSupportPlanEndpoint)
                  .postCategoryGoal(
            session,
            params['pupilId'],
            params['supportCategoryId'],
            params['description'],
            params['strategies'],
            params['createdBy'],
          ),
        ),
      },
    );
    connectors['supportCategory'] = _i1.EndpointConnector(
      name: 'supportCategory',
      endpoint: endpoints['supportCategory']!,
      methodConnectors: {
        'fetchSupportCategories': _i1.MethodConnector(
          name: 'fetchSupportCategories',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['supportCategory'] as _i16.SupportCategoryEndpoint)
                  .fetchSupportCategories(session),
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
              (endpoints['supportCategory'] as _i16.SupportCategoryEndpoint)
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
              type: _i1.getType<_i42.SupportCategory>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['supportCategory'] as _i16.SupportCategoryEndpoint)
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
              type: _i1.getType<_i42.SupportCategory>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['supportCategory'] as _i16.SupportCategoryEndpoint)
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
              type: _i1.getType<_i42.SupportCategory>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['supportCategory'] as _i16.SupportCategoryEndpoint)
                  .deleteSupportCategory(
            session,
            params['category'],
          ),
        ),
      },
    );
    connectors['matrix'] = _i1.EndpointConnector(
      name: 'matrix',
      endpoint: endpoints['matrix']!,
      methodConnectors: {
        'getCompulsoryRooms': _i1.MethodConnector(
          name: 'getCompulsoryRooms',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['matrix'] as _i17.MatrixEndpoint)
                  .getCompulsoryRooms(session),
        ),
        'setCompulsoryRooms': _i1.MethodConnector(
          name: 'setCompulsoryRooms',
          params: {
            'compulsoryRooms': _i1.ParameterDescription(
              name: 'compulsoryRooms',
              type: _i1.getType<List<_i43.CompulsoryRoom>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['matrix'] as _i17.MatrixEndpoint).setCompulsoryRooms(
            session,
            params['compulsoryRooms'],
          ),
        ),
        'deleteCompulsoryRoom': _i1.MethodConnector(
          name: 'deleteCompulsoryRoom',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['matrix'] as _i17.MatrixEndpoint).deleteCompulsoryRoom(
            session,
            params['roomId'],
          ),
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
              (endpoints['pupil'] as _i18.PupilEndpoint).fetchPupils(session),
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
              (endpoints['pupil'] as _i18.PupilEndpoint).fetchPupilsById(
            session,
            params['internalIds'],
          ),
        ),
        'deletePupilDocument': _i1.MethodConnector(
          name: 'deletePupilDocument',
          params: {
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'documentType': _i1.ParameterDescription(
              name: 'documentType',
              type: _i1.getType<_i44.PupilDocumentType>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupil'] as _i18.PupilEndpoint).deletePupilDocument(
            session,
            params['pupilId'],
            params['documentType'],
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
              (endpoints['pupil'] as _i18.PupilEndpoint).resetPublicMediaAuth(
            session,
            params['pupilId'],
            params['createdBy'],
          ),
        ),
        'deleteSupportLevelHistoryItem': _i1.MethodConnector(
          name: 'deleteSupportLevelHistoryItem',
          params: {
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
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
              (endpoints['pupil'] as _i18.PupilEndpoint)
                  .deleteSupportLevelHistoryItem(
            session,
            params['pupilId'],
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
              (endpoints['pupil'] as _i18.PupilEndpoint)
                  .fetchPupilsAsStream(session),
        ),
      },
    );
    connectors['pupilIdentity'] = _i1.EndpointConnector(
      name: 'pupilIdentity',
      endpoint: endpoints['pupilIdentity']!,
      methodConnectors: {
        'sendPupilIdentityMessage': _i1.MethodConnector(
          name: 'sendPupilIdentityMessage',
          params: {
            'pupilIdentityChannel': _i1.ParameterDescription(
              name: 'pupilIdentityChannel',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'pupilIdentityMessage': _i1.ParameterDescription(
              name: 'pupilIdentityMessage',
              type: _i1.getType<_i45.PupilIdentityDto>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilIdentity'] as _i19.PupilIdentityEndpoint)
                  .sendPupilIdentityMessage(
            session,
            params['pupilIdentityChannel'],
            params['pupilIdentityMessage'],
          ),
        ),
        'fetchLastPupilIdentitiesUpdate': _i1.MethodConnector(
          name: 'fetchLastPupilIdentitiesUpdate',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilIdentity'] as _i19.PupilIdentityEndpoint)
                  .fetchLastPupilIdentitiesUpdate(session),
        ),
        'updateLastPupilIdentitiesUpdate': _i1.MethodConnector(
          name: 'updateLastPupilIdentitiesUpdate',
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
              (endpoints['pupilIdentity'] as _i19.PupilIdentityEndpoint)
                  .updateLastPupilIdentitiesUpdate(
            session,
            params['date'],
          ),
        ),
        'deleteLastPupilIdentitiesUpdate': _i1.MethodConnector(
          name: 'deleteLastPupilIdentitiesUpdate',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilIdentity'] as _i19.PupilIdentityEndpoint)
                  .deleteLastPupilIdentitiesUpdate(session),
        ),
        'streamEncryptedPupilIds': _i1.MethodStreamConnector(
          name: 'streamEncryptedPupilIds',
          params: {
            'channelName': _i1.ParameterDescription(
              name: 'channelName',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
            Map<String, Stream> streamParams,
          ) =>
              (endpoints['pupilIdentity'] as _i19.PupilIdentityEndpoint)
                  .streamEncryptedPupilIds(
            session,
            params['channelName'],
          ),
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
              type: _i1.getType<_i46.PupilData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i20.PupilUpdateEndpoint)
                  .updatePupil(
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
              type: _i1.getType<_i47.CommunicationSkills?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i20.PupilUpdateEndpoint)
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
              type: _i1.getType<_i48.TutorInfo?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i20.PupilUpdateEndpoint)
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
              type: _i1.getType<_i49.SiblingsTutorInfo>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i20.PupilUpdateEndpoint)
                  .updateSiblingsTutorInfo(
            session,
            params['siblingsTutorInfo'],
          ),
        ),
        'updatePupilDocument': _i1.MethodConnector(
          name: 'updatePupilDocument',
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
            'documentType': _i1.ParameterDescription(
              name: 'documentType',
              type: _i1.getType<_i44.PupilDocumentType>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i20.PupilUpdateEndpoint)
                  .updatePupilDocument(
            session,
            params['pupilId'],
            params['filePath'],
            params['createdBy'],
            params['documentType'],
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
              (endpoints['pupilUpdate'] as _i20.PupilUpdateEndpoint)
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
              (endpoints['pupilUpdate'] as _i20.PupilUpdateEndpoint)
                  .updateCredit(
            session,
            params['pupilId'],
            params['value'],
            params['description'],
            params['sender'],
          ),
        ),
        'updatePreSchoolMedicalStatus': _i1.MethodConnector(
          name: 'updatePreSchoolMedicalStatus',
          params: {
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'preSchoolMedicalStatus': _i1.ParameterDescription(
              name: 'preSchoolMedicalStatus',
              type: _i1.getType<_i50.PreSchoolMedicalStatus>(),
              nullable: false,
            ),
            'updatedBy': _i1.ParameterDescription(
              name: 'updatedBy',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i20.PupilUpdateEndpoint)
                  .updatePreSchoolMedicalStatus(
            session,
            params['pupilId'],
            params['preSchoolMedicalStatus'],
            params['updatedBy'],
          ),
        ),
        'updatePublicMediaAuth': _i1.MethodConnector(
          name: 'updatePublicMediaAuth',
          params: {
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'publicMediaAuth': _i1.ParameterDescription(
              name: 'publicMediaAuth',
              type: _i1.getType<_i51.PublicMediaAuth>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i20.PupilUpdateEndpoint)
                  .updatePublicMediaAuth(
            session,
            params['pupilId'],
            params['publicMediaAuth'],
          ),
        ),
        'updateSupportLevel': _i1.MethodConnector(
          name: 'updateSupportLevel',
          params: {
            'supportLevel': _i1.ParameterDescription(
              name: 'supportLevel',
              type: _i1.getType<_i52.SupportLevel>(),
              nullable: false,
            ),
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i20.PupilUpdateEndpoint)
                  .updateSupportLevel(
            session,
            params['supportLevel'],
            params['pupilId'],
          ),
        ),
        'updateSchoolyearHeldBackDate': _i1.MethodConnector(
          name: 'updateSchoolyearHeldBackDate',
          params: {
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'schoolyearHeldBackDate': _i1.ParameterDescription(
              name: 'schoolyearHeldBackDate',
              type: _i1.getType<({DateTime? value})>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i20.PupilUpdateEndpoint)
                  .updateSchoolyearHeldBackDate(
            session,
            params['pupilId'],
            params['schoolyearHeldBackDate'],
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
              (endpoints['schoolList'] as _i21.SchoolListEndpoint)
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
              (endpoints['schoolList'] as _i21.SchoolListEndpoint)
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
            'authorizedUsers': _i1.ParameterDescription(
              name: 'authorizedUsers',
              type: _i1.getType<({String? value})?>(),
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
                  ({_i32.MemberOperation operation, List<int> pupilIds})?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schoolList'] as _i21.SchoolListEndpoint)
                  .updateSchoolList(
            session,
            params['listId'],
            params['name'],
            params['description'],
            params['authorizedUsers'],
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
              (endpoints['schoolList'] as _i21.SchoolListEndpoint)
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
              type: _i1.getType<_i53.PupilListEntry>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schoolList'] as _i21.SchoolListEndpoint)
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
            'schoolYearName': _i1.ParameterDescription(
              name: 'schoolYearName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
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
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'supportConferenceDate': _i1.ParameterDescription(
              name: 'supportConferenceDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'reportConferenceDate': _i1.ParameterDescription(
              name: 'reportConferenceDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'reportSignedDate': _i1.ParameterDescription(
              name: 'reportSignedDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayAdmin'] as _i22.SchooldayAdminEndpoint)
                  .createSchoolSemester(
            session,
            params['schoolYearName'],
            params['startDate'],
            params['endDate'],
            params['isFirst'],
            params['classConferenceDate'],
            params['supportConferenceDate'],
            params['reportConferenceDate'],
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
              (endpoints['schooldayAdmin'] as _i22.SchooldayAdminEndpoint)
                  .getAllSchoolSemesters(session),
        ),
        'getCurrentSchoolSemester': _i1.MethodConnector(
          name: 'getCurrentSchoolSemester',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayAdmin'] as _i22.SchooldayAdminEndpoint)
                  .getCurrentSchoolSemester(session),
        ),
        'updateSchoolSemester': _i1.MethodConnector(
          name: 'updateSchoolSemester',
          params: {
            'schoolSemester': _i1.ParameterDescription(
              name: 'schoolSemester',
              type: _i1.getType<_i54.SchoolSemester>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayAdmin'] as _i22.SchooldayAdminEndpoint)
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
              type: _i1.getType<_i54.SchoolSemester>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayAdmin'] as _i22.SchooldayAdminEndpoint)
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
              (endpoints['schooldayAdmin'] as _i22.SchooldayAdminEndpoint)
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
              (endpoints['schooldayAdmin'] as _i22.SchooldayAdminEndpoint)
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
              (endpoints['schooldayAdmin'] as _i22.SchooldayAdminEndpoint)
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
              type: _i1.getType<_i55.Schoolday>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayAdmin'] as _i22.SchooldayAdminEndpoint)
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
              (endpoints['schoolday'] as _i22.SchooldayEndpoint)
                  .getSchoolSemesters(session),
        ),
        'getSchooldays': _i1.MethodConnector(
          name: 'getSchooldays',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schoolday'] as _i22.SchooldayEndpoint)
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
              (endpoints['schooldayEvent'] as _i23.SchooldayEventEndpoint)
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
              type: _i1.getType<_i56.SchooldayEventType>(),
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
              (endpoints['schooldayEvent'] as _i23.SchooldayEventEndpoint)
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
              type: _i1.getType<_i57.SchooldayEvent>(),
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
              (endpoints['schooldayEvent'] as _i23.SchooldayEventEndpoint)
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
              (endpoints['schooldayEvent'] as _i23.SchooldayEventEndpoint)
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
              (endpoints['schooldayEvent'] as _i23.SchooldayEventEndpoint)
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
              (endpoints['schooldayEvent'] as _i23.SchooldayEventEndpoint)
                  .deleteSchooldayEventFile(
            session,
            params['schooldayEventId'],
            params['isProcessed'],
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
              (endpoints['user'] as _i24.UserEndpoint).getCurrentUser(session),
        ),
        'getAllUsers': _i1.MethodConnector(
          name: 'getAllUsers',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i24.UserEndpoint).getAllUsers(session),
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
              (endpoints['user'] as _i24.UserEndpoint).changePassword(
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
              (endpoints['user'] as _i24.UserEndpoint)
                  .increaseStaffCredit(session),
        ),
      },
    );
    connectors['pupilWorkbooks'] = _i1.EndpointConnector(
      name: 'pupilWorkbooks',
      endpoint: endpoints['pupilWorkbooks']!,
      methodConnectors: {
        'postPupilWorkbook': _i1.MethodConnector(
          name: 'postPupilWorkbook',
          params: {
            'isbn': _i1.ParameterDescription(
              name: 'isbn',
              type: _i1.getType<int>(),
              nullable: false,
            ),
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
              (endpoints['pupilWorkbooks'] as _i25.PupilWorkbooksEndpoint)
                  .postPupilWorkbook(
            session,
            params['isbn'],
            params['pupilId'],
            params['createdBy'],
          ),
        ),
        'fetchPupilWorkbooks': _i1.MethodConnector(
          name: 'fetchPupilWorkbooks',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilWorkbooks'] as _i25.PupilWorkbooksEndpoint)
                  .fetchPupilWorkbooks(session),
        ),
        'fetchPupilWorkbooksFromPupil': _i1.MethodConnector(
          name: 'fetchPupilWorkbooksFromPupil',
          params: {
            'pupilId': _i1.ParameterDescription(
              name: 'pupilId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilWorkbooks'] as _i25.PupilWorkbooksEndpoint)
                  .fetchPupilWorkbooksFromPupil(
            session,
            params['pupilId'],
          ),
        ),
        'updatePupilWorkbook': _i1.MethodConnector(
          name: 'updatePupilWorkbook',
          params: {
            'pupilWorkbook': _i1.ParameterDescription(
              name: 'pupilWorkbook',
              type: _i1.getType<_i58.PupilWorkbook>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilWorkbooks'] as _i25.PupilWorkbooksEndpoint)
                  .updatePupilWorkbook(
            session,
            params['pupilWorkbook'],
          ),
        ),
        'deletePupilWorkbook': _i1.MethodConnector(
          name: 'deletePupilWorkbook',
          params: {
            'pupilWorkbookId': _i1.ParameterDescription(
              name: 'pupilWorkbookId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilWorkbooks'] as _i25.PupilWorkbooksEndpoint)
                  .deletePupilWorkbook(
            session,
            params['pupilWorkbookId'],
          ),
        ),
      },
    );
    connectors['workbooks'] = _i1.EndpointConnector(
      name: 'workbooks',
      endpoint: endpoints['workbooks']!,
      methodConnectors: {
        'postWorkbook': _i1.MethodConnector(
          name: 'postWorkbook',
          params: {
            'workbook': _i1.ParameterDescription(
              name: 'workbook',
              type: _i1.getType<_i59.Workbook>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['workbooks'] as _i26.WorkbooksEndpoint).postWorkbook(
            session,
            params['workbook'],
          ),
        ),
        'fetchWorkbookByIsbn': _i1.MethodConnector(
          name: 'fetchWorkbookByIsbn',
          params: {
            'isbn': _i1.ParameterDescription(
              name: 'isbn',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['workbooks'] as _i26.WorkbooksEndpoint)
                  .fetchWorkbookByIsbn(
            session,
            params['isbn'],
          ),
        ),
        'fetchWorkbooks': _i1.MethodConnector(
          name: 'fetchWorkbooks',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['workbooks'] as _i26.WorkbooksEndpoint)
                  .fetchWorkbooks(session),
        ),
        'updateWorkbook': _i1.MethodConnector(
          name: 'updateWorkbook',
          params: {
            'workbook': _i1.ParameterDescription(
              name: 'workbook',
              type: _i1.getType<_i59.Workbook>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['workbooks'] as _i26.WorkbooksEndpoint).updateWorkbook(
            session,
            params['workbook'],
          ),
        ),
        'deleteWorkbook': _i1.MethodConnector(
          name: 'deleteWorkbook',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['workbooks'] as _i26.WorkbooksEndpoint).deleteWorkbook(
            session,
            params['id'],
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
              (endpoints['files'] as _i27.FilesEndpoint).getUploadDescription(
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
              (endpoints['files'] as _i27.FilesEndpoint).verifyUpload(
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
              (endpoints['files'] as _i27.FilesEndpoint).getImage(
            session,
            params['documentId'],
          ),
        ),
        'getUnencryptedImage': _i1.MethodConnector(
          name: 'getUnencryptedImage',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['files'] as _i27.FilesEndpoint).getUnencryptedImage(
            session,
            params['path'],
          ),
        ),
      },
    );
    modules['serverpod_auth'] = _i60.Endpoints()..initializeEndpoints(server);
  }
}

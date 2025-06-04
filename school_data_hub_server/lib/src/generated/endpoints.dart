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
import '../_features/attendance/endpoints/missed_class_endpoint.dart' as _i3;
import '../_features/authorizations/endpoints/authorization_endpoint.dart'
    as _i4;
import '../_features/authorizations/endpoints/pupil_authorization_endpoint.dart'
    as _i5;
import '../_features/books/endpoints/books/book_tags_endpoint.dart' as _i6;
import '../_features/books/endpoints/books/books_endpoint.dart' as _i7;
import '../_features/books/endpoints/library_books/library_book_locations_endpoint.dart'
    as _i8;
import '../_features/books/endpoints/library_books/library_books_endpoint.dart'
    as _i9;
import '../_features/books/endpoints/pupil_book_lending_endpoint.dart' as _i10;
import '../_features/learning/endpoints/competence_check_endpoint.dart' as _i11;
import '../_features/learning/endpoints/competence_endpoint.dart' as _i12;
import '../_features/learning_support/endpoints/learning_support_plan_endpoint.dart'
    as _i13;
import '../_features/learning_support/endpoints/support_category_endpoint.dart'
    as _i14;
import '../_features/pupil/endpooints/pupil_endpoint.dart' as _i15;
import '../_features/pupil/endpooints/pupil_update_endpoint.dart' as _i16;
import '../_features/school_lists/endpoints/school_list_endpoint.dart' as _i17;
import '../_features/schoolday/endpoints/schoolday_admin_endpoint.dart' as _i18;
import '../_features/schoolday_events/endpoints/schoolday_event_endpoint.dart'
    as _i19;
import '../_features/user/endpoints/auth_endpoint.dart' as _i20;
import '../_features/user/endpoints/user_endpoints.dart' as _i21;
import '../_features/workbooks/endpoints/pupil_workbooks_endpoint.dart' as _i22;
import '../_features/workbooks/endpoints/workbooks_endpoint.dart' as _i23;
import '../_shared/endpoints/file_endpoints.dart' as _i24;
import 'package:school_data_hub_server/src/generated/_features/user/models/roles.dart'
    as _i25;
import 'package:school_data_hub_server/src/generated/_features/attendance/models/missed_class.dart'
    as _i26;
import 'package:school_data_hub_server/src/generated/_shared/models/member_operation.dart'
    as _i27;
import 'package:school_data_hub_server/src/generated/_features/authorizations/models/pupil_authorization.dart'
    as _i28;
import 'package:school_data_hub_server/src/generated/_features/books/models/book_tagging/book_tag.dart'
    as _i29;
import 'package:school_data_hub_server/src/generated/_features/books/models/book.dart'
    as _i30;
import 'package:school_data_hub_server/src/generated/_features/books/models/library_book_location.dart'
    as _i31;
import 'package:school_data_hub_server/src/generated/_features/books/models/library_book_query.dart'
    as _i32;
import 'package:school_data_hub_server/src/generated/_features/books/models/pupil_book_lending.dart'
    as _i33;
import 'dart:io' as _i34;
import 'package:school_data_hub_server/src/generated/_features/learning/models/competence.dart'
    as _i35;
import 'package:school_data_hub_server/src/generated/_features/learning_support/models/learning_support_plan.dart'
    as _i36;
import 'package:school_data_hub_server/src/generated/_features/learning_support/models/support_category.dart'
    as _i37;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_data/dto/pupil_document_type.dart'
    as _i38;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_data/pupil_data.dart'
    as _i39;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_data/communication/communication_skills.dart'
    as _i40;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_data/communication/tutor_info.dart'
    as _i41;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_data/dto/siblings_tutor_info_dto.dart'
    as _i42;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_data/preschool/pre_school_medical_status.dart'
    as _i43;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_data/communication/public_media_auth.dart'
    as _i44;
import 'package:school_data_hub_server/src/generated/_features/learning_support/models/support_level.dart'
    as _i45;
import 'package:school_data_hub_server/src/generated/_features/school_lists/models/pupil_entry.dart'
    as _i46;
import 'package:school_data_hub_server/src/generated/_features/schoolday/models/school_semester.dart'
    as _i47;
import 'package:school_data_hub_server/src/generated/_features/schoolday/models/schoolday.dart'
    as _i48;
import 'package:school_data_hub_server/src/generated/_features/schoolday_events/models/schoolday_event_type.dart'
    as _i49;
import 'package:school_data_hub_server/src/generated/_features/schoolday_events/models/schoolday_event.dart'
    as _i50;
import 'package:school_data_hub_server/src/generated/_features/user/models/device_info.dart'
    as _i51;
import 'package:school_data_hub_server/src/generated/protocol.dart' as _i52;
import 'package:school_data_hub_server/src/generated/_features/workbooks/models/pupil_workbook.dart'
    as _i53;
import 'package:school_data_hub_server/src/generated/_features/workbooks/models/workbook.dart'
    as _i54;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i55;

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
      'missedClass': _i3.MissedClassEndpoint()
        ..initialize(
          server,
          'missedClass',
          null,
        ),
      'authorization': _i4.AuthorizationEndpoint()
        ..initialize(
          server,
          'authorization',
          null,
        ),
      'pupilAuthorization': _i5.PupilAuthorizationEndpoint()
        ..initialize(
          server,
          'pupilAuthorization',
          null,
        ),
      'bookTags': _i6.BookTagsEndpoint()
        ..initialize(
          server,
          'bookTags',
          null,
        ),
      'books': _i7.BooksEndpoint()
        ..initialize(
          server,
          'books',
          null,
        ),
      'libraryBookLocations': _i8.LibraryBookLocationsEndpoint()
        ..initialize(
          server,
          'libraryBookLocations',
          null,
        ),
      'libraryBooks': _i9.LibraryBooksEndpoint()
        ..initialize(
          server,
          'libraryBooks',
          null,
        ),
      'pupilBookLending': _i10.PupilBookLendingEndpoint()
        ..initialize(
          server,
          'pupilBookLending',
          null,
        ),
      'competenceCheck': _i11.CompetenceCheckEndpoint()
        ..initialize(
          server,
          'competenceCheck',
          null,
        ),
      'competence': _i12.CompetenceEndpoint()
        ..initialize(
          server,
          'competence',
          null,
        ),
      'learningSupportPlan': _i13.LearningSupportPlanEndpoint()
        ..initialize(
          server,
          'learningSupportPlan',
          null,
        ),
      'supportCategory': _i14.SupportCategoryEndpoint()
        ..initialize(
          server,
          'supportCategory',
          null,
        ),
      'pupil': _i15.PupilEndpoint()
        ..initialize(
          server,
          'pupil',
          null,
        ),
      'pupilUpdate': _i16.PupilUpdateEndpoint()
        ..initialize(
          server,
          'pupilUpdate',
          null,
        ),
      'schoolList': _i17.SchoolListEndpoint()
        ..initialize(
          server,
          'schoolList',
          null,
        ),
      'schooldayAdmin': _i18.SchooldayAdminEndpoint()
        ..initialize(
          server,
          'schooldayAdmin',
          null,
        ),
      'schoolday': _i18.SchooldayEndpoint()
        ..initialize(
          server,
          'schoolday',
          null,
        ),
      'schooldayEvent': _i19.SchooldayEventEndpoint()
        ..initialize(
          server,
          'schooldayEvent',
          null,
        ),
      'auth': _i20.AuthEndpoint()
        ..initialize(
          server,
          'auth',
          null,
        ),
      'user': _i21.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
      'pupilWorkbooks': _i22.PupilWorkbooksEndpoint()
        ..initialize(
          server,
          'pupilWorkbooks',
          null,
        ),
      'workbooks': _i23.WorkbooksEndpoint()
        ..initialize(
          server,
          'workbooks',
          null,
        ),
      'files': _i24.FilesEndpoint()
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
              type: _i1.getType<_i25.Role>(),
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
    connectors['missedClass'] = _i1.EndpointConnector(
      name: 'missedClass',
      endpoint: endpoints['missedClass']!,
      methodConnectors: {
        'postMissedClass': _i1.MethodConnector(
          name: 'postMissedClass',
          params: {
            'missedClass': _i1.ParameterDescription(
              name: 'missedClass',
              type: _i1.getType<_i26.MissedClass>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['missedClass'] as _i3.MissedClassEndpoint)
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
              type: _i1.getType<List<_i26.MissedClass>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['missedClass'] as _i3.MissedClassEndpoint)
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
              (endpoints['missedClass'] as _i3.MissedClassEndpoint)
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
              (endpoints['missedClass'] as _i3.MissedClassEndpoint)
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
              (endpoints['missedClass'] as _i3.MissedClassEndpoint)
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
              type: _i1.getType<_i26.MissedClass>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['missedClass'] as _i3.MissedClassEndpoint)
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
              (endpoints['missedClass'] as _i3.MissedClassEndpoint)
                  .streamMyModels(session),
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
              (endpoints['authorization'] as _i4.AuthorizationEndpoint)
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
              (endpoints['authorization'] as _i4.AuthorizationEndpoint)
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
              (endpoints['authorization'] as _i4.AuthorizationEndpoint)
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
                  ({_i27.MemberOperation operation, List<int> pupilIds})?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['authorization'] as _i4.AuthorizationEndpoint)
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
              (endpoints['authorization'] as _i4.AuthorizationEndpoint)
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
              type: _i1.getType<_i28.PupilAuthorization>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilAuthorization']
                      as _i5.PupilAuthorizationEndpoint)
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
                      as _i5.PupilAuthorizationEndpoint)
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
                      as _i5.PupilAuthorizationEndpoint)
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
              type: _i1.getType<_i29.BookTag>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['bookTags'] as _i6.BookTagsEndpoint).postBookTag(
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
              (endpoints['bookTags'] as _i6.BookTagsEndpoint)
                  .fetchBookTags(session),
        ),
        'updateBookTag': _i1.MethodConnector(
          name: 'updateBookTag',
          params: {
            'bookTag': _i1.ParameterDescription(
              name: 'bookTag',
              type: _i1.getType<_i29.BookTag>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['bookTags'] as _i6.BookTagsEndpoint).updateBookTag(
            session,
            params['bookTag'],
          ),
        ),
        'deleteBookTag': _i1.MethodConnector(
          name: 'deleteBookTag',
          params: {
            'bookTag': _i1.ParameterDescription(
              name: 'bookTag',
              type: _i1.getType<_i29.BookTag>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['bookTags'] as _i6.BookTagsEndpoint).deleteBookTag(
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
              type: _i1.getType<_i30.Book>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['books'] as _i7.BooksEndpoint).postBook(
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
              (endpoints['books'] as _i7.BooksEndpoint).fetchBooks(session),
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
              (endpoints['books'] as _i7.BooksEndpoint).fetchBookByIsbn(
            session,
            params['isbn'],
          ),
        ),
        'updateBook': _i1.MethodConnector(
          name: 'updateBook',
          params: {
            'book': _i1.ParameterDescription(
              name: 'book',
              type: _i1.getType<_i30.Book>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['books'] as _i7.BooksEndpoint).updateBook(
            session,
            params['book'],
          ),
        ),
        'updateBookTags': _i1.MethodConnector(
          name: 'updateBookTags',
          params: {
            'book': _i1.ParameterDescription(
              name: 'book',
              type: _i1.getType<_i30.Book>(),
              nullable: false,
            ),
            'tags': _i1.ParameterDescription(
              name: 'tags',
              type: _i1.getType<List<_i29.BookTag>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['books'] as _i7.BooksEndpoint).updateBookTags(
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
              (endpoints['books'] as _i7.BooksEndpoint).deleteBook(
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
              type: _i1.getType<_i31.LibraryBookLocation>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['libraryBookLocations']
                      as _i8.LibraryBookLocationsEndpoint)
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
                      as _i8.LibraryBookLocationsEndpoint)
                  .fetchLibraryBookLocations(session),
        ),
        'updateLibraryBookLocation': _i1.MethodConnector(
          name: 'updateLibraryBookLocation',
          params: {
            'libraryBookLocation': _i1.ParameterDescription(
              name: 'libraryBookLocation',
              type: _i1.getType<_i31.LibraryBookLocation>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['libraryBookLocations']
                      as _i8.LibraryBookLocationsEndpoint)
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
              type: _i1.getType<_i31.LibraryBookLocation>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['libraryBookLocations']
                      as _i8.LibraryBookLocationsEndpoint)
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
              type: _i1.getType<_i31.LibraryBookLocation>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['libraryBooks'] as _i9.LibraryBooksEndpoint)
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
              (endpoints['libraryBooks'] as _i9.LibraryBooksEndpoint)
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
              (endpoints['libraryBooks'] as _i9.LibraryBooksEndpoint)
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
              (endpoints['libraryBooks'] as _i9.LibraryBooksEndpoint)
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
              type: _i1.getType<_i32.LibraryBookQuery>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['libraryBooks'] as _i9.LibraryBooksEndpoint)
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
              type: _i1.getType<_i31.LibraryBookLocation?>(),
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
              (endpoints['libraryBooks'] as _i9.LibraryBooksEndpoint)
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
              (endpoints['libraryBooks'] as _i9.LibraryBooksEndpoint)
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
              (endpoints['pupilBookLending'] as _i10.PupilBookLendingEndpoint)
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
              (endpoints['pupilBookLending'] as _i10.PupilBookLendingEndpoint)
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
              (endpoints['pupilBookLending'] as _i10.PupilBookLendingEndpoint)
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
              type: _i1.getType<_i33.PupilBookLending>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilBookLending'] as _i10.PupilBookLendingEndpoint)
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
              (endpoints['pupilBookLending'] as _i10.PupilBookLendingEndpoint)
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
              (endpoints['competenceCheck'] as _i11.CompetenceCheckEndpoint)
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
              type: _i1.getType<_i34.File>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['competence'] as _i12.CompetenceEndpoint)
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
              (endpoints['competence'] as _i12.CompetenceEndpoint)
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
              (endpoints['competence'] as _i12.CompetenceEndpoint)
                  .getAllCompetences(session),
        ),
        'updateCompetence': _i1.MethodConnector(
          name: 'updateCompetence',
          params: {
            'competence': _i1.ParameterDescription(
              name: 'competence',
              type: _i1.getType<_i35.Competence>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['competence'] as _i12.CompetenceEndpoint)
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
              (endpoints['competence'] as _i12.CompetenceEndpoint)
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
                      as _i13.LearningSupportPlanEndpoint)
                  .fetchLearningSupportPlans(session),
        ),
        'createLearningSupportPlan': _i1.MethodConnector(
          name: 'createLearningSupportPlan',
          params: {
            'plan': _i1.ParameterDescription(
              name: 'plan',
              type: _i1.getType<_i36.LearningSupportPlan>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['learningSupportPlan']
                      as _i13.LearningSupportPlanEndpoint)
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
              type: _i1.getType<_i36.LearningSupportPlan>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['learningSupportPlan']
                      as _i13.LearningSupportPlanEndpoint)
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
              type: _i1.getType<_i36.LearningSupportPlan>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['learningSupportPlan']
                      as _i13.LearningSupportPlanEndpoint)
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
                      as _i13.LearningSupportPlanEndpoint)
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
                      as _i13.LearningSupportPlanEndpoint)
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
                      as _i13.LearningSupportPlanEndpoint)
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
                      as _i13.LearningSupportPlanEndpoint)
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
                      as _i13.LearningSupportPlanEndpoint)
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
                      as _i13.LearningSupportPlanEndpoint)
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
              (endpoints['supportCategory'] as _i14.SupportCategoryEndpoint)
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
              (endpoints['supportCategory'] as _i14.SupportCategoryEndpoint)
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
              type: _i1.getType<_i37.SupportCategory>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['supportCategory'] as _i14.SupportCategoryEndpoint)
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
              type: _i1.getType<_i37.SupportCategory>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['supportCategory'] as _i14.SupportCategoryEndpoint)
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
              type: _i1.getType<_i37.SupportCategory>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['supportCategory'] as _i14.SupportCategoryEndpoint)
                  .deleteSupportCategory(
            session,
            params['category'],
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
              (endpoints['pupil'] as _i15.PupilEndpoint).fetchPupils(session),
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
              (endpoints['pupil'] as _i15.PupilEndpoint).fetchPupilsById(
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
              type: _i1.getType<_i38.PupilDocumentType>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupil'] as _i15.PupilEndpoint).deletePupilDocument(
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
              (endpoints['pupil'] as _i15.PupilEndpoint).resetPublicMediaAuth(
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
              (endpoints['pupil'] as _i15.PupilEndpoint)
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
              (endpoints['pupil'] as _i15.PupilEndpoint)
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
              type: _i1.getType<_i39.PupilData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i16.PupilUpdateEndpoint)
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
              type: _i1.getType<_i40.CommunicationSkills?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i16.PupilUpdateEndpoint)
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
              type: _i1.getType<_i41.TutorInfo?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i16.PupilUpdateEndpoint)
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
              type: _i1.getType<_i42.SiblingsTutorInfo>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i16.PupilUpdateEndpoint)
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
              type: _i1.getType<_i38.PupilDocumentType>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i16.PupilUpdateEndpoint)
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
              (endpoints['pupilUpdate'] as _i16.PupilUpdateEndpoint)
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
              (endpoints['pupilUpdate'] as _i16.PupilUpdateEndpoint)
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
              type: _i1.getType<_i43.PreSchoolMedicalStatus>(),
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
              (endpoints['pupilUpdate'] as _i16.PupilUpdateEndpoint)
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
              type: _i1.getType<_i44.PublicMediaAuth>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilUpdate'] as _i16.PupilUpdateEndpoint)
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
              type: _i1.getType<_i45.SupportLevel>(),
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
              (endpoints['pupilUpdate'] as _i16.PupilUpdateEndpoint)
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
              (endpoints['pupilUpdate'] as _i16.PupilUpdateEndpoint)
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
              (endpoints['schoolList'] as _i17.SchoolListEndpoint)
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
              (endpoints['schoolList'] as _i17.SchoolListEndpoint)
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
                  ({_i27.MemberOperation operation, List<int> pupilIds})?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schoolList'] as _i17.SchoolListEndpoint)
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
              (endpoints['schoolList'] as _i17.SchoolListEndpoint)
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
              type: _i1.getType<_i46.PupilListEntry>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schoolList'] as _i17.SchoolListEndpoint)
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
              (endpoints['schooldayAdmin'] as _i18.SchooldayAdminEndpoint)
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
              (endpoints['schooldayAdmin'] as _i18.SchooldayAdminEndpoint)
                  .getAllSchoolSemesters(session),
        ),
        'getCurrentSchoolSemester': _i1.MethodConnector(
          name: 'getCurrentSchoolSemester',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayAdmin'] as _i18.SchooldayAdminEndpoint)
                  .getCurrentSchoolSemester(session),
        ),
        'updateSchoolSemester': _i1.MethodConnector(
          name: 'updateSchoolSemester',
          params: {
            'schoolSemester': _i1.ParameterDescription(
              name: 'schoolSemester',
              type: _i1.getType<_i47.SchoolSemester>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayAdmin'] as _i18.SchooldayAdminEndpoint)
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
              type: _i1.getType<_i47.SchoolSemester>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayAdmin'] as _i18.SchooldayAdminEndpoint)
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
              (endpoints['schooldayAdmin'] as _i18.SchooldayAdminEndpoint)
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
              (endpoints['schooldayAdmin'] as _i18.SchooldayAdminEndpoint)
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
              (endpoints['schooldayAdmin'] as _i18.SchooldayAdminEndpoint)
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
              type: _i1.getType<_i48.Schoolday>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schooldayAdmin'] as _i18.SchooldayAdminEndpoint)
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
              (endpoints['schoolday'] as _i18.SchooldayEndpoint)
                  .getSchoolSemesters(session),
        ),
        'getSchooldays': _i1.MethodConnector(
          name: 'getSchooldays',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['schoolday'] as _i18.SchooldayEndpoint)
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
              (endpoints['schooldayEvent'] as _i19.SchooldayEventEndpoint)
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
              type: _i1.getType<_i49.SchooldayEventType>(),
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
              (endpoints['schooldayEvent'] as _i19.SchooldayEventEndpoint)
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
              type: _i1.getType<_i50.SchooldayEvent>(),
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
              (endpoints['schooldayEvent'] as _i19.SchooldayEventEndpoint)
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
              (endpoints['schooldayEvent'] as _i19.SchooldayEventEndpoint)
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
              (endpoints['schooldayEvent'] as _i19.SchooldayEventEndpoint)
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
              (endpoints['schooldayEvent'] as _i19.SchooldayEventEndpoint)
                  .deleteSchooldayEventFile(
            session,
            params['schooldayEventId'],
            params['isProcessed'],
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
              type: _i1.getType<_i51.DeviceInfo>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i20.AuthEndpoint)
                  .login(
                    session,
                    params['email'],
                    params['password'],
                    params['deviceInfo'],
                  )
                  .then((record) => _i52.mapRecordToJson(record)),
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
              (endpoints['auth'] as _i20.AuthEndpoint).verifyPassword(
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
              (endpoints['auth'] as _i20.AuthEndpoint).logOut(
            session,
            params['keyId'],
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
              (endpoints['user'] as _i21.UserEndpoint).getCurrentUser(session),
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
              (endpoints['user'] as _i21.UserEndpoint).changePassword(
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
              (endpoints['user'] as _i21.UserEndpoint)
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
              (endpoints['pupilWorkbooks'] as _i22.PupilWorkbooksEndpoint)
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
              (endpoints['pupilWorkbooks'] as _i22.PupilWorkbooksEndpoint)
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
              (endpoints['pupilWorkbooks'] as _i22.PupilWorkbooksEndpoint)
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
              type: _i1.getType<_i53.PupilWorkbook>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pupilWorkbooks'] as _i22.PupilWorkbooksEndpoint)
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
              (endpoints['pupilWorkbooks'] as _i22.PupilWorkbooksEndpoint)
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
              type: _i1.getType<_i54.Workbook>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['workbooks'] as _i23.WorkbooksEndpoint).postWorkbook(
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
              (endpoints['workbooks'] as _i23.WorkbooksEndpoint)
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
              (endpoints['workbooks'] as _i23.WorkbooksEndpoint)
                  .fetchWorkbooks(session),
        ),
        'updateWorkbook': _i1.MethodConnector(
          name: 'updateWorkbook',
          params: {
            'workbook': _i1.ParameterDescription(
              name: 'workbook',
              type: _i1.getType<_i54.Workbook>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['workbooks'] as _i23.WorkbooksEndpoint).updateWorkbook(
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
              (endpoints['workbooks'] as _i23.WorkbooksEndpoint).deleteWorkbook(
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
              (endpoints['files'] as _i24.FilesEndpoint).getUploadDescription(
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
              (endpoints['files'] as _i24.FilesEndpoint).verifyUpload(
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
              (endpoints['files'] as _i24.FilesEndpoint).getImage(
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
              (endpoints['files'] as _i24.FilesEndpoint).getUnencryptedImage(
            session,
            params['path'],
          ),
        ),
      },
    );
    modules['serverpod_auth'] = _i55.Endpoints()..initializeEndpoints(server);
  }
}

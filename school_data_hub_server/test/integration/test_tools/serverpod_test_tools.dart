/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_local_identifiers

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_test/serverpod_test.dart' as _i1;
import 'package:serverpod/serverpod.dart' as _i2;
import 'dart:async' as _i3;
import 'package:school_data_hub_server/src/generated/_features/user/models/staff_user.dart'
    as _i4;
import 'package:school_data_hub_server/src/generated/_features/user/models/roles.dart'
    as _i5;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_data/pupil_data.dart'
    as _i6;
import 'package:school_data_hub_server/src/generated/_features/attendance/models/missed_schoolday_dto.dart'
    as _i7;
import 'package:school_data_hub_server/src/generated/_features/attendance/models/missed_schoolday.dart'
    as _i8;
import 'package:school_data_hub_server/src/generated/_features/authorizations/models/authorization.dart'
    as _i9;
import 'package:school_data_hub_server/src/generated/_shared/models/member_operation.dart'
    as _i10;
import 'package:school_data_hub_server/src/generated/protocol.dart' as _i11;
import 'package:school_data_hub_server/src/generated/_features/authorizations/models/pupil_authorization.dart'
    as _i12;
import 'package:school_data_hub_server/src/generated/_features/books/models/book_tagging/book_tag.dart'
    as _i13;
import 'package:school_data_hub_server/src/generated/_features/books/models/book.dart'
    as _i14;
import 'package:school_data_hub_server/src/generated/_features/books/models/library_book_location.dart'
    as _i15;
import 'package:school_data_hub_server/src/generated/_features/books/models/library_book.dart'
    as _i16;
import 'package:school_data_hub_server/src/generated/_features/books/models/library_book_query.dart'
    as _i17;
import 'package:school_data_hub_server/src/generated/_features/books/models/pupil_book_lending.dart'
    as _i18;
import 'package:school_data_hub_server/src/generated/_features/learning/models/competence.dart'
    as _i19;
import 'dart:io' as _i20;
import 'package:school_data_hub_server/src/generated/_features/learning_support/models/learning_support_plan.dart'
    as _i21;
import 'package:school_data_hub_server/src/generated/_features/learning_support/models/support_category_status.dart'
    as _i22;
import 'package:school_data_hub_server/src/generated/_features/learning_support/models/support_category.dart'
    as _i23;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_data/dto/pupil_document_type.dart'
    as _i24;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_data/communication/communication_skills.dart'
    as _i25;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_data/communication/tutor_info.dart'
    as _i26;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_data/dto/siblings_tutor_info_dto.dart'
    as _i27;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_data/preschool/pre_school_medical_status.dart'
    as _i28;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_data/communication/public_media_auth.dart'
    as _i29;
import 'package:school_data_hub_server/src/generated/_features/learning_support/models/support_level.dart'
    as _i30;
import 'package:school_data_hub_server/src/generated/_features/school_lists/models/school_list.dart'
    as _i31;
import 'package:school_data_hub_server/src/generated/_features/school_lists/models/pupil_entry.dart'
    as _i32;
import 'package:school_data_hub_server/src/generated/_features/schoolday/models/school_semester.dart'
    as _i33;
import 'package:school_data_hub_server/src/generated/_features/schoolday/models/schoolday.dart'
    as _i34;
import 'package:school_data_hub_server/src/generated/_features/schoolday_events/models/schoolday_event.dart'
    as _i35;
import 'package:school_data_hub_server/src/generated/_features/schoolday_events/models/schoolday_event_type.dart'
    as _i36;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i37;
import 'package:school_data_hub_server/src/generated/_features/user/models/user_device.dart'
    as _i38;
import 'package:school_data_hub_server/src/generated/_features/user/models/device_info.dart'
    as _i39;
import 'package:school_data_hub_server/src/generated/_features/workbooks/models/pupil_workbook.dart'
    as _i40;
import 'package:school_data_hub_server/src/generated/_features/workbooks/models/workbook.dart'
    as _i41;
import 'dart:typed_data' as _i42;
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/generated/endpoints.dart';
export 'package:serverpod_test/serverpod_test_public_exports.dart';

/// Creates a new test group that takes a callback that can be used to write tests.
/// The callback has two parameters: `sessionBuilder` and `endpoints`.
/// `sessionBuilder` is used to build a `Session` object that represents the server state during an endpoint call and is used to set up scenarios.
/// `endpoints` contains all your Serverpod endpoints and lets you call them:
/// ```dart
/// withServerpod('Given Example endpoint', (sessionBuilder, endpoints) {
///   test('when calling `hello` then should return greeting', () async {
///     final greeting = await endpoints.example.hello(sessionBuilder, 'Michael');
///     expect(greeting, 'Hello Michael');
///   });
/// });
/// ```
///
/// **Configuration options**
///
/// [applyMigrations] Whether pending migrations should be applied when starting Serverpod. Defaults to `true`
///
/// [enableSessionLogging] Whether session logging should be enabled. Defaults to `false`
///
/// [rollbackDatabase] Options for when to rollback the database during the test lifecycle.
/// By default `withServerpod` does all database operations inside a transaction that is rolled back after each `test` case.
/// Just like the following enum describes, the behavior of the automatic rollbacks can be configured:
/// ```dart
/// /// Options for when to rollback the database during the test lifecycle.
/// enum RollbackDatabase {
///   /// After each test. This is the default.
///   afterEach,
///
///   /// After all tests.
///   afterAll,
///
///   /// Disable rolling back the database.
///   disabled,
/// }
/// ```
///
/// [runMode] The run mode that Serverpod should be running in. Defaults to `test`.
///
/// [serverpodLoggingMode] The logging mode used when creating Serverpod. Defaults to `ServerpodLoggingMode.normal`
///
/// [serverpodStartTimeout] The timeout to use when starting Serverpod, which connects to the database among other things. Defaults to `Duration(seconds: 30)`.
///
/// [testGroupTagsOverride] By default Serverpod test tools tags the `withServerpod` test group with `"integration"`.
/// This is to provide a simple way to only run unit or integration tests.
/// This property allows this tag to be overridden to something else. Defaults to `['integration']`.
///
/// [experimentalFeatures] Optionally specify experimental features. See [Serverpod] for more information.
@_i1.isTestGroup
void withServerpod(
  String testGroupName,
  _i1.TestClosure<TestEndpoints> testClosure, {
  bool? applyMigrations,
  bool? enableSessionLogging,
  _i2.ExperimentalFeatures? experimentalFeatures,
  _i1.RollbackDatabase? rollbackDatabase,
  String? runMode,
  _i2.ServerpodLoggingMode? serverpodLoggingMode,
  Duration? serverpodStartTimeout,
  List<String>? testGroupTagsOverride,
}) {
  _i1.buildWithServerpod<_InternalTestEndpoints>(
    testGroupName,
    _i1.TestServerpod(
      testEndpoints: _InternalTestEndpoints(),
      endpoints: Endpoints(),
      serializationManager: Protocol(),
      runMode: runMode,
      applyMigrations: applyMigrations,
      isDatabaseEnabled: true,
      serverpodLoggingMode: serverpodLoggingMode,
      experimentalFeatures: experimentalFeatures,
    ),
    maybeRollbackDatabase: rollbackDatabase,
    maybeEnableSessionLogging: enableSessionLogging,
    maybeTestGroupTagsOverride: testGroupTagsOverride,
    maybeServerpodStartTimeout: serverpodStartTimeout,
  )(testClosure);
}

class TestEndpoints {
  late final _AdminEndpoint admin;

  late final _MissedSchooldayEndpoint missedSchoolday;

  late final _AuthorizationEndpoint authorization;

  late final _PupilAuthorizationEndpoint pupilAuthorization;

  late final _BookTagsEndpoint bookTags;

  late final _BooksEndpoint books;

  late final _LibraryBookLocationsEndpoint libraryBookLocations;

  late final _LibraryBooksEndpoint libraryBooks;

  late final _PupilBookLendingEndpoint pupilBookLending;

  late final _CompetenceCheckEndpoint competenceCheck;

  late final _CompetenceEndpoint competence;

  late final _LearningSupportPlanEndpoint learningSupportPlan;

  late final _SupportCategoryEndpoint supportCategory;

  late final _PupilEndpoint pupil;

  late final _PupilUpdateEndpoint pupilUpdate;

  late final _SchoolListEndpoint schoolList;

  late final _SchooldayAdminEndpoint schooldayAdmin;

  late final _SchooldayEndpoint schoolday;

  late final _SchooldayEventEndpoint schooldayEvent;

  late final _AuthEndpoint auth;

  late final _UserEndpoint user;

  late final _PupilWorkbooksEndpoint pupilWorkbooks;

  late final _WorkbooksEndpoint workbooks;

  late final _FilesEndpoint files;
}

class _InternalTestEndpoints extends TestEndpoints
    implements _i1.InternalTestEndpoints {
  @override
  void initialize(
    _i2.SerializationManager serializationManager,
    _i2.EndpointDispatch endpoints,
  ) {
    admin = _AdminEndpoint(
      endpoints,
      serializationManager,
    );
    missedSchoolday = _MissedSchooldayEndpoint(
      endpoints,
      serializationManager,
    );
    authorization = _AuthorizationEndpoint(
      endpoints,
      serializationManager,
    );
    pupilAuthorization = _PupilAuthorizationEndpoint(
      endpoints,
      serializationManager,
    );
    bookTags = _BookTagsEndpoint(
      endpoints,
      serializationManager,
    );
    books = _BooksEndpoint(
      endpoints,
      serializationManager,
    );
    libraryBookLocations = _LibraryBookLocationsEndpoint(
      endpoints,
      serializationManager,
    );
    libraryBooks = _LibraryBooksEndpoint(
      endpoints,
      serializationManager,
    );
    pupilBookLending = _PupilBookLendingEndpoint(
      endpoints,
      serializationManager,
    );
    competenceCheck = _CompetenceCheckEndpoint(
      endpoints,
      serializationManager,
    );
    competence = _CompetenceEndpoint(
      endpoints,
      serializationManager,
    );
    learningSupportPlan = _LearningSupportPlanEndpoint(
      endpoints,
      serializationManager,
    );
    supportCategory = _SupportCategoryEndpoint(
      endpoints,
      serializationManager,
    );
    pupil = _PupilEndpoint(
      endpoints,
      serializationManager,
    );
    pupilUpdate = _PupilUpdateEndpoint(
      endpoints,
      serializationManager,
    );
    schoolList = _SchoolListEndpoint(
      endpoints,
      serializationManager,
    );
    schooldayAdmin = _SchooldayAdminEndpoint(
      endpoints,
      serializationManager,
    );
    schoolday = _SchooldayEndpoint(
      endpoints,
      serializationManager,
    );
    schooldayEvent = _SchooldayEventEndpoint(
      endpoints,
      serializationManager,
    );
    auth = _AuthEndpoint(
      endpoints,
      serializationManager,
    );
    user = _UserEndpoint(
      endpoints,
      serializationManager,
    );
    pupilWorkbooks = _PupilWorkbooksEndpoint(
      endpoints,
      serializationManager,
    );
    workbooks = _WorkbooksEndpoint(
      endpoints,
      serializationManager,
    );
    files = _FilesEndpoint(
      endpoints,
      serializationManager,
    );
  }
}

class _AdminEndpoint {
  _AdminEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i4.User> createUser(
    _i1.TestSessionBuilder sessionBuilder, {
    required String userName,
    required String fullName,
    required String email,
    required String password,
    required _i5.Role role,
    required int timeUnits,
    required List<String> scopeNames,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'admin',
        method: 'createUser',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'createUser',
          parameters: _i1.testObjectToJson({
            'userName': userName,
            'fullName': fullName,
            'email': email,
            'password': password,
            'role': role,
            'timeUnits': timeUnits,
            'scopeNames': scopeNames,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i4.User>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> deleteUser(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'admin',
        method: 'deleteUser',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'deleteUser',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> promoteUserScope(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
    String scopeName,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'admin',
        method: 'promoteUserScope',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'promoteUserScope',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'scopeName': scopeName,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> demoteUserScope(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
    String scopeName,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'admin',
        method: 'demoteUserScope',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'demoteUserScope',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'scopeName': scopeName,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i4.User>> getAllUsers(
      _i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'admin',
        method: 'getAllUsers',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'getAllUsers',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i4.User>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i4.User?> getUserById(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'admin',
        method: 'getUserById',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'getUserById',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i4.User?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Set<_i6.PupilData>> updateBackendPupilDataState(
    _i1.TestSessionBuilder sessionBuilder,
    String filePath,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'admin',
        method: 'updateBackendPupilDataState',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'updateBackendPupilDataState',
          parameters: _i1.testObjectToJson({'filePath': filePath}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<Set<_i6.PupilData>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _MissedSchooldayEndpoint {
  _MissedSchooldayEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Stream<_i7.MissedSchooldayDto> streamMyModels(
      _i1.TestSessionBuilder sessionBuilder) {
    var _localTestStreamManager =
        _i1.TestStreamManager<_i7.MissedSchooldayDto>();
    _i1.callStreamFunctionAndHandleExceptions(
      () async {
        var _localUniqueSession =
            (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
          endpoint: 'missedSchoolday',
          method: 'streamMyModels',
        );
        var _localCallContext =
            await _endpointDispatch.getMethodStreamCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'missedSchoolday',
          methodName: 'streamMyModels',
          arguments: {},
          requestedInputStreams: [],
          serializationManager: _serializationManager,
        );
        await _localTestStreamManager.callStreamMethod(
          _localCallContext,
          _localUniqueSession,
          {},
        );
      },
      _localTestStreamManager.outputStreamController,
    );
    return _localTestStreamManager.outputStreamController.stream;
  }

  _i3.Future<_i8.MissedSchoolday> postMissedSchoolday(
    _i1.TestSessionBuilder sessionBuilder,
    _i8.MissedSchoolday missedClass,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'missedSchoolday',
        method: 'postMissedSchoolday',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'missedSchoolday',
          methodName: 'postMissedSchoolday',
          parameters: _i1.testObjectToJson({'missedClass': missedClass}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i8.MissedSchoolday>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i8.MissedSchoolday>> postMissedSchooldayes(
    _i1.TestSessionBuilder sessionBuilder,
    List<_i8.MissedSchoolday> missedClasses,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'missedSchoolday',
        method: 'postMissedSchooldayes',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'missedSchoolday',
          methodName: 'postMissedSchooldayes',
          parameters: _i1.testObjectToJson({'missedClasses': missedClasses}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i8.MissedSchoolday>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i8.MissedSchoolday>> fetchAllMissedSchooldayes(
      _i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'missedSchoolday',
        method: 'fetchAllMissedSchooldayes',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'missedSchoolday',
          methodName: 'fetchAllMissedSchooldayes',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i8.MissedSchoolday>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i8.MissedSchoolday>> fetchMissedSchooldayesOnASchoolday(
    _i1.TestSessionBuilder sessionBuilder,
    DateTime schoolday,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'missedSchoolday',
        method: 'fetchMissedSchooldayesOnASchoolday',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'missedSchoolday',
          methodName: 'fetchMissedSchooldayesOnASchoolday',
          parameters: _i1.testObjectToJson({'schoolday': schoolday}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i8.MissedSchoolday>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteMissedSchoolday(
    _i1.TestSessionBuilder sessionBuilder,
    int pupilId,
    int schooldayId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'missedSchoolday',
        method: 'deleteMissedSchoolday',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'missedSchoolday',
          methodName: 'deleteMissedSchoolday',
          parameters: _i1.testObjectToJson({
            'pupilId': pupilId,
            'schooldayId': schooldayId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i8.MissedSchoolday> updateMissedSchoolday(
    _i1.TestSessionBuilder sessionBuilder,
    _i8.MissedSchoolday missedSchoolday,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'missedSchoolday',
        method: 'updateMissedSchoolday',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'missedSchoolday',
          methodName: 'updateMissedSchoolday',
          parameters:
              _i1.testObjectToJson({'missedSchoolday': missedSchoolday}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i8.MissedSchoolday>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AuthorizationEndpoint {
  _AuthorizationEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i9.Authorization>> fetchAuthorizations(
      _i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'authorization',
        method: 'fetchAuthorizations',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'authorization',
          methodName: 'fetchAuthorizations',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i9.Authorization>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i9.Authorization?> fetchAuthorizationById(
    _i1.TestSessionBuilder sessionBuilder,
    int id,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'authorization',
        method: 'fetchAuthorizationById',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'authorization',
          methodName: 'fetchAuthorizationById',
          parameters: _i1.testObjectToJson({'id': id}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i9.Authorization?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i9.Authorization> postAuthorizationWithPupils(
    _i1.TestSessionBuilder sessionBuilder,
    String name,
    String description,
    String createdBy,
    List<int> pupilIds,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'authorization',
        method: 'postAuthorizationWithPupils',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'authorization',
          methodName: 'postAuthorizationWithPupils',
          parameters: _i1.testObjectToJson({
            'name': name,
            'description': description,
            'createdBy': createdBy,
            'pupilIds': pupilIds,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i9.Authorization>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i9.Authorization> updateAuthorization(
    _i1.TestSessionBuilder sessionBuilder,
    int authId,
    String? name,
    String? description,
    ({_i10.MemberOperation operation, List<int> pupilIds})? updateMembers,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'authorization',
        method: 'updateAuthorization',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'authorization',
          methodName: 'updateAuthorization',
          parameters: _i1.testObjectToJson({
            'authId': authId,
            'name': name,
            'description': description,
            'updateMembers': _i11.mapRecordToJson(updateMembers),
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i9.Authorization>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteAuthorization(
    _i1.TestSessionBuilder sessionBuilder,
    int authId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'authorization',
        method: 'deleteAuthorization',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'authorization',
          methodName: 'deleteAuthorization',
          parameters: _i1.testObjectToJson({'authId': authId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _PupilAuthorizationEndpoint {
  _PupilAuthorizationEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i12.PupilAuthorization> updatePupilAuthorization(
    _i1.TestSessionBuilder sessionBuilder,
    _i12.PupilAuthorization authorization,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupilAuthorization',
        method: 'updatePupilAuthorization',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupilAuthorization',
          methodName: 'updatePupilAuthorization',
          parameters: _i1.testObjectToJson({'authorization': authorization}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i12.PupilAuthorization>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i12.PupilAuthorization> addFileToPupilAuthorization(
    _i1.TestSessionBuilder sessionBuilder,
    int pupilAuthId,
    String filePath,
    String createdBy,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupilAuthorization',
        method: 'addFileToPupilAuthorization',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupilAuthorization',
          methodName: 'addFileToPupilAuthorization',
          parameters: _i1.testObjectToJson({
            'pupilAuthId': pupilAuthId,
            'filePath': filePath,
            'createdBy': createdBy,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i12.PupilAuthorization>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i12.PupilAuthorization> removeFileFromPupilAuthorization(
    _i1.TestSessionBuilder sessionBuilder,
    int pupilAuthId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupilAuthorization',
        method: 'removeFileFromPupilAuthorization',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupilAuthorization',
          methodName: 'removeFileFromPupilAuthorization',
          parameters: _i1.testObjectToJson({'pupilAuthId': pupilAuthId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i12.PupilAuthorization>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _BookTagsEndpoint {
  _BookTagsEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i13.BookTag> postBookTag(
    _i1.TestSessionBuilder sessionBuilder,
    _i13.BookTag bookTag,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'bookTags',
        method: 'postBookTag',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'bookTags',
          methodName: 'postBookTag',
          parameters: _i1.testObjectToJson({'bookTag': bookTag}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i13.BookTag>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i13.BookTag>> fetchBookTags(
      _i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'bookTags',
        method: 'fetchBookTags',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'bookTags',
          methodName: 'fetchBookTags',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i13.BookTag>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i13.BookTag> updateBookTag(
    _i1.TestSessionBuilder sessionBuilder,
    _i13.BookTag bookTag,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'bookTags',
        method: 'updateBookTag',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'bookTags',
          methodName: 'updateBookTag',
          parameters: _i1.testObjectToJson({'bookTag': bookTag}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i13.BookTag>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteBookTag(
    _i1.TestSessionBuilder sessionBuilder,
    _i13.BookTag bookTag,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'bookTags',
        method: 'deleteBookTag',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'bookTags',
          methodName: 'deleteBookTag',
          parameters: _i1.testObjectToJson({'bookTag': bookTag}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _BooksEndpoint {
  _BooksEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i14.Book> postBook(
    _i1.TestSessionBuilder sessionBuilder,
    _i14.Book book,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'books',
        method: 'postBook',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'books',
          methodName: 'postBook',
          parameters: _i1.testObjectToJson({'book': book}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i14.Book>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i14.Book>> fetchBooks(
      _i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'books',
        method: 'fetchBooks',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'books',
          methodName: 'fetchBooks',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i14.Book>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i14.Book?> fetchBookByIsbn(
    _i1.TestSessionBuilder sessionBuilder,
    int isbn,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'books',
        method: 'fetchBookByIsbn',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'books',
          methodName: 'fetchBookByIsbn',
          parameters: _i1.testObjectToJson({'isbn': isbn}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i14.Book?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i14.Book> updateBook(
    _i1.TestSessionBuilder sessionBuilder,
    _i14.Book book,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'books',
        method: 'updateBook',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'books',
          methodName: 'updateBook',
          parameters: _i1.testObjectToJson({'book': book}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i14.Book>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i14.Book> updateBookTags(
    _i1.TestSessionBuilder sessionBuilder,
    _i14.Book book,
    List<_i13.BookTag> tags,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'books',
        method: 'updateBookTags',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'books',
          methodName: 'updateBookTags',
          parameters: _i1.testObjectToJson({
            'book': book,
            'tags': tags,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i14.Book>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteBook(
    _i1.TestSessionBuilder sessionBuilder,
    int id,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'books',
        method: 'deleteBook',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'books',
          methodName: 'deleteBook',
          parameters: _i1.testObjectToJson({'id': id}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _LibraryBookLocationsEndpoint {
  _LibraryBookLocationsEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i15.LibraryBookLocation> postLibraryBookLocation(
    _i1.TestSessionBuilder sessionBuilder,
    _i15.LibraryBookLocation libraryBookLocation,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'libraryBookLocations',
        method: 'postLibraryBookLocation',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'libraryBookLocations',
          methodName: 'postLibraryBookLocation',
          parameters: _i1
              .testObjectToJson({'libraryBookLocation': libraryBookLocation}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i15.LibraryBookLocation>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i15.LibraryBookLocation>> fetchLibraryBookLocations(
      _i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'libraryBookLocations',
        method: 'fetchLibraryBookLocations',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'libraryBookLocations',
          methodName: 'fetchLibraryBookLocations',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i15.LibraryBookLocation>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i15.LibraryBookLocation> updateLibraryBookLocation(
    _i1.TestSessionBuilder sessionBuilder,
    _i15.LibraryBookLocation libraryBookLocation,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'libraryBookLocations',
        method: 'updateLibraryBookLocation',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'libraryBookLocations',
          methodName: 'updateLibraryBookLocation',
          parameters: _i1
              .testObjectToJson({'libraryBookLocation': libraryBookLocation}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i15.LibraryBookLocation>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteLibraryBookLocation(
    _i1.TestSessionBuilder sessionBuilder,
    _i15.LibraryBookLocation location,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'libraryBookLocations',
        method: 'deleteLibraryBookLocation',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'libraryBookLocations',
          methodName: 'deleteLibraryBookLocation',
          parameters: _i1.testObjectToJson({'location': location}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _LibraryBooksEndpoint {
  _LibraryBooksEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i16.LibraryBook> postLibraryBook(
    _i1.TestSessionBuilder sessionBuilder,
    int isbn,
    String libraryId,
    _i15.LibraryBookLocation location,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'libraryBooks',
        method: 'postLibraryBook',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'libraryBooks',
          methodName: 'postLibraryBook',
          parameters: _i1.testObjectToJson({
            'isbn': isbn,
            'libraryId': libraryId,
            'location': location,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i16.LibraryBook>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i16.LibraryBook>> fetchLibraryBooks(
      _i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'libraryBooks',
        method: 'fetchLibraryBooks',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'libraryBooks',
          methodName: 'fetchLibraryBooks',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i16.LibraryBook>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i16.LibraryBook?> fetchLibraryBookByIsbn(
    _i1.TestSessionBuilder sessionBuilder,
    int isbn,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'libraryBooks',
        method: 'fetchLibraryBookByIsbn',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'libraryBooks',
          methodName: 'fetchLibraryBookByIsbn',
          parameters: _i1.testObjectToJson({'isbn': isbn}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i16.LibraryBook?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i16.LibraryBook?> fetchLibraryBookByLibraryId(
    _i1.TestSessionBuilder sessionBuilder,
    String libraryId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'libraryBooks',
        method: 'fetchLibraryBookByLibraryId',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'libraryBooks',
          methodName: 'fetchLibraryBookByLibraryId',
          parameters: _i1.testObjectToJson({'libraryId': libraryId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i16.LibraryBook?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i16.LibraryBook>> fetchLibraryBooksMatchingQuery(
    _i1.TestSessionBuilder sessionBuilder,
    _i17.LibraryBookQuery libraryBookQuery,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'libraryBooks',
        method: 'fetchLibraryBooksMatchingQuery',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'libraryBooks',
          methodName: 'fetchLibraryBooksMatchingQuery',
          parameters:
              _i1.testObjectToJson({'libraryBookQuery': libraryBookQuery}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i16.LibraryBook>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i16.LibraryBook> updateLibraryBook(
    _i1.TestSessionBuilder sessionBuilder,
    int isbn,
    String libraryId,
    bool? available,
    _i15.LibraryBookLocation? location,
    String? title,
    String? author,
    String? description,
    String? readingLevel,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'libraryBooks',
        method: 'updateLibraryBook',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'libraryBooks',
          methodName: 'updateLibraryBook',
          parameters: _i1.testObjectToJson({
            'isbn': isbn,
            'libraryId': libraryId,
            'available': available,
            'location': location,
            'title': title,
            'author': author,
            'description': description,
            'readingLevel': readingLevel,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i16.LibraryBook>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteLibraryBook(
    _i1.TestSessionBuilder sessionBuilder,
    int libraryBookId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'libraryBooks',
        method: 'deleteLibraryBook',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'libraryBooks',
          methodName: 'deleteLibraryBook',
          parameters: _i1.testObjectToJson({'libraryBookId': libraryBookId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _PupilBookLendingEndpoint {
  _PupilBookLendingEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i6.PupilData> postPupilBookLending(
    _i1.TestSessionBuilder sessionBuilder,
    int pupilId,
    String libraryId,
    String lentBy,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupilBookLending',
        method: 'postPupilBookLending',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupilBookLending',
          methodName: 'postPupilBookLending',
          parameters: _i1.testObjectToJson({
            'pupilId': pupilId,
            'libraryId': libraryId,
            'lentBy': lentBy,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i6.PupilData>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i18.PupilBookLending>> fetchPupilBookLendings(
      _i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupilBookLending',
        method: 'fetchPupilBookLendings',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupilBookLending',
          methodName: 'fetchPupilBookLendings',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i18.PupilBookLending>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i18.PupilBookLending?> fetchPupilBookLendingById(
    _i1.TestSessionBuilder sessionBuilder,
    int id,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupilBookLending',
        method: 'fetchPupilBookLendingById',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupilBookLending',
          methodName: 'fetchPupilBookLendingById',
          parameters: _i1.testObjectToJson({'id': id}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i18.PupilBookLending?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.PupilData> updatePupilBookLending(
    _i1.TestSessionBuilder sessionBuilder,
    _i18.PupilBookLending pupilBookLending,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupilBookLending',
        method: 'updatePupilBookLending',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupilBookLending',
          methodName: 'updatePupilBookLending',
          parameters:
              _i1.testObjectToJson({'pupilBookLending': pupilBookLending}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i6.PupilData>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.PupilData> deletePupilBookLending(
    _i1.TestSessionBuilder sessionBuilder,
    int id,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupilBookLending',
        method: 'deletePupilBookLending',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupilBookLending',
          methodName: 'deletePupilBookLending',
          parameters: _i1.testObjectToJson({'id': id}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i6.PupilData>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _CompetenceCheckEndpoint {
  _CompetenceCheckEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i6.PupilData> postCompetenceCheck(
    _i1.TestSessionBuilder sessionBuilder, {
    required int competenceId,
    required int pupilId,
    required int score,
    String? comment,
    required double valueFactor,
    required String createdBy,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'competenceCheck',
        method: 'postCompetenceCheck',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'competenceCheck',
          methodName: 'postCompetenceCheck',
          parameters: _i1.testObjectToJson({
            'competenceId': competenceId,
            'pupilId': pupilId,
            'score': score,
            'comment': comment,
            'valueFactor': valueFactor,
            'createdBy': createdBy,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i6.PupilData>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _CompetenceEndpoint {
  _CompetenceEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i19.Competence>> importCompetencesFromJsonFile(
    _i1.TestSessionBuilder sessionBuilder,
    _i20.File jsonFile,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'competence',
        method: 'importCompetencesFromJsonFile',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'competence',
          methodName: 'importCompetencesFromJsonFile',
          parameters: _i1.testObjectToJson({'jsonFile': jsonFile}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i19.Competence>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i19.Competence> postCompetence(
    _i1.TestSessionBuilder sessionBuilder, {
    int? parentCompetence,
    required String name,
    required List<String> level,
    required List<String> indicators,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'competence',
        method: 'postCompetence',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'competence',
          methodName: 'postCompetence',
          parameters: _i1.testObjectToJson({
            'parentCompetence': parentCompetence,
            'name': name,
            'level': level,
            'indicators': indicators,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i19.Competence>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i19.Competence>> getAllCompetences(
      _i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'competence',
        method: 'getAllCompetences',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'competence',
          methodName: 'getAllCompetences',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i19.Competence>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i19.Competence> updateCompetence(
    _i1.TestSessionBuilder sessionBuilder,
    _i19.Competence competence,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'competence',
        method: 'updateCompetence',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'competence',
          methodName: 'updateCompetence',
          parameters: _i1.testObjectToJson({'competence': competence}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i19.Competence>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteCompetence(
    _i1.TestSessionBuilder sessionBuilder,
    int publicId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'competence',
        method: 'deleteCompetence',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'competence',
          methodName: 'deleteCompetence',
          parameters: _i1.testObjectToJson({'publicId': publicId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _LearningSupportPlanEndpoint {
  _LearningSupportPlanEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i21.LearningSupportPlan>> fetchLearningSupportPlans(
      _i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'learningSupportPlan',
        method: 'fetchLearningSupportPlans',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'learningSupportPlan',
          methodName: 'fetchLearningSupportPlans',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i21.LearningSupportPlan>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> createLearningSupportPlan(
    _i1.TestSessionBuilder sessionBuilder,
    _i21.LearningSupportPlan plan,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'learningSupportPlan',
        method: 'createLearningSupportPlan',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'learningSupportPlan',
          methodName: 'createLearningSupportPlan',
          parameters: _i1.testObjectToJson({'plan': plan}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> updateLearningSupportPlan(
    _i1.TestSessionBuilder sessionBuilder,
    _i21.LearningSupportPlan plan,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'learningSupportPlan',
        method: 'updateLearningSupportPlan',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'learningSupportPlan',
          methodName: 'updateLearningSupportPlan',
          parameters: _i1.testObjectToJson({'plan': plan}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteLearningSupportPlan(
    _i1.TestSessionBuilder sessionBuilder,
    _i21.LearningSupportPlan plan,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'learningSupportPlan',
        method: 'deleteLearningSupportPlan',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'learningSupportPlan',
          methodName: 'deleteLearningSupportPlan',
          parameters: _i1.testObjectToJson({'plan': plan}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.PupilData> postSupportCategoryStatus(
    _i1.TestSessionBuilder sessionBuilder,
    int pupilId,
    int supportCategoryId,
    int learningSupportPlanId,
    int status,
    String comment,
    String createdBy,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'learningSupportPlan',
        method: 'postSupportCategoryStatus',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'learningSupportPlan',
          methodName: 'postSupportCategoryStatus',
          parameters: _i1.testObjectToJson({
            'pupilId': pupilId,
            'supportCategoryId': supportCategoryId,
            'learningSupportPlanId': learningSupportPlanId,
            'status': status,
            'comment': comment,
            'createdBy': createdBy,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i6.PupilData>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i22.SupportCategoryStatus>> fetchSupportCategoryStatus(
    _i1.TestSessionBuilder sessionBuilder,
    int pupilId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'learningSupportPlan',
        method: 'fetchSupportCategoryStatus',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'learningSupportPlan',
          methodName: 'fetchSupportCategoryStatus',
          parameters: _i1.testObjectToJson({'pupilId': pupilId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i22.SupportCategoryStatus>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i22.SupportCategoryStatus>>
      fetchSupportCategoryStatusFromPupil(
    _i1.TestSessionBuilder sessionBuilder,
    int pupilId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'learningSupportPlan',
        method: 'fetchSupportCategoryStatusFromPupil',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'learningSupportPlan',
          methodName: 'fetchSupportCategoryStatusFromPupil',
          parameters: _i1.testObjectToJson({'pupilId': pupilId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i22.SupportCategoryStatus>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i22.SupportCategoryStatus> updateCategoryStatus(
    _i1.TestSessionBuilder sessionBuilder,
    int pupilId,
    int supportCategoryId,
    int? status,
    String? comment,
    String? createdBy,
    DateTime? createdAt,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'learningSupportPlan',
        method: 'updateCategoryStatus',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'learningSupportPlan',
          methodName: 'updateCategoryStatus',
          parameters: _i1.testObjectToJson({
            'pupilId': pupilId,
            'supportCategoryId': supportCategoryId,
            'status': status,
            'comment': comment,
            'createdBy': createdBy,
            'createdAt': createdAt,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i22.SupportCategoryStatus>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.PupilData> deleteSupportCategoryStatus(
    _i1.TestSessionBuilder sessionBuilder,
    int pupilId,
    int statusId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'learningSupportPlan',
        method: 'deleteSupportCategoryStatus',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'learningSupportPlan',
          methodName: 'deleteSupportCategoryStatus',
          parameters: _i1.testObjectToJson({
            'pupilId': pupilId,
            'statusId': statusId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i6.PupilData>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.PupilData> postCategoryGoal(
    _i1.TestSessionBuilder sessionBuilder,
    int pupilId,
    int supportCategoryId,
    String description,
    String strategies,
    String createdBy,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'learningSupportPlan',
        method: 'postCategoryGoal',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'learningSupportPlan',
          methodName: 'postCategoryGoal',
          parameters: _i1.testObjectToJson({
            'pupilId': pupilId,
            'supportCategoryId': supportCategoryId,
            'description': description,
            'strategies': strategies,
            'createdBy': createdBy,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i6.PupilData>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _SupportCategoryEndpoint {
  _SupportCategoryEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i23.SupportCategory>> fetchSupportCategories(
      _i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'supportCategory',
        method: 'fetchSupportCategories',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'supportCategory',
          methodName: 'fetchSupportCategories',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i23.SupportCategory>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i23.SupportCategory>> importSupportCategoriesFromJsonFile(
    _i1.TestSessionBuilder sessionBuilder,
    String jsonFilePath,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'supportCategory',
        method: 'importSupportCategoriesFromJsonFile',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'supportCategory',
          methodName: 'importSupportCategoriesFromJsonFile',
          parameters: _i1.testObjectToJson({'jsonFilePath': jsonFilePath}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i23.SupportCategory>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> createSupportCategory(
    _i1.TestSessionBuilder sessionBuilder,
    _i23.SupportCategory category,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'supportCategory',
        method: 'createSupportCategory',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'supportCategory',
          methodName: 'createSupportCategory',
          parameters: _i1.testObjectToJson({'category': category}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> updateSupportCategory(
    _i1.TestSessionBuilder sessionBuilder,
    _i23.SupportCategory category,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'supportCategory',
        method: 'updateSupportCategory',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'supportCategory',
          methodName: 'updateSupportCategory',
          parameters: _i1.testObjectToJson({'category': category}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteSupportCategory(
    _i1.TestSessionBuilder sessionBuilder,
    _i23.SupportCategory category,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'supportCategory',
        method: 'deleteSupportCategory',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'supportCategory',
          methodName: 'deleteSupportCategory',
          parameters: _i1.testObjectToJson({'category': category}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _PupilEndpoint {
  _PupilEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Stream<List<_i6.PupilData>> fetchPupilsAsStream(
      _i1.TestSessionBuilder sessionBuilder) {
    var _localTestStreamManager = _i1.TestStreamManager<List<_i6.PupilData>>();
    _i1.callStreamFunctionAndHandleExceptions(
      () async {
        var _localUniqueSession =
            (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
          endpoint: 'pupil',
          method: 'fetchPupilsAsStream',
        );
        var _localCallContext =
            await _endpointDispatch.getMethodStreamCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupil',
          methodName: 'fetchPupilsAsStream',
          arguments: {},
          requestedInputStreams: [],
          serializationManager: _serializationManager,
        );
        await _localTestStreamManager.callStreamMethod(
          _localCallContext,
          _localUniqueSession,
          {},
        );
      },
      _localTestStreamManager.outputStreamController,
    );
    return _localTestStreamManager.outputStreamController.stream;
  }

  _i3.Future<List<_i6.PupilData>> fetchPupils(
      _i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupil',
        method: 'fetchPupils',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupil',
          methodName: 'fetchPupils',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i6.PupilData>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i6.PupilData>> fetchPupilsById(
    _i1.TestSessionBuilder sessionBuilder,
    Set<int> internalIds,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupil',
        method: 'fetchPupilsById',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupil',
          methodName: 'fetchPupilsById',
          parameters: _i1.testObjectToJson({'internalIds': internalIds}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i6.PupilData>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.PupilData> deletePupilDocument(
    _i1.TestSessionBuilder sessionBuilder,
    int pupilId,
    _i24.PupilDocumentType documentType,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupil',
        method: 'deletePupilDocument',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupil',
          methodName: 'deletePupilDocument',
          parameters: _i1.testObjectToJson({
            'pupilId': pupilId,
            'documentType': documentType,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i6.PupilData>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.PupilData> resetPublicMediaAuth(
    _i1.TestSessionBuilder sessionBuilder,
    int pupilId,
    String createdBy,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupil',
        method: 'resetPublicMediaAuth',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupil',
          methodName: 'resetPublicMediaAuth',
          parameters: _i1.testObjectToJson({
            'pupilId': pupilId,
            'createdBy': createdBy,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i6.PupilData>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.PupilData> deleteSupportLevelHistoryItem(
    _i1.TestSessionBuilder sessionBuilder,
    int pupilId,
    int supportLevelId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupil',
        method: 'deleteSupportLevelHistoryItem',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupil',
          methodName: 'deleteSupportLevelHistoryItem',
          parameters: _i1.testObjectToJson({
            'pupilId': pupilId,
            'supportLevelId': supportLevelId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i6.PupilData>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _PupilUpdateEndpoint {
  _PupilUpdateEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i6.PupilData> updatePupil(
    _i1.TestSessionBuilder sessionBuilder,
    _i6.PupilData pupil,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupilUpdate',
        method: 'updatePupil',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupilUpdate',
          methodName: 'updatePupil',
          parameters: _i1.testObjectToJson({'pupil': pupil}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i6.PupilData>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.PupilData> updateCommunicationSkills(
    _i1.TestSessionBuilder sessionBuilder, {
    required int pupilId,
    required _i25.CommunicationSkills? communicationSkills,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupilUpdate',
        method: 'updateCommunicationSkills',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupilUpdate',
          methodName: 'updateCommunicationSkills',
          parameters: _i1.testObjectToJson({
            'pupilId': pupilId,
            'communicationSkills': communicationSkills,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i6.PupilData>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.PupilData> updateTutorInfo(
    _i1.TestSessionBuilder sessionBuilder,
    int pupilId,
    _i26.TutorInfo? tutorInfo,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupilUpdate',
        method: 'updateTutorInfo',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupilUpdate',
          methodName: 'updateTutorInfo',
          parameters: _i1.testObjectToJson({
            'pupilId': pupilId,
            'tutorInfo': tutorInfo,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i6.PupilData>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i6.PupilData>> updateSiblingsTutorInfo(
    _i1.TestSessionBuilder sessionBuilder,
    _i27.SiblingsTutorInfo siblingsTutorInfo,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupilUpdate',
        method: 'updateSiblingsTutorInfo',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupilUpdate',
          methodName: 'updateSiblingsTutorInfo',
          parameters:
              _i1.testObjectToJson({'siblingsTutorInfo': siblingsTutorInfo}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i6.PupilData>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.PupilData> updatePupilDocument(
    _i1.TestSessionBuilder sessionBuilder,
    int pupilId,
    String filePath,
    String createdBy,
    _i24.PupilDocumentType documentType,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupilUpdate',
        method: 'updatePupilDocument',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupilUpdate',
          methodName: 'updatePupilDocument',
          parameters: _i1.testObjectToJson({
            'pupilId': pupilId,
            'filePath': filePath,
            'createdBy': createdBy,
            'documentType': documentType,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i6.PupilData>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.PupilData> updateStringProperty(
    _i1.TestSessionBuilder sessionBuilder,
    int pupilId,
    String property,
    String? value,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupilUpdate',
        method: 'updateStringProperty',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupilUpdate',
          methodName: 'updateStringProperty',
          parameters: _i1.testObjectToJson({
            'pupilId': pupilId,
            'property': property,
            'value': value,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i6.PupilData>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.PupilData> updateCredit(
    _i1.TestSessionBuilder sessionBuilder,
    int pupilId,
    int value,
    String? description,
    String sender,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupilUpdate',
        method: 'updateCredit',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupilUpdate',
          methodName: 'updateCredit',
          parameters: _i1.testObjectToJson({
            'pupilId': pupilId,
            'value': value,
            'description': description,
            'sender': sender,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i6.PupilData>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.PupilData> updatePreSchoolMedicalStatus(
    _i1.TestSessionBuilder sessionBuilder,
    int pupilId,
    _i28.PreSchoolMedicalStatus preSchoolMedicalStatus,
    String updatedBy,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupilUpdate',
        method: 'updatePreSchoolMedicalStatus',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupilUpdate',
          methodName: 'updatePreSchoolMedicalStatus',
          parameters: _i1.testObjectToJson({
            'pupilId': pupilId,
            'preSchoolMedicalStatus': preSchoolMedicalStatus,
            'updatedBy': updatedBy,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i6.PupilData>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.PupilData> updatePublicMediaAuth(
    _i1.TestSessionBuilder sessionBuilder,
    int pupilId,
    _i29.PublicMediaAuth publicMediaAuth,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupilUpdate',
        method: 'updatePublicMediaAuth',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupilUpdate',
          methodName: 'updatePublicMediaAuth',
          parameters: _i1.testObjectToJson({
            'pupilId': pupilId,
            'publicMediaAuth': publicMediaAuth,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i6.PupilData>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.PupilData> updateSupportLevel(
    _i1.TestSessionBuilder sessionBuilder,
    _i30.SupportLevel supportLevel,
    int pupilId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupilUpdate',
        method: 'updateSupportLevel',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupilUpdate',
          methodName: 'updateSupportLevel',
          parameters: _i1.testObjectToJson({
            'supportLevel': supportLevel,
            'pupilId': pupilId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i6.PupilData>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.PupilData> updateSchoolyearHeldBackDate(
    _i1.TestSessionBuilder sessionBuilder,
    int pupilId,
    ({DateTime? value}) schoolyearHeldBackDate,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupilUpdate',
        method: 'updateSchoolyearHeldBackDate',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupilUpdate',
          methodName: 'updateSchoolyearHeldBackDate',
          parameters: _i1.testObjectToJson({
            'pupilId': pupilId,
            'schoolyearHeldBackDate':
                _i11.mapRecordToJson(schoolyearHeldBackDate),
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i6.PupilData>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _SchoolListEndpoint {
  _SchoolListEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i31.SchoolList>> fetchSchoolLists(
    _i1.TestSessionBuilder sessionBuilder,
    String userName,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'schoolList',
        method: 'fetchSchoolLists',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'schoolList',
          methodName: 'fetchSchoolLists',
          parameters: _i1.testObjectToJson({'userName': userName}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i31.SchoolList>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i31.SchoolList> postSchoolList(
    _i1.TestSessionBuilder sessionBuilder,
    String name,
    String description,
    List<int> pupilIds,
    bool public,
    String createdBy,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'schoolList',
        method: 'postSchoolList',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'schoolList',
          methodName: 'postSchoolList',
          parameters: _i1.testObjectToJson({
            'name': name,
            'description': description,
            'pupilIds': pupilIds,
            'public': public,
            'createdBy': createdBy,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i31.SchoolList>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i31.SchoolList> updateSchoolList(
    _i1.TestSessionBuilder sessionBuilder,
    int listId,
    String? name,
    String? description,
    bool? public,
    ({_i10.MemberOperation operation, List<int> pupilIds})? updateMembers,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'schoolList',
        method: 'updateSchoolList',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'schoolList',
          methodName: 'updateSchoolList',
          parameters: _i1.testObjectToJson({
            'listId': listId,
            'name': name,
            'description': description,
            'public': public,
            'updateMembers': _i11.mapRecordToJson(updateMembers),
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i31.SchoolList>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteSchoolList(
    _i1.TestSessionBuilder sessionBuilder,
    int listId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'schoolList',
        method: 'deleteSchoolList',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'schoolList',
          methodName: 'deleteSchoolList',
          parameters: _i1.testObjectToJson({'listId': listId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i32.PupilListEntry> updatePupilListEntry(
    _i1.TestSessionBuilder sessionBuilder,
    _i32.PupilListEntry entry,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'schoolList',
        method: 'updatePupilListEntry',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'schoolList',
          methodName: 'updatePupilListEntry',
          parameters: _i1.testObjectToJson({'entry': entry}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i32.PupilListEntry>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _SchooldayAdminEndpoint {
  _SchooldayAdminEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i33.SchoolSemester> createSchoolSemester(
    _i1.TestSessionBuilder sessionBuilder,
    DateTime startDate,
    DateTime endDate,
    bool isFirst,
    DateTime classConferenceDate,
    DateTime supportConferenceDate,
    DateTime reportSignedDate,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'schooldayAdmin',
        method: 'createSchoolSemester',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'schooldayAdmin',
          methodName: 'createSchoolSemester',
          parameters: _i1.testObjectToJson({
            'startDate': startDate,
            'endDate': endDate,
            'isFirst': isFirst,
            'classConferenceDate': classConferenceDate,
            'supportConferenceDate': supportConferenceDate,
            'reportSignedDate': reportSignedDate,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i33.SchoolSemester>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i33.SchoolSemester>> getAllSchoolSemesters(
      _i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'schooldayAdmin',
        method: 'getAllSchoolSemesters',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'schooldayAdmin',
          methodName: 'getAllSchoolSemesters',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i33.SchoolSemester>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i33.SchoolSemester?> getCurrentSchoolSemester(
      _i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'schooldayAdmin',
        method: 'getCurrentSchoolSemester',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'schooldayAdmin',
          methodName: 'getCurrentSchoolSemester',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i33.SchoolSemester?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> updateSchoolSemester(
    _i1.TestSessionBuilder sessionBuilder,
    _i33.SchoolSemester schoolSemester,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'schooldayAdmin',
        method: 'updateSchoolSemester',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'schooldayAdmin',
          methodName: 'updateSchoolSemester',
          parameters: _i1.testObjectToJson({'schoolSemester': schoolSemester}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteSchoolSemester(
    _i1.TestSessionBuilder sessionBuilder,
    _i33.SchoolSemester semester,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'schooldayAdmin',
        method: 'deleteSchoolSemester',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'schooldayAdmin',
          methodName: 'deleteSchoolSemester',
          parameters: _i1.testObjectToJson({'semester': semester}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i34.Schoolday?> createSchoolday(
    _i1.TestSessionBuilder sessionBuilder,
    DateTime date,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'schooldayAdmin',
        method: 'createSchoolday',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'schooldayAdmin',
          methodName: 'createSchoolday',
          parameters: _i1.testObjectToJson({'date': date}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i34.Schoolday?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i34.Schoolday>> createSchooldays(
    _i1.TestSessionBuilder sessionBuilder,
    List<DateTime> dates,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'schooldayAdmin',
        method: 'createSchooldays',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'schooldayAdmin',
          methodName: 'createSchooldays',
          parameters: _i1.testObjectToJson({'dates': dates}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i34.Schoolday>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteSchoolday(
    _i1.TestSessionBuilder sessionBuilder,
    DateTime date,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'schooldayAdmin',
        method: 'deleteSchoolday',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'schooldayAdmin',
          methodName: 'deleteSchoolday',
          parameters: _i1.testObjectToJson({'date': date}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> updateSchoolday(
    _i1.TestSessionBuilder sessionBuilder,
    _i34.Schoolday schoolday,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'schooldayAdmin',
        method: 'updateSchoolday',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'schooldayAdmin',
          methodName: 'updateSchoolday',
          parameters: _i1.testObjectToJson({'schoolday': schoolday}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _SchooldayEndpoint {
  _SchooldayEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i33.SchoolSemester>> getSchoolSemesters(
      _i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'schoolday',
        method: 'getSchoolSemesters',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'schoolday',
          methodName: 'getSchoolSemesters',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i33.SchoolSemester>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i34.Schoolday>> getSchooldays(
      _i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'schoolday',
        method: 'getSchooldays',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'schoolday',
          methodName: 'getSchooldays',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i34.Schoolday>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _SchooldayEventEndpoint {
  _SchooldayEventEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i35.SchooldayEvent>> fetchSchooldayEvents(
      _i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'schooldayEvent',
        method: 'fetchSchooldayEvents',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'schooldayEvent',
          methodName: 'fetchSchooldayEvents',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i35.SchooldayEvent>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i35.SchooldayEvent> createSchooldayEvent(
    _i1.TestSessionBuilder sessionBuilder, {
    required int pupilId,
    required int schooldayId,
    required _i36.SchooldayEventType type,
    required String reason,
    required String createdBy,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'schooldayEvent',
        method: 'createSchooldayEvent',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'schooldayEvent',
          methodName: 'createSchooldayEvent',
          parameters: _i1.testObjectToJson({
            'pupilId': pupilId,
            'schooldayId': schooldayId,
            'type': type,
            'reason': reason,
            'createdBy': createdBy,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i35.SchooldayEvent>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i35.SchooldayEvent> updateSchooldayEvent(
    _i1.TestSessionBuilder sessionBuilder,
    _i35.SchooldayEvent schooldayEvent,
    bool changedProcessedToFalse,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'schooldayEvent',
        method: 'updateSchooldayEvent',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'schooldayEvent',
          methodName: 'updateSchooldayEvent',
          parameters: _i1.testObjectToJson({
            'schooldayEvent': schooldayEvent,
            'changedProcessedToFalse': changedProcessedToFalse,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i35.SchooldayEvent>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteSchooldayEvent(
    _i1.TestSessionBuilder sessionBuilder,
    int schooldayEventId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'schooldayEvent',
        method: 'deleteSchooldayEvent',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'schooldayEvent',
          methodName: 'deleteSchooldayEvent',
          parameters:
              _i1.testObjectToJson({'schooldayEventId': schooldayEventId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i35.SchooldayEvent> updateSchooldayEventFile(
    _i1.TestSessionBuilder sessionBuilder,
    int schooldayEventId,
    String filePath,
    String createdBy,
    bool isprocessed,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'schooldayEvent',
        method: 'updateSchooldayEventFile',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'schooldayEvent',
          methodName: 'updateSchooldayEventFile',
          parameters: _i1.testObjectToJson({
            'schooldayEventId': schooldayEventId,
            'filePath': filePath,
            'createdBy': createdBy,
            'isprocessed': isprocessed,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i35.SchooldayEvent>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i35.SchooldayEvent> deleteSchooldayEventFile(
    _i1.TestSessionBuilder sessionBuilder,
    int schooldayEventId,
    bool isProcessed,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'schooldayEvent',
        method: 'deleteSchooldayEventFile',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'schooldayEvent',
          methodName: 'deleteSchooldayEventFile',
          parameters: _i1.testObjectToJson({
            'schooldayEventId': schooldayEventId,
            'isProcessed': isProcessed,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i35.SchooldayEvent>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AuthEndpoint {
  _AuthEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<
          ({_i37.AuthenticationResponse response, _i38.UserDevice? userDevice})>
      login(
    _i1.TestSessionBuilder sessionBuilder,
    String email,
    String password,
    _i39.DeviceInfo deviceInfo,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'auth',
        method: 'login',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'auth',
          methodName: 'login',
          parameters: _i1.testObjectToJson({
            'email': email,
            'password': password,
            'deviceInfo': deviceInfo,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await _localCallContext.method
            .call(
              _localUniqueSession,
              _localCallContext.arguments,
            )
            .then((record) => _i11.Protocol().deserialize<
                ({
                  _i37.AuthenticationResponse response,
                  _i38.UserDevice? userDevice
                })>(record));
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> verifyPassword(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
    String password,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'auth',
        method: 'verifyPassword',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'auth',
          methodName: 'verifyPassword',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'password': password,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> logOut(
    _i1.TestSessionBuilder sessionBuilder,
    String keyId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'auth',
        method: 'logOut',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'auth',
          methodName: 'logOut',
          parameters: _i1.testObjectToJson({'keyId': keyId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _UserEndpoint {
  _UserEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i4.User?> getCurrentUser(
      _i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'user',
        method: 'getCurrentUser',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'user',
          methodName: 'getCurrentUser',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i4.User?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> changePassword(
    _i1.TestSessionBuilder sessionBuilder,
    String oldPassword,
    String newPassword,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'user',
        method: 'changePassword',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'user',
          methodName: 'changePassword',
          parameters: _i1.testObjectToJson({
            'oldPassword': oldPassword,
            'newPassword': newPassword,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> increaseStaffCredit(
      _i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'user',
        method: 'increaseStaffCredit',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'user',
          methodName: 'increaseStaffCredit',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _PupilWorkbooksEndpoint {
  _PupilWorkbooksEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i40.PupilWorkbook> postPupilWorkbook(
    _i1.TestSessionBuilder sessionBuilder,
    int isbn,
    int pupilId,
    String createdBy,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupilWorkbooks',
        method: 'postPupilWorkbook',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupilWorkbooks',
          methodName: 'postPupilWorkbook',
          parameters: _i1.testObjectToJson({
            'isbn': isbn,
            'pupilId': pupilId,
            'createdBy': createdBy,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i40.PupilWorkbook>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i40.PupilWorkbook>> fetchPupilWorkbooks(
      _i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupilWorkbooks',
        method: 'fetchPupilWorkbooks',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupilWorkbooks',
          methodName: 'fetchPupilWorkbooks',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i40.PupilWorkbook>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i40.PupilWorkbook>> fetchPupilWorkbooksFromPupil(
    _i1.TestSessionBuilder sessionBuilder,
    int pupilId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupilWorkbooks',
        method: 'fetchPupilWorkbooksFromPupil',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupilWorkbooks',
          methodName: 'fetchPupilWorkbooksFromPupil',
          parameters: _i1.testObjectToJson({'pupilId': pupilId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i40.PupilWorkbook>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i40.PupilWorkbook> updatePupilWorkbook(
    _i1.TestSessionBuilder sessionBuilder,
    _i40.PupilWorkbook pupilWorkbook,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupilWorkbooks',
        method: 'updatePupilWorkbook',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupilWorkbooks',
          methodName: 'updatePupilWorkbook',
          parameters: _i1.testObjectToJson({'pupilWorkbook': pupilWorkbook}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i40.PupilWorkbook>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deletePupilWorkbook(
    _i1.TestSessionBuilder sessionBuilder,
    int pupilWorkbookId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'pupilWorkbooks',
        method: 'deletePupilWorkbook',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'pupilWorkbooks',
          methodName: 'deletePupilWorkbook',
          parameters:
              _i1.testObjectToJson({'pupilWorkbookId': pupilWorkbookId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _WorkbooksEndpoint {
  _WorkbooksEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i41.Workbook> postWorkbook(
    _i1.TestSessionBuilder sessionBuilder,
    _i41.Workbook workbook,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'workbooks',
        method: 'postWorkbook',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'workbooks',
          methodName: 'postWorkbook',
          parameters: _i1.testObjectToJson({'workbook': workbook}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i41.Workbook>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i41.Workbook> fetchWorkbookByIsbn(
    _i1.TestSessionBuilder sessionBuilder,
    int isbn,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'workbooks',
        method: 'fetchWorkbookByIsbn',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'workbooks',
          methodName: 'fetchWorkbookByIsbn',
          parameters: _i1.testObjectToJson({'isbn': isbn}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i41.Workbook>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i41.Workbook>> fetchWorkbooks(
      _i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'workbooks',
        method: 'fetchWorkbooks',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'workbooks',
          methodName: 'fetchWorkbooks',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<List<_i41.Workbook>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i41.Workbook> updateWorkbook(
    _i1.TestSessionBuilder sessionBuilder,
    _i41.Workbook workbook,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'workbooks',
        method: 'updateWorkbook',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'workbooks',
          methodName: 'updateWorkbook',
          parameters: _i1.testObjectToJson({'workbook': workbook}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i41.Workbook>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteWorkbook(
    _i1.TestSessionBuilder sessionBuilder,
    int id,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'workbooks',
        method: 'deleteWorkbook',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'workbooks',
          methodName: 'deleteWorkbook',
          parameters: _i1.testObjectToJson({'id': id}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _FilesEndpoint {
  _FilesEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<String?> getUploadDescription(
    _i1.TestSessionBuilder sessionBuilder,
    String storageId,
    String path,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'files',
        method: 'getUploadDescription',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'files',
          methodName: 'getUploadDescription',
          parameters: _i1.testObjectToJson({
            'storageId': storageId,
            'path': path,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<String?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> verifyUpload(
    _i1.TestSessionBuilder sessionBuilder,
    String storageId,
    String path,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'files',
        method: 'verifyUpload',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'files',
          methodName: 'verifyUpload',
          parameters: _i1.testObjectToJson({
            'storageId': storageId,
            'path': path,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i42.ByteData?> getImage(
    _i1.TestSessionBuilder sessionBuilder,
    String documentId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'files',
        method: 'getImage',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'files',
          methodName: 'getImage',
          parameters: _i1.testObjectToJson({'documentId': documentId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i42.ByteData?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i42.ByteData?> getUnencryptedImage(
    _i1.TestSessionBuilder sessionBuilder,
    String path,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
        endpoint: 'files',
        method: 'getUnencryptedImage',
      );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'files',
          methodName: 'getUnencryptedImage',
          parameters: _i1.testObjectToJson({'path': path}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await (_localCallContext.method.call(
          _localUniqueSession,
          _localCallContext.arguments,
        ) as _i3.Future<_i42.ByteData?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

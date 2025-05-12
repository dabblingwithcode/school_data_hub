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
import 'package:school_data_hub_client/src/protocol/schoolday/missed_class/missed_class_dto.dart'
    as _i6;
import 'package:school_data_hub_client/src/protocol/schoolday/missed_class/missed_class.dart'
    as _i7;
import 'package:school_data_hub_client/src/protocol/user/device_info.dart'
    as _i8;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i9;
import 'package:school_data_hub_client/src/protocol/authorization/authorization.dart'
    as _i10;
import 'package:school_data_hub_client/src/protocol/shared/member_operation.dart'
    as _i11;
import 'package:school_data_hub_client/src/protocol/protocol.dart' as _i12;
import 'package:school_data_hub_client/src/protocol/authorization/pupil_authorization.dart'
    as _i13;
import 'package:school_data_hub_client/src/protocol/book/book_tagging/book_tag.dart'
    as _i14;
import 'package:school_data_hub_client/src/protocol/book/book.dart' as _i15;
import 'package:school_data_hub_client/src/protocol/book/library_book/location/library_book_location.dart'
    as _i16;
import 'package:school_data_hub_client/src/protocol/book/library_book/library_book.dart'
    as _i17;
import 'package:school_data_hub_client/src/protocol/book/library_book/library_book_query.dart'
    as _i18;
import 'package:school_data_hub_client/src/protocol/book/pupil_book_lending.dart'
    as _i19;
import 'dart:typed_data' as _i20;
import 'package:school_data_hub_client/src/protocol/learning/competence.dart'
    as _i21;
import 'dart:io' as _i22;
import 'package:school_data_hub_client/src/protocol/learning_support/support_category.dart'
    as _i23;
import 'package:school_data_hub_client/src/protocol/learning_support/support_category_status.dart'
    as _i24;
import 'package:school_data_hub_client/src/protocol/pupil_data/dto/pupil_document_type.dart'
    as _i25;
import 'package:school_data_hub_client/src/protocol/pupil_data/pupil_objects/communication/communication_skills.dart'
    as _i26;
import 'package:school_data_hub_client/src/protocol/pupil_data/pupil_objects/communication/tutor_info.dart'
    as _i27;
import 'package:school_data_hub_client/src/protocol/pupil_data/dto/siblings_tutor_info_dto.dart'
    as _i28;
import 'package:school_data_hub_client/src/protocol/pupil_data/pupil_objects/preschool/pre_school_medical_status.dart'
    as _i29;
import 'package:school_data_hub_client/src/protocol/pupil_data/pupil_objects/communication/public_media_auth.dart'
    as _i30;
import 'package:school_data_hub_client/src/protocol/learning_support/support_level.dart'
    as _i31;
import 'package:school_data_hub_client/src/protocol/school_list/school_list.dart'
    as _i32;
import 'package:school_data_hub_client/src/protocol/school_list/pupil_entry.dart'
    as _i33;
import 'package:school_data_hub_client/src/protocol/schoolday/school_semester.dart'
    as _i34;
import 'package:school_data_hub_client/src/protocol/schoolday/schoolday.dart'
    as _i35;
import 'package:school_data_hub_client/src/protocol/schoolday/schoolday_event/schoolday_event.dart'
    as _i36;
import 'package:school_data_hub_client/src/protocol/schoolday/schoolday_event/schoolday_event_type.dart'
    as _i37;
import 'protocol.dart' as _i38;

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

  _i2.Future<Set<_i5.PupilData>> updateBackendPupilDataState(String filePath) =>
      caller.callServerEndpoint<Set<_i5.PupilData>>(
        'admin',
        'updateBackendPupilDataState',
        {'filePath': filePath},
      );
}

/// {@category Endpoint}
class EndpointMissedClass extends _i1.EndpointRef {
  EndpointMissedClass(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'missedClass';

  _i2.Stream<_i6.MissedClassDto> streamMyModels() =>
      caller.callStreamingServerEndpoint<_i2.Stream<_i6.MissedClassDto>,
          _i6.MissedClassDto>(
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
class EndpointAuthorization extends _i1.EndpointRef {
  EndpointAuthorization(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'authorization';

  _i2.Future<List<_i10.Authorization>> fetchAuthorizations() =>
      caller.callServerEndpoint<List<_i10.Authorization>>(
        'authorization',
        'fetchAuthorizations',
        {},
      );

  _i2.Future<_i10.Authorization?> fetchAuthorizationById(int id) =>
      caller.callServerEndpoint<_i10.Authorization?>(
        'authorization',
        'fetchAuthorizationById',
        {'id': id},
      );

  _i2.Future<_i10.Authorization> postAuthorizationWithPupils(
    String name,
    String description,
    String createdBy,
    List<int> pupilIds,
  ) =>
      caller.callServerEndpoint<_i10.Authorization>(
        'authorization',
        'postAuthorizationWithPupils',
        {
          'name': name,
          'description': description,
          'createdBy': createdBy,
          'pupilIds': pupilIds,
        },
      );

  _i2.Future<_i10.Authorization> updateAuthorization(
    int authId,
    String? name,
    String? description,
    ({_i11.MemberOperation operation, List<int> pupilIds})? updateMembers,
  ) =>
      caller.callServerEndpoint<_i10.Authorization>(
        'authorization',
        'updateAuthorization',
        {
          'authId': authId,
          'name': name,
          'description': description,
          'updateMembers': _i12.mapRecordToJson(updateMembers),
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

  _i2.Future<_i13.PupilAuthorization> updatePupilAuthorization(
          _i13.PupilAuthorization authorization) =>
      caller.callServerEndpoint<_i13.PupilAuthorization>(
        'pupilAuthorization',
        'updatePupilAuthorization',
        {'authorization': authorization},
      );

  _i2.Future<_i13.PupilAuthorization> addFileToPupilAuthorization(
    int pupilAuthId,
    String filePath,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i13.PupilAuthorization>(
        'pupilAuthorization',
        'addFileToPupilAuthorization',
        {
          'pupilAuthId': pupilAuthId,
          'filePath': filePath,
          'createdBy': createdBy,
        },
      );

  _i2.Future<_i13.PupilAuthorization> removeFileFromPupilAuthorization(
          int pupilAuthId) =>
      caller.callServerEndpoint<_i13.PupilAuthorization>(
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

  _i2.Future<_i14.BookTag> postBookTag(_i14.BookTag bookTag) =>
      caller.callServerEndpoint<_i14.BookTag>(
        'bookTags',
        'postBookTag',
        {'bookTag': bookTag},
      );

  _i2.Future<List<_i14.BookTag>> fetchBookTags() =>
      caller.callServerEndpoint<List<_i14.BookTag>>(
        'bookTags',
        'fetchBookTags',
        {},
      );

  _i2.Future<_i14.BookTag> updateBookTag(_i14.BookTag bookTag) =>
      caller.callServerEndpoint<_i14.BookTag>(
        'bookTags',
        'updateBookTag',
        {'bookTag': bookTag},
      );

  _i2.Future<bool> deleteBookTag(int id) => caller.callServerEndpoint<bool>(
        'bookTags',
        'deleteBookTag',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointBooks extends _i1.EndpointRef {
  EndpointBooks(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'books';

  _i2.Future<_i15.Book> postBook(_i15.Book book) =>
      caller.callServerEndpoint<_i15.Book>(
        'books',
        'postBook',
        {'book': book},
      );

  _i2.Future<List<_i15.Book>> fetchBooks() =>
      caller.callServerEndpoint<List<_i15.Book>>(
        'books',
        'fetchBooks',
        {},
      );

  _i2.Future<_i15.Book?> fetchBookByIsbn(int isbn) =>
      caller.callServerEndpoint<_i15.Book?>(
        'books',
        'fetchBookByIsbn',
        {'isbn': isbn},
      );

  _i2.Future<_i15.Book> updateBook(_i15.Book book) =>
      caller.callServerEndpoint<_i15.Book>(
        'books',
        'updateBook',
        {'book': book},
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

  _i2.Future<_i16.LibraryBookLocation> postLibraryBookLocation(
          _i16.LibraryBookLocation libraryBookLocation) =>
      caller.callServerEndpoint<_i16.LibraryBookLocation>(
        'libraryBookLocations',
        'postLibraryBookLocation',
        {'libraryBookLocation': libraryBookLocation},
      );

  _i2.Future<List<_i16.LibraryBookLocation>> fetchLibraryBookLocations() =>
      caller.callServerEndpoint<List<_i16.LibraryBookLocation>>(
        'libraryBookLocations',
        'fetchLibraryBookLocations',
        {},
      );

  _i2.Future<_i16.LibraryBookLocation> updateLibraryBookLocation(
          _i16.LibraryBookLocation libraryBookLocation) =>
      caller.callServerEndpoint<_i16.LibraryBookLocation>(
        'libraryBookLocations',
        'updateLibraryBookLocation',
        {'libraryBookLocation': libraryBookLocation},
      );

  _i2.Future<bool> deleteLibraryBookLocation(int id) =>
      caller.callServerEndpoint<bool>(
        'libraryBookLocations',
        'deleteLibraryBookLocation',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointLibraryBooks extends _i1.EndpointRef {
  EndpointLibraryBooks(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'libraryBooks';

  _i2.Future<_i17.LibraryBook> postLibraryBook(_i17.LibraryBook libraryBook) =>
      caller.callServerEndpoint<_i17.LibraryBook>(
        'libraryBooks',
        'postLibraryBook',
        {'libraryBook': libraryBook},
      );

  _i2.Future<List<_i17.LibraryBook>> fetchLibraryBooks() =>
      caller.callServerEndpoint<List<_i17.LibraryBook>>(
        'libraryBooks',
        'fetchLibraryBooks',
        {},
      );

  _i2.Future<_i17.LibraryBook?> fetchLibraryBookByIsbn(int isbn) =>
      caller.callServerEndpoint<_i17.LibraryBook?>(
        'libraryBooks',
        'fetchLibraryBookByIsbn',
        {'isbn': isbn},
      );

  _i2.Future<List<_i17.LibraryBook>> fetchLibraryBooksMatchingQuery(
          _i18.LibraryBookQuery libraryBookQuery) =>
      caller.callServerEndpoint<List<_i17.LibraryBook>>(
        'libraryBooks',
        'fetchLibraryBooksMatchingQuery',
        {'libraryBookQuery': libraryBookQuery},
      );

  _i2.Future<_i17.LibraryBook> updateLibraryBook(
          _i17.LibraryBook libraryBook) =>
      caller.callServerEndpoint<_i17.LibraryBook>(
        'libraryBooks',
        'updateLibraryBook',
        {'libraryBook': libraryBook},
      );

  _i2.Future<bool> deleteLibraryBook(int id) => caller.callServerEndpoint<bool>(
        'libraryBooks',
        'deleteLibraryBook',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointPupilBookLending extends _i1.EndpointRef {
  EndpointPupilBookLending(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'pupilBookLending';

  _i2.Future<_i19.PupilBookLending> postPupilBookLending(
          _i19.PupilBookLending pupilBookLending) =>
      caller.callServerEndpoint<_i19.PupilBookLending>(
        'pupilBookLending',
        'postPupilBookLending',
        {'pupilBookLending': pupilBookLending},
      );

  _i2.Future<List<_i19.PupilBookLending>> fetchPupilBookLendings() =>
      caller.callServerEndpoint<List<_i19.PupilBookLending>>(
        'pupilBookLending',
        'fetchPupilBookLendings',
        {},
      );

  _i2.Future<_i19.PupilBookLending?> fetchPupilBookLendingById(int id) =>
      caller.callServerEndpoint<_i19.PupilBookLending?>(
        'pupilBookLending',
        'fetchPupilBookLendingById',
        {'id': id},
      );

  _i2.Future<_i19.PupilBookLending> updatePupilBookLending(
          _i19.PupilBookLending pupilBookLending) =>
      caller.callServerEndpoint<_i19.PupilBookLending>(
        'pupilBookLending',
        'updatePupilBookLending',
        {'pupilBookLending': pupilBookLending},
      );

  _i2.Future<bool> deletePupilBookLending(int id) =>
      caller.callServerEndpoint<bool>(
        'pupilBookLending',
        'deletePupilBookLending',
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
  _i2.Future<_i20.ByteData?> getImage(String documentId) =>
      caller.callServerEndpoint<_i20.ByteData?>(
        'files',
        'getImage',
        {'documentId': documentId},
      );
}

/// {@category Endpoint}
class EndpointCompetence extends _i1.EndpointRef {
  EndpointCompetence(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'competence';

  _i2.Future<List<_i21.Competence>> importCompetencesFromJsonFile(
          _i22.File jsonFile) =>
      caller.callServerEndpoint<List<_i21.Competence>>(
        'competence',
        'importCompetencesFromJsonFile',
        {'jsonFile': jsonFile},
      );

  _i2.Future<_i21.Competence> postCompetence({
    int? parentCompetence,
    required String name,
    required List<String> level,
    required List<String> indicators,
  }) =>
      caller.callServerEndpoint<_i21.Competence>(
        'competence',
        'postCompetence',
        {
          'parentCompetence': parentCompetence,
          'name': name,
          'level': level,
          'indicators': indicators,
        },
      );

  _i2.Future<List<_i21.Competence>> getAllCompetences() =>
      caller.callServerEndpoint<List<_i21.Competence>>(
        'competence',
        'getAllCompetences',
        {},
      );

  _i2.Future<_i21.Competence> updateCompetence(_i21.Competence competence) =>
      caller.callServerEndpoint<_i21.Competence>(
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
class EndpointSupportCategory extends _i1.EndpointRef {
  EndpointSupportCategory(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'supportCategory';

  _i2.Future<List<_i23.SupportCategory>> fetchSupportCategories() =>
      caller.callServerEndpoint<List<_i23.SupportCategory>>(
        'supportCategory',
        'fetchSupportCategories',
        {},
      );

  _i2.Future<List<_i23.SupportCategory>> importSupportCategoriesFromJsonFile(
          String jsonFilePath) =>
      caller.callServerEndpoint<List<_i23.SupportCategory>>(
        'supportCategory',
        'importSupportCategoriesFromJsonFile',
        {'jsonFilePath': jsonFilePath},
      );

  _i2.Future<bool> createSupportCategory(_i23.SupportCategory category) =>
      caller.callServerEndpoint<bool>(
        'supportCategory',
        'createSupportCategory',
        {'category': category},
      );

  _i2.Future<bool> updateSupportCategory(_i23.SupportCategory category) =>
      caller.callServerEndpoint<bool>(
        'supportCategory',
        'updateSupportCategory',
        {'category': category},
      );

  _i2.Future<bool> deleteSupportCategory(_i23.SupportCategory category) =>
      caller.callServerEndpoint<bool>(
        'supportCategory',
        'deleteSupportCategory',
        {'category': category},
      );

  _i2.Future<_i5.PupilData> postSupportCategoryStatus(
    int pupilId,
    int supportCategoryId,
    int status,
    String comment,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'supportCategory',
        'postSupportCategoryStatus',
        {
          'pupilId': pupilId,
          'supportCategoryId': supportCategoryId,
          'status': status,
          'comment': comment,
          'createdBy': createdBy,
        },
      );

  _i2.Future<List<_i24.SupportCategoryStatus>> fetchSupportCategoryStatus(
          int pupilId) =>
      caller.callServerEndpoint<List<_i24.SupportCategoryStatus>>(
        'supportCategory',
        'fetchSupportCategoryStatus',
        {'pupilId': pupilId},
      );

  _i2.Future<List<_i24.SupportCategoryStatus>>
      fetchSupportCategoryStatusFromPupil(int pupilId) =>
          caller.callServerEndpoint<List<_i24.SupportCategoryStatus>>(
            'supportCategory',
            'fetchSupportCategoryStatusFromPupil',
            {'pupilId': pupilId},
          );

  _i2.Future<_i24.SupportCategoryStatus> updateCategoryStatus(
    int pupilId,
    int supportCategoryId,
    int? status,
    String? comment,
    String? createdBy,
    DateTime? createdAt,
  ) =>
      caller.callServerEndpoint<_i24.SupportCategoryStatus>(
        'supportCategory',
        'updateCategoryStatus',
        {
          'pupilId': pupilId,
          'supportCategoryId': supportCategoryId,
          'status': status,
          'comment': comment,
          'createdBy': createdBy,
          'createdAt': createdAt,
        },
      );

  _i2.Future<_i5.PupilData> deleteSupportCategoryStatus(
    int pupilId,
    int statusId,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'supportCategory',
        'deleteSupportCategoryStatus',
        {
          'pupilId': pupilId,
          'statusId': statusId,
        },
      );

  _i2.Future<_i5.PupilData> postCategoryGoal(
    int pupilId,
    int supportCategoryId,
    String description,
    String strategies,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'supportCategory',
        'postCategoryGoal',
        {
          'pupilId': pupilId,
          'supportCategoryId': supportCategoryId,
          'description': description,
          'strategies': strategies,
          'createdBy': createdBy,
        },
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

  _i2.Future<_i5.PupilData> deletePupilDocument(
    int pupilId,
    _i25.PupilDocumentType documentType,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupil',
        'deletePupilDocument',
        {
          'pupilId': pupilId,
          'documentType': documentType,
        },
      );

  _i2.Future<_i5.PupilData> resetPublicMediaAuth(
    int pupilId,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupil',
        'resetPublicMediaAuth',
        {
          'pupilId': pupilId,
          'createdBy': createdBy,
        },
      );

  _i2.Future<_i5.PupilData> deleteSupportLevelHistoryItem(
    int pupilId,
    int supportLevelId,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupil',
        'deleteSupportLevelHistoryItem',
        {
          'pupilId': pupilId,
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
    required _i26.CommunicationSkills? communicationSkills,
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
    _i27.TutorInfo? tutorInfo,
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
          _i28.SiblingsTutorInfo siblingsTutorInfo) =>
      caller.callServerEndpoint<List<_i5.PupilData>>(
        'pupilUpdate',
        'updateSiblingsTutorInfo',
        {'siblingsTutorInfo': siblingsTutorInfo},
      );

  _i2.Future<_i5.PupilData> updatePupilDocument(
    int pupilId,
    String filePath,
    String createdBy,
    _i25.PupilDocumentType documentType,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupilUpdate',
        'updatePupilDocument',
        {
          'pupilId': pupilId,
          'filePath': filePath,
          'createdBy': createdBy,
          'documentType': documentType,
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
    String sender,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupilUpdate',
        'updateCredit',
        {
          'pupilId': pupilId,
          'value': value,
          'description': description,
          'sender': sender,
        },
      );

  _i2.Future<_i5.PupilData> updatePreSchoolMedicalStatus(
    int pupilId,
    _i29.PreSchoolMedicalStatus preSchoolMedicalStatus,
    String updatedBy,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupilUpdate',
        'updatePreSchoolMedicalStatus',
        {
          'pupilId': pupilId,
          'preSchoolMedicalStatus': preSchoolMedicalStatus,
          'updatedBy': updatedBy,
        },
      );

  _i2.Future<_i5.PupilData> updatePublicMediaAuth(
    int pupilId,
    _i30.PublicMediaAuth publicMediaAuth,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupilUpdate',
        'updatePublicMediaAuth',
        {
          'pupilId': pupilId,
          'publicMediaAuth': publicMediaAuth,
        },
      );

  _i2.Future<_i5.PupilData> updateSupportLevel(
    _i31.SupportLevel supportLevel,
    int pupilId,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupilUpdate',
        'updateSupportLevel',
        {
          'supportLevel': supportLevel,
          'pupilId': pupilId,
        },
      );
}

/// {@category Endpoint}
class EndpointSchoolList extends _i1.EndpointRef {
  EndpointSchoolList(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'schoolList';

  _i2.Future<List<_i32.SchoolList>> fetchSchoolLists(String userName) =>
      caller.callServerEndpoint<List<_i32.SchoolList>>(
        'schoolList',
        'fetchSchoolLists',
        {'userName': userName},
      );

  _i2.Future<_i32.SchoolList> postSchoolList(
    String name,
    String description,
    List<int> pupilIds,
    bool public,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i32.SchoolList>(
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

  _i2.Future<_i32.SchoolList> updateSchoolList(
    int listId,
    String? name,
    String? description,
    bool? public,
    ({_i11.MemberOperation operation, List<int> pupilIds})? updateMembers,
  ) =>
      caller.callServerEndpoint<_i32.SchoolList>(
        'schoolList',
        'updateSchoolList',
        {
          'listId': listId,
          'name': name,
          'description': description,
          'public': public,
          'updateMembers': _i12.mapRecordToJson(updateMembers),
        },
      );

  _i2.Future<bool> deleteSchoolList(int listId) =>
      caller.callServerEndpoint<bool>(
        'schoolList',
        'deleteSchoolList',
        {'listId': listId},
      );

  _i2.Future<_i33.PupilListEntry> updatePupilListEntry(
          _i33.PupilListEntry entry) =>
      caller.callServerEndpoint<_i33.PupilListEntry>(
        'schoolList',
        'updatePupilListEntry',
        {'entry': entry},
      );
}

/// {@category Endpoint}
class EndpointSchooldayAdmin extends _i1.EndpointRef {
  EndpointSchooldayAdmin(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'schooldayAdmin';

  _i2.Future<_i34.SchoolSemester> createSchoolSemester(
    DateTime startDate,
    DateTime endDate,
    bool isFirst,
    DateTime classConferenceDate,
    DateTime supportConferenceDate,
    DateTime reportSignedDate,
  ) =>
      caller.callServerEndpoint<_i34.SchoolSemester>(
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

  _i2.Future<List<_i34.SchoolSemester>> getAllSchoolSemesters() =>
      caller.callServerEndpoint<List<_i34.SchoolSemester>>(
        'schooldayAdmin',
        'getAllSchoolSemesters',
        {},
      );

  _i2.Future<_i34.SchoolSemester?> getCurrentSchoolSemester() =>
      caller.callServerEndpoint<_i34.SchoolSemester?>(
        'schooldayAdmin',
        'getCurrentSchoolSemester',
        {},
      );

  _i2.Future<bool> updateSchoolSemester(_i34.SchoolSemester schoolSemester) =>
      caller.callServerEndpoint<bool>(
        'schooldayAdmin',
        'updateSchoolSemester',
        {'schoolSemester': schoolSemester},
      );

  _i2.Future<bool> deleteSchoolSemester(_i34.SchoolSemester semester) =>
      caller.callServerEndpoint<bool>(
        'schooldayAdmin',
        'deleteSchoolSemester',
        {'semester': semester},
      );

  _i2.Future<_i35.Schoolday?> createSchoolday(DateTime date) =>
      caller.callServerEndpoint<_i35.Schoolday?>(
        'schooldayAdmin',
        'createSchoolday',
        {'date': date},
      );

  _i2.Future<List<_i35.Schoolday>> createSchooldays(List<DateTime> dates) =>
      caller.callServerEndpoint<List<_i35.Schoolday>>(
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

  _i2.Future<bool> updateSchoolday(_i35.Schoolday schoolday) =>
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

  _i2.Future<List<_i34.SchoolSemester>> getSchoolSemesters() =>
      caller.callServerEndpoint<List<_i34.SchoolSemester>>(
        'schoolday',
        'getSchoolSemesters',
        {},
      );

  _i2.Future<List<_i35.Schoolday>> getSchooldays() =>
      caller.callServerEndpoint<List<_i35.Schoolday>>(
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

  _i2.Future<List<_i36.SchooldayEvent>> fetchSchooldayEvents() =>
      caller.callServerEndpoint<List<_i36.SchooldayEvent>>(
        'schooldayEvent',
        'fetchSchooldayEvents',
        {},
      );

  _i2.Future<_i36.SchooldayEvent> createSchooldayEvent({
    required int pupilId,
    required int schooldayId,
    required _i37.SchooldayEventType type,
    required String reason,
    required String createdBy,
  }) =>
      caller.callServerEndpoint<_i36.SchooldayEvent>(
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

  _i2.Future<_i36.SchooldayEvent> updateSchooldayEvent(
    _i36.SchooldayEvent schooldayEvent,
    bool changedProcessedToFalse,
  ) =>
      caller.callServerEndpoint<_i36.SchooldayEvent>(
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

  _i2.Future<_i36.SchooldayEvent> updateSchooldayEventFile(
    int schooldayEventId,
    String filePath,
    String createdBy,
    bool isprocessed,
  ) =>
      caller.callServerEndpoint<_i36.SchooldayEvent>(
        'schooldayEvent',
        'updateSchooldayEventFile',
        {
          'schooldayEventId': schooldayEventId,
          'filePath': filePath,
          'createdBy': createdBy,
          'isprocessed': isprocessed,
        },
      );

  _i2.Future<_i36.SchooldayEvent> deleteSchooldayEventFile(
    int schooldayEventId,
    bool isProcessed,
  ) =>
      caller.callServerEndpoint<_i36.SchooldayEvent>(
        'schooldayEvent',
        'deleteSchooldayEventFile',
        {
          'schooldayEventId': schooldayEventId,
          'isProcessed': isProcessed,
        },
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
          _i38.Protocol(),
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
    missedClass = EndpointMissedClass(this);
    auth = EndpointAuth(this);
    authorization = EndpointAuthorization(this);
    pupilAuthorization = EndpointPupilAuthorization(this);
    bookTags = EndpointBookTags(this);
    books = EndpointBooks(this);
    libraryBookLocations = EndpointLibraryBookLocations(this);
    libraryBooks = EndpointLibraryBooks(this);
    pupilBookLending = EndpointPupilBookLending(this);
    files = EndpointFiles(this);
    competence = EndpointCompetence(this);
    supportCategory = EndpointSupportCategory(this);
    pupil = EndpointPupil(this);
    pupilUpdate = EndpointPupilUpdate(this);
    schoolList = EndpointSchoolList(this);
    schooldayAdmin = EndpointSchooldayAdmin(this);
    schoolday = EndpointSchoolday(this);
    schooldayEvent = EndpointSchooldayEvent(this);
    user = EndpointUser(this);
    modules = Modules(this);
  }

  late final EndpointAdmin admin;

  late final EndpointMissedClass missedClass;

  late final EndpointAuth auth;

  late final EndpointAuthorization authorization;

  late final EndpointPupilAuthorization pupilAuthorization;

  late final EndpointBookTags bookTags;

  late final EndpointBooks books;

  late final EndpointLibraryBookLocations libraryBookLocations;

  late final EndpointLibraryBooks libraryBooks;

  late final EndpointPupilBookLending pupilBookLending;

  late final EndpointFiles files;

  late final EndpointCompetence competence;

  late final EndpointSupportCategory supportCategory;

  late final EndpointPupil pupil;

  late final EndpointPupilUpdate pupilUpdate;

  late final EndpointSchoolList schoolList;

  late final EndpointSchooldayAdmin schooldayAdmin;

  late final EndpointSchoolday schoolday;

  late final EndpointSchooldayEvent schooldayEvent;

  late final EndpointUser user;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'admin': admin,
        'missedClass': missedClass,
        'auth': auth,
        'authorization': authorization,
        'pupilAuthorization': pupilAuthorization,
        'bookTags': bookTags,
        'books': books,
        'libraryBookLocations': libraryBookLocations,
        'libraryBooks': libraryBooks,
        'pupilBookLending': pupilBookLending,
        'files': files,
        'competence': competence,
        'supportCategory': supportCategory,
        'pupil': pupil,
        'pupilUpdate': pupilUpdate,
        'schoolList': schoolList,
        'schooldayAdmin': schooldayAdmin,
        'schoolday': schoolday,
        'schooldayEvent': schooldayEvent,
        'user': user,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}

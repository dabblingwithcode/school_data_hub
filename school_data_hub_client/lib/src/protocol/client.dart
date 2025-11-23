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
import 'package:school_data_hub_client/src/protocol/_features/user/models/staff_user.dart'
    as _i3;
import 'package:school_data_hub_client/src/protocol/_features/user/models/roles.dart'
    as _i4;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/pupil_data.dart'
    as _i5;
import 'package:school_data_hub_client/src/protocol/_features/learning/models/competence.dart'
    as _i6;
import 'package:school_data_hub_client/src/protocol/_features/learning_support/models/support_category.dart'
    as _i7;
import 'package:school_data_hub_client/src/protocol/_features/attendance/models/missed_schoolday_dto.dart'
    as _i8;
import 'package:school_data_hub_client/src/protocol/_features/attendance/models/missed_schoolday.dart'
    as _i9;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i10;
import 'package:school_data_hub_client/src/protocol/_features/auth/models/user_device.dart'
    as _i11;
import 'package:school_data_hub_client/src/protocol/_features/auth/models/device_info.dart'
    as _i12;
import 'package:school_data_hub_client/src/protocol/_features/authorizations/models/authorization.dart'
    as _i13;
import 'package:school_data_hub_client/src/protocol/_shared/models/member_operation.dart'
    as _i14;
import 'package:school_data_hub_client/src/protocol/protocol.dart' as _i15;
import 'package:school_data_hub_client/src/protocol/_features/authorizations/models/pupil_authorization.dart'
    as _i16;
import 'package:school_data_hub_client/src/protocol/_features/books/models/book_tagging/book_tag.dart'
    as _i17;
import 'package:school_data_hub_client/src/protocol/_features/books/models/book.dart'
    as _i18;
import 'package:school_data_hub_client/src/protocol/_features/books/models/library_book_location.dart'
    as _i19;
import 'package:school_data_hub_client/src/protocol/_features/books/models/library_book.dart'
    as _i20;
import 'package:school_data_hub_client/src/protocol/_features/books/models/library_book_query.dart'
    as _i21;
import 'package:school_data_hub_client/src/protocol/_features/books/models/pupil_book_lending.dart'
    as _i22;
import 'package:school_data_hub_client/src/protocol/_features/learning_support/models/learning_support_plan.dart'
    as _i23;
import 'package:school_data_hub_client/src/protocol/_features/learning_support/models/support_category_status.dart'
    as _i24;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/preschool/pre_school_medical.dart'
    as _i25;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/preschool/pre_school_medical_status.dart'
    as _i26;
import 'package:school_data_hub_client/src/protocol/_features/matrix/compulsory_room.dart'
    as _i27;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/dto/pupil_document_type.dart'
    as _i28;
import 'package:school_data_hub_client/src/protocol/_features/learning_support/models/support_level_legacy_dto.dart'
    as _i29;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_identity/pupil_identity_dto.dart'
    as _i30;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/communication/communication_skills.dart'
    as _i31;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/communication/tutor_info.dart'
    as _i32;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/dto/siblings_tutor_info_dto.dart'
    as _i33;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/communication/public_media_auth.dart'
    as _i34;
import 'package:school_data_hub_client/src/protocol/_features/learning_support/models/support_level.dart'
    as _i35;
import 'package:school_data_hub_client/src/protocol/_features/pupil/models/pupil_data/after_school_care/after_school_care.dart'
    as _i36;
import 'package:school_data_hub_client/src/protocol/_features/school_data/models/school_data.dart'
    as _i37;
import 'package:school_data_hub_client/src/protocol/_features/school_lists/models/school_list.dart'
    as _i38;
import 'package:school_data_hub_client/src/protocol/_features/school_lists/models/pupil_entry.dart'
    as _i39;
import 'package:school_data_hub_client/src/protocol/_features/schoolday/models/school_semester.dart'
    as _i40;
import 'package:school_data_hub_client/src/protocol/_features/schoolday/models/schoolday.dart'
    as _i41;
import 'package:school_data_hub_client/src/protocol/_features/schoolday_events/models/schoolday_event.dart'
    as _i42;
import 'package:school_data_hub_client/src/protocol/_features/schoolday_events/models/schoolday_event_type.dart'
    as _i43;
import 'package:school_data_hub_client/src/protocol/_features/timetable/models/classroom.dart'
    as _i44;
import 'package:school_data_hub_client/src/protocol/_features/timetable/models/lesson/lesson_group.dart'
    as _i45;
import 'package:school_data_hub_client/src/protocol/_features/timetable/models/scheduled_lesson/scheduled_lesson.dart'
    as _i46;
import 'package:school_data_hub_client/src/protocol/_features/timetable/models/scheduled_lesson/lesson_group_membership.dart'
    as _i47;
import 'package:school_data_hub_client/src/protocol/_features/timetable/models/scheduled_lesson/subject.dart'
    as _i48;
import 'package:school_data_hub_client/src/protocol/_features/timetable/models/timetable.dart'
    as _i49;
import 'package:school_data_hub_client/src/protocol/_features/timetable/models/scheduled_lesson/timetable_slot.dart'
    as _i50;
import 'package:school_data_hub_client/src/protocol/_features/timetable/models/scheduled_lesson/weekday_enum.dart'
    as _i51;
import 'package:school_data_hub_client/src/protocol/_features/workbooks/models/pupil_workbook.dart'
    as _i52;
import 'package:school_data_hub_client/src/protocol/_features/workbooks/models/workbook.dart'
    as _i53;
import 'dart:typed_data' as _i54;
import 'protocol.dart' as _i55;

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
    required int reliefTimeUnits,
    required List<String> scopeNames,
    required bool isTester,
    String? schooldayEventsProcessingTeam,
    String? matrixUserId,
    int? credit,
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
          'reliefTimeUnits': reliefTimeUnits,
          'scopeNames': scopeNames,
          'isTester': isTester,
          'schooldayEventsProcessingTeam': schooldayEventsProcessingTeam,
          'matrixUserId': matrixUserId,
          'credit': credit,
        },
      );

  _i2.Future<bool> resetPassword(
    String userEmail,
    String newPassword,
  ) =>
      caller.callServerEndpoint<bool>(
        'admin',
        'resetPassword',
        {
          'userEmail': userEmail,
          'newPassword': newPassword,
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

  _i2.Future<List<_i6.Competence>> importCompetencesFromJsonFile(
          String filePath) =>
      caller.callServerEndpoint<List<_i6.Competence>>(
        'admin',
        'importCompetencesFromJsonFile',
        {'filePath': filePath},
      );

  _i2.Future<List<_i7.SupportCategory>> importSupportCategoriesFromJsonFile(
          String filePath) =>
      caller.callServerEndpoint<List<_i7.SupportCategory>>(
        'admin',
        'importSupportCategoriesFromJsonFile',
        {'filePath': filePath},
      );
}

/// {@category Endpoint}
class EndpointMissedSchoolday extends _i1.EndpointRef {
  EndpointMissedSchoolday(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'missedSchoolday';

  _i2.Stream<_i8.MissedSchooldayDto> streamMissedSchooldays() =>
      caller.callStreamingServerEndpoint<_i2.Stream<_i8.MissedSchooldayDto>,
          _i8.MissedSchooldayDto>(
        'missedSchoolday',
        'streamMissedSchooldays',
        {},
        {},
      );

  _i2.Future<_i9.MissedSchoolday> postMissedSchoolday(
          _i9.MissedSchoolday missedClass) =>
      caller.callServerEndpoint<_i9.MissedSchoolday>(
        'missedSchoolday',
        'postMissedSchoolday',
        {'missedClass': missedClass},
      );

  _i2.Future<List<_i9.MissedSchoolday>> postMissedSchooldays(
          List<_i9.MissedSchoolday> missedClasses) =>
      caller.callServerEndpoint<List<_i9.MissedSchoolday>>(
        'missedSchoolday',
        'postMissedSchooldays',
        {'missedClasses': missedClasses},
      );

  _i2.Future<List<_i9.MissedSchoolday>> fetchAllMissedSchooldays() =>
      caller.callServerEndpoint<List<_i9.MissedSchoolday>>(
        'missedSchoolday',
        'fetchAllMissedSchooldays',
        {},
      );

  _i2.Future<List<_i9.MissedSchoolday>> fetchMissedSchooldaysOnASchoolday(
          DateTime schoolday) =>
      caller.callServerEndpoint<List<_i9.MissedSchoolday>>(
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

  _i2.Future<_i9.MissedSchoolday> updateMissedSchoolday(
          _i9.MissedSchoolday missedSchoolday) =>
      caller.callServerEndpoint<_i9.MissedSchoolday>(
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
          ({_i10.AuthenticationResponse response, _i11.UserDevice? userDevice})>
      login(
    String email,
    String password,
    _i12.DeviceInfo deviceInfo,
  ) =>
          caller.callServerEndpoint<
              ({
                _i10.AuthenticationResponse response,
                _i11.UserDevice? userDevice
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

  _i2.Future<List<_i13.Authorization>> fetchAuthorizations() =>
      caller.callServerEndpoint<List<_i13.Authorization>>(
        'authorization',
        'fetchAuthorizations',
        {},
      );

  _i2.Future<_i13.Authorization?> fetchAuthorizationById(int id) =>
      caller.callServerEndpoint<_i13.Authorization?>(
        'authorization',
        'fetchAuthorizationById',
        {'id': id},
      );

  _i2.Future<_i13.Authorization> postAuthorizationWithPupils(
    String name,
    String description,
    String createdBy,
    List<int> pupilIds,
  ) =>
      caller.callServerEndpoint<_i13.Authorization>(
        'authorization',
        'postAuthorizationWithPupils',
        {
          'name': name,
          'description': description,
          'createdBy': createdBy,
          'pupilIds': pupilIds,
        },
      );

  _i2.Future<_i13.Authorization> updateAuthorization(
    int authId,
    String? name,
    String? description,
    ({_i14.MemberOperation operation, List<int> pupilIds})? updateMembers,
  ) =>
      caller.callServerEndpoint<_i13.Authorization>(
        'authorization',
        'updateAuthorization',
        {
          'authId': authId,
          'name': name,
          'description': description,
          'updateMembers': _i15.mapRecordToJson(updateMembers),
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

  _i2.Future<_i16.PupilAuthorization> updatePupilAuthorization(
          _i16.PupilAuthorization authorization) =>
      caller.callServerEndpoint<_i16.PupilAuthorization>(
        'pupilAuthorization',
        'updatePupilAuthorization',
        {'authorization': authorization},
      );

  _i2.Future<_i16.PupilAuthorization> addFileToPupilAuthorization(
    int pupilAuthId,
    String filePath,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i16.PupilAuthorization>(
        'pupilAuthorization',
        'addFileToPupilAuthorization',
        {
          'pupilAuthId': pupilAuthId,
          'filePath': filePath,
          'createdBy': createdBy,
        },
      );

  _i2.Future<_i16.PupilAuthorization> removeFileFromPupilAuthorization(
          int pupilAuthId) =>
      caller.callServerEndpoint<_i16.PupilAuthorization>(
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

  _i2.Future<_i17.BookTag> postBookTag(_i17.BookTag bookTag) =>
      caller.callServerEndpoint<_i17.BookTag>(
        'bookTags',
        'postBookTag',
        {'bookTag': bookTag},
      );

  _i2.Future<List<_i17.BookTag>> fetchBookTags() =>
      caller.callServerEndpoint<List<_i17.BookTag>>(
        'bookTags',
        'fetchBookTags',
        {},
      );

  _i2.Future<_i17.BookTag> updateBookTag(_i17.BookTag bookTag) =>
      caller.callServerEndpoint<_i17.BookTag>(
        'bookTags',
        'updateBookTag',
        {'bookTag': bookTag},
      );

  _i2.Future<bool> deleteBookTag(_i17.BookTag bookTag) =>
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

  _i2.Future<_i18.Book> postBook(_i18.Book book) =>
      caller.callServerEndpoint<_i18.Book>(
        'books',
        'postBook',
        {'book': book},
      );

  _i2.Future<List<_i18.Book>> fetchBooks() =>
      caller.callServerEndpoint<List<_i18.Book>>(
        'books',
        'fetchBooks',
        {},
      );

  _i2.Future<_i18.Book?> fetchBookByIsbn(int isbn) =>
      caller.callServerEndpoint<_i18.Book?>(
        'books',
        'fetchBookByIsbn',
        {'isbn': isbn},
      );

  _i2.Future<_i18.Book> updateBookTags(
    int isbn, {
    List<_i17.BookTag>? tags,
  }) =>
      caller.callServerEndpoint<_i18.Book>(
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

  _i2.Future<_i19.LibraryBookLocation> postLibraryBookLocation(
          _i19.LibraryBookLocation libraryBookLocation) =>
      caller.callServerEndpoint<_i19.LibraryBookLocation>(
        'libraryBookLocations',
        'postLibraryBookLocation',
        {'libraryBookLocation': libraryBookLocation},
      );

  _i2.Future<List<_i19.LibraryBookLocation>> fetchLibraryBookLocations() =>
      caller.callServerEndpoint<List<_i19.LibraryBookLocation>>(
        'libraryBookLocations',
        'fetchLibraryBookLocations',
        {},
      );

  _i2.Future<_i19.LibraryBookLocation> updateLibraryBookLocation(
          _i19.LibraryBookLocation libraryBookLocation) =>
      caller.callServerEndpoint<_i19.LibraryBookLocation>(
        'libraryBookLocations',
        'updateLibraryBookLocation',
        {'libraryBookLocation': libraryBookLocation},
      );

  _i2.Future<bool> deleteLibraryBookLocation(
          _i19.LibraryBookLocation location) =>
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

  _i2.Future<_i20.LibraryBook> postLibraryBook(
    int isbn,
    String libraryId,
    _i19.LibraryBookLocation location,
  ) =>
      caller.callServerEndpoint<_i20.LibraryBook>(
        'libraryBooks',
        'postLibraryBook',
        {
          'isbn': isbn,
          'libraryId': libraryId,
          'location': location,
        },
      );

  _i2.Future<List<_i20.LibraryBook>> fetchLibraryBooks() =>
      caller.callServerEndpoint<List<_i20.LibraryBook>>(
        'libraryBooks',
        'fetchLibraryBooks',
        {},
      );

  _i2.Future<_i20.LibraryBook?> fetchLibraryBookByIsbn(int isbn) =>
      caller.callServerEndpoint<_i20.LibraryBook?>(
        'libraryBooks',
        'fetchLibraryBookByIsbn',
        {'isbn': isbn},
      );

  _i2.Future<_i20.LibraryBook?> fetchLibraryBookByLibraryId(String libraryId) =>
      caller.callServerEndpoint<_i20.LibraryBook?>(
        'libraryBooks',
        'fetchLibraryBookByLibraryId',
        {'libraryId': libraryId},
      );

  _i2.Future<List<_i20.LibraryBook>> fetchLibraryBooksMatchingQuery(
          _i21.LibraryBookQuery libraryBookQuery) =>
      caller.callServerEndpoint<List<_i20.LibraryBook>>(
        'libraryBooks',
        'fetchLibraryBooksMatchingQuery',
        {'libraryBookQuery': libraryBookQuery},
      );

  _i2.Future<_i20.LibraryBook> updateLibraryBookAndRelatedBook(
    int isbn,
    String libraryId,
    bool? available,
    _i19.LibraryBookLocation? location,
    String? title,
    String? author,
    String? description,
    String? readingLevel,
    List<_i17.BookTag>? tags,
  ) =>
      caller.callServerEndpoint<_i20.LibraryBook>(
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

  _i2.Future<_i5.PupilData> postPupilBookLending(
    int pupilId,
    String libraryId,
    String lentBy,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupilBookLending',
        'postPupilBookLending',
        {
          'pupilId': pupilId,
          'libraryId': libraryId,
          'lentBy': lentBy,
        },
      );

  _i2.Future<List<_i22.PupilBookLending>> fetchPupilBookLendings() =>
      caller.callServerEndpoint<List<_i22.PupilBookLending>>(
        'pupilBookLending',
        'fetchPupilBookLendings',
        {},
      );

  _i2.Future<_i22.PupilBookLending?> fetchPupilBookLendingByLendingId(
          String lendingId) =>
      caller.callServerEndpoint<_i22.PupilBookLending?>(
        'pupilBookLending',
        'fetchPupilBookLendingByLendingId',
        {'lendingId': lendingId},
      );

  _i2.Future<_i5.PupilData> updatePupilBookLending(
          _i22.PupilBookLending pupilBookLending) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupilBookLending',
        'updatePupilBookLending',
        {'pupilBookLending': pupilBookLending},
      );

  _i2.Future<_i5.PupilData> deletePupilBookLending(String lendingId) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupilBookLending',
        'deletePupilBookLending',
        {'lendingId': lendingId},
      );
}

/// {@category Endpoint}
class EndpointCompetenceCheck extends _i1.EndpointRef {
  EndpointCompetenceCheck(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'competenceCheck';

  _i2.Future<_i5.PupilData> postCompetenceCheck({
    required int competenceId,
    required int pupilId,
    required int score,
    String? comment,
    required double valueFactor,
    required String createdBy,
  }) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'competenceCheck',
        'postCompetenceCheck',
        {
          'competenceId': competenceId,
          'pupilId': pupilId,
          'score': score,
          'comment': comment,
          'valueFactor': valueFactor,
          'createdBy': createdBy,
        },
      );

  _i2.Future<_i5.PupilData> updateCompetenceCheck(
    String checkId, {
    ({int value})? score,
    ({double value})? valueFactor,
    ({String value})? createdBy,
    ({String? value})? comment,
  }) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'competenceCheck',
        'updateCompetenceCheck',
        {
          'checkId': checkId,
          'score': _i15.mapRecordToJson(score),
          'valueFactor': _i15.mapRecordToJson(valueFactor),
          'createdBy': _i15.mapRecordToJson(createdBy),
          'comment': _i15.mapRecordToJson(comment),
        },
      );

  _i2.Future<_i5.PupilData> deleteCompetenceCheck(String checkId) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'competenceCheck',
        'deleteCompetenceCheck',
        {'checkId': checkId},
      );

  _i2.Future<_i5.PupilData> addFileToCompetenceCheck(
    String checkId,
    String filePath,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'competenceCheck',
        'addFileToCompetenceCheck',
        {
          'checkId': checkId,
          'filePath': filePath,
          'createdBy': createdBy,
        },
      );

  _i2.Future<_i5.PupilData> removeFileFromCompetenceCheck(
    String checkId,
    String documentId,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
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

  _i2.Future<_i6.Competence> postCompetence({
    int? parentCompetence,
    required String name,
    required List<String> level,
    required List<String> indicators,
  }) =>
      caller.callServerEndpoint<_i6.Competence>(
        'competence',
        'postCompetence',
        {
          'parentCompetence': parentCompetence,
          'name': name,
          'level': level,
          'indicators': indicators,
        },
      );

  _i2.Future<List<_i6.Competence>> getAllCompetences() =>
      caller.callServerEndpoint<List<_i6.Competence>>(
        'competence',
        'getAllCompetences',
        {},
      );

  _i2.Future<_i6.Competence> updateCompetence(_i6.Competence competence) =>
      caller.callServerEndpoint<_i6.Competence>(
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
class EndpointLearningSupportPlan extends _i1.EndpointRef {
  EndpointLearningSupportPlan(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'learningSupportPlan';

  _i2.Future<List<_i23.LearningSupportPlan>> fetchLearningSupportPlans() =>
      caller.callServerEndpoint<List<_i23.LearningSupportPlan>>(
        'learningSupportPlan',
        'fetchLearningSupportPlans',
        {},
      );

  _i2.Future<_i23.LearningSupportPlan> createLearningSupportPlan(
          _i23.LearningSupportPlan plan) =>
      caller.callServerEndpoint<_i23.LearningSupportPlan>(
        'learningSupportPlan',
        'createLearningSupportPlan',
        {'plan': plan},
      );

  _i2.Future<bool> updateLearningSupportPlan(_i23.LearningSupportPlan plan) =>
      caller.callServerEndpoint<bool>(
        'learningSupportPlan',
        'updateLearningSupportPlan',
        {'plan': plan},
      );

  _i2.Future<bool> deleteLearningSupportPlan(_i23.LearningSupportPlan plan) =>
      caller.callServerEndpoint<bool>(
        'learningSupportPlan',
        'deleteLearningSupportPlan',
        {'plan': plan},
      );

  _i2.Future<_i5.PupilData> postSupportCategoryStatus(
    int pupilId,
    int supportCategoryId,
    int learningSupportPlanId,
    int status,
    String comment,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
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

  _i2.Future<List<_i24.SupportCategoryStatus>> fetchSupportCategoryStatus(
          int pupilId) =>
      caller.callServerEndpoint<List<_i24.SupportCategoryStatus>>(
        'learningSupportPlan',
        'fetchSupportCategoryStatus',
        {'pupilId': pupilId},
      );

  _i2.Future<List<_i24.SupportCategoryStatus>>
      fetchSupportCategoryStatusFromPupil(int pupilId) =>
          caller.callServerEndpoint<List<_i24.SupportCategoryStatus>>(
            'learningSupportPlan',
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
        'learningSupportPlan',
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
        'learningSupportPlan',
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
}

/// {@category Endpoint}
class EndpointPreSchoolMedical extends _i1.EndpointRef {
  EndpointPreSchoolMedical(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'preSchoolMedical';

  /// Create a new PreSchoolMedical record for a pupil
  _i2.Future<_i25.PreSchoolMedical> createPreSchoolMedical(
    int pupilId,
    _i26.PreSchoolMedicalStatus? preschoolMedicalStatus,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i25.PreSchoolMedical>(
        'preSchoolMedical',
        'createPreSchoolMedical',
        {
          'pupilId': pupilId,
          'preschoolMedicalStatus': preschoolMedicalStatus,
          'createdBy': createdBy,
        },
      );

  /// Update an existing PreSchoolMedical record
  _i2.Future<_i25.PreSchoolMedical> updatePreSchoolMedical(
    int preSchoolMedicalId,
    _i26.PreSchoolMedicalStatus? preschoolMedicalStatus,
    String updatedBy,
  ) =>
      caller.callServerEndpoint<_i25.PreSchoolMedical>(
        'preSchoolMedical',
        'updatePreSchoolMedical',
        {
          'preSchoolMedicalId': preSchoolMedicalId,
          'preschoolMedicalStatus': preschoolMedicalStatus,
          'updatedBy': updatedBy,
        },
      );

  /// Get a PreSchoolMedical record by ID
  _i2.Future<_i25.PreSchoolMedical?> getPreSchoolMedical(
          int preSchoolMedicalId) =>
      caller.callServerEndpoint<_i25.PreSchoolMedical?>(
        'preSchoolMedical',
        'getPreSchoolMedical',
        {'preSchoolMedicalId': preSchoolMedicalId},
      );

  /// Get PreSchoolMedical record for a specific pupil
  _i2.Future<_i25.PreSchoolMedical?> getPreSchoolMedicalByPupilId(
          int pupilId) =>
      caller.callServerEndpoint<_i25.PreSchoolMedical?>(
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
  _i2.Future<_i25.PreSchoolMedical> addFileToPreSchoolMedical(
    int preSchoolMedicalId,
    String filePath,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i25.PreSchoolMedical>(
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
  _i2.Future<List<_i25.PreSchoolMedical>> getAllPreSchoolMedicalRecords() =>
      caller.callServerEndpoint<List<_i25.PreSchoolMedical>>(
        'preSchoolMedical',
        'getAllPreSchoolMedicalRecords',
        {},
      );

  /// Get PreSchoolMedical records with specific status
  _i2.Future<List<_i25.PreSchoolMedical>> getPreSchoolMedicalByStatus(
          _i26.PreSchoolMedicalStatus status) =>
      caller.callServerEndpoint<List<_i25.PreSchoolMedical>>(
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

  _i2.Future<List<_i7.SupportCategory>> fetchSupportCategories() =>
      caller.callServerEndpoint<List<_i7.SupportCategory>>(
        'supportCategory',
        'fetchSupportCategories',
        {},
      );

  _i2.Future<List<_i7.SupportCategory>> importSupportCategoriesFromJsonFile(
          String jsonFilePath) =>
      caller.callServerEndpoint<List<_i7.SupportCategory>>(
        'supportCategory',
        'importSupportCategoriesFromJsonFile',
        {'jsonFilePath': jsonFilePath},
      );

  _i2.Future<bool> createSupportCategory(_i7.SupportCategory category) =>
      caller.callServerEndpoint<bool>(
        'supportCategory',
        'createSupportCategory',
        {'category': category},
      );

  _i2.Future<bool> updateSupportCategory(_i7.SupportCategory category) =>
      caller.callServerEndpoint<bool>(
        'supportCategory',
        'updateSupportCategory',
        {'category': category},
      );

  _i2.Future<bool> deleteSupportCategory(_i7.SupportCategory category) =>
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

  _i2.Future<List<_i27.CompulsoryRoom>?> getCompulsoryRooms() =>
      caller.callServerEndpoint<List<_i27.CompulsoryRoom>?>(
        'matrix',
        'getCompulsoryRooms',
        {},
      );

  _i2.Future<List<_i27.CompulsoryRoom>> setCompulsoryRooms(
          List<_i27.CompulsoryRoom> compulsoryRooms) =>
      caller.callServerEndpoint<List<_i27.CompulsoryRoom>>(
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
    _i28.PupilDocumentType documentType,
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

  _i2.Future<bool> bulkAddSupportLevels(
          List<_i29.SupportLevelLegacyDto> supportLevelData) =>
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

  _i2.Stream<_i30.PupilIdentityDto> streamEncryptedPupilIds(
          String channelName) =>
      caller.callStreamingServerEndpoint<_i2.Stream<_i30.PupilIdentityDto>,
          _i30.PupilIdentityDto>(
        'pupilIdentity',
        'streamEncryptedPupilIds',
        {'channelName': channelName},
        {},
      );

  _i2.Future<bool> sendPupilIdentityMessage(
    String pupilIdentityChannel,
    _i30.PupilIdentityDto pupilIdentityMessage,
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

  _i2.Future<bool> updateLastPupilIdentitiesUpdate(DateTime date) =>
      caller.callServerEndpoint<bool>(
        'pupilIdentity',
        'updateLastPupilIdentitiesUpdate',
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

  _i2.Future<_i5.PupilData> updatePupil(_i5.PupilData pupil) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupilUpdate',
        'updatePupil',
        {'pupil': pupil},
      );

  _i2.Future<_i5.PupilData> updateCommunicationSkills({
    required int pupilId,
    required _i31.CommunicationSkills? communicationSkills,
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
    _i32.TutorInfo? tutorInfo,
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
          _i33.SiblingsTutorInfo siblingsTutorInfo) =>
      caller.callServerEndpoint<List<_i5.PupilData>>(
        'pupilUpdate',
        'updateSiblingsTutorInfo',
        {'siblingsTutorInfo': siblingsTutorInfo},
      );

  _i2.Future<_i5.PupilData> updatePupilDocument(
    int pupilId,
    String filePath,
    String createdBy,
    _i28.PupilDocumentType documentType,
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
    _i26.PreSchoolMedicalStatus preSchoolMedicalStatus,
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
    _i34.PublicMediaAuth publicMediaAuth,
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
    _i35.SupportLevel supportLevel,
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

  _i2.Future<_i5.PupilData> updateSchoolyearHeldBackDate(
    int pupilId,
    ({DateTime? value}) schoolyearHeldBackDate,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
        'pupilUpdate',
        'updateSchoolyearHeldBackDate',
        {
          'pupilId': pupilId,
          'schoolyearHeldBackDate':
              _i15.mapRecordToJson(schoolyearHeldBackDate),
        },
      );

  _i2.Future<_i5.PupilData> updateAfterSchoolCare(
    int pupilId,
    _i36.AfterSchoolCare afterSchoolCare,
  ) =>
      caller.callServerEndpoint<_i5.PupilData>(
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

  _i2.Future<_i37.SchoolData> postSchoolData(_i37.SchoolData schoolData) =>
      caller.callServerEndpoint<_i37.SchoolData>(
        'schoolData',
        'postSchoolData',
        {'schoolData': schoolData},
      );

  /// TODO: we should be specific about which school data to get
  _i2.Future<_i37.SchoolData?> getSchoolData() =>
      caller.callServerEndpoint<_i37.SchoolData?>(
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

  _i2.Future<List<_i38.SchoolList>> fetchSchoolLists(String userName) =>
      caller.callServerEndpoint<List<_i38.SchoolList>>(
        'schoolList',
        'fetchSchoolLists',
        {'userName': userName},
      );

  _i2.Future<_i38.SchoolList> postSchoolList(
    String name,
    String description,
    List<int> pupilIds,
    bool public,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i38.SchoolList>(
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

  _i2.Future<_i38.SchoolList> updateSchoolList(
    int listId,
    String? name,
    String? description,
    ({String? value})? authorizedUsers,
    bool? public,
    ({_i14.MemberOperation operation, List<int> pupilIds})? updateMembers,
  ) =>
      caller.callServerEndpoint<_i38.SchoolList>(
        'schoolList',
        'updateSchoolList',
        {
          'listId': listId,
          'name': name,
          'description': description,
          'authorizedUsers': _i15.mapRecordToJson(authorizedUsers),
          'public': public,
          'updateMembers': _i15.mapRecordToJson(updateMembers),
        },
      );

  _i2.Future<bool> deleteSchoolList(int listId) =>
      caller.callServerEndpoint<bool>(
        'schoolList',
        'deleteSchoolList',
        {'listId': listId},
      );

  _i2.Future<_i39.PupilListEntry> updatePupilListEntry(
          _i39.PupilListEntry entry) =>
      caller.callServerEndpoint<_i39.PupilListEntry>(
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

  _i2.Future<_i40.SchoolSemester> createSchoolSemester(
    String schoolYearName,
    DateTime startDate,
    DateTime endDate,
    bool isFirst,
    DateTime? classConferenceDate,
    DateTime? supportConferenceDate,
    DateTime? reportConferenceDate,
    DateTime? reportSignedDate,
  ) =>
      caller.callServerEndpoint<_i40.SchoolSemester>(
        'schooldayAdmin',
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

  _i2.Future<List<_i40.SchoolSemester>> getAllSchoolSemesters() =>
      caller.callServerEndpoint<List<_i40.SchoolSemester>>(
        'schooldayAdmin',
        'getAllSchoolSemesters',
        {},
      );

  _i2.Future<_i40.SchoolSemester?> getCurrentSchoolSemester() =>
      caller.callServerEndpoint<_i40.SchoolSemester?>(
        'schooldayAdmin',
        'getCurrentSchoolSemester',
        {},
      );

  _i2.Future<bool> updateSchoolSemester(_i40.SchoolSemester schoolSemester) =>
      caller.callServerEndpoint<bool>(
        'schooldayAdmin',
        'updateSchoolSemester',
        {'schoolSemester': schoolSemester},
      );

  _i2.Future<bool> deleteSchoolSemester(_i40.SchoolSemester semester) =>
      caller.callServerEndpoint<bool>(
        'schooldayAdmin',
        'deleteSchoolSemester',
        {'semester': semester},
      );

  _i2.Future<_i41.Schoolday?> createSchoolday(DateTime date) =>
      caller.callServerEndpoint<_i41.Schoolday?>(
        'schooldayAdmin',
        'createSchoolday',
        {'date': date},
      );

  _i2.Future<List<_i41.Schoolday>> createSchooldays(List<DateTime> dates) =>
      caller.callServerEndpoint<List<_i41.Schoolday>>(
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

  _i2.Future<bool> updateSchoolday(_i41.Schoolday schoolday) =>
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

  _i2.Future<List<_i40.SchoolSemester>> getSchoolSemesters() =>
      caller.callServerEndpoint<List<_i40.SchoolSemester>>(
        'schoolday',
        'getSchoolSemesters',
        {},
      );

  _i2.Future<List<_i41.Schoolday>> getSchooldays() =>
      caller.callServerEndpoint<List<_i41.Schoolday>>(
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

  _i2.Future<List<_i42.SchooldayEvent>> fetchSchooldayEvents() =>
      caller.callServerEndpoint<List<_i42.SchooldayEvent>>(
        'schooldayEvent',
        'fetchSchooldayEvents',
        {},
      );

  _i2.Future<_i42.SchooldayEvent> createSchooldayEvent({
    required int pupilId,
    required String pupilNameAndGroup,
    required String dateTimeAsString,
    required int schooldayId,
    required _i43.SchooldayEventType type,
    required String reason,
    required String createdBy,
    required String tutor,
  }) =>
      caller.callServerEndpoint<_i42.SchooldayEvent>(
        'schooldayEvent',
        'createSchooldayEvent',
        {
          'pupilId': pupilId,
          'pupilNameAndGroup': pupilNameAndGroup,
          'dateTimeAsString': dateTimeAsString,
          'schooldayId': schooldayId,
          'type': type,
          'reason': reason,
          'createdBy': createdBy,
          'tutor': tutor,
        },
      );

  _i2.Future<_i42.SchooldayEvent> updateSchooldayEvent(
    _i42.SchooldayEvent schooldayEvent,
    bool changedProcessedStatus,
    String pupilNameAndGroup,
    String tutor,
    String modifiedBy,
    String dateTimeAsString,
  ) =>
      caller.callServerEndpoint<_i42.SchooldayEvent>(
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

  _i2.Future<_i42.SchooldayEvent> updateSchooldayEventFile(
    int schooldayEventId,
    String filePath,
    String createdBy,
    bool isprocessed,
  ) =>
      caller.callServerEndpoint<_i42.SchooldayEvent>(
        'schooldayEvent',
        'updateSchooldayEventFile',
        {
          'schooldayEventId': schooldayEventId,
          'filePath': filePath,
          'createdBy': createdBy,
          'isprocessed': isprocessed,
        },
      );

  _i2.Future<_i42.SchooldayEvent> deleteSchooldayEventFile(
    int schooldayEventId,
    bool isProcessed,
  ) =>
      caller.callServerEndpoint<_i42.SchooldayEvent>(
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

  _i2.Future<_i44.Classroom> createClassroom(_i44.Classroom classroom) =>
      caller.callServerEndpoint<_i44.Classroom>(
        'classroom',
        'createClassroom',
        {'classroom': classroom},
      );

  _i2.Future<List<_i44.Classroom>> fetchClassrooms() =>
      caller.callServerEndpoint<List<_i44.Classroom>>(
        'classroom',
        'fetchClassrooms',
        {},
      );

  _i2.Future<_i44.Classroom?> fetchClassroomById(int id) =>
      caller.callServerEndpoint<_i44.Classroom?>(
        'classroom',
        'fetchClassroomById',
        {'id': id},
      );

  _i2.Future<_i44.Classroom?> fetchClassroomByRoomCode(String roomCode) =>
      caller.callServerEndpoint<_i44.Classroom?>(
        'classroom',
        'fetchClassroomByRoomCode',
        {'roomCode': roomCode},
      );

  _i2.Future<List<_i44.Classroom>> fetchClassroomsByRoomName(String roomName) =>
      caller.callServerEndpoint<List<_i44.Classroom>>(
        'classroom',
        'fetchClassroomsByRoomName',
        {'roomName': roomName},
      );

  _i2.Future<_i44.Classroom> updateClassroom(_i44.Classroom classroom) =>
      caller.callServerEndpoint<_i44.Classroom>(
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

  _i2.Future<_i45.LessonGroup> createLessonGroup(
          _i45.LessonGroup lessonGroup) =>
      caller.callServerEndpoint<_i45.LessonGroup>(
        'learningGroup',
        'createLessonGroup',
        {'lessonGroup': lessonGroup},
      );

  _i2.Future<List<_i45.LessonGroup>> fetchLessonGroups() =>
      caller.callServerEndpoint<List<_i45.LessonGroup>>(
        'learningGroup',
        'fetchLessonGroups',
        {},
      );

  _i2.Future<_i45.LessonGroup?> fetchLessonGroupById(int id) =>
      caller.callServerEndpoint<_i45.LessonGroup?>(
        'learningGroup',
        'fetchLessonGroupById',
        {'id': id},
      );

  _i2.Future<_i45.LessonGroup?> fetchLessonGroupByPublicId(String publicId) =>
      caller.callServerEndpoint<_i45.LessonGroup?>(
        'learningGroup',
        'fetchLessonGroupByPublicId',
        {'publicId': publicId},
      );

  _i2.Future<List<_i45.LessonGroup>> fetchLessonGroupsByName(String name) =>
      caller.callServerEndpoint<List<_i45.LessonGroup>>(
        'learningGroup',
        'fetchLessonGroupsByName',
        {'name': name},
      );

  _i2.Future<List<_i45.LessonGroup>> fetchLessonGroupsByCreator(
          String createdBy) =>
      caller.callServerEndpoint<List<_i45.LessonGroup>>(
        'learningGroup',
        'fetchLessonGroupsByCreator',
        {'createdBy': createdBy},
      );

  _i2.Future<List<_i45.LessonGroup>> fetchLessonGroupsByTimetable(
          int timetableId) =>
      caller.callServerEndpoint<List<_i45.LessonGroup>>(
        'learningGroup',
        'fetchLessonGroupsByTimetable',
        {'timetableId': timetableId},
      );

  _i2.Future<_i45.LessonGroup> updateLessonGroup(
          _i45.LessonGroup lessonGroup) =>
      caller.callServerEndpoint<_i45.LessonGroup>(
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

  _i2.Future<_i46.ScheduledLesson?> createScheduledLesson(
          _i46.ScheduledLesson scheduledLesson) =>
      caller.callServerEndpoint<_i46.ScheduledLesson?>(
        'scheduledLesson',
        'createScheduledLesson',
        {'scheduledLesson': scheduledLesson},
      );

  _i2.Future<List<_i46.ScheduledLesson>> fetchScheduledLessons() =>
      caller.callServerEndpoint<List<_i46.ScheduledLesson>>(
        'scheduledLesson',
        'fetchScheduledLessons',
        {},
      );

  _i2.Future<_i46.ScheduledLesson?> fetchScheduledLessonById(int id) =>
      caller.callServerEndpoint<_i46.ScheduledLesson?>(
        'scheduledLesson',
        'fetchScheduledLessonById',
        {'id': id},
      );

  _i2.Future<List<_i46.ScheduledLesson>> fetchScheduledLessonsByTimetable(
          int timetableId) =>
      caller.callServerEndpoint<List<_i46.ScheduledLesson>>(
        'scheduledLesson',
        'fetchScheduledLessonsByTimetable',
        {'timetableId': timetableId},
      );

  _i2.Future<List<_i46.ScheduledLesson>> fetchScheduledLessonsBySubject(
          int subjectId) =>
      caller.callServerEndpoint<List<_i46.ScheduledLesson>>(
        'scheduledLesson',
        'fetchScheduledLessonsBySubject',
        {'subjectId': subjectId},
      );

  _i2.Future<List<_i46.ScheduledLesson>> fetchScheduledLessonsByRoom(
          int roomId) =>
      caller.callServerEndpoint<List<_i46.ScheduledLesson>>(
        'scheduledLesson',
        'fetchScheduledLessonsByRoom',
        {'roomId': roomId},
      );

  _i2.Future<List<_i46.ScheduledLesson>> fetchScheduledLessonsBySlotId(
          int slotId) =>
      caller.callServerEndpoint<List<_i46.ScheduledLesson>>(
        'scheduledLesson',
        'fetchScheduledLessonsBySlotId',
        {'slotId': slotId},
      );

  _i2.Future<List<_i46.ScheduledLesson>> fetchActiveScheduledLessons() =>
      caller.callServerEndpoint<List<_i46.ScheduledLesson>>(
        'scheduledLesson',
        'fetchActiveScheduledLessons',
        {},
      );

  _i2.Future<_i46.ScheduledLesson?> updateScheduledLesson(
          _i46.ScheduledLesson scheduledLesson) =>
      caller.callServerEndpoint<_i46.ScheduledLesson?>(
        'scheduledLesson',
        'updateScheduledLesson',
        {'scheduledLesson': scheduledLesson},
      );

  _i2.Future<_i46.ScheduledLesson?> deactivateScheduledLesson(int id) =>
      caller.callServerEndpoint<_i46.ScheduledLesson?>(
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

  _i2.Future<_i47.ScheduledLessonGroupMembership>
      createScheduledLessonGroupMembership(
              _i47.ScheduledLessonGroupMembership membership) =>
          caller.callServerEndpoint<_i47.ScheduledLessonGroupMembership>(
            'scheduledLessonGroupMembership',
            'createScheduledLessonGroupMembership',
            {'membership': membership},
          );

  _i2.Future<List<_i47.ScheduledLessonGroupMembership>>
      fetchScheduledLessonGroupMemberships() =>
          caller.callServerEndpoint<List<_i47.ScheduledLessonGroupMembership>>(
            'scheduledLessonGroupMembership',
            'fetchScheduledLessonGroupMemberships',
            {},
          );

  _i2.Future<_i47.ScheduledLessonGroupMembership?>
      fetchScheduledLessonGroupMembershipById(int id) =>
          caller.callServerEndpoint<_i47.ScheduledLessonGroupMembership?>(
            'scheduledLessonGroupMembership',
            'fetchScheduledLessonGroupMembershipById',
            {'id': id},
          );

  _i2.Future<List<_i47.ScheduledLessonGroupMembership>>
      fetchMembershipsByLessonGroupId(int lessonGroupId) =>
          caller.callServerEndpoint<List<_i47.ScheduledLessonGroupMembership>>(
            'scheduledLessonGroupMembership',
            'fetchMembershipsByLessonGroupId',
            {'lessonGroupId': lessonGroupId},
          );

  _i2.Future<List<_i47.ScheduledLessonGroupMembership>>
      fetchMembershipsByPupilDataId(int pupilDataId) =>
          caller.callServerEndpoint<List<_i47.ScheduledLessonGroupMembership>>(
            'scheduledLessonGroupMembership',
            'fetchMembershipsByPupilDataId',
            {'pupilDataId': pupilDataId},
          );

  _i2.Future<_i47.ScheduledLessonGroupMembership?>
      fetchMembershipByLessonGroupAndPupil(
    int lessonGroupId,
    int pupilDataId,
  ) =>
          caller.callServerEndpoint<_i47.ScheduledLessonGroupMembership?>(
            'scheduledLessonGroupMembership',
            'fetchMembershipByLessonGroupAndPupil',
            {
              'lessonGroupId': lessonGroupId,
              'pupilDataId': pupilDataId,
            },
          );

  _i2.Future<_i47.ScheduledLessonGroupMembership>
      updateScheduledLessonGroupMembership(
              _i47.ScheduledLessonGroupMembership membership) =>
          caller.callServerEndpoint<_i47.ScheduledLessonGroupMembership>(
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

  _i2.Future<_i48.Subject> createSubject(_i48.Subject subject) =>
      caller.callServerEndpoint<_i48.Subject>(
        'subject',
        'createSubject',
        {'subject': subject},
      );

  _i2.Future<List<_i48.Subject>> fetchSubjects() =>
      caller.callServerEndpoint<List<_i48.Subject>>(
        'subject',
        'fetchSubjects',
        {},
      );

  _i2.Future<_i48.Subject?> fetchSubjectById(int id) =>
      caller.callServerEndpoint<_i48.Subject?>(
        'subject',
        'fetchSubjectById',
        {'id': id},
      );

  _i2.Future<_i48.Subject?> fetchSubjectByPublicId(String publicId) =>
      caller.callServerEndpoint<_i48.Subject?>(
        'subject',
        'fetchSubjectByPublicId',
        {'publicId': publicId},
      );

  _i2.Future<List<_i48.Subject>> fetchSubjectsByName(String name) =>
      caller.callServerEndpoint<List<_i48.Subject>>(
        'subject',
        'fetchSubjectsByName',
        {'name': name},
      );

  _i2.Future<List<_i48.Subject>> fetchSubjectsByCreator(String createdBy) =>
      caller.callServerEndpoint<List<_i48.Subject>>(
        'subject',
        'fetchSubjectsByCreator',
        {'createdBy': createdBy},
      );

  _i2.Future<_i48.Subject> updateSubject(_i48.Subject subject) =>
      caller.callServerEndpoint<_i48.Subject>(
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

  _i2.Future<_i49.Timetable> createTimetable(_i49.Timetable timetable) =>
      caller.callServerEndpoint<_i49.Timetable>(
        'timetable',
        'createTimetable',
        {'timetable': timetable},
      );

  _i2.Future<List<_i49.Timetable>> fetchTimetables() =>
      caller.callServerEndpoint<List<_i49.Timetable>>(
        'timetable',
        'fetchTimetables',
        {},
      );

  _i2.Future<_i49.Timetable?> fetchTimetableById(int id) =>
      caller.callServerEndpoint<_i49.Timetable?>(
        'timetable',
        'fetchTimetableById',
        {'id': id},
      );

  _i2.Future<_i49.Timetable?> fetchTimetable() =>
      caller.callServerEndpoint<_i49.Timetable?>(
        'timetable',
        'fetchTimetable',
        {},
      );

  _i2.Future<_i49.Timetable?> fetchCompleteTimetableData() =>
      caller.callServerEndpoint<_i49.Timetable?>(
        'timetable',
        'fetchCompleteTimetableData',
        {},
      );

  _i2.Future<List<_i49.Timetable>> fetchActiveTimetables() =>
      caller.callServerEndpoint<List<_i49.Timetable>>(
        'timetable',
        'fetchActiveTimetables',
        {},
      );

  _i2.Future<List<_i49.Timetable>> fetchTimetablesBySemester(
          int schoolSemesterId) =>
      caller.callServerEndpoint<List<_i49.Timetable>>(
        'timetable',
        'fetchTimetablesBySemester',
        {'schoolSemesterId': schoolSemesterId},
      );

  _i2.Future<_i49.Timetable> updateTimetable(_i49.Timetable timetable) =>
      caller.callServerEndpoint<_i49.Timetable>(
        'timetable',
        'updateTimetable',
        {'timetable': timetable},
      );

  _i2.Future<_i49.Timetable> deactivateTimetable(int id) =>
      caller.callServerEndpoint<_i49.Timetable>(
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

  _i2.Future<_i50.TimetableSlot> createTimetableSlot(
          _i50.TimetableSlot timetableSlot) =>
      caller.callServerEndpoint<_i50.TimetableSlot>(
        'timetableSlot',
        'createTimetableSlot',
        {'timetableSlot': timetableSlot},
      );

  _i2.Future<List<_i50.TimetableSlot>> fetchTimetableSlots() =>
      caller.callServerEndpoint<List<_i50.TimetableSlot>>(
        'timetableSlot',
        'fetchTimetableSlots',
        {},
      );

  _i2.Future<_i50.TimetableSlot?> fetchTimetableSlotById(int id) =>
      caller.callServerEndpoint<_i50.TimetableSlot?>(
        'timetableSlot',
        'fetchTimetableSlotById',
        {'id': id},
      );

  _i2.Future<List<_i50.TimetableSlot>> fetchTimetableSlotsByTimetableId(
          int timetableId) =>
      caller.callServerEndpoint<List<_i50.TimetableSlot>>(
        'timetableSlot',
        'fetchTimetableSlotsByTimetableId',
        {'timetableId': timetableId},
      );

  _i2.Future<List<_i50.TimetableSlot>> fetchTimetableSlotsByDay(
          _i51.Weekday day) =>
      caller.callServerEndpoint<List<_i50.TimetableSlot>>(
        'timetableSlot',
        'fetchTimetableSlotsByDay',
        {'day': day},
      );

  _i2.Future<_i50.TimetableSlot> updateTimetableSlot(
          _i50.TimetableSlot timetableSlot) =>
      caller.callServerEndpoint<_i50.TimetableSlot>(
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

  _i2.Future<_i3.User?> getCurrentUser() =>
      caller.callServerEndpoint<_i3.User?>(
        'user',
        'getCurrentUser',
        {},
      );

  _i2.Future<List<_i3.User>> getAllUsers() =>
      caller.callServerEndpoint<List<_i3.User>>(
        'user',
        'getAllUsers',
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

  _i2.Future<_i52.PupilWorkbook> postPupilWorkbook(
    int isbn,
    int pupilId,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i52.PupilWorkbook>(
        'pupilWorkbooks',
        'postPupilWorkbook',
        {
          'isbn': isbn,
          'pupilId': pupilId,
          'createdBy': createdBy,
        },
      );

  _i2.Future<List<_i52.PupilWorkbook>> fetchPupilWorkbooks() =>
      caller.callServerEndpoint<List<_i52.PupilWorkbook>>(
        'pupilWorkbooks',
        'fetchPupilWorkbooks',
        {},
      );

  _i2.Future<List<_i52.PupilWorkbook>> fetchPupilWorkbooksFromPupil(
          int pupilId) =>
      caller.callServerEndpoint<List<_i52.PupilWorkbook>>(
        'pupilWorkbooks',
        'fetchPupilWorkbooksFromPupil',
        {'pupilId': pupilId},
      );

  _i2.Future<_i52.PupilWorkbook> updatePupilWorkbook(
          _i52.PupilWorkbook pupilWorkbook) =>
      caller.callServerEndpoint<_i52.PupilWorkbook>(
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

  _i2.Future<_i53.Workbook> postWorkbook(_i53.Workbook workbook) =>
      caller.callServerEndpoint<_i53.Workbook>(
        'workbooks',
        'postWorkbook',
        {'workbook': workbook},
      );

  _i2.Future<_i53.Workbook> fetchWorkbookByIsbn(int isbn) =>
      caller.callServerEndpoint<_i53.Workbook>(
        'workbooks',
        'fetchWorkbookByIsbn',
        {'isbn': isbn},
      );

  _i2.Future<List<_i53.Workbook>> fetchWorkbooks() =>
      caller.callServerEndpoint<List<_i53.Workbook>>(
        'workbooks',
        'fetchWorkbooks',
        {},
      );

  _i2.Future<_i53.Workbook> updateWorkbook(_i53.Workbook workbook) =>
      caller.callServerEndpoint<_i53.Workbook>(
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
  _i2.Future<_i54.ByteData?> getImage(String documentId) =>
      caller.callServerEndpoint<_i54.ByteData?>(
        'files',
        'getImage',
        {'documentId': documentId},
      );

  _i2.Future<_i54.ByteData?> getUnencryptedImage(String path) =>
      caller.callServerEndpoint<_i54.ByteData?>(
        'files',
        'getUnencryptedImage',
        {'path': path},
      );
}

class Modules {
  Modules(Client client) {
    auth = _i10.Caller(client);
  }

  late final _i10.Caller auth;
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
          _i55.Protocol(),
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
    missedSchoolday = EndpointMissedSchoolday(this);
    auth = EndpointAuth(this);
    authorization = EndpointAuthorization(this);
    pupilAuthorization = EndpointPupilAuthorization(this);
    bookTags = EndpointBookTags(this);
    books = EndpointBooks(this);
    libraryBookLocations = EndpointLibraryBookLocations(this);
    libraryBooks = EndpointLibraryBooks(this);
    pupilBookLending = EndpointPupilBookLending(this);
    competenceCheck = EndpointCompetenceCheck(this);
    competence = EndpointCompetence(this);
    learningSupportPlan = EndpointLearningSupportPlan(this);
    preSchoolMedical = EndpointPreSchoolMedical(this);
    supportCategory = EndpointSupportCategory(this);
    matrix = EndpointMatrix(this);
    pupil = EndpointPupil(this);
    pupilIdentity = EndpointPupilIdentity(this);
    pupilUpdate = EndpointPupilUpdate(this);
    schoolData = EndpointSchoolData(this);
    schoolList = EndpointSchoolList(this);
    schooldayAdmin = EndpointSchooldayAdmin(this);
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

  late final EndpointAdmin admin;

  late final EndpointMissedSchoolday missedSchoolday;

  late final EndpointAuth auth;

  late final EndpointAuthorization authorization;

  late final EndpointPupilAuthorization pupilAuthorization;

  late final EndpointBookTags bookTags;

  late final EndpointBooks books;

  late final EndpointLibraryBookLocations libraryBookLocations;

  late final EndpointLibraryBooks libraryBooks;

  late final EndpointPupilBookLending pupilBookLending;

  late final EndpointCompetenceCheck competenceCheck;

  late final EndpointCompetence competence;

  late final EndpointLearningSupportPlan learningSupportPlan;

  late final EndpointPreSchoolMedical preSchoolMedical;

  late final EndpointSupportCategory supportCategory;

  late final EndpointMatrix matrix;

  late final EndpointPupil pupil;

  late final EndpointPupilIdentity pupilIdentity;

  late final EndpointPupilUpdate pupilUpdate;

  late final EndpointSchoolData schoolData;

  late final EndpointSchoolList schoolList;

  late final EndpointSchooldayAdmin schooldayAdmin;

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
        'admin': admin,
        'missedSchoolday': missedSchoolday,
        'auth': auth,
        'authorization': authorization,
        'pupilAuthorization': pupilAuthorization,
        'bookTags': bookTags,
        'books': books,
        'libraryBookLocations': libraryBookLocations,
        'libraryBooks': libraryBooks,
        'pupilBookLending': pupilBookLending,
        'competenceCheck': competenceCheck,
        'competence': competence,
        'learningSupportPlan': learningSupportPlan,
        'preSchoolMedical': preSchoolMedical,
        'supportCategory': supportCategory,
        'matrix': matrix,
        'pupil': pupil,
        'pupilIdentity': pupilIdentity,
        'pupilUpdate': pupilUpdate,
        'schoolData': schoolData,
        'schoolList': schoolList,
        'schooldayAdmin': schooldayAdmin,
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

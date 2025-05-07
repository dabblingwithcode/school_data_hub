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
import 'package:school_data_hub_client/src/protocol/schoolday/missed_class/missed_class.dart'
    as _i3;
import 'package:school_data_hub_client/src/protocol/authorization/authorization.dart'
    as _i4;
import 'package:school_data_hub_client/src/protocol/shared/member_operation.dart'
    as _i5;
import 'package:school_data_hub_client/src/protocol/protocol.dart' as _i6;
import 'package:school_data_hub_client/src/protocol/authorization/pupil_authorization.dart'
    as _i7;
import 'package:school_data_hub_client/src/protocol/learning/competence.dart'
    as _i8;
import 'dart:io' as _i9;
import 'dart:typed_data' as _i10;
import 'package:school_data_hub_client/src/protocol/learning_support/support_category.dart'
    as _i11;
import 'package:school_data_hub_client/src/protocol/learning_support/support_category_status.dart'
    as _i12;
import 'package:school_data_hub_client/src/protocol/schoolday/missed_class/missed_class_dto.dart'
    as _i13;
import 'package:school_data_hub_client/src/protocol/pupil_data/pupil_data.dart'
    as _i14;
import 'package:school_data_hub_client/src/protocol/pupil_data/dto/pupil_document_type.dart'
    as _i15;
import 'package:school_data_hub_client/src/protocol/pupil_data/pupil_objects/communication/communication_skills.dart'
    as _i16;
import 'package:school_data_hub_client/src/protocol/pupil_data/pupil_objects/communication/tutor_info.dart'
    as _i17;
import 'package:school_data_hub_client/src/protocol/pupil_data/dto/siblings_tutor_info_dto.dart'
    as _i18;
import 'package:school_data_hub_client/src/protocol/pupil_data/pupil_objects/communication/public_media_auth.dart'
    as _i19;
import 'package:school_data_hub_client/src/protocol/learning_support/support_level.dart'
    as _i20;
import 'package:school_data_hub_client/src/protocol/school_list/school_list.dart'
    as _i21;
import 'package:school_data_hub_client/src/protocol/school_list/pupil_entry.dart'
    as _i22;
import 'package:school_data_hub_client/src/protocol/schoolday/school_semester.dart'
    as _i23;
import 'package:school_data_hub_client/src/protocol/schoolday/schoolday.dart'
    as _i24;
import 'package:school_data_hub_client/src/protocol/schoolday/schoolday_event/schoolday_event.dart'
    as _i25;
import 'package:school_data_hub_client/src/protocol/schoolday/schoolday_event/schoolday_event_type.dart'
    as _i26;
import 'package:school_data_hub_client/src/protocol/user/staff_user.dart'
    as _i27;
import 'package:school_data_hub_client/src/protocol/user/roles/roles.dart'
    as _i28;
import 'package:school_data_hub_client/src/protocol/user/device_info.dart'
    as _i29;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i30;
import 'protocol.dart' as _i31;

/// {@category Endpoint}
class EndpointAttendance extends _i1.EndpointRef {
  EndpointAttendance(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'attendance';

  _i2.Future<List<_i3.MissedClass>> fetchMissedClassesOnASchoolday(
          DateTime schoolday) =>
      caller.callServerEndpoint<List<_i3.MissedClass>>(
        'attendance',
        'fetchMissedClassesOnASchoolday',
        {'schoolday': schoolday},
      );

  _i2.Future<List<_i3.MissedClass>> fetchMissedClasses() =>
      caller.callServerEndpoint<List<_i3.MissedClass>>(
        'attendance',
        'fetchMissedClasses',
        {},
      );

  _i2.Future<bool> createMissedClass(_i3.MissedClass missedClass) =>
      caller.callServerEndpoint<bool>(
        'attendance',
        'createMissedClass',
        {'missedClass': missedClass},
      );

  _i2.Future<bool> deleteMissedClass(_i3.MissedClass missedClass) =>
      caller.callServerEndpoint<bool>(
        'attendance',
        'deleteMissedClass',
        {'missedClass': missedClass},
      );
}

/// {@category Endpoint}
class EndpointAuthorization extends _i1.EndpointRef {
  EndpointAuthorization(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'authorization';

  _i2.Future<List<_i4.Authorization>> fetchAuthorizations() =>
      caller.callServerEndpoint<List<_i4.Authorization>>(
        'authorization',
        'fetchAuthorizations',
        {},
      );

  _i2.Future<_i4.Authorization?> fetchAuthorizationById(int id) =>
      caller.callServerEndpoint<_i4.Authorization?>(
        'authorization',
        'fetchAuthorizationById',
        {'id': id},
      );

  _i2.Future<_i4.Authorization> postAuthorizationWithPupils(
    String name,
    String description,
    String createdBy,
    List<int> pupilIds,
  ) =>
      caller.callServerEndpoint<_i4.Authorization>(
        'authorization',
        'postAuthorizationWithPupils',
        {
          'name': name,
          'description': description,
          'createdBy': createdBy,
          'pupilIds': pupilIds,
        },
      );

  _i2.Future<_i4.Authorization> updateAuthorization(
    int authId,
    String? name,
    String? description,
    ({_i5.MemberOperation operation, List<int> pupilIds})? updateMembers,
  ) =>
      caller.callServerEndpoint<_i4.Authorization>(
        'authorization',
        'updateAuthorization',
        {
          'authId': authId,
          'name': name,
          'description': description,
          'updateMembers': _i6.mapRecordToJson(updateMembers),
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

  _i2.Future<_i7.PupilAuthorization> updatePupilAuthorization(
          _i7.PupilAuthorization authorization) =>
      caller.callServerEndpoint<_i7.PupilAuthorization>(
        'pupilAuthorization',
        'updatePupilAuthorization',
        {'authorization': authorization},
      );

  _i2.Future<_i7.PupilAuthorization> addFileToPupilAuthorization(
    int pupilAuthId,
    String filePath,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i7.PupilAuthorization>(
        'pupilAuthorization',
        'addFileToPupilAuthorization',
        {
          'pupilAuthId': pupilAuthId,
          'filePath': filePath,
          'createdBy': createdBy,
        },
      );

  _i2.Future<_i7.PupilAuthorization> removeFileFromPupilAuthorization(
          int pupilAuthId) =>
      caller.callServerEndpoint<_i7.PupilAuthorization>(
        'pupilAuthorization',
        'removeFileFromPupilAuthorization',
        {'pupilAuthId': pupilAuthId},
      );
}

/// {@category Endpoint}
class EndpointCompetence extends _i1.EndpointRef {
  EndpointCompetence(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'competence';

  _i2.Future<List<_i8.Competence>> importCompetencesFromJsonFile(
          _i9.File jsonFile) =>
      caller.callServerEndpoint<List<_i8.Competence>>(
        'competence',
        'importCompetencesFromJsonFile',
        {'jsonFile': jsonFile},
      );

  _i2.Future<_i8.Competence> postCompetence({
    int? parentCompetence,
    required String name,
    required List<String> level,
    required List<String> indicators,
  }) =>
      caller.callServerEndpoint<_i8.Competence>(
        'competence',
        'postCompetence',
        {
          'parentCompetence': parentCompetence,
          'name': name,
          'level': level,
          'indicators': indicators,
        },
      );

  _i2.Future<List<_i8.Competence>> getAllCompetences() =>
      caller.callServerEndpoint<List<_i8.Competence>>(
        'competence',
        'getAllCompetences',
        {},
      );

  _i2.Future<_i8.Competence> updateCompetence(_i8.Competence competence) =>
      caller.callServerEndpoint<_i8.Competence>(
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
  _i2.Future<_i10.ByteData?> getImage(String documentId) =>
      caller.callServerEndpoint<_i10.ByteData?>(
        'files',
        'getImage',
        {'documentId': documentId},
      );
}

/// {@category Endpoint}
class EndpointSupportCategory extends _i1.EndpointRef {
  EndpointSupportCategory(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'supportCategory';

  _i2.Future<List<_i11.SupportCategory>> fetchSupportCategories() =>
      caller.callServerEndpoint<List<_i11.SupportCategory>>(
        'supportCategory',
        'fetchSupportCategories',
        {},
      );

  _i2.Future<List<_i11.SupportCategory>> importSupportCategoriesFromJsonFile(
          String jsonFilePath) =>
      caller.callServerEndpoint<List<_i11.SupportCategory>>(
        'supportCategory',
        'importSupportCategoriesFromJsonFile',
        {'jsonFilePath': jsonFilePath},
      );

  _i2.Future<bool> createSupportCategory(_i11.SupportCategory category) =>
      caller.callServerEndpoint<bool>(
        'supportCategory',
        'createSupportCategory',
        {'category': category},
      );

  _i2.Future<bool> updateSupportCategory(_i11.SupportCategory category) =>
      caller.callServerEndpoint<bool>(
        'supportCategory',
        'updateSupportCategory',
        {'category': category},
      );

  _i2.Future<bool> deleteSupportCategory(_i11.SupportCategory category) =>
      caller.callServerEndpoint<bool>(
        'supportCategory',
        'deleteSupportCategory',
        {'category': category},
      );

  _i2.Future<_i12.SupportCategoryStatus> postCategoryStatus(
    int pupilId,
    int supportCategoryId,
    int status,
    String comment,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i12.SupportCategoryStatus>(
        'supportCategory',
        'postCategoryStatus',
        {
          'pupilId': pupilId,
          'supportCategoryId': supportCategoryId,
          'status': status,
          'comment': comment,
          'createdBy': createdBy,
        },
      );

  _i2.Future<_i12.SupportCategoryStatus> updateCategoryStatus(
    int pupilId,
    int supportCategoryId,
    int? status,
    String? comment,
    String? createdBy,
    DateTime? createdAt,
  ) =>
      caller.callServerEndpoint<_i12.SupportCategoryStatus>(
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
}

/// {@category Endpoint}
class EndpointMissedClass extends _i1.EndpointRef {
  EndpointMissedClass(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'missedClass';

  _i2.Stream<_i13.MissedClassDto> streamMyModels() =>
      caller.callStreamingServerEndpoint<_i2.Stream<_i13.MissedClassDto>,
          _i13.MissedClassDto>(
        'missedClass',
        'streamMyModels',
        {},
        {},
      );

  _i2.Future<_i3.MissedClass> postMissedClass(_i3.MissedClass missedClass) =>
      caller.callServerEndpoint<_i3.MissedClass>(
        'missedClass',
        'postMissedClass',
        {'missedClass': missedClass},
      );

  _i2.Future<List<_i3.MissedClass>> postMissedClasses(
          List<_i3.MissedClass> missedClasses) =>
      caller.callServerEndpoint<List<_i3.MissedClass>>(
        'missedClass',
        'postMissedClasses',
        {'missedClasses': missedClasses},
      );

  _i2.Future<List<_i3.MissedClass>> fetchAllMissedClasses() =>
      caller.callServerEndpoint<List<_i3.MissedClass>>(
        'missedClass',
        'fetchAllMissedClasses',
        {},
      );

  _i2.Future<List<_i3.MissedClass>> fetchMissedClassesOnASchoolday(
          DateTime schoolday) =>
      caller.callServerEndpoint<List<_i3.MissedClass>>(
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

  _i2.Future<_i3.MissedClass> updateMissedClass(_i3.MissedClass missedClass) =>
      caller.callServerEndpoint<_i3.MissedClass>(
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

  _i2.Stream<List<_i14.PupilData>> fetchPupilsAsStream() =>
      caller.callStreamingServerEndpoint<_i2.Stream<List<_i14.PupilData>>,
          List<_i14.PupilData>>(
        'pupil',
        'fetchPupilsAsStream',
        {},
        {},
      );

  _i2.Future<List<_i14.PupilData>> fetchPupils() =>
      caller.callServerEndpoint<List<_i14.PupilData>>(
        'pupil',
        'fetchPupils',
        {},
      );

  _i2.Future<List<_i14.PupilData>> fetchPupilsById(Set<int> internalIds) =>
      caller.callServerEndpoint<List<_i14.PupilData>>(
        'pupil',
        'fetchPupilsById',
        {'internalIds': internalIds},
      );

  _i2.Future<_i14.PupilData> deletePupilDocument(
    int pupilId,
    _i15.PupilDocumentType documentType,
  ) =>
      caller.callServerEndpoint<_i14.PupilData>(
        'pupil',
        'deletePupilDocument',
        {
          'pupilId': pupilId,
          'documentType': documentType,
        },
      );

  _i2.Future<_i14.PupilData> resetPublicMediaAuth(
    int pupilId,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i14.PupilData>(
        'pupil',
        'resetPublicMediaAuth',
        {
          'pupilId': pupilId,
          'createdBy': createdBy,
        },
      );

  _i2.Future<_i14.PupilData> deleteSupportLevelHistoryItem(
    int pupilId,
    int supportLevelId,
  ) =>
      caller.callServerEndpoint<_i14.PupilData>(
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

  _i2.Future<_i14.PupilData> updatePupil(_i14.PupilData pupil) =>
      caller.callServerEndpoint<_i14.PupilData>(
        'pupilUpdate',
        'updatePupil',
        {'pupil': pupil},
      );

  _i2.Future<_i14.PupilData> updateCommunicationSkills({
    required int pupilId,
    required _i16.CommunicationSkills? communicationSkills,
  }) =>
      caller.callServerEndpoint<_i14.PupilData>(
        'pupilUpdate',
        'updateCommunicationSkills',
        {
          'pupilId': pupilId,
          'communicationSkills': communicationSkills,
        },
      );

  _i2.Future<_i14.PupilData> updateTutorInfo(
    int pupilId,
    _i17.TutorInfo? tutorInfo,
  ) =>
      caller.callServerEndpoint<_i14.PupilData>(
        'pupilUpdate',
        'updateTutorInfo',
        {
          'pupilId': pupilId,
          'tutorInfo': tutorInfo,
        },
      );

  _i2.Future<List<_i14.PupilData>> updateSiblingsTutorInfo(
          _i18.SiblingsTutorInfo siblingsTutorInfo) =>
      caller.callServerEndpoint<List<_i14.PupilData>>(
        'pupilUpdate',
        'updateSiblingsTutorInfo',
        {'siblingsTutorInfo': siblingsTutorInfo},
      );

  _i2.Future<_i14.PupilData> updatePupilDocument(
    int pupilId,
    String filePath,
    String createdBy,
    _i15.PupilDocumentType documentType,
  ) =>
      caller.callServerEndpoint<_i14.PupilData>(
        'pupilUpdate',
        'updatePupilDocument',
        {
          'pupilId': pupilId,
          'filePath': filePath,
          'createdBy': createdBy,
          'documentType': documentType,
        },
      );

  _i2.Future<_i14.PupilData> updateStringProperty(
    int pupilId,
    String property,
    String? value,
  ) =>
      caller.callServerEndpoint<_i14.PupilData>(
        'pupilUpdate',
        'updateStringProperty',
        {
          'pupilId': pupilId,
          'property': property,
          'value': value,
        },
      );

  _i2.Future<_i14.PupilData> updateCredit(
    int pupilId,
    int value,
    String? description,
    String sender,
  ) =>
      caller.callServerEndpoint<_i14.PupilData>(
        'pupilUpdate',
        'updateCredit',
        {
          'pupilId': pupilId,
          'value': value,
          'description': description,
          'sender': sender,
        },
      );

  _i2.Future<_i14.PupilData> updatePublicMediaAuth(
    int pupilId,
    _i19.PublicMediaAuth publicMediaAuth,
  ) =>
      caller.callServerEndpoint<_i14.PupilData>(
        'pupilUpdate',
        'updatePublicMediaAuth',
        {
          'pupilId': pupilId,
          'publicMediaAuth': publicMediaAuth,
        },
      );

  _i2.Future<_i14.PupilData> updateSupportLevel(
    _i20.SupportLevel supportLevel,
    int pupilId,
  ) =>
      caller.callServerEndpoint<_i14.PupilData>(
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

  _i2.Future<List<_i21.SchoolList>> fetchSchoolLists(String userName) =>
      caller.callServerEndpoint<List<_i21.SchoolList>>(
        'schoolList',
        'fetchSchoolLists',
        {'userName': userName},
      );

  _i2.Future<_i21.SchoolList> postSchoolList(
    String name,
    String description,
    List<int> pupilIds,
    bool public,
    String createdBy,
  ) =>
      caller.callServerEndpoint<_i21.SchoolList>(
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

  _i2.Future<_i21.SchoolList> updateSchoolList(
    int listId,
    String? name,
    String? description,
    bool? public,
    ({_i5.MemberOperation operation, List<int> pupilIds})? updateMembers,
  ) =>
      caller.callServerEndpoint<_i21.SchoolList>(
        'schoolList',
        'updateSchoolList',
        {
          'listId': listId,
          'name': name,
          'description': description,
          'public': public,
          'updateMembers': _i6.mapRecordToJson(updateMembers),
        },
      );

  _i2.Future<bool> deleteSchoolList(int listId) =>
      caller.callServerEndpoint<bool>(
        'schoolList',
        'deleteSchoolList',
        {'listId': listId},
      );

  _i2.Future<_i22.PupilListEntry> updatePupilListEntry(
          _i22.PupilListEntry entry) =>
      caller.callServerEndpoint<_i22.PupilListEntry>(
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

  _i2.Future<_i23.SchoolSemester> createSchoolSemester(
    DateTime startDate,
    DateTime endDate,
    bool isFirst,
    DateTime classConferenceDate,
    DateTime supportConferenceDate,
    DateTime reportSignedDate,
  ) =>
      caller.callServerEndpoint<_i23.SchoolSemester>(
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

  _i2.Future<List<_i23.SchoolSemester>> getAllSchoolSemesters() =>
      caller.callServerEndpoint<List<_i23.SchoolSemester>>(
        'schooldayAdmin',
        'getAllSchoolSemesters',
        {},
      );

  _i2.Future<_i23.SchoolSemester?> getCurrentSchoolSemester() =>
      caller.callServerEndpoint<_i23.SchoolSemester?>(
        'schooldayAdmin',
        'getCurrentSchoolSemester',
        {},
      );

  _i2.Future<bool> updateSchoolSemester(_i23.SchoolSemester schoolSemester) =>
      caller.callServerEndpoint<bool>(
        'schooldayAdmin',
        'updateSchoolSemester',
        {'schoolSemester': schoolSemester},
      );

  _i2.Future<bool> deleteSchoolSemester(_i23.SchoolSemester semester) =>
      caller.callServerEndpoint<bool>(
        'schooldayAdmin',
        'deleteSchoolSemester',
        {'semester': semester},
      );

  _i2.Future<_i24.Schoolday?> createSchoolday(DateTime date) =>
      caller.callServerEndpoint<_i24.Schoolday?>(
        'schooldayAdmin',
        'createSchoolday',
        {'date': date},
      );

  _i2.Future<List<_i24.Schoolday>> createSchooldays(List<DateTime> dates) =>
      caller.callServerEndpoint<List<_i24.Schoolday>>(
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

  _i2.Future<bool> updateSchoolday(_i24.Schoolday schoolday) =>
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

  _i2.Future<List<_i23.SchoolSemester>> getSchoolSemesters() =>
      caller.callServerEndpoint<List<_i23.SchoolSemester>>(
        'schoolday',
        'getSchoolSemesters',
        {},
      );

  _i2.Future<List<_i24.Schoolday>> getSchooldays() =>
      caller.callServerEndpoint<List<_i24.Schoolday>>(
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

  _i2.Future<List<_i25.SchooldayEvent>> fetchSchooldayEvents() =>
      caller.callServerEndpoint<List<_i25.SchooldayEvent>>(
        'schooldayEvent',
        'fetchSchooldayEvents',
        {},
      );

  _i2.Future<_i25.SchooldayEvent> createSchooldayEvent({
    required int pupilId,
    required int schooldayId,
    required _i26.SchooldayEventType type,
    required String reason,
    required String createdBy,
  }) =>
      caller.callServerEndpoint<_i25.SchooldayEvent>(
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

  _i2.Future<_i25.SchooldayEvent> updateSchooldayEvent(
    _i25.SchooldayEvent schooldayEvent,
    bool changedProcessedToFalse,
  ) =>
      caller.callServerEndpoint<_i25.SchooldayEvent>(
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

  _i2.Future<_i25.SchooldayEvent> updateSchooldayEventFile(
    int schooldayEventId,
    String filePath,
    String createdBy,
    bool isprocessed,
  ) =>
      caller.callServerEndpoint<_i25.SchooldayEvent>(
        'schooldayEvent',
        'updateSchooldayEventFile',
        {
          'schooldayEventId': schooldayEventId,
          'filePath': filePath,
          'createdBy': createdBy,
          'isprocessed': isprocessed,
        },
      );

  _i2.Future<_i25.SchooldayEvent> deleteSchooldayEventFile(
    int schooldayEventId,
    bool isProcessed,
  ) =>
      caller.callServerEndpoint<_i25.SchooldayEvent>(
        'schooldayEvent',
        'deleteSchooldayEventFile',
        {
          'schooldayEventId': schooldayEventId,
          'isProcessed': isProcessed,
        },
      );
}

/// The endpoint for admin operations.
/// This endpoint requires the user to be logged in and have admin scope.
/// {@category Endpoint}
class EndpointAdmin extends _i1.EndpointRef {
  EndpointAdmin(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  _i2.Future<_i27.User> createUser({
    required String userName,
    required String fullName,
    required String email,
    required String password,
    required _i28.Role role,
    required int timeUnits,
    required List<String> scopeNames,
  }) =>
      caller.callServerEndpoint<_i27.User>(
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

  _i2.Future<List<_i27.User>> getAllUsers() =>
      caller.callServerEndpoint<List<_i27.User>>(
        'admin',
        'getAllUsers',
        {},
      );

  _i2.Future<_i27.User?> getUserById(int userId) =>
      caller.callServerEndpoint<_i27.User?>(
        'admin',
        'getUserById',
        {'userId': userId},
      );

  _i2.Future<Set<_i14.PupilData>> updateBackendPupilDataState(
          String filePath) =>
      caller.callServerEndpoint<Set<_i14.PupilData>>(
        'admin',
        'updateBackendPupilDataState',
        {'filePath': filePath},
      );
}

/// {@category Endpoint}
class EndpointAuth extends _i1.EndpointRef {
  EndpointAuth(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  _i2.Future<
          ({_i29.DeviceInfo? deviceInfo, _i30.AuthenticationResponse response})>
      login(
    String email,
    String password,
    _i29.DeviceInfo deviceInfo,
  ) =>
          caller.callServerEndpoint<
              ({
                _i29.DeviceInfo? deviceInfo,
                _i30.AuthenticationResponse response
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

  _i2.Future<_i27.User?> getCurrentUser() =>
      caller.callServerEndpoint<_i27.User?>(
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
    auth = _i30.Caller(client);
  }

  late final _i30.Caller auth;
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
          _i31.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    attendance = EndpointAttendance(this);
    authorization = EndpointAuthorization(this);
    pupilAuthorization = EndpointPupilAuthorization(this);
    competence = EndpointCompetence(this);
    files = EndpointFiles(this);
    supportCategory = EndpointSupportCategory(this);
    missedClass = EndpointMissedClass(this);
    pupil = EndpointPupil(this);
    pupilUpdate = EndpointPupilUpdate(this);
    schoolList = EndpointSchoolList(this);
    schooldayAdmin = EndpointSchooldayAdmin(this);
    schoolday = EndpointSchoolday(this);
    schooldayEvent = EndpointSchooldayEvent(this);
    admin = EndpointAdmin(this);
    auth = EndpointAuth(this);
    user = EndpointUser(this);
    modules = Modules(this);
  }

  late final EndpointAttendance attendance;

  late final EndpointAuthorization authorization;

  late final EndpointPupilAuthorization pupilAuthorization;

  late final EndpointCompetence competence;

  late final EndpointFiles files;

  late final EndpointSupportCategory supportCategory;

  late final EndpointMissedClass missedClass;

  late final EndpointPupil pupil;

  late final EndpointPupilUpdate pupilUpdate;

  late final EndpointSchoolList schoolList;

  late final EndpointSchooldayAdmin schooldayAdmin;

  late final EndpointSchoolday schoolday;

  late final EndpointSchooldayEvent schooldayEvent;

  late final EndpointAdmin admin;

  late final EndpointAuth auth;

  late final EndpointUser user;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'attendance': attendance,
        'authorization': authorization,
        'pupilAuthorization': pupilAuthorization,
        'competence': competence,
        'files': files,
        'supportCategory': supportCategory,
        'missedClass': missedClass,
        'pupil': pupil,
        'pupilUpdate': pupilUpdate,
        'schoolList': schoolList,
        'schooldayAdmin': schooldayAdmin,
        'schoolday': schoolday,
        'schooldayEvent': schooldayEvent,
        'admin': admin,
        'auth': auth,
        'user': user,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}

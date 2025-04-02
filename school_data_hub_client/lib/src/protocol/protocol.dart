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
import 'authorization/authorization.dart' as _i2;
import 'authorization/pupil_authorization.dart' as _i3;
import 'book/book.dart' as _i4;
import 'book/book_tagging/book_tag.dart' as _i5;
import 'book/book_tagging/book_tagging.dart' as _i6;
import 'book/library_book.dart' as _i7;
import 'book/location/library_book_location.dart' as _i8;
import 'book/pupil_book_lending.dart' as _i9;
import 'book/pupil_book_lending_file.dart' as _i10;
import 'example.dart' as _i11;
import 'learning/competence.dart' as _i12;
import 'learning/competence_check.dart' as _i13;
import 'learning/competence_check_file.dart' as _i14;
import 'learning/competence_goal.dart' as _i15;
import 'learning/competence_report.dart' as _i16;
import 'learning/competence_report_check.dart' as _i17;
import 'learning_support/support_category.dart' as _i18;
import 'learning_support/support_category_status.dart' as _i19;
import 'learning_support/support_goal/support_goal.dart' as _i20;
import 'learning_support/support_goal/support_goal_check.dart' as _i21;
import 'learning_support/support_goal/support_goal_check_file.dart' as _i22;
import 'learning_support/support_level.dart' as _i23;
import 'pupil_data/dto/siblings_parent_info_dto.dart' as _i24;
import 'pupil_data/pupil_data.dart' as _i25;
import 'pupil_data/pupil_data_parent_info.dart' as _i26;
import 'pupil_data/pupil_enums.dart' as _i27;
import 'school_list/pupil_list.dart' as _i28;
import 'school_list/school_list.dart' as _i29;
import 'schoolday/missed_class.dart' as _i30;
import 'schoolday/school_semester.dart' as _i31;
import 'schoolday/schoolday.dart' as _i32;
import 'schoolday/schoolday_event.dart' as _i33;
import 'user/roles/auth_level.dart' as _i34;
import 'user/roles/roles.dart' as _i35;
import 'user/roles/staff.dart' as _i36;
import 'workbook/pupil_workbook.dart' as _i37;
import 'workbook/workbook.dart' as _i38;
import 'package:school_data_hub_client/src/protocol/pupil_data/pupil_data.dart'
    as _i39;
import 'package:school_data_hub_client/src/protocol/schoolday/schoolday.dart'
    as _i40;
import 'package:school_data_hub_client/src/protocol/schoolday/school_semester.dart'
    as _i41;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i42;
export 'authorization/authorization.dart';
export 'authorization/pupil_authorization.dart';
export 'book/book.dart';
export 'book/book_tagging/book_tag.dart';
export 'book/book_tagging/book_tagging.dart';
export 'book/library_book.dart';
export 'book/location/library_book_location.dart';
export 'book/pupil_book_lending.dart';
export 'book/pupil_book_lending_file.dart';
export 'example.dart';
export 'learning/competence.dart';
export 'learning/competence_check.dart';
export 'learning/competence_check_file.dart';
export 'learning/competence_goal.dart';
export 'learning/competence_report.dart';
export 'learning/competence_report_check.dart';
export 'learning_support/support_category.dart';
export 'learning_support/support_category_status.dart';
export 'learning_support/support_goal/support_goal.dart';
export 'learning_support/support_goal/support_goal_check.dart';
export 'learning_support/support_goal/support_goal_check_file.dart';
export 'learning_support/support_level.dart';
export 'pupil_data/dto/siblings_parent_info_dto.dart';
export 'pupil_data/pupil_data.dart';
export 'pupil_data/pupil_data_parent_info.dart';
export 'pupil_data/pupil_enums.dart';
export 'school_list/pupil_list.dart';
export 'school_list/school_list.dart';
export 'schoolday/missed_class.dart';
export 'schoolday/school_semester.dart';
export 'schoolday/schoolday.dart';
export 'schoolday/schoolday_event.dart';
export 'user/roles/auth_level.dart';
export 'user/roles/roles.dart';
export 'user/roles/staff.dart';
export 'workbook/pupil_workbook.dart';
export 'workbook/workbook.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.Authorization) {
      return _i2.Authorization.fromJson(data) as T;
    }
    if (t == _i3.PupilAuthorization) {
      return _i3.PupilAuthorization.fromJson(data) as T;
    }
    if (t == _i4.Book) {
      return _i4.Book.fromJson(data) as T;
    }
    if (t == _i5.BookTag) {
      return _i5.BookTag.fromJson(data) as T;
    }
    if (t == _i6.BookTagging) {
      return _i6.BookTagging.fromJson(data) as T;
    }
    if (t == _i7.LibraryBook) {
      return _i7.LibraryBook.fromJson(data) as T;
    }
    if (t == _i8.LibraryBookLocation) {
      return _i8.LibraryBookLocation.fromJson(data) as T;
    }
    if (t == _i9.PupilBookLending) {
      return _i9.PupilBookLending.fromJson(data) as T;
    }
    if (t == _i10.PupilBookLendingFile) {
      return _i10.PupilBookLendingFile.fromJson(data) as T;
    }
    if (t == _i11.Example) {
      return _i11.Example.fromJson(data) as T;
    }
    if (t == _i12.Competence) {
      return _i12.Competence.fromJson(data) as T;
    }
    if (t == _i13.CompetenceCheck) {
      return _i13.CompetenceCheck.fromJson(data) as T;
    }
    if (t == _i14.CompetenceCheckFile) {
      return _i14.CompetenceCheckFile.fromJson(data) as T;
    }
    if (t == _i15.CompetenceGoal) {
      return _i15.CompetenceGoal.fromJson(data) as T;
    }
    if (t == _i16.CompetenceReport) {
      return _i16.CompetenceReport.fromJson(data) as T;
    }
    if (t == _i17.CompetenceReportCheck) {
      return _i17.CompetenceReportCheck.fromJson(data) as T;
    }
    if (t == _i18.SupportCategory) {
      return _i18.SupportCategory.fromJson(data) as T;
    }
    if (t == _i19.SupportCategoryStatus) {
      return _i19.SupportCategoryStatus.fromJson(data) as T;
    }
    if (t == _i20.SupportGoal) {
      return _i20.SupportGoal.fromJson(data) as T;
    }
    if (t == _i21.SupportGoalCheck) {
      return _i21.SupportGoalCheck.fromJson(data) as T;
    }
    if (t == _i22.SupportGoalCheckFile) {
      return _i22.SupportGoalCheckFile.fromJson(data) as T;
    }
    if (t == _i23.SupportLevel) {
      return _i23.SupportLevel.fromJson(data) as T;
    }
    if (t == _i24.SiblingsParentInfo) {
      return _i24.SiblingsParentInfo.fromJson(data) as T;
    }
    if (t == _i25.PupilData) {
      return _i25.PupilData.fromJson(data) as T;
    }
    if (t == _i26.PupilDataParentInfo) {
      return _i26.PupilDataParentInfo.fromJson(data) as T;
    }
    if (t == _i27.PreSchoolRevision) {
      return _i27.PreSchoolRevision.fromJson(data) as T;
    }
    if (t == _i28.PupilList) {
      return _i28.PupilList.fromJson(data) as T;
    }
    if (t == _i29.SchoolList) {
      return _i29.SchoolList.fromJson(data) as T;
    }
    if (t == _i30.MissedClass) {
      return _i30.MissedClass.fromJson(data) as T;
    }
    if (t == _i31.SchoolSemester) {
      return _i31.SchoolSemester.fromJson(data) as T;
    }
    if (t == _i32.Schoolday) {
      return _i32.Schoolday.fromJson(data) as T;
    }
    if (t == _i33.SchooldayEvent) {
      return _i33.SchooldayEvent.fromJson(data) as T;
    }
    if (t == _i34.AuthLevel) {
      return _i34.AuthLevel.fromJson(data) as T;
    }
    if (t == _i35.Role) {
      return _i35.Role.fromJson(data) as T;
    }
    if (t == _i36.Staff) {
      return _i36.Staff.fromJson(data) as T;
    }
    if (t == _i37.PupilWorkbook) {
      return _i37.PupilWorkbook.fromJson(data) as T;
    }
    if (t == _i38.Workbook) {
      return _i38.Workbook.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Authorization?>()) {
      return (data != null ? _i2.Authorization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.PupilAuthorization?>()) {
      return (data != null ? _i3.PupilAuthorization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Book?>()) {
      return (data != null ? _i4.Book.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.BookTag?>()) {
      return (data != null ? _i5.BookTag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.BookTagging?>()) {
      return (data != null ? _i6.BookTagging.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.LibraryBook?>()) {
      return (data != null ? _i7.LibraryBook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.LibraryBookLocation?>()) {
      return (data != null ? _i8.LibraryBookLocation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.PupilBookLending?>()) {
      return (data != null ? _i9.PupilBookLending.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.PupilBookLendingFile?>()) {
      return (data != null ? _i10.PupilBookLendingFile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.Example?>()) {
      return (data != null ? _i11.Example.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.Competence?>()) {
      return (data != null ? _i12.Competence.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.CompetenceCheck?>()) {
      return (data != null ? _i13.CompetenceCheck.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.CompetenceCheckFile?>()) {
      return (data != null ? _i14.CompetenceCheckFile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.CompetenceGoal?>()) {
      return (data != null ? _i15.CompetenceGoal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.CompetenceReport?>()) {
      return (data != null ? _i16.CompetenceReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.CompetenceReportCheck?>()) {
      return (data != null ? _i17.CompetenceReportCheck.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i18.SupportCategory?>()) {
      return (data != null ? _i18.SupportCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.SupportCategoryStatus?>()) {
      return (data != null ? _i19.SupportCategoryStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.SupportGoal?>()) {
      return (data != null ? _i20.SupportGoal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.SupportGoalCheck?>()) {
      return (data != null ? _i21.SupportGoalCheck.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.SupportGoalCheckFile?>()) {
      return (data != null ? _i22.SupportGoalCheckFile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.SupportLevel?>()) {
      return (data != null ? _i23.SupportLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.SiblingsParentInfo?>()) {
      return (data != null ? _i24.SiblingsParentInfo.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.PupilData?>()) {
      return (data != null ? _i25.PupilData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.PupilDataParentInfo?>()) {
      return (data != null ? _i26.PupilDataParentInfo.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i27.PreSchoolRevision?>()) {
      return (data != null ? _i27.PreSchoolRevision.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.PupilList?>()) {
      return (data != null ? _i28.PupilList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.SchoolList?>()) {
      return (data != null ? _i29.SchoolList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.MissedClass?>()) {
      return (data != null ? _i30.MissedClass.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.SchoolSemester?>()) {
      return (data != null ? _i31.SchoolSemester.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.Schoolday?>()) {
      return (data != null ? _i32.Schoolday.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.SchooldayEvent?>()) {
      return (data != null ? _i33.SchooldayEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.AuthLevel?>()) {
      return (data != null ? _i34.AuthLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.Role?>()) {
      return (data != null ? _i35.Role.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.Staff?>()) {
      return (data != null ? _i36.Staff.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.PupilWorkbook?>()) {
      return (data != null ? _i37.PupilWorkbook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.Workbook?>()) {
      return (data != null ? _i38.Workbook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<List<_i3.PupilAuthorization>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i3.PupilAuthorization>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i6.BookTagging>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i6.BookTagging>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i7.LibraryBook>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i7.LibraryBook>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i6.BookTagging>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i6.BookTagging>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i9.PupilBookLending>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i9.PupilBookLending>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i7.LibraryBook>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i7.LibraryBook>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i10.PupilBookLendingFile>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i10.PupilBookLendingFile>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i15.CompetenceGoal>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i15.CompetenceGoal>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i13.CompetenceCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i13.CompetenceCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i17.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i17.CompetenceReportCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i14.CompetenceCheckFile>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i14.CompetenceCheckFile>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i17.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i17.CompetenceReportCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i20.SupportGoal>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i20.SupportGoal>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i19.SupportCategoryStatus>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.SupportCategoryStatus>(e))
              .toList()
          : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<List<_i21.SupportGoalCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i21.SupportGoalCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i22.SupportGoalCheckFile>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i22.SupportGoalCheckFile>(e))
              .toList()
          : null) as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _i1.getType<List<_i3.PupilAuthorization>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i3.PupilAuthorization>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i30.MissedClass>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i30.MissedClass>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i33.SchooldayEvent>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i33.SchooldayEvent>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i38.Workbook>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i38.Workbook>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i20.SupportGoal>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i20.SupportGoal>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i19.SupportCategoryStatus>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.SupportCategoryStatus>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i37.PupilWorkbook>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i37.PupilWorkbook>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i9.PupilBookLending>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i9.PupilBookLending>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i15.CompetenceGoal>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i15.CompetenceGoal>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i13.CompetenceCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i13.CompetenceCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i16.CompetenceReport>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i16.CompetenceReport>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i17.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i17.CompetenceReportCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i28.PupilList>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i28.PupilList>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Set<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toSet()
          : null) as T;
    }
    if (t == _i1.getType<List<_i28.PupilList>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i28.PupilList>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i32.Schoolday>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i32.Schoolday>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i16.CompetenceReport>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i16.CompetenceReport>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i30.MissedClass>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i30.MissedClass>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i33.SchooldayEvent>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i33.SchooldayEvent>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i37.PupilWorkbook>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i37.PupilWorkbook>(e))
              .toList()
          : null) as T;
    }
    if (t == List<_i39.PupilData>) {
      return (data as List).map((e) => deserialize<_i39.PupilData>(e)).toList()
          as T;
    }
    if (t == List<_i40.Schoolday>) {
      return (data as List).map((e) => deserialize<_i40.Schoolday>(e)).toList()
          as T;
    }
    if (t == List<DateTime>) {
      return (data as List).map((e) => deserialize<DateTime>(e)).toList() as T;
    }
    if (t == List<_i41.SchoolSemester>) {
      return (data as List)
          .map((e) => deserialize<_i41.SchoolSemester>(e))
          .toList() as T;
    }
    try {
      return _i42.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.Authorization) {
      return 'Authorization';
    }
    if (data is _i3.PupilAuthorization) {
      return 'PupilAuthorization';
    }
    if (data is _i4.Book) {
      return 'Book';
    }
    if (data is _i5.BookTag) {
      return 'BookTag';
    }
    if (data is _i6.BookTagging) {
      return 'BookTagging';
    }
    if (data is _i7.LibraryBook) {
      return 'LibraryBook';
    }
    if (data is _i8.LibraryBookLocation) {
      return 'LibraryBookLocation';
    }
    if (data is _i9.PupilBookLending) {
      return 'PupilBookLending';
    }
    if (data is _i10.PupilBookLendingFile) {
      return 'PupilBookLendingFile';
    }
    if (data is _i11.Example) {
      return 'Example';
    }
    if (data is _i12.Competence) {
      return 'Competence';
    }
    if (data is _i13.CompetenceCheck) {
      return 'CompetenceCheck';
    }
    if (data is _i14.CompetenceCheckFile) {
      return 'CompetenceCheckFile';
    }
    if (data is _i15.CompetenceGoal) {
      return 'CompetenceGoal';
    }
    if (data is _i16.CompetenceReport) {
      return 'CompetenceReport';
    }
    if (data is _i17.CompetenceReportCheck) {
      return 'CompetenceReportCheck';
    }
    if (data is _i18.SupportCategory) {
      return 'SupportCategory';
    }
    if (data is _i19.SupportCategoryStatus) {
      return 'SupportCategoryStatus';
    }
    if (data is _i20.SupportGoal) {
      return 'SupportGoal';
    }
    if (data is _i21.SupportGoalCheck) {
      return 'SupportGoalCheck';
    }
    if (data is _i22.SupportGoalCheckFile) {
      return 'SupportGoalCheckFile';
    }
    if (data is _i23.SupportLevel) {
      return 'SupportLevel';
    }
    if (data is _i24.SiblingsParentInfo) {
      return 'SiblingsParentInfo';
    }
    if (data is _i25.PupilData) {
      return 'PupilData';
    }
    if (data is _i26.PupilDataParentInfo) {
      return 'PupilDataParentInfo';
    }
    if (data is _i27.PreSchoolRevision) {
      return 'PreSchoolRevision';
    }
    if (data is _i28.PupilList) {
      return 'PupilList';
    }
    if (data is _i29.SchoolList) {
      return 'SchoolList';
    }
    if (data is _i30.MissedClass) {
      return 'MissedClass';
    }
    if (data is _i31.SchoolSemester) {
      return 'SchoolSemester';
    }
    if (data is _i32.Schoolday) {
      return 'Schoolday';
    }
    if (data is _i33.SchooldayEvent) {
      return 'SchooldayEvent';
    }
    if (data is _i34.AuthLevel) {
      return 'AuthLevel';
    }
    if (data is _i35.Role) {
      return 'Role';
    }
    if (data is _i36.Staff) {
      return 'Staff';
    }
    if (data is _i37.PupilWorkbook) {
      return 'PupilWorkbook';
    }
    if (data is _i38.Workbook) {
      return 'Workbook';
    }
    className = _i42.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    if (data is List<_i39.PupilData>) {
      return 'List<PupilData>';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Authorization') {
      return deserialize<_i2.Authorization>(data['data']);
    }
    if (dataClassName == 'PupilAuthorization') {
      return deserialize<_i3.PupilAuthorization>(data['data']);
    }
    if (dataClassName == 'Book') {
      return deserialize<_i4.Book>(data['data']);
    }
    if (dataClassName == 'BookTag') {
      return deserialize<_i5.BookTag>(data['data']);
    }
    if (dataClassName == 'BookTagging') {
      return deserialize<_i6.BookTagging>(data['data']);
    }
    if (dataClassName == 'LibraryBook') {
      return deserialize<_i7.LibraryBook>(data['data']);
    }
    if (dataClassName == 'LibraryBookLocation') {
      return deserialize<_i8.LibraryBookLocation>(data['data']);
    }
    if (dataClassName == 'PupilBookLending') {
      return deserialize<_i9.PupilBookLending>(data['data']);
    }
    if (dataClassName == 'PupilBookLendingFile') {
      return deserialize<_i10.PupilBookLendingFile>(data['data']);
    }
    if (dataClassName == 'Example') {
      return deserialize<_i11.Example>(data['data']);
    }
    if (dataClassName == 'Competence') {
      return deserialize<_i12.Competence>(data['data']);
    }
    if (dataClassName == 'CompetenceCheck') {
      return deserialize<_i13.CompetenceCheck>(data['data']);
    }
    if (dataClassName == 'CompetenceCheckFile') {
      return deserialize<_i14.CompetenceCheckFile>(data['data']);
    }
    if (dataClassName == 'CompetenceGoal') {
      return deserialize<_i15.CompetenceGoal>(data['data']);
    }
    if (dataClassName == 'CompetenceReport') {
      return deserialize<_i16.CompetenceReport>(data['data']);
    }
    if (dataClassName == 'CompetenceReportCheck') {
      return deserialize<_i17.CompetenceReportCheck>(data['data']);
    }
    if (dataClassName == 'SupportCategory') {
      return deserialize<_i18.SupportCategory>(data['data']);
    }
    if (dataClassName == 'SupportCategoryStatus') {
      return deserialize<_i19.SupportCategoryStatus>(data['data']);
    }
    if (dataClassName == 'SupportGoal') {
      return deserialize<_i20.SupportGoal>(data['data']);
    }
    if (dataClassName == 'SupportGoalCheck') {
      return deserialize<_i21.SupportGoalCheck>(data['data']);
    }
    if (dataClassName == 'SupportGoalCheckFile') {
      return deserialize<_i22.SupportGoalCheckFile>(data['data']);
    }
    if (dataClassName == 'SupportLevel') {
      return deserialize<_i23.SupportLevel>(data['data']);
    }
    if (dataClassName == 'SiblingsParentInfo') {
      return deserialize<_i24.SiblingsParentInfo>(data['data']);
    }
    if (dataClassName == 'PupilData') {
      return deserialize<_i25.PupilData>(data['data']);
    }
    if (dataClassName == 'PupilDataParentInfo') {
      return deserialize<_i26.PupilDataParentInfo>(data['data']);
    }
    if (dataClassName == 'PreSchoolRevision') {
      return deserialize<_i27.PreSchoolRevision>(data['data']);
    }
    if (dataClassName == 'PupilList') {
      return deserialize<_i28.PupilList>(data['data']);
    }
    if (dataClassName == 'SchoolList') {
      return deserialize<_i29.SchoolList>(data['data']);
    }
    if (dataClassName == 'MissedClass') {
      return deserialize<_i30.MissedClass>(data['data']);
    }
    if (dataClassName == 'SchoolSemester') {
      return deserialize<_i31.SchoolSemester>(data['data']);
    }
    if (dataClassName == 'Schoolday') {
      return deserialize<_i32.Schoolday>(data['data']);
    }
    if (dataClassName == 'SchooldayEvent') {
      return deserialize<_i33.SchooldayEvent>(data['data']);
    }
    if (dataClassName == 'AuthLevel') {
      return deserialize<_i34.AuthLevel>(data['data']);
    }
    if (dataClassName == 'Role') {
      return deserialize<_i35.Role>(data['data']);
    }
    if (dataClassName == 'Staff') {
      return deserialize<_i36.Staff>(data['data']);
    }
    if (dataClassName == 'PupilWorkbook') {
      return deserialize<_i37.PupilWorkbook>(data['data']);
    }
    if (dataClassName == 'Workbook') {
      return deserialize<_i38.Workbook>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i42.Protocol().deserializeByClassName(data);
    }
    if (dataClassName == 'List<PupilData>') {
      return deserialize<List<_i39.PupilData>>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}

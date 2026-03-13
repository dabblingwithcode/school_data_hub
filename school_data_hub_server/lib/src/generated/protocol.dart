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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i3;
import '_features/learning/competence/models/competence_check.dart' as _i4;
import '_features/admin/models/batch_create_user_event.dart' as _i5;
import '_features/admin/models/batch_create_users_response.dart' as _i6;
import '_features/admin/models/create_user_request.dart' as _i7;
import '_features/admin/models/created_user_credential.dart' as _i8;
import '_features/admin/models/hub_log_entry.dart' as _i9;
import '_features/admin/models/hub_query_log_entry.dart' as _i10;
import '_features/admin/models/hub_session_log_entry.dart' as _i11;
import '_features/admin/models/hub_session_log_filter.dart' as _i12;
import '_features/admin/models/hub_session_log_info.dart' as _i13;
import '_features/admin/models/hub_session_log_result.dart' as _i14;
import '_features/attendance/models/contacted_type.dart' as _i15;
import '_features/attendance/models/missed_schoolday.dart' as _i16;
import '_features/attendance/models/missed_type.dart' as _i17;
import '_features/auth/models/device_info.dart' as _i18;
import '_features/auth/models/user_device.dart' as _i19;
import '_features/authorizations/models/authorization.dart' as _i20;
import '_features/authorizations/models/pupil_authorization.dart' as _i21;
import '_features/books/models/book.dart' as _i22;
import '_features/books/models/book_stats_dto.dart' as _i23;
import '_features/books/models/book_tagging/book_tag.dart' as _i24;
import '_features/books/models/book_tagging/book_tagging.dart' as _i25;
import '_features/books/models/library_book.dart' as _i26;
import '_features/books/models/library_book_location.dart' as _i27;
import '_features/books/models/library_book_query.dart' as _i28;
import '_features/books/models/pupil_book_lending.dart' as _i29;
import '_features/hub/models/force_logout_event.dart' as _i30;
import '_features/hub/models/hub_delete_event.dart' as _i31;
import '_features/hub/models/hub_object_type.dart' as _i32;
import '_features/learning/competence/models/competence.dart' as _i33;
import '_features/admin/models/batch_create_user_error.dart' as _i34;
import '_features/learning/competence/models/competence_goal.dart' as _i35;
import '_features/learning/competence_report/models/competence_report.dart'
    as _i36;
import '_features/learning/competence_report/models/competence_report_check.dart'
    as _i37;
import '_features/learning/competence_report/models/competence_report_item.dart'
    as _i38;
import '_features/learning_support/models/learning_support_plan.dart' as _i39;
import '_features/learning_support/models/support_category.dart' as _i40;
import '_features/learning_support/models/support_category_status.dart' as _i41;
import '_features/learning_support/models/support_goal/support_goal.dart'
    as _i42;
import '_features/learning_support/models/support_goal/support_goal_check.dart'
    as _i43;
import '_features/learning_support/models/support_level.dart' as _i44;
import '_features/learning_support/models/support_level_legacy_dto.dart'
    as _i45;
import '_features/matrix/compulsory_room.dart' as _i46;
import '_features/matrix/matrix_room_type.dart' as _i47;
import '_features/pupil/models/pupil_data/after_school_care/after_school_care.dart'
    as _i48;
import '_features/pupil/models/pupil_data/after_school_care/after_school_pickup_times.dart'
    as _i49;
import '_features/pupil/models/pupil_data/after_school_care/pick_up_info.dart'
    as _i50;
import '_features/pupil/models/pupil_data/communication/communication_skills.dart'
    as _i51;
import '_features/pupil/models/pupil_data/communication/public_media_auth.dart'
    as _i52;
import '_features/pupil/models/pupil_data/communication/tutor_info.dart'
    as _i53;
import '_features/pupil/models/pupil_data/credit_transaction.dart' as _i54;
import '_features/pupil/models/pupil_data/dto/pupil_document_type.dart' as _i55;
import '_features/pupil/models/pupil_data/dto/siblings_tutor_info_dto.dart'
    as _i56;
import '_features/pupil/models/pupil_data/preschool/kindergarden.dart' as _i57;
import '_features/pupil/models/pupil_data/preschool/kindergarden_info.dart'
    as _i58;
import '_features/pupil/models/pupil_data/preschool/pre_school_medical.dart'
    as _i59;
import '_features/pupil/models/pupil_data/preschool/pre_school_medical_status.dart'
    as _i60;
import '_features/pupil/models/pupil_data/preschool/pre_school_test.dart'
    as _i61;
import '_features/pupil/models/pupil_data/pupil_data.dart' as _i62;
import '_features/pupil/models/pupil_data/pupil_status.dart' as _i63;
import '_shared/models/member_operation.dart' as _i64;
import '_features/pupil/models/pupil_identity/pupil_identity.dart' as _i65;
import '_features/pupil/models/pupil_identity/pupil_identity_dto.dart' as _i66;
import '_features/pupil/models/pupil_identity/school_grade.dart' as _i67;
import '_features/school_data/models/school_data.dart' as _i68;
import '_features/school_lists/models/pupil_entry.dart' as _i69;
import '_features/school_lists/models/school_list.dart' as _i70;
import '_features/schoolday/models/school_semester.dart' as _i71;
import '_features/schoolday/models/schoolday.dart' as _i72;
import '_features/schoolday_events/models/schoolday_event.dart' as _i73;
import '_features/schoolday_events/models/schoolday_event_type.dart' as _i74;
import '_features/timetable/models/classroom.dart' as _i75;
import '_features/timetable/models/junction_models/lesson_teacher.dart' as _i76;
import '_features/timetable/models/junction_models/scheduled_lesson_teacher.dart'
    as _i77;
import '_features/timetable/models/lesson/lesson.dart' as _i78;
import '_features/timetable/models/lesson/lesson_attendance.dart' as _i79;
import '_features/timetable/models/lesson/lesson_group.dart' as _i80;
import '_features/timetable/models/scheduled_lesson/lesson_group_membership.dart'
    as _i81;
import '_features/timetable/models/scheduled_lesson/scheduled_lesson.dart'
    as _i82;
import '_features/timetable/models/scheduled_lesson/subject.dart' as _i83;
import '_features/timetable/models/scheduled_lesson/timetable_slot.dart'
    as _i84;
import '_features/timetable/models/scheduled_lesson/weekday_enum.dart' as _i85;
import '_features/timetable/models/timetable.dart' as _i86;
import '_features/user/models/roles.dart' as _i87;
import '_features/user/models/staff_user.dart' as _i88;
import '_features/user/models/user_flags.dart' as _i89;
import '_features/user/models/user_with_devices.dart' as _i90;
import '_features/workbooks/models/pupil_workbook.dart' as _i91;
import '_features/workbooks/models/workbook.dart' as _i92;
import '_shared/models/exceptions/test_exception.dart' as _i93;
import '_shared/models/hub_document.dart' as _i94;
import '_features/pupil/models/pupil_identity/last_pupil_identities_update.dart'
    as _i95;
import 'package:school_data_hub_server/src/generated/_features/learning/competence/models/competence.dart'
    as _i96;
import 'package:school_data_hub_server/src/generated/_features/learning_support/models/support_category.dart'
    as _i97;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_data/pupil_data.dart'
    as _i98;
import 'package:school_data_hub_server/src/generated/_features/schoolday/models/schoolday.dart'
    as _i99;
import 'package:school_data_hub_server/src/generated/_features/admin/models/create_user_request.dart'
    as _i100;
import 'package:school_data_hub_server/src/generated/_features/attendance/models/missed_schoolday.dart'
    as _i101;
import 'package:school_data_hub_server/src/generated/_features/auth/models/user_device.dart'
    as _i102;
import 'package:school_data_hub_server/src/generated/_features/authorizations/models/authorization.dart'
    as _i103;
import 'package:school_data_hub_server/src/generated/_shared/models/member_operation.dart'
    as _i104;
import 'package:school_data_hub_server/src/generated/_features/books/models/book_tagging/book_tag.dart'
    as _i105;
import 'package:school_data_hub_server/src/generated/_features/books/models/book.dart'
    as _i106;
import 'package:school_data_hub_server/src/generated/_features/books/models/library_book_location.dart'
    as _i107;
import 'package:school_data_hub_server/src/generated/_features/books/models/library_book.dart'
    as _i108;
import 'package:school_data_hub_server/src/generated/_features/books/models/pupil_book_lending.dart'
    as _i109;
import 'package:school_data_hub_server/src/generated/_features/learning/competence/models/competence_goal.dart'
    as _i110;
import 'package:school_data_hub_server/src/generated/_features/learning/competence_report/models/competence_report.dart'
    as _i111;
import 'package:school_data_hub_server/src/generated/_features/learning/competence_report/models/competence_report_item.dart'
    as _i112;
import 'package:school_data_hub_server/src/generated/_features/learning_support/models/support_goal/support_goal.dart'
    as _i113;
import 'package:school_data_hub_server/src/generated/_features/learning_support/models/learning_support_plan.dart'
    as _i114;
import 'package:school_data_hub_server/src/generated/_features/learning_support/models/support_category_status.dart'
    as _i115;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_data/preschool/pre_school_medical.dart'
    as _i116;
import 'package:school_data_hub_server/src/generated/_features/matrix/compulsory_room.dart'
    as _i117;
import 'package:school_data_hub_server/src/generated/_features/learning_support/models/support_level_legacy_dto.dart'
    as _i118;
import 'package:school_data_hub_server/src/generated/_features/school_lists/models/school_list.dart'
    as _i119;
import 'package:school_data_hub_server/src/generated/_features/schoolday/models/school_semester.dart'
    as _i120;
import 'package:school_data_hub_server/src/generated/_features/schoolday_events/models/schoolday_event.dart'
    as _i121;
import 'package:school_data_hub_server/src/generated/_features/timetable/models/classroom.dart'
    as _i122;
import 'package:school_data_hub_server/src/generated/_features/timetable/models/lesson/lesson_group.dart'
    as _i123;
import 'package:school_data_hub_server/src/generated/_features/timetable/models/scheduled_lesson/scheduled_lesson.dart'
    as _i124;
import 'package:school_data_hub_server/src/generated/_features/timetable/models/scheduled_lesson/lesson_group_membership.dart'
    as _i125;
import 'package:school_data_hub_server/src/generated/_features/timetable/models/scheduled_lesson/subject.dart'
    as _i126;
import 'package:school_data_hub_server/src/generated/_features/timetable/models/timetable.dart'
    as _i127;
import 'package:school_data_hub_server/src/generated/_features/timetable/models/scheduled_lesson/timetable_slot.dart'
    as _i128;
import 'package:school_data_hub_server/src/generated/_features/user/models/staff_user.dart'
    as _i129;
import 'package:school_data_hub_server/src/generated/_features/user/models/user_with_devices.dart'
    as _i130;
import 'package:school_data_hub_server/src/generated/_features/workbooks/models/pupil_workbook.dart'
    as _i131;
import 'package:school_data_hub_server/src/generated/_features/workbooks/models/workbook.dart'
    as _i132;
export '_features/admin/models/batch_create_user_error.dart';
export '_features/admin/models/batch_create_user_event.dart';
export '_features/admin/models/batch_create_users_response.dart';
export '_features/admin/models/create_user_request.dart';
export '_features/admin/models/created_user_credential.dart';
export '_features/admin/models/hub_log_entry.dart';
export '_features/admin/models/hub_query_log_entry.dart';
export '_features/admin/models/hub_session_log_entry.dart';
export '_features/admin/models/hub_session_log_filter.dart';
export '_features/admin/models/hub_session_log_info.dart';
export '_features/admin/models/hub_session_log_result.dart';
export '_features/attendance/models/contacted_type.dart';
export '_features/attendance/models/missed_schoolday.dart';
export '_features/attendance/models/missed_type.dart';
export '_features/auth/models/device_info.dart';
export '_features/auth/models/user_device.dart';
export '_features/authorizations/models/authorization.dart';
export '_features/authorizations/models/pupil_authorization.dart';
export '_features/books/models/book.dart';
export '_features/books/models/book_stats_dto.dart';
export '_features/books/models/book_tagging/book_tag.dart';
export '_features/books/models/book_tagging/book_tagging.dart';
export '_features/books/models/library_book.dart';
export '_features/books/models/library_book_location.dart';
export '_features/books/models/library_book_query.dart';
export '_features/books/models/pupil_book_lending.dart';
export '_features/hub/models/force_logout_event.dart';
export '_features/hub/models/hub_delete_event.dart';
export '_features/hub/models/hub_object_type.dart';
export '_features/learning/competence/models/competence.dart';
export '_features/learning/competence/models/competence_check.dart';
export '_features/learning/competence/models/competence_goal.dart';
export '_features/learning/competence_report/models/competence_report.dart';
export '_features/learning/competence_report/models/competence_report_check.dart';
export '_features/learning/competence_report/models/competence_report_item.dart';
export '_features/learning_support/models/learning_support_plan.dart';
export '_features/learning_support/models/support_category.dart';
export '_features/learning_support/models/support_category_status.dart';
export '_features/learning_support/models/support_goal/support_goal.dart';
export '_features/learning_support/models/support_goal/support_goal_check.dart';
export '_features/learning_support/models/support_level.dart';
export '_features/learning_support/models/support_level_legacy_dto.dart';
export '_features/matrix/compulsory_room.dart';
export '_features/matrix/matrix_room_type.dart';
export '_features/pupil/models/pupil_data/after_school_care/after_school_care.dart';
export '_features/pupil/models/pupil_data/after_school_care/after_school_pickup_times.dart';
export '_features/pupil/models/pupil_data/after_school_care/pick_up_info.dart';
export '_features/pupil/models/pupil_data/communication/communication_skills.dart';
export '_features/pupil/models/pupil_data/communication/public_media_auth.dart';
export '_features/pupil/models/pupil_data/communication/tutor_info.dart';
export '_features/pupil/models/pupil_data/credit_transaction.dart';
export '_features/pupil/models/pupil_data/dto/pupil_document_type.dart';
export '_features/pupil/models/pupil_data/dto/siblings_tutor_info_dto.dart';
export '_features/pupil/models/pupil_data/preschool/kindergarden.dart';
export '_features/pupil/models/pupil_data/preschool/kindergarden_info.dart';
export '_features/pupil/models/pupil_data/preschool/pre_school_medical.dart';
export '_features/pupil/models/pupil_data/preschool/pre_school_medical_status.dart';
export '_features/pupil/models/pupil_data/preschool/pre_school_test.dart';
export '_features/pupil/models/pupil_data/pupil_data.dart';
export '_features/pupil/models/pupil_data/pupil_status.dart';
export '_features/pupil/models/pupil_identity/last_pupil_identities_update.dart';
export '_features/pupil/models/pupil_identity/pupil_identity.dart';
export '_features/pupil/models/pupil_identity/pupil_identity_dto.dart';
export '_features/pupil/models/pupil_identity/school_grade.dart';
export '_features/school_data/models/school_data.dart';
export '_features/school_lists/models/pupil_entry.dart';
export '_features/school_lists/models/school_list.dart';
export '_features/schoolday/models/school_semester.dart';
export '_features/schoolday/models/schoolday.dart';
export '_features/schoolday_events/models/schoolday_event.dart';
export '_features/schoolday_events/models/schoolday_event_type.dart';
export '_features/timetable/models/classroom.dart';
export '_features/timetable/models/junction_models/lesson_teacher.dart';
export '_features/timetable/models/junction_models/scheduled_lesson_teacher.dart';
export '_features/timetable/models/lesson/lesson.dart';
export '_features/timetable/models/lesson/lesson_attendance.dart';
export '_features/timetable/models/lesson/lesson_group.dart';
export '_features/timetable/models/scheduled_lesson/lesson_group_membership.dart';
export '_features/timetable/models/scheduled_lesson/scheduled_lesson.dart';
export '_features/timetable/models/scheduled_lesson/subject.dart';
export '_features/timetable/models/scheduled_lesson/timetable_slot.dart';
export '_features/timetable/models/scheduled_lesson/weekday_enum.dart';
export '_features/timetable/models/timetable.dart';
export '_features/user/models/roles.dart';
export '_features/user/models/staff_user.dart';
export '_features/user/models/user_flags.dart';
export '_features/user/models/user_with_devices.dart';
export '_features/workbooks/models/pupil_workbook.dart';
export '_features/workbooks/models/workbook.dart';
export '_shared/models/exceptions/test_exception.dart';
export '_shared/models/hub_document.dart';
export '_shared/models/member_operation.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'authorization',
      dartName: 'Authorization',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'authorization_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'authorization_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'book',
      dartName: 'Book',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'book_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'isbn',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'author',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'readingLevel',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'imagePath',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'book_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'book_id_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isbn',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'book_tag',
      dartName: 'BookTag',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'book_tag_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'book_tag_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'book_tagging',
      dartName: 'BookTagging',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'book_tagging_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'bookId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'bookTagId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'book_tagging_fk_0',
          columns: ['bookId'],
          referenceTable: 'book',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'book_tagging_fk_1',
          columns: ['bookTagId'],
          referenceTable: 'book_tag',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'book_tagging_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'book_tagging_index_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'bookId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'bookTagId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'competence',
      dartName: 'Competence',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'competence_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'publicId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'parentCompetence',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'indicators',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'order',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'competence_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'competence_check',
      dartName: 'CompetenceCheck',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'competence_check_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'checkId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'score',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'comment',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'valueFactor',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'groupCheckId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'groupCheckName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'pupilId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'competenceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'competence_check_fk_0',
          columns: ['pupilId'],
          referenceTable: 'pupil_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'competence_check_fk_1',
          columns: ['competenceId'],
          referenceTable: 'competence',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'competence_check_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'competence_goal',
      dartName: 'CompetenceGoal',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'competence_goal_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'publicId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'strategies',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'modifiedBy',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'score',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'achievedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'pupilId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'competenceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'competence_goal_fk_0',
          columns: ['pupilId'],
          referenceTable: 'pupil_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'competence_goal_fk_1',
          columns: ['competenceId'],
          referenceTable: 'competence',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'competence_goal_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'competence_report',
      dartName: 'CompetenceReport',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'competence_report_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'reportId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'modifiedBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'modifiedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'achievement',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'achievedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'indicators',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'pupilId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'schoolSemesterId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'competence_report_fk_0',
          columns: ['pupilId'],
          referenceTable: 'pupil_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'competence_report_fk_1',
          columns: ['schoolSemesterId'],
          referenceTable: 'school_semester',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'competence_report_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'competence_report_check',
      dartName: 'CompetenceReportCheck',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'competence_report_check_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'publicId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'achievement',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'comment',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'shouldPrint',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'pupilId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'competenceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'competenceReportId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'competence_report_check_fk_0',
          columns: ['pupilId'],
          referenceTable: 'pupil_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'competence_report_check_fk_1',
          columns: ['competenceId'],
          referenceTable: 'competence_report_item',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'competence_report_check_fk_2',
          columns: ['competenceReportId'],
          referenceTable: 'competence_report',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'competence_report_check_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'competence_report_item',
      dartName: 'CompetenceReportItem',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'competence_report_item_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'publicId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'parentItem',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'order',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'competence_report_item_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'compulsory_room',
      dartName: 'CompulsoryRoom',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'compulsory_room_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'roomId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'roomType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MatrixRoomType',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'compulsory_room_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'credit_transaction',
      dartName: 'CreditTransaction',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'credit_transaction_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'sender',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'receiver',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'amount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'dateTime',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: '_pupilDataCredittransactionsPupilDataId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'credit_transaction_fk_0',
          columns: ['_pupilDataCredittransactionsPupilDataId'],
          referenceTable: 'pupil_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'credit_transaction_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'reciever_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'receiver',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'sender_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'sender',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'hub_document',
      dartName: 'HubDocument',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'hub_document_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'documentId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'documentPath',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: '_pupilBookLendingPupilbooklendingfilesPupilBookLendingId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: '_competenceCheckDocumentsCompetenceCheckId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: '_competenceGoalDocumentsCompetenceGoalId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: '_supportCategoryStatusDocumentsSupportCategoryStatusId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: '_supportGoalCheckDocumentsSupportGoalCheckId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: '_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: '_preSchoolTestPreschooltestdocumentsPreSchoolTestId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'hub_document_fk_0',
          columns: ['_pupilBookLendingPupilbooklendingfilesPupilBookLendingId'],
          referenceTable: 'pupil_book_lending',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'hub_document_fk_1',
          columns: ['_competenceCheckDocumentsCompetenceCheckId'],
          referenceTable: 'competence_check',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'hub_document_fk_2',
          columns: ['_competenceGoalDocumentsCompetenceGoalId'],
          referenceTable: 'competence_goal',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'hub_document_fk_3',
          columns: ['_supportCategoryStatusDocumentsSupportCategoryStatusId'],
          referenceTable: 'support_category_status',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'hub_document_fk_4',
          columns: ['_supportGoalCheckDocumentsSupportGoalCheckId'],
          referenceTable: 'support_goal_check',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'hub_document_fk_5',
          columns: ['_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId'],
          referenceTable: 'pre_school_medical',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'hub_document_fk_6',
          columns: ['_preSchoolTestPreschooltestdocumentsPreSchoolTestId'],
          referenceTable: 'pre_school_test',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'hub_document_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'kindergarden',
      dartName: 'Kindergarden',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'kindergarden_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'phone',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'address',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'contactPerson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'kindergarden_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'last_pupil_identities_update',
      dartName: 'LastPupilIdentiesUpdate',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'last_pupil_identities_update_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'date',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'last_pupil_identities_update_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'learning_support_plan',
      dartName: 'LearningSupportPlan',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'learning_support_plan_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'planId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'number',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'specialNeedsTeacher',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'socialPedagogue',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'proffesionalsInvolved',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'strengthsDescription',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'problemsDescription',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'learningSupportLevelId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'comment',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'pupilId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'schoolSemesterId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'learning_support_plan_fk_0',
          columns: ['learningSupportLevelId'],
          referenceTable: 'support_level',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'learning_support_plan_fk_1',
          columns: ['pupilId'],
          referenceTable: 'pupil_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'learning_support_plan_fk_2',
          columns: ['schoolSemesterId'],
          referenceTable: 'school_semester',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'learning_support_plan_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'lesson',
      dartName: 'Lesson',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'lesson_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'publicId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'subjectId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'lesson_fk_0',
          columns: ['subjectId'],
          referenceTable: 'subject',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'lesson_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'lesson_attendance',
      dartName: 'LessonAttendance',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'lesson_attendance_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'lessonId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'pupilId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'comment',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'modifiedBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'modifiedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'lesson_attendance_fk_0',
          columns: ['lessonId'],
          referenceTable: 'lesson',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'lesson_attendance_fk_1',
          columns: ['pupilId'],
          referenceTable: 'pupil_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'lesson_attendance_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'lesson_group',
      dartName: 'LessonGroup',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'lesson_group_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'publicId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'color',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'timetableId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'modifiedBy',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'modifiedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'lesson_group_fk_0',
          columns: ['timetableId'],
          referenceTable: 'timetable',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'lesson_group_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'lesson_group_pupil',
      dartName: 'ScheduledLessonGroupMembership',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'lesson_group_pupil_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'lessonGroupId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'pupilDataId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'lesson_group_pupil_fk_0',
          columns: ['lessonGroupId'],
          referenceTable: 'lesson_group',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'lesson_group_pupil_fk_1',
          columns: ['pupilDataId'],
          referenceTable: 'pupil_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'lesson_group_pupil_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'lesson_group_membership_index_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'lessonGroupId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'pupilDataId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'lesson_teacher',
      dartName: 'LessonTeacher',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'lesson_teacher_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'scheduledLessonId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'lesson_teacher_fk_0',
          columns: ['userId'],
          referenceTable: 'user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'lesson_teacher_fk_1',
          columns: ['scheduledLessonId'],
          referenceTable: 'lesson',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'lesson_teacher_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'lesson_teacher_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'scheduledLessonId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'library_book',
      dartName: 'LibraryBook',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'library_book_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'libraryId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'bookId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'locationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'available',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'library_book_fk_0',
          columns: ['bookId'],
          referenceTable: 'book',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'library_book_fk_1',
          columns: ['locationId'],
          referenceTable: 'library_book_location',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'library_book_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'library_id_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'libraryId',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'library_book_location',
      dartName: 'LibraryBookLocation',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'library_book_location_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'location',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'library_book_location_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'location_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'location',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'missed_class',
      dartName: 'MissedSchoolday',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'missed_class_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'missedType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MissedType',
        ),
        _i2.ColumnDefinition(
          name: 'unexcused',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'contacted',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ContactedType',
        ),
        _i2.ColumnDefinition(
          name: 'returned',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'returnedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'writtenExcuse',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'minutesLate',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'modifiedBy',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'comment',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'schooldayId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'pupilId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'missed_class_fk_0',
          columns: ['schooldayId'],
          referenceTable: 'schoolday',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'missed_class_fk_1',
          columns: ['pupilId'],
          referenceTable: 'pupil_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'missed_class_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'schoolday_pupil_data_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'schooldayId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'pupilId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'pre_school_medical',
      dartName: 'PreSchoolMedical',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'pre_school_medical_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'preschoolMedicalStatus',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:PreSchoolMedicalStatus?',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedBy',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'pre_school_medical_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'pre_school_test',
      dartName: 'PreSchoolTest',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'pre_school_test_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'careNeedsIntensity',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'pre_school_test_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'pupil_authorization',
      dartName: 'PupilAuthorization',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'pupil_authorization_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'comment',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'fileId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'authorizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'pupilId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'pupil_authorization_fk_0',
          columns: ['fileId'],
          referenceTable: 'hub_document',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'pupil_authorization_fk_1',
          columns: ['authorizationId'],
          referenceTable: 'authorization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'pupil_authorization_fk_2',
          columns: ['pupilId'],
          referenceTable: 'pupil_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'pupil_authorization_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'pupil_book_lending',
      dartName: 'PupilBookLending',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'pupil_book_lending_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'lendingId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'score',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'bookScore',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'lentAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'lentBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'returnedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'receivedBy',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'pupilId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'isbn',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'libraryBookId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'pupil_book_lending_fk_0',
          columns: ['pupilId'],
          referenceTable: 'pupil_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'pupil_book_lending_fk_1',
          columns: ['libraryBookId'],
          referenceTable: 'library_book',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'pupil_book_lending_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'pupil_data',
      dartName: 'PupilData',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'pupil_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:PupilStatus',
        ),
        _i2.ColumnDefinition(
          name: 'internalId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'password',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'preSchoolMedicalId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'kindergardenId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'kindergardenData',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:KindergardenInfo?',
        ),
        _i2.ColumnDefinition(
          name: 'preSchoolTestId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'avatarId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'avatarAuthId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'publicMediaAuth',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'protocol:PublicMediaAuth',
        ),
        _i2.ColumnDefinition(
          name: 'publicMediaAuthDocumentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'contact',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'communicationPupil',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:CommunicationSkills?',
        ),
        _i2.ColumnDefinition(
          name: 'specialInformation',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'tutorInfo',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:TutorInfo?',
        ),
        _i2.ColumnDefinition(
          name: 'afterSchoolCare',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:AfterSchoolCare?',
        ),
        _i2.ColumnDefinition(
          name: 'credit',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'creditEarned',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'schoolyearHeldBackAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'swimmer',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: '_kindergardenPupilsKindergardenId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'pupil_data_fk_0',
          columns: ['preSchoolMedicalId'],
          referenceTable: 'pre_school_medical',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'pupil_data_fk_1',
          columns: ['kindergardenId'],
          referenceTable: 'kindergarden',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'pupil_data_fk_2',
          columns: ['preSchoolTestId'],
          referenceTable: 'pre_school_test',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'pupil_data_fk_3',
          columns: ['avatarId'],
          referenceTable: 'hub_document',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'pupil_data_fk_4',
          columns: ['avatarAuthId'],
          referenceTable: 'hub_document',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'pupil_data_fk_5',
          columns: ['publicMediaAuthDocumentId'],
          referenceTable: 'hub_document',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'pupil_data_fk_6',
          columns: ['_kindergardenPupilsKindergardenId'],
          referenceTable: 'kindergarden',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'pupil_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'pupil_data_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'internalId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'pupil_data_internal_id_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'internalId',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'pupil_list_entry',
      dartName: 'PupilListEntry',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'pupil_list_entry_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'comment',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'entryBy',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'schoolListId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'pupilId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'pupil_list_entry_fk_0',
          columns: ['schoolListId'],
          referenceTable: 'school_list',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'pupil_list_entry_fk_1',
          columns: ['pupilId'],
          referenceTable: 'pupil_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'pupil_list_entry_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'pupil_workbook',
      dartName: 'PupilWorkbook',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'pupil_workbook_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'isbn',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'comment',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'score',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'finishedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'pupilId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'workbookId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'pupil_workbook_fk_0',
          columns: ['pupilId'],
          referenceTable: 'pupil_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'pupil_workbook_fk_1',
          columns: ['workbookId'],
          referenceTable: 'workbook',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'pupil_workbook_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'room',
      dartName: 'Classroom',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'room_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'roomCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'roomName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'room_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'scheduled_lesson',
      dartName: 'ScheduledLesson',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'scheduled_lesson_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'active',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'subjectId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'scheduledAtId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'timetableSlotOrder',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'timetableId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'mainTeacherId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'lessonId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'roomId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'lessonGroupId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'modifiedBy',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'modifiedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'recordtest',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: '( {int testint, String testString})?',
        ),
        _i2.ColumnDefinition(
          name: '_roomScheduledlessonsRoomId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'scheduled_lesson_fk_0',
          columns: ['subjectId'],
          referenceTable: 'subject',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'scheduled_lesson_fk_1',
          columns: ['scheduledAtId'],
          referenceTable: 'timetable_slot',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'scheduled_lesson_fk_2',
          columns: ['timetableId'],
          referenceTable: 'timetable',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'scheduled_lesson_fk_3',
          columns: ['roomId'],
          referenceTable: 'room',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'scheduled_lesson_fk_4',
          columns: ['lessonGroupId'],
          referenceTable: 'lesson_group',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'scheduled_lesson_fk_5',
          columns: ['_roomScheduledlessonsRoomId'],
          referenceTable: 'room',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'scheduled_lesson_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'scheduled_lesson_teacher',
      dartName: 'ScheduledLessonTeacher',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'scheduled_lesson_teacher_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'scheduledLessonId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'scheduled_lesson_teacher_fk_0',
          columns: ['userId'],
          referenceTable: 'user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'scheduled_lesson_teacher_fk_1',
          columns: ['scheduledLessonId'],
          referenceTable: 'scheduled_lesson',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'scheduled_lesson_teacher_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'scheduled_lesson_teacher_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'scheduledLessonId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'school_data',
      dartName: 'SchoolData',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'school_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'officialName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'extraName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'address',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'zipCode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'city',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'schoolNumber',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'telephoneNumber',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'website',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'principalName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'logoId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'officialSealId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'school_data_fk_0',
          columns: ['logoId'],
          referenceTable: 'hub_document',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'school_data_fk_1',
          columns: ['officialSealId'],
          referenceTable: 'hub_document',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'school_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'school_list',
      dartName: 'SchoolList',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'school_list_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'listId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'archived',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'public',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'authorizedUsers',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'school_list_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'school_semester',
      dartName: 'SchoolSemester',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'school_semester_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'schoolYear',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isFirst',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'startDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'endDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'classConferenceDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'supportConferenceDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'reportConferenceDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'reportSignedDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'school_semester_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'schoolday',
      dartName: 'Schoolday',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'schoolday_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'schoolday',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'schoolSemesterId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'schoolday_fk_0',
          columns: ['schoolSemesterId'],
          referenceTable: 'school_semester',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'schoolday_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'schoolday_event',
      dartName: 'SchooldayEvent',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'schoolday_event_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'eventId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'eventType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:SchooldayEventType',
        ),
        _i2.ColumnDefinition(
          name: 'eventReason',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'eventTime',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'processed',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'processedBy',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'processedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'documentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'processedDocumentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'schooldayId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'pupilId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'comment',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'schoolday_event_fk_0',
          columns: ['documentId'],
          referenceTable: 'hub_document',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'schoolday_event_fk_1',
          columns: ['processedDocumentId'],
          referenceTable: 'hub_document',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'schoolday_event_fk_2',
          columns: ['schooldayId'],
          referenceTable: 'schoolday',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'schoolday_event_fk_3',
          columns: ['pupilId'],
          referenceTable: 'pupil_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'schoolday_event_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'subject',
      dartName: 'Subject',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'subject_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'publicId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'color',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'modifiedBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'subject_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'support_category',
      dartName: 'SupportCategory',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'support_category_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'categoryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'parentCategory',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'order',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'printable',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'support_category_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'support_category_goal',
      dartName: 'SupportGoal',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'support_category_goal_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'goalId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'score',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'achievedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'strategies',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'pupilId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'supportCategoryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: '_learningSupportPlanSupportgoalsLearningSupportPlanId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: '_supportCategoryCategorygoalsSupportCategoryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: '_pupilDataSupportgoalsPupilDataId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'support_category_goal_fk_0',
          columns: ['pupilId'],
          referenceTable: 'pupil_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'support_category_goal_fk_1',
          columns: ['supportCategoryId'],
          referenceTable: 'support_category',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'support_category_goal_fk_2',
          columns: ['_learningSupportPlanSupportgoalsLearningSupportPlanId'],
          referenceTable: 'learning_support_plan',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'support_category_goal_fk_3',
          columns: ['_supportCategoryCategorygoalsSupportCategoryId'],
          referenceTable: 'support_category',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'support_category_goal_fk_4',
          columns: ['_pupilDataSupportgoalsPupilDataId'],
          referenceTable: 'pupil_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'support_category_goal_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'support_category_status',
      dartName: 'SupportCategoryStatus',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'support_category_status_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'score',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'comment',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'pupilId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'supportCategoryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'learningSupportPlanId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name:
              '_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: '_supportCategoryCategorystatuesSupportCategoryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: '_pupilDataSupportcategorystatusesPupilDataId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'support_category_status_fk_0',
          columns: ['pupilId'],
          referenceTable: 'pupil_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'support_category_status_fk_1',
          columns: ['supportCategoryId'],
          referenceTable: 'support_category',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'support_category_status_fk_2',
          columns: ['learningSupportPlanId'],
          referenceTable: 'learning_support_plan',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'support_category_status_fk_3',
          columns: [
            '_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId'
          ],
          referenceTable: 'learning_support_plan',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'support_category_status_fk_4',
          columns: ['_supportCategoryCategorystatuesSupportCategoryId'],
          referenceTable: 'support_category',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'support_category_status_fk_5',
          columns: ['_pupilDataSupportcategorystatusesPupilDataId'],
          referenceTable: 'pupil_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'support_category_status_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'support_goal_check',
      dartName: 'SupportGoalCheck',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'support_goal_check_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'checkId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'score',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'comment',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'print',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'supportGoalId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: '_supportCategoryGoalGoalchecksSupportCategoryGoalId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'support_goal_check_fk_0',
          columns: ['supportGoalId'],
          referenceTable: 'support_category_goal',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'support_goal_check_fk_1',
          columns: ['_supportCategoryGoalGoalchecksSupportCategoryGoalId'],
          referenceTable: 'support_category_goal',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'support_goal_check_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'support_level',
      dartName: 'SupportLevel',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'support_level_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'comment',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'pupilId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'support_level_fk_0',
          columns: ['pupilId'],
          referenceTable: 'pupil_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'support_level_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'timetable',
      dartName: 'Timetable',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'timetable_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'active',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'startsAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'endsAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'schoolSemesterId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'modified',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<( {String modifiedBy, DateTime modifiedAt})>?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'timetable_fk_0',
          columns: ['schoolSemesterId'],
          referenceTable: 'school_semester',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'timetable_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'timetable_school_semester_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'schoolSemesterId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'timetable_slot',
      dartName: 'TimetableSlot',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'timetable_slot_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'day',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:Weekday',
        ),
        _i2.ColumnDefinition(
          name: 'startTime',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'endTime',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'timetableId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'timetable_slot_fk_0',
          columns: ['timetableId'],
          referenceTable: 'timetable',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'timetable_slot_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user',
      dartName: 'User',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userInfoId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'role',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:Role',
        ),
        _i2.ColumnDefinition(
          name: 'matrixUserId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'timeUnits',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'reliefTimeUnits',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'pupilsAuth',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Set<int>?',
        ),
        _i2.ColumnDefinition(
          name: 'schooldayEventsProcessingTeam',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'credit',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'userFlags',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'protocol:UserFlags',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'user_fk_0',
          columns: ['userInfoId'],
          referenceTable: 'serverpod_user_info',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'user_info_id_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userInfoId',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_device',
      dartName: 'UserDevice',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_device_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userInfoId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'deviceId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'deviceName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'lastLogin',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'authId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'user_device_fk_0',
          columns: ['userInfoId'],
          referenceTable: 'serverpod_user_info',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'user_device_fk_1',
          columns: ['authId'],
          referenceTable: 'serverpod_auth_key',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_device_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'auth_key_user_device_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'authId',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'workbook',
      dartName: 'Workbook',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'workbook_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'isbn',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'subject',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'amount',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'imageUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'workbook_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i4.CompetenceCheck) {
      return _i4.CompetenceCheck.fromJson(data) as T;
    }
    if (t == _i5.BatchCreateUserEvent) {
      return _i5.BatchCreateUserEvent.fromJson(data) as T;
    }
    if (t == _i6.BatchCreateUsersResponse) {
      return _i6.BatchCreateUsersResponse.fromJson(data) as T;
    }
    if (t == _i7.CreateUserRequest) {
      return _i7.CreateUserRequest.fromJson(data) as T;
    }
    if (t == _i8.CreatedUserCredential) {
      return _i8.CreatedUserCredential.fromJson(data) as T;
    }
    if (t == _i9.HubLogEntry) {
      return _i9.HubLogEntry.fromJson(data) as T;
    }
    if (t == _i10.HubQueryLogEntry) {
      return _i10.HubQueryLogEntry.fromJson(data) as T;
    }
    if (t == _i11.HubSessionLogEntry) {
      return _i11.HubSessionLogEntry.fromJson(data) as T;
    }
    if (t == _i12.HubSessionLogFilter) {
      return _i12.HubSessionLogFilter.fromJson(data) as T;
    }
    if (t == _i13.HubSessionLogInfo) {
      return _i13.HubSessionLogInfo.fromJson(data) as T;
    }
    if (t == _i14.HubSessionLogResult) {
      return _i14.HubSessionLogResult.fromJson(data) as T;
    }
    if (t == _i15.ContactedType) {
      return _i15.ContactedType.fromJson(data) as T;
    }
    if (t == _i16.MissedSchoolday) {
      return _i16.MissedSchoolday.fromJson(data) as T;
    }
    if (t == _i17.MissedType) {
      return _i17.MissedType.fromJson(data) as T;
    }
    if (t == _i18.DeviceInfo) {
      return _i18.DeviceInfo.fromJson(data) as T;
    }
    if (t == _i19.UserDevice) {
      return _i19.UserDevice.fromJson(data) as T;
    }
    if (t == _i20.Authorization) {
      return _i20.Authorization.fromJson(data) as T;
    }
    if (t == _i21.PupilAuthorization) {
      return _i21.PupilAuthorization.fromJson(data) as T;
    }
    if (t == _i22.Book) {
      return _i22.Book.fromJson(data) as T;
    }
    if (t == _i23.LibraryBookStatsDto) {
      return _i23.LibraryBookStatsDto.fromJson(data) as T;
    }
    if (t == _i24.BookTag) {
      return _i24.BookTag.fromJson(data) as T;
    }
    if (t == _i25.BookTagging) {
      return _i25.BookTagging.fromJson(data) as T;
    }
    if (t == _i26.LibraryBook) {
      return _i26.LibraryBook.fromJson(data) as T;
    }
    if (t == _i27.LibraryBookLocation) {
      return _i27.LibraryBookLocation.fromJson(data) as T;
    }
    if (t == _i28.LibraryBookQuery) {
      return _i28.LibraryBookQuery.fromJson(data) as T;
    }
    if (t == _i29.PupilBookLending) {
      return _i29.PupilBookLending.fromJson(data) as T;
    }
    if (t == _i30.ForceLogoutEvent) {
      return _i30.ForceLogoutEvent.fromJson(data) as T;
    }
    if (t == _i31.HubDeleteEvent) {
      return _i31.HubDeleteEvent.fromJson(data) as T;
    }
    if (t == _i32.HubObjectType) {
      return _i32.HubObjectType.fromJson(data) as T;
    }
    if (t == _i33.Competence) {
      return _i33.Competence.fromJson(data) as T;
    }
    if (t == _i34.BatchCreateUserError) {
      return _i34.BatchCreateUserError.fromJson(data) as T;
    }
    if (t == _i35.CompetenceGoal) {
      return _i35.CompetenceGoal.fromJson(data) as T;
    }
    if (t == _i36.CompetenceReport) {
      return _i36.CompetenceReport.fromJson(data) as T;
    }
    if (t == _i37.CompetenceReportCheck) {
      return _i37.CompetenceReportCheck.fromJson(data) as T;
    }
    if (t == _i38.CompetenceReportItem) {
      return _i38.CompetenceReportItem.fromJson(data) as T;
    }
    if (t == _i39.LearningSupportPlan) {
      return _i39.LearningSupportPlan.fromJson(data) as T;
    }
    if (t == _i40.SupportCategory) {
      return _i40.SupportCategory.fromJson(data) as T;
    }
    if (t == _i41.SupportCategoryStatus) {
      return _i41.SupportCategoryStatus.fromJson(data) as T;
    }
    if (t == _i42.SupportGoal) {
      return _i42.SupportGoal.fromJson(data) as T;
    }
    if (t == _i43.SupportGoalCheck) {
      return _i43.SupportGoalCheck.fromJson(data) as T;
    }
    if (t == _i44.SupportLevel) {
      return _i44.SupportLevel.fromJson(data) as T;
    }
    if (t == _i45.SupportLevelLegacyDto) {
      return _i45.SupportLevelLegacyDto.fromJson(data) as T;
    }
    if (t == _i46.CompulsoryRoom) {
      return _i46.CompulsoryRoom.fromJson(data) as T;
    }
    if (t == _i47.MatrixRoomType) {
      return _i47.MatrixRoomType.fromJson(data) as T;
    }
    if (t == _i48.AfterSchoolCare) {
      return _i48.AfterSchoolCare.fromJson(data) as T;
    }
    if (t == _i49.AfterSchoolCarePickUpTimes) {
      return _i49.AfterSchoolCarePickUpTimes.fromJson(data) as T;
    }
    if (t == _i50.PickUpInfo) {
      return _i50.PickUpInfo.fromJson(data) as T;
    }
    if (t == _i51.CommunicationSkills) {
      return _i51.CommunicationSkills.fromJson(data) as T;
    }
    if (t == _i52.PublicMediaAuth) {
      return _i52.PublicMediaAuth.fromJson(data) as T;
    }
    if (t == _i53.TutorInfo) {
      return _i53.TutorInfo.fromJson(data) as T;
    }
    if (t == _i54.CreditTransaction) {
      return _i54.CreditTransaction.fromJson(data) as T;
    }
    if (t == _i55.PupilDocumentType) {
      return _i55.PupilDocumentType.fromJson(data) as T;
    }
    if (t == _i56.SiblingsTutorInfo) {
      return _i56.SiblingsTutorInfo.fromJson(data) as T;
    }
    if (t == _i57.Kindergarden) {
      return _i57.Kindergarden.fromJson(data) as T;
    }
    if (t == _i58.KindergardenInfo) {
      return _i58.KindergardenInfo.fromJson(data) as T;
    }
    if (t == _i59.PreSchoolMedical) {
      return _i59.PreSchoolMedical.fromJson(data) as T;
    }
    if (t == _i60.PreSchoolMedicalStatus) {
      return _i60.PreSchoolMedicalStatus.fromJson(data) as T;
    }
    if (t == _i61.PreSchoolTest) {
      return _i61.PreSchoolTest.fromJson(data) as T;
    }
    if (t == _i62.PupilData) {
      return _i62.PupilData.fromJson(data) as T;
    }
    if (t == _i63.PupilStatus) {
      return _i63.PupilStatus.fromJson(data) as T;
    }
    if (t == _i64.MemberOperation) {
      return _i64.MemberOperation.fromJson(data) as T;
    }
    if (t == _i65.PupilIdentity) {
      return _i65.PupilIdentity.fromJson(data) as T;
    }
    if (t == _i66.PupilIdentityDto) {
      return _i66.PupilIdentityDto.fromJson(data) as T;
    }
    if (t == _i67.SchoolGrade) {
      return _i67.SchoolGrade.fromJson(data) as T;
    }
    if (t == _i68.SchoolData) {
      return _i68.SchoolData.fromJson(data) as T;
    }
    if (t == _i69.PupilListEntry) {
      return _i69.PupilListEntry.fromJson(data) as T;
    }
    if (t == _i70.SchoolList) {
      return _i70.SchoolList.fromJson(data) as T;
    }
    if (t == _i71.SchoolSemester) {
      return _i71.SchoolSemester.fromJson(data) as T;
    }
    if (t == _i72.Schoolday) {
      return _i72.Schoolday.fromJson(data) as T;
    }
    if (t == _i73.SchooldayEvent) {
      return _i73.SchooldayEvent.fromJson(data) as T;
    }
    if (t == _i74.SchooldayEventType) {
      return _i74.SchooldayEventType.fromJson(data) as T;
    }
    if (t == _i75.Classroom) {
      return _i75.Classroom.fromJson(data) as T;
    }
    if (t == _i76.LessonTeacher) {
      return _i76.LessonTeacher.fromJson(data) as T;
    }
    if (t == _i77.ScheduledLessonTeacher) {
      return _i77.ScheduledLessonTeacher.fromJson(data) as T;
    }
    if (t == _i78.Lesson) {
      return _i78.Lesson.fromJson(data) as T;
    }
    if (t == _i79.LessonAttendance) {
      return _i79.LessonAttendance.fromJson(data) as T;
    }
    if (t == _i80.LessonGroup) {
      return _i80.LessonGroup.fromJson(data) as T;
    }
    if (t == _i81.ScheduledLessonGroupMembership) {
      return _i81.ScheduledLessonGroupMembership.fromJson(data) as T;
    }
    if (t == _i82.ScheduledLesson) {
      return _i82.ScheduledLesson.fromJson(data) as T;
    }
    if (t == _i83.Subject) {
      return _i83.Subject.fromJson(data) as T;
    }
    if (t == _i84.TimetableSlot) {
      return _i84.TimetableSlot.fromJson(data) as T;
    }
    if (t == _i85.Weekday) {
      return _i85.Weekday.fromJson(data) as T;
    }
    if (t == _i86.Timetable) {
      return _i86.Timetable.fromJson(data) as T;
    }
    if (t == _i87.Role) {
      return _i87.Role.fromJson(data) as T;
    }
    if (t == _i88.User) {
      return _i88.User.fromJson(data) as T;
    }
    if (t == _i89.UserFlags) {
      return _i89.UserFlags.fromJson(data) as T;
    }
    if (t == _i90.UserWithDevices) {
      return _i90.UserWithDevices.fromJson(data) as T;
    }
    if (t == _i91.PupilWorkbook) {
      return _i91.PupilWorkbook.fromJson(data) as T;
    }
    if (t == _i92.Workbook) {
      return _i92.Workbook.fromJson(data) as T;
    }
    if (t == _i93.MyException) {
      return _i93.MyException.fromJson(data) as T;
    }
    if (t == _i94.HubDocument) {
      return _i94.HubDocument.fromJson(data) as T;
    }
    if (t == _i95.LastPupilIdentiesUpdate) {
      return _i95.LastPupilIdentiesUpdate.fromJson(data) as T;
    }
    if (t == _i1.getType<_i4.CompetenceCheck?>()) {
      return (data != null ? _i4.CompetenceCheck.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.BatchCreateUserEvent?>()) {
      return (data != null ? _i5.BatchCreateUserEvent.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i6.BatchCreateUsersResponse?>()) {
      return (data != null ? _i6.BatchCreateUsersResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i7.CreateUserRequest?>()) {
      return (data != null ? _i7.CreateUserRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.CreatedUserCredential?>()) {
      return (data != null ? _i8.CreatedUserCredential.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.HubLogEntry?>()) {
      return (data != null ? _i9.HubLogEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.HubQueryLogEntry?>()) {
      return (data != null ? _i10.HubQueryLogEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.HubSessionLogEntry?>()) {
      return (data != null ? _i11.HubSessionLogEntry.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.HubSessionLogFilter?>()) {
      return (data != null ? _i12.HubSessionLogFilter.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.HubSessionLogInfo?>()) {
      return (data != null ? _i13.HubSessionLogInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.HubSessionLogResult?>()) {
      return (data != null ? _i14.HubSessionLogResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.ContactedType?>()) {
      return (data != null ? _i15.ContactedType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.MissedSchoolday?>()) {
      return (data != null ? _i16.MissedSchoolday.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.MissedType?>()) {
      return (data != null ? _i17.MissedType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.DeviceInfo?>()) {
      return (data != null ? _i18.DeviceInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.UserDevice?>()) {
      return (data != null ? _i19.UserDevice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.Authorization?>()) {
      return (data != null ? _i20.Authorization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.PupilAuthorization?>()) {
      return (data != null ? _i21.PupilAuthorization.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.Book?>()) {
      return (data != null ? _i22.Book.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.LibraryBookStatsDto?>()) {
      return (data != null ? _i23.LibraryBookStatsDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i24.BookTag?>()) {
      return (data != null ? _i24.BookTag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.BookTagging?>()) {
      return (data != null ? _i25.BookTagging.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.LibraryBook?>()) {
      return (data != null ? _i26.LibraryBook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.LibraryBookLocation?>()) {
      return (data != null ? _i27.LibraryBookLocation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i28.LibraryBookQuery?>()) {
      return (data != null ? _i28.LibraryBookQuery.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.PupilBookLending?>()) {
      return (data != null ? _i29.PupilBookLending.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.ForceLogoutEvent?>()) {
      return (data != null ? _i30.ForceLogoutEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.HubDeleteEvent?>()) {
      return (data != null ? _i31.HubDeleteEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.HubObjectType?>()) {
      return (data != null ? _i32.HubObjectType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.Competence?>()) {
      return (data != null ? _i33.Competence.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.BatchCreateUserError?>()) {
      return (data != null ? _i34.BatchCreateUserError.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i35.CompetenceGoal?>()) {
      return (data != null ? _i35.CompetenceGoal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.CompetenceReport?>()) {
      return (data != null ? _i36.CompetenceReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.CompetenceReportCheck?>()) {
      return (data != null ? _i37.CompetenceReportCheck.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i38.CompetenceReportItem?>()) {
      return (data != null ? _i38.CompetenceReportItem.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i39.LearningSupportPlan?>()) {
      return (data != null ? _i39.LearningSupportPlan.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i40.SupportCategory?>()) {
      return (data != null ? _i40.SupportCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.SupportCategoryStatus?>()) {
      return (data != null ? _i41.SupportCategoryStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i42.SupportGoal?>()) {
      return (data != null ? _i42.SupportGoal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.SupportGoalCheck?>()) {
      return (data != null ? _i43.SupportGoalCheck.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.SupportLevel?>()) {
      return (data != null ? _i44.SupportLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.SupportLevelLegacyDto?>()) {
      return (data != null ? _i45.SupportLevelLegacyDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i46.CompulsoryRoom?>()) {
      return (data != null ? _i46.CompulsoryRoom.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.MatrixRoomType?>()) {
      return (data != null ? _i47.MatrixRoomType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.AfterSchoolCare?>()) {
      return (data != null ? _i48.AfterSchoolCare.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.AfterSchoolCarePickUpTimes?>()) {
      return (data != null
          ? _i49.AfterSchoolCarePickUpTimes.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i50.PickUpInfo?>()) {
      return (data != null ? _i50.PickUpInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.CommunicationSkills?>()) {
      return (data != null ? _i51.CommunicationSkills.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i52.PublicMediaAuth?>()) {
      return (data != null ? _i52.PublicMediaAuth.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.TutorInfo?>()) {
      return (data != null ? _i53.TutorInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.CreditTransaction?>()) {
      return (data != null ? _i54.CreditTransaction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.PupilDocumentType?>()) {
      return (data != null ? _i55.PupilDocumentType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.SiblingsTutorInfo?>()) {
      return (data != null ? _i56.SiblingsTutorInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.Kindergarden?>()) {
      return (data != null ? _i57.Kindergarden.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.KindergardenInfo?>()) {
      return (data != null ? _i58.KindergardenInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.PreSchoolMedical?>()) {
      return (data != null ? _i59.PreSchoolMedical.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i60.PreSchoolMedicalStatus?>()) {
      return (data != null ? _i60.PreSchoolMedicalStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i61.PreSchoolTest?>()) {
      return (data != null ? _i61.PreSchoolTest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.PupilData?>()) {
      return (data != null ? _i62.PupilData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.PupilStatus?>()) {
      return (data != null ? _i63.PupilStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.MemberOperation?>()) {
      return (data != null ? _i64.MemberOperation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.PupilIdentity?>()) {
      return (data != null ? _i65.PupilIdentity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i66.PupilIdentityDto?>()) {
      return (data != null ? _i66.PupilIdentityDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.SchoolGrade?>()) {
      return (data != null ? _i67.SchoolGrade.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.SchoolData?>()) {
      return (data != null ? _i68.SchoolData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i69.PupilListEntry?>()) {
      return (data != null ? _i69.PupilListEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i70.SchoolList?>()) {
      return (data != null ? _i70.SchoolList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i71.SchoolSemester?>()) {
      return (data != null ? _i71.SchoolSemester.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i72.Schoolday?>()) {
      return (data != null ? _i72.Schoolday.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i73.SchooldayEvent?>()) {
      return (data != null ? _i73.SchooldayEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i74.SchooldayEventType?>()) {
      return (data != null ? _i74.SchooldayEventType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i75.Classroom?>()) {
      return (data != null ? _i75.Classroom.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i76.LessonTeacher?>()) {
      return (data != null ? _i76.LessonTeacher.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i77.ScheduledLessonTeacher?>()) {
      return (data != null ? _i77.ScheduledLessonTeacher.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i78.Lesson?>()) {
      return (data != null ? _i78.Lesson.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i79.LessonAttendance?>()) {
      return (data != null ? _i79.LessonAttendance.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i80.LessonGroup?>()) {
      return (data != null ? _i80.LessonGroup.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i81.ScheduledLessonGroupMembership?>()) {
      return (data != null
          ? _i81.ScheduledLessonGroupMembership.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i82.ScheduledLesson?>()) {
      return (data != null ? _i82.ScheduledLesson.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i83.Subject?>()) {
      return (data != null ? _i83.Subject.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i84.TimetableSlot?>()) {
      return (data != null ? _i84.TimetableSlot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i85.Weekday?>()) {
      return (data != null ? _i85.Weekday.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i86.Timetable?>()) {
      return (data != null ? _i86.Timetable.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i87.Role?>()) {
      return (data != null ? _i87.Role.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i88.User?>()) {
      return (data != null ? _i88.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i89.UserFlags?>()) {
      return (data != null ? _i89.UserFlags.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i90.UserWithDevices?>()) {
      return (data != null ? _i90.UserWithDevices.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i91.PupilWorkbook?>()) {
      return (data != null ? _i91.PupilWorkbook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i92.Workbook?>()) {
      return (data != null ? _i92.Workbook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i93.MyException?>()) {
      return (data != null ? _i93.MyException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i94.HubDocument?>()) {
      return (data != null ? _i94.HubDocument.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i95.LastPupilIdentiesUpdate?>()) {
      return (data != null ? _i95.LastPupilIdentiesUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<List<_i94.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i94.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == List<_i8.CreatedUserCredential>) {
      return (data as List)
          .map((e) => deserialize<_i8.CreatedUserCredential>(e))
          .toList() as T;
    }
    if (t == List<_i34.BatchCreateUserError>) {
      return (data as List)
          .map((e) => deserialize<_i34.BatchCreateUserError>(e))
          .toList() as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<Set<int>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<int>(e)).toSet()
          : null) as T;
    }
    if (t == List<_i9.HubLogEntry>) {
      return (data as List).map((e) => deserialize<_i9.HubLogEntry>(e)).toList()
          as T;
    }
    if (t == List<_i10.HubQueryLogEntry>) {
      return (data as List)
          .map((e) => deserialize<_i10.HubQueryLogEntry>(e))
          .toList() as T;
    }
    if (t == List<_i13.HubSessionLogInfo>) {
      return (data as List)
          .map((e) => deserialize<_i13.HubSessionLogInfo>(e))
          .toList() as T;
    }
    if (t == _i1.getType<List<_i21.PupilAuthorization>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i21.PupilAuthorization>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i25.BookTagging>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i25.BookTagging>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i26.LibraryBook>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i26.LibraryBook>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i25.BookTagging>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i25.BookTagging>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i29.PupilBookLending>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i29.PupilBookLending>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i26.LibraryBook>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i26.LibraryBook>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i24.BookTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i24.BookTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i94.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i94.HubDocument>(e)).toList()
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
    if (t == _i1.getType<List<_i35.CompetenceGoal>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i35.CompetenceGoal>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i4.CompetenceCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i4.CompetenceCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i94.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i94.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i37.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i37.CompetenceReportCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i37.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i37.CompetenceReportCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i41.SupportCategoryStatus>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i41.SupportCategoryStatus>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i42.SupportGoal>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i42.SupportGoal>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i42.SupportGoal>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i42.SupportGoal>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i41.SupportCategoryStatus>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i41.SupportCategoryStatus>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i94.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i94.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i43.SupportGoalCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i43.SupportGoalCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i94.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i94.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i39.LearningSupportPlan>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i39.LearningSupportPlan>(e))
              .toList()
          : null) as T;
    }
    if (t == Set<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toSet() as T;
    }
    if (t == _i1.getType<List<_i62.PupilData>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i62.PupilData>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i94.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i94.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i94.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i94.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i21.PupilAuthorization>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i21.PupilAuthorization>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i54.CreditTransaction>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i54.CreditTransaction>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i81.ScheduledLessonGroupMembership>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i81.ScheduledLessonGroupMembership>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i79.LessonAttendance>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i79.LessonAttendance>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i35.CompetenceGoal>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i35.CompetenceGoal>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i4.CompetenceCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i4.CompetenceCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i36.CompetenceReport>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i36.CompetenceReport>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i37.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i37.CompetenceReportCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i91.PupilWorkbook>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i91.PupilWorkbook>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i29.PupilBookLending>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i29.PupilBookLending>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i44.SupportLevel>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i44.SupportLevel>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i41.SupportCategoryStatus>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i41.SupportCategoryStatus>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i42.SupportGoal>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i42.SupportGoal>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i39.LearningSupportPlan>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i39.LearningSupportPlan>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i16.MissedSchoolday>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i16.MissedSchoolday>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i73.SchooldayEvent>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i73.SchooldayEvent>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i69.PupilListEntry>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i69.PupilListEntry>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i69.PupilListEntry>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i69.PupilListEntry>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i86.Timetable>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i86.Timetable>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i72.Schoolday>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i72.Schoolday>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i36.CompetenceReport>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i36.CompetenceReport>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i39.LearningSupportPlan>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i39.LearningSupportPlan>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i16.MissedSchoolday>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i16.MissedSchoolday>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i73.SchooldayEvent>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i73.SchooldayEvent>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i82.ScheduledLesson>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i82.ScheduledLesson>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i79.LessonAttendance>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i79.LessonAttendance>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i76.LessonTeacher>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i76.LessonTeacher>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i82.ScheduledLesson>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i82.ScheduledLesson>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i81.ScheduledLessonGroupMembership>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i81.ScheduledLessonGroupMembership>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i77.ScheduledLessonTeacher>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i77.ScheduledLessonTeacher>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<({int testint, String testString})?>()) {
      return (data == null)
          ? null as T
          : (
              testint: deserialize<int>(((data as Map)['n'] as Map)['testint']),
              testString: deserialize<String>(data['n']['testString']),
            ) as T;
    }
    if (t == _i1.getType<List<_i82.ScheduledLesson>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i82.ScheduledLesson>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i78.Lesson>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i78.Lesson>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i82.ScheduledLesson>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i82.ScheduledLesson>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i84.TimetableSlot>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i84.TimetableSlot>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i80.LessonGroup>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i80.LessonGroup>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<({String modifiedBy, DateTime modifiedAt})>?>()) {
      return (data != null
          ? (data as List)
              .map((e) =>
                  deserialize<({String modifiedBy, DateTime modifiedAt})>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<({String modifiedBy, DateTime modifiedAt})>()) {
      return (
        modifiedBy:
            deserialize<String>(((data as Map)['n'] as Map)['modifiedBy']),
        modifiedAt: deserialize<DateTime>(data['n']['modifiedAt']),
      ) as T;
    }
    if (t == _i1.getType<List<_i77.ScheduledLessonTeacher>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i77.ScheduledLessonTeacher>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i76.LessonTeacher>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i76.LessonTeacher>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Set<int>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<int>(e)).toSet()
          : null) as T;
    }
    if (t == List<_i19.UserDevice>) {
      return (data as List).map((e) => deserialize<_i19.UserDevice>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i91.PupilWorkbook>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i91.PupilWorkbook>(e))
              .toList()
          : null) as T;
    }
    if (t == List<_i96.Competence>) {
      return (data as List).map((e) => deserialize<_i96.Competence>(e)).toList()
          as T;
    }
    if (t == List<_i97.SupportCategory>) {
      return (data as List)
          .map((e) => deserialize<_i97.SupportCategory>(e))
          .toList() as T;
    }
    if (t == Set<_i98.PupilData>) {
      return (data as List).map((e) => deserialize<_i98.PupilData>(e)).toSet()
          as T;
    }
    if (t == List<_i99.Schoolday>) {
      return (data as List).map((e) => deserialize<_i99.Schoolday>(e)).toList()
          as T;
    }
    if (t == List<DateTime>) {
      return (data as List).map((e) => deserialize<DateTime>(e)).toList() as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<Set<int>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<int>(e)).toSet()
          : null) as T;
    }
    if (t == List<_i100.CreateUserRequest>) {
      return (data as List)
          .map((e) => deserialize<_i100.CreateUserRequest>(e))
          .toList() as T;
    }
    if (t == Set<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toSet() as T;
    }
    if (t == List<_i101.MissedSchoolday>) {
      return (data as List)
          .map((e) => deserialize<_i101.MissedSchoolday>(e))
          .toList() as T;
    }
    if (t ==
        _i1.getType<
            ({
              _i3.AuthenticationResponse response,
              _i102.UserDevice? userDevice
            })>()) {
      return (
        response: deserialize<_i3.AuthenticationResponse>(
            ((data as Map)['n'] as Map)['response']),
        userDevice: ((data)['n'] as Map)['userDevice'] == null
            ? null
            : deserialize<_i102.UserDevice>(data['n']['userDevice']),
      ) as T;
    }
    if (t == List<_i103.Authorization>) {
      return (data as List)
          .map((e) => deserialize<_i103.Authorization>(e))
          .toList() as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t ==
        _i1.getType<
            ({_i104.MemberOperation operation, List<int> pupilIds})?>()) {
      return (data == null)
          ? null as T
          : (
              operation: deserialize<_i104.MemberOperation>(
                  ((data as Map)['n'] as Map)['operation']),
              pupilIds: deserialize<List<int>>(data['n']['pupilIds']),
            ) as T;
    }
    if (t == List<_i105.BookTag>) {
      return (data as List).map((e) => deserialize<_i105.BookTag>(e)).toList()
          as T;
    }
    if (t == List<_i106.Book>) {
      return (data as List).map((e) => deserialize<_i106.Book>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i105.BookTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i105.BookTag>(e)).toList()
          : null) as T;
    }
    if (t == List<_i107.LibraryBookLocation>) {
      return (data as List)
          .map((e) => deserialize<_i107.LibraryBookLocation>(e))
          .toList() as T;
    }
    if (t == List<_i108.LibraryBook>) {
      return (data as List)
          .map((e) => deserialize<_i108.LibraryBook>(e))
          .toList() as T;
    }
    if (t == List<_i109.PupilBookLending>) {
      return (data as List)
          .map((e) => deserialize<_i109.PupilBookLending>(e))
          .toList() as T;
    }
    if (t == _i1.getType<({int value})?>()) {
      return (data == null)
          ? null as T
          : (value: deserialize<int>(((data as Map)['n'] as Map)['value']),)
              as T;
    }
    if (t == _i1.getType<({double value})?>()) {
      return (data == null)
          ? null as T
          : (value: deserialize<double>(((data as Map)['n'] as Map)['value']),)
              as T;
    }
    if (t == _i1.getType<({String value})?>()) {
      return (data == null)
          ? null as T
          : (value: deserialize<String>(((data as Map)['n'] as Map)['value']),)
              as T;
    }
    if (t == _i1.getType<({String? value})?>()) {
      return (data == null)
          ? null as T
          : (
              value: ((data as Map)['n'] as Map)['value'] == null
                  ? null
                  : deserialize<String>(data['n']['value']),
            ) as T;
    }
    if (t == List<_i110.CompetenceGoal>) {
      return (data as List)
          .map((e) => deserialize<_i110.CompetenceGoal>(e))
          .toList() as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<({List<String>? value})?>()) {
      return (data == null)
          ? null as T
          : (
              value: ((data as Map)['n'] as Map)['value'] == null
                  ? null
                  : deserialize<List<String>>(data['n']['value']),
            ) as T;
    }
    if (t == _i1.getType<({int? value})?>()) {
      return (data == null)
          ? null as T
          : (
              value: ((data as Map)['n'] as Map)['value'] == null
                  ? null
                  : deserialize<int>(data['n']['value']),
            ) as T;
    }
    if (t == _i1.getType<({DateTime? value})?>()) {
      return (data == null)
          ? null as T
          : (
              value: ((data as Map)['n'] as Map)['value'] == null
                  ? null
                  : deserialize<DateTime>(data['n']['value']),
            ) as T;
    }
    if (t == _i1.getType<({bool? value})?>()) {
      return (data == null)
          ? null as T
          : (
              value: ((data as Map)['n'] as Map)['value'] == null
                  ? null
                  : deserialize<bool>(data['n']['value']),
            ) as T;
    }
    if (t == List<_i111.CompetenceReport>) {
      return (data as List)
          .map((e) => deserialize<_i111.CompetenceReport>(e))
          .toList() as T;
    }
    if (t == _i1.getType<({DateTime value})?>()) {
      return (data == null)
          ? null as T
          : (
              value:
                  deserialize<DateTime>(((data as Map)['n'] as Map)['value']),
            ) as T;
    }
    if (t == List<_i112.CompetenceReportItem>) {
      return (data as List)
          .map((e) => deserialize<_i112.CompetenceReportItem>(e))
          .toList() as T;
    }
    if (t == List<_i113.SupportGoal>) {
      return (data as List)
          .map((e) => deserialize<_i113.SupportGoal>(e))
          .toList() as T;
    }
    if (t == List<_i114.LearningSupportPlan>) {
      return (data as List)
          .map((e) => deserialize<_i114.LearningSupportPlan>(e))
          .toList() as T;
    }
    if (t == List<_i115.SupportCategoryStatus>) {
      return (data as List)
          .map((e) => deserialize<_i115.SupportCategoryStatus>(e))
          .toList() as T;
    }
    if (t == List<_i116.PreSchoolMedical>) {
      return (data as List)
          .map((e) => deserialize<_i116.PreSchoolMedical>(e))
          .toList() as T;
    }
    if (t == _i1.getType<List<_i117.CompulsoryRoom>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i117.CompulsoryRoom>(e))
              .toList()
          : null) as T;
    }
    if (t == List<_i117.CompulsoryRoom>) {
      return (data as List)
          .map((e) => deserialize<_i117.CompulsoryRoom>(e))
          .toList() as T;
    }
    if (t == List<_i98.PupilData>) {
      return (data as List).map((e) => deserialize<_i98.PupilData>(e)).toList()
          as T;
    }
    if (t == List<_i118.SupportLevelLegacyDto>) {
      return (data as List)
          .map((e) => deserialize<_i118.SupportLevelLegacyDto>(e))
          .toList() as T;
    }
    if (t == _i1.getType<({DateTime? value})>()) {
      return (
        value: ((data as Map)['n'] as Map)['value'] == null
            ? null
            : deserialize<DateTime>(data['n']['value']),
      ) as T;
    }
    if (t == List<_i119.SchoolList>) {
      return (data as List)
          .map((e) => deserialize<_i119.SchoolList>(e))
          .toList() as T;
    }
    if (t == List<_i120.SchoolSemester>) {
      return (data as List)
          .map((e) => deserialize<_i120.SchoolSemester>(e))
          .toList() as T;
    }
    if (t == List<_i121.SchooldayEvent>) {
      return (data as List)
          .map((e) => deserialize<_i121.SchooldayEvent>(e))
          .toList() as T;
    }
    if (t == List<_i122.Classroom>) {
      return (data as List).map((e) => deserialize<_i122.Classroom>(e)).toList()
          as T;
    }
    if (t == List<_i123.LessonGroup>) {
      return (data as List)
          .map((e) => deserialize<_i123.LessonGroup>(e))
          .toList() as T;
    }
    if (t == List<_i124.ScheduledLesson>) {
      return (data as List)
          .map((e) => deserialize<_i124.ScheduledLesson>(e))
          .toList() as T;
    }
    if (t == List<_i125.ScheduledLessonGroupMembership>) {
      return (data as List)
          .map((e) => deserialize<_i125.ScheduledLessonGroupMembership>(e))
          .toList() as T;
    }
    if (t == List<_i126.Subject>) {
      return (data as List).map((e) => deserialize<_i126.Subject>(e)).toList()
          as T;
    }
    if (t == List<_i127.Timetable>) {
      return (data as List).map((e) => deserialize<_i127.Timetable>(e)).toList()
          as T;
    }
    if (t == List<_i128.TimetableSlot>) {
      return (data as List)
          .map((e) => deserialize<_i128.TimetableSlot>(e))
          .toList() as T;
    }
    if (t == List<_i129.User>) {
      return (data as List).map((e) => deserialize<_i129.User>(e)).toList()
          as T;
    }
    if (t == List<_i130.UserWithDevices>) {
      return (data as List)
          .map((e) => deserialize<_i130.UserWithDevices>(e))
          .toList() as T;
    }
    if (t == List<_i131.PupilWorkbook>) {
      return (data as List)
          .map((e) => deserialize<_i131.PupilWorkbook>(e))
          .toList() as T;
    }
    if (t == List<_i132.Workbook>) {
      return (data as List).map((e) => deserialize<_i132.Workbook>(e)).toList()
          as T;
    }
    if (t == _i1.getType<({int testint, String testString})?>()) {
      return (data == null)
          ? null as T
          : (
              testint: deserialize<int>(((data as Map)['n'] as Map)['testint']),
              testString: deserialize<String>(data['n']['testString']),
            ) as T;
    }
    if (t == _i1.getType<List<({String modifiedBy, DateTime modifiedAt})>?>()) {
      return (data != null
          ? (data as List)
              .map((e) =>
                  deserialize<({String modifiedBy, DateTime modifiedAt})>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<({String modifiedBy, DateTime modifiedAt})>()) {
      return (
        modifiedBy:
            deserialize<String>(((data as Map)['n'] as Map)['modifiedBy']),
        modifiedAt: deserialize<DateTime>(data['n']['modifiedAt']),
      ) as T;
    }
    if (t == _i1.getType<({String modifiedBy, DateTime modifiedAt})>()) {
      return (
        modifiedBy:
            deserialize<String>(((data as Map)['n'] as Map)['modifiedBy']),
        modifiedAt: deserialize<DateTime>(data['n']['modifiedAt']),
      ) as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i4.CompetenceCheck) {
      return 'CompetenceCheck';
    }
    if (data is _i5.BatchCreateUserEvent) {
      return 'BatchCreateUserEvent';
    }
    if (data is _i6.BatchCreateUsersResponse) {
      return 'BatchCreateUsersResponse';
    }
    if (data is _i7.CreateUserRequest) {
      return 'CreateUserRequest';
    }
    if (data is _i8.CreatedUserCredential) {
      return 'CreatedUserCredential';
    }
    if (data is _i9.HubLogEntry) {
      return 'HubLogEntry';
    }
    if (data is _i10.HubQueryLogEntry) {
      return 'HubQueryLogEntry';
    }
    if (data is _i11.HubSessionLogEntry) {
      return 'HubSessionLogEntry';
    }
    if (data is _i12.HubSessionLogFilter) {
      return 'HubSessionLogFilter';
    }
    if (data is _i13.HubSessionLogInfo) {
      return 'HubSessionLogInfo';
    }
    if (data is _i14.HubSessionLogResult) {
      return 'HubSessionLogResult';
    }
    if (data is _i15.ContactedType) {
      return 'ContactedType';
    }
    if (data is _i16.MissedSchoolday) {
      return 'MissedSchoolday';
    }
    if (data is _i17.MissedType) {
      return 'MissedType';
    }
    if (data is _i18.DeviceInfo) {
      return 'DeviceInfo';
    }
    if (data is _i19.UserDevice) {
      return 'UserDevice';
    }
    if (data is _i20.Authorization) {
      return 'Authorization';
    }
    if (data is _i21.PupilAuthorization) {
      return 'PupilAuthorization';
    }
    if (data is _i22.Book) {
      return 'Book';
    }
    if (data is _i23.LibraryBookStatsDto) {
      return 'LibraryBookStatsDto';
    }
    if (data is _i24.BookTag) {
      return 'BookTag';
    }
    if (data is _i25.BookTagging) {
      return 'BookTagging';
    }
    if (data is _i26.LibraryBook) {
      return 'LibraryBook';
    }
    if (data is _i27.LibraryBookLocation) {
      return 'LibraryBookLocation';
    }
    if (data is _i28.LibraryBookQuery) {
      return 'LibraryBookQuery';
    }
    if (data is _i29.PupilBookLending) {
      return 'PupilBookLending';
    }
    if (data is _i30.ForceLogoutEvent) {
      return 'ForceLogoutEvent';
    }
    if (data is _i31.HubDeleteEvent) {
      return 'HubDeleteEvent';
    }
    if (data is _i32.HubObjectType) {
      return 'HubObjectType';
    }
    if (data is _i33.Competence) {
      return 'Competence';
    }
    if (data is _i34.BatchCreateUserError) {
      return 'BatchCreateUserError';
    }
    if (data is _i35.CompetenceGoal) {
      return 'CompetenceGoal';
    }
    if (data is _i36.CompetenceReport) {
      return 'CompetenceReport';
    }
    if (data is _i37.CompetenceReportCheck) {
      return 'CompetenceReportCheck';
    }
    if (data is _i38.CompetenceReportItem) {
      return 'CompetenceReportItem';
    }
    if (data is _i39.LearningSupportPlan) {
      return 'LearningSupportPlan';
    }
    if (data is _i40.SupportCategory) {
      return 'SupportCategory';
    }
    if (data is _i41.SupportCategoryStatus) {
      return 'SupportCategoryStatus';
    }
    if (data is _i42.SupportGoal) {
      return 'SupportGoal';
    }
    if (data is _i43.SupportGoalCheck) {
      return 'SupportGoalCheck';
    }
    if (data is _i44.SupportLevel) {
      return 'SupportLevel';
    }
    if (data is _i45.SupportLevelLegacyDto) {
      return 'SupportLevelLegacyDto';
    }
    if (data is _i46.CompulsoryRoom) {
      return 'CompulsoryRoom';
    }
    if (data is _i47.MatrixRoomType) {
      return 'MatrixRoomType';
    }
    if (data is _i48.AfterSchoolCare) {
      return 'AfterSchoolCare';
    }
    if (data is _i49.AfterSchoolCarePickUpTimes) {
      return 'AfterSchoolCarePickUpTimes';
    }
    if (data is _i50.PickUpInfo) {
      return 'PickUpInfo';
    }
    if (data is _i51.CommunicationSkills) {
      return 'CommunicationSkills';
    }
    if (data is _i52.PublicMediaAuth) {
      return 'PublicMediaAuth';
    }
    if (data is _i53.TutorInfo) {
      return 'TutorInfo';
    }
    if (data is _i54.CreditTransaction) {
      return 'CreditTransaction';
    }
    if (data is _i55.PupilDocumentType) {
      return 'PupilDocumentType';
    }
    if (data is _i56.SiblingsTutorInfo) {
      return 'SiblingsTutorInfo';
    }
    if (data is _i57.Kindergarden) {
      return 'Kindergarden';
    }
    if (data is _i58.KindergardenInfo) {
      return 'KindergardenInfo';
    }
    if (data is _i59.PreSchoolMedical) {
      return 'PreSchoolMedical';
    }
    if (data is _i60.PreSchoolMedicalStatus) {
      return 'PreSchoolMedicalStatus';
    }
    if (data is _i61.PreSchoolTest) {
      return 'PreSchoolTest';
    }
    if (data is _i62.PupilData) {
      return 'PupilData';
    }
    if (data is _i63.PupilStatus) {
      return 'PupilStatus';
    }
    if (data is _i64.MemberOperation) {
      return 'MemberOperation';
    }
    if (data is _i65.PupilIdentity) {
      return 'PupilIdentity';
    }
    if (data is _i66.PupilIdentityDto) {
      return 'PupilIdentityDto';
    }
    if (data is _i67.SchoolGrade) {
      return 'SchoolGrade';
    }
    if (data is _i68.SchoolData) {
      return 'SchoolData';
    }
    if (data is _i69.PupilListEntry) {
      return 'PupilListEntry';
    }
    if (data is _i70.SchoolList) {
      return 'SchoolList';
    }
    if (data is _i71.SchoolSemester) {
      return 'SchoolSemester';
    }
    if (data is _i72.Schoolday) {
      return 'Schoolday';
    }
    if (data is _i73.SchooldayEvent) {
      return 'SchooldayEvent';
    }
    if (data is _i74.SchooldayEventType) {
      return 'SchooldayEventType';
    }
    if (data is _i75.Classroom) {
      return 'Classroom';
    }
    if (data is _i76.LessonTeacher) {
      return 'LessonTeacher';
    }
    if (data is _i77.ScheduledLessonTeacher) {
      return 'ScheduledLessonTeacher';
    }
    if (data is _i78.Lesson) {
      return 'Lesson';
    }
    if (data is _i79.LessonAttendance) {
      return 'LessonAttendance';
    }
    if (data is _i80.LessonGroup) {
      return 'LessonGroup';
    }
    if (data is _i81.ScheduledLessonGroupMembership) {
      return 'ScheduledLessonGroupMembership';
    }
    if (data is _i82.ScheduledLesson) {
      return 'ScheduledLesson';
    }
    if (data is _i83.Subject) {
      return 'Subject';
    }
    if (data is _i84.TimetableSlot) {
      return 'TimetableSlot';
    }
    if (data is _i85.Weekday) {
      return 'Weekday';
    }
    if (data is _i86.Timetable) {
      return 'Timetable';
    }
    if (data is _i87.Role) {
      return 'Role';
    }
    if (data is _i88.User) {
      return 'User';
    }
    if (data is _i89.UserFlags) {
      return 'UserFlags';
    }
    if (data is _i90.UserWithDevices) {
      return 'UserWithDevices';
    }
    if (data is _i91.PupilWorkbook) {
      return 'PupilWorkbook';
    }
    if (data is _i92.Workbook) {
      return 'Workbook';
    }
    if (data is _i93.MyException) {
      return 'MyException';
    }
    if (data is _i94.HubDocument) {
      return 'HubDocument';
    }
    if (data is _i95.LastPupilIdentiesUpdate) {
      return 'LastPupilIdentiesUpdate';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    if (data is List<_i98.PupilData>) {
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
    if (dataClassName == 'CompetenceCheck') {
      return deserialize<_i4.CompetenceCheck>(data['data']);
    }
    if (dataClassName == 'BatchCreateUserEvent') {
      return deserialize<_i5.BatchCreateUserEvent>(data['data']);
    }
    if (dataClassName == 'BatchCreateUsersResponse') {
      return deserialize<_i6.BatchCreateUsersResponse>(data['data']);
    }
    if (dataClassName == 'CreateUserRequest') {
      return deserialize<_i7.CreateUserRequest>(data['data']);
    }
    if (dataClassName == 'CreatedUserCredential') {
      return deserialize<_i8.CreatedUserCredential>(data['data']);
    }
    if (dataClassName == 'HubLogEntry') {
      return deserialize<_i9.HubLogEntry>(data['data']);
    }
    if (dataClassName == 'HubQueryLogEntry') {
      return deserialize<_i10.HubQueryLogEntry>(data['data']);
    }
    if (dataClassName == 'HubSessionLogEntry') {
      return deserialize<_i11.HubSessionLogEntry>(data['data']);
    }
    if (dataClassName == 'HubSessionLogFilter') {
      return deserialize<_i12.HubSessionLogFilter>(data['data']);
    }
    if (dataClassName == 'HubSessionLogInfo') {
      return deserialize<_i13.HubSessionLogInfo>(data['data']);
    }
    if (dataClassName == 'HubSessionLogResult') {
      return deserialize<_i14.HubSessionLogResult>(data['data']);
    }
    if (dataClassName == 'ContactedType') {
      return deserialize<_i15.ContactedType>(data['data']);
    }
    if (dataClassName == 'MissedSchoolday') {
      return deserialize<_i16.MissedSchoolday>(data['data']);
    }
    if (dataClassName == 'MissedType') {
      return deserialize<_i17.MissedType>(data['data']);
    }
    if (dataClassName == 'DeviceInfo') {
      return deserialize<_i18.DeviceInfo>(data['data']);
    }
    if (dataClassName == 'UserDevice') {
      return deserialize<_i19.UserDevice>(data['data']);
    }
    if (dataClassName == 'Authorization') {
      return deserialize<_i20.Authorization>(data['data']);
    }
    if (dataClassName == 'PupilAuthorization') {
      return deserialize<_i21.PupilAuthorization>(data['data']);
    }
    if (dataClassName == 'Book') {
      return deserialize<_i22.Book>(data['data']);
    }
    if (dataClassName == 'LibraryBookStatsDto') {
      return deserialize<_i23.LibraryBookStatsDto>(data['data']);
    }
    if (dataClassName == 'BookTag') {
      return deserialize<_i24.BookTag>(data['data']);
    }
    if (dataClassName == 'BookTagging') {
      return deserialize<_i25.BookTagging>(data['data']);
    }
    if (dataClassName == 'LibraryBook') {
      return deserialize<_i26.LibraryBook>(data['data']);
    }
    if (dataClassName == 'LibraryBookLocation') {
      return deserialize<_i27.LibraryBookLocation>(data['data']);
    }
    if (dataClassName == 'LibraryBookQuery') {
      return deserialize<_i28.LibraryBookQuery>(data['data']);
    }
    if (dataClassName == 'PupilBookLending') {
      return deserialize<_i29.PupilBookLending>(data['data']);
    }
    if (dataClassName == 'ForceLogoutEvent') {
      return deserialize<_i30.ForceLogoutEvent>(data['data']);
    }
    if (dataClassName == 'HubDeleteEvent') {
      return deserialize<_i31.HubDeleteEvent>(data['data']);
    }
    if (dataClassName == 'HubObjectType') {
      return deserialize<_i32.HubObjectType>(data['data']);
    }
    if (dataClassName == 'Competence') {
      return deserialize<_i33.Competence>(data['data']);
    }
    if (dataClassName == 'BatchCreateUserError') {
      return deserialize<_i34.BatchCreateUserError>(data['data']);
    }
    if (dataClassName == 'CompetenceGoal') {
      return deserialize<_i35.CompetenceGoal>(data['data']);
    }
    if (dataClassName == 'CompetenceReport') {
      return deserialize<_i36.CompetenceReport>(data['data']);
    }
    if (dataClassName == 'CompetenceReportCheck') {
      return deserialize<_i37.CompetenceReportCheck>(data['data']);
    }
    if (dataClassName == 'CompetenceReportItem') {
      return deserialize<_i38.CompetenceReportItem>(data['data']);
    }
    if (dataClassName == 'LearningSupportPlan') {
      return deserialize<_i39.LearningSupportPlan>(data['data']);
    }
    if (dataClassName == 'SupportCategory') {
      return deserialize<_i40.SupportCategory>(data['data']);
    }
    if (dataClassName == 'SupportCategoryStatus') {
      return deserialize<_i41.SupportCategoryStatus>(data['data']);
    }
    if (dataClassName == 'SupportGoal') {
      return deserialize<_i42.SupportGoal>(data['data']);
    }
    if (dataClassName == 'SupportGoalCheck') {
      return deserialize<_i43.SupportGoalCheck>(data['data']);
    }
    if (dataClassName == 'SupportLevel') {
      return deserialize<_i44.SupportLevel>(data['data']);
    }
    if (dataClassName == 'SupportLevelLegacyDto') {
      return deserialize<_i45.SupportLevelLegacyDto>(data['data']);
    }
    if (dataClassName == 'CompulsoryRoom') {
      return deserialize<_i46.CompulsoryRoom>(data['data']);
    }
    if (dataClassName == 'MatrixRoomType') {
      return deserialize<_i47.MatrixRoomType>(data['data']);
    }
    if (dataClassName == 'AfterSchoolCare') {
      return deserialize<_i48.AfterSchoolCare>(data['data']);
    }
    if (dataClassName == 'AfterSchoolCarePickUpTimes') {
      return deserialize<_i49.AfterSchoolCarePickUpTimes>(data['data']);
    }
    if (dataClassName == 'PickUpInfo') {
      return deserialize<_i50.PickUpInfo>(data['data']);
    }
    if (dataClassName == 'CommunicationSkills') {
      return deserialize<_i51.CommunicationSkills>(data['data']);
    }
    if (dataClassName == 'PublicMediaAuth') {
      return deserialize<_i52.PublicMediaAuth>(data['data']);
    }
    if (dataClassName == 'TutorInfo') {
      return deserialize<_i53.TutorInfo>(data['data']);
    }
    if (dataClassName == 'CreditTransaction') {
      return deserialize<_i54.CreditTransaction>(data['data']);
    }
    if (dataClassName == 'PupilDocumentType') {
      return deserialize<_i55.PupilDocumentType>(data['data']);
    }
    if (dataClassName == 'SiblingsTutorInfo') {
      return deserialize<_i56.SiblingsTutorInfo>(data['data']);
    }
    if (dataClassName == 'Kindergarden') {
      return deserialize<_i57.Kindergarden>(data['data']);
    }
    if (dataClassName == 'KindergardenInfo') {
      return deserialize<_i58.KindergardenInfo>(data['data']);
    }
    if (dataClassName == 'PreSchoolMedical') {
      return deserialize<_i59.PreSchoolMedical>(data['data']);
    }
    if (dataClassName == 'PreSchoolMedicalStatus') {
      return deserialize<_i60.PreSchoolMedicalStatus>(data['data']);
    }
    if (dataClassName == 'PreSchoolTest') {
      return deserialize<_i61.PreSchoolTest>(data['data']);
    }
    if (dataClassName == 'PupilData') {
      return deserialize<_i62.PupilData>(data['data']);
    }
    if (dataClassName == 'PupilStatus') {
      return deserialize<_i63.PupilStatus>(data['data']);
    }
    if (dataClassName == 'MemberOperation') {
      return deserialize<_i64.MemberOperation>(data['data']);
    }
    if (dataClassName == 'PupilIdentity') {
      return deserialize<_i65.PupilIdentity>(data['data']);
    }
    if (dataClassName == 'PupilIdentityDto') {
      return deserialize<_i66.PupilIdentityDto>(data['data']);
    }
    if (dataClassName == 'SchoolGrade') {
      return deserialize<_i67.SchoolGrade>(data['data']);
    }
    if (dataClassName == 'SchoolData') {
      return deserialize<_i68.SchoolData>(data['data']);
    }
    if (dataClassName == 'PupilListEntry') {
      return deserialize<_i69.PupilListEntry>(data['data']);
    }
    if (dataClassName == 'SchoolList') {
      return deserialize<_i70.SchoolList>(data['data']);
    }
    if (dataClassName == 'SchoolSemester') {
      return deserialize<_i71.SchoolSemester>(data['data']);
    }
    if (dataClassName == 'Schoolday') {
      return deserialize<_i72.Schoolday>(data['data']);
    }
    if (dataClassName == 'SchooldayEvent') {
      return deserialize<_i73.SchooldayEvent>(data['data']);
    }
    if (dataClassName == 'SchooldayEventType') {
      return deserialize<_i74.SchooldayEventType>(data['data']);
    }
    if (dataClassName == 'Classroom') {
      return deserialize<_i75.Classroom>(data['data']);
    }
    if (dataClassName == 'LessonTeacher') {
      return deserialize<_i76.LessonTeacher>(data['data']);
    }
    if (dataClassName == 'ScheduledLessonTeacher') {
      return deserialize<_i77.ScheduledLessonTeacher>(data['data']);
    }
    if (dataClassName == 'Lesson') {
      return deserialize<_i78.Lesson>(data['data']);
    }
    if (dataClassName == 'LessonAttendance') {
      return deserialize<_i79.LessonAttendance>(data['data']);
    }
    if (dataClassName == 'LessonGroup') {
      return deserialize<_i80.LessonGroup>(data['data']);
    }
    if (dataClassName == 'ScheduledLessonGroupMembership') {
      return deserialize<_i81.ScheduledLessonGroupMembership>(data['data']);
    }
    if (dataClassName == 'ScheduledLesson') {
      return deserialize<_i82.ScheduledLesson>(data['data']);
    }
    if (dataClassName == 'Subject') {
      return deserialize<_i83.Subject>(data['data']);
    }
    if (dataClassName == 'TimetableSlot') {
      return deserialize<_i84.TimetableSlot>(data['data']);
    }
    if (dataClassName == 'Weekday') {
      return deserialize<_i85.Weekday>(data['data']);
    }
    if (dataClassName == 'Timetable') {
      return deserialize<_i86.Timetable>(data['data']);
    }
    if (dataClassName == 'Role') {
      return deserialize<_i87.Role>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i88.User>(data['data']);
    }
    if (dataClassName == 'UserFlags') {
      return deserialize<_i89.UserFlags>(data['data']);
    }
    if (dataClassName == 'UserWithDevices') {
      return deserialize<_i90.UserWithDevices>(data['data']);
    }
    if (dataClassName == 'PupilWorkbook') {
      return deserialize<_i91.PupilWorkbook>(data['data']);
    }
    if (dataClassName == 'Workbook') {
      return deserialize<_i92.Workbook>(data['data']);
    }
    if (dataClassName == 'MyException') {
      return deserialize<_i93.MyException>(data['data']);
    }
    if (dataClassName == 'HubDocument') {
      return deserialize<_i94.HubDocument>(data['data']);
    }
    if (dataClassName == 'LastPupilIdentiesUpdate') {
      return deserialize<_i95.LastPupilIdentiesUpdate>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName == 'List<PupilData>') {
      return deserialize<List<_i98.PupilData>>(data['data']);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i16.MissedSchoolday:
        return _i16.MissedSchoolday.t;
      case _i19.UserDevice:
        return _i19.UserDevice.t;
      case _i20.Authorization:
        return _i20.Authorization.t;
      case _i21.PupilAuthorization:
        return _i21.PupilAuthorization.t;
      case _i22.Book:
        return _i22.Book.t;
      case _i24.BookTag:
        return _i24.BookTag.t;
      case _i25.BookTagging:
        return _i25.BookTagging.t;
      case _i26.LibraryBook:
        return _i26.LibraryBook.t;
      case _i27.LibraryBookLocation:
        return _i27.LibraryBookLocation.t;
      case _i29.PupilBookLending:
        return _i29.PupilBookLending.t;
      case _i33.Competence:
        return _i33.Competence.t;
      case _i4.CompetenceCheck:
        return _i4.CompetenceCheck.t;
      case _i35.CompetenceGoal:
        return _i35.CompetenceGoal.t;
      case _i36.CompetenceReport:
        return _i36.CompetenceReport.t;
      case _i37.CompetenceReportCheck:
        return _i37.CompetenceReportCheck.t;
      case _i38.CompetenceReportItem:
        return _i38.CompetenceReportItem.t;
      case _i39.LearningSupportPlan:
        return _i39.LearningSupportPlan.t;
      case _i40.SupportCategory:
        return _i40.SupportCategory.t;
      case _i41.SupportCategoryStatus:
        return _i41.SupportCategoryStatus.t;
      case _i42.SupportGoal:
        return _i42.SupportGoal.t;
      case _i43.SupportGoalCheck:
        return _i43.SupportGoalCheck.t;
      case _i44.SupportLevel:
        return _i44.SupportLevel.t;
      case _i46.CompulsoryRoom:
        return _i46.CompulsoryRoom.t;
      case _i54.CreditTransaction:
        return _i54.CreditTransaction.t;
      case _i57.Kindergarden:
        return _i57.Kindergarden.t;
      case _i59.PreSchoolMedical:
        return _i59.PreSchoolMedical.t;
      case _i61.PreSchoolTest:
        return _i61.PreSchoolTest.t;
      case _i62.PupilData:
        return _i62.PupilData.t;
      case _i95.LastPupilIdentiesUpdate:
        return _i95.LastPupilIdentiesUpdate.t;
      case _i68.SchoolData:
        return _i68.SchoolData.t;
      case _i69.PupilListEntry:
        return _i69.PupilListEntry.t;
      case _i70.SchoolList:
        return _i70.SchoolList.t;
      case _i71.SchoolSemester:
        return _i71.SchoolSemester.t;
      case _i72.Schoolday:
        return _i72.Schoolday.t;
      case _i73.SchooldayEvent:
        return _i73.SchooldayEvent.t;
      case _i75.Classroom:
        return _i75.Classroom.t;
      case _i76.LessonTeacher:
        return _i76.LessonTeacher.t;
      case _i77.ScheduledLessonTeacher:
        return _i77.ScheduledLessonTeacher.t;
      case _i78.Lesson:
        return _i78.Lesson.t;
      case _i79.LessonAttendance:
        return _i79.LessonAttendance.t;
      case _i80.LessonGroup:
        return _i80.LessonGroup.t;
      case _i81.ScheduledLessonGroupMembership:
        return _i81.ScheduledLessonGroupMembership.t;
      case _i82.ScheduledLesson:
        return _i82.ScheduledLesson.t;
      case _i83.Subject:
        return _i83.Subject.t;
      case _i84.TimetableSlot:
        return _i84.TimetableSlot.t;
      case _i86.Timetable:
        return _i86.Timetable.t;
      case _i88.User:
        return _i88.User.t;
      case _i91.PupilWorkbook:
        return _i91.PupilWorkbook.t;
      case _i92.Workbook:
        return _i92.Workbook.t;
      case _i94.HubDocument:
        return _i94.HubDocument.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'school_data_hub';
}

/// Maps any `Record`s known to this [Protocol] to their JSON representation
///
/// Throws in case the record type is not known.
///
/// This method will return `null` (only) for `null` inputs.
Map<String, dynamic>? mapRecordToJson(Record? record) {
  if (record == null) {
    return null;
  }
  if (record is ({
    _i3.AuthenticationResponse response,
    _i102.UserDevice? userDevice
  })) {
    return {
      "n": {
        "response": record.response,
        "userDevice": record.userDevice,
      },
    };
  }
  if (record is ({_i104.MemberOperation operation, List<int> pupilIds})) {
    return {
      "n": {
        "operation": record.operation,
        "pupilIds": record.pupilIds,
      },
    };
  }
  if (record is ({int value})) {
    return {
      "n": {
        "value": record.value,
      },
    };
  }
  if (record is ({double value})) {
    return {
      "n": {
        "value": record.value,
      },
    };
  }
  if (record is ({String value})) {
    return {
      "n": {
        "value": record.value,
      },
    };
  }
  if (record is ({String? value})) {
    return {
      "n": {
        "value": record.value,
      },
    };
  }
  if (record is ({List<String>? value})) {
    return {
      "n": {
        "value": record.value,
      },
    };
  }
  if (record is ({int? value})) {
    return {
      "n": {
        "value": record.value,
      },
    };
  }
  if (record is ({DateTime? value})) {
    return {
      "n": {
        "value": record.value,
      },
    };
  }
  if (record is ({bool? value})) {
    return {
      "n": {
        "value": record.value,
      },
    };
  }
  if (record is ({DateTime value})) {
    return {
      "n": {
        "value": record.value,
      },
    };
  }
  if (record is ({int testint, String testString})) {
    return {
      "n": {
        "testint": record.testint,
        "testString": record.testString,
      },
    };
  }
  if (record is ({String modifiedBy, DateTime modifiedAt})) {
    return {
      "n": {
        "modifiedBy": record.modifiedBy,
        "modifiedAt": record.modifiedAt,
      },
    };
  }
  throw Exception('Unsupported record type ${record.runtimeType}');
}

/// Maps container types (like [List], [Map], [Set]) containing [Record]s to their JSON representation.
///
/// It should not be called for [SerializableModel] types. These handle the "[Record] in container" mapping internally already.
///
/// It is only supposed to be called from generated protocol code.
///
/// Returns either a `List<dynamic>` (for List, Sets, and Maps with non-String keys) or a `Map<String, dynamic>` in case the input was a `Map<String, …>`.
Object? mapRecordContainingContainerToJson(Object obj) {
  if (obj is! Iterable && obj is! Map) {
    throw ArgumentError.value(
      obj,
      'obj',
      'The object to serialize should be of type List, Map, or Set',
    );
  }

  dynamic mapIfNeeded(Object? obj) {
    return switch (obj) {
      Record record => mapRecordToJson(record),
      Iterable iterable => mapRecordContainingContainerToJson(iterable),
      Map map => mapRecordContainingContainerToJson(map),
      Object? value => value,
    };
  }

  switch (obj) {
    case Map<String, dynamic>():
      return {
        for (var entry in obj.entries) entry.key: mapIfNeeded(entry.value),
      };
    case Map():
      return [
        for (var entry in obj.entries)
          {
            'k': mapIfNeeded(entry.key),
            'v': mapIfNeeded(entry.value),
          }
      ];

    case Iterable():
      return [
        for (var e in obj) mapIfNeeded(e),
      ];
  }

  return obj;
}

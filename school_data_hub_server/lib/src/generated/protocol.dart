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
import '_features/learning_support/models/support_level.dart' as _i4;
import '_features/attendance/models/missed_schoolday.dart' as _i5;
import '_features/attendance/models/missed_schoolday_dto.dart' as _i6;
import '_features/attendance/models/missed_type.dart' as _i7;
import '_features/authorizations/models/authorization.dart' as _i8;
import '_features/authorizations/models/pupil_authorization.dart' as _i9;
import '_features/books/models/book.dart' as _i10;
import '_features/books/models/book_tagging/book_tag.dart' as _i11;
import '_features/books/models/book_tagging/book_tagging.dart' as _i12;
import '_features/books/models/library_book.dart' as _i13;
import '_features/books/models/library_book_location.dart' as _i14;
import '_features/books/models/library_book_query.dart' as _i15;
import '_features/books/models/pupil_book_lending.dart' as _i16;
import '_features/learning/models/competence.dart' as _i17;
import '_features/learning/models/competence_check.dart' as _i18;
import '_features/learning/models/competence_goal.dart' as _i19;
import '_features/learning/models/competence_report.dart' as _i20;
import '_features/learning/models/competence_report_check.dart' as _i21;
import '_features/learning/models/competence_report_item.dart' as _i22;
import '_features/learning_support/models/learning_support_plan.dart' as _i23;
import '_features/learning_support/models/support_category.dart' as _i24;
import '_features/learning_support/models/support_category_status.dart' as _i25;
import '_features/learning_support/models/support_goal/support_goal.dart'
    as _i26;
import '_features/learning_support/models/support_goal/support_goal_check.dart'
    as _i27;
import '_features/attendance/models/contacted_type.dart' as _i28;
import '_features/matrix/compulsory_room.dart' as _i29;
import '_features/matrix/matrix_room_type.dart' as _i30;
import '_features/pupil/models/pupil_data/after_school_care/after_school_care.dart'
    as _i31;
import '_features/pupil/models/pupil_data/after_school_care/after_school_pickup_times.dart'
    as _i32;
import '_features/pupil/models/pupil_data/after_school_care/pick_up_info.dart'
    as _i33;
import '_features/pupil/models/pupil_data/communication/communication_skills.dart'
    as _i34;
import '_features/pupil/models/pupil_data/communication/public_media_auth.dart'
    as _i35;
import '_features/pupil/models/pupil_data/communication/tutor_info.dart'
    as _i36;
import '_features/pupil/models/pupil_data/credit_transaction.dart' as _i37;
import '_features/pupil/models/pupil_data/dto/pupil_document_type.dart' as _i38;
import '_features/pupil/models/pupil_data/dto/siblings_tutor_info_dto.dart'
    as _i39;
import '_features/pupil/models/pupil_data/preschool/kindergarden.dart' as _i40;
import '_features/pupil/models/pupil_data/preschool/kindergarden_info.dart'
    as _i41;
import '_features/pupil/models/pupil_data/preschool/pre_school_medical.dart'
    as _i42;
import '_features/pupil/models/pupil_data/preschool/pre_school_medical_status.dart'
    as _i43;
import '_features/pupil/models/pupil_data/preschool/pre_school_test.dart'
    as _i44;
import '_features/pupil/models/pupil_data/pupil_data.dart' as _i45;
import '_features/pupil/models/pupil_identity/pupil_identity.dart' as _i46;
import '_features/pupil/models/pupil_identity/pupil_identity_dto.dart' as _i47;
import '_features/pupil/models/pupil_identity/school_grade.dart' as _i48;
import '_features/school_lists/models/pupil_entry.dart' as _i49;
import '_shared/models/member_operation.dart' as _i50;
import '_features/schoolday/models/school_semester.dart' as _i51;
import '_features/schoolday/models/schoolday.dart' as _i52;
import '_features/schoolday_events/models/schoolday_event.dart' as _i53;
import '_features/schoolday_events/models/schoolday_event_type.dart' as _i54;
import '_features/timetable/models/classroom.dart' as _i55;
import '_features/timetable/models/lesson/lesson.dart' as _i56;
import '_features/timetable/models/lesson/lesson_attendance.dart' as _i57;
import '_features/timetable/models/lesson/lesson_group.dart' as _i58;
import '_features/timetable/models/lesson/lesson_group_membership.dart' as _i59;
import '_features/timetable/models/lesson/lesson_subject.dart' as _i60;
import '_features/timetable/models/lesson/subject.dart' as _i61;
import '_features/timetable/models/scheduled_lesson.dart' as _i62;
import '_features/timetable/models/timetable_slot.dart' as _i63;
import '_features/timetable/models/weekday_enum.dart' as _i64;
import '_features/user/models/device_info.dart' as _i65;
import '_features/user/models/roles.dart' as _i66;
import '_features/user/models/staff_user.dart' as _i67;
import '_features/user/models/user_device.dart' as _i68;
import '_features/user/models/user_flags.dart' as _i69;
import '_features/workbooks/models/pupil_workbook.dart' as _i70;
import '_features/workbooks/models/workbook.dart' as _i71;
import '_shared/models/exceptions/test_exception.dart' as _i72;
import '_shared/models/hub_document.dart' as _i73;
import '_features/school_lists/models/school_list.dart' as _i74;
import 'package:school_data_hub_server/src/generated/_features/user/models/staff_user.dart'
    as _i75;
import 'package:school_data_hub_server/src/generated/_features/pupil/models/pupil_data/pupil_data.dart'
    as _i76;
import 'package:school_data_hub_server/src/generated/_features/attendance/models/missed_schoolday.dart'
    as _i77;
import 'package:school_data_hub_server/src/generated/_features/authorizations/models/authorization.dart'
    as _i78;
import 'package:school_data_hub_server/src/generated/_shared/models/member_operation.dart'
    as _i79;
import 'package:school_data_hub_server/src/generated/_features/books/models/book_tagging/book_tag.dart'
    as _i80;
import 'package:school_data_hub_server/src/generated/_features/books/models/book.dart'
    as _i81;
import 'package:school_data_hub_server/src/generated/_features/books/models/library_book_location.dart'
    as _i82;
import 'package:school_data_hub_server/src/generated/_features/books/models/library_book.dart'
    as _i83;
import 'package:school_data_hub_server/src/generated/_features/books/models/pupil_book_lending.dart'
    as _i84;
import 'package:school_data_hub_server/src/generated/_features/learning/models/competence.dart'
    as _i85;
import 'package:school_data_hub_server/src/generated/_features/learning_support/models/learning_support_plan.dart'
    as _i86;
import 'package:school_data_hub_server/src/generated/_features/learning_support/models/support_category_status.dart'
    as _i87;
import 'package:school_data_hub_server/src/generated/_features/learning_support/models/support_category.dart'
    as _i88;
import 'package:school_data_hub_server/src/generated/_features/matrix/compulsory_room.dart'
    as _i89;
import 'package:school_data_hub_server/src/generated/_features/school_lists/models/school_list.dart'
    as _i90;
import 'package:school_data_hub_server/src/generated/_features/schoolday/models/school_semester.dart'
    as _i91;
import 'package:school_data_hub_server/src/generated/_features/schoolday/models/schoolday.dart'
    as _i92;
import 'package:school_data_hub_server/src/generated/_features/schoolday_events/models/schoolday_event.dart'
    as _i93;
import 'package:school_data_hub_server/src/generated/_features/user/models/user_device.dart'
    as _i94;
import 'package:school_data_hub_server/src/generated/_features/workbooks/models/pupil_workbook.dart'
    as _i95;
import 'package:school_data_hub_server/src/generated/_features/workbooks/models/workbook.dart'
    as _i96;
export '_features/attendance/models/contacted_type.dart';
export '_features/attendance/models/missed_schoolday.dart';
export '_features/attendance/models/missed_schoolday_dto.dart';
export '_features/attendance/models/missed_type.dart';
export '_features/authorizations/models/authorization.dart';
export '_features/authorizations/models/pupil_authorization.dart';
export '_features/books/models/book.dart';
export '_features/books/models/book_tagging/book_tag.dart';
export '_features/books/models/book_tagging/book_tagging.dart';
export '_features/books/models/library_book.dart';
export '_features/books/models/library_book_location.dart';
export '_features/books/models/library_book_query.dart';
export '_features/books/models/pupil_book_lending.dart';
export '_features/learning/models/competence.dart';
export '_features/learning/models/competence_check.dart';
export '_features/learning/models/competence_goal.dart';
export '_features/learning/models/competence_report.dart';
export '_features/learning/models/competence_report_check.dart';
export '_features/learning/models/competence_report_item.dart';
export '_features/learning_support/models/learning_support_plan.dart';
export '_features/learning_support/models/support_category.dart';
export '_features/learning_support/models/support_category_status.dart';
export '_features/learning_support/models/support_goal/support_goal.dart';
export '_features/learning_support/models/support_goal/support_goal_check.dart';
export '_features/learning_support/models/support_level.dart';
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
export '_features/pupil/models/pupil_identity/pupil_identity.dart';
export '_features/pupil/models/pupil_identity/pupil_identity_dto.dart';
export '_features/pupil/models/pupil_identity/school_grade.dart';
export '_features/school_lists/models/pupil_entry.dart';
export '_features/school_lists/models/school_list.dart';
export '_features/schoolday/models/school_semester.dart';
export '_features/schoolday/models/schoolday.dart';
export '_features/schoolday_events/models/schoolday_event.dart';
export '_features/schoolday_events/models/schoolday_event_type.dart';
export '_features/timetable/models/classroom.dart';
export '_features/timetable/models/lesson/lesson.dart';
export '_features/timetable/models/lesson/lesson_attendance.dart';
export '_features/timetable/models/lesson/lesson_group.dart';
export '_features/timetable/models/lesson/lesson_group_membership.dart';
export '_features/timetable/models/lesson/lesson_subject.dart';
export '_features/timetable/models/lesson/subject.dart';
export '_features/timetable/models/scheduled_lesson.dart';
export '_features/timetable/models/timetable_slot.dart';
export '_features/timetable/models/weekday_enum.dart';
export '_features/user/models/device_info.dart';
export '_features/user/models/roles.dart';
export '_features/user/models/staff_user.dart';
export '_features/user/models/user_device.dart';
export '_features/user/models/user_flags.dart';
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
          isNullable: false,
          dartType: 'String',
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
          isNullable: false,
          dartType: 'DateTime',
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
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'competence_report_check_fk_2',
          columns: ['competenceReportId'],
          referenceTable: 'competence_report',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
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
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
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
          referenceTable: 'lesson_subject',
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
      foreignKeys: [],
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
      name: 'lesson_subject',
      dartName: 'LessonSubject',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'lesson_subject_id_seq\'::regclass)',
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
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'lesson_subject_pkey',
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
          name: 'active',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'internalId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
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
          indexName: 'pupil_data_active_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'active',
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
        _i2.ColumnDefinition(
          name: 'scheduledAtId',
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
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'modifiedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
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
          columns: ['roomId'],
          referenceTable: 'room',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'scheduled_lesson_fk_3',
          columns: ['lessonGroupId'],
          referenceTable: 'lesson_group',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'scheduled_lesson_fk_4',
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
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'supportConferenceDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'isFirst',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'reportConferenceDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
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
          isNullable: true,
          dartType: 'protocol:Weekday?',
        ),
        _i2.ColumnDefinition(
          name: 'startTime',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'endTime',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
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
          name: 'timeUnits',
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
    if (t == _i4.SupportLevel) {
      return _i4.SupportLevel.fromJson(data) as T;
    }
    if (t == _i5.MissedSchoolday) {
      return _i5.MissedSchoolday.fromJson(data) as T;
    }
    if (t == _i6.MissedSchooldayDto) {
      return _i6.MissedSchooldayDto.fromJson(data) as T;
    }
    if (t == _i7.MissedType) {
      return _i7.MissedType.fromJson(data) as T;
    }
    if (t == _i8.Authorization) {
      return _i8.Authorization.fromJson(data) as T;
    }
    if (t == _i9.PupilAuthorization) {
      return _i9.PupilAuthorization.fromJson(data) as T;
    }
    if (t == _i10.Book) {
      return _i10.Book.fromJson(data) as T;
    }
    if (t == _i11.BookTag) {
      return _i11.BookTag.fromJson(data) as T;
    }
    if (t == _i12.BookTagging) {
      return _i12.BookTagging.fromJson(data) as T;
    }
    if (t == _i13.LibraryBook) {
      return _i13.LibraryBook.fromJson(data) as T;
    }
    if (t == _i14.LibraryBookLocation) {
      return _i14.LibraryBookLocation.fromJson(data) as T;
    }
    if (t == _i15.LibraryBookQuery) {
      return _i15.LibraryBookQuery.fromJson(data) as T;
    }
    if (t == _i16.PupilBookLending) {
      return _i16.PupilBookLending.fromJson(data) as T;
    }
    if (t == _i17.Competence) {
      return _i17.Competence.fromJson(data) as T;
    }
    if (t == _i18.CompetenceCheck) {
      return _i18.CompetenceCheck.fromJson(data) as T;
    }
    if (t == _i19.CompetenceGoal) {
      return _i19.CompetenceGoal.fromJson(data) as T;
    }
    if (t == _i20.CompetenceReport) {
      return _i20.CompetenceReport.fromJson(data) as T;
    }
    if (t == _i21.CompetenceReportCheck) {
      return _i21.CompetenceReportCheck.fromJson(data) as T;
    }
    if (t == _i22.CompetenceReportItem) {
      return _i22.CompetenceReportItem.fromJson(data) as T;
    }
    if (t == _i23.LearningSupportPlan) {
      return _i23.LearningSupportPlan.fromJson(data) as T;
    }
    if (t == _i24.SupportCategory) {
      return _i24.SupportCategory.fromJson(data) as T;
    }
    if (t == _i25.SupportCategoryStatus) {
      return _i25.SupportCategoryStatus.fromJson(data) as T;
    }
    if (t == _i26.SupportGoal) {
      return _i26.SupportGoal.fromJson(data) as T;
    }
    if (t == _i27.SupportGoalCheck) {
      return _i27.SupportGoalCheck.fromJson(data) as T;
    }
    if (t == _i28.ContactedType) {
      return _i28.ContactedType.fromJson(data) as T;
    }
    if (t == _i29.CompulsoryRoom) {
      return _i29.CompulsoryRoom.fromJson(data) as T;
    }
    if (t == _i30.MatrixRoomType) {
      return _i30.MatrixRoomType.fromJson(data) as T;
    }
    if (t == _i31.AfterSchoolCare) {
      return _i31.AfterSchoolCare.fromJson(data) as T;
    }
    if (t == _i32.AfterSchoolCarePickUpTimes) {
      return _i32.AfterSchoolCarePickUpTimes.fromJson(data) as T;
    }
    if (t == _i33.PickUpInfo) {
      return _i33.PickUpInfo.fromJson(data) as T;
    }
    if (t == _i34.CommunicationSkills) {
      return _i34.CommunicationSkills.fromJson(data) as T;
    }
    if (t == _i35.PublicMediaAuth) {
      return _i35.PublicMediaAuth.fromJson(data) as T;
    }
    if (t == _i36.TutorInfo) {
      return _i36.TutorInfo.fromJson(data) as T;
    }
    if (t == _i37.CreditTransaction) {
      return _i37.CreditTransaction.fromJson(data) as T;
    }
    if (t == _i38.PupilDocumentType) {
      return _i38.PupilDocumentType.fromJson(data) as T;
    }
    if (t == _i39.SiblingsTutorInfo) {
      return _i39.SiblingsTutorInfo.fromJson(data) as T;
    }
    if (t == _i40.Kindergarden) {
      return _i40.Kindergarden.fromJson(data) as T;
    }
    if (t == _i41.KindergardenInfo) {
      return _i41.KindergardenInfo.fromJson(data) as T;
    }
    if (t == _i42.PreSchoolMedical) {
      return _i42.PreSchoolMedical.fromJson(data) as T;
    }
    if (t == _i43.PreSchoolMedicalStatus) {
      return _i43.PreSchoolMedicalStatus.fromJson(data) as T;
    }
    if (t == _i44.PreSchoolTest) {
      return _i44.PreSchoolTest.fromJson(data) as T;
    }
    if (t == _i45.PupilData) {
      return _i45.PupilData.fromJson(data) as T;
    }
    if (t == _i46.PupilIdentity) {
      return _i46.PupilIdentity.fromJson(data) as T;
    }
    if (t == _i47.PupilIdentityDto) {
      return _i47.PupilIdentityDto.fromJson(data) as T;
    }
    if (t == _i48.SchoolGrade) {
      return _i48.SchoolGrade.fromJson(data) as T;
    }
    if (t == _i49.PupilListEntry) {
      return _i49.PupilListEntry.fromJson(data) as T;
    }
    if (t == _i50.MemberOperation) {
      return _i50.MemberOperation.fromJson(data) as T;
    }
    if (t == _i51.SchoolSemester) {
      return _i51.SchoolSemester.fromJson(data) as T;
    }
    if (t == _i52.Schoolday) {
      return _i52.Schoolday.fromJson(data) as T;
    }
    if (t == _i53.SchooldayEvent) {
      return _i53.SchooldayEvent.fromJson(data) as T;
    }
    if (t == _i54.SchooldayEventType) {
      return _i54.SchooldayEventType.fromJson(data) as T;
    }
    if (t == _i55.Classroom) {
      return _i55.Classroom.fromJson(data) as T;
    }
    if (t == _i56.Lesson) {
      return _i56.Lesson.fromJson(data) as T;
    }
    if (t == _i57.LessonAttendance) {
      return _i57.LessonAttendance.fromJson(data) as T;
    }
    if (t == _i58.LessonGroup) {
      return _i58.LessonGroup.fromJson(data) as T;
    }
    if (t == _i59.ScheduledLessonGroupMembership) {
      return _i59.ScheduledLessonGroupMembership.fromJson(data) as T;
    }
    if (t == _i60.LessonSubject) {
      return _i60.LessonSubject.fromJson(data) as T;
    }
    if (t == _i61.Subject) {
      return _i61.Subject.fromJson(data) as T;
    }
    if (t == _i62.ScheduledLesson) {
      return _i62.ScheduledLesson.fromJson(data) as T;
    }
    if (t == _i63.TimetableSlot) {
      return _i63.TimetableSlot.fromJson(data) as T;
    }
    if (t == _i64.Weekday) {
      return _i64.Weekday.fromJson(data) as T;
    }
    if (t == _i65.DeviceInfo) {
      return _i65.DeviceInfo.fromJson(data) as T;
    }
    if (t == _i66.Role) {
      return _i66.Role.fromJson(data) as T;
    }
    if (t == _i67.User) {
      return _i67.User.fromJson(data) as T;
    }
    if (t == _i68.UserDevice) {
      return _i68.UserDevice.fromJson(data) as T;
    }
    if (t == _i69.UserFlags) {
      return _i69.UserFlags.fromJson(data) as T;
    }
    if (t == _i70.PupilWorkbook) {
      return _i70.PupilWorkbook.fromJson(data) as T;
    }
    if (t == _i71.Workbook) {
      return _i71.Workbook.fromJson(data) as T;
    }
    if (t == _i72.MyException) {
      return _i72.MyException.fromJson(data) as T;
    }
    if (t == _i73.HubDocument) {
      return _i73.HubDocument.fromJson(data) as T;
    }
    if (t == _i74.SchoolList) {
      return _i74.SchoolList.fromJson(data) as T;
    }
    if (t == _i1.getType<_i4.SupportLevel?>()) {
      return (data != null ? _i4.SupportLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.MissedSchoolday?>()) {
      return (data != null ? _i5.MissedSchoolday.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.MissedSchooldayDto?>()) {
      return (data != null ? _i6.MissedSchooldayDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.MissedType?>()) {
      return (data != null ? _i7.MissedType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Authorization?>()) {
      return (data != null ? _i8.Authorization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.PupilAuthorization?>()) {
      return (data != null ? _i9.PupilAuthorization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Book?>()) {
      return (data != null ? _i10.Book.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.BookTag?>()) {
      return (data != null ? _i11.BookTag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.BookTagging?>()) {
      return (data != null ? _i12.BookTagging.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.LibraryBook?>()) {
      return (data != null ? _i13.LibraryBook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.LibraryBookLocation?>()) {
      return (data != null ? _i14.LibraryBookLocation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.LibraryBookQuery?>()) {
      return (data != null ? _i15.LibraryBookQuery.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.PupilBookLending?>()) {
      return (data != null ? _i16.PupilBookLending.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.Competence?>()) {
      return (data != null ? _i17.Competence.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.CompetenceCheck?>()) {
      return (data != null ? _i18.CompetenceCheck.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.CompetenceGoal?>()) {
      return (data != null ? _i19.CompetenceGoal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.CompetenceReport?>()) {
      return (data != null ? _i20.CompetenceReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.CompetenceReportCheck?>()) {
      return (data != null ? _i21.CompetenceReportCheck.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.CompetenceReportItem?>()) {
      return (data != null ? _i22.CompetenceReportItem.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.LearningSupportPlan?>()) {
      return (data != null ? _i23.LearningSupportPlan.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i24.SupportCategory?>()) {
      return (data != null ? _i24.SupportCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.SupportCategoryStatus?>()) {
      return (data != null ? _i25.SupportCategoryStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.SupportGoal?>()) {
      return (data != null ? _i26.SupportGoal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.SupportGoalCheck?>()) {
      return (data != null ? _i27.SupportGoalCheck.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.ContactedType?>()) {
      return (data != null ? _i28.ContactedType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.CompulsoryRoom?>()) {
      return (data != null ? _i29.CompulsoryRoom.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.MatrixRoomType?>()) {
      return (data != null ? _i30.MatrixRoomType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.AfterSchoolCare?>()) {
      return (data != null ? _i31.AfterSchoolCare.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.AfterSchoolCarePickUpTimes?>()) {
      return (data != null
          ? _i32.AfterSchoolCarePickUpTimes.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i33.PickUpInfo?>()) {
      return (data != null ? _i33.PickUpInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.CommunicationSkills?>()) {
      return (data != null ? _i34.CommunicationSkills.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i35.PublicMediaAuth?>()) {
      return (data != null ? _i35.PublicMediaAuth.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.TutorInfo?>()) {
      return (data != null ? _i36.TutorInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.CreditTransaction?>()) {
      return (data != null ? _i37.CreditTransaction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.PupilDocumentType?>()) {
      return (data != null ? _i38.PupilDocumentType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.SiblingsTutorInfo?>()) {
      return (data != null ? _i39.SiblingsTutorInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.Kindergarden?>()) {
      return (data != null ? _i40.Kindergarden.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.KindergardenInfo?>()) {
      return (data != null ? _i41.KindergardenInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.PreSchoolMedical?>()) {
      return (data != null ? _i42.PreSchoolMedical.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.PreSchoolMedicalStatus?>()) {
      return (data != null ? _i43.PreSchoolMedicalStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i44.PreSchoolTest?>()) {
      return (data != null ? _i44.PreSchoolTest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.PupilData?>()) {
      return (data != null ? _i45.PupilData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.PupilIdentity?>()) {
      return (data != null ? _i46.PupilIdentity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.PupilIdentityDto?>()) {
      return (data != null ? _i47.PupilIdentityDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.SchoolGrade?>()) {
      return (data != null ? _i48.SchoolGrade.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.PupilListEntry?>()) {
      return (data != null ? _i49.PupilListEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.MemberOperation?>()) {
      return (data != null ? _i50.MemberOperation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.SchoolSemester?>()) {
      return (data != null ? _i51.SchoolSemester.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.Schoolday?>()) {
      return (data != null ? _i52.Schoolday.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.SchooldayEvent?>()) {
      return (data != null ? _i53.SchooldayEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.SchooldayEventType?>()) {
      return (data != null ? _i54.SchooldayEventType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i55.Classroom?>()) {
      return (data != null ? _i55.Classroom.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.Lesson?>()) {
      return (data != null ? _i56.Lesson.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.LessonAttendance?>()) {
      return (data != null ? _i57.LessonAttendance.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.LessonGroup?>()) {
      return (data != null ? _i58.LessonGroup.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.ScheduledLessonGroupMembership?>()) {
      return (data != null
          ? _i59.ScheduledLessonGroupMembership.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i60.LessonSubject?>()) {
      return (data != null ? _i60.LessonSubject.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.Subject?>()) {
      return (data != null ? _i61.Subject.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.ScheduledLesson?>()) {
      return (data != null ? _i62.ScheduledLesson.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.TimetableSlot?>()) {
      return (data != null ? _i63.TimetableSlot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.Weekday?>()) {
      return (data != null ? _i64.Weekday.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.DeviceInfo?>()) {
      return (data != null ? _i65.DeviceInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i66.Role?>()) {
      return (data != null ? _i66.Role.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.User?>()) {
      return (data != null ? _i67.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.UserDevice?>()) {
      return (data != null ? _i68.UserDevice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i69.UserFlags?>()) {
      return (data != null ? _i69.UserFlags.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i70.PupilWorkbook?>()) {
      return (data != null ? _i70.PupilWorkbook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i71.Workbook?>()) {
      return (data != null ? _i71.Workbook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i72.MyException?>()) {
      return (data != null ? _i72.MyException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i73.HubDocument?>()) {
      return (data != null ? _i73.HubDocument.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i74.SchoolList?>()) {
      return (data != null ? _i74.SchoolList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<List<_i23.LearningSupportPlan>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i23.LearningSupportPlan>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i9.PupilAuthorization>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i9.PupilAuthorization>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i12.BookTagging>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i12.BookTagging>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i13.LibraryBook>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i13.LibraryBook>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i12.BookTagging>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i12.BookTagging>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i16.PupilBookLending>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i16.PupilBookLending>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i13.LibraryBook>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i13.LibraryBook>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i12.BookTagging>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i12.BookTagging>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i73.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i73.HubDocument>(e)).toList()
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
    if (t == _i1.getType<List<_i19.CompetenceGoal>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.CompetenceGoal>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i18.CompetenceCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i18.CompetenceCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i73.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i73.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i73.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i73.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i21.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i21.CompetenceReportCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i21.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i21.CompetenceReportCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i25.SupportCategoryStatus>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i25.SupportCategoryStatus>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i26.SupportGoal>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i26.SupportGoal>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i26.SupportGoal>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i26.SupportGoal>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i25.SupportCategoryStatus>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i25.SupportCategoryStatus>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i73.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i73.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i27.SupportGoalCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i27.SupportGoalCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i73.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i73.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == Set<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toSet() as T;
    }
    if (t == _i1.getType<List<_i45.PupilData>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i45.PupilData>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i73.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i73.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i73.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i73.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i9.PupilAuthorization>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i9.PupilAuthorization>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i37.CreditTransaction>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i37.CreditTransaction>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i59.ScheduledLessonGroupMembership>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i59.ScheduledLessonGroupMembership>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i57.LessonAttendance>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i57.LessonAttendance>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i19.CompetenceGoal>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.CompetenceGoal>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i18.CompetenceCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i18.CompetenceCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i20.CompetenceReport>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i20.CompetenceReport>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i21.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i21.CompetenceReportCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i70.PupilWorkbook>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i70.PupilWorkbook>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i16.PupilBookLending>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i16.PupilBookLending>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i4.SupportLevel>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i4.SupportLevel>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i25.SupportCategoryStatus>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i25.SupportCategoryStatus>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i26.SupportGoal>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i26.SupportGoal>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i23.LearningSupportPlan>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i23.LearningSupportPlan>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i5.MissedSchoolday>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i5.MissedSchoolday>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i53.SchooldayEvent>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i53.SchooldayEvent>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i49.PupilListEntry>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i49.PupilListEntry>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i52.Schoolday>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i52.Schoolday>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i20.CompetenceReport>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i20.CompetenceReport>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i23.LearningSupportPlan>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i23.LearningSupportPlan>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i5.MissedSchoolday>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i5.MissedSchoolday>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i53.SchooldayEvent>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i53.SchooldayEvent>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i62.ScheduledLesson>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i62.ScheduledLesson>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i57.LessonAttendance>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i57.LessonAttendance>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i62.ScheduledLesson>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i62.ScheduledLesson>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i59.ScheduledLessonGroupMembership>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i59.ScheduledLessonGroupMembership>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i56.Lesson>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i56.Lesson>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i62.ScheduledLesson>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i62.ScheduledLesson>(e))
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
    if (t == _i1.getType<Set<int>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<int>(e)).toSet()
          : null) as T;
    }
    if (t == _i1.getType<List<_i70.PupilWorkbook>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i70.PupilWorkbook>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i49.PupilListEntry>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i49.PupilListEntry>(e))
              .toList()
          : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i75.User>) {
      return (data as List).map((e) => deserialize<_i75.User>(e)).toList() as T;
    }
    if (t == Set<_i76.PupilData>) {
      return (data as List).map((e) => deserialize<_i76.PupilData>(e)).toSet()
          as T;
    }
    if (t == List<_i77.MissedSchoolday>) {
      return (data as List)
          .map((e) => deserialize<_i77.MissedSchoolday>(e))
          .toList() as T;
    }
    if (t == List<_i78.Authorization>) {
      return (data as List)
          .map((e) => deserialize<_i78.Authorization>(e))
          .toList() as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t ==
        _i1.getType<
            ({_i79.MemberOperation operation, List<int> pupilIds})?>()) {
      return (data == null)
          ? null as T
          : (
              operation: deserialize<_i79.MemberOperation>(
                  ((data as Map)['n'] as Map)['operation']),
              pupilIds: deserialize<List<int>>(data['n']['pupilIds']),
            ) as T;
    }
    if (t == List<_i80.BookTag>) {
      return (data as List).map((e) => deserialize<_i80.BookTag>(e)).toList()
          as T;
    }
    if (t == List<_i81.Book>) {
      return (data as List).map((e) => deserialize<_i81.Book>(e)).toList() as T;
    }
    if (t == List<_i82.LibraryBookLocation>) {
      return (data as List)
          .map((e) => deserialize<_i82.LibraryBookLocation>(e))
          .toList() as T;
    }
    if (t == List<_i83.LibraryBook>) {
      return (data as List)
          .map((e) => deserialize<_i83.LibraryBook>(e))
          .toList() as T;
    }
    if (t == List<_i84.PupilBookLending>) {
      return (data as List)
          .map((e) => deserialize<_i84.PupilBookLending>(e))
          .toList() as T;
    }
    if (t == List<_i85.Competence>) {
      return (data as List).map((e) => deserialize<_i85.Competence>(e)).toList()
          as T;
    }
    if (t == List<_i86.LearningSupportPlan>) {
      return (data as List)
          .map((e) => deserialize<_i86.LearningSupportPlan>(e))
          .toList() as T;
    }
    if (t == List<_i87.SupportCategoryStatus>) {
      return (data as List)
          .map((e) => deserialize<_i87.SupportCategoryStatus>(e))
          .toList() as T;
    }
    if (t == List<_i88.SupportCategory>) {
      return (data as List)
          .map((e) => deserialize<_i88.SupportCategory>(e))
          .toList() as T;
    }
    if (t == _i1.getType<List<_i89.CompulsoryRoom>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i89.CompulsoryRoom>(e))
              .toList()
          : null) as T;
    }
    if (t == List<_i89.CompulsoryRoom>) {
      return (data as List)
          .map((e) => deserialize<_i89.CompulsoryRoom>(e))
          .toList() as T;
    }
    if (t == List<_i76.PupilData>) {
      return (data as List).map((e) => deserialize<_i76.PupilData>(e)).toList()
          as T;
    }
    if (t == Set<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toSet() as T;
    }
    if (t == _i1.getType<({DateTime? value})>()) {
      return (
        value: ((data as Map)['n'] as Map)['value'] == null
            ? null
            : deserialize<DateTime>(data['n']['value']),
      ) as T;
    }
    if (t == List<_i90.SchoolList>) {
      return (data as List).map((e) => deserialize<_i90.SchoolList>(e)).toList()
          as T;
    }
    if (t == List<_i91.SchoolSemester>) {
      return (data as List)
          .map((e) => deserialize<_i91.SchoolSemester>(e))
          .toList() as T;
    }
    if (t == List<_i92.Schoolday>) {
      return (data as List).map((e) => deserialize<_i92.Schoolday>(e)).toList()
          as T;
    }
    if (t == List<DateTime>) {
      return (data as List).map((e) => deserialize<DateTime>(e)).toList() as T;
    }
    if (t == List<_i93.SchooldayEvent>) {
      return (data as List)
          .map((e) => deserialize<_i93.SchooldayEvent>(e))
          .toList() as T;
    }
    if (t ==
        _i1.getType<
            ({
              _i3.AuthenticationResponse response,
              _i94.UserDevice? userDevice
            })>()) {
      return (
        response: deserialize<_i3.AuthenticationResponse>(
            ((data as Map)['n'] as Map)['response']),
        userDevice: ((data)['n'] as Map)['userDevice'] == null
            ? null
            : deserialize<_i94.UserDevice>(data['n']['userDevice']),
      ) as T;
    }
    if (t == List<_i95.PupilWorkbook>) {
      return (data as List)
          .map((e) => deserialize<_i95.PupilWorkbook>(e))
          .toList() as T;
    }
    if (t == List<_i96.Workbook>) {
      return (data as List).map((e) => deserialize<_i96.Workbook>(e)).toList()
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
    if (data is _i4.SupportLevel) {
      return 'SupportLevel';
    }
    if (data is _i5.MissedSchoolday) {
      return 'MissedSchoolday';
    }
    if (data is _i6.MissedSchooldayDto) {
      return 'MissedSchooldayDto';
    }
    if (data is _i7.MissedType) {
      return 'MissedType';
    }
    if (data is _i8.Authorization) {
      return 'Authorization';
    }
    if (data is _i9.PupilAuthorization) {
      return 'PupilAuthorization';
    }
    if (data is _i10.Book) {
      return 'Book';
    }
    if (data is _i11.BookTag) {
      return 'BookTag';
    }
    if (data is _i12.BookTagging) {
      return 'BookTagging';
    }
    if (data is _i13.LibraryBook) {
      return 'LibraryBook';
    }
    if (data is _i14.LibraryBookLocation) {
      return 'LibraryBookLocation';
    }
    if (data is _i15.LibraryBookQuery) {
      return 'LibraryBookQuery';
    }
    if (data is _i16.PupilBookLending) {
      return 'PupilBookLending';
    }
    if (data is _i17.Competence) {
      return 'Competence';
    }
    if (data is _i18.CompetenceCheck) {
      return 'CompetenceCheck';
    }
    if (data is _i19.CompetenceGoal) {
      return 'CompetenceGoal';
    }
    if (data is _i20.CompetenceReport) {
      return 'CompetenceReport';
    }
    if (data is _i21.CompetenceReportCheck) {
      return 'CompetenceReportCheck';
    }
    if (data is _i22.CompetenceReportItem) {
      return 'CompetenceReportItem';
    }
    if (data is _i23.LearningSupportPlan) {
      return 'LearningSupportPlan';
    }
    if (data is _i24.SupportCategory) {
      return 'SupportCategory';
    }
    if (data is _i25.SupportCategoryStatus) {
      return 'SupportCategoryStatus';
    }
    if (data is _i26.SupportGoal) {
      return 'SupportGoal';
    }
    if (data is _i27.SupportGoalCheck) {
      return 'SupportGoalCheck';
    }
    if (data is _i28.ContactedType) {
      return 'ContactedType';
    }
    if (data is _i29.CompulsoryRoom) {
      return 'CompulsoryRoom';
    }
    if (data is _i30.MatrixRoomType) {
      return 'MatrixRoomType';
    }
    if (data is _i31.AfterSchoolCare) {
      return 'AfterSchoolCare';
    }
    if (data is _i32.AfterSchoolCarePickUpTimes) {
      return 'AfterSchoolCarePickUpTimes';
    }
    if (data is _i33.PickUpInfo) {
      return 'PickUpInfo';
    }
    if (data is _i34.CommunicationSkills) {
      return 'CommunicationSkills';
    }
    if (data is _i35.PublicMediaAuth) {
      return 'PublicMediaAuth';
    }
    if (data is _i36.TutorInfo) {
      return 'TutorInfo';
    }
    if (data is _i37.CreditTransaction) {
      return 'CreditTransaction';
    }
    if (data is _i38.PupilDocumentType) {
      return 'PupilDocumentType';
    }
    if (data is _i39.SiblingsTutorInfo) {
      return 'SiblingsTutorInfo';
    }
    if (data is _i40.Kindergarden) {
      return 'Kindergarden';
    }
    if (data is _i41.KindergardenInfo) {
      return 'KindergardenInfo';
    }
    if (data is _i42.PreSchoolMedical) {
      return 'PreSchoolMedical';
    }
    if (data is _i43.PreSchoolMedicalStatus) {
      return 'PreSchoolMedicalStatus';
    }
    if (data is _i44.PreSchoolTest) {
      return 'PreSchoolTest';
    }
    if (data is _i45.PupilData) {
      return 'PupilData';
    }
    if (data is _i46.PupilIdentity) {
      return 'PupilIdentity';
    }
    if (data is _i47.PupilIdentityDto) {
      return 'PupilIdentityDto';
    }
    if (data is _i48.SchoolGrade) {
      return 'SchoolGrade';
    }
    if (data is _i49.PupilListEntry) {
      return 'PupilListEntry';
    }
    if (data is _i50.MemberOperation) {
      return 'MemberOperation';
    }
    if (data is _i51.SchoolSemester) {
      return 'SchoolSemester';
    }
    if (data is _i52.Schoolday) {
      return 'Schoolday';
    }
    if (data is _i53.SchooldayEvent) {
      return 'SchooldayEvent';
    }
    if (data is _i54.SchooldayEventType) {
      return 'SchooldayEventType';
    }
    if (data is _i55.Classroom) {
      return 'Classroom';
    }
    if (data is _i56.Lesson) {
      return 'Lesson';
    }
    if (data is _i57.LessonAttendance) {
      return 'LessonAttendance';
    }
    if (data is _i58.LessonGroup) {
      return 'LessonGroup';
    }
    if (data is _i59.ScheduledLessonGroupMembership) {
      return 'ScheduledLessonGroupMembership';
    }
    if (data is _i60.LessonSubject) {
      return 'LessonSubject';
    }
    if (data is _i61.Subject) {
      return 'Subject';
    }
    if (data is _i62.ScheduledLesson) {
      return 'ScheduledLesson';
    }
    if (data is _i63.TimetableSlot) {
      return 'TimetableSlot';
    }
    if (data is _i64.Weekday) {
      return 'Weekday';
    }
    if (data is _i65.DeviceInfo) {
      return 'DeviceInfo';
    }
    if (data is _i66.Role) {
      return 'Role';
    }
    if (data is _i67.User) {
      return 'User';
    }
    if (data is _i68.UserDevice) {
      return 'UserDevice';
    }
    if (data is _i69.UserFlags) {
      return 'UserFlags';
    }
    if (data is _i70.PupilWorkbook) {
      return 'PupilWorkbook';
    }
    if (data is _i71.Workbook) {
      return 'Workbook';
    }
    if (data is _i72.MyException) {
      return 'MyException';
    }
    if (data is _i73.HubDocument) {
      return 'HubDocument';
    }
    if (data is _i74.SchoolList) {
      return 'SchoolList';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    if (data is List<_i76.PupilData>) {
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
    if (dataClassName == 'SupportLevel') {
      return deserialize<_i4.SupportLevel>(data['data']);
    }
    if (dataClassName == 'MissedSchoolday') {
      return deserialize<_i5.MissedSchoolday>(data['data']);
    }
    if (dataClassName == 'MissedSchooldayDto') {
      return deserialize<_i6.MissedSchooldayDto>(data['data']);
    }
    if (dataClassName == 'MissedType') {
      return deserialize<_i7.MissedType>(data['data']);
    }
    if (dataClassName == 'Authorization') {
      return deserialize<_i8.Authorization>(data['data']);
    }
    if (dataClassName == 'PupilAuthorization') {
      return deserialize<_i9.PupilAuthorization>(data['data']);
    }
    if (dataClassName == 'Book') {
      return deserialize<_i10.Book>(data['data']);
    }
    if (dataClassName == 'BookTag') {
      return deserialize<_i11.BookTag>(data['data']);
    }
    if (dataClassName == 'BookTagging') {
      return deserialize<_i12.BookTagging>(data['data']);
    }
    if (dataClassName == 'LibraryBook') {
      return deserialize<_i13.LibraryBook>(data['data']);
    }
    if (dataClassName == 'LibraryBookLocation') {
      return deserialize<_i14.LibraryBookLocation>(data['data']);
    }
    if (dataClassName == 'LibraryBookQuery') {
      return deserialize<_i15.LibraryBookQuery>(data['data']);
    }
    if (dataClassName == 'PupilBookLending') {
      return deserialize<_i16.PupilBookLending>(data['data']);
    }
    if (dataClassName == 'Competence') {
      return deserialize<_i17.Competence>(data['data']);
    }
    if (dataClassName == 'CompetenceCheck') {
      return deserialize<_i18.CompetenceCheck>(data['data']);
    }
    if (dataClassName == 'CompetenceGoal') {
      return deserialize<_i19.CompetenceGoal>(data['data']);
    }
    if (dataClassName == 'CompetenceReport') {
      return deserialize<_i20.CompetenceReport>(data['data']);
    }
    if (dataClassName == 'CompetenceReportCheck') {
      return deserialize<_i21.CompetenceReportCheck>(data['data']);
    }
    if (dataClassName == 'CompetenceReportItem') {
      return deserialize<_i22.CompetenceReportItem>(data['data']);
    }
    if (dataClassName == 'LearningSupportPlan') {
      return deserialize<_i23.LearningSupportPlan>(data['data']);
    }
    if (dataClassName == 'SupportCategory') {
      return deserialize<_i24.SupportCategory>(data['data']);
    }
    if (dataClassName == 'SupportCategoryStatus') {
      return deserialize<_i25.SupportCategoryStatus>(data['data']);
    }
    if (dataClassName == 'SupportGoal') {
      return deserialize<_i26.SupportGoal>(data['data']);
    }
    if (dataClassName == 'SupportGoalCheck') {
      return deserialize<_i27.SupportGoalCheck>(data['data']);
    }
    if (dataClassName == 'ContactedType') {
      return deserialize<_i28.ContactedType>(data['data']);
    }
    if (dataClassName == 'CompulsoryRoom') {
      return deserialize<_i29.CompulsoryRoom>(data['data']);
    }
    if (dataClassName == 'MatrixRoomType') {
      return deserialize<_i30.MatrixRoomType>(data['data']);
    }
    if (dataClassName == 'AfterSchoolCare') {
      return deserialize<_i31.AfterSchoolCare>(data['data']);
    }
    if (dataClassName == 'AfterSchoolCarePickUpTimes') {
      return deserialize<_i32.AfterSchoolCarePickUpTimes>(data['data']);
    }
    if (dataClassName == 'PickUpInfo') {
      return deserialize<_i33.PickUpInfo>(data['data']);
    }
    if (dataClassName == 'CommunicationSkills') {
      return deserialize<_i34.CommunicationSkills>(data['data']);
    }
    if (dataClassName == 'PublicMediaAuth') {
      return deserialize<_i35.PublicMediaAuth>(data['data']);
    }
    if (dataClassName == 'TutorInfo') {
      return deserialize<_i36.TutorInfo>(data['data']);
    }
    if (dataClassName == 'CreditTransaction') {
      return deserialize<_i37.CreditTransaction>(data['data']);
    }
    if (dataClassName == 'PupilDocumentType') {
      return deserialize<_i38.PupilDocumentType>(data['data']);
    }
    if (dataClassName == 'SiblingsTutorInfo') {
      return deserialize<_i39.SiblingsTutorInfo>(data['data']);
    }
    if (dataClassName == 'Kindergarden') {
      return deserialize<_i40.Kindergarden>(data['data']);
    }
    if (dataClassName == 'KindergardenInfo') {
      return deserialize<_i41.KindergardenInfo>(data['data']);
    }
    if (dataClassName == 'PreSchoolMedical') {
      return deserialize<_i42.PreSchoolMedical>(data['data']);
    }
    if (dataClassName == 'PreSchoolMedicalStatus') {
      return deserialize<_i43.PreSchoolMedicalStatus>(data['data']);
    }
    if (dataClassName == 'PreSchoolTest') {
      return deserialize<_i44.PreSchoolTest>(data['data']);
    }
    if (dataClassName == 'PupilData') {
      return deserialize<_i45.PupilData>(data['data']);
    }
    if (dataClassName == 'PupilIdentity') {
      return deserialize<_i46.PupilIdentity>(data['data']);
    }
    if (dataClassName == 'PupilIdentityDto') {
      return deserialize<_i47.PupilIdentityDto>(data['data']);
    }
    if (dataClassName == 'SchoolGrade') {
      return deserialize<_i48.SchoolGrade>(data['data']);
    }
    if (dataClassName == 'PupilListEntry') {
      return deserialize<_i49.PupilListEntry>(data['data']);
    }
    if (dataClassName == 'MemberOperation') {
      return deserialize<_i50.MemberOperation>(data['data']);
    }
    if (dataClassName == 'SchoolSemester') {
      return deserialize<_i51.SchoolSemester>(data['data']);
    }
    if (dataClassName == 'Schoolday') {
      return deserialize<_i52.Schoolday>(data['data']);
    }
    if (dataClassName == 'SchooldayEvent') {
      return deserialize<_i53.SchooldayEvent>(data['data']);
    }
    if (dataClassName == 'SchooldayEventType') {
      return deserialize<_i54.SchooldayEventType>(data['data']);
    }
    if (dataClassName == 'Classroom') {
      return deserialize<_i55.Classroom>(data['data']);
    }
    if (dataClassName == 'Lesson') {
      return deserialize<_i56.Lesson>(data['data']);
    }
    if (dataClassName == 'LessonAttendance') {
      return deserialize<_i57.LessonAttendance>(data['data']);
    }
    if (dataClassName == 'LessonGroup') {
      return deserialize<_i58.LessonGroup>(data['data']);
    }
    if (dataClassName == 'ScheduledLessonGroupMembership') {
      return deserialize<_i59.ScheduledLessonGroupMembership>(data['data']);
    }
    if (dataClassName == 'LessonSubject') {
      return deserialize<_i60.LessonSubject>(data['data']);
    }
    if (dataClassName == 'Subject') {
      return deserialize<_i61.Subject>(data['data']);
    }
    if (dataClassName == 'ScheduledLesson') {
      return deserialize<_i62.ScheduledLesson>(data['data']);
    }
    if (dataClassName == 'TimetableSlot') {
      return deserialize<_i63.TimetableSlot>(data['data']);
    }
    if (dataClassName == 'Weekday') {
      return deserialize<_i64.Weekday>(data['data']);
    }
    if (dataClassName == 'DeviceInfo') {
      return deserialize<_i65.DeviceInfo>(data['data']);
    }
    if (dataClassName == 'Role') {
      return deserialize<_i66.Role>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i67.User>(data['data']);
    }
    if (dataClassName == 'UserDevice') {
      return deserialize<_i68.UserDevice>(data['data']);
    }
    if (dataClassName == 'UserFlags') {
      return deserialize<_i69.UserFlags>(data['data']);
    }
    if (dataClassName == 'PupilWorkbook') {
      return deserialize<_i70.PupilWorkbook>(data['data']);
    }
    if (dataClassName == 'Workbook') {
      return deserialize<_i71.Workbook>(data['data']);
    }
    if (dataClassName == 'MyException') {
      return deserialize<_i72.MyException>(data['data']);
    }
    if (dataClassName == 'HubDocument') {
      return deserialize<_i73.HubDocument>(data['data']);
    }
    if (dataClassName == 'SchoolList') {
      return deserialize<_i74.SchoolList>(data['data']);
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
      return deserialize<List<_i76.PupilData>>(data['data']);
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
      case _i5.MissedSchoolday:
        return _i5.MissedSchoolday.t;
      case _i8.Authorization:
        return _i8.Authorization.t;
      case _i9.PupilAuthorization:
        return _i9.PupilAuthorization.t;
      case _i10.Book:
        return _i10.Book.t;
      case _i11.BookTag:
        return _i11.BookTag.t;
      case _i12.BookTagging:
        return _i12.BookTagging.t;
      case _i13.LibraryBook:
        return _i13.LibraryBook.t;
      case _i14.LibraryBookLocation:
        return _i14.LibraryBookLocation.t;
      case _i16.PupilBookLending:
        return _i16.PupilBookLending.t;
      case _i17.Competence:
        return _i17.Competence.t;
      case _i18.CompetenceCheck:
        return _i18.CompetenceCheck.t;
      case _i19.CompetenceGoal:
        return _i19.CompetenceGoal.t;
      case _i20.CompetenceReport:
        return _i20.CompetenceReport.t;
      case _i21.CompetenceReportCheck:
        return _i21.CompetenceReportCheck.t;
      case _i22.CompetenceReportItem:
        return _i22.CompetenceReportItem.t;
      case _i23.LearningSupportPlan:
        return _i23.LearningSupportPlan.t;
      case _i24.SupportCategory:
        return _i24.SupportCategory.t;
      case _i25.SupportCategoryStatus:
        return _i25.SupportCategoryStatus.t;
      case _i26.SupportGoal:
        return _i26.SupportGoal.t;
      case _i27.SupportGoalCheck:
        return _i27.SupportGoalCheck.t;
      case _i4.SupportLevel:
        return _i4.SupportLevel.t;
      case _i29.CompulsoryRoom:
        return _i29.CompulsoryRoom.t;
      case _i37.CreditTransaction:
        return _i37.CreditTransaction.t;
      case _i40.Kindergarden:
        return _i40.Kindergarden.t;
      case _i42.PreSchoolMedical:
        return _i42.PreSchoolMedical.t;
      case _i44.PreSchoolTest:
        return _i44.PreSchoolTest.t;
      case _i45.PupilData:
        return _i45.PupilData.t;
      case _i49.PupilListEntry:
        return _i49.PupilListEntry.t;
      case _i74.SchoolList:
        return _i74.SchoolList.t;
      case _i51.SchoolSemester:
        return _i51.SchoolSemester.t;
      case _i52.Schoolday:
        return _i52.Schoolday.t;
      case _i53.SchooldayEvent:
        return _i53.SchooldayEvent.t;
      case _i55.Classroom:
        return _i55.Classroom.t;
      case _i56.Lesson:
        return _i56.Lesson.t;
      case _i57.LessonAttendance:
        return _i57.LessonAttendance.t;
      case _i58.LessonGroup:
        return _i58.LessonGroup.t;
      case _i59.ScheduledLessonGroupMembership:
        return _i59.ScheduledLessonGroupMembership.t;
      case _i60.LessonSubject:
        return _i60.LessonSubject.t;
      case _i61.Subject:
        return _i61.Subject.t;
      case _i62.ScheduledLesson:
        return _i62.ScheduledLesson.t;
      case _i63.TimetableSlot:
        return _i63.TimetableSlot.t;
      case _i67.User:
        return _i67.User.t;
      case _i68.UserDevice:
        return _i68.UserDevice.t;
      case _i70.PupilWorkbook:
        return _i70.PupilWorkbook.t;
      case _i71.Workbook:
        return _i71.Workbook.t;
      case _i73.HubDocument:
        return _i73.HubDocument.t;
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
  if (record is ({_i79.MemberOperation operation, List<int> pupilIds})) {
    return {
      "n": {
        "operation": record.operation,
        "pupilIds": record.pupilIds,
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
  if (record is ({
    _i3.AuthenticationResponse response,
    _i94.UserDevice? userDevice
  })) {
    return {
      "n": {
        "response": record.response,
        "userDevice": record.userDevice,
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

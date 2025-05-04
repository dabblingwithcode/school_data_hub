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
import 'authorization/authorization.dart' as _i4;
import 'authorization/pupil_authorization.dart' as _i5;
import 'book/book.dart' as _i6;
import 'book/book_tagging/book_tag.dart' as _i7;
import 'book/book_tagging/book_tagging.dart' as _i8;
import 'book/library_book.dart' as _i9;
import 'book/location/library_book_location.dart' as _i10;
import 'book/pupil_book_lending.dart' as _i11;
import 'book/pupil_book_lending_file.dart' as _i12;
import 'learning/competence.dart' as _i13;
import 'learning/competence_check.dart' as _i14;
import 'learning/competence_goal.dart' as _i15;
import 'learning/competence_report.dart' as _i16;
import 'learning/competence_report_check.dart' as _i17;
import 'learning/timetable/lesson/lesson.dart' as _i18;
import 'learning/timetable/lesson/lesson_attendance.dart' as _i19;
import 'learning/timetable/lesson/lesson_group.dart' as _i20;
import 'learning/timetable/lesson/lesson_group_membership.dart' as _i21;
import 'learning/timetable/lesson/lesson_subject.dart' as _i22;
import 'learning/timetable/lesson/scheduled_lesson.dart' as _i23;
import 'learning/timetable/lesson/subject.dart' as _i24;
import 'learning/timetable/lesson/timetable_slot.dart' as _i25;
import 'learning/timetable/lesson/weekday_enum.dart' as _i26;
import 'learning/timetable/room.dart' as _i27;
import 'learning_support/support_category.dart' as _i28;
import 'learning_support/support_category_status.dart' as _i29;
import 'learning_support/support_goal/support_goal.dart' as _i30;
import 'learning_support/support_goal/support_goal_check.dart' as _i31;
import 'learning_support/support_goal/support_goal_check_file.dart' as _i32;
import 'learning_support/support_level.dart' as _i33;
import 'pupil_data/dto/pupil_document_type.dart' as _i34;
import 'pupil_data/dto/siblings_tutor_info_dto.dart' as _i35;
import 'pupil_data/pupil_data.dart' as _i36;
import 'pupil_data/pupil_objects/after_school_care/after_school_care.dart'
    as _i37;
import 'pupil_data/pupil_objects/after_school_care/after_school_pickup_times.dart'
    as _i38;
import 'pupil_data/pupil_objects/after_school_care/pick_up_info.dart' as _i39;
import 'pupil_data/pupil_objects/communication/communication_skills.dart'
    as _i40;
import 'pupil_data/pupil_objects/communication/language.dart' as _i41;
import 'pupil_data/pupil_objects/communication/public_media_auth.dart' as _i42;
import 'pupil_data/pupil_objects/communication/tutor_info.dart' as _i43;
import 'pupil_data/pupil_objects/preschool/kindergarden_info.dart' as _i44;
import 'pupil_data/pupil_objects/preschool/pre_school_medical.dart' as _i45;
import 'pupil_data/pupil_objects/preschool/pre_school_medical_status.dart'
    as _i46;
import 'pupil_data/pupil_objects/preschool/pre_school_test.dart' as _i47;
import 'school_list/pupil_entry.dart' as _i48;
import 'school_list/school_list.dart' as _i49;
import 'schoolday/missed_class/contacted_type.dart' as _i50;
import 'schoolday/missed_class/missed_class.dart' as _i51;
import 'schoolday/missed_class/missed_class_dto.dart' as _i52;
import 'schoolday/missed_class/missed_type.dart' as _i53;
import 'schoolday/school_semester.dart' as _i54;
import 'schoolday/schoolday.dart' as _i55;
import 'schoolday/schoolday_event/schoolday_event.dart' as _i56;
import 'schoolday/schoolday_event/schoolday_event_type.dart' as _i57;
import 'shared/document.dart' as _i58;
import 'shared/member_operation.dart' as _i59;
import 'stats/language_stats.dart' as _i60;
import 'user/credit_transaction.dart' as _i61;
import 'user/device_info.dart' as _i62;
import 'user/roles/roles.dart' as _i63;
import 'user/staff_user.dart' as _i64;
import 'user/user_device.dart' as _i65;
import 'user/user_flags.dart' as _i66;
import 'workbook/pupil_workbook.dart' as _i67;
import 'workbook/workbook.dart' as _i68;
import 'package:school_data_hub_server/src/generated/schoolday/missed_class/missed_class.dart'
    as _i69;
import 'package:school_data_hub_server/src/generated/authorization/authorization.dart'
    as _i70;
import 'package:school_data_hub_server/src/generated/shared/member_operation.dart'
    as _i71;
import 'package:school_data_hub_server/src/generated/learning/competence.dart'
    as _i72;
import 'package:school_data_hub_server/src/generated/pupil_data/pupil_data.dart'
    as _i73;
import 'package:school_data_hub_server/src/generated/school_list/school_list.dart'
    as _i74;
import 'package:school_data_hub_server/src/generated/schoolday/school_semester.dart'
    as _i75;
import 'package:school_data_hub_server/src/generated/schoolday/schoolday.dart'
    as _i76;
import 'package:school_data_hub_server/src/generated/schoolday/schoolday_event/schoolday_event.dart'
    as _i77;
import 'package:school_data_hub_server/src/generated/user/staff_user.dart'
    as _i78;
import 'package:school_data_hub_server/src/generated/user/device_info.dart'
    as _i79;
import 'package:school_data_hub_server/src/generated/learning_support/support_category.dart'
    as _i80;
export 'authorization/authorization.dart';
export 'authorization/pupil_authorization.dart';
export 'book/book.dart';
export 'book/book_tagging/book_tag.dart';
export 'book/book_tagging/book_tagging.dart';
export 'book/library_book.dart';
export 'book/location/library_book_location.dart';
export 'book/pupil_book_lending.dart';
export 'book/pupil_book_lending_file.dart';
export 'learning/competence.dart';
export 'learning/competence_check.dart';
export 'learning/competence_goal.dart';
export 'learning/competence_report.dart';
export 'learning/competence_report_check.dart';
export 'learning/timetable/lesson/lesson.dart';
export 'learning/timetable/lesson/lesson_attendance.dart';
export 'learning/timetable/lesson/lesson_group.dart';
export 'learning/timetable/lesson/lesson_group_membership.dart';
export 'learning/timetable/lesson/lesson_subject.dart';
export 'learning/timetable/lesson/scheduled_lesson.dart';
export 'learning/timetable/lesson/subject.dart';
export 'learning/timetable/lesson/timetable_slot.dart';
export 'learning/timetable/lesson/weekday_enum.dart';
export 'learning/timetable/room.dart';
export 'learning_support/support_category.dart';
export 'learning_support/support_category_status.dart';
export 'learning_support/support_goal/support_goal.dart';
export 'learning_support/support_goal/support_goal_check.dart';
export 'learning_support/support_goal/support_goal_check_file.dart';
export 'learning_support/support_level.dart';
export 'pupil_data/dto/pupil_document_type.dart';
export 'pupil_data/dto/siblings_tutor_info_dto.dart';
export 'pupil_data/pupil_data.dart';
export 'pupil_data/pupil_objects/after_school_care/after_school_care.dart';
export 'pupil_data/pupil_objects/after_school_care/after_school_pickup_times.dart';
export 'pupil_data/pupil_objects/after_school_care/pick_up_info.dart';
export 'pupil_data/pupil_objects/communication/communication_skills.dart';
export 'pupil_data/pupil_objects/communication/language.dart';
export 'pupil_data/pupil_objects/communication/public_media_auth.dart';
export 'pupil_data/pupil_objects/communication/tutor_info.dart';
export 'pupil_data/pupil_objects/preschool/kindergarden_info.dart';
export 'pupil_data/pupil_objects/preschool/pre_school_medical.dart';
export 'pupil_data/pupil_objects/preschool/pre_school_medical_status.dart';
export 'pupil_data/pupil_objects/preschool/pre_school_test.dart';
export 'school_list/pupil_entry.dart';
export 'school_list/school_list.dart';
export 'schoolday/missed_class/contacted_type.dart';
export 'schoolday/missed_class/missed_class.dart';
export 'schoolday/missed_class/missed_class_dto.dart';
export 'schoolday/missed_class/missed_type.dart';
export 'schoolday/school_semester.dart';
export 'schoolday/schoolday.dart';
export 'schoolday/schoolday_event/schoolday_event.dart';
export 'schoolday/schoolday_event/schoolday_event_type.dart';
export 'shared/document.dart';
export 'shared/member_operation.dart';
export 'stats/language_stats.dart';
export 'user/credit_transaction.dart';
export 'user/device_info.dart';
export 'user/roles/roles.dart';
export 'user/staff_user.dart';
export 'user/user_device.dart';
export 'user/user_flags.dart';
export 'workbook/pupil_workbook.dart';
export 'workbook/workbook.dart';

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
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'imageId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
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
        )
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
          name: 'publicId',
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
          name: 'valueFactor',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'groupCheckId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'groupCheckName',
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
          referenceTable: 'competence',
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
          columns: ['_competenceCheckDocumentsCompetenceCheckId'],
          referenceTable: 'competence_check',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'hub_document_fk_1',
          columns: ['_competenceGoalDocumentsCompetenceGoalId'],
          referenceTable: 'competence_goal',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'hub_document_fk_2',
          columns: ['_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId'],
          referenceTable: 'pre_school_medical',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'hub_document_fk_3',
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
      name: 'language_stats',
      dartName: 'LanguageStats',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'language_stats_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'languages',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Set<protocol:Language>?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'language_stats_pkey',
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
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'missed_class',
      dartName: 'MissedClass',
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
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'missed_class_fk_1',
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
          isNullable: false,
          dartType: 'String',
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
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'receivedBy',
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
      name: 'pupil_book_lending_file',
      dartName: 'PupilBookLendingFile',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'pupil_book_lending_file_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'fileId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'fileUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'fileExtension',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'uploadedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'uploadedBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'lendingId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'pupil_book_lending_file_fk_0',
          columns: ['lendingId'],
          referenceTable: 'pupil_book_lending',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'pupil_book_lending_file_pkey',
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
          name: 'kindergarden',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
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
          name: 'latestSupportLevel',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:SupportLevel?',
        ),
        _i2.ColumnDefinition(
          name: 'swimmer',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
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
          columns: ['preSchoolTestId'],
          referenceTable: 'pre_school_test',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'pupil_data_fk_2',
          columns: ['avatarId'],
          referenceTable: 'hub_document',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'pupil_data_fk_3',
          columns: ['avatarAuthId'],
          referenceTable: 'hub_document',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'pupil_data_fk_4',
          columns: ['publicMediaAuthDocumentId'],
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
          name: 'comment',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'status',
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
          name: 'finishedAt',
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
      dartName: 'Room',
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
          name: 'achieved',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'achievedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
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
          isNullable: false,
          dartType: 'List<String>',
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
          columns: ['_supportCategoryCategorygoalsSupportCategoryId'],
          referenceTable: 'support_category',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'support_category_goal_fk_3',
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
          name: 'statusId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'status',
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
          name: 'fileUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'fileId',
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
          columns: ['_supportCategoryCategorystatuesSupportCategoryId'],
          referenceTable: 'support_category',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'support_category_status_fk_3',
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
          name: 'achieved',
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
      name: 'support_goal_check_file',
      dartName: 'SupportGoalCheckFile',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'support_goal_check_file_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'fileId',
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
          name: 'fileUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'supportGoalCheckId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: '_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'support_goal_check_file_fk_0',
          columns: ['supportGoalCheckId'],
          referenceTable: 'support_goal_check',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'support_goal_check_file_fk_1',
          columns: ['_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId'],
          referenceTable: 'support_goal_check',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'support_goal_check_file_pkey',
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
          name: 'pupilIdId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'support_level_fk_0',
          columns: ['pupilIdId'],
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
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'amount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'imageId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
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
    if (t == _i4.Authorization) {
      return _i4.Authorization.fromJson(data) as T;
    }
    if (t == _i5.PupilAuthorization) {
      return _i5.PupilAuthorization.fromJson(data) as T;
    }
    if (t == _i6.Book) {
      return _i6.Book.fromJson(data) as T;
    }
    if (t == _i7.BookTag) {
      return _i7.BookTag.fromJson(data) as T;
    }
    if (t == _i8.BookTagging) {
      return _i8.BookTagging.fromJson(data) as T;
    }
    if (t == _i9.LibraryBook) {
      return _i9.LibraryBook.fromJson(data) as T;
    }
    if (t == _i10.LibraryBookLocation) {
      return _i10.LibraryBookLocation.fromJson(data) as T;
    }
    if (t == _i11.PupilBookLending) {
      return _i11.PupilBookLending.fromJson(data) as T;
    }
    if (t == _i12.PupilBookLendingFile) {
      return _i12.PupilBookLendingFile.fromJson(data) as T;
    }
    if (t == _i13.Competence) {
      return _i13.Competence.fromJson(data) as T;
    }
    if (t == _i14.CompetenceCheck) {
      return _i14.CompetenceCheck.fromJson(data) as T;
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
    if (t == _i18.Lesson) {
      return _i18.Lesson.fromJson(data) as T;
    }
    if (t == _i19.LessonAttendance) {
      return _i19.LessonAttendance.fromJson(data) as T;
    }
    if (t == _i20.LessonGroup) {
      return _i20.LessonGroup.fromJson(data) as T;
    }
    if (t == _i21.ScheduledLessonGroupMembership) {
      return _i21.ScheduledLessonGroupMembership.fromJson(data) as T;
    }
    if (t == _i22.LessonSubject) {
      return _i22.LessonSubject.fromJson(data) as T;
    }
    if (t == _i23.ScheduledLesson) {
      return _i23.ScheduledLesson.fromJson(data) as T;
    }
    if (t == _i24.Subject) {
      return _i24.Subject.fromJson(data) as T;
    }
    if (t == _i25.TimetableSlot) {
      return _i25.TimetableSlot.fromJson(data) as T;
    }
    if (t == _i26.Weekday) {
      return _i26.Weekday.fromJson(data) as T;
    }
    if (t == _i27.Room) {
      return _i27.Room.fromJson(data) as T;
    }
    if (t == _i28.SupportCategory) {
      return _i28.SupportCategory.fromJson(data) as T;
    }
    if (t == _i29.SupportCategoryStatus) {
      return _i29.SupportCategoryStatus.fromJson(data) as T;
    }
    if (t == _i30.SupportGoal) {
      return _i30.SupportGoal.fromJson(data) as T;
    }
    if (t == _i31.SupportGoalCheck) {
      return _i31.SupportGoalCheck.fromJson(data) as T;
    }
    if (t == _i32.SupportGoalCheckFile) {
      return _i32.SupportGoalCheckFile.fromJson(data) as T;
    }
    if (t == _i33.SupportLevel) {
      return _i33.SupportLevel.fromJson(data) as T;
    }
    if (t == _i34.PupilDocumentType) {
      return _i34.PupilDocumentType.fromJson(data) as T;
    }
    if (t == _i35.SiblingsTutorInfo) {
      return _i35.SiblingsTutorInfo.fromJson(data) as T;
    }
    if (t == _i36.PupilData) {
      return _i36.PupilData.fromJson(data) as T;
    }
    if (t == _i37.AfterSchoolCare) {
      return _i37.AfterSchoolCare.fromJson(data) as T;
    }
    if (t == _i38.AfterSchoolCarePickUpTimes) {
      return _i38.AfterSchoolCarePickUpTimes.fromJson(data) as T;
    }
    if (t == _i39.PickUpInfo) {
      return _i39.PickUpInfo.fromJson(data) as T;
    }
    if (t == _i40.CommunicationSkills) {
      return _i40.CommunicationSkills.fromJson(data) as T;
    }
    if (t == _i41.Language) {
      return _i41.Language.fromJson(data) as T;
    }
    if (t == _i42.PublicMediaAuth) {
      return _i42.PublicMediaAuth.fromJson(data) as T;
    }
    if (t == _i43.TutorInfo) {
      return _i43.TutorInfo.fromJson(data) as T;
    }
    if (t == _i44.KindergardenInfo) {
      return _i44.KindergardenInfo.fromJson(data) as T;
    }
    if (t == _i45.PreSchoolMedical) {
      return _i45.PreSchoolMedical.fromJson(data) as T;
    }
    if (t == _i46.PreSchoolMedicalStatus) {
      return _i46.PreSchoolMedicalStatus.fromJson(data) as T;
    }
    if (t == _i47.PreSchoolTest) {
      return _i47.PreSchoolTest.fromJson(data) as T;
    }
    if (t == _i48.PupilListEntry) {
      return _i48.PupilListEntry.fromJson(data) as T;
    }
    if (t == _i49.SchoolList) {
      return _i49.SchoolList.fromJson(data) as T;
    }
    if (t == _i50.ContactedType) {
      return _i50.ContactedType.fromJson(data) as T;
    }
    if (t == _i51.MissedClass) {
      return _i51.MissedClass.fromJson(data) as T;
    }
    if (t == _i52.MissedClassDto) {
      return _i52.MissedClassDto.fromJson(data) as T;
    }
    if (t == _i53.MissedType) {
      return _i53.MissedType.fromJson(data) as T;
    }
    if (t == _i54.SchoolSemester) {
      return _i54.SchoolSemester.fromJson(data) as T;
    }
    if (t == _i55.Schoolday) {
      return _i55.Schoolday.fromJson(data) as T;
    }
    if (t == _i56.SchooldayEvent) {
      return _i56.SchooldayEvent.fromJson(data) as T;
    }
    if (t == _i57.SchooldayEventType) {
      return _i57.SchooldayEventType.fromJson(data) as T;
    }
    if (t == _i58.HubDocument) {
      return _i58.HubDocument.fromJson(data) as T;
    }
    if (t == _i59.MemberOperation) {
      return _i59.MemberOperation.fromJson(data) as T;
    }
    if (t == _i60.LanguageStats) {
      return _i60.LanguageStats.fromJson(data) as T;
    }
    if (t == _i61.CreditTransaction) {
      return _i61.CreditTransaction.fromJson(data) as T;
    }
    if (t == _i62.DeviceInfo) {
      return _i62.DeviceInfo.fromJson(data) as T;
    }
    if (t == _i63.Role) {
      return _i63.Role.fromJson(data) as T;
    }
    if (t == _i64.User) {
      return _i64.User.fromJson(data) as T;
    }
    if (t == _i65.UserDevice) {
      return _i65.UserDevice.fromJson(data) as T;
    }
    if (t == _i66.UserFlags) {
      return _i66.UserFlags.fromJson(data) as T;
    }
    if (t == _i67.PupilWorkbook) {
      return _i67.PupilWorkbook.fromJson(data) as T;
    }
    if (t == _i68.Workbook) {
      return _i68.Workbook.fromJson(data) as T;
    }
    if (t == _i1.getType<_i4.Authorization?>()) {
      return (data != null ? _i4.Authorization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.PupilAuthorization?>()) {
      return (data != null ? _i5.PupilAuthorization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Book?>()) {
      return (data != null ? _i6.Book.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.BookTag?>()) {
      return (data != null ? _i7.BookTag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.BookTagging?>()) {
      return (data != null ? _i8.BookTagging.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.LibraryBook?>()) {
      return (data != null ? _i9.LibraryBook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.LibraryBookLocation?>()) {
      return (data != null ? _i10.LibraryBookLocation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.PupilBookLending?>()) {
      return (data != null ? _i11.PupilBookLending.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.PupilBookLendingFile?>()) {
      return (data != null ? _i12.PupilBookLendingFile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.Competence?>()) {
      return (data != null ? _i13.Competence.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.CompetenceCheck?>()) {
      return (data != null ? _i14.CompetenceCheck.fromJson(data) : null) as T;
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
    if (t == _i1.getType<_i18.Lesson?>()) {
      return (data != null ? _i18.Lesson.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.LessonAttendance?>()) {
      return (data != null ? _i19.LessonAttendance.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.LessonGroup?>()) {
      return (data != null ? _i20.LessonGroup.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.ScheduledLessonGroupMembership?>()) {
      return (data != null
          ? _i21.ScheduledLessonGroupMembership.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i22.LessonSubject?>()) {
      return (data != null ? _i22.LessonSubject.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.ScheduledLesson?>()) {
      return (data != null ? _i23.ScheduledLesson.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.Subject?>()) {
      return (data != null ? _i24.Subject.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.TimetableSlot?>()) {
      return (data != null ? _i25.TimetableSlot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.Weekday?>()) {
      return (data != null ? _i26.Weekday.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.Room?>()) {
      return (data != null ? _i27.Room.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.SupportCategory?>()) {
      return (data != null ? _i28.SupportCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.SupportCategoryStatus?>()) {
      return (data != null ? _i29.SupportCategoryStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i30.SupportGoal?>()) {
      return (data != null ? _i30.SupportGoal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.SupportGoalCheck?>()) {
      return (data != null ? _i31.SupportGoalCheck.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.SupportGoalCheckFile?>()) {
      return (data != null ? _i32.SupportGoalCheckFile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i33.SupportLevel?>()) {
      return (data != null ? _i33.SupportLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.PupilDocumentType?>()) {
      return (data != null ? _i34.PupilDocumentType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.SiblingsTutorInfo?>()) {
      return (data != null ? _i35.SiblingsTutorInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.PupilData?>()) {
      return (data != null ? _i36.PupilData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.AfterSchoolCare?>()) {
      return (data != null ? _i37.AfterSchoolCare.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.AfterSchoolCarePickUpTimes?>()) {
      return (data != null
          ? _i38.AfterSchoolCarePickUpTimes.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i39.PickUpInfo?>()) {
      return (data != null ? _i39.PickUpInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.CommunicationSkills?>()) {
      return (data != null ? _i40.CommunicationSkills.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i41.Language?>()) {
      return (data != null ? _i41.Language.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.PublicMediaAuth?>()) {
      return (data != null ? _i42.PublicMediaAuth.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.TutorInfo?>()) {
      return (data != null ? _i43.TutorInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.KindergardenInfo?>()) {
      return (data != null ? _i44.KindergardenInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.PreSchoolMedical?>()) {
      return (data != null ? _i45.PreSchoolMedical.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.PreSchoolMedicalStatus?>()) {
      return (data != null ? _i46.PreSchoolMedicalStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i47.PreSchoolTest?>()) {
      return (data != null ? _i47.PreSchoolTest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.PupilListEntry?>()) {
      return (data != null ? _i48.PupilListEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.SchoolList?>()) {
      return (data != null ? _i49.SchoolList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.ContactedType?>()) {
      return (data != null ? _i50.ContactedType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.MissedClass?>()) {
      return (data != null ? _i51.MissedClass.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.MissedClassDto?>()) {
      return (data != null ? _i52.MissedClassDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.MissedType?>()) {
      return (data != null ? _i53.MissedType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.SchoolSemester?>()) {
      return (data != null ? _i54.SchoolSemester.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.Schoolday?>()) {
      return (data != null ? _i55.Schoolday.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.SchooldayEvent?>()) {
      return (data != null ? _i56.SchooldayEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.SchooldayEventType?>()) {
      return (data != null ? _i57.SchooldayEventType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i58.HubDocument?>()) {
      return (data != null ? _i58.HubDocument.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.MemberOperation?>()) {
      return (data != null ? _i59.MemberOperation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i60.LanguageStats?>()) {
      return (data != null ? _i60.LanguageStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.CreditTransaction?>()) {
      return (data != null ? _i61.CreditTransaction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.DeviceInfo?>()) {
      return (data != null ? _i62.DeviceInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.Role?>()) {
      return (data != null ? _i63.Role.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.User?>()) {
      return (data != null ? _i64.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.UserDevice?>()) {
      return (data != null ? _i65.UserDevice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i66.UserFlags?>()) {
      return (data != null ? _i66.UserFlags.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.PupilWorkbook?>()) {
      return (data != null ? _i67.PupilWorkbook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.Workbook?>()) {
      return (data != null ? _i68.Workbook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<List<_i5.PupilAuthorization>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i5.PupilAuthorization>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i8.BookTagging>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i8.BookTagging>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i9.LibraryBook>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i9.LibraryBook>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i8.BookTagging>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i8.BookTagging>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i11.PupilBookLending>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i11.PupilBookLending>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i9.LibraryBook>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i9.LibraryBook>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i12.PupilBookLendingFile>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i12.PupilBookLendingFile>(e))
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
    if (t == _i1.getType<List<_i14.CompetenceCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i14.CompetenceCheck>(e))
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
    if (t == _i1.getType<List<_i58.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i58.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i58.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i58.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i17.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i17.CompetenceReportCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i19.LessonAttendance>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.LessonAttendance>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i23.ScheduledLesson>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i23.ScheduledLesson>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i21.ScheduledLessonGroupMembership>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i21.ScheduledLessonGroupMembership>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i18.Lesson>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i18.Lesson>(e)).toList()
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
    if (t == _i1.getType<List<_i23.ScheduledLesson>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i23.ScheduledLesson>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i23.ScheduledLesson>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i23.ScheduledLesson>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i30.SupportGoal>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i30.SupportGoal>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i29.SupportCategoryStatus>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i29.SupportCategoryStatus>(e))
              .toList()
          : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<List<_i31.SupportGoalCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i31.SupportGoalCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i32.SupportGoalCheckFile>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i32.SupportGoalCheckFile>(e))
              .toList()
          : null) as T;
    }
    if (t == Set<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toSet() as T;
    }
    if (t == _i1.getType<List<_i5.PupilAuthorization>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i5.PupilAuthorization>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i61.CreditTransaction>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i61.CreditTransaction>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i21.ScheduledLessonGroupMembership>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i21.ScheduledLessonGroupMembership>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i19.LessonAttendance>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.LessonAttendance>(e))
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
    if (t == _i1.getType<List<_i14.CompetenceCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i14.CompetenceCheck>(e))
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
    if (t == _i1.getType<List<_i67.PupilWorkbook>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i67.PupilWorkbook>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i11.PupilBookLending>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i11.PupilBookLending>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i33.SupportLevel>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i33.SupportLevel>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i29.SupportCategoryStatus>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i29.SupportCategoryStatus>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i30.SupportGoal>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i30.SupportGoal>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i51.MissedClass>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i51.MissedClass>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i56.SchooldayEvent>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i56.SchooldayEvent>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i48.PupilListEntry>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i48.PupilListEntry>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i58.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i58.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i58.HubDocument>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i58.HubDocument>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i48.PupilListEntry>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i48.PupilListEntry>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i55.Schoolday>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i55.Schoolday>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i16.CompetenceReport>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i16.CompetenceReport>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i51.MissedClass>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i51.MissedClass>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i56.SchooldayEvent>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i56.SchooldayEvent>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Set<_i41.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i41.Language>(e)).toSet()
          : null) as T;
    }
    if (t == _i1.getType<Set<int>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<int>(e)).toSet()
          : null) as T;
    }
    if (t == _i1.getType<List<_i67.PupilWorkbook>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i67.PupilWorkbook>(e))
              .toList()
          : null) as T;
    }
    if (t == List<_i69.MissedClass>) {
      return (data as List)
          .map((e) => deserialize<_i69.MissedClass>(e))
          .toList() as T;
    }
    if (t == List<_i70.Authorization>) {
      return (data as List)
          .map((e) => deserialize<_i70.Authorization>(e))
          .toList() as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t ==
        _i1.getType<
            ({_i71.MemberOperation operation, List<int> pupilIds})?>()) {
      return (data == null)
          ? null as T
          : (
              operation: deserialize<_i71.MemberOperation>(
                  ((data as Map)['n'] as Map)['operation']),
              pupilIds: deserialize<List<int>>(data['n']['pupilIds']),
            ) as T;
    }
    if (t == List<_i72.Competence>) {
      return (data as List).map((e) => deserialize<_i72.Competence>(e)).toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i73.PupilData>) {
      return (data as List).map((e) => deserialize<_i73.PupilData>(e)).toList()
          as T;
    }
    if (t == Set<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toSet() as T;
    }
    if (t == List<_i74.SchoolList>) {
      return (data as List).map((e) => deserialize<_i74.SchoolList>(e)).toList()
          as T;
    }
    if (t == List<_i75.SchoolSemester>) {
      return (data as List)
          .map((e) => deserialize<_i75.SchoolSemester>(e))
          .toList() as T;
    }
    if (t == List<_i76.Schoolday>) {
      return (data as List).map((e) => deserialize<_i76.Schoolday>(e)).toList()
          as T;
    }
    if (t == List<DateTime>) {
      return (data as List).map((e) => deserialize<DateTime>(e)).toList() as T;
    }
    if (t == List<_i77.SchooldayEvent>) {
      return (data as List)
          .map((e) => deserialize<_i77.SchooldayEvent>(e))
          .toList() as T;
    }
    if (t == List<_i78.User>) {
      return (data as List).map((e) => deserialize<_i78.User>(e)).toList() as T;
    }
    if (t == Set<_i73.PupilData>) {
      return (data as List).map((e) => deserialize<_i73.PupilData>(e)).toSet()
          as T;
    }
    if (t ==
        _i1.getType<
            ({
              _i79.DeviceInfo? deviceInfo,
              _i3.AuthenticationResponse response
            })>()) {
      return (
        deviceInfo: ((data as Map)['n'] as Map)['deviceInfo'] == null
            ? null
            : deserialize<_i79.DeviceInfo>(data['n']['deviceInfo']),
        response:
            deserialize<_i3.AuthenticationResponse>(data['n']['response']),
      ) as T;
    }
    if (t == List<_i80.SupportCategory>) {
      return (data as List)
          .map((e) => deserialize<_i80.SupportCategory>(e))
          .toList() as T;
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
    if (data is _i4.Authorization) {
      return 'Authorization';
    }
    if (data is _i5.PupilAuthorization) {
      return 'PupilAuthorization';
    }
    if (data is _i6.Book) {
      return 'Book';
    }
    if (data is _i7.BookTag) {
      return 'BookTag';
    }
    if (data is _i8.BookTagging) {
      return 'BookTagging';
    }
    if (data is _i9.LibraryBook) {
      return 'LibraryBook';
    }
    if (data is _i10.LibraryBookLocation) {
      return 'LibraryBookLocation';
    }
    if (data is _i11.PupilBookLending) {
      return 'PupilBookLending';
    }
    if (data is _i12.PupilBookLendingFile) {
      return 'PupilBookLendingFile';
    }
    if (data is _i13.Competence) {
      return 'Competence';
    }
    if (data is _i14.CompetenceCheck) {
      return 'CompetenceCheck';
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
    if (data is _i18.Lesson) {
      return 'Lesson';
    }
    if (data is _i19.LessonAttendance) {
      return 'LessonAttendance';
    }
    if (data is _i20.LessonGroup) {
      return 'LessonGroup';
    }
    if (data is _i21.ScheduledLessonGroupMembership) {
      return 'ScheduledLessonGroupMembership';
    }
    if (data is _i22.LessonSubject) {
      return 'LessonSubject';
    }
    if (data is _i23.ScheduledLesson) {
      return 'ScheduledLesson';
    }
    if (data is _i24.Subject) {
      return 'Subject';
    }
    if (data is _i25.TimetableSlot) {
      return 'TimetableSlot';
    }
    if (data is _i26.Weekday) {
      return 'Weekday';
    }
    if (data is _i27.Room) {
      return 'Room';
    }
    if (data is _i28.SupportCategory) {
      return 'SupportCategory';
    }
    if (data is _i29.SupportCategoryStatus) {
      return 'SupportCategoryStatus';
    }
    if (data is _i30.SupportGoal) {
      return 'SupportGoal';
    }
    if (data is _i31.SupportGoalCheck) {
      return 'SupportGoalCheck';
    }
    if (data is _i32.SupportGoalCheckFile) {
      return 'SupportGoalCheckFile';
    }
    if (data is _i33.SupportLevel) {
      return 'SupportLevel';
    }
    if (data is _i34.PupilDocumentType) {
      return 'PupilDocumentType';
    }
    if (data is _i35.SiblingsTutorInfo) {
      return 'SiblingsTutorInfo';
    }
    if (data is _i36.PupilData) {
      return 'PupilData';
    }
    if (data is _i37.AfterSchoolCare) {
      return 'AfterSchoolCare';
    }
    if (data is _i38.AfterSchoolCarePickUpTimes) {
      return 'AfterSchoolCarePickUpTimes';
    }
    if (data is _i39.PickUpInfo) {
      return 'PickUpInfo';
    }
    if (data is _i40.CommunicationSkills) {
      return 'CommunicationSkills';
    }
    if (data is _i41.Language) {
      return 'Language';
    }
    if (data is _i42.PublicMediaAuth) {
      return 'PublicMediaAuth';
    }
    if (data is _i43.TutorInfo) {
      return 'TutorInfo';
    }
    if (data is _i44.KindergardenInfo) {
      return 'KindergardenInfo';
    }
    if (data is _i45.PreSchoolMedical) {
      return 'PreSchoolMedical';
    }
    if (data is _i46.PreSchoolMedicalStatus) {
      return 'PreSchoolMedicalStatus';
    }
    if (data is _i47.PreSchoolTest) {
      return 'PreSchoolTest';
    }
    if (data is _i48.PupilListEntry) {
      return 'PupilListEntry';
    }
    if (data is _i49.SchoolList) {
      return 'SchoolList';
    }
    if (data is _i50.ContactedType) {
      return 'ContactedType';
    }
    if (data is _i51.MissedClass) {
      return 'MissedClass';
    }
    if (data is _i52.MissedClassDto) {
      return 'MissedClassDto';
    }
    if (data is _i53.MissedType) {
      return 'MissedType';
    }
    if (data is _i54.SchoolSemester) {
      return 'SchoolSemester';
    }
    if (data is _i55.Schoolday) {
      return 'Schoolday';
    }
    if (data is _i56.SchooldayEvent) {
      return 'SchooldayEvent';
    }
    if (data is _i57.SchooldayEventType) {
      return 'SchooldayEventType';
    }
    if (data is _i58.HubDocument) {
      return 'HubDocument';
    }
    if (data is _i59.MemberOperation) {
      return 'MemberOperation';
    }
    if (data is _i60.LanguageStats) {
      return 'LanguageStats';
    }
    if (data is _i61.CreditTransaction) {
      return 'CreditTransaction';
    }
    if (data is _i62.DeviceInfo) {
      return 'DeviceInfo';
    }
    if (data is _i63.Role) {
      return 'Role';
    }
    if (data is _i64.User) {
      return 'User';
    }
    if (data is _i65.UserDevice) {
      return 'UserDevice';
    }
    if (data is _i66.UserFlags) {
      return 'UserFlags';
    }
    if (data is _i67.PupilWorkbook) {
      return 'PupilWorkbook';
    }
    if (data is _i68.Workbook) {
      return 'Workbook';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    if (data is List<_i73.PupilData>) {
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
      return deserialize<_i4.Authorization>(data['data']);
    }
    if (dataClassName == 'PupilAuthorization') {
      return deserialize<_i5.PupilAuthorization>(data['data']);
    }
    if (dataClassName == 'Book') {
      return deserialize<_i6.Book>(data['data']);
    }
    if (dataClassName == 'BookTag') {
      return deserialize<_i7.BookTag>(data['data']);
    }
    if (dataClassName == 'BookTagging') {
      return deserialize<_i8.BookTagging>(data['data']);
    }
    if (dataClassName == 'LibraryBook') {
      return deserialize<_i9.LibraryBook>(data['data']);
    }
    if (dataClassName == 'LibraryBookLocation') {
      return deserialize<_i10.LibraryBookLocation>(data['data']);
    }
    if (dataClassName == 'PupilBookLending') {
      return deserialize<_i11.PupilBookLending>(data['data']);
    }
    if (dataClassName == 'PupilBookLendingFile') {
      return deserialize<_i12.PupilBookLendingFile>(data['data']);
    }
    if (dataClassName == 'Competence') {
      return deserialize<_i13.Competence>(data['data']);
    }
    if (dataClassName == 'CompetenceCheck') {
      return deserialize<_i14.CompetenceCheck>(data['data']);
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
    if (dataClassName == 'Lesson') {
      return deserialize<_i18.Lesson>(data['data']);
    }
    if (dataClassName == 'LessonAttendance') {
      return deserialize<_i19.LessonAttendance>(data['data']);
    }
    if (dataClassName == 'LessonGroup') {
      return deserialize<_i20.LessonGroup>(data['data']);
    }
    if (dataClassName == 'ScheduledLessonGroupMembership') {
      return deserialize<_i21.ScheduledLessonGroupMembership>(data['data']);
    }
    if (dataClassName == 'LessonSubject') {
      return deserialize<_i22.LessonSubject>(data['data']);
    }
    if (dataClassName == 'ScheduledLesson') {
      return deserialize<_i23.ScheduledLesson>(data['data']);
    }
    if (dataClassName == 'Subject') {
      return deserialize<_i24.Subject>(data['data']);
    }
    if (dataClassName == 'TimetableSlot') {
      return deserialize<_i25.TimetableSlot>(data['data']);
    }
    if (dataClassName == 'Weekday') {
      return deserialize<_i26.Weekday>(data['data']);
    }
    if (dataClassName == 'Room') {
      return deserialize<_i27.Room>(data['data']);
    }
    if (dataClassName == 'SupportCategory') {
      return deserialize<_i28.SupportCategory>(data['data']);
    }
    if (dataClassName == 'SupportCategoryStatus') {
      return deserialize<_i29.SupportCategoryStatus>(data['data']);
    }
    if (dataClassName == 'SupportGoal') {
      return deserialize<_i30.SupportGoal>(data['data']);
    }
    if (dataClassName == 'SupportGoalCheck') {
      return deserialize<_i31.SupportGoalCheck>(data['data']);
    }
    if (dataClassName == 'SupportGoalCheckFile') {
      return deserialize<_i32.SupportGoalCheckFile>(data['data']);
    }
    if (dataClassName == 'SupportLevel') {
      return deserialize<_i33.SupportLevel>(data['data']);
    }
    if (dataClassName == 'PupilDocumentType') {
      return deserialize<_i34.PupilDocumentType>(data['data']);
    }
    if (dataClassName == 'SiblingsTutorInfo') {
      return deserialize<_i35.SiblingsTutorInfo>(data['data']);
    }
    if (dataClassName == 'PupilData') {
      return deserialize<_i36.PupilData>(data['data']);
    }
    if (dataClassName == 'AfterSchoolCare') {
      return deserialize<_i37.AfterSchoolCare>(data['data']);
    }
    if (dataClassName == 'AfterSchoolCarePickUpTimes') {
      return deserialize<_i38.AfterSchoolCarePickUpTimes>(data['data']);
    }
    if (dataClassName == 'PickUpInfo') {
      return deserialize<_i39.PickUpInfo>(data['data']);
    }
    if (dataClassName == 'CommunicationSkills') {
      return deserialize<_i40.CommunicationSkills>(data['data']);
    }
    if (dataClassName == 'Language') {
      return deserialize<_i41.Language>(data['data']);
    }
    if (dataClassName == 'PublicMediaAuth') {
      return deserialize<_i42.PublicMediaAuth>(data['data']);
    }
    if (dataClassName == 'TutorInfo') {
      return deserialize<_i43.TutorInfo>(data['data']);
    }
    if (dataClassName == 'KindergardenInfo') {
      return deserialize<_i44.KindergardenInfo>(data['data']);
    }
    if (dataClassName == 'PreSchoolMedical') {
      return deserialize<_i45.PreSchoolMedical>(data['data']);
    }
    if (dataClassName == 'PreSchoolMedicalStatus') {
      return deserialize<_i46.PreSchoolMedicalStatus>(data['data']);
    }
    if (dataClassName == 'PreSchoolTest') {
      return deserialize<_i47.PreSchoolTest>(data['data']);
    }
    if (dataClassName == 'PupilListEntry') {
      return deserialize<_i48.PupilListEntry>(data['data']);
    }
    if (dataClassName == 'SchoolList') {
      return deserialize<_i49.SchoolList>(data['data']);
    }
    if (dataClassName == 'ContactedType') {
      return deserialize<_i50.ContactedType>(data['data']);
    }
    if (dataClassName == 'MissedClass') {
      return deserialize<_i51.MissedClass>(data['data']);
    }
    if (dataClassName == 'MissedClassDto') {
      return deserialize<_i52.MissedClassDto>(data['data']);
    }
    if (dataClassName == 'MissedType') {
      return deserialize<_i53.MissedType>(data['data']);
    }
    if (dataClassName == 'SchoolSemester') {
      return deserialize<_i54.SchoolSemester>(data['data']);
    }
    if (dataClassName == 'Schoolday') {
      return deserialize<_i55.Schoolday>(data['data']);
    }
    if (dataClassName == 'SchooldayEvent') {
      return deserialize<_i56.SchooldayEvent>(data['data']);
    }
    if (dataClassName == 'SchooldayEventType') {
      return deserialize<_i57.SchooldayEventType>(data['data']);
    }
    if (dataClassName == 'HubDocument') {
      return deserialize<_i58.HubDocument>(data['data']);
    }
    if (dataClassName == 'MemberOperation') {
      return deserialize<_i59.MemberOperation>(data['data']);
    }
    if (dataClassName == 'LanguageStats') {
      return deserialize<_i60.LanguageStats>(data['data']);
    }
    if (dataClassName == 'CreditTransaction') {
      return deserialize<_i61.CreditTransaction>(data['data']);
    }
    if (dataClassName == 'DeviceInfo') {
      return deserialize<_i62.DeviceInfo>(data['data']);
    }
    if (dataClassName == 'Role') {
      return deserialize<_i63.Role>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i64.User>(data['data']);
    }
    if (dataClassName == 'UserDevice') {
      return deserialize<_i65.UserDevice>(data['data']);
    }
    if (dataClassName == 'UserFlags') {
      return deserialize<_i66.UserFlags>(data['data']);
    }
    if (dataClassName == 'PupilWorkbook') {
      return deserialize<_i67.PupilWorkbook>(data['data']);
    }
    if (dataClassName == 'Workbook') {
      return deserialize<_i68.Workbook>(data['data']);
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
      return deserialize<List<_i73.PupilData>>(data['data']);
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
      case _i4.Authorization:
        return _i4.Authorization.t;
      case _i5.PupilAuthorization:
        return _i5.PupilAuthorization.t;
      case _i6.Book:
        return _i6.Book.t;
      case _i7.BookTag:
        return _i7.BookTag.t;
      case _i8.BookTagging:
        return _i8.BookTagging.t;
      case _i9.LibraryBook:
        return _i9.LibraryBook.t;
      case _i10.LibraryBookLocation:
        return _i10.LibraryBookLocation.t;
      case _i11.PupilBookLending:
        return _i11.PupilBookLending.t;
      case _i12.PupilBookLendingFile:
        return _i12.PupilBookLendingFile.t;
      case _i13.Competence:
        return _i13.Competence.t;
      case _i14.CompetenceCheck:
        return _i14.CompetenceCheck.t;
      case _i15.CompetenceGoal:
        return _i15.CompetenceGoal.t;
      case _i16.CompetenceReport:
        return _i16.CompetenceReport.t;
      case _i17.CompetenceReportCheck:
        return _i17.CompetenceReportCheck.t;
      case _i18.Lesson:
        return _i18.Lesson.t;
      case _i19.LessonAttendance:
        return _i19.LessonAttendance.t;
      case _i20.LessonGroup:
        return _i20.LessonGroup.t;
      case _i21.ScheduledLessonGroupMembership:
        return _i21.ScheduledLessonGroupMembership.t;
      case _i22.LessonSubject:
        return _i22.LessonSubject.t;
      case _i23.ScheduledLesson:
        return _i23.ScheduledLesson.t;
      case _i24.Subject:
        return _i24.Subject.t;
      case _i25.TimetableSlot:
        return _i25.TimetableSlot.t;
      case _i27.Room:
        return _i27.Room.t;
      case _i28.SupportCategory:
        return _i28.SupportCategory.t;
      case _i29.SupportCategoryStatus:
        return _i29.SupportCategoryStatus.t;
      case _i30.SupportGoal:
        return _i30.SupportGoal.t;
      case _i31.SupportGoalCheck:
        return _i31.SupportGoalCheck.t;
      case _i32.SupportGoalCheckFile:
        return _i32.SupportGoalCheckFile.t;
      case _i33.SupportLevel:
        return _i33.SupportLevel.t;
      case _i36.PupilData:
        return _i36.PupilData.t;
      case _i45.PreSchoolMedical:
        return _i45.PreSchoolMedical.t;
      case _i47.PreSchoolTest:
        return _i47.PreSchoolTest.t;
      case _i48.PupilListEntry:
        return _i48.PupilListEntry.t;
      case _i49.SchoolList:
        return _i49.SchoolList.t;
      case _i51.MissedClass:
        return _i51.MissedClass.t;
      case _i54.SchoolSemester:
        return _i54.SchoolSemester.t;
      case _i55.Schoolday:
        return _i55.Schoolday.t;
      case _i56.SchooldayEvent:
        return _i56.SchooldayEvent.t;
      case _i58.HubDocument:
        return _i58.HubDocument.t;
      case _i60.LanguageStats:
        return _i60.LanguageStats.t;
      case _i61.CreditTransaction:
        return _i61.CreditTransaction.t;
      case _i64.User:
        return _i64.User.t;
      case _i65.UserDevice:
        return _i65.UserDevice.t;
      case _i67.PupilWorkbook:
        return _i67.PupilWorkbook.t;
      case _i68.Workbook:
        return _i68.Workbook.t;
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
  if (record is ({_i71.MemberOperation operation, List<int> pupilIds})) {
    return {
      "n": {
        "operation": record.operation,
        "pupilIds": record.pupilIds,
      },
    };
  }
  if (record is ({
    _i79.DeviceInfo? deviceInfo,
    _i3.AuthenticationResponse response
  })) {
    return {
      "n": {
        "deviceInfo": record.deviceInfo,
        "response": record.response,
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

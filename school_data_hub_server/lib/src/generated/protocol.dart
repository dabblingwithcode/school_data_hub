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
import 'example.dart' as _i13;
import 'learning/competence.dart' as _i14;
import 'learning/competence_check.dart' as _i15;
import 'learning/competence_check_file.dart' as _i16;
import 'learning/competence_goal.dart' as _i17;
import 'learning/competence_report.dart' as _i18;
import 'learning/competence_report_check.dart' as _i19;
import 'learning_support/support_category.dart' as _i20;
import 'learning_support/support_category_status.dart' as _i21;
import 'learning_support/support_goal/support_goal.dart' as _i22;
import 'learning_support/support_goal/support_goal_check.dart' as _i23;
import 'learning_support/support_goal/support_goal_check_file.dart' as _i24;
import 'learning_support/support_level.dart' as _i25;
import 'pupil_data/dto/siblings_parent_info_dto.dart' as _i26;
import 'pupil_data/language.dart' as _i27;
import 'pupil_data/pupil_data.dart' as _i28;
import 'pupil_data/pupil_data_parent_info.dart' as _i29;
import 'pupil_data/pupil_enums.dart' as _i30;
import 'school_list/pupil_list.dart' as _i31;
import 'school_list/school_list.dart' as _i32;
import 'schoolday/missed_class.dart' as _i33;
import 'schoolday/school_semester.dart' as _i34;
import 'schoolday/schoolday.dart' as _i35;
import 'schoolday/schoolday_event.dart' as _i36;
import 'stats/language_stats.dart' as _i37;
import 'user/credit_transaction.dart' as _i38;
import 'user/device_info.dart' as _i39;
import 'user/roles/auth_level.dart' as _i40;
import 'user/roles/roles.dart' as _i41;
import 'user/staff_user.dart' as _i42;
import 'user/user_device.dart' as _i43;
import 'user/user_flags.dart' as _i44;
import 'workbook/pupil_workbook.dart' as _i45;
import 'workbook/workbook.dart' as _i46;
import 'package:school_data_hub_server/src/generated/user/staff_user.dart'
    as _i47;
import 'package:school_data_hub_server/src/generated/user/device_info.dart'
    as _i48;
import 'package:school_data_hub_server/src/generated/learning/competence.dart'
    as _i49;
import 'package:school_data_hub_server/src/generated/schoolday/missed_class.dart'
    as _i50;
import 'package:school_data_hub_server/src/generated/pupil_data/pupil_data.dart'
    as _i51;
import 'package:school_data_hub_server/src/generated/schoolday/school_semester.dart'
    as _i52;
import 'package:school_data_hub_server/src/generated/schoolday/schoolday.dart'
    as _i53;
import 'package:school_data_hub_server/src/generated/learning_support/support_category.dart'
    as _i54;
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
export 'pupil_data/language.dart';
export 'pupil_data/pupil_data.dart';
export 'pupil_data/pupil_data_parent_info.dart';
export 'pupil_data/pupil_enums.dart';
export 'school_list/pupil_list.dart';
export 'school_list/school_list.dart';
export 'schoolday/missed_class.dart';
export 'schoolday/school_semester.dart';
export 'schoolday/schoolday.dart';
export 'schoolday/schoolday_event.dart';
export 'stats/language_stats.dart';
export 'user/credit_transaction.dart';
export 'user/device_info.dart';
export 'user/roles/auth_level.dart';
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
          name: 'publicId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'authorizationName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'authorizationDescription',
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
      name: 'competence_check_file',
      dartName: 'CompetenceCheckFile',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'competence_check_file_id_seq\'::regclass)',
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
          name: 'competenceCheckId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'competence_check_file_fk_0',
          columns: ['competenceCheckId'],
          referenceTable: 'competence_check',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'competence_check_file_pkey',
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
      ],
      foreignKeys: [],
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
        )
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
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
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
          dartType: 'String',
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
          isNullable: false,
          dartType: 'DateTime',
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
          name: 'modifiedBy',
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
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'fileUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
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
          columns: ['authorizationId'],
          referenceTable: 'authorization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'pupil_authorization_fk_1',
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
          name: 'internalId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'contact',
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
          name: 'creditEarned',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'ogs',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'pickUpTime',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'ogsInfo',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'latestSupportLevel',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:SupportLevel',
        ),
        _i2.ColumnDefinition(
          name: 'repeater',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'swimmer',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'communicationPupil',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'pupilDataParentInfo',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:PupilDataParentInfo?',
        ),
        _i2.ColumnDefinition(
          name: 'preSchoolRevision',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:PreSchoolRevision',
        ),
      ],
      foreignKeys: [],
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
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'pupil_list',
      dartName: 'PupilList',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'pupil_list_id_seq\'::regclass)',
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
          constraintName: 'pupil_list_fk_0',
          columns: ['schoolListId'],
          referenceTable: 'school_list',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'pupil_list_fk_1',
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
          indexName: 'pupil_list_pkey',
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
          name: 'visibility',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'authorizedUsers',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Set<String>?',
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
          dartType: 'String',
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
          name: 'fileUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'processedFileId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'processedFileUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
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
          columns: ['schooldayId'],
          referenceTable: 'schoolday',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'schoolday_event_fk_1',
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
      name: 'staff',
      dartName: 'StaffUser',
      schema: 'public',
      module: 'school_data_hub',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'staff_id_seq\'::regclass)',
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
          constraintName: 'staff_fk_0',
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
          indexName: 'staff_pkey',
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
        _i2.ColumnDefinition(
          name: '_pupilDataWorkbooksPupilDataId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'workbook_fk_0',
          columns: ['_pupilDataWorkbooksPupilDataId'],
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
    if (t == _i13.Example) {
      return _i13.Example.fromJson(data) as T;
    }
    if (t == _i14.Competence) {
      return _i14.Competence.fromJson(data) as T;
    }
    if (t == _i15.CompetenceCheck) {
      return _i15.CompetenceCheck.fromJson(data) as T;
    }
    if (t == _i16.CompetenceCheckFile) {
      return _i16.CompetenceCheckFile.fromJson(data) as T;
    }
    if (t == _i17.CompetenceGoal) {
      return _i17.CompetenceGoal.fromJson(data) as T;
    }
    if (t == _i18.CompetenceReport) {
      return _i18.CompetenceReport.fromJson(data) as T;
    }
    if (t == _i19.CompetenceReportCheck) {
      return _i19.CompetenceReportCheck.fromJson(data) as T;
    }
    if (t == _i20.SupportCategory) {
      return _i20.SupportCategory.fromJson(data) as T;
    }
    if (t == _i21.SupportCategoryStatus) {
      return _i21.SupportCategoryStatus.fromJson(data) as T;
    }
    if (t == _i22.SupportGoal) {
      return _i22.SupportGoal.fromJson(data) as T;
    }
    if (t == _i23.SupportGoalCheck) {
      return _i23.SupportGoalCheck.fromJson(data) as T;
    }
    if (t == _i24.SupportGoalCheckFile) {
      return _i24.SupportGoalCheckFile.fromJson(data) as T;
    }
    if (t == _i25.SupportLevel) {
      return _i25.SupportLevel.fromJson(data) as T;
    }
    if (t == _i26.SiblingsParentInfo) {
      return _i26.SiblingsParentInfo.fromJson(data) as T;
    }
    if (t == _i27.Language) {
      return _i27.Language.fromJson(data) as T;
    }
    if (t == _i28.PupilData) {
      return _i28.PupilData.fromJson(data) as T;
    }
    if (t == _i29.PupilDataParentInfo) {
      return _i29.PupilDataParentInfo.fromJson(data) as T;
    }
    if (t == _i30.PreSchoolRevision) {
      return _i30.PreSchoolRevision.fromJson(data) as T;
    }
    if (t == _i31.PupilList) {
      return _i31.PupilList.fromJson(data) as T;
    }
    if (t == _i32.SchoolList) {
      return _i32.SchoolList.fromJson(data) as T;
    }
    if (t == _i33.MissedClass) {
      return _i33.MissedClass.fromJson(data) as T;
    }
    if (t == _i34.SchoolSemester) {
      return _i34.SchoolSemester.fromJson(data) as T;
    }
    if (t == _i35.Schoolday) {
      return _i35.Schoolday.fromJson(data) as T;
    }
    if (t == _i36.SchooldayEvent) {
      return _i36.SchooldayEvent.fromJson(data) as T;
    }
    if (t == _i37.LanguageStats) {
      return _i37.LanguageStats.fromJson(data) as T;
    }
    if (t == _i38.CreditTransaction) {
      return _i38.CreditTransaction.fromJson(data) as T;
    }
    if (t == _i39.DeviceInfo) {
      return _i39.DeviceInfo.fromJson(data) as T;
    }
    if (t == _i40.AuthLevel) {
      return _i40.AuthLevel.fromJson(data) as T;
    }
    if (t == _i41.Role) {
      return _i41.Role.fromJson(data) as T;
    }
    if (t == _i42.StaffUser) {
      return _i42.StaffUser.fromJson(data) as T;
    }
    if (t == _i43.UserDevice) {
      return _i43.UserDevice.fromJson(data) as T;
    }
    if (t == _i44.UserFlags) {
      return _i44.UserFlags.fromJson(data) as T;
    }
    if (t == _i45.PupilWorkbook) {
      return _i45.PupilWorkbook.fromJson(data) as T;
    }
    if (t == _i46.Workbook) {
      return _i46.Workbook.fromJson(data) as T;
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
    if (t == _i1.getType<_i13.Example?>()) {
      return (data != null ? _i13.Example.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Competence?>()) {
      return (data != null ? _i14.Competence.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.CompetenceCheck?>()) {
      return (data != null ? _i15.CompetenceCheck.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.CompetenceCheckFile?>()) {
      return (data != null ? _i16.CompetenceCheckFile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.CompetenceGoal?>()) {
      return (data != null ? _i17.CompetenceGoal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.CompetenceReport?>()) {
      return (data != null ? _i18.CompetenceReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.CompetenceReportCheck?>()) {
      return (data != null ? _i19.CompetenceReportCheck.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.SupportCategory?>()) {
      return (data != null ? _i20.SupportCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.SupportCategoryStatus?>()) {
      return (data != null ? _i21.SupportCategoryStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.SupportGoal?>()) {
      return (data != null ? _i22.SupportGoal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.SupportGoalCheck?>()) {
      return (data != null ? _i23.SupportGoalCheck.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.SupportGoalCheckFile?>()) {
      return (data != null ? _i24.SupportGoalCheckFile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.SupportLevel?>()) {
      return (data != null ? _i25.SupportLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.SiblingsParentInfo?>()) {
      return (data != null ? _i26.SiblingsParentInfo.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i27.Language?>()) {
      return (data != null ? _i27.Language.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.PupilData?>()) {
      return (data != null ? _i28.PupilData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.PupilDataParentInfo?>()) {
      return (data != null ? _i29.PupilDataParentInfo.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i30.PreSchoolRevision?>()) {
      return (data != null ? _i30.PreSchoolRevision.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.PupilList?>()) {
      return (data != null ? _i31.PupilList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.SchoolList?>()) {
      return (data != null ? _i32.SchoolList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.MissedClass?>()) {
      return (data != null ? _i33.MissedClass.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.SchoolSemester?>()) {
      return (data != null ? _i34.SchoolSemester.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.Schoolday?>()) {
      return (data != null ? _i35.Schoolday.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.SchooldayEvent?>()) {
      return (data != null ? _i36.SchooldayEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.LanguageStats?>()) {
      return (data != null ? _i37.LanguageStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.CreditTransaction?>()) {
      return (data != null ? _i38.CreditTransaction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.DeviceInfo?>()) {
      return (data != null ? _i39.DeviceInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.AuthLevel?>()) {
      return (data != null ? _i40.AuthLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.Role?>()) {
      return (data != null ? _i41.Role.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.StaffUser?>()) {
      return (data != null ? _i42.StaffUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.UserDevice?>()) {
      return (data != null ? _i43.UserDevice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.UserFlags?>()) {
      return (data != null ? _i44.UserFlags.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.PupilWorkbook?>()) {
      return (data != null ? _i45.PupilWorkbook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.Workbook?>()) {
      return (data != null ? _i46.Workbook.fromJson(data) : null) as T;
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
    if (t == _i1.getType<List<_i17.CompetenceGoal>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i17.CompetenceGoal>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i15.CompetenceCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i15.CompetenceCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i19.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.CompetenceReportCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i16.CompetenceCheckFile>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i16.CompetenceCheckFile>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i19.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.CompetenceReportCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i22.SupportGoal>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i22.SupportGoal>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i21.SupportCategoryStatus>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i21.SupportCategoryStatus>(e))
              .toList()
          : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<List<_i23.SupportGoalCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i23.SupportGoalCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i24.SupportGoalCheckFile>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i24.SupportGoalCheckFile>(e))
              .toList()
          : null) as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _i1.getType<List<_i5.PupilAuthorization>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i5.PupilAuthorization>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i33.MissedClass>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i33.MissedClass>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i36.SchooldayEvent>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i36.SchooldayEvent>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i46.Workbook>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i46.Workbook>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i22.SupportGoal>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i22.SupportGoal>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i21.SupportCategoryStatus>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i21.SupportCategoryStatus>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i45.PupilWorkbook>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i45.PupilWorkbook>(e))
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
    if (t == _i1.getType<List<_i17.CompetenceGoal>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i17.CompetenceGoal>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i15.CompetenceCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i15.CompetenceCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i18.CompetenceReport>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i18.CompetenceReport>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i19.CompetenceReportCheck>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.CompetenceReportCheck>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i31.PupilList>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i31.PupilList>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Set<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toSet()
          : null) as T;
    }
    if (t == _i1.getType<List<_i31.PupilList>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i31.PupilList>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i35.Schoolday>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i35.Schoolday>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i18.CompetenceReport>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i18.CompetenceReport>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i33.MissedClass>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i33.MissedClass>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i36.SchooldayEvent>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i36.SchooldayEvent>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Set<_i27.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i27.Language>(e)).toSet()
          : null) as T;
    }
    if (t == _i1.getType<Set<int>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<int>(e)).toSet()
          : null) as T;
    }
    if (t == _i1.getType<List<_i45.PupilWorkbook>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i45.PupilWorkbook>(e))
              .toList()
          : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i47.StaffUser>) {
      return (data as List).map((e) => deserialize<_i47.StaffUser>(e)).toList()
          as T;
    }
    if (t ==
        _i1.getType<
            ({
              _i48.DeviceInfo? deviceInfo,
              _i3.AuthenticationResponse response
            })>()) {
      return (
        deviceInfo: ((data as Map)['n'] as Map)['deviceInfo'] == null
            ? null
            : deserialize<_i48.DeviceInfo>(data['n']['deviceInfo']),
        response:
            deserialize<_i3.AuthenticationResponse>(data['n']['response']),
      ) as T;
    }
    if (t == List<_i49.Competence>) {
      return (data as List).map((e) => deserialize<_i49.Competence>(e)).toList()
          as T;
    }
    if (t == List<_i50.MissedClass>) {
      return (data as List)
          .map((e) => deserialize<_i50.MissedClass>(e))
          .toList() as T;
    }
    if (t == List<_i51.PupilData>) {
      return (data as List).map((e) => deserialize<_i51.PupilData>(e)).toList()
          as T;
    }
    if (t == Set<_i51.PupilData>) {
      return (data as List).map((e) => deserialize<_i51.PupilData>(e)).toSet()
          as T;
    }
    if (t == List<_i52.SchoolSemester>) {
      return (data as List)
          .map((e) => deserialize<_i52.SchoolSemester>(e))
          .toList() as T;
    }
    if (t == List<_i53.Schoolday>) {
      return (data as List).map((e) => deserialize<_i53.Schoolday>(e)).toList()
          as T;
    }
    if (t == List<DateTime>) {
      return (data as List).map((e) => deserialize<DateTime>(e)).toList() as T;
    }
    if (t == List<_i54.SupportCategory>) {
      return (data as List)
          .map((e) => deserialize<_i54.SupportCategory>(e))
          .toList() as T;
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
    if (data is _i13.Example) {
      return 'Example';
    }
    if (data is _i14.Competence) {
      return 'Competence';
    }
    if (data is _i15.CompetenceCheck) {
      return 'CompetenceCheck';
    }
    if (data is _i16.CompetenceCheckFile) {
      return 'CompetenceCheckFile';
    }
    if (data is _i17.CompetenceGoal) {
      return 'CompetenceGoal';
    }
    if (data is _i18.CompetenceReport) {
      return 'CompetenceReport';
    }
    if (data is _i19.CompetenceReportCheck) {
      return 'CompetenceReportCheck';
    }
    if (data is _i20.SupportCategory) {
      return 'SupportCategory';
    }
    if (data is _i21.SupportCategoryStatus) {
      return 'SupportCategoryStatus';
    }
    if (data is _i22.SupportGoal) {
      return 'SupportGoal';
    }
    if (data is _i23.SupportGoalCheck) {
      return 'SupportGoalCheck';
    }
    if (data is _i24.SupportGoalCheckFile) {
      return 'SupportGoalCheckFile';
    }
    if (data is _i25.SupportLevel) {
      return 'SupportLevel';
    }
    if (data is _i26.SiblingsParentInfo) {
      return 'SiblingsParentInfo';
    }
    if (data is _i27.Language) {
      return 'Language';
    }
    if (data is _i28.PupilData) {
      return 'PupilData';
    }
    if (data is _i29.PupilDataParentInfo) {
      return 'PupilDataParentInfo';
    }
    if (data is _i30.PreSchoolRevision) {
      return 'PreSchoolRevision';
    }
    if (data is _i31.PupilList) {
      return 'PupilList';
    }
    if (data is _i32.SchoolList) {
      return 'SchoolList';
    }
    if (data is _i33.MissedClass) {
      return 'MissedClass';
    }
    if (data is _i34.SchoolSemester) {
      return 'SchoolSemester';
    }
    if (data is _i35.Schoolday) {
      return 'Schoolday';
    }
    if (data is _i36.SchooldayEvent) {
      return 'SchooldayEvent';
    }
    if (data is _i37.LanguageStats) {
      return 'LanguageStats';
    }
    if (data is _i38.CreditTransaction) {
      return 'CreditTransaction';
    }
    if (data is _i39.DeviceInfo) {
      return 'DeviceInfo';
    }
    if (data is _i40.AuthLevel) {
      return 'AuthLevel';
    }
    if (data is _i41.Role) {
      return 'Role';
    }
    if (data is _i42.StaffUser) {
      return 'StaffUser';
    }
    if (data is _i43.UserDevice) {
      return 'UserDevice';
    }
    if (data is _i44.UserFlags) {
      return 'UserFlags';
    }
    if (data is _i45.PupilWorkbook) {
      return 'PupilWorkbook';
    }
    if (data is _i46.Workbook) {
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
    if (data is List<_i51.PupilData>) {
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
    if (dataClassName == 'Example') {
      return deserialize<_i13.Example>(data['data']);
    }
    if (dataClassName == 'Competence') {
      return deserialize<_i14.Competence>(data['data']);
    }
    if (dataClassName == 'CompetenceCheck') {
      return deserialize<_i15.CompetenceCheck>(data['data']);
    }
    if (dataClassName == 'CompetenceCheckFile') {
      return deserialize<_i16.CompetenceCheckFile>(data['data']);
    }
    if (dataClassName == 'CompetenceGoal') {
      return deserialize<_i17.CompetenceGoal>(data['data']);
    }
    if (dataClassName == 'CompetenceReport') {
      return deserialize<_i18.CompetenceReport>(data['data']);
    }
    if (dataClassName == 'CompetenceReportCheck') {
      return deserialize<_i19.CompetenceReportCheck>(data['data']);
    }
    if (dataClassName == 'SupportCategory') {
      return deserialize<_i20.SupportCategory>(data['data']);
    }
    if (dataClassName == 'SupportCategoryStatus') {
      return deserialize<_i21.SupportCategoryStatus>(data['data']);
    }
    if (dataClassName == 'SupportGoal') {
      return deserialize<_i22.SupportGoal>(data['data']);
    }
    if (dataClassName == 'SupportGoalCheck') {
      return deserialize<_i23.SupportGoalCheck>(data['data']);
    }
    if (dataClassName == 'SupportGoalCheckFile') {
      return deserialize<_i24.SupportGoalCheckFile>(data['data']);
    }
    if (dataClassName == 'SupportLevel') {
      return deserialize<_i25.SupportLevel>(data['data']);
    }
    if (dataClassName == 'SiblingsParentInfo') {
      return deserialize<_i26.SiblingsParentInfo>(data['data']);
    }
    if (dataClassName == 'Language') {
      return deserialize<_i27.Language>(data['data']);
    }
    if (dataClassName == 'PupilData') {
      return deserialize<_i28.PupilData>(data['data']);
    }
    if (dataClassName == 'PupilDataParentInfo') {
      return deserialize<_i29.PupilDataParentInfo>(data['data']);
    }
    if (dataClassName == 'PreSchoolRevision') {
      return deserialize<_i30.PreSchoolRevision>(data['data']);
    }
    if (dataClassName == 'PupilList') {
      return deserialize<_i31.PupilList>(data['data']);
    }
    if (dataClassName == 'SchoolList') {
      return deserialize<_i32.SchoolList>(data['data']);
    }
    if (dataClassName == 'MissedClass') {
      return deserialize<_i33.MissedClass>(data['data']);
    }
    if (dataClassName == 'SchoolSemester') {
      return deserialize<_i34.SchoolSemester>(data['data']);
    }
    if (dataClassName == 'Schoolday') {
      return deserialize<_i35.Schoolday>(data['data']);
    }
    if (dataClassName == 'SchooldayEvent') {
      return deserialize<_i36.SchooldayEvent>(data['data']);
    }
    if (dataClassName == 'LanguageStats') {
      return deserialize<_i37.LanguageStats>(data['data']);
    }
    if (dataClassName == 'CreditTransaction') {
      return deserialize<_i38.CreditTransaction>(data['data']);
    }
    if (dataClassName == 'DeviceInfo') {
      return deserialize<_i39.DeviceInfo>(data['data']);
    }
    if (dataClassName == 'AuthLevel') {
      return deserialize<_i40.AuthLevel>(data['data']);
    }
    if (dataClassName == 'Role') {
      return deserialize<_i41.Role>(data['data']);
    }
    if (dataClassName == 'StaffUser') {
      return deserialize<_i42.StaffUser>(data['data']);
    }
    if (dataClassName == 'UserDevice') {
      return deserialize<_i43.UserDevice>(data['data']);
    }
    if (dataClassName == 'UserFlags') {
      return deserialize<_i44.UserFlags>(data['data']);
    }
    if (dataClassName == 'PupilWorkbook') {
      return deserialize<_i45.PupilWorkbook>(data['data']);
    }
    if (dataClassName == 'Workbook') {
      return deserialize<_i46.Workbook>(data['data']);
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
      return deserialize<List<_i51.PupilData>>(data['data']);
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
      case _i14.Competence:
        return _i14.Competence.t;
      case _i15.CompetenceCheck:
        return _i15.CompetenceCheck.t;
      case _i16.CompetenceCheckFile:
        return _i16.CompetenceCheckFile.t;
      case _i17.CompetenceGoal:
        return _i17.CompetenceGoal.t;
      case _i18.CompetenceReport:
        return _i18.CompetenceReport.t;
      case _i19.CompetenceReportCheck:
        return _i19.CompetenceReportCheck.t;
      case _i20.SupportCategory:
        return _i20.SupportCategory.t;
      case _i21.SupportCategoryStatus:
        return _i21.SupportCategoryStatus.t;
      case _i22.SupportGoal:
        return _i22.SupportGoal.t;
      case _i23.SupportGoalCheck:
        return _i23.SupportGoalCheck.t;
      case _i24.SupportGoalCheckFile:
        return _i24.SupportGoalCheckFile.t;
      case _i28.PupilData:
        return _i28.PupilData.t;
      case _i31.PupilList:
        return _i31.PupilList.t;
      case _i32.SchoolList:
        return _i32.SchoolList.t;
      case _i33.MissedClass:
        return _i33.MissedClass.t;
      case _i34.SchoolSemester:
        return _i34.SchoolSemester.t;
      case _i35.Schoolday:
        return _i35.Schoolday.t;
      case _i36.SchooldayEvent:
        return _i36.SchooldayEvent.t;
      case _i37.LanguageStats:
        return _i37.LanguageStats.t;
      case _i38.CreditTransaction:
        return _i38.CreditTransaction.t;
      case _i42.StaffUser:
        return _i42.StaffUser.t;
      case _i43.UserDevice:
        return _i43.UserDevice.t;
      case _i45.PupilWorkbook:
        return _i45.PupilWorkbook.t;
      case _i46.Workbook:
        return _i46.Workbook.t;
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
    _i48.DeviceInfo? deviceInfo,
    _i3.AuthenticationResponse response
  })) {
    return {
      "n": {
        "deviceInfo": record.deviceInfo,
        "response": record.response,
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

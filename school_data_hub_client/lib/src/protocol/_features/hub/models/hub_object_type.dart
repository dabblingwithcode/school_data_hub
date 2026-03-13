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

enum HubObjectType implements _i1.SerializableModel {
  pupilData,
  missedSchoolday,
  schooldayEvent,
  schoolList,
  authorization,
  supportCategory,
  competence,
  competenceReport,
  competenceReportCheck,
  competenceReportItem,
  competenceGoal,
  supportGoal;

  static HubObjectType fromJson(int index) {
    switch (index) {
      case 0:
        return HubObjectType.pupilData;
      case 1:
        return HubObjectType.missedSchoolday;
      case 2:
        return HubObjectType.schooldayEvent;
      case 3:
        return HubObjectType.schoolList;
      case 4:
        return HubObjectType.authorization;
      case 5:
        return HubObjectType.supportCategory;
      case 6:
        return HubObjectType.competence;
      case 7:
        return HubObjectType.competenceReport;
      case 8:
        return HubObjectType.competenceReportCheck;
      case 9:
        return HubObjectType.competenceReportItem;
      case 10:
        return HubObjectType.competenceGoal;
      case 11:
        return HubObjectType.supportGoal;
      default:
        throw ArgumentError(
            'Value "$index" cannot be converted to "HubObjectType"');
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}

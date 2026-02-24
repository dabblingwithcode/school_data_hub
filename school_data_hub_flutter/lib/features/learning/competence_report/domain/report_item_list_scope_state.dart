import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

/// In-memory state for the competence report item list flow (scope lifetime).
/// Holds the last selected grades used when creating a new report item.
class ReportItemListScopeState {
  ReportItemListScopeState() : lastGrades = ValueNotifier<Set<SchoolGrade>>({});

  final ValueNotifier<Set<SchoolGrade>> lastGrades;
  void dispose() {
    lastGrades.dispose();
    Logger('Scoped state disposed').info;
  }

  // void dispose() => lastGrades.dispose();
}

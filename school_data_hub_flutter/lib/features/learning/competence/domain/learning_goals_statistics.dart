import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/pupil_proxy_competence_ext.dart';

/// Statistics about learning goals across pupils
typedef LearningGoalsStats = ({
  int totalGoals,
  int totalOpenGoals,
  int totalAchievedGoals,
});

class LearningGoalsStatistics {
  /// Calculates statistics for all competence goals across the given pupils.
  ///
  /// This analyzes competence goals from all pupils and returns counts for:
  /// - totalGoals: Total number of competence goals
  /// - totalOpenGoals: Number of goals where achievedAt is null
  /// - totalAchievedGoals: Number of goals where achievedAt is not null
  static LearningGoalsStats calculateStats(List<PupilProxy> pupils) {
    int totalGoals = 0;
    int totalOpenGoals = 0;
    int totalAchievedGoals = 0;

    for (final pupil in pupils) {
      // Process competence goals
      if (pupil.competenceGoals.isNotEmpty) {
        for (final goal in pupil.competenceGoals) {
          totalGoals++;
          if (goal.achievedAt == null) {
            totalOpenGoals++;
          } else {
            totalAchievedGoals++;
          }
        }
      }
    }

    return (
      totalGoals: totalGoals,
      totalOpenGoals: totalOpenGoals,
      totalAchievedGoals: totalAchievedGoals,
    );
  }
}

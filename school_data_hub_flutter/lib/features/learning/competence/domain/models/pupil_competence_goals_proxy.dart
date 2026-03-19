import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

class PupilCompetenceGoalsProxy with ChangeNotifier {
  List<CompetenceGoal> competenceGoals = [];

  void setCompetenceGoals(List<CompetenceGoal> value) {
    if (competenceGoals == value) return;
    competenceGoals = value;
    notifyListeners();
  }

  void upsertCompetenceGoal(CompetenceGoal value) {
    final index = competenceGoals.indexWhere((e) => e.id == value.id);
    if (index != -1) {
      competenceGoals[index] = value;
    } else {
      competenceGoals.add(value);
    }
    notifyListeners();
  }

  void removeCompetenceGoalById(int id) {
    competenceGoals.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void clear() {
    competenceGoals.clear();
    notifyListeners();
  }
}

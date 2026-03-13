import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

class PupilSupportGoalsProxy with ChangeNotifier {
  List<SupportGoal> supportGoals = [];

  void setSupportGoals(List<SupportGoal> value) {
    if (supportGoals == value) return;
    supportGoals = value;
    notifyListeners();
  }

  void upsertSupportGoal(SupportGoal value) {
    final index = supportGoals.indexWhere((e) => e.id == value.id);
    if (index != -1) {
      supportGoals[index] = value;
    } else {
      supportGoals.add(value);
    }
    notifyListeners();
  }

  void removeSupportGoalById(int id) {
    supportGoals.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void clear() {
    supportGoals.clear();
    notifyListeners();
  }
}

import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';

class PupilMissedClassesProxy with ChangeNotifier {
  List<MissedClass> missedClasses = [];

  void setMissedClasses(List<MissedClass> value) {
    if (missedClasses == value) return;
    missedClasses = value;
    notifyListeners();
  }

  void updateMissedClass(MissedClass value) {
    int index = missedClasses.indexWhere((element) => element.id == value.id);
    if (index != -1) {
      missedClasses[index] = value;
    } else {
      missedClasses.add(value);
    }
    notifyListeners();
  }

  void addMissedClass(MissedClass value) {
    missedClasses.add(value);
    notifyListeners();
  }

  void removeMissedClass(int pupilId, DateTime date) {
    missedClasses.removeWhere((element) =>
        element.pupilId == pupilId &&
        element.schoolday!.schoolday.formatForJson() == date.formatForJson());

    notifyListeners();
  }

  void clear() {
    missedClasses.clear();
    notifyListeners();
  }
}

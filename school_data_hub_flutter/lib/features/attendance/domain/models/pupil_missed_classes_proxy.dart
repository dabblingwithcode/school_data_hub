import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

class PupilMissedSchooldaysProxy with ChangeNotifier {
  List<MissedSchoolday> missedSchooldays = [];

  void setMissedSchooldayes(List<MissedSchoolday> value) {
    if (missedSchooldays == value) return;
    missedSchooldays = value;
    notifyListeners();
  }

  void updateMissedSchoolday(MissedSchoolday value) {
    int index = missedSchooldays.indexWhere(
      (element) => element.id == value.id,
    );
    if (index != -1) {
      missedSchooldays[index] = value;
    } else {
      missedSchooldays.add(value);
    }
    notifyListeners();
  }

  void addMissedSchoolday(MissedSchoolday value) {
    missedSchooldays.add(value);
    notifyListeners();
  }

  void removeMissedSchoolday(int pupilId, DateTime date) {
    missedSchooldays.removeWhere(
      (element) =>
          element.pupilId == pupilId &&
          element.schoolday!.schoolday.toLocal() == date.toLocal(),
    );

    notifyListeners();
  }

  void clear() {
    missedSchooldays.clear();
    notifyListeners();
  }
}

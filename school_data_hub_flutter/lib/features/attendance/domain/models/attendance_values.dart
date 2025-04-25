import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';

class AttendanceValues with ChangeNotifier {
  MissedType missedTypeValue;
  ContactedType contactedTypeValue;
  String? createdOrModifiedByValue;
  bool unexcusedValue;
  bool returnedValue;
  DateTime? returnedTimeValue;
  String? commentValue;

  AttendanceValues({
    required this.missedTypeValue,
    required this.contactedTypeValue,
    required this.createdOrModifiedByValue,
    required this.unexcusedValue,
    this.returnedValue = false,
    this.returnedTimeValue,
    this.commentValue,
  });

  void setMissedType(MissedType value) {
    if (missedTypeValue == value) return;
    missedTypeValue = value;
    notifyListeners();
  }

  void setContactedType(ContactedType value) {
    if (contactedTypeValue == value) return;
    contactedTypeValue = value;
    notifyListeners();
  }

  void setCreatedOrModifiedBy(String? value) {
    if (createdOrModifiedByValue == value) return;
    createdOrModifiedByValue = value;
    notifyListeners();
  }

  void setUnexcused(bool value) {
    if (unexcusedValue == value) return;
    unexcusedValue = value;
    notifyListeners();
  }

  void setReturned(bool value) {
    if (returnedValue == value) return;
    returnedValue = value;
    notifyListeners();
  }

  void setReturnedTime(DateTime? value) {
    if (returnedTimeValue == value) return;
    returnedTimeValue = value;
    notifyListeners();
  }

  void setComment(String? value) {
    if (commentValue == value) return;
    commentValue = value;
    notifyListeners();
  }

  void reset() {
    missedTypeValue = MissedType.notSet;
    contactedTypeValue = ContactedType.notSet;
    createdOrModifiedByValue = null;
    unexcusedValue = false;
    returnedValue = false;
    returnedTimeValue = null;
    commentValue = null;
    notifyListeners();
  }
}

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

  void reset() {
    missedClasses = [];
    notifyListeners();
  }
}

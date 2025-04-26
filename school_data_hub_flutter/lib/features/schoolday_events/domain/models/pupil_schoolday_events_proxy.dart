import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

class PupilSchooldayEventsProxy with ChangeNotifier {
  List<SchooldayEvent> schooldayEvents = [];

  void setSchooldayEvents(List<SchooldayEvent> value) {
    if (schooldayEvents == value) return;
    schooldayEvents = value;
    notifyListeners();
  }

  void updateSchooldayEvent(SchooldayEvent value) {
    int index = schooldayEvents.indexWhere((element) => element.id == value.id);
    if (index != -1) {
      schooldayEvents[index] = value;
    } else {
      schooldayEvents.add(value);
    }
    notifyListeners();
  }

  void addSchooldayEvent(SchooldayEvent value) {
    schooldayEvents.add(value);
    notifyListeners();
  }

  void removeSchooldayEvent(SchooldayEvent event) {
    schooldayEvents.removeWhere((element) => element.id! == event.id!);
    notifyListeners();
  }

  void clear() {
    schooldayEvents.clear();
    notifyListeners();
  }
}

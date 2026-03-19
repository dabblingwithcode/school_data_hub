import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

class PupilSchooldayEventsProxy with ChangeNotifier {
  Map<int, SchooldayEvent> schooldayEvents = {};

  void setSchooldayEvents(List<SchooldayEvent> events) {
    schooldayEvents.clear();

    for (var event in events) {
      schooldayEvents[event.id!] = event;
    }
    notifyListeners();
  }

  void updateSchooldayEvent(SchooldayEvent event) {
    schooldayEvents[event.id!] = event;

    notifyListeners();
  }

  void removeSchooldayEvent(SchooldayEvent event) {
    if (schooldayEvents[event.id!] == null) return;

    schooldayEvents.remove(event.id!);

    notifyListeners();
  }

  void clear() {
    schooldayEvents.clear();
    notifyListeners();
  }
}

import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

class PupilListEntryProxy with ChangeNotifier {
  PupilListEntry pupilEntry;
  PupilListEntryProxy({required this.pupilEntry});
  void setPupilEntry(PupilListEntry entry) {
    pupilEntry = entry;
    notifyListeners();
  }
}

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

final _log = Logger('PupilListEntryProxy');

//- TODO ADVICE: thousands of these proxies will be created on start
//- is there a better way?
class PupilListEntryProxy with ChangeNotifier {
  PupilListEntry pupilEntry;
  PupilListEntryProxy({required this.pupilEntry}) {
    notifyListeners();
    // _log.info('PupilListEntryProxy created: ${pupilEntry.id}');
  }
  void setPupilEntry(PupilListEntry entry) {
    pupilEntry = entry;
    notifyListeners();
    // _log.info('PupilListEntryProxy updated: ${pupilEntry.id}');
  }
}

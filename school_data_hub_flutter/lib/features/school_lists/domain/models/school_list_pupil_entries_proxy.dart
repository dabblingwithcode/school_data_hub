import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/models/pupil_list_entry_proxy.dart';

final _log = Logger('SchoolListPupilEntriesProxy');

class SchoolListPupilEntriesProxy with ChangeNotifier {
  /// This class is used to manage the state of pupil entries in a school list.
  /// key is the entry id, value is the list of pupil entries.
  Map<int, PupilListEntryProxy> pupilEntries = {};

  void setPupilEntries(List<PupilListEntry> newEntries) {
    // 1. Find entry IDs to keep
    final Set<int> newEntryIds = newEntries.map((e) => e.id!).toSet();

    // Find keys to remove (in current map but not in new entries)
    final List<int> keysToRemove =
        pupilEntries.keys.where((key) => !newEntryIds.contains(key)).toList();

    // Remove entries that no longer exist
    for (final key in keysToRemove) {
      pupilEntries.remove(key);
      _log.fine('Removed entry with ID: $key');
    }

    // 2. Update or add entries
    bool hasChanges = keysToRemove.isNotEmpty;

    for (final newEntry in newEntries) {
      final entryId = newEntry.id!;

      // Case: entry is new, add it
      if (!pupilEntries.containsKey(entryId)) {
        pupilEntries[entryId] = PupilListEntryProxy(pupilEntry: newEntry);
        hasChanges = true;
      }
      // Case: entry exists, check if it needs update
      else {
        final existingEntry = pupilEntries[entryId]!.pupilEntry;

        // Only update if there are actual changes
        // (comparing meaningful fields; adjust as needed)
        if (existingEntry.status != newEntry.status ||
            existingEntry.comment != newEntry.comment) {
          pupilEntries[entryId]!.setPupilEntry(newEntry);
          hasChanges = true;
        } else {
          _log.fine('No changes for entry with ID: $entryId');
        }
      }
    }

    // Only notify listeners if something actually changed
    if (hasChanges) {
      notifyListeners();
      _log.fine('${pupilEntries.length} pupil entries updated in proxy');
    } else {
      _log.fine('No changes in pupil entries');
    }
  }

  void updatePupilEntry(PupilListEntry entry) {
    final entryProxy = pupilEntries[entry.id!];
    entryProxy!.setPupilEntry(entry);

    notifyListeners();
  }

  void removePupilEntry(PupilListEntry entry) {
    if (pupilEntries[entry.id!] == null) return;

    pupilEntries.remove(entry.id!);

    notifyListeners();
    _log.info('Pupil entries set: ${pupilEntries.length}');
  }

  void clear() {
    pupilEntries.clear();
    notifyListeners();
  }
}

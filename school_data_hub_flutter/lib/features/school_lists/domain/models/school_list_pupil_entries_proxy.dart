import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/models/pupil_list_entry_proxy.dart';

final _log = Logger('SchoolListPupilEntriesProxy');

class SchoolListPupilEntriesProxyMap with ChangeNotifier {
  /// This class is used to manage the state of pupil entries in a school list.
  /// key is the entry id, value is the pupil list entry proxy.
  final Map<int, PupilListEntryProxy> pupilEntries = {};

  /// key is the pupilId, value is the pupil list entry proxy.
  /// This allows for O(1) lookups by pupilId.
  final Map<int, PupilListEntryProxy> pupilIdToEntryMap = {};

  void setPupilEntries(List<PupilListEntry> newEntries) {
    // 1. Find entry IDs to keep
    final Set<int> newEntryIds = newEntries.map((e) => e.id!).toSet();

    // Find keys to remove (in current map but not in new entries)
    final List<int> keysToRemove = pupilEntries.keys
        .where((key) => !newEntryIds.contains(key))
        .toList();

    // Remove entries that no longer exist
    for (final key in keysToRemove) {
      final proxy = pupilEntries.remove(key);
      if (proxy != null) {
        pupilIdToEntryMap.remove(proxy.pupilEntry.pupilId);
      }
      _log.fine('Removed entry with ID: $key');
    }

    // 2. Update or add entries
    bool hasChanges = keysToRemove.isNotEmpty;

    for (final newEntry in newEntries) {
      final entryId = newEntry.id!;

      // Case: entry is new, add it
      if (!pupilEntries.containsKey(entryId)) {
        final proxy = PupilListEntryProxy(pupilEntry: newEntry);
        pupilEntries[entryId] = proxy;
        pupilIdToEntryMap[newEntry.pupilId] = proxy;
        hasChanges = true;
      }
      // Case: entry exists, check if it needs update
      else {
        final proxy = pupilEntries[entryId]!;
        final existingEntry = proxy.pupilEntry;

        // Only update if there are actual changes
        // (comparing meaningful fields; adjust as needed)
        if (existingEntry.status != newEntry.status ||
            existingEntry.comment != newEntry.comment) {
          proxy.setPupilEntry(newEntry);
          // Update the pupilId map just in case pupilId changed (unlikely but safe)
          pupilIdToEntryMap[newEntry.pupilId] = proxy;
          hasChanges = true;
        } else {
          _log.info('No changes for entry with ID: $entryId');
        }
      }
    }

    // Only notify listeners if something actually changed
    if (hasChanges) {
      notifyListeners();
      _log.info('${pupilEntries.length} pupil entries updated in proxy');
    } else {
      _log.info('No changes in pupil entries');
    }
  }

  void addPupilEntry(PupilListEntry entry) {
    final proxy = PupilListEntryProxy(pupilEntry: entry);
    pupilEntries[entry.id!] = proxy;
    pupilIdToEntryMap[entry.pupilId] = proxy;
    notifyListeners();
    _log.info('Pupil entry added: ${entry.id}');
  }

  void updatePupilEntry(PupilListEntry entry) {
    final proxy = pupilEntries[entry.id!];
    if (proxy != null) {
      proxy.setPupilEntry(entry);
      pupilIdToEntryMap[entry.pupilId] = proxy;
      notifyListeners();
    }
  }

  void removePupilEntry(int entryId) {
    final proxy = pupilEntries.remove(entryId);
    if (proxy != null) {
      pupilIdToEntryMap.remove(proxy.pupilEntry.pupilId);
      notifyListeners();
      _log.info('Pupil entries remaining: ${pupilEntries.length}');
    }
  }

  void clear() {
    pupilEntries.clear();
    pupilIdToEntryMap.clear();
    notifyListeners();
  }
}

import 'package:school_data_hub_server/src/generated/protocol.dart';

class HubUpdatesTracker {
  HubUpdatesTracker._();
  static final instance = HubUpdatesTracker._();

  final _lastChanged = <HubObjectType, DateTime>{};

  void touch(HubObjectType type) {
    _lastChanged[type] = DateTime.now().toUtc();
  }

  List<HubTypeLastUpdate> get changeTimes => [
        for (final entry in _lastChanged.entries)
          HubTypeLastUpdate(
            objectType: entry.key,
            changedAt: entry.value,
          ),
      ];

  /// Only for use in tests.
  void reset() => _lastChanged.clear();
}

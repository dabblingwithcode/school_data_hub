import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:flutter_it/flutter_it.dart';

final _log = Logger('HubStreamService');

class HubStreamService {
  StreamSubscription<dynamic>? _subscription;

  final _isConnected = ValueNotifier<bool>(false);
  ValueListenable<bool> get isConnected => _isConnected;

  Future<HubStreamService> init() async {
    _subscribe();
    return this;
  }

  void _subscribe() {
    _log.info('[HUB] Subscribing to hub_events_stream');
    _subscription = di<Client>().hub.streamHubEvents().listen(
      (message) {
        _isConnected.value = true;
        if (message is PupilData) {
          di<PupilProxyManager>().upsertFromStream(message);
        } else if (message is MissedSchoolday) {
          di<AttendanceManager>().upsertFromStream(message);
        } else if (message is SchooldayEvent) {
          di<SchooldayEventManager>().upsertFromStream(message);
        } else if (message is SchoolList) {
          di<SchoolListManager>().upsertFromStream(message);
        } else if (message is HubDeleteEvent) {
          switch (message.objectType) {
            case HubObjectType.pupilData:
              break; // hard delete not supported; soft-delete arrives as PupilData upsert
            case HubObjectType.missedSchoolday:
              di<AttendanceManager>().deleteFromStream(message.id);
            case HubObjectType.schooldayEvent:
              di<SchooldayEventManager>().deleteFromStream(message.id);
            case HubObjectType.schoolList:
              di<SchoolListManager>().deleteFromStream(message.id);
          }
        } else {
          _log.warning('[HUB] Received unknown message type: ${message.runtimeType}');
        }
      },
      onError: (Object error) async {
        _isConnected.value = false;
        _log.severe('[HUB] Stream error: $error');
        if (error.toString().contains('Unauthorized')) {
          di<HubSessionManager>().signOutDevice();
          return;
        }
        await Future<void>.delayed(const Duration(seconds: 1));
        _subscribe();
      },
      onDone: () async {
        _isConnected.value = false;
        _log.warning('[HUB] Stream closed - reconnecting...');
        await Future<void>.delayed(const Duration(seconds: 1));
        _subscribe();
      },
    );
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    _isConnected.dispose();
  }
}

import 'package:serverpod/serverpod.dart';
import 'package:school_data_hub_server/src/_features/hub/services/hub_updates_tracker.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';

class HubEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Stream<dynamic> streamHubEvents(Session session) async* {
    final stream = session.messages.createStream<dynamic>('hub_events_stream');
    await for (final event in stream) {
      yield event;
    }
  }

  Future<List<HubTypeLastUpdate>> getLastChangeTimes(Session session) async {
    return HubUpdatesTracker.instance.changeTimes;
  }
}

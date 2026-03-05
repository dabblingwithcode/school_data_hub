import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class HubEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Stream<dynamic> streamHubEvents(Session session) async* {
    final stream =
        session.messages.createStream<dynamic>('hub_events_stream');
    await for (final event in stream) {
      yield event;
    }
  }
}

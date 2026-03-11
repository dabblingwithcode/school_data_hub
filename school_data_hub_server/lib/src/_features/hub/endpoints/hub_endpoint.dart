import 'package:serverpod/serverpod.dart';

class HubEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Stream<dynamic> streamHubEvents(Session session) async* {
    final stream = session.messages.createStream<dynamic>('hub_events_stream');
    await for (final event in stream) {
      yield event;
    }
  }
}

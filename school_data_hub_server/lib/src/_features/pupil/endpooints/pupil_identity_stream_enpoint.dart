import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class PupilIdentityStreamEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Stream<PupilIdentityDto> streamEncryptedPupilIds(
      Session session, String channelName) async* {
    var stream = session.messages.createStream<PupilIdentityDto>(channelName);

    // Relay messages from the stream to the client
    await for (var string in stream) {
      yield string;
    }
  }

  Future<bool> sendPupilIdentityMessage(
      Session session,
      String pupilIdentityChannel,
      PupilIdentityDto pupilIdentityMessage) async {
    // Send the new missed class to the stream
    session.messages.postMessage(
      pupilIdentityChannel,
      pupilIdentityMessage,
    );
    return true;
  }
}

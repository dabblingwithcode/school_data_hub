import 'dart:developer';

import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class PupilIdentityEndpoint extends Endpoint {
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

  Future<DateTime?> fetchLastPupilIdentitiesUpdate(Session session) async {
    // Find the last update for the user's pupil identities
    var lastUpdate = await LastPupilIdentiesUpdate.db.findFirstRow(
      session,
    );
    // If no update is found, return null
    if (lastUpdate == null) {
      return null;
    }
    // Return the date of the last update
    return lastUpdate.date;
  }

  Future<bool> updateLastPupilIdentitiesUpdate(
      Session session, DateTime date) async {
    // Create or update the last identities update record
    var lastUpdate = await LastPupilIdentiesUpdate.db.findFirstRow(
      session,
    );
    try {
      if (lastUpdate == null) {
        // Create a new record if it doesn't exist
        lastUpdate = LastPupilIdentiesUpdate(date: date);
        await LastPupilIdentiesUpdate.db.insertRow(session, lastUpdate);
      } else {
        // Update the existing record
        lastUpdate.date = date;
        await LastPupilIdentiesUpdate.db.updateRow(session, lastUpdate);
      }
      return true;
    } catch (e) {
      // Handle any errors that occur during the update
      log('Error updating last pupil identities: $e');
      return false;
    }
  }

  Future<bool> deleteLastPupilIdentitiesUpdate(Session session) async {
    final lastUpdate = await LastPupilIdentiesUpdate.db.findFirstRow(
      session,
    );
    if (lastUpdate == null) {
      return false; // No record to delete
    }
    // Delete the last identities update record
    await LastPupilIdentiesUpdate.db.deleteRow(session, lastUpdate);
    log('Last pupil identities update deleted successfully.');
    return true;
  }
}

import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class PupilBookLendingEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  //- create

  Future<PupilBookLending> postPupilBookLending(
      Session session, PupilBookLending pupilBookLending) async {
    final pupilBookLendingInDatabase =
        await PupilBookLending.db.insertRow(session, pupilBookLending);
    return pupilBookLendingInDatabase;
  }

  //- read
  Future<List<PupilBookLending>> fetchPupilBookLendings(Session session) async {
    final pupilBookLendings = await PupilBookLending.db.find(
      session,
    );
    return pupilBookLendings;
  }

  Future<PupilBookLending?> fetchPupilBookLendingById(
    Session session,
    int id,
  ) async {
    final pupilBookLending = await PupilBookLending.db.findFirstRow(
      session,
      where: (t) => t.id.equals(id),
    );
    return pupilBookLending;
  }

  //-update
  Future<PupilBookLending> updatePupilBookLending(
      Session session, PupilBookLending pupilBookLending) async {
    final updatedPupilBookLending =
        await PupilBookLending.db.updateRow(session, pupilBookLending);
    return updatedPupilBookLending;
  }

  //- delete
  Future<bool> deletePupilBookLending(Session session, int id) async {
    // Check if the pupil book lending exists
    final pupilBookLending = await PupilBookLending.db.findFirstRow(
      session,
      where: (t) => t.id.equals(id),
    );
    if (pupilBookLending == null) {
      throw Exception('Pupil book lending with id $id does not exist.');
    }
    final deleted =
        await PupilBookLending.db.deleteRow(session, pupilBookLending);
    return true;
  }
}

import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class PupilEndpoint extends Endpoint {
  Stream<List<PupilData>> getPupils(Session session) async* {
    final pupils = await PupilData.db.find(session);
    yield pupils;
  }

  Future<bool> createPupil(Session session, PupilData pupil) async {
    await session.db.insertRow(pupil);
    return true;
  }

  Future<void> updateParentInfo(
      Session session, SiblingsParentInfo parentInfo) async {
    for (final internalId in parentInfo.siblingsInternalIds) {
      final pupil = await PupilData.db.findFirstRow(
        session,
        where: (t) => t.internalId.equals(internalId),
      );
      if (pupil == null) {
        throw Exception('Pupil not found');
      }

      pupil.pupilDataParentInfo = PupilDataParentInfo(
          parentsContact: parentInfo.parentsContact,
          communicationTutor1: parentInfo.communicationTutor1,
          communicationTutor2: parentInfo.communicationTutor2,
          createdBy: parentInfo.createdBy);

      await PupilData.db.updateRow(session, pupil);
    }
  }
}

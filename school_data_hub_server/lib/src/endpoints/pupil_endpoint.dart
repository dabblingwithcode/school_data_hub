import 'dart:io';

import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class PupilEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

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

  Future<Set<PupilData>> refreshPupilDataState(
      Session session, File file) async {
    // check the extension of the file
    if (file.path.split('.').last != 'csv') {
      throw Exception('File is not a CSV file');
    }
    // Implement the logic to refresh pupil data state from the file
    // This is a placeholder implementation
    final pupils = await PupilData.db.find(session);
    return pupils.toSet();
  }
}

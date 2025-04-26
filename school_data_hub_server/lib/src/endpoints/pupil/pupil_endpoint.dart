import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class PupilEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  //- We create pupils only through the admin endpoint api
  // Future<bool> createPupil(Session session, PupilData pupil) async {
  //   await session.db.insertRow(pupil);
  //   return true;
  // }

  Stream<List<PupilData>> fetchPupilsAsStream(Session session) async* {
    final pupils = await PupilData.db.find(session);

    yield pupils;
  }

  Future<List<PupilData>> fetchPupils(Session session) async {
    final pupils = await PupilData.db.find(session);

    return pupils;
  }

  Future<List<PupilData>> fetchPupilsById(
      Session session, Set<int> internalIds) async {
    final pupils = await PupilData.db.find(session,
        where: (t) => t.internalId.inSet(internalIds),
        include: PupilData.include(
          avatar: HubDocument.include(),
        ));

    return pupils;
  }

  Future<PupilData> deleteAvatar(Session session, int internalId) async {
    final pupil = await PupilData.db.findFirstRow(
      session,
      where: (t) => t.internalId.equals(internalId),
      include: PupilData.include(
        avatar: HubDocument.include(),
      ),
    );
    if (pupil == null) {
      throw Exception('Pupil not found');
    }
    await session.storage
        .deleteFile(storageId: 'private', path: pupil.avatar!.documentPath!);
    await PupilData.db.detachRow.avatar(session, pupil);

    await HubDocument.db.deleteRow(session, pupil.avatar!);
    pupil.avatar = null;
    return pupil;
  }

  Future<PupilData> deleteAvatarAuth(Session session, int internalId) async {
    final pupil = await PupilData.db.findFirstRow(
      session,
      where: (t) => t.internalId.equals(internalId),
    );
    if (pupil == null) {
      throw Exception('Pupil not found');
    }
    session.storage.deleteFile(
        storageId: 'private', path: pupil.avatarAuth!.documentPath!);
    pupil.avatarAuth = null;
    final updatedPupil = await PupilData.db.updateRow(session, pupil);
    return updatedPupil;
  }

  Future<PupilData> resetPublicMediaAuth(
      Session session, int internalId) async {
    final pupil = await PupilData.db.findFirstRow(
      session,
      where: (t) => t.internalId.equals(internalId),
    );
    if (pupil == null) {
      throw Exception('Pupil not found');
    }
    session.storage.deleteFile(
        storageId: 'private',
        path: pupil.publicMediaAuthDocument!.documentPath!);
    pupil.publicMediaAuth = PublicMediaAuth(
        groupPicturesOnWebsite: false,
        groupPicturesInPress: false,
        portraitPicturesOnWebsite: false,
        portraitPicturesInPress: false,
        nameOnWebsite: false,
        nameInPress: false,
        videoOnWebsite: false,
        videoInPress: false);
    final updatedPupil = await PupilData.db.updateRow(session, pupil);
    return updatedPupil;
  }

  Future<PupilData> deleteSupportLevelHistoryItem(
      Session session, int internalId, int supportLevelId) async {
    final pupil = await PupilData.db.findFirstRow(
      session,
      where: (t) => t.internalId.equals(internalId),
    );
    if (pupil == null) {
      throw Exception('Pupil not found');
    }
    pupil.supportLevelHistory!
        .removeWhere((element) => element.id == supportLevelId);
    pupil.latestSupportLevel = pupil.supportLevelHistory!.last;

    final updatedPupil = await PupilData.db.updateRow(session, pupil);

    return updatedPupil;
  }
}

import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/utils/hub_document_helper.dart';
import 'package:school_data_hub_server/src/utils/schemas/pupil_schemas.dart';
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
    final pupils =
        await PupilData.db.find(session, include: PupilSchemas.allInclude);

    return pupils;
  }

  Future<List<PupilData>> fetchPupilsById(
      Session session, Set<int> internalIds) async {
    final pupils = await PupilData.db.find(
      session,
      where: (t) => t.internalId.inSet(internalIds),
      include: PupilSchemas.allInclude,
    );

    return pupils;
  }

  Future<PupilData> deleteAvatar(Session session, int internalId) async {
    final pupil = await PupilData.db.findFirstRow(
      session,
      where: (t) => t.internalId.equals(internalId),
      include: PupilSchemas.allInclude,
    );
    if (pupil == null) {
      throw Exception('Pupil not found');
    }
    await session.storage
        .deleteFile(storageId: 'private', path: pupil.avatar!.documentPath!);
    await PupilData.db.detachRow.avatar(session, pupil);

    await HubDocument.db.deleteRow(session, pupil.avatar!);
    pupil.avatar = null;
    await PupilData.db.updateRow(session, pupil);
    // get the updated pupil with the avatar removed
    final updatedPupilWithAvatar = await PupilData.db.findFirstRow(
      session,
      where: (t) => t.internalId.equals(internalId),
      include: PupilSchemas.allInclude,
    );
    return updatedPupilWithAvatar!;
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
      Session session, int pupilId, String createdBy) async {
    final pupil = await PupilData.db.findFirstRow(
      session,
      where: (t) => t.id.equals(pupilId),
      include: PupilData.include(
        publicMediaAuthDocument: HubDocument.include(),
      ),
    );
    if (pupil == null) {
      throw Exception('Pupil not found');
    }
    final publicMediaAuthReset = PublicMediaAuth(
      groupPicturesOnWebsite: false,
      groupPicturesInPress: false,
      portraitPicturesOnWebsite: false,
      portraitPicturesInPress: false,
      nameOnWebsite: false,
      nameInPress: false,
      videoOnWebsite: false,
      videoInPress: false,
      createdAt: DateTime.now(),
      createdBy: createdBy,
    );

    if (pupil.publicMediaAuthDocument != null) {
      final documentId = pupil.publicMediaAuthDocument!.documentId;
      await session.db.transaction((transaction) async {
        await PupilData.db.detachRow
            .publicMediaAuthDocument(session, pupil, transaction: transaction);

        await HubDocumentHelper.deleteHubDocumentAndFile(
            session: session, documentId: documentId, transaction: transaction);
        pupil.publicMediaAuthDocument = null;
        pupil.publicMediaAuth = publicMediaAuthReset;

        await PupilData.db.updateRow(session, pupil, transaction: transaction);
      });
    } else {
      pupil.publicMediaAuth = publicMediaAuthReset;
      await PupilData.db.updateRow(session, pupil);
    }
    final updatedPupil = await PupilData.db
        .findById(session, pupilId, include: PupilSchemas.allInclude);
    return updatedPupil!;
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

import 'package:logging/logging.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/helpers/hub_document_helper.dart';
import 'package:school_data_hub_server/src/schemas/pupil_schemas.dart';
import 'package:serverpod/serverpod.dart';

class PupilEndpoint extends Endpoint {
  final _logger = Logger('PupilEndpoint');

  @override
  bool get requireLogin => true;

  //- We create pupils only through the admin endpoint api
  // Future<bool> createPupil(Session session, PupilData pupil) async {
  //   await session.db.insertRow(pupil);
  //   return true;
  // }

  Stream<List<PupilData>> fetchPupilsAsStream(Session session) async* {
    final pupils = await PupilData.db.find(session,
        where: (t) => t.status.equals(PupilStatus.active),
        include: PupilSchemas.allInclude);

    yield pupils;
  }

  Future<List<PupilData>> fetchPupils(Session session) async {
    final pupils = await PupilData.db.find(session,
        where: (t) => t.status.equals(PupilStatus.active),
        include: PupilSchemas.allInclude);

    return pupils;
  }

  Future<List<PupilData>> fetchPupilsById(
      Session session, Set<int> internalIds) async {
    _logger.info('Fetching pupils by internal IDs');
    try {
      final pupils = await PupilData.db.find(
        session,
        where: (t) =>
            t.internalId.inSet(internalIds) &
            t.status.equals(PupilStatus.active),
        include: PupilSchemas.allInclude,
      );

      return pupils;
    } catch (e, stackTrace) {
      _logger.severe('Error fetching pupils by internal IDs: $e', stackTrace);
      throw Exception('Error fetching pupils by internal IDs: $e');
    }
  }

  Future<PupilData> deletePupilDocument(
      Session session, int pupilId, PupilDocumentType documentType) async {
    final pupil = await PupilData.db.findById(
      session,
      pupilId,
      include: PupilSchemas.allInclude,
    );
    if (pupil == null) {
      throw Exception('Pupil not found');
    }
    String path;

    switch (documentType) {
      case PupilDocumentType.avatar:
        path = pupil.avatar!.documentPath!;

        await PupilData.db.detachRow.avatar(session, pupil);

        await HubDocument.db.deleteRow(session, pupil.avatar!);
        _logger.info('Deleted avatar for pupil ${pupil.id}');
        break;
      case PupilDocumentType.avatarAuth:
        path = pupil.avatarAuth!.documentPath!;

        await PupilData.db.detachRow.avatarAuth(session, pupil);
        await HubDocument.db.deleteRow(session, pupil.avatarAuth!);
        _logger.info('Deleted avatar auth for pupil ${pupil.id}');
        // if the avatar auth is revoked, we need to delete the avatar as well
        if (pupil.avatar != null) {
          await PupilData.db.detachRow.avatar(session, pupil);
          await HubDocument.db.deleteRow(session, pupil.avatar!);
          _logger.info('Deleted avatar for pupil ${pupil.id}');
        }
        await session.storage.deleteFile(
          storageId: 'private',
          path: pupil.avatar!.documentPath!,
        );
        _logger.info('Deleted avatar auth file for pupil ${pupil.id}');
        //await PupilData.db.updateRow(session, pupil);
        break;
      case PupilDocumentType.publicMediaAuth:
        path = pupil.publicMediaAuthDocument!.documentPath!;

        await PupilData.db.detachRow.publicMediaAuthDocument(session, pupil);
        await HubDocument.db.deleteRow(session, pupil.publicMediaAuthDocument!);
        _logger.info('Deleted public media auth for pupil ${pupil.id}');
        //await PupilData.db.updateRow(session, pupil);
        break;
    }

    // Then delete the file and document
    await session.storage.deleteFile(storageId: 'private', path: path);
    _logger.info('Deleted file for pupil ${pupil.id}');
    // await HubDocument.db.deleteRow(session, documentToDelete!);

    // Get the updated pupil
    final updatedPupil = await PupilData.db.findById(
      session,
      pupilId,
      include: PupilSchemas.allInclude,
    );
    return updatedPupil!;
  }

  // Future<PupilData> deleteAvatarAuth(Session session, int internalId) async {
  //   final pupil = await PupilData.db.findFirstRow(
  //     session,
  //     where: (t) => t.internalId.equals(internalId),
  //   );
  //   if (pupil == null) {
  //     throw Exception('Pupil not found');
  //   }
  //   session.storage.deleteFile(
  //       storageId: 'private', path: pupil.avatarAuth!.documentPath!);
  //   pupil.avatarAuth = null;
  //   final updatedPupil = await PupilData.db.updateRow(session, pupil);
  //   return updatedPupil;
  // }

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
      createdAt: DateTime.now().toUtc(),
      createdBy: createdBy,
    );

    if (pupil.publicMediaAuthDocument != null) {
      final documentId = pupil.publicMediaAuthDocument!.documentId;
      await session.db.transaction((transaction) async {
        await PupilData.db.detachRow
            .publicMediaAuthDocument(session, pupil, transaction: transaction);
        await HubDocumentHelper().deleteHubDocumentAndFile(
            session: session, documentId: documentId, transaction: transaction);
      });
    }
    final releasedPupil = await PupilData.db.findFirstRow(
      session,
      where: (t) => t.id.equals(pupilId),
      include: PupilData.include(
        publicMediaAuthDocument: HubDocument.include(),
      ),
    );
    // pupil.publicMediaAuthDocument = null;
    // pupil.publicMediaAuthDocumentId = null;
    releasedPupil!.publicMediaAuth = publicMediaAuthReset;
    await PupilData.db.updateRow(session, releasedPupil);
    final updatedPupil = await PupilData.db
        .findById(session, pupilId, include: PupilSchemas.allInclude);
    return updatedPupil!;
  }

  Future<PupilData> deleteSupportLevelHistoryItem(
      Session session, int pupilId, int supportLevelId) async {
    final pupil = await PupilData.db
        .findById(session, pupilId, include: PupilSchemas.allInclude);
    if (pupil == null) {
      throw Exception('Pupil not found');
    }
    var supportLevel = await SupportLevel.db.findById(session, supportLevelId);
    if (supportLevel != null) {
      await SupportLevel.db.deleteRow(session, supportLevel);
    }

    //  PupilData.db.updateRow(session, pupil);

    // fetch the updated pupil with the support level history
    final updatedPupilWithHistory = await PupilData.db.findById(
      session,
      pupilId,
      include: PupilSchemas.allInclude,
    );
    return updatedPupilWithHistory!;
  }
}

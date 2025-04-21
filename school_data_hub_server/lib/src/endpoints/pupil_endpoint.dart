import 'dart:typed_data';

import 'package:logging/logging.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/utils/get_user_name.dart';
import 'package:school_data_hub_server/src/utils/hub_document_helper.dart';
import 'package:serverpod/serverpod.dart';

final _log = Logger('PupilEndpoint');

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

  Future<List<PupilData>> updateSiblingsTutorInfo(
      Session session, SiblingsTutorInfo siblingsTutorInfo) async {
    final List<PupilData> updatedSiblings = [];
    for (final internalId in siblingsTutorInfo.siblingsInternalIds) {
      final pupil = await PupilData.db.findFirstRow(
        session,
        where: (t) => t.internalId.equals(internalId),
      );
      if (pupil == null) {
        throw Exception('Pupil not found');
      }
      pupil.tutorInfo = siblingsTutorInfo.tutorInfo;
      updatedSiblings.add(pupil);

      // await PupilData.db.updateRow(session, pupil);
    }
    final writtenSiblings = await PupilData.db.update(session, updatedSiblings);

    return writtenSiblings;
  }

  Future<PupilData> updatePupil(Session session, PupilData pupil) async {
    final updatedPupil = await PupilData.db.updateRow(session, pupil);
    return updatedPupil;
  }

  Future<PupilData> updatePupilAvatar(
      Session session, int pupilId, String path) async {
    final createdBy = await getUserName(session);
    final hubDocument = await HubDocumentHelper.createHubDocumentObject(
        session: session, createdBy: createdBy!, path: path);

    // Save the document to the database
    final hubDocumentInDatabase =
        await HubDocument.db.insertRow(session, hubDocument);
    // find the pupil by id
    final pupil = await PupilData.db.findById(
      session,
      pupilId,
    );
    if (pupil == null) {
      throw Exception('Pupil not found');
    }
    _log.info('Pupil found: ${pupil.toJson()}');
    // if the pupil has an avatar, delete it
    if (pupil.avatar != null) {
      _log.info('Deleting old avatar document: ${pupil.avatar!.documentId}');
      // delete the old avatar document from the storage
      final success = await HubDocumentHelper.deleteHubDocument(
        session: session,
        documentId: pupil.avatar!.documentId,
      );
      // TODO: Handle exception gracefully here
      if (!success) {
        throw Exception('Failed to delete old avatar document');
      }
      await HubDocument.db.deleteRow(session, pupil.avatar!);
    }
    // update the pupil with the new avatar
    _log.info(
        'Updating pupil avatar: id: [${hubDocumentInDatabase.id}]documentID [${hubDocumentInDatabase.documentId}]');
    // pupil.avatar = hubDocument;
    await PupilData.db.attachRow.avatar(session, pupil, hubDocumentInDatabase);
    final updatedPupil = await PupilData.db.findById(session, pupil.id!,
        include: PupilData.include(
          avatar: HubDocument.include(),
        ));

    _log.info('Updated pupil : ${updatedPupil!.toJson()}');
    return updatedPupil;
  }

  Future<PupilData> updatePupilAvatarAuth(Session session, int pupilId,
      ByteData avatarAuthBytes, String path) async {
    final createdBy = await getUserName(session);
    final hubDocument = await HubDocumentHelper.createHubDocumentObject(
      session: session,
      createdBy: createdBy!,
      path: path,
    ); // find the pupil by id
    final pupil = await PupilData.db.findFirstRow(
      session,
      where: (t) => t.id.equals(pupilId),
    );
    if (pupil == null) {
      throw Exception('Pupil not found');
    }
    // if the pupil has an avatar auth, delete it
    if (pupil.avatarAuth != null) {
      final success = await HubDocumentHelper.deleteHubDocument(
        session: session,
        documentId: pupil.avatarAuth!.documentId,
      );
      // TODO: Handle exception gracefully here
      if (!success) {
        throw Exception('Failed to delete old avatar document');
      }
      HubDocument.db.deleteRow(session, pupil.avatarAuth!);
    }
    // update the pupil with the new avatar auth
    HubDocument.db.updateRow(session, hubDocument);
    pupil.avatarAuth = hubDocument;
    final updatedPupil = await PupilData.db.updateRow(session, pupil);
    return updatedPupil;
  }

  Future<PupilData> updatePupilWithPublicMediaAuth(Session session, int pupilId,
      ByteData publicMediaAuthFBytes, String path) async {
    final createdBy = await getUserName(session);

    final hubDocument = await HubDocumentHelper.createHubDocumentObject(
        session: session, createdBy: createdBy!, path: path);

    final pupil = await PupilData.db.findFirstRow(
      session,
      where: (t) => t.id.equals(pupilId),
    );
    if (pupil == null) {
      throw Exception('Pupil not found');
    }
    // if the pupil has an public media auth document, delete it
    if (pupil.publicMediaAuthDocument != null) {
      final success = await HubDocumentHelper.deleteHubDocument(
        session: session,
        documentId: pupil.publicMediaAuthDocument!.documentId,
      );
      // TODO: Handle exception gracefully here
      if (!success) {
        throw Exception('Failed to delete old avatar document');
      }
      HubDocument.db.deleteRow(session, pupil.publicMediaAuthDocument!);
    }
    // update the pupil with the new avatar
    HubDocument.db.updateRow(session, hubDocument);
    pupil.publicMediaAuthDocument = hubDocument;
    final updatedPupil = await PupilData.db.updateRow(session, pupil);
    return updatedPupil;
  }

  Future<PupilData> deleteAvatar(Session session, int internalId) async {
    final pupil = await PupilData.db.findFirstRow(
      session,
      where: (t) => t.internalId.equals(internalId),
    );
    if (pupil == null) {
      throw Exception('Pupil not found');
    }
    session.storage
        .deleteFile(storageId: 'private', path: pupil.avatar!.documentPath!);

    pupil.avatar = null;
    final updatedPupil = await PupilData.db.updateRow(session, pupil);
    return updatedPupil;
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

  Future<PupilData> updateSupportLevel(
      Session session, SupportLevel supportLevel) async {
    final pupil =
        await PupilData.db.findById(session, supportLevel.pupilId!.id!);

    if (pupil == null) {
      throw Exception('Pupil not found');
    }
    pupil.latestSupportLevel = supportLevel;
    pupil.supportLevelHistory ??= <SupportLevel>[];
    pupil.supportLevelHistory!.add(supportLevel);
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

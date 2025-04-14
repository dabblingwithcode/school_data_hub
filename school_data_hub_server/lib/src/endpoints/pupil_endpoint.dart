import 'dart:typed_data';

import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/utils/get_user_name.dart';
import 'package:school_data_hub_server/src/utils/save_hub_document.dart';
import 'package:serverpod/serverpod.dart';

class PupilEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

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
    final pupils = await PupilData.db.find(
      session,
      where: (t) => t.internalId.inSet(internalIds),
    );

    return pupils;
  }

  Future<bool> createPupil(Session session, PupilData pupil) async {
    await session.db.insertRow(pupil);
    return true;
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

  Future<PupilData> updatePupilProperty(
      Session session, int internalId, String property, dynamic value) async {
    final pupil = await PupilData.db.findFirstRow(
      session,
      where: (t) => t.internalId.equals(internalId),
    );
    if (pupil == null) {
      throw Exception('Pupil not found');
    }
    // Update the property dynamically
    switch (property) {
      case 'active':
        pupil.active = value;
        break;
      case 'preSchoolMedical':
        pupil.preSchoolMedical = value;
        break;
      case 'kindergarden':
        pupil.kindergarden = value;
        break;
      case 'preSchoolTest':
        pupil.preSchoolTest = value;
        break;
      case 'avatar':
        pupil.avatar = value;
        break;
      case 'avatarAuth':
        pupil.avatarAuth = value;
        break;
      case 'publicMediaAuth':
        pupil.publicMediaAuth = value;
        break;
      case 'publicMediaAuthDocument':
        pupil.publicMediaAuthDocument = value;
        break;
      case 'contact':
        pupil.contact = value;
        break;
      case 'communicationPupil':
        pupil.communicationPupil = value;
        break;
      case 'speacialInformation':
        pupil.specialInformation = value;
        break;
      case 'tutorInfo':
        pupil.tutorInfo = value;
        break;
      case 'afterSchoolCare':
        pupil.afterSchoolCare = value;
        break;
      case 'credit':
        pupil.credit = value;
      case 'creditEarned':
        pupil.creditEarned = value;
        break;
      case 'schoolyearHeldBackAt':
        pupil.schoolyearHeldBackAt = value;
        break;
      case 'latestSupportLevel':
        pupil.latestSupportLevel = value;
        break;
      case 'swimmer':
        pupil.swimmer = value;
        break;

      default:
        throw Exception('Invalid property name: $property');
    }
    final updatedPupil = await PupilData.db.updateRow(session, pupil);
    return updatedPupil;
  }

  Future<PupilData> updatePupilAvatar(
      Session session, int internalId, ByteData avatarByteData) async {
    final createdBy = await getUserName(session);
    final hubDocument = createHubDocument(
      session: session,
      createdBy: createdBy!,
      fileData: avatarByteData,
    );

    return updatePupilProperty(
      session,
      internalId,
      'avatar',
      hubDocument,
    );
  }

  Future<PupilData> updatePupilAvatarAuth(
      Session session, int internalId, ByteData avatarAuthBytes) async {
    final createdBy = await getUserName(session);
    final hubDocument = await createHubDocument(
      session: session,
      createdBy: createdBy!,
      fileData: avatarAuthBytes,
    );

    return updatePupilProperty(
      session,
      internalId,
      'avatarAuth',
      hubDocument,
    );
  }

  Future<PupilData> updatePupilWithPublicMediaAuth(
      Session session, int internalId, ByteData publicMediaAuthFBytes) async {
    final createdBy = await getUserName(session);
    final documentId = Uuid().v4();
    final hubDocument = createHubDocument(
        session: session,
        createdBy: createdBy!,
        fileData: publicMediaAuthFBytes);

    return updatePupilProperty(
      session,
      internalId,
      'publicMediaAuth',
      hubDocument,
    );
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

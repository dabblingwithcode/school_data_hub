import 'dart:typed_data';

import 'package:logging/logging.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/utils/get_user_name.dart';
import 'package:school_data_hub_server/src/utils/hub_document_helper.dart';
import 'package:serverpod/serverpod.dart';

final _log = Logger('PupilUpdateEndpoint');

class PupilUpdateEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<PupilData> updateTutorInfo(
      Session session, int pupilId, TutorInfo tutorInfo) async {
    final pupil = await PupilData.db.findById(session, pupilId);
    if (pupil == null) {
      throw Exception('Pupil not found');
    }
    pupil.tutorInfo = tutorInfo;
    // Update the pupil in the database
    final updatedPupil = await PupilData.db.updateRow(session, pupil);
    return updatedPupil;
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
      Session session, int pupilId, String filePath) async {
    // find the createdBy user
    // TODO: Send username as a parameter to the endpoint
    final createdBy = await getUserName(session);

    // find the pupil by id
    final pupil = await PupilData.db.findById(
      session,
      pupilId,
      include: PupilData.include(
        avatar: HubDocument.include(),
      ),
    );
    if (pupil == null) {
      throw Exception('Pupil not found');
    }

    // Create a HubDocument with the file path
    final documentId = Uuid().v4();
    final hubDocument = HubDocument(
      documentId: documentId,
      documentPath: filePath,
      createdBy: createdBy!,
      createdAt: DateTime.now(),
    );

    // Let's create a transaction for the database operations
    // This is important to ensure that all operations are atomic
    await session.db.transaction((transaction) async {
      // Save the hub document object to the database
      final hubDocumentInDatabase = await HubDocument.db
          .insertRow(session, hubDocument, transaction: transaction);

      // if the pupil has an avatar, delete it
      if (pupil.avatar != null) {
        _log.warning(
            'Deleting old avatar document: ${pupil.avatar!.documentId}');
        // delete the old avatar file from the storage
        session.storage.deleteFile(
            storageId: 'private', path: pupil.avatar!.documentPath!);
        // detach the old avatar from the pupil
        await PupilData.db.detachRow
            .avatar(session, pupil, transaction: transaction);
        // delete the old avatar document from the database
        await HubDocument.db
            .deleteRow(session, pupil.avatar!, transaction: transaction);
        // TODO: Consider exceptions and handle them gracefully here
      }
      // update the pupil with the new avatar
      _log.info(
          'Updating pupil avatar: id: [${hubDocumentInDatabase.id}] documentID [${hubDocumentInDatabase.documentId}]');
      // pupil.avatar = hubDocument;
      await PupilData.db.attachRow.avatar(session, pupil, hubDocumentInDatabase,
          transaction: transaction);
    });

    final updatedPupil = await PupilData.db.findById(session, pupil.id!,
        include: PupilData.include(
          avatar: HubDocument.include(),
        ));

    _log.fine('Updated pupil : ${updatedPupil!.toJson()}');
    return updatedPupil;
  }

  Future<PupilData> updateStringProperty(
      Session session, int pupilId, String property, String? value) async {
    final pupil = await PupilData.db.findById(session, pupilId);
    if (pupil == null) {
      throw Exception('Pupil not found');
    }
    switch (property) {
      case 'kindergarden':
        pupil.kindergarden = value;
        break;
      case 'contact':
        pupil.contact = value;
        break;
      case 'specialInformation':
        pupil.specialInformation = value;
        break;
      case 'swimmer':
        pupil.swimmer = value;
        break;
      default:
        throw Exception('Invalid property name');
    }
    await session.db.updateRow(pupil);
    // Fetch the object again with the relation included
    final updatedPupil = await PupilData.db.findById(
      session,
      pupil.id!,
    );
    return updatedPupil!;
  }

  Future<PupilData> updateCredit(
      Session session, int pupilId, int value, String? description) async {
    final pupil = await PupilData.db.findById(session, pupilId);
    if (pupil == null) {
      throw Exception('Pupil not found');
    }
    final userName = await getUserName(session);
    final creditTransactionToAdd = CreditTransaction(
      sender: userName!,
      receiver: pupil.id!,
      amount: value,
      dateTime: DateTime.now(),
      description: description,
    );
    // Save the credit transaction to the database
    final creditTransaction =
        await CreditTransaction.db.insertRow(session, creditTransactionToAdd);
    // Update the pupil's credit balance
    PupilData.db.attachRow
        .creditTransactions(session, pupil, creditTransaction);

    pupil.credit += value;
    if (value > 0) {
      pupil.creditEarned += value;
    }
    // Update the pupil in the database
    await PupilData.db.updateRow(session, pupil);
    // Fetch the object again with the relation included
    final updatedPupil = await PupilData.db.findById(
      session,
      pupil.id!,
      include: PupilData.include(
        creditTransactions: CreditTransaction.includeList(),
      ),
    );
    return updatedPupil!;
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
}

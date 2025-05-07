import 'package:logging/logging.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/utils/hub_document_helper.dart';
import 'package:school_data_hub_server/src/utils/schemas/pupil_schemas.dart';
import 'package:serverpod/serverpod.dart';

final _log = Logger('PupilUpdateEndpoint');

class PupilUpdateEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<PupilData> updatePupil(Session session, PupilData pupil) async {
    final updatedPupil = await PupilData.db.updateRow(session, pupil);
    return updatedPupil;
  }

  Future<PupilData> updateCommunicationSkills(Session session,
      {required int pupilId,
      required CommunicationSkills? communicationSkills}) async {
    final pupil = await PupilData.db.findById(session, pupilId);
    if (pupil == null) {
      throw Exception('Pupil not found');
    }
    pupil.communicationPupil = communicationSkills;

    // Update the pupil in the database
    await PupilData.db.updateRow(session, pupil);
    // Fetch the object again with the relation included
    final updatedPupilWithRelation = await PupilData.db.findById(
      session,
      pupil.id!,
      include: PupilSchemas.allInclude,
    );
    return updatedPupilWithRelation!;
  }

  Future<PupilData> updateTutorInfo(
      Session session, int pupilId, TutorInfo? tutorInfo) async {
    final pupil = await PupilData.db.findById(session, pupilId);
    if (pupil == null) {
      throw Exception('Pupil not found');
    }
    pupil.tutorInfo = tutorInfo;
    // Update the pupil in the database
    await PupilData.db.updateRow(session, pupil);
    // Fetch the object again with the relation included
    final updatedPupilWithRelation = await PupilData.db.findById(
      session,
      pupil.id!,
      include: PupilSchemas.allInclude,
    );

    return updatedPupilWithRelation!;
  }

  Future<List<PupilData>> updateSiblingsTutorInfo(
      Session session, SiblingsTutorInfo siblingsTutorInfo) async {
    final List<PupilData> updatedSiblings = [];
    for (final pupilId in siblingsTutorInfo.siblingsIds) {
      final pupil = await PupilData.db.findById(
        session,
        pupilId,
      );
      if (pupil == null) {
        throw Exception('Pupil not found');
      }
      pupil.tutorInfo = siblingsTutorInfo.tutorInfo;
      updatedSiblings.add(pupil);

      // await PupilData.db.updateRow(session, pupil);
    }
    await PupilData.db.update(session, updatedSiblings);
    // Fetch the object again with the relation included
    final updatedSiblingsWithRelation = await PupilData.db.find(
      session,
      where: (t) => t.id.inSet(siblingsTutorInfo.siblingsIds),
      include: PupilSchemas.allInclude,
    );
    return updatedSiblingsWithRelation;
  }

  Future<PupilData> updatePupilDocument(Session session, int pupilId,
      String filePath, String createdBy, PupilDocumentType documentType) async {
    // find the createdBy user

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
    final newHubDocument = HubDocumentHelper.createHubDocumentObject(
        session: session, createdBy: createdBy, path: filePath);

    // Let's create a transaction for the database operations
    // This is important to ensure that all operations are atomic
    await session.db.transaction((transaction) async {
      // Save the hub document object to the database
      final hubDocumentInDatabase = await HubDocument.db
          .insertRow(session, newHubDocument, transaction: transaction);

      switch (documentType) {
        case PupilDocumentType.avatar:
          _log.info(
              'Updating pupil avatar: id: [${hubDocumentInDatabase.id}] documentID [${hubDocumentInDatabase.documentId}]');

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

            // TODO: Consider exceptions and handle them
          }

          // update the pupil with the new avatar

          await PupilData.db.attachRow.avatar(
              session, pupil, hubDocumentInDatabase,
              transaction: transaction);
          break;

        case PupilDocumentType.avatarAuth:
          _log.info(
              'Updating pupil avatarAuth: id: [${hubDocumentInDatabase.id}] documentID [${hubDocumentInDatabase.documentId}]');

          // if the pupil has an avatar auth, delete it

          if (pupil.avatarAuth != null) {
            _log.warning(
                'Deleting old avatar auth document: ${pupil.avatar!.documentId}');

            // delete the old avatar file from the storage
            session.storage.deleteFile(
                storageId: 'private', path: pupil.avatarAuth!.documentPath!);

            // detach the old avatar auth from the pupil
            await PupilData.db.detachRow
                .avatarAuth(session, pupil, transaction: transaction);

            // delete the old avatar auth document from the database
            await HubDocument.db.deleteRow(session, pupil.avatarAuth!,
                transaction: transaction);

            // TODO: Consider exceptions and handle them
          }

          // update the pupil with the new avatar

          await PupilData.db.attachRow.avatarAuth(
              session, pupil, hubDocumentInDatabase,
              transaction: transaction);

          break;

        case PupilDocumentType.publicMediaAuth:
          _log.info(
              'Updating pupil public media auth: id: [${hubDocumentInDatabase.id}] documentID [${hubDocumentInDatabase.documentId}]');

          // if the pupil has a public media auth, delete it
          if (pupil.publicMediaAuthDocument != null) {
            _log.warning(
                'Deleting old public media auth document: ${pupil.publicMediaAuthDocument!.documentId}');

            // delete the old public media auth document file from the storage
            session.storage.deleteFile(
                storageId: 'private',
                path: pupil.publicMediaAuthDocument!.documentPath!);

            // detach the old public media auth document from the pupil
            await PupilData.db.detachRow.publicMediaAuthDocument(session, pupil,
                transaction: transaction);

            // delete the old avatar document from the database
            await HubDocument.db.deleteRow(
                session, pupil.publicMediaAuthDocument!,
                transaction: transaction);

            // TODO: Consider exceptions and handle them
          }

          // update the pupil with the new publi media a
          _log.info(
              'Updating pupil public media auth with id: [${hubDocumentInDatabase.id}] documentID [${hubDocumentInDatabase.documentId}]');

          await PupilData.db.attachRow.publicMediaAuthDocument(
              session, pupil, hubDocumentInDatabase,
              transaction: transaction);

          break;
      }
    });

    final updatedPupil = await PupilData.db
        .findById(session, pupil.id!, include: PupilSchemas.allInclude);

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
      include: PupilSchemas.allInclude,
    );
    return updatedPupil!;
  }

  Future<PupilData> updateCredit(Session session, int pupilId, int value,
      String? description, String sender) async {
    final pupil = await PupilData.db.findById(session, pupilId);
    if (pupil == null) {
      throw Exception('Pupil not found');
    }

    final creditTransactionToAdd = CreditTransaction(
      sender: sender,
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
      include: PupilSchemas.allInclude,
    );
    return updatedPupil!;
  }

  Future<PupilData> updatePreSchoolMedicalStatus(
    Session session,
    int pupilId,
    PreSchoolMedicalStatus preSchoolMedicalStatus,
    String updatedBy,
  ) async {
    final pupil = await PupilData.db
        .findById(session, pupilId, include: PupilSchemas.allInclude);
    if (pupil == null) {
      throw Exception('Pupil not found');
    }
    // TODO: preschoolmedical should never be null, so this should be removed
    if (pupil.preSchoolMedical == null) {
      final preSchoolMedicalInDatabase = await PreSchoolMedical.db.insertRow(
          session,
          PreSchoolMedical(
            preschoolMedicalStatus: preSchoolMedicalStatus,
            createdBy: updatedBy,
            createdAt: DateTime.now().toUtc(),
          ));

      await PupilData.db.attachRow
          .preSchoolMedical(session, pupil, preSchoolMedicalInDatabase);
    } else {
      final updatedPreSchoolMedicalStatus = pupil.preSchoolMedical!.copyWith(
        preschoolMedicalStatus: preSchoolMedicalStatus,
        updatedBy: updatedBy,
        updatedAt: DateTime.now().toUtc(),
      );
      await PreSchoolMedical.db
          .updateRow(session, updatedPreSchoolMedicalStatus);
    }

    final updatedPupil = await PupilData.db.findById(
      session,
      pupil.id!,
      include: PupilSchemas.allInclude,
    );
    return updatedPupil!;
  }

  Future<PupilData> updatePublicMediaAuth(
      Session session, int pupilId, PublicMediaAuth publicMediaAuth) async {
    final pupil = await PupilData.db.findById(session, pupilId);

    if (pupil == null) {
      throw Exception('Pupil not found');
    }
    pupil.publicMediaAuth = publicMediaAuth;
    await PupilData.db.updateRow(session, pupil);
    // Fetch the object again with the relation included
    final updatedPupilWithRelation = await PupilData.db.findById(
      session,
      pupil.id!,
      include: PupilSchemas.allInclude,
    );
    return updatedPupilWithRelation!;
  }

  Future<PupilData> updateSupportLevel(
      Session session, SupportLevel supportLevel, int pupilId) async {
    final pupil = await PupilData.db.findById(session, pupilId);

    if (pupil == null) {
      throw Exception('Pupil not found');
    }

    final supportLevelInDatabase =
        await SupportLevel.db.insertRow(session, supportLevel);
    // Update the pupil's credit balance
    PupilData.db.attachRow
        .supportLevelHistory(session, pupil, supportLevelInDatabase);

    // await PupilData.db.updateRow(session, pupil);
    // Fetch the object again with the relation included
    final updatedPupilWithRelation = await PupilData.db.findById(
      session,
      pupil.id!,
      include: PupilSchemas.allInclude,
    );
    return updatedPupilWithRelation!;
  }
}

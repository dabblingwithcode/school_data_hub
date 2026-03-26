import 'package:logging/logging.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/helpers/hub_document_helper.dart';
import 'package:school_data_hub_server/src/_features/pupil/schemas/pupil_schemas.dart';
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

  /// Lightweight fetch for startup — returns only avatar + support level
  /// relations. Use fetchPupilsById for full detail on individual pupils.
  Future<List<PupilData>> fetchPupilsList(
      Session session, Set<int> internalIds) async {
    _logger.info('Fetching pupils list (lightweight) for ${internalIds.length} IDs');
    final pupils = await PupilData.db.find(
      session,
      where: (t) =>
          t.internalId.inSet(internalIds) &
          t.status.equals(PupilStatus.active),
      include: PupilSchemas.listInclude,
    );
    return pupils;
  }

  // ── Domain-scoped fetch endpoints ──

  /// Fetch communication data for a pupil (contact, tutorInfo, etc.).
  Future<PupilCommunicationData?> fetchPupilCommunicationData(
      Session session, int pupilId) async {
    final pupil = await PupilData.db.findById(session, pupilId,
        include: PupilData.include(
            communicationData: PupilCommunicationData.include()));
    return pupil?.communicationData;
  }

  /// Fetch preschool data for a pupil (kindergarden, medical, test).
  Future<PupilPreschoolData?> fetchPupilPreschoolData(
      Session session, int pupilId) async {
    final pupil = await PupilData.db.findById(session, pupilId,
        include: PupilData.include(
            preschoolData: PupilSchemas.preschoolSubInclude));
    return pupil?.preschoolData;
  }

  /// Fetch media data for a pupil (avatar, auth, publicMediaAuth).
  Future<PupilMediaData?> fetchPupilMediaData(
      Session session, int pupilId) async {
    final pupil = await PupilData.db.findById(session, pupilId,
        include: PupilData.include(
            mediaData: PupilSchemas.mediaSubInclude));
    return pupil?.mediaData;
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

    try {
      await session.db.transaction((transaction) async {
        switch (documentType) {
          case PupilDocumentType.avatar:
            if (pupil.avatar == null) {
              throw Exception('Avatar not found for pupil');
            }

            final avatarPath = pupil.avatar!.documentPath;
            if (avatarPath != null) {
              await session.storage
                  .deleteFile(storageId: 'private', path: avatarPath);
            }

            await PupilData.db.detachRow
                .avatar(session, pupil, transaction: transaction);
            await HubDocument.db
                .deleteRow(session, pupil.avatar!, transaction: transaction);
            _logger.info('Deleted avatar for pupil ${pupil.id}');
            break;

          case PupilDocumentType.avatarAuth:
            if (pupil.avatarAuth == null) {
              throw Exception('Avatar auth not found for pupil');
            }

            final avatarAuthPath = pupil.avatarAuth!.documentPath;
            if (avatarAuthPath != null) {
              await session.storage
                  .deleteFile(storageId: 'private', path: avatarAuthPath);
            }

            await PupilData.db.detachRow
                .avatarAuth(session, pupil, transaction: transaction);
            await HubDocument.db.deleteRow(session, pupil.avatarAuth!,
                transaction: transaction);
            _logger.info('Deleted avatar auth for pupil ${pupil.id}');

            // If the avatar auth is revoked, delete the avatar as well
            if (pupil.avatar != null) {
              final avatarPath = pupil.avatar!.documentPath;
              if (avatarPath != null) {
                await session.storage
                    .deleteFile(storageId: 'private', path: avatarPath);
              }
              await PupilData.db.detachRow
                  .avatar(session, pupil, transaction: transaction);
              await HubDocument.db
                  .deleteRow(session, pupil.avatar!, transaction: transaction);
              _logger.info('Deleted avatar for pupil ${pupil.id}');
            }
            break;

          case PupilDocumentType.publicMediaAuth:
            if (pupil.publicMediaAuthDocument == null) {
              throw Exception('Public media auth document not found for pupil');
            }

            final publicMediaPath = pupil.publicMediaAuthDocument!.documentPath;
            if (publicMediaPath != null) {
              await session.storage
                  .deleteFile(storageId: 'private', path: publicMediaPath);
            }

            await PupilData.db.detachRow.publicMediaAuthDocument(session, pupil,
                transaction: transaction);
            await HubDocument.db.deleteRow(
                session, pupil.publicMediaAuthDocument!,
                transaction: transaction);
            _logger.info('Deleted public media auth for pupil ${pupil.id}');
            break;
        }
      });

      // Get the updated pupil
      final updatedPupil = await PupilData.db.findById(
        session,
        pupilId,
        include: PupilSchemas.allInclude,
      );

      if (updatedPupil == null) {
        throw Exception('Failed to retrieve updated pupil data');
      }

      return updatedPupil;
    } catch (e) {
      _logger.severe('Error deleting pupil document: $e');
      rethrow;
    }
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

    await session.db.transaction((transaction) async {
      if (pupil.publicMediaAuthDocument != null) {
        final documentId = pupil.publicMediaAuthDocument!.documentId;
        await PupilData.db.detachRow
            .publicMediaAuthDocument(session, pupil, transaction: transaction);
        await HubDocumentHelper().deleteHubDocumentAndFile(
            session: session, documentId: documentId, transaction: transaction);
      }
      final releasedPupil = await PupilData.db.findFirstRow(
        session,
        where: (t) => t.id.equals(pupilId),
        include: PupilData.include(
          publicMediaAuthDocument: HubDocument.include(),
        ),
        transaction: transaction,
      );
      releasedPupil!.publicMediaAuth = publicMediaAuthReset;
      await PupilData.db
          .updateRow(session, releasedPupil, transaction: transaction);
    });
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

  Future<bool> bulkAddSupportLevels(
      Session session, List<SupportLevelLegacyDto> supportLevelData) async {
    _logger
        .info('Bulk adding support levels: ${supportLevelData.length} items');

    if (supportLevelData.isEmpty) {
      _logger.warning('No support level data provided');
      return false;
    }

    try {
      final List<SupportLevel> createdSupportLevels = [];
      int skippedCount = 0;

      // Use transaction for data consistency
      await session.db.transaction((transaction) async {
        // Process each support level entry
        for (final data in supportLevelData) {
          // Find the pupil by internalId
          final pupil = await PupilData.db.findFirstRow(
            session,
            where: (t) => t.internalId.equals(data.pupilId),
          );

          if (pupil == null) {
            _logger.warning('Pupil not found for internalId: ${data.pupilId}');
            skippedCount++;
            continue;
          }

          // Create the support level
          final supportLevel = SupportLevel(
            level: data.level,
            comment: data.comment ?? '',
            createdAt: data.createdAt!.toUtc(),
            createdBy: data.createdBy ?? 'ADM',
            pupilId: pupil.id!,
            pupil: pupil,
          );

          // Insert the support level
          final createdSupportLevel =
              await SupportLevel.db.insertRow(session, supportLevel);
          createdSupportLevels.add(createdSupportLevel);

          _logger.info(
              'Created support level for pupil ${pupil.id} (internalId: ${pupil.internalId})');
        }
      });

      _logger.info(
          'Successfully created ${createdSupportLevels.length} support levels, skipped $skippedCount entries');
      return true;
    } catch (e, stackTrace) {
      _logger.severe('Error bulk adding support levels: $e', stackTrace);
      throw Exception('Error bulk adding support levels: $e');
    }
  }
}

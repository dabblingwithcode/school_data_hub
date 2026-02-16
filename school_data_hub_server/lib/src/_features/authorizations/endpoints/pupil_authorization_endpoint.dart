import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/helpers/hub_document_helper.dart';
import 'package:serverpod/serverpod.dart';

class PupilAuthorizationEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<PupilAuthorization> updatePupilAuthorization(
    Session session,
    PupilAuthorization authorization,
  ) async {
    final updatedPupilAuth =
        await PupilAuthorization.db.updateRow(session, authorization);
    final authWithInclude = await PupilAuthorization.db.findById(
      session,
      updatedPupilAuth.id!,
      include: PupilAuthorization.include(
        file: HubDocument.include(),
      ),
    );
    return authWithInclude!;
  }

  Future<PupilAuthorization> addFileToPupilAuthorization(
    Session session,
    int pupilAuthId,
    String filePath,
    String createdBy,
  ) async {
    final pupilAuth = await PupilAuthorization.db.findById(
      session,
      pupilAuthId,
      include: PupilAuthorization.include(
        file: HubDocument.include(),
      ),
    );
    if (pupilAuth == null) {
      throw Exception('PupilAuthorization not found');
    }
    final document = HubDocumentHelper().createHubDocumentObject(
      session: session,
      createdBy: createdBy,
      path: filePath,
    );
    return await session.db.transaction((transaction) async {
      final documentInDatabase = await HubDocument.db.insertRow(
        session,
        document,
        transaction: transaction,
      );
      final updatedPupilAuth = pupilAuth.copyWith(
        fileId: documentInDatabase.id,
      );
      await PupilAuthorization.db
          .updateRow(session, updatedPupilAuth, transaction: transaction);
      final authWithInclude = await PupilAuthorization.db.findById(
        session,
        updatedPupilAuth.id!,
        include: PupilAuthorization.include(
          file: HubDocument.include(),
        ),
        transaction: transaction,
      );
      return authWithInclude!;
    });
  }

  Future<PupilAuthorization> removeFileFromPupilAuthorization(
    Session session,
    int pupilAuthId,
  ) async {
    final pupilAuth = await PupilAuthorization.db.findById(
      session,
      pupilAuthId,
      include: PupilAuthorization.include(
        file: HubDocument.include(),
      ),
    );
    if (pupilAuth == null) {
      throw Exception('PupilAuthorization not found');
    }

    await session.db.transaction((transaction) async {
      // detach the file from the pupil authorization
      await PupilAuthorization.db.detachRow
          .file(session, pupilAuth, transaction: transaction);
      // delete the file from the database
      await HubDocument.db
          .deleteRow(session, pupilAuth.file!, transaction: transaction);
      // delete the file from the storage
      await session.storage.deleteFile(
        storageId: 'private',
        path: pupilAuth.file!.documentPath!,
      );
    });
    final authWithInclude = await PupilAuthorization.db.findById(
      session,
      pupilAuth.id!,
      include: PupilAuthorization.include(
        file: HubDocument.include(),
      ),
    );
    return authWithInclude!;
  }
}

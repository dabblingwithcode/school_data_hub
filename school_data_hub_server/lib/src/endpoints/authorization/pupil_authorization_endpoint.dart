import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/utils/hub_document_helper.dart';
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
    final document = HubDocumentHelper.createHubDocumentObject(
      session: session,
      createdBy: createdBy,
      path: filePath,
    );
    final documentInDatabase = await HubDocument.db.insertRow(
      session,
      document,
    );
    final updatedPupilAuth = pupilAuth.copyWith(
      fileId: documentInDatabase.id,
    );
    await PupilAuthorization.db.updateRow(session, updatedPupilAuth);
    final authWithInclude = await PupilAuthorization.db.findById(
      session,
      updatedPupilAuth.id!,
      include: PupilAuthorization.include(
        file: HubDocument.include(),
      ),
    );
    return authWithInclude!;
  }

  Future<PupilAuthorization> removeFileFromPupilAuthorization(
    Session session,
    int pupilAuthId,
  ) async {
    // TODO: This is not right, check it!
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
    final updatedPupilAuth = pupilAuth.copyWith(
      fileId: null,
    );
    await PupilAuthorization.db.updateRow(session, updatedPupilAuth);
    final authWithInclude = await PupilAuthorization.db.findById(
      session,
      updatedPupilAuth.id!,
      include: PupilAuthorization.include(
        file: HubDocument.include(),
      ),
    );
    return authWithInclude!;
  }
}

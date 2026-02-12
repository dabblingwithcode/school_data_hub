import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/helpers/hub_document_helper.dart';
import 'package:serverpod/serverpod.dart';

class AdminSchoolDataEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;
  @override
  Set<Scope> get requiredScopes => {Scope('serverpod.admin')};

  Future<SchoolData> postSchoolData(
      Session session, SchoolData schoolData) async {
    final schooldataInDb = await session.db.insertRow(schoolData);
    return schooldataInDb;
  }

  /// Upload a logo image and link it to the SchoolData record
  Future<SchoolData> uploadLogo(
    Session session,
    int schoolDataId,
    String filePath,
    String createdBy,
  ) async {
    final schoolData = await SchoolData.db.findById(
      session,
      schoolDataId,
      include: SchoolData.include(
        logo: HubDocument.include(),
      ),
    );
    if (schoolData == null) {
      throw Exception('SchoolData not found');
    }

    // Delete old logo if exists
    if (schoolData.logoId != null && schoolData.logo != null) {
      await HubDocumentHelper().deleteHubDocumentAndFile(
        session: session,
        documentId: schoolData.logo!.documentId,
      );
    }

    // Create new HubDocument for the logo
    final document = HubDocumentHelper().createHubDocumentObject(
      session: session,
      createdBy: createdBy,
      path: filePath,
    );
    final documentInDatabase = await HubDocument.db.insertRow(
      session,
      document,
    );

    // Update SchoolData with the new logoId
    final updatedSchoolData = schoolData.copyWith(
      logoId: documentInDatabase.id,
    );
    await SchoolData.db.updateRow(session, updatedSchoolData);

    // Return the updated SchoolData with includes
    final result = await SchoolData.db.findById(
      session,
      schoolDataId,
      include: SchoolData.include(
        logo: HubDocument.include(),
        officialSeal: HubDocument.include(),
      ),
    );
    return result!;
  }

  /// Upload an official seal image and link it to the SchoolData record
  Future<SchoolData> uploadOfficialSeal(
    Session session,
    int schoolDataId,
    String filePath,
    String createdBy,
  ) async {
    final schoolData = await SchoolData.db.findById(
      session,
      schoolDataId,
      include: SchoolData.include(
        officialSeal: HubDocument.include(),
      ),
    );
    if (schoolData == null) {
      throw Exception('SchoolData not found');
    }

    // Delete old seal if exists
    if (schoolData.officialSealId != null && schoolData.officialSeal != null) {
      await HubDocumentHelper().deleteHubDocumentAndFile(
        session: session,
        documentId: schoolData.officialSeal!.documentId,
      );
    }

    // Create new HubDocument for the seal
    final document = HubDocumentHelper().createHubDocumentObject(
      session: session,
      createdBy: createdBy,
      path: filePath,
    );
    final documentInDatabase = await HubDocument.db.insertRow(
      session,
      document,
    );

    // Update SchoolData with the new officialSealId
    final updatedSchoolData = schoolData.copyWith(
      officialSealId: documentInDatabase.id,
    );
    await SchoolData.db.updateRow(session, updatedSchoolData);

    // Return the updated SchoolData with includes
    final result = await SchoolData.db.findById(
      session,
      schoolDataId,
      include: SchoolData.include(
        logo: HubDocument.include(),
        officialSeal: HubDocument.include(),
      ),
    );
    return result!;
  }
}

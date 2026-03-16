import 'package:school_data_hub_server/src/_features/hub/services/hub_updates_tracker.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/helpers/hub_document_helper.dart';
import 'package:serverpod/serverpod.dart';

class AdminSchoolDataEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;
  @override
  Set<Scope> get requiredScopes => {Scope('serverpod.admin')};

  Future<SchoolData> postSchoolData(
    Session session,
    SchoolData schoolData,
  ) async {
    final schooldataInDb = await session.db.insertRow(schoolData);
    session.messages.postMessage('hub_events_stream', schooldataInDb);
    HubUpdatesTracker.instance.touch(HubObjectType.schoolData);
    return schooldataInDb;
  }

  /// Update existing school data
  Future<SchoolData> updateSchoolData(
    Session session,
    SchoolData schoolData,
  ) async {
    if (schoolData.id == null) {
      throw Exception('School data ID is required for update');
    }

    final updatedSchoolData = await SchoolData.db.updateRow(
      session,
      schoolData,
    );

    // Return with includes
    final result = await SchoolData.db.findById(
          session,
          schoolData.id!,
          include: SchoolData.include(
            logo: HubDocument.include(),
            officialSeal: HubDocument.include(),
          ),
        ) ??
        updatedSchoolData;
    session.messages.postMessage('hub_events_stream', result);
    HubUpdatesTracker.instance.touch(HubObjectType.schoolData);
    return result;
  }

  /// Upload a logo image and link it to the SchoolData record
  Future<SchoolData> uploadLogo(
    Session session,
    int schoolDataId,
    String filePath,
    String createdBy,
  ) async {
    final result = await session.db.transaction((transaction) async {
      // Fetch SchoolData inside transaction
      final schoolData = await SchoolData.db.findById(
        session,
        schoolDataId,
        include: SchoolData.include(logo: HubDocument.include()),
        transaction: transaction,
      );
      if (schoolData == null) {
        throw Exception('SchoolData not found');
      }

      // Store old logo document for deletion
      final oldLogoDocument = schoolData.logo;

      // Create new HubDocument for the logo
      final document = HubDocumentHelper().createHubDocumentObject(
        session: session,
        createdBy: createdBy,
        path: filePath,
      );
      final documentInDatabase = await HubDocument.db.insertRow(
        session,
        document,
        transaction: transaction,
      );

      // Update SchoolData with the new logoId
      final updatedSchoolData = schoolData.copyWith(
        logoId: documentInDatabase.id,
      );
      await SchoolData.db.updateRow(
        session,
        updatedSchoolData,
        transaction: transaction,
      );

      // Delete old logo if exists (after updating the foreign key)
      if (oldLogoDocument != null) {
        await HubDocumentHelper().deleteHubDocumentAndFile(
          session: session,
          documentId: oldLogoDocument.documentId,
          transaction: transaction,
        );
      }

      // Return the updated SchoolData with includes
      return await SchoolData.db.findById(
        session,
        schoolDataId,
        include: SchoolData.include(
          logo: HubDocument.include(),
          officialSeal: HubDocument.include(),
        ),
        transaction: transaction,
      );
    });
    session.messages.postMessage('hub_events_stream', result!);
    HubUpdatesTracker.instance.touch(HubObjectType.schoolData);
    return result;
  }

  /// Upload an official seal image and link it to the SchoolData record
  Future<SchoolData> uploadOfficialSeal(
    Session session,
    int schoolDataId,
    String filePath,
    String createdBy,
  ) async {
    final result = await session.db.transaction((transaction) async {
      // Fetch SchoolData inside transaction
      final schoolData = await SchoolData.db.findById(
        session,
        schoolDataId,
        include: SchoolData.include(officialSeal: HubDocument.include()),
        transaction: transaction,
      );
      if (schoolData == null) {
        throw Exception('SchoolData not found');
      }

      // Store old seal document for deletion
      final oldSealDocument = schoolData.officialSeal;

      // Create new HubDocument for the seal
      final document = HubDocumentHelper().createHubDocumentObject(
        session: session,
        createdBy: createdBy,
        path: filePath,
      );
      final documentInDatabase = await HubDocument.db.insertRow(
        session,
        document,
        transaction: transaction,
      );

      // Update SchoolData with the new officialSealId
      final updatedSchoolData = schoolData.copyWith(
        officialSealId: documentInDatabase.id,
      );
      await SchoolData.db.updateRow(
        session,
        updatedSchoolData,
        transaction: transaction,
      );

      // Delete old seal if exists (after updating the foreign key)
      if (oldSealDocument != null) {
        await HubDocumentHelper().deleteHubDocumentAndFile(
          session: session,
          documentId: oldSealDocument.documentId,
          transaction: transaction,
        );
      }

      // Return the updated SchoolData with includes
      return await SchoolData.db.findById(
        session,
        schoolDataId,
        include: SchoolData.include(
          logo: HubDocument.include(),
          officialSeal: HubDocument.include(),
        ),
        transaction: transaction,
      );
    });
    session.messages.postMessage('hub_events_stream', result!);
    HubUpdatesTracker.instance.touch(HubObjectType.schoolData);
    return result;
  }

  /// Delete the logo from SchoolData
  Future<SchoolData> deleteLogo(
    Session session,
    int schoolDataId,
  ) async {
    final result = await session.db.transaction((transaction) async {
      // Fetch SchoolData inside transaction
      final schoolData = await SchoolData.db.findById(
        session,
        schoolDataId,
        include: SchoolData.include(logo: HubDocument.include()),
        transaction: transaction,
      );
      if (schoolData == null) {
        throw Exception('SchoolData not found');
      }

      // Store logo document for deletion
      final logoDocument = schoolData.logo;

      // Update SchoolData to remove logoId reference
      final updatedSchoolData = schoolData.copyWith(
        logoId: null,
      );
      await SchoolData.db.updateRow(
        session,
        updatedSchoolData,
        transaction: transaction,
      );

      // Delete logo document and file if exists
      if (logoDocument != null) {
        await HubDocumentHelper().deleteHubDocumentAndFile(
          session: session,
          documentId: logoDocument.documentId,
          transaction: transaction,
        );
      }

      // Return the updated SchoolData with includes
      return await SchoolData.db.findById(
        session,
        schoolDataId,
        include: SchoolData.include(
          logo: HubDocument.include(),
          officialSeal: HubDocument.include(),
        ),
        transaction: transaction,
      );
    });
    session.messages.postMessage('hub_events_stream', result!);
    HubUpdatesTracker.instance.touch(HubObjectType.schoolData);
    return result;
  }

  /// Delete the official seal from SchoolData
  Future<SchoolData> deleteOfficialSeal(
    Session session,
    int schoolDataId,
  ) async {
    final result = await session.db.transaction((transaction) async {
      // Fetch SchoolData inside transaction
      final schoolData = await SchoolData.db.findById(
        session,
        schoolDataId,
        include: SchoolData.include(officialSeal: HubDocument.include()),
        transaction: transaction,
      );
      if (schoolData == null) {
        throw Exception('SchoolData not found');
      }

      // Store seal document for deletion
      final sealDocument = schoolData.officialSeal;

      // Update SchoolData to remove officialSealId reference
      final updatedSchoolData = schoolData.copyWith(
        officialSealId: null,
      );
      await SchoolData.db.updateRow(
        session,
        updatedSchoolData,
        transaction: transaction,
      );

      // Delete seal document and file if exists
      if (sealDocument != null) {
        await HubDocumentHelper().deleteHubDocumentAndFile(
          session: session,
          documentId: sealDocument.documentId,
          transaction: transaction,
        );
      }

      // Return the updated SchoolData with includes
      return await SchoolData.db.findById(
        session,
        schoolDataId,
        include: SchoolData.include(
          logo: HubDocument.include(),
          officialSeal: HubDocument.include(),
        ),
        transaction: transaction,
      );
    });
    session.messages.postMessage('hub_events_stream', result!);
    HubUpdatesTracker.instance.touch(HubObjectType.schoolData);
    return result;
  }
}

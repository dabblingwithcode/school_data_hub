import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/helpers/hub_document_helper.dart';
import 'package:school_data_hub_server/src/schemas/pupil_schemas.dart';
import 'package:serverpod/serverpod.dart';

class PreSchoolMedicalEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Create a new PreSchoolMedical record for a pupil
  Future<PreSchoolMedical> createPreSchoolMedical(
    Session session,
    int pupilId,
    PreSchoolMedicalStatus? preschoolMedicalStatus,
    String createdBy,
  ) async {
    final pupil = await PupilData.db.findById(
      session,
      pupilId,
      include: PupilSchemas.allInclude,
    );

    if (pupil == null) {
      throw Exception('Pupil not found');
    }

    // Check if pupil already has a PreSchoolMedical record
    if (pupil.preSchoolMedical != null) {
      throw Exception('Pupil already has a PreSchoolMedical record');
    }

    final newPreSchoolMedical = PreSchoolMedical(
      preschoolMedicalStatus: preschoolMedicalStatus,
      createdBy: createdBy,
      createdAt: DateTime.now().toUtc(),
    );

    final createdPreSchoolMedical = await PreSchoolMedical.db.insertRow(
      session,
      newPreSchoolMedical,
    );

    // Attach the PreSchoolMedical to the pupil
    await PupilData.db.attachRow.preSchoolMedical(
      session,
      pupil,
      createdPreSchoolMedical,
    );

    return createdPreSchoolMedical;
  }

  /// Update an existing PreSchoolMedical record
  Future<PreSchoolMedical> updatePreSchoolMedical(
    Session session,
    int preSchoolMedicalId,
    PreSchoolMedicalStatus? preschoolMedicalStatus,
    String updatedBy,
  ) async {
    final existingPreSchoolMedical = await PreSchoolMedical.db.findById(
      session,
      preSchoolMedicalId,
    );

    if (existingPreSchoolMedical == null) {
      throw Exception('PreSchoolMedical record not found');
    }

    final updatedPreSchoolMedical = existingPreSchoolMedical.copyWith(
      preschoolMedicalStatus: preschoolMedicalStatus,
      updatedBy: updatedBy,
      updatedAt: DateTime.now().toUtc(),
    );

    final result = await PreSchoolMedical.db.updateRow(
      session,
      updatedPreSchoolMedical,
    );

    return result;
  }

  /// Get a PreSchoolMedical record by ID
  Future<PreSchoolMedical?> getPreSchoolMedical(
    Session session,
    int preSchoolMedicalId,
  ) async {
    return await PreSchoolMedical.db.findById(session, preSchoolMedicalId);
  }

  /// Get PreSchoolMedical record for a specific pupil
  Future<PreSchoolMedical?> getPreSchoolMedicalByPupilId(
    Session session,
    int pupilId,
  ) async {
    final pupil = await PupilData.db.findById(
      session,
      pupilId,
      include: PupilSchemas.allInclude,
    );

    return pupil?.preSchoolMedical;
  }

  /// Delete a PreSchoolMedical record
  Future<bool> deletePreSchoolMedical(
    Session session,
    int preSchoolMedicalId,
  ) async {
    final existingPreSchoolMedical = await PreSchoolMedical.db.findById(
      session,
      preSchoolMedicalId,
    );

    if (existingPreSchoolMedical == null) {
      throw Exception('PreSchoolMedical record not found');
    }

    await PreSchoolMedical.db.deleteRow(
      session,
      existingPreSchoolMedical,
    );

    return true;
  }

  /// Add a file to a PreSchoolMedical record
  Future<PreSchoolMedical> addFileToPreSchoolMedical(
    Session session,
    int preSchoolMedicalId,
    String filePath,
    String createdBy,
  ) async {
    final preSchoolMedical = await PreSchoolMedical.db.findById(
      session,
      preSchoolMedicalId,
    );

    if (preSchoolMedical == null) {
      throw Exception('PreSchoolMedical record not found');
    }

    // Create a new HubDocument for the file using the helper
    final hubDocument = HubDocumentHelper().createHubDocumentObject(
      session: session,
      createdBy: createdBy,
      path: filePath,
    );

    final createdDocument = await HubDocument.db.insertRow(
      session,
      hubDocument,
    );

    // Attach the document to the PreSchoolMedical record
    await PreSchoolMedical.db.attachRow.preschoolMedicalFiles(
      session,
      preSchoolMedical,
      createdDocument,
    );

    // Return the updated PreSchoolMedical record
    return await PreSchoolMedical.db.findById(
          session,
          preSchoolMedicalId,
        ) ??
        preSchoolMedical;
  }

  /// Remove a file from a PreSchoolMedical record
  Future<bool> removeFileFromPreSchoolMedical(
    Session session,
    int preSchoolMedicalId,
    String documentId,
  ) async {
    final preSchoolMedical = await PreSchoolMedical.db.findById(
      session,
      preSchoolMedicalId,
    );

    if (preSchoolMedical == null) {
      throw Exception('PreSchoolMedical record not found');
    }

    final document = await HubDocument.db.findFirstRow(
      session,
      where: (t) => t.documentId.equals(documentId),
    );
    if (document == null) {
      throw Exception('Document not found');
    }

    // Use a transaction to ensure data consistency
    await session.db.transaction((transaction) async {
      // Detach the document from the PreSchoolMedical record
      await PreSchoolMedical.db.detachRow.preschoolMedicalFiles(
        session,
        document,
        transaction: transaction,
      );

      // Delete the file from storage
      await session.storage.deleteFile(
        storageId: 'private',
        path: document.documentPath!,
      );

      // Delete the document from database
      await HubDocument.db
          .deleteRow(session, document, transaction: transaction);
    });

    return true;
  }

  /// Get all PreSchoolMedical records (for admin purposes)
  Future<List<PreSchoolMedical>> getAllPreSchoolMedicalRecords(
    Session session,
  ) async {
    return await PreSchoolMedical.db.find(session);
  }

  /// Get PreSchoolMedical records with specific status
  Future<List<PreSchoolMedical>> getPreSchoolMedicalByStatus(
    Session session,
    PreSchoolMedicalStatus status,
  ) async {
    return await PreSchoolMedical.db.find(
      session,
      where: (t) => t.preschoolMedicalStatus.equals(status),
    );
  }
}

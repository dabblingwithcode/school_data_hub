import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/client/file_upload_service.dart';
import 'package:school_data_hub_flutter/common/models/enums.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';

class SchoolDataApiService {
  final _client = di<Client>();
  final _cacheManager = di<DefaultCacheManager>();

  /// Fetch the current school data
  Future<SchoolData?> fetchSchoolData() async {
    final schoolData = await ClientHelper.apiCall(
      call: () => _client.schoolData.getSchoolData(),
      errorMessage: 'Fehler beim Laden der Schulinformationen',
    );
    return schoolData;
  }

  /// Create or update school data
  Future<SchoolData?> postSchoolData(SchoolData schoolData) async {
    final createdSchoolData = await ClientHelper.apiCall(
      call: () => _client.adminSchoolData.postSchoolData(schoolData),
      errorMessage: 'Fehler beim Speichern der Schulinformationen',
    );
    return createdSchoolData;
  }

  /// Update existing school data
  Future<SchoolData?> updateSchoolData(SchoolData schoolData) async {
    final updatedSchoolData = await ClientHelper.apiCall(
      call: () => _client.adminSchoolData.updateSchoolData(schoolData),
      errorMessage: 'Fehler beim Aktualisieren der Schulinformationen',
    );
    return updatedSchoolData;
  }

  /// Upload school logo - uploads file to storage and links to SchoolData
  Future<SchoolData?> uploadLogo(
    File imageFile,
    int schoolDataId,
    String createdBy,
  ) async {
    // First upload the file to cloud storage
    final result = await ClientFileUpload.uploadFile(
      file: imageFile,
      storageId: StorageId.private,
      folder: ServerStorageFolder.schoolLogos,
    );

    if (result.cancelled) {
      return null;
    }

    if (result.success && result.path != null) {
      // Cache the uploaded file so it's immediately available
      final bytes = await imageFile.readAsBytes();
      await _cacheManager.putFile(result.path!, bytes);

      // Call the backend endpoint to create HubDocument and link to SchoolData
      final updatedSchoolData = await ClientHelper.apiCall(
        call: () => _client.adminSchoolData.uploadLogo(
          schoolDataId,
          result.path!,
          createdBy,
        ),
        errorMessage: 'Fehler beim Verknüpfen des Logos',
      );
      return updatedSchoolData;
    }

    throw Exception('Logo upload failed before linking to SchoolData');
  }

  /// Upload official seal - uploads file to storage and links to SchoolData
  Future<SchoolData?> uploadOfficialSeal(
    File imageFile,
    int schoolDataId,
    String createdBy,
  ) async {
    // First upload the file to cloud storage
    final result = await ClientFileUpload.uploadFile(
      file: imageFile,
      storageId: StorageId.private,
      folder: ServerStorageFolder.schoolLogos,
    );

    if (result.cancelled) {
      return null;
    }

    if (result.success && result.path != null) {
      // Cache the uploaded file so it's immediately available
      final bytes = await imageFile.readAsBytes();
      await _cacheManager.putFile(result.path!, bytes);

      // Call the backend endpoint to create HubDocument and link to SchoolData
      final updatedSchoolData = await ClientHelper.apiCall(
        call: () => _client.adminSchoolData.uploadOfficialSeal(
          schoolDataId,
          result.path!,
          createdBy,
        ),
        errorMessage: 'Fehler beim Verknüpfen des Dienstsiegels',
      );
      return updatedSchoolData;
    }

    throw Exception('Official seal upload failed before linking to SchoolData');
  }

  /// Delete school logo
  Future<SchoolData?> deleteLogo(int schoolDataId) async {
    final updatedSchoolData = await ClientHelper.apiCall(
      call: () => _client.adminSchoolData.deleteLogo(schoolDataId),
      errorMessage: 'Fehler beim Löschen des Logos',
    );
    return updatedSchoolData;
  }

  /// Delete official seal
  Future<SchoolData?> deleteOfficialSeal(int schoolDataId) async {
    final updatedSchoolData = await ClientHelper.apiCall(
      call: () => _client.adminSchoolData.deleteOfficialSeal(schoolDataId),
      errorMessage: 'Fehler beim Löschen des Dienstsiegels',
    );
    return updatedSchoolData;
  }

  /// Get school logo image with caching
  Future<ByteData?> getLogoImage(String documentId) async {
    // Check cache first
    final fileInfo = await _cacheManager.getFileFromCache(documentId);
    if (fileInfo != null && await fileInfo.file.exists()) {
      final bytes = await fileInfo.file.readAsBytes();
      return ByteData.view(bytes.buffer);
    }

    // Download if not in cache
    final byteData = await _client.files.getImage(documentId);
    if (byteData != null) {
      await _cacheManager.putFile(documentId, byteData.buffer.asUint8List());
    }
    return byteData;
  }

  /// Get official seal image with caching
  Future<ByteData?> getOfficialSealImage(String documentId) async {
    // Check cache first
    final fileInfo = await _cacheManager.getFileFromCache(documentId);
    if (fileInfo != null && await fileInfo.file.exists()) {
      final bytes = await fileInfo.file.readAsBytes();
      return ByteData.view(bytes.buffer);
    }

    // Download if not in cache
    final byteData = await _client.files.getImage(documentId);
    if (byteData != null) {
      await _cacheManager.putFile(documentId, byteData.buffer.asUint8List());
    }
    return byteData;
  }
}

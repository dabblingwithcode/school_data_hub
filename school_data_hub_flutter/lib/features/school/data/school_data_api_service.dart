import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/data/file_upload_service.dart';
import 'package:school_data_hub_flutter/common/models/enums.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:flutter_it/flutter_it.dart';

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

  /// Upload school logo
  Future<String?> uploadLogo(File imageFile) async {
    final result = await ClientFileUpload.uploadFile(
      file: imageFile,
      storageId: StorageId.private,
      folder: ServerStorageFolder.schoolLogos,
    );

    if (result.success && result.path != null) {
      // Cache the uploaded file so it's immediately available
      final bytes = await imageFile.readAsBytes();
      await _cacheManager.putFile(result.path!, bytes);
      return result.path;
    }
    return null;
  }

  /// Upload official seal
  Future<String?> uploadOfficialSeal(File imageFile) async {
    final result = await ClientFileUpload.uploadFile(
      file: imageFile,
      storageId: StorageId.private,
      folder: ServerStorageFolder.schoolSeals,
    );

    if (result.success && result.path != null) {
      // Cache the uploaded file so it's immediately available
      final bytes = await imageFile.readAsBytes();
      await _cacheManager.putFile(result.path!, bytes);
      return result.path;
    }
    return null;
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

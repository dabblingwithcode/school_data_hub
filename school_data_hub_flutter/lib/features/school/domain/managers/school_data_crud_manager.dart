import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/school/data/school_data_api_service.dart';

/// Manages CRUD operations for school data
class SchoolInfoDataManager extends ChangeNotifier {
  final _apiService = SchoolDataApiService();
  final _log = Logger('SchoolInfoDataManager');

  /// Fetch school data from the server
  Future<SchoolData?> fetchSchoolData() async {
    try {
      final schoolData = await _apiService.fetchSchoolData();
      if (schoolData != null) {
        _log.info('School data fetched successfully: ${schoolData.name}');
      }
      return schoolData;
    } catch (e) {
      _log.info('Error fetching school data: $e');
      rethrow;
    }
  }

  /// Create or update school data
  Future<SchoolData?> postSchoolData(SchoolData schoolData) async {
    try {
      final createdSchoolData = await _apiService.postSchoolData(schoolData);
      if (createdSchoolData != null) {
        _log.info('School data saved successfully: ${createdSchoolData.name}');
      }
      return createdSchoolData;
    } catch (e) {
      _log.info('Error saving school data: $e');
      rethrow;
    }
  }

  /// Upload school logo
  Future<String?> uploadLogo(File imageFile) async {
    try {
      final logoPath = await _apiService.uploadLogo(imageFile);
      if (logoPath != null) {
        _log.info('Logo uploaded successfully: $logoPath');
      }
      return logoPath;
    } catch (e) {
      _log.info('Error uploading logo: $e');
      rethrow;
    }
  }

  /// Upload official seal
  Future<String?> uploadOfficialSeal(File imageFile) async {
    try {
      final sealPath = await _apiService.uploadOfficialSeal(imageFile);
      if (sealPath != null) {
        _log.info('Official seal uploaded successfully: $sealPath');
      }
      return sealPath;
    } catch (e) {
      _log.info('Error uploading official seal: $e');
      rethrow;
    }
  }

  /// Get school logo image
  Future<ByteData?> getLogoImage(String documentId) async {
    try {
      return await _apiService.getLogoImage(documentId);
    } catch (e) {
      _log.info('Error getting logo image: $e');
      rethrow;
    }
  }

  /// Get official seal image
  Future<ByteData?> getOfficialSealImage(String documentId) async {
    try {
      return await _apiService.getOfficialSealImage(documentId);
    } catch (e) {
      _log.info('Error getting official seal image: $e');
      rethrow;
    }
  }
}

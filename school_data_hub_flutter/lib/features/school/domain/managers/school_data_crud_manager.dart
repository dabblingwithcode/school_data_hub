import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/school/data/school_data_api_service.dart';

/// Manages CRUD operations for school data
class SchoolInfoDataManager {
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

  /// Update existing school data
  Future<SchoolData?> updateSchoolData(SchoolData schoolData) async {
    try {
      final updatedSchoolData = await _apiService.updateSchoolData(schoolData);
      if (updatedSchoolData != null) {
        _log.info(
          'School data updated successfully: ${updatedSchoolData.name}',
        );
      }
      return updatedSchoolData;
    } catch (e) {
      _log.info('Error updating school data: $e');
      rethrow;
    }
  }

  /// Upload school logo and link to SchoolData
  Future<SchoolData?> uploadLogo(
    File imageFile,
    int schoolDataId,
    String createdBy,
  ) async {
    try {
      final updatedSchoolData = await _apiService.uploadLogo(
        imageFile,
        schoolDataId,
        createdBy,
      );
      if (updatedSchoolData != null) {
        _log.info(
          'Logo uploaded and linked successfully. LogoId: ${updatedSchoolData.logoId}',
        );
      }
      return updatedSchoolData;
    } catch (e) {
      _log.info('Error uploading logo: $e');
      rethrow;
    }
  }

  /// Upload official seal and link to SchoolData
  Future<SchoolData?> uploadOfficialSeal(
    File imageFile,
    int schoolDataId,
    String createdBy,
  ) async {
    try {
      final updatedSchoolData = await _apiService.uploadOfficialSeal(
        imageFile,
        schoolDataId,
        createdBy,
      );
      if (updatedSchoolData != null) {
        _log.info(
          'Official seal uploaded and linked successfully. SealId: ${updatedSchoolData.officialSealId}',
        );
      }
      return updatedSchoolData;
    } catch (e) {
      _log.info('Error uploading official seal: $e');
      rethrow;
    }
  }

  /// Delete school logo
  Future<SchoolData?> deleteLogo(int schoolDataId) async {
    try {
      final updatedSchoolData = await _apiService.deleteLogo(schoolDataId);
      if (updatedSchoolData != null) {
        _log.info('Logo deleted successfully');
      }
      return updatedSchoolData;
    } catch (e) {
      _log.info('Error deleting logo: $e');
      rethrow;
    }
  }

  /// Delete official seal
  Future<SchoolData?> deleteOfficialSeal(int schoolDataId) async {
    try {
      final updatedSchoolData = await _apiService.deleteOfficialSeal(
        schoolDataId,
      );
      if (updatedSchoolData != null) {
        _log.info('Official seal deleted successfully');
      }
      return updatedSchoolData;
    } catch (e) {
      _log.info('Error deleting official seal: $e');
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

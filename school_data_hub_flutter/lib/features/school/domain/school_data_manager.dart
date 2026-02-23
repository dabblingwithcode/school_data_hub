import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/school/domain/managers/school_data_crud_manager.dart';
import 'package:school_data_hub_flutter/features/school/domain/managers/school_data_manager.dart'
    as data_manager;
import 'package:school_data_hub_flutter/features/school/domain/managers/school_data_ui_manager.dart';

final _log = Logger('SchoolDataMainManager');

// AI GENERATED CODE

/// Main school data manager that orchestrates all sub-managers
/// This follows the established pattern from the timetable feature
class SchoolDataMainManager {
  // Sub-managers
  final data_manager.SchoolDataManager _dataManager;
  final SchoolInfoDataManager _crudManager;
  final SchoolDataUiManager _uiManager;

  SchoolDataMainManager()
    : _dataManager = data_manager.SchoolDataManager(),
      _crudManager = SchoolInfoDataManager(),
      _uiManager = SchoolDataUiManager();

  // Expose data manager properties
  ValueListenable<SchoolData?> get schoolData => _dataManager.schoolData;
  ValueListenable<ByteData?> get logoImage => _dataManager.logoImage;
  ValueListenable<ByteData?> get officialSealImage =>
      _dataManager.officialSealImage;
  ValueListenable<bool> get isLoading => _dataManager.isLoading;
  ValueListenable<bool> get isSaving => _dataManager.isSaving;

  // Expose UI manager properties
  ValueListenable<SchoolData?> get formData => _uiManager.formData;
  ValueListenable<bool> get isFormValid => _uiManager.isFormValid;
  ValueListenable<bool> get isFormDirty => _uiManager.isFormDirty;
  ValueListenable<String?> get selectedLogoFile => _uiManager.selectedLogoFile;
  ValueListenable<String?> get selectedSealFile => _uiManager.selectedSealFile;

  /// Initialize the school data manager
  Future<SchoolDataMainManager> init() async {
    await _dataManager.init();
    await _uiManager.init();
    await refreshData();

    return this;
  }

  void dispose() {
    _dataManager.dispose();

    _uiManager.dispose();
  }

  /// Refresh all data from API
  Future<void> refreshData() async {
    _dataManager.setLoading(true);
    try {
      final schoolData = await _crudManager.fetchSchoolData();
      if (schoolData != null) {
        _dataManager.setSchoolData(schoolData);

        // Load images if they exist (using the HubDocument's documentId)
        if (schoolData.logo != null) {
          await _loadLogoImage(schoolData.logo!.documentId);
        }
        if (schoolData.officialSeal != null) {
          await _loadOfficialSealImage(schoolData.officialSeal!.documentId);
        }
      }
    } catch (e) {
      _log.severe('Error refreshing school data: $e');
      rethrow;
    } finally {
      _dataManager.setLoading(false);
    }
  }

  /// Load logo image
  Future<void> _loadLogoImage(String documentId) async {
    try {
      final imageData = await _crudManager.getLogoImage(documentId);
      _dataManager.setLogoImage(imageData);
    } catch (e) {
      _log.severe('Error loading logo image: $e');
    }
  }

  /// Load official seal image
  Future<void> _loadOfficialSealImage(String documentId) async {
    try {
      final imageData = await _crudManager.getOfficialSealImage(documentId);
      _dataManager.setOfficialSealImage(imageData);
    } catch (e) {
      _log.severe('Error loading official seal image: $e');
    }
  }

  /// Save school data
  Future<void> saveSchoolData() async {
    final formData = _uiManager.getCurrentFormData();
    if (formData == null) {
      throw Exception('No form data to save');
    }

    _dataManager.setSaving(true);
    try {
      SchoolData? savedData;

      // Use update if ID exists, otherwise create new
      if (formData.id != null) {
        savedData = await _crudManager.updateSchoolData(formData);
      } else {
        savedData = await _crudManager.postSchoolData(formData);
      }

      if (savedData != null) {
        _dataManager.setSchoolData(savedData);
        _uiManager.clearFormChanges();
      }
    } catch (e) {
      _log.severe('Error saving school data: $e');
      rethrow;
    } finally {
      _dataManager.setSaving(false);
    }
  }

  /// Upload logo
  Future<void> uploadLogo(File imageFile) async {
    final currentSchoolData = _dataManager.schoolData.value;
    if (currentSchoolData?.id == null) {
      throw Exception('SchoolData must be saved before uploading a logo');
    }

    final createdBy = di<HubSessionManager>().userName ?? 'unknown';

    _dataManager.setSaving(true);
    try {
      final updatedSchoolData = await _crudManager.uploadLogo(
        imageFile,
        currentSchoolData!.id!,
        createdBy,
      );
      if (updatedSchoolData == null) {
        throw Exception('Logo upload returned no updated SchoolData');
      }

      _log.info(
        'Logo uploaded and linked successfully. LogoId: ${updatedSchoolData.logoId}',
      );
      // Update local state with the returned SchoolData
      _dataManager.setSchoolData(updatedSchoolData);
      // Load the new image data to show it in the UI
      if (updatedSchoolData.logo != null) {
        await _loadLogoImage(updatedSchoolData.logo!.documentId);
      }
      // Re-initialize the form so it reflects the updated SchoolData
      _uiManager.initializeForm(updatedSchoolData);
    } catch (e) {
      _log.severe('Error uploading logo: $e');
      rethrow;
    } finally {
      _dataManager.setSaving(false);
    }
  }

  /// Upload official seal
  Future<void> uploadOfficialSeal(File imageFile) async {
    final currentSchoolData = _dataManager.schoolData.value;
    if (currentSchoolData?.id == null) {
      throw Exception(
        'SchoolData must be saved before uploading an official seal',
      );
    }

    final createdBy = di<HubSessionManager>().userName ?? 'unknown';

    _dataManager.setSaving(true);
    try {
      final updatedSchoolData = await _crudManager.uploadOfficialSeal(
        imageFile,
        currentSchoolData!.id!,
        createdBy,
      );
      if (updatedSchoolData == null) {
        throw Exception('Official seal upload returned no updated SchoolData');
      }

      _log.info(
        'Official seal uploaded and linked successfully. SealId: ${updatedSchoolData.officialSealId}',
      );
      // Update local state with the returned SchoolData
      _dataManager.setSchoolData(updatedSchoolData);
      // Load the new image data to show it in the UI
      if (updatedSchoolData.officialSeal != null) {
        await _loadOfficialSealImage(
          updatedSchoolData.officialSeal!.documentId,
        );
      }
      // Re-initialize the form so it reflects the updated SchoolData
      _uiManager.initializeForm(updatedSchoolData);
    } catch (e) {
      _log.severe('Error uploading official seal: $e');
      rethrow;
    } finally {
      _dataManager.setSaving(false);
    }
  }

  /// Delete logo
  Future<void> deleteLogo() async {
    final currentSchoolData = _dataManager.schoolData.value;
    if (currentSchoolData?.id == null) {
      throw Exception('SchoolData must exist to delete logo');
    }

    _dataManager.setSaving(true);
    try {
      final updatedSchoolData = await _crudManager.deleteLogo(
        currentSchoolData!.id!,
      );
      if (updatedSchoolData == null) {
        throw Exception('Logo deletion returned no updated SchoolData');
      }

      _log.info('Logo deleted successfully');
      // Update local state with the returned SchoolData
      _dataManager.setSchoolData(updatedSchoolData);
      // Clear the logo image from memory
      _dataManager.setLogoImage(null);
      // Re-initialize the form so it reflects the updated SchoolData
      _uiManager.initializeForm(updatedSchoolData);
    } catch (e) {
      _log.severe('Error deleting logo: $e');
      rethrow;
    } finally {
      _dataManager.setSaving(false);
    }
  }

  /// Delete official seal
  Future<void> deleteOfficialSeal() async {
    final currentSchoolData = _dataManager.schoolData.value;
    if (currentSchoolData?.id == null) {
      throw Exception('SchoolData must exist to delete official seal');
    }

    _dataManager.setSaving(true);
    try {
      final updatedSchoolData = await _crudManager.deleteOfficialSeal(
        currentSchoolData!.id!,
      );
      if (updatedSchoolData == null) {
        throw Exception(
          'Official seal deletion returned no updated SchoolData',
        );
      }

      _log.info('Official seal deleted successfully');
      // Update local state with the returned SchoolData
      _dataManager.setSchoolData(updatedSchoolData);
      // Clear the seal image from memory
      _dataManager.setOfficialSealImage(null);
      // Re-initialize the form so it reflects the updated SchoolData
      _uiManager.initializeForm(updatedSchoolData);
    } catch (e) {
      _log.severe('Error deleting official seal: $e');
      rethrow;
    } finally {
      _dataManager.setSaving(false);
    }
  }

  // UI Management Methods
  void initializeForm() {
    _uiManager.initializeForm(_dataManager.schoolData.value);
  }

  void updateFormField({
    String? name,
    String? officialName,
    String? address,
    String? schoolNumber,
    String? telephoneNumber,
    String? email,
    String? website,
  }) {
    _uiManager.updateFormField(
      name: name,
      officialName: officialName,
      address: address,
      schoolNumber: schoolNumber,
      telephoneNumber: telephoneNumber,
      email: email,
      website: website,
    );
  }

  void setSelectedLogoFile(String? filePath) {
    _uiManager.setSelectedLogoFile(filePath);
  }

  void setSelectedSealFile(String? filePath) {
    _uiManager.setSelectedSealFile(filePath);
  }

  void clearFormChanges() {
    _uiManager.clearFormChanges();
  }

  void resetForm() {
    _uiManager.resetForm();
  }

  /// Check if there's school data
  bool get hasSchoolData => _dataManager.schoolData.value != null;

  /// Get the current school data
  SchoolData? get currentSchoolData => _dataManager.schoolData.value;

  /// Check if form has unsaved changes
  bool get hasUnsavedChanges => _uiManager.hasUnsavedChanges;

  /// Debug method to print current state
  void debugPrintState() {
    _dataManager.debugPrintState();
    _uiManager.debugPrintState();
  }
}

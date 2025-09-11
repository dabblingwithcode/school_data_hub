import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/school/domain/managers/school_data_crud_manager.dart';
import 'package:school_data_hub_flutter/features/school/domain/managers/school_data_manager.dart'
    as data_manager;
import 'package:school_data_hub_flutter/features/school/domain/managers/school_data_ui_manager.dart';

/// Main school data manager that orchestrates all sub-managers
/// This follows the established pattern from the timetable feature
class SchoolDataMainManager extends ChangeNotifier {
  // Sub-managers
  final data_manager.SchoolDataManager _dataManager;
  final SchoolDataCrudManager _crudManager;
  final SchoolDataUiManager _uiManager;

  SchoolDataMainManager()
    : _dataManager = data_manager.SchoolDataManager(),
      _crudManager = SchoolDataCrudManager(),
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
    await refreshData();
    await _dataManager.init();
    await _uiManager.init();
    return this;
  }

  /// Refresh all data from API
  Future<void> refreshData() async {
    _dataManager.setLoading(true);
    try {
      final schoolData = await _crudManager.fetchSchoolData();
      if (schoolData != null) {
        _dataManager.setSchoolData(schoolData);

        // Load images if they exist
        if (schoolData.logoId != null) {
          await _loadLogoImage(schoolData.logoId.toString());
        }
        if (schoolData.officialSealId != null) {
          await _loadOfficialSealImage(schoolData.officialSealId.toString());
        }
      }
    } catch (e) {
      print('Error refreshing school data: $e');
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
      print('Error loading logo image: $e');
    }
  }

  /// Load official seal image
  Future<void> _loadOfficialSealImage(String documentId) async {
    try {
      final imageData = await _crudManager.getOfficialSealImage(documentId);
      _dataManager.setOfficialSealImage(imageData);
    } catch (e) {
      print('Error loading official seal image: $e');
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
      final savedData = await _crudManager.postSchoolData(formData);
      if (savedData != null) {
        _dataManager.setSchoolData(savedData);
        _uiManager.clearFormChanges();
        notifyListeners();
      }
    } catch (e) {
      print('Error saving school data: $e');
      rethrow;
    } finally {
      _dataManager.setSaving(false);
    }
  }

  /// Upload logo
  Future<void> uploadLogo(File imageFile) async {
    _dataManager.setSaving(true);
    try {
      final logoPath = await _crudManager.uploadLogo(imageFile);
      if (logoPath != null) {
        // Update the form data with the new logo path
        final currentData = _uiManager.getCurrentFormData();
        if (currentData != null) {
          // Note: This would need to be updated when the API supports logo path storage
          print('Logo uploaded successfully: $logoPath');
        }
      }
    } catch (e) {
      print('Error uploading logo: $e');
      rethrow;
    } finally {
      _dataManager.setSaving(false);
    }
  }

  /// Upload official seal
  Future<void> uploadOfficialSeal(File imageFile) async {
    _dataManager.setSaving(true);
    try {
      final sealPath = await _crudManager.uploadOfficialSeal(imageFile);
      if (sealPath != null) {
        // Update the form data with the new seal path
        final currentData = _uiManager.getCurrentFormData();
        if (currentData != null) {
          // Note: This would need to be updated when the API supports seal path storage
          print('Official seal uploaded successfully: $sealPath');
        }
      }
    } catch (e) {
      print('Error uploading official seal: $e');
      rethrow;
    } finally {
      _dataManager.setSaving(false);
    }
  }

  // UI Management Methods
  void initializeForm() {
    _uiManager.initializeForm(_dataManager.schoolData.value);
    notifyListeners();
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
    notifyListeners();
  }

  void setSelectedLogoFile(String? filePath) {
    _uiManager.setSelectedLogoFile(filePath);
    notifyListeners();
  }

  void setSelectedSealFile(String? filePath) {
    _uiManager.setSelectedSealFile(filePath);
    notifyListeners();
  }

  void clearFormChanges() {
    _uiManager.clearFormChanges();
    notifyListeners();
  }

  void resetForm() {
    _uiManager.resetForm();
    notifyListeners();
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

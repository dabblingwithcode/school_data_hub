import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

final _log = Logger('SchoolDataUiManager');

/// Manages UI state and form data for school data
class SchoolDataUiManager {
  // Form data
  final _formData = ValueNotifier<SchoolData?>(null);
  ValueListenable<SchoolData?> get formData => _formData;

  // Form validation states
  final _isFormValid = ValueNotifier<bool>(false);
  ValueListenable<bool> get isFormValid => _isFormValid;

  // Form dirty state (has unsaved changes)
  final _isFormDirty = ValueNotifier<bool>(false);
  ValueListenable<bool> get isFormDirty => _isFormDirty;

  // Image selection states
  final _selectedLogoFile = ValueNotifier<String?>(null);
  ValueListenable<String?> get selectedLogoFile => _selectedLogoFile;

  final _selectedSealFile = ValueNotifier<String?>(null);
  ValueListenable<String?> get selectedSealFile => _selectedSealFile;

  SchoolDataUiManager();

  void dispose() {
    _formData.dispose();
    _isFormValid.dispose();
    _isFormDirty.dispose();
    _selectedLogoFile.dispose();
    _selectedSealFile.dispose();
  }

  /// Initialize the UI manager
  Future<SchoolDataUiManager> init() async {
    return this;
  }

  /// Initialize form with school data
  void initializeForm(SchoolData? schoolData) {
    _formData.value = schoolData;
    _isFormDirty.value = false;
    _validateForm();
  }

  /// Update form field
  void updateFormField({
    String? name,
    String? officialName,
    String? extraName,
    String? address,
    String? city,
    String? zipCode,
    String? schoolNumber,
    String? principalName,
    String? telephoneNumber,
    String? email,
    String? website,
  }) {
    var currentData = _formData.value;

    // If no form data exists, create a default one
    currentData ??= SchoolData(
      name: '',
      officialName: '',
      extraName: '',
      address: '',
      city: '',
      zipCode: '',
      schoolNumber: '',
      principalName: '',
      telephoneNumber: '',
      email: '',
      website: '',
    );

    // Use current value for any parameter not supplied, so copyWith doesn't overwrite with null
    final updatedData = currentData.copyWith(
      name: name ?? currentData.name,
      officialName: officialName ?? currentData.officialName,
      extraName: extraName ?? currentData.extraName,
      address: address ?? currentData.address,
      city: city ?? currentData.city,
      zipCode: zipCode ?? currentData.zipCode,
      schoolNumber: schoolNumber ?? currentData.schoolNumber,
      principalName: principalName ?? currentData.principalName,
      telephoneNumber: telephoneNumber ?? currentData.telephoneNumber,
      email: email ?? currentData.email,
      website: website ?? currentData.website,
    );
    _formData.value = updatedData;
    _isFormDirty.value = true;
    _isFormValid.value = true; // Always valid since we're not validating
  }

  /// Set selected logo file
  void setSelectedLogoFile(String? filePath) {
    _selectedLogoFile.value = filePath;
    _isFormDirty.value = true;
  }

  /// Set selected seal file
  void setSelectedSealFile(String? filePath) {
    _selectedSealFile.value = filePath;
    _isFormDirty.value = true;
  }

  /// Clear form changes
  void clearFormChanges() {
    _isFormDirty.value = false;
    _selectedLogoFile.value = null;
    _selectedSealFile.value = null;
  }

  /// Reset form to original data
  void resetForm() {
    // Keep the original data but clear dirty state
    _isFormDirty.value = false;
    _selectedLogoFile.value = null;
    _selectedSealFile.value = null;
    _validateForm();
  }

  /// Validate form data
  void _validateForm() {
    final data = _formData.value;
    if (data == null) {
      _isFormValid.value = false;
      return;
    }

    // Basic validation - all required fields must be present and not empty
    final isValid =
        data.name.isNotEmpty &&
        data.officialName.isNotEmpty &&
        data.address.isNotEmpty &&
        data.schoolNumber.isNotEmpty &&
        data.telephoneNumber.isNotEmpty &&
        data.email.isNotEmpty &&
        data.website.isNotEmpty;

    _isFormValid.value = isValid;
  }

  /// Get current form data as SchoolData object
  SchoolData? getCurrentFormData() {
    return _formData.value;
  }

  /// Check if form has unsaved changes
  bool get hasUnsavedChanges => _isFormDirty.value;

  /// Debug method to print current state
  void debugPrintState() {
    _log.info('''
    Form Data: ${_formData.value?.name ?? 'null'}
    Is Form Valid: ${_isFormValid.value}
    Is Form Dirty: ${_isFormDirty.value}
    Selected Logo File: ${_selectedLogoFile.value ?? 'none'}
    Selected Seal File: ${_selectedSealFile.value ?? 'none'}
    ''');
  }
}

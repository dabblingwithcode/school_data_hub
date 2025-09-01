import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

/// Manages local school data storage and state
class SchoolDataManager extends ChangeNotifier {
  // Current school data
  final _schoolData = ValueNotifier<SchoolData?>(null);
  ValueListenable<SchoolData?> get schoolData => _schoolData;

  // Logo image cache
  final _logoImage = ValueNotifier<ByteData?>(null);
  ValueListenable<ByteData?> get logoImage => _logoImage;

  // Official seal image cache
  final _officialSealImage = ValueNotifier<ByteData?>(null);
  ValueListenable<ByteData?> get officialSealImage => _officialSealImage;

  // Loading states
  final _isLoading = ValueNotifier<bool>(false);
  ValueListenable<bool> get isLoading => _isLoading;

  final _isSaving = ValueNotifier<bool>(false);
  ValueListenable<bool> get isSaving => _isSaving;

  SchoolDataManager();

  /// Initialize the manager
  Future<SchoolDataManager> init() async {
    return this;
  }

  /// Clear all data
  void clearData() {
    _schoolData.value = null;
    _logoImage.value = null;
    _officialSealImage.value = null;
    _isLoading.value = false;
    _isSaving.value = false;
  }

  /// Set school data
  void setSchoolData(SchoolData schoolData) {
    _schoolData.value = schoolData;
    notifyListeners();
    print('School data updated: ${schoolData.name}');
  }

  /// Set logo image
  void setLogoImage(ByteData? imageData) {
    _logoImage.value = imageData;
    notifyListeners();
    print('Logo image updated');
  }

  /// Set official seal image
  void setOfficialSealImage(ByteData? imageData) {
    _officialSealImage.value = imageData;
    notifyListeners();
    print('Official seal image updated');
  }

  /// Set loading state
  void setLoading(bool loading) {
    _isLoading.value = loading;
    notifyListeners();
  }

  /// Set saving state
  void setSaving(bool saving) {
    _isSaving.value = saving;
    notifyListeners();
  }

  /// Debug method to print current state
  void debugPrintState() {
    print('=== SchoolDataManager Debug State ===');
    print(
      'School Data: ${_schoolData.value?.name ?? 'null'} (ID: ${_schoolData.value?.id ?? 'null'})',
    );
    print('Logo Image: ${_logoImage.value != null ? 'loaded' : 'not loaded'}');
    print(
      'Official Seal Image: ${_officialSealImage.value != null ? 'loaded' : 'not loaded'}',
    );
    print('Is Loading: ${_isLoading.value}');
    print('Is Saving: ${_isSaving.value}');
    print('====================================');
  }
}

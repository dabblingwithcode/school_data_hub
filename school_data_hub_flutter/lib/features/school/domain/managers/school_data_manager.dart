import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

final _log = Logger('SchoolDataManager');

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
    _log.info('School data updated: ${schoolData.name}');
  }

  /// Set logo image
  void setLogoImage(ByteData? imageData) {
    _logoImage.value = imageData;
    notifyListeners();
    _log.info('Logo image updated');
  }

  /// Set official seal image
  void setOfficialSealImage(ByteData? imageData) {
    _officialSealImage.value = imageData;
    notifyListeners();
    _log.info('Official seal image updated');
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
    _log.info('=== SchoolDataManager Debug State ===');
    _log.info(
      'School Data: ${_schoolData.value?.name ?? 'null'} (ID: ${_schoolData.value?.id ?? 'null'})',
    );
    _log.info(
      'Logo Image: ${_logoImage.value != null ? 'loaded' : 'not loaded'}',
    );
    _log.info(
      'Official Seal Image: ${_officialSealImage.value != null ? 'loaded' : 'not loaded'}',
    );
    _log.info('Is Loading: ${_isLoading.value}');
    _log.info('Is Saving: ${_isSaving.value}');
    _log.info('====================================');
  }
}

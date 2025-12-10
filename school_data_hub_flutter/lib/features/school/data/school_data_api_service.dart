import 'dart:io';
import 'dart:typed_data';

import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/data/file_upload_service.dart';
import 'package:school_data_hub_flutter/common/models/enums.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:watch_it/watch_it.dart';

class SchoolDataApiService {
  final _client = di<Client>();

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
      call: () => _client.admin.postSchoolData(schoolData),
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
      return result.path;
    }
    return null;
  }

  /// Get school logo image
  Future<ByteData?> getLogoImage(String documentId) async {
    return await _client.files.getImage(documentId);
  }

  /// Get official seal image
  Future<ByteData?> getOfficialSealImage(String documentId) async {
    return await _client.files.getImage(documentId);
  }
}

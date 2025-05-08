import 'package:school_data_hub_server/src/generated/protocol.dart';

PupilData generatePupilfromExternalAdminConsoleData(String importedLine) {
  // Split the line by commas and trim whitespace
  final data = importedLine.split(',').map((e) => e.trim()).toList();

  bool afterSchoolCare = false;
  if (data[14] == 'OFFGANZ' || data[14] == 'true') {
    afterSchoolCare = true;
    print('After school care: $afterSchoolCare');
  }
  // Create a PupilData object from the data
  return PupilData(
      active: true,
      internalId: int.parse(data[0]),
      preSchoolMedical: _defaultPreSchoolMedical,
      publicMediaAuth: _publicMediaAuth,
      publicMediaAuthDocumentId: null,
      afterSchoolCare: afterSchoolCare == true ? _afterSchoolCare : null,
      credit: 1,
      creditEarned: 1,
      swimmer: null);
}

//TODO: This should be written to the database

final _defaultPreSchoolMedical = PreSchoolMedical(
  preschoolMedicalStatus: PreSchoolMedicalStatus.notAvailable,
  preschoolMedicalFiles: null,
  createdBy: 'ADM',
  createdAt: DateTime.now().toUtc(),
);

final _publicMediaAuth = PublicMediaAuth(
  groupPicturesOnWebsite: false,
  groupPicturesInPress: false,
  portraitPicturesOnWebsite: false,
  portraitPicturesInPress: false,
  nameOnWebsite: false,
  nameInPress: false,
  videoOnWebsite: false,
  videoInPress: false,
  createdBy: 'ADM',
  createdAt: DateTime.now().toUtc(),
);

final _afterSchoolCare = AfterSchoolCare();

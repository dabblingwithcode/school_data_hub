import 'package:school_data_hub_server/src/generated/protocol.dart';

PupilData? generatePupilfromExternalAdminConsoleData(String importedLine) {
  // Split the line by commas and trim whitespace
  final data = importedLine.split(',').map((e) => e.trim()).toList();

  // Check if the data has the expected number of fields
  if (data.length != 3) {
    throw Exception('Invalid CSV format: $importedLine');
  }

  // Create a PupilData object from the data
  return null;

  // PupilData(
  //     internalId: int.parse(data[0]),
  //     avatarId: null,
  //     avatarAuth: false,
  //     avatarAuthId: null,
  //     avatarAuthPath: null,
  //     publicMediaAuth: PublicMediaAuth(
  //       groupPicturesOnWebsite: false,
  //       groupPicturesInPress: false,
  //       portraitPicturesOnWebsite: false,
  //       portraitPicturesInPress: false,
  //       nameOnWebsite: false,
  //       nameInPress: false,
  //       videoOnWebsite: false,
  //       videoInPress: false,
  //     ),
  //     publicMediaAuthId: null,
  //     publicMediaAuthPath: null,
  //     contact: null,
  //     parentsContact: null,
  //     credit: 1,
  //     creditEarned: 0,
  //     repeaterSince: null,
  //     latestSupportLevel: null,
  //     ogs: data[1] == "OFFGANZ" ? true : false,
  //     ogsInfo: null,
  //     preSchoolRevision: PreSchoolRevision.notAvailable,
  //     emergencyCare: false,
  //     pupilDataParentInfo: PupilDataParentInfo());
}

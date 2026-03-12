import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Creates a new PupilData from an external admin console CSV line
/// and inserts it with its related PreSchoolMedical record.
Future<PupilData> createPupilFromExternalAdminConsoleData(
  Session session,
  String importedLine, {
  Transaction? transaction,
}) async {
  final data = importedLine.split(',');

  bool afterSchoolCare = data[1].toLowerCase() == 'true';

  final pupil = await PupilData.db.insertRow(
    session,
    PupilData(
      status: PupilStatus.active,
      internalId: int.parse(data[0]),
      publicMediaAuth: _defaultPublicMediaAuth(),
      publicMediaAuthDocumentId: null,
      afterSchoolCare: afterSchoolCare ? AfterSchoolCare() : null,
      credit: 1,
      creditEarned: 1,
      swimmer: null,
    ),
    transaction: transaction,
  );

  final preSchoolMedical = await PreSchoolMedical.db.insertRow(
    session,
    PreSchoolMedical(
      preschoolMedicalStatus: PreSchoolMedicalStatus.notAvailable,
      preschoolMedicalFiles: null,
      createdBy: 'ADM',
      createdAt: DateTime.now().toUtc(),
    ),
    transaction: transaction,
  );

  await PupilData.db.attachRow.preSchoolMedical(
    session,
    pupil,
    preSchoolMedical,
    transaction: transaction,
  );

  return pupil;
}

PublicMediaAuth _defaultPublicMediaAuth() => PublicMediaAuth(
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

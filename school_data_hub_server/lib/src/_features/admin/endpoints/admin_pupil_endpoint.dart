import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/helpers/generate_pupil_from_admin_console_data.dart';
import 'package:serverpod/serverpod.dart';

/// Endpoint for admin-only pupil operations (e.g. updating backend from external source).
class AdminPupilEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {Scope('serverpod.admin')};

  /// Updates backend pupil state from reduced sync content. Admin only.
  /// [reducedContent] is newline-separated lines, each line "internalId,afterSchoolCare"
  /// with afterSchoolCare as "true" or "false".
  Future<Set<PupilData>> updateBackendPupilDataState(
      Session session, String reducedContent) async {
    final content = reducedContent;

    // get all active pupils from the database and create a list
    final activePupils = await PupilData.db
        .find(session, where: (t) => t.status.equals(PupilStatus.active));

    // we monitor the pupils that we haven't processed yet
    final List<PupilData> unprocessedPupilsList = List.from(activePupils);
    session.log('Unprocessed pupils: $unprocessedPupilsList');

    final List<String> lines = LineSplitter.split(content).toList();

    await session.db.transaction((transaction) async {
      for (final line in lines) {
        // Check if the pupil is already in the database
        final PupilData? existingPupil = unprocessedPupilsList.firstWhereOrNull(
          (pupil) => pupil.internalId == int.parse(line.split(',')[0]),
        );

        if (existingPupil != null) {
          // If the pupil exists, we process it updating just the after care status
          // This is the second string of the line
          if (line.split(',')[1] == 'true') {
            // we check if the after school care is set
            // if it is already set we leave it alone
            // if not, we set the after school care as an empty object
            // the user will have to fill it later
            if (existingPupil.afterSchoolCare == null) {
              existingPupil.afterSchoolCare = AfterSchoolCare();
              await PupilData.db
                  .updateRow(session, existingPupil, transaction: transaction);
            }
          } else {
            // there is no entry for after School care
            // if the existing pupil has an after school care entry, we remove it
            if (existingPupil.afterSchoolCare != null) {
              existingPupil.afterSchoolCare = null;
              await PupilData.db
                  .updateRow(session, existingPupil, transaction: transaction);
            }
          }
          // we have processed the pupil, let's remove it from the unprocessed list
          unprocessedPupilsList.remove(existingPupil);
        } else {
          // The pupil is not in the active pupils list
          // We first need to check if it exists but is inactive and should be activated
          // if it doesn't exist, we'll create a new one
          final inactivePupil = await PupilData.db.findFirstRow(
            session,
            where: (t) => t.internalId.equals(int.parse(line.split(',')[0])),
            transaction: transaction,
          );
          if (inactivePupil != null) {
            // If the pupil exists, we just activate it and update the after school care status
            inactivePupil.status = PupilStatus.active;
            inactivePupil.afterSchoolCare =
                line.split(',')[1] == 'true' ? AfterSchoolCare() : null;
            await PupilData.db
                .updateRow(session, inactivePupil, transaction: transaction);
          } else {
            await createPupilFromExternalAdminConsoleData(
              session, line, transaction: transaction,
            );
          }
        }
      }
      // if there are unprocessed pupils, they are not active in the school data system
      // so we set them to inactive
      for (final pupil in unprocessedPupilsList) {
        pupil.status = PupilStatus.inactive;
        await PupilData.db.updateRow(session, pupil, transaction: transaction);
      }
    });

    // we return the updated set of pupils that are active in the school data system
    final pupils = await PupilData.db
        .find(session, where: (t) => t.status.equals(PupilStatus.active));
    return pupils.toSet();
  }
}

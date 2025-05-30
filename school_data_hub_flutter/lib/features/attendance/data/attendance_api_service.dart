import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/schoolday/domain/schoolday_manager.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('AttendanceApiService');
final _client = di<Client>();
final _session = di<HubSessionManager>();
final _schooldayManager = di<SchooldayManager>();
final _notificationService = di<NotificationService>();

class AttendanceApiService {
//- fetch all missed classes -//

  Future<List<MissedClass>> fetchAllMissedClasses() async {
    final missedClasses = await ClientHelper.apiCall(
      call: () => _client.missedClass.fetchAllMissedClasses(),
      errorMessage: 'Fehler beim Laden der Fehlzeiten',
    );
    return missedClasses;
  }

  //- fetch missed classes for a date -//

  Future<List<MissedClass>> fetchMissedClassesOnASchoolday(
      DateTime schoolday) async {
    final missedClasses = await ClientHelper.apiCall(
      call: () => _client.missedClass.fetchMissedClassesOnASchoolday(schoolday),
      errorMessage: 'Fehler beim Laden der Fehlzeiten',
    );
    return missedClasses;
  }

  //- post new class -//

  Future<MissedClass> postMissedClass({
    required int pupilId,
    required MissedType missedType,
    required DateTime date,
    int? minutesLate,
    bool? writtenExcuse,
    bool? unexcused,
    bool? returned,
    DateTime? returnedAt,
    ContactedType? contactedType,
  }) async {
    final missedSchoolday = _schooldayManager.getSchooldayByDate(date);
    final MissedClass missedClass = MissedClass(
        missedType: missedType,
        unexcused: unexcused ?? false,
        contacted: contactedType ?? ContactedType.notSet,
        returned: returned ?? false,
        writtenExcuse: writtenExcuse ?? false,
        createdBy: _session.signedInUser!.userName!,
        schooldayId: missedSchoolday!.id!,
        pupilId: pupilId);

    final missedClasse = await ClientHelper.apiCall(
      call: () => _client.missedClass.postMissedClass(missedClass),
      errorMessage: 'Fehler beim Eintragen der Fehlzeit',
    );
    return missedClasse;
  }

  //- post a list of missed classes -//

  Future<List<MissedClass>> postMissedClassList(
      {required List<MissedClass> missedClasses}) async {
    final missedClassesList = await ClientHelper.apiCall(
      call: () => _client.missedClass.postMissedClasses(missedClasses),
      errorMessage: 'Fehler beim Eintragen der Fehlzeiten',
    );
    return missedClassesList;
  }

  //- patch a missed class -//

  Future<MissedClass> updateMissedClass({
    required MissedClass missedClassToUpdate,
  }) async {
    final missedClass = await ClientHelper.apiCall(
      call: () => _client.missedClass.updateMissedClass(missedClassToUpdate),
      errorMessage: 'Fehler beim Aktualisieren der Fehlzeit',
    );
    return missedClass;
  }

  //- delete missed class -//

  Future<bool> deleteMissedClass(int pupilId, int schooldayId) async {
    _notificationService.apiRunning(true);
    final success = await ClientHelper.apiCall(
      call: () => _client.missedClass.deleteMissedClass(pupilId, schooldayId),
      errorMessage: 'Fehler beim Löschen der Fehlzeit',
    );
    return success;
  }
}

import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:watch_it/watch_it.dart';

final _client = di<Client>();
final _session = di<HubSessionManager>();
final _schoolCalendarManager = di<SchoolCalendarManager>();
final _notificationService = di<NotificationService>();

class AttendanceApiService {
//- fetch all missed classes -//

  Future<List<MissedSchoolday>?> fetchAllMissedSchooldayes() async {
    final missedSchooldays = await ClientHelper.apiCall(
      call: () => _client.missedSchoolday.fetchAllMissedSchooldayes(),
      errorMessage: 'Fehler beim Laden der Fehlzeiten',
    );
    return missedSchooldays;
  }

  //- fetch missed classes for a date -//

  Future<List<MissedSchoolday>?> fetchMissedSchooldayesOnASchoolday(
      DateTime schoolday) async {
    final missedSchooldays = await ClientHelper.apiCall(
      call: () =>
          _client.missedSchoolday.fetchMissedSchooldayesOnASchoolday(schoolday),
      errorMessage: 'Fehler beim Laden der Fehlzeiten',
    );
    return missedSchooldays;
  }

  //- post new class -//

  Future<MissedSchoolday?> postMissedSchoolday({
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
    final schoolday = _schoolCalendarManager.getSchooldayByDate(date);
    final MissedSchoolday missedSchoolday = MissedSchoolday(
        missedType: missedType,
        unexcused: unexcused ?? false,
        contacted: contactedType ?? ContactedType.notSet,
        returned: returned ?? false,
        writtenExcuse: writtenExcuse ?? false,
        createdBy: _session.signedInUser!.userName!,
        schooldayId: schoolday!.id!,
        pupilId: pupilId);

    final missedSchooldayResponse = await ClientHelper.apiCall(
      call: () => _client.missedSchoolday.postMissedSchoolday(missedSchoolday),
      errorMessage: 'Fehler beim Eintragen der Fehlzeit',
    );
    return missedSchooldayResponse;
  }

  //- post a list of missed classes -//

  Future<List<MissedSchoolday>?> postMissedSchooldayList(
      {required List<MissedSchoolday> missedSchooldays}) async {
    final missedSchooldaysList = await ClientHelper.apiCall(
      call: () =>
          _client.missedSchoolday.postMissedSchooldayes(missedSchooldays),
      errorMessage: 'Fehler beim Eintragen der Fehlzeiten',
    );
    return missedSchooldaysList;
  }

  //- patch a missed class -//

  Future<MissedSchoolday?> updateMissedSchoolday({
    required MissedSchoolday missedSchooldayToUpdate,
  }) async {
    final missedSchoolday = await ClientHelper.apiCall(
      call: () => _client.missedSchoolday
          .updateMissedSchoolday(missedSchooldayToUpdate),
      errorMessage: 'Fehler beim Aktualisieren der Fehlzeit',
    );
    return missedSchoolday;
  }

  //- delete missed class -//

  Future<bool?> deleteMissedSchoolday(int pupilId, int schooldayId) async {
    _notificationService.apiRunning(true);
    final success = await ClientHelper.apiCall(
      call: () =>
          _client.missedSchoolday.deleteMissedSchoolday(pupilId, schooldayId),
      errorMessage: 'Fehler beim Löschen der Fehlzeit',
    );
    return success;
  }
}

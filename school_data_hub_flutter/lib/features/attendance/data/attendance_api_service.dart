import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/schoolday/domain/schoolday_manager.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('AttendanceApiService');
final _client = di<Client>();
final _session = di<ServerpodSessionManager>();
final _schooldayManager = di<SchooldayManager>();
final _notificationService = di<NotificationService>();

class AttendanceApiService {
//- fetch all missed classes -//

  Future<List<MissedClass>> fetchAllMissedClasses() async {
    try {
      _notificationService.apiRunning(true);
      final missedClasses = await _client.missedClass.fetchAllMissedClasses();
      _notificationService.apiRunning(false);
      return missedClasses;
    } catch (e) {
      _notificationService.apiRunning(false);
      _notificationService.showSnackBar(NotificationType.error, 'Fehler: $e');
      _log.severe('Error fetching all missed classes', e);
    }

    return [];
  }

  //- fetch missed classes for a date -//

  Future<List<MissedClass>> fetchMissedClassesOnASchoolday(
      DateTime schoolday) async {
    // This one is called every 10 seconds, isRunning would be annoying

    try {
      _notificationService.apiRunning(true);
      final missedClasses =
          await _client.missedClass.fetchMissedClassesOnASchoolday(schoolday);
      _notificationService.apiRunning(false);
      return missedClasses;
    } catch (e) {
      _notificationService.apiRunning(false);
      _notificationService.showSnackBar(NotificationType.error, 'Fehler: $e');
      _log.severe('Error fetching missed classes on a schoolday', e);
    }

    return [];
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
    String? returnedAt,
    ContactedType? contactedType,
  }) async {
    final missedSchoolday = _schooldayManager.getSchooldayByDate(date);
    final MissedClass missedClass = MissedClass(
        missedType: missedType.value,
        unexcused: unexcused ?? false,
        contacted: contactedType?.value ?? '0',
        returned: returned ?? false,
        writtenExcuse: writtenExcuse ?? false,
        createdBy: _session.signedInUser!.userName!,
        schooldayId: missedSchoolday!.id!,
        pupilId: pupilId);

    try {
      _notificationService.apiRunning(true);
      final newMissedClass = await _client.missedClass.postMissedClass(
        missedClass,
      );
      _notificationService.apiRunning(false);
      return newMissedClass;
    } catch (e) {
      _notificationService.apiRunning(false);
      _notificationService.showSnackBar(NotificationType.error, 'Fehler: $e');
      _log.severe('Error posting missed class', e);

      throw Exception(
        'Error posting missed class: $e',
      );
    }
  }

  //- post a list of missed classes -//

  Future<List<MissedClass>> postMissedClassList(
      {required List<MissedClass> missedClasses}) async {
    try {
      _notificationService.apiRunning(true);
      final missedClassesList = await _client.missedClass.postMissedClasses(
        missedClasses,
      );
      _notificationService.apiRunning(false);
      return missedClassesList;
    } catch (e) {
      _notificationService.apiRunning(false);
      _notificationService.showSnackBar(NotificationType.error, 'Fehler: $e');
      _log.severe('Error posting missed class list', e);
      throw Exception(
        'Error posting missed class list: $e',
      );
    }
  }

  //- patch a missed class -//

  Future<MissedClass> updateMissedClass({
    required int pupilId,
    required DateTime date,
    MissedType? missedType,
    int? minutesLate,
    bool? writtenExcuse,
    bool? excused,
    bool? returned,
    String? returnedAt,
    ContactedType? contactedType,
    String? comment,
  }) async {
    _notificationService.apiRunning(true);
    final schoolday = _schooldayManager.getSchooldayByDate(date);
    final MissedClass missedClassToUpdate = MissedClass(
      missedType: missedType?.value ?? '0',
      unexcused: excused ?? false,
      contacted: contactedType?.value ?? '0',
      returned: returned ?? false,
      writtenExcuse: writtenExcuse ?? false,
      createdBy: _session.signedInUser!.userName!,
      pupilId: pupilId,
      schooldayId: schoolday!.id!,
    );
    try {
      _notificationService.apiRunning(true);
      final missedClass = await _client.missedClass.updateMissedClass(
        missedClassToUpdate,
      );
      _notificationService.apiRunning(false);
      return missedClass;
    } catch (e) {
      _notificationService.apiRunning(false);
      _notificationService.showSnackBar(NotificationType.error, 'Fehler: $e');
      _log.severe('Error updating missed class', e);
      throw Exception(
        'Error updating missed class: $e',
      );
    }
  }

  //- delete missed class -//

  Future<bool> deleteMissedClass(int internalId, DateTime date) async {
    _notificationService.apiRunning(true);

    try {
      _notificationService.apiRunning(true);
      final response = await _client.missedClass.deleteMissedClass(
        internalId,
        date,
      );
      _notificationService.apiRunning(false);
      return response;
    } catch (e) {
      _notificationService.apiRunning(false);
      _notificationService.showSnackBar(NotificationType.error, 'Fehler: $e');
      _log.severe('Error deleting missed class', e);
      throw Exception(
        'Error deleting missed class: $e',
      );
    }
  }
}

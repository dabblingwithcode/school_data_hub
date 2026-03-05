import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/data/attendance_api_service.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/models/pupil_missed_classes_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:flutter_it/flutter_it.dart';

class AttendanceManager with ChangeNotifier {
  PupilProxyManager get _pupilManager => di<PupilProxyManager>();
  SchoolCalendarManager get _schoolCalendarManager =>
      di<SchoolCalendarManager>();
  NotificationService get _notificationService => di<NotificationService>();
  HubSessionManager get _sessionManager => di<HubSessionManager>();

  final _log = Logger('AttendanceManager');
  final _attendanceApiService = AttendanceApiService();

  final _missedSchooldays = ListNotifier<MissedSchoolday>();

  ValueListenable<List<MissedSchoolday>> get missedSchooldays =>
      _missedSchooldays;

  final Map<int, PupilMissedSchooldaysProxy> _pupilMissedSchooldaysMap = {};

  AttendanceManager() {
    init();
  }

  @override
  void dispose() {
    _pupilMissedSchooldaysMap.clear();
    _missedSchooldays.dispose();
    super.dispose();
  }

  Future<void> init() async {
    final pupilIds = _pupilManager.allPupils.map((e) => e.pupilId).toList();
    for (final pupilId in pupilIds) {
      _pupilMissedSchooldaysMap[pupilId] = PupilMissedSchooldaysProxy();
    }
    fetchAllPupilMissedSchooldayes();
  }

  //- Getters

  MissedSchoolday? getPupilMissedSchooldayOnDate(int pupilId, DateTime date) {
    return _pupilMissedSchooldaysMap[pupilId]!.missedSchooldays
        .firstWhereOrNull(
          (element) => element.schoolday!.schoolday.isSameDate(date),
        );
  }

  List<MissedSchoolday> getAllPupilMissedSchooldays(int pupilId) {
    return _pupilMissedSchooldaysMap[pupilId]!.missedSchooldays;
  }

  PupilMissedSchooldaysProxy getPupilMissedSchooldaysProxy(int pupilId) {
    if (!_pupilMissedSchooldaysMap.containsKey(pupilId)) {
      _log.warning(
        'No PupilMissedSchooldaysProxy found for pupilId: $pupilId - creating a new one',
      );
      _pupilMissedSchooldaysMap[pupilId] = PupilMissedSchooldaysProxy();
    }
    return _pupilMissedSchooldaysMap[pupilId]!;
  }

  /// Missed schooldays grouped by date (local date-only key). Null schoolday skipped.
  Map<DateTime, List<MissedSchoolday>> get missedSchooldaysByDate {
    final byDate = <DateTime, List<MissedSchoolday>>{};
    for (final missed in _missedSchooldays.value) {
      if (missed.schoolday == null) continue;
      final d = missed.schoolday!.schoolday.toLocal();
      final key = DateTime(d.year, d.month, d.day);
      byDate.putIfAbsent(key, () => []).add(missed);
    }
    return byDate;
  }

  /// Count of missed schooldays per date (derived from [missedSchooldaysByDate]).
  Map<DateTime, int> get missedSchooldaysCountByDate =>
      missedSchooldaysByDate.map((k, v) => MapEntry(k, v.length));

  //- Handle collections

  void _updateMissedSchooldayesInCollections(
    List<MissedSchoolday> missedSchooldays,
  ) {
    _missedSchooldays.startTransAction();
    for (final missedSchoolday in missedSchooldays) {
      _updateCollectionsWithSingleEntry(missedSchoolday);
    }
    _missedSchooldays.endTransAction();
  }

  void _updateCollectionsWithSingleEntry(
    MissedSchoolday responseMissedSchoolday,
  ) {
    final date = responseMissedSchoolday.schoolday!.schoolday;
    final pupilId = responseMissedSchoolday.pupilId;

    if (!_pupilMissedSchooldaysMap.containsKey(pupilId)) {
      _pupilMissedSchooldaysMap[pupilId] = PupilMissedSchooldaysProxy();
    }
    _pupilMissedSchooldaysMap[pupilId]!
        .updateMissedSchoolday(responseMissedSchoolday);

    final index = _missedSchooldays.value.indexWhere(
      (e) => e.schoolday!.schoolday == date && e.pupilId == pupilId,
    );
    if (index != -1) {
      _missedSchooldays[index] = responseMissedSchoolday;
    } else {
      _missedSchooldays.add(responseMissedSchoolday);
    }
  }

  void updateMissedSchooldayInCollections(
    MissedSchoolday responseMissedSchoolday,
  ) {
    _updateCollectionsWithSingleEntry(responseMissedSchoolday);
  }

  void removeMissedSchooldayFromCollections(int pupilId, DateTime date) {
    _pupilMissedSchooldaysMap[pupilId]?.removeMissedSchoolday(pupilId, date);

    final index = _missedSchooldays.value.indexWhere(
      (e) => e.schoolday!.schoolday == date && e.pupilId == pupilId,
    );
    if (index != -1) {
      _missedSchooldays.removeAt(index);
    }
  }

  //- Stream entry points (called by HubStreamService)

  void upsertFromStream(MissedSchoolday missedSchoolday) {
    _log.fine('[STREAM] upsert missedSchoolday ${missedSchoolday.id}');
    updateMissedSchooldayInCollections(missedSchoolday);
  }

  void deleteFromStream(int id) {
    _log.fine('[STREAM] delete missedSchoolday $id');
    final entry = _missedSchooldays.value.firstWhereOrNull((e) => e.id == id);
    if (entry == null) return;
    removeMissedSchooldayFromCollections(
      entry.pupilId,
      entry.schoolday!.schoolday,
    );
  }

  //- CRUD operations

  void fetchAllPupilMissedSchooldayes() async {
    final fetchedMissedSchooldayes =
        await _attendanceApiService.fetchAllMissedSchooldayes();
    if (fetchedMissedSchooldayes == null) return;
    _updateMissedSchooldayesInCollections(fetchedMissedSchooldayes);
  }

  Future<void> fetchMissedSchooldayesOnASchoolday(DateTime schoolday) async {
    _log.info('fetchMissedSchooldayesOnASchoolday $schoolday');
    final List<MissedSchoolday>? missedSchooldays = await _attendanceApiService
        .fetchMissedSchooldayesOnASchoolday(schoolday.toUtc());
    if (missedSchooldays == null) return;
    _updateMissedSchooldayesInCollections(missedSchooldays);
  }

  Future<void> updateUnexcusedValue(
    int pupilId,
    DateTime date,
    bool newValue,
  ) async {
    final missedSchoolday = getPupilMissedSchooldayOnDate(pupilId, date);

    if (missedSchoolday == null) {
      return;
    }
    final missedSchooldayToUpdate = missedSchoolday.copyWith(
      unexcused: newValue,
      modifiedBy: _sessionManager.signedInUser!.userName!,
    );
    final MissedSchoolday? responseMissedSchoolday = await _attendanceApiService
        .updateMissedSchoolday(
          missedSchooldayToUpdate: missedSchooldayToUpdate,
        );

    if (responseMissedSchoolday == null) {
      return;
    }
    updateMissedSchooldayInCollections(responseMissedSchoolday);
  }

  Future<void> deleteMissedSchoolday(int pupilId, DateTime date) async {
    final response = await _attendanceApiService.deleteMissedSchoolday(
      pupilId,
      _schoolCalendarManager.getSchooldayByDate(date)!.id!,
    );

    if (response == true) {
      removeMissedSchooldayFromCollections(pupilId, date.toUtc());
      _notificationService.showSnackBar(
        NotificationType.success,
        'Fehlzeit erfolgreich gelöscht!',
      );
    } else {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehlzeit konnte nicht gelöscht werden!',
      );
    }
  }

  Future<void> updateReturnedValue(
    int pupilId,
    bool newValue,
    DateTime date,
    DateTime? returnedDateTime,
  ) async {
    final missedSchoolday = getPupilMissedSchooldayOnDate(pupilId, date);

    if (missedSchoolday == null) {
      final MissedSchoolday? newMissedSchoolday = await _attendanceApiService
          .postMissedSchoolday(
            pupilId: pupilId,
            missedType: MissedType.notSet,
            date: date,
            unexcused: false,
            contactedType: ContactedType.notSet,
            returned: true,
            returnedAt: returnedDateTime?.toUtc(),
          );
      if (newMissedSchoolday == null) {
        return;
      }
      updateMissedSchooldayInCollections(newMissedSchoolday);
      _notificationService.showSnackBar(
        NotificationType.success,
        'Eintrag erfolgreich!',
      );
      return;
    }

    if (newValue == false && missedSchoolday.missedType == MissedType.notSet) {
      final success = await _attendanceApiService.deleteMissedSchoolday(
        pupilId,
        _schoolCalendarManager.getSchooldayByDate(date)!.id!,
      );
      if (success == true) {
        removeMissedSchooldayFromCollections(pupilId, date.toUtc());
        _notificationService.showSnackBar(
          NotificationType.success,
          'Eintrag erfolgreich gelöscht!',
        );
      } else {
        _notificationService.showSnackBar(
          NotificationType.error,
          'Eintrag konnte nicht gelöscht werden!',
        );
      }
      return;
    }

    if (newValue == true) {
      final missedSchooldayToUpdate = missedSchoolday.copyWith(
        returned: newValue,
        returnedAt: returnedDateTime?.toUtc(),
        modifiedBy: _sessionManager.signedInUser!.userName!,
      );
      final MissedSchoolday? updatedMissedSchoolday =
          await _attendanceApiService.updateMissedSchoolday(
            missedSchooldayToUpdate: missedSchooldayToUpdate,
          );
      if (updatedMissedSchoolday == null) {
        return;
      }
      updateMissedSchooldayInCollections(updatedMissedSchoolday);
    } else {
      final missedSchooldayToUpdate = missedSchoolday.copyWith(
        returned: newValue,
        returnedAt: null,
        modifiedBy: _sessionManager.signedInUser!.userName!,
      );
      final MissedSchoolday? updatedMissedSchoolday =
          await _attendanceApiService.updateMissedSchoolday(
            missedSchooldayToUpdate: missedSchooldayToUpdate,
          );
      if (updatedMissedSchoolday == null) {
        return;
      }
      updateMissedSchooldayInCollections(updatedMissedSchoolday);
    }
  }

  Future<void> updateLateTypeValue(
    int pupilId,
    MissedType dropdownValue,
    DateTime date,
    int minutesLate,
  ) async {
    final missedSchoolday = getPupilMissedSchooldayOnDate(pupilId, date);

    if (missedSchoolday == null) {
      final MissedSchoolday? updatedMissedSchoolday =
          await _attendanceApiService.postMissedSchoolday(
            pupilId: pupilId,
            missedType: dropdownValue,
            date: date,
            minutesLate: minutesLate,
            unexcused: false,
            contactedType: ContactedType.notSet,
            returned: false,
            returnedAt: null,
            writtenExcuse: null,
          );
      if (updatedMissedSchoolday == null) {
        return;
      }
      updateMissedSchooldayInCollections(updatedMissedSchoolday);
      return;
    }

    final missedSchooldayToUpdate = missedSchoolday.copyWith(
      missedType: dropdownValue,
      minutesLate: minutesLate,
      modifiedBy: _sessionManager.signedInUser!.userName!,
    );
    final MissedSchoolday? updatedMissedSchoolday =
        await _attendanceApiService.updateMissedSchoolday(
          missedSchooldayToUpdate: missedSchooldayToUpdate,
        );
    if (updatedMissedSchoolday == null) {
      return;
    }
    updateMissedSchooldayInCollections(updatedMissedSchoolday);
  }

  Future<void> updateCommentValue(
    int pupilId,
    String? comment,
    DateTime date,
  ) async {
    final MissedSchoolday? missedSchoolday = getPupilMissedSchooldayOnDate(
      pupilId,
      date,
    );

    if (missedSchoolday == null) {
      return;
    }
    final missedSchooldayToUpdate = missedSchoolday.copyWith(
      comment: comment,
      modifiedBy: _sessionManager.signedInUser!.userName!,
    );
    final MissedSchoolday? updatedMissedSchoolday =
        await _attendanceApiService.updateMissedSchoolday(
          missedSchooldayToUpdate: missedSchooldayToUpdate,
        );
    if (updatedMissedSchoolday == null) {
      return;
    }
    updateMissedSchooldayInCollections(updatedMissedSchoolday);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Eintrag erfolgreich!',
    );
  }

  Future<void> postManyMissedSchooldays({
    required int id,
    required DateTime startdate,
    required DateTime enddate,
    required MissedType missedType,
    String? comment,
  }) async {
    List<MissedSchoolday> missedSchooldays = [];

    final List<DateTime> validSchooldays =
        _schoolCalendarManager.availableDates.value;

    for (DateTime validSchoolday in validSchooldays) {
      if (validSchoolday.isSameDate(startdate) ||
          validSchoolday.isSameDate(enddate) ||
          (validSchoolday.isAfterDate(startdate) &&
              validSchoolday.isBeforeDate(enddate))) {
        final schoolday = _schoolCalendarManager.getSchooldayByDate(
          validSchoolday,
        );
        missedSchooldays.add(
          MissedSchoolday(
            createdBy: _sessionManager.signedInUser!.userName!,
            pupilId: id,
            schoolday: schoolday,
            missedType: missedType,
            unexcused: false,
            contacted: ContactedType.notSet,
            returned: false,
            returnedAt: null,
            minutesLate: null,
            writtenExcuse: false,
            modifiedBy: null,
            comment: comment,
            schooldayId: schoolday!.id!,
          ),
        );
      }
    }
    final List<MissedSchoolday>? responseMissedSchooldayes =
        await _attendanceApiService.postMissedSchooldayList(
          missedSchooldays: missedSchooldays,
        );
    if (responseMissedSchooldayes == null) {
      return;
    }
    for (final MissedSchoolday responseMissedSchoolday
        in responseMissedSchooldayes) {
      updateMissedSchooldayInCollections(responseMissedSchoolday);
    }
    _notificationService.showSnackBar(
      NotificationType.success,
      'Einträge erfolgreich!',
    );
  }

  Future<void> updateMissedTypeValue(
    int pupilId,
    MissedType missedType,
    DateTime date,
  ) async {
    if (missedType == MissedType.notSet) {
      await deleteMissedSchoolday(pupilId, date);
      return;
    }

    final missedSchoolday = getPupilMissedSchooldayOnDate(pupilId, date);

    if (missedSchoolday == null) {
      _log.info('This missed class is new');

      final MissedSchoolday? updatedMissedSchoolday =
          await _attendanceApiService.postMissedSchoolday(
            pupilId: pupilId,
            missedType: missedType,
            date: date,
          );
      if (updatedMissedSchoolday == null) {
        return;
      }
      updateMissedSchooldayInCollections(updatedMissedSchoolday);

      _notificationService.showSnackBar(
        NotificationType.success,
        'Eintrag erfolgreich!',
      );
      return;
    }

    final missedSchooldayToUpdate = missedSchoolday.copyWith(
      missedType: missedType,
      minutesLate: null,
      modifiedBy: _sessionManager.signedInUser!.userName!,
    );
    final MissedSchoolday? updatedMissedSchoolday =
        await _attendanceApiService.updateMissedSchoolday(
          missedSchooldayToUpdate: missedSchooldayToUpdate,
        );
    if (updatedMissedSchoolday == null) {
      return;
    }
    updateMissedSchooldayInCollections(updatedMissedSchoolday);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Eintrag erfolgreich!',
    );
  }

  Future<void> updateContactedValue(
    int pupilId,
    ContactedType contactedType,
    DateTime date,
  ) async {
    final MissedSchoolday? missedSchoolday = getPupilMissedSchooldayOnDate(
      pupilId,
      date,
    );
    if (missedSchoolday == null) {
      return;
    }
    final missedSchooldayToUpdate = missedSchoolday.copyWith(
      contacted: contactedType,
      modifiedBy: _sessionManager.signedInUser!.userName!,
    );
    final MissedSchoolday? updatedMissedSchoolday =
        await _attendanceApiService.updateMissedSchoolday(
          missedSchooldayToUpdate: missedSchooldayToUpdate,
        );
    if (updatedMissedSchoolday == null) {
      return;
    }
    updateMissedSchooldayInCollections(updatedMissedSchoolday);
    _notificationService.showSnackBar(
      NotificationType.success,
      'Eintrag erfolgreich!',
    );
  }
}

import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:flutter_it/flutter_it.dart';

class AttendanceStatsHelper {
  static AttendanceManager get _attendanceManager => di<AttendanceManager>();
  static PupilProxyManager get _pupilManager => di<PupilProxyManager>();

  //- Private helper methods

  static List<MissedSchoolday> _getMissedSchooldays(int pupilId) {
    return _attendanceManager
        .getPupilMissedSchooldaysProxy(pupilId)
        .missedSchooldays;
  }

  static int _countForPupil(
    PupilProxy pupil,
    bool Function(MissedSchoolday) predicate,
  ) {
    return _getMissedSchooldays(pupil.pupilId).where(predicate).length;
  }

  static int _globalSum(bool Function(MissedSchoolday) predicate) {
    return _pupilManager.allPupils.fold(0, (sum, pupil) {
      return sum + _getMissedSchooldays(pupil.pupilId).where(predicate).length;
    });
  }

  //- Global sums (of all pupils)

  static int missedGlobalSum() => _globalSum(
    (e) =>
        e.missedType == MissedType.missed ||
        e.missedType == MissedType.home ||
        e.returned == true,
  );

  static int unexcusedGlobalSum() => _globalSum(
    (e) => e.missedType == MissedType.missed && e.unexcused == true,
  );

  static int lateGlobalSum() =>
      _globalSum((e) => e.missedType == MissedType.late);

  static int contactedGlobalSum() =>
      _globalSum((e) => e.contacted != ContactedType.notSet);

  static int pickedUpGlobalSum() => _globalSum((e) => e.returned == true);

  //- Sums of a list of pupils on a specific schoolday

  static int missedPupilsSum(
    List<PupilProxy> filteredPupils,
    DateTime thisDate,
  ) {
    return filteredPupils
        .where(
          (pupil) => _getMissedSchooldays(pupil.pupilId).any(
            (e) =>
                e.schoolday!.schoolday.isSameDate(thisDate) &&
                (e.missedType == MissedType.missed ||
                    e.missedType == MissedType.home ||
                    e.returned == true),
          ),
        )
        .length;
  }

  static int missedAndUnexcusedPupilsSum(
    List<PupilProxy> filteredPupils,
    DateTime thisDate,
  ) {
    return filteredPupils
        .where(
          (pupil) => _getMissedSchooldays(pupil.pupilId).any(
            (e) =>
                e.schoolday!.schoolday.isSameDate(thisDate) &&
                e.missedType == MissedType.missed &&
                e.unexcused == true,
          ),
        )
        .length;
  }

  //- Sums of a list of pupils (aggregated)

  static int pupilListMissedclassSum(List<PupilProxy> filteredPupils) =>
      filteredPupils.fold(
        0,
        (sum, pupil) => sum + missedclassExcusedSum(pupil),
      );

  static int pupilListUnexcusedSum(List<PupilProxy> filteredPupils) =>
      filteredPupils.fold(
        0,
        (sum, pupil) => sum + missedclassUnexcusedSum(pupil),
      );

  static int pupilListLateSum(List<PupilProxy> filteredPupils) =>
      filteredPupils.fold(0, (sum, pupil) => sum + lateSum(pupil));

  static int pupilListContactedSum(List<PupilProxy> filteredPupils) =>
      filteredPupils.fold(0, (sum, pupil) => sum + contactedSum(pupil));

  static int pupilListPickedUpSum(List<PupilProxy> filteredPupils) =>
      filteredPupils.fold(0, (sum, pupil) => sum + goneHomeSum(pupil));

  //- Single pupil sums

  static int missedclassExcusedSum(PupilProxy pupil) => _countForPupil(
    pupil,
    (e) => e.missedType == MissedType.missed && e.unexcused == false,
  );

  static int missedclassUnexcusedSum(PupilProxy pupil) => _countForPupil(
    pupil,
    (e) => e.missedType == MissedType.missed && e.unexcused == true,
  );

  static int lateSum(PupilProxy pupil) =>
      _countForPupil(pupil, (e) => e.missedType == MissedType.late);

  static int lateUnexcusedSum(PupilProxy pupil) => _countForPupil(
    pupil,
    (e) => e.missedType == MissedType.late && e.unexcused == true,
  );

  static int lateExcusedSum(PupilProxy pupil) => _countForPupil(
    pupil,
    (e) => e.missedType == MissedType.late && e.unexcused == false,
  );

  static int contactedSum(PupilProxy pupil) =>
      _countForPupil(pupil, (e) => e.contacted != ContactedType.notSet);

  static int goneHomeSum(PupilProxy pupil) =>
      _countForPupil(pupil, (e) => e.returned == true);
}

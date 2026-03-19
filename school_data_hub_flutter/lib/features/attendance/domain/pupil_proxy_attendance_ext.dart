import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_manager.dart';

extension PupilProxyAttendance on PupilProxy {
  List<MissedSchoolday>? get missedSchooldays =>
      di<AttendanceManager>().getAllPupilMissedSchooldays(pupilId);
}

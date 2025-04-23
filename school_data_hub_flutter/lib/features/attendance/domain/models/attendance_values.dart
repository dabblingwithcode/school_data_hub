import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/models/enums.dart';

class AttendanceValues {
  final MissedType missedTypeValue;
  final ContactedType contactedTypeValue;
  final String? createdOrModifiedByValue;
  final bool unexcusedValue;
  final bool returnedValue;
  final DateTime? returnedTimeValue;
  final String? commentValue;

  AttendanceValues({
    required this.missedTypeValue,
    required this.contactedTypeValue,
    required this.createdOrModifiedByValue,
    required this.unexcusedValue,
    this.returnedValue = false,
    this.returnedTimeValue,
    this.commentValue,
  });
}

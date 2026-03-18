import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/pupil_workbook_manager.dart';

extension PupilProxyWorkbooks on PupilProxy {
  List<PupilWorkbook>? get pupilWorkbooks =>
      di<PupilWorkbookManager>().getPupilWorkbooks(pupilId);
}

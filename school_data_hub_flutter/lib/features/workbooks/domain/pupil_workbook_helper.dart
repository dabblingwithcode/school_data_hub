import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/pupil_workbook_manager.dart';

class PupilWorkbookHelper {
  static ({int totalWorkbooks, int openWorkbooks, int finishedWorkbooks})
  countCompletedWorkbooks(List<PupilProxy> pupils) {
    int totalWorkbooks = 0;
    int finishedWorkbooks = 0;
    int openWorkbooks = 0;

    for (final pupil in pupils) {
      final pupilWorkbooks = di<PupilWorkbookManager>().getPupilWorkbooks(
        pupil.pupilId,
      );
      totalWorkbooks += pupilWorkbooks.length;
      openWorkbooks += pupilWorkbooks
          .where((workbook) => workbook.finishedAt == null)
          .length;
      finishedWorkbooks += pupilWorkbooks
          .where((workbook) => workbook.finishedAt != null)
          .length;
    }

    return (
      totalWorkbooks: totalWorkbooks,
      openWorkbooks: openWorkbooks,
      finishedWorkbooks: finishedWorkbooks,
    );
  }
}

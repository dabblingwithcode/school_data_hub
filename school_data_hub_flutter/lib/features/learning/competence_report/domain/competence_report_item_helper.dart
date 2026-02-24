import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/competence_report_item_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_manager.dart';

class CompetenceReportItemHelper {
  static List<CompetenceReportItem> getReportItemsForReport(
    CompetenceReport report,
  ) {
    SchoolGrade pupilGrade;
    pupilGrade = di<PupilProxyManager>()
        .getPupilByPupilId(report.pupilId)!
        .schoolGrade;
    // E3 pupils should count as E2 for the report items
    if (pupilGrade == SchoolGrade.E3) {
      pupilGrade = SchoolGrade.E2;
    }
    final reportItems = di<CompetenceReportItemManager>().items.value;
    return reportItems
        .where((item) => item.level!.contains(pupilGrade.name))
        .toList();
  }
}

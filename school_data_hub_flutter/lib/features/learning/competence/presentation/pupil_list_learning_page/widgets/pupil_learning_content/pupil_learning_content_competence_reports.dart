import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/competence_report_item_helper.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/competence_report_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';

class PupilLearningContentCompetenceReports extends WatchingWidget {
  final PupilProxy pupil;
  const PupilLearningContentCompetenceReports({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final reportManager = di<CompetenceReportManager>();
    final currentSchoolSemester =
        di<SchoolCalendarManager>().currentSemester.value;

    final reportsByPupil = watchValue(
      (CompetenceReportManager m) => m.reportsByPupil,
    );
    final reports = reportsByPupil[pupil.pupilId] ?? [];
    final report = reports.firstWhereOrNull(
      (report) => report.schoolSemesterId == currentSchoolSemester!.id,
    );
    if (report == null) {
      return const Text('Kein Zeugnis für das aktuelle Semester vorhanden');
    }
    final reportItems = CompetenceReportItemHelper.getReportItemsForReport(
      report,
    );
    if (reportItems.isEmpty) {
      return const Text(
        'Keine Zeugniskompetenzen für das aktuelle Semester vorhanden',
      );
    }

    final checks = report.competenceReportChecks ?? [];

    return _ReportCheckTree(
      items: reportItems,
      parentId: null,
      checks: checks,
      pupilId: pupil.pupilId,
      reportId: report.id!,
      reportManager: reportManager,
    );
  }
}

class _ReportCheckTree extends StatelessWidget {
  final List<CompetenceReportItem> items;
  final int? parentId;
  final List<CompetenceReportCheck> checks;
  final int pupilId;
  final int reportId;
  final CompetenceReportManager reportManager;

  const _ReportCheckTree({
    required this.items,
    required this.parentId,
    required this.checks,
    required this.pupilId,
    required this.reportId,
    required this.reportManager,
  });

  @override
  Widget build(BuildContext context) {
    final children = items.where((i) => i.parentItem == parentId).toList()
      ..sort((a, b) {
        if (a.order != null && b.order != null) {
          return a.order!.compareTo(b.order!);
        }
        if (a.order != null) return -1;
        if (b.order != null) return 1;
        return a.publicId.compareTo(b.publicId);
      });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in children)
          _ReportCheckNode(
            item: item,
            allItems: items,
            checks: checks,
            pupilId: pupilId,
            reportId: reportId,
            reportManager: reportManager,
          ),
      ],
    );
  }
}

class _ReportCheckNode extends StatelessWidget {
  final CompetenceReportItem item;
  final List<CompetenceReportItem> allItems;
  final List<CompetenceReportCheck> checks;
  final int pupilId;
  final int reportId;
  final CompetenceReportManager reportManager;

  const _ReportCheckNode({
    required this.item,
    required this.allItems,
    required this.checks,
    required this.pupilId,
    required this.reportId,
    required this.reportManager,
  });

  @override
  Widget build(BuildContext context) {
    final hasChildren = allItems.any((i) => i.parentItem == item.publicId);

    if (hasChildren) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: _ReportCheckTree(
                items: allItems,
                parentId: item.publicId,
                checks: checks,
                pupilId: pupilId,
                reportId: reportId,
                reportManager: reportManager,
              ),
            ),
          ],
        ),
      );
    }

    final check = checks.firstWhereOrNull(
      (c) => c.competenceId == item.publicId,
    );
    final score = check?.achievement ?? 0;

    return Row(
      children: [
        Expanded(child: Text(item.name)),
        GrowthDropdown(
          dropdownValue: score,
          onChangedFunction: (newValue) {
            if (check == null) {
              reportManager.postReportCheck(
                pupilId: pupilId,
                competenceReportItemId: item.publicId,
                competenceReportId: reportId,
                achievement: newValue,
                comment: '',
              );
            } else {
              reportManager.updateReportCheck(
                pupilId: pupilId,
                publicId: check.publicId,
                achievement: (value: newValue),
              );
            }
          },
        ),
      ],
    );
  }
}

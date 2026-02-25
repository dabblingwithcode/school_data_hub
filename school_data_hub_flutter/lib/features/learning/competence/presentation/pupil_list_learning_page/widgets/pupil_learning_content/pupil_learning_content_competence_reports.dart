import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_switch.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/services/pdf/competence_report_pdf_generator.dart';
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) =>
                      CompetenceReportPdfViewPage(pupil: pupil, report: report),
                ),
              );
            },
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text('PDF erstellen'),
          ),
        ),
        _ReportCheckTree(
          items: reportItems,
          parentId: null,
          isFirstLevel: true,
          checks: checks,
          pupilId: pupil.pupilId,
          reportId: report.id!,
          reportManager: reportManager,
        ),
      ],
    );
  }
}

class _ReportCheckTree extends StatelessWidget {
  final List<CompetenceReportItem> items;
  final int? parentId;
  final bool isFirstLevel;
  final List<CompetenceReportCheck> checks;
  final int pupilId;
  final int reportId;
  final CompetenceReportManager reportManager;

  const _ReportCheckTree({
    required this.items,
    required this.parentId,
    this.isFirstLevel = false,
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
        for (final item in children) ...[
          if (isFirstLevel && items.any((i) => i.parentItem == item.publicId))
            _FirstLevelBranchNode(
              item: item,
              items: items,
              checks: checks,
              pupilId: pupilId,
              reportId: reportId,
              reportManager: reportManager,
            )
          else
            _ReportCheckNode(
              item: item,
              allItems: items,
              checks: checks,
              pupilId: pupilId,
              reportId: reportId,
              reportManager: reportManager,
            ),
        ],
      ],
    );
  }
}

int _countChecksUnderBranch(
  int branchPublicId,
  List<CompetenceReportItem> allItems,
  List<CompetenceReportCheck> checks,
) {
  final descendantIds = <int>{branchPublicId};
  void addDescendants(int parentId) {
    for (final i in allItems) {
      if (i.parentItem == parentId) {
        descendantIds.add(i.publicId);
        addDescendants(i.publicId);
      }
    }
  }

  addDescendants(branchPublicId);
  return checks.where((c) => descendantIds.contains(c.competenceId)).length;
}

class _FirstLevelBranchNode extends WatchingWidget {
  final CompetenceReportItem item;
  final List<CompetenceReportItem> items;
  final List<CompetenceReportCheck> checks;
  final int pupilId;
  final int reportId;
  final CompetenceReportManager reportManager;

  const _FirstLevelBranchNode({
    required this.item,
    required this.items,
    required this.checks,
    required this.pupilId,
    required this.reportId,
    required this.reportManager,
  });

  @override
  Widget build(BuildContext context) {
    final tileController = createOnce(() => CustomExpansionTileController());
    final color = AppColors.interactiveColor;
    final totalChecks = _countChecksUnderBranch(item.publicId, items, checks);
    final initial = item.name.isNotEmpty ? item.name[0].toUpperCase() : '';

    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        children: [
          InkWell(
            onTap: () => tileController.toggle(),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        initial,
                        style: TextStyle(
                          color: AppColors.bestContrastCompetenceFontColor(
                            color,
                          ),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                  const Gap(10),
                  Text(
                    totalChecks.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const Gap(10),
                  CustomExpansionTileSwitch(
                    customExpansionTileController: tileController,
                    switchColor: color,
                  ),
                ],
              ),
            ),
          ),
          CustomExpansionTileContent(
            tileController: tileController,
            widgetList: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: _ReportCheckTree(
                  items: items,
                  parentId: item.publicId,
                  isFirstLevel: false,
                  checks: checks,
                  pupilId: pupilId,
                  reportId: reportId,
                  reportManager: reportManager,
                ),
              ),
            ],
          ),
        ],
      ),
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
                isFirstLevel: false,
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

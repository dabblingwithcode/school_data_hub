import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/pdf_viewer_screen.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_header.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/competence_report_item_helper.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/competence_report_manager.dart';
import 'package:school_data_hub_flutter/features/learning/services/pdf/competence_report_pdf_generator.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';

/// Returns the checks for [pupilId] in the current semester from [reportsByPupil].
/// Returns null if no report exists for the current semester.
({CompetenceReport report, List<CompetenceReportCheck> checks})?
_currentReportAndChecks(
  Map<int, List<CompetenceReport>> reportsByPupil,
  int pupilId,
) {
  final currentSchoolSemester =
      di<SchoolCalendarManager>().currentSemester.value;
  final reports = reportsByPupil[pupilId] ?? [];
  final report = reports.firstWhereOrNull(
    (r) => r.schoolSemesterId == currentSchoolSemester!.id,
  );
  if (report == null) return null;
  return (report: report, checks: report.competenceReportChecks ?? []);
}

class PupilLearningContentCompetenceReports extends WatchingWidget {
  final PupilProxy pupil;
  const PupilLearningContentCompetenceReports({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final reportManager = di<CompetenceReportManager>();

    callOnce((_) => reportManager.fetchReportsForPupil(pupil.pupilId));

    final reportsByPupil = watchValue(
      (CompetenceReportManager m) => m.reportsByPupil,
    );

    final result = _currentReportAndChecks(reportsByPupil, pupil.pupilId);
    if (result == null) {
      return const Text('Kein Zeugnis für das aktuelle Semester vorhanden');
    }
    final report = result.report;
    final reportItems = CompetenceReportItemHelper.getReportItemsForReport(
      report,
    );
    if (reportItems.isEmpty) {
      return const Text(
        'Keine Zeugniskompetenzen für das aktuelle Semester vorhanden',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => PdfViewerScreen(
                    pdfGenerator: () =>
                        CompetenceReportPdfGenerator.generateCompetenceReportPdf(
                          pupil: pupil,
                          report: report,
                        ),
                    title: 'Kriterienzeugnis PDF',
                    showZoomButton: true,
                  ),
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
          pupilId: pupil.pupilId,
          reportId: report.id!,
        ),
      ],
    );
  }
}

class _ReportCheckTree extends StatelessWidget {
  final List<CompetenceReportItem> items;
  final int? parentId;
  final bool isFirstLevel;
  final int pupilId;
  final int reportId;

  const _ReportCheckTree({
    required this.items,
    required this.parentId,
    this.isFirstLevel = false,
    required this.pupilId,
    required this.reportId,
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
              pupilId: pupilId,
              reportId: reportId,
            )
          else
            _ReportCheckNode(
              item: item,
              allItems: items,
              pupilId: pupilId,
              reportId: reportId,
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
  final int pupilId;
  final int reportId;

  const _FirstLevelBranchNode({
    required this.item,
    required this.items,
    required this.pupilId,
    required this.reportId,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final tileController = createOnce(() => ExpansionController());
    final color = style.colors.interactive;

    // Watch reportsByPupil directly so this widget reacts to stream updates.
    final reportsByPupil = watchValue(
      (CompetenceReportManager m) => m.reportsByPupil,
    );
    final result = _currentReportAndChecks(reportsByPupil, pupilId);
    final checks = result?.checks ?? [];

    final totalChecks = _countChecksUnderBranch(item.publicId, items, checks);
    final initial = item.name.isNotEmpty ? item.name[0].toUpperCase() : '';

    return CardBox(
      variant: CardBoxVariant.filledSecondary,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => tileController.toggle(),
            child: Padding(
              padding: EdgeInsets.all(Style.spacing.md),
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
                        style: context.typography.title.withColor(
                          style.colors.background,
                        ),
                      ),
                    ),
                  ),
                  Gap(Style.spacing.md),
                  Expanded(
                    child: Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.typography.title.withColor(color),
                    ),
                  ),
                  Gap(Style.spacing.md),
                  Text(
                    totalChecks.toString(),
                    style: context.typography.title.withColor(color),
                  ),
                  Gap(Style.spacing.md),
                  ExpansionHeader(
                    expansionController: tileController,
                    switchColor: color,
                  ),
                ],
              ),
            ),
          ),
          ExpansionBody(
            tileController: tileController,
            widgetList: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Style.spacing.sm,
                  vertical: Style.spacing.xs,
                ),
                child: _ReportCheckTree(
                  items: items,
                  parentId: item.publicId,
                  isFirstLevel: false,
                  pupilId: pupilId,
                  reportId: reportId,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReportCheckNode extends WatchingWidget {
  final CompetenceReportItem item;
  final List<CompetenceReportItem> allItems;
  final int pupilId;
  final int reportId;

  const _ReportCheckNode({
    required this.item,
    required this.allItems,
    required this.pupilId,
    required this.reportId,
  });

  @override
  Widget build(BuildContext context) {
    // Watch MUST be called unconditionally (before any early return)
    // so that WatchingWidget always registers the listener.
    final reportsByPupil = watchValue(
      (CompetenceReportManager m) => m.reportsByPupil,
    );

    final hasChildren = allItems.any((i) => i.parentItem == item.publicId);

    if (hasChildren) {
      return Padding(
        padding: EdgeInsets.only(top: Style.spacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.name, style: context.typography.title),
            Padding(
              padding: EdgeInsets.only(left: Style.spacing.sm),
              child: _ReportCheckTree(
                items: allItems,
                parentId: item.publicId,
                isFirstLevel: false,
                pupilId: pupilId,
                reportId: reportId,
              ),
            ),
          ],
        ),
      );
    }

    final result = _currentReportAndChecks(reportsByPupil, pupilId);
    final checks = result?.checks ?? [];
    final reportManager = di<CompetenceReportManager>();

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

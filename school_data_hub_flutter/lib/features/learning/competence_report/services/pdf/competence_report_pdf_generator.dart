import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdfrx/pdfrx.dart';
import 'package:printing/printing.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_helper.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/competence_report_item_helper.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/services/pdf/competence_report_pdf_helpers.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/services/pdf/pages/competence_report_pdf_page1.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/services/pdf/pages/competence_report_pdf_page5.dart';
import 'package:school_data_hub_flutter/features/school/domain/school_data_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';

final _log = Logger('CompetenceReportPdfGenerator');

/// One criterion row: predicate text and achievement (0–4) for checkbox columns.
class ZeugnisCriterionRow {
  final String predicate;
  final int achievement;
  const ZeugnisCriterionRow({
    required this.predicate,
    required this.achievement,
  });
}

/// A subsection under a section: optional second-level title (when item has children) and rows.
class ReportSubsection {
  /// Second-level title (e.g. "Leistungsbereitschaft"). Null when criteria are direct under the section.
  final String? subsectionTitle;
  final List<ZeugnisCriterionRow> rows;
  const ReportSubsection({this.subsectionTitle, required this.rows});
}

/// Data for one report section (e.g. "Lern- und Arbeitsverhalten" with criteria/subsections).
class ReportSectionData {
  final String title;
  final List<ReportSubsection> subsections;
  final String weitereHinweise;
  const ReportSectionData({
    required this.title,
    required this.subsections,
    this.weitereHinweise = 'Keine.',
  });

  /// Flat list of all criterion rows (for single-table legacy or pages 2–4).
  List<ZeugnisCriterionRow> get criteriaRows =>
      subsections.expand((s) => s.rows).toList();

  /// Plain predicate strings for pages 2–4 that do not show the achievement table.
  List<String> get criteria => criteriaRows.map((r) => r.predicate).toList();
}

// =============================================================================
// Page height estimation (for placement simulation)
// =============================================================================

const double _pageUsableHeight = 769.0; // A4 842 - margins 24*2 - header ~25
const double _firstPageContentHeight = 220.0;

const double _sectionTitleHeight = 18.0; // Text 11pt + SizedBox(4)
const double _subsectionTitleHeight = 28.0; // Padding 6+10 + text ~12
const double _tableHeaderHeight = 28.0;
const double _tableRowHeight = 15.0;
const double _afterTableHeight = 4.0;
const double _hinweiseBlockHeight = 72.0;
const double _afterSectionHeight = 12.0;

/// Estimated height of one subsection block (optional subtitle + table + after).
double _estimatedSubsectionBlockHeight(ReportSubsection sub) {
  double h = 0;
  if (sub.subsectionTitle != null && sub.subsectionTitle!.isNotEmpty) {
    h += _subsectionTitleHeight;
  }
  h +=
      _tableHeaderHeight +
      _tableRowHeight * sub.rows.length +
      _afterTableHeight;
  return h;
}

/// Block heights for a section in the same order as [sectionBlockWidgets]:
/// [title+first subsection], (further subsections), [hinweise], (optional spacing).
List<double> _sectionBlockHeights(
  ReportSectionData section,
  bool isLastSection,
) {
  final blocks = <double>[];
  final allSubsectionsEmpty = section.subsections.every((s) => s.rows.isEmpty);
  if (allSubsectionsEmpty && section.subsections.isNotEmpty) {
    // First widget: Container(sectionTitle, 4, table). Second: SizedBox(4). Then hinweise, then maybe 12.
    blocks.add(
      _sectionTitleHeight +
          _tableHeaderHeight +
          _tableRowHeight * section.subsections.length +
          _afterTableHeight,
    );
    blocks.add(_afterTableHeight); // SizedBox(4)
    blocks.add(_hinweiseBlockHeight);
    if (!isLastSection) blocks.add(_afterSectionHeight);
  } else {
    for (var i = 0; i < section.subsections.length; i++) {
      final sub = section.subsections[i];
      final subHeight = _estimatedSubsectionBlockHeight(sub);
      if (i == 0) {
        blocks.add(_sectionTitleHeight + subHeight);
      } else {
        blocks.add(subHeight);
      }
    }
    blocks.add(_hinweiseBlockHeight);
    if (!isLastSection) blocks.add(_afterSectionHeight);
  }
  return blocks;
}

// =============================================================================
// PDF View Page
// =============================================================================

class CompetenceReportPdfViewPage extends StatefulWidget {
  final CompetenceReport report;
  final PupilProxy pupil;
  const CompetenceReportPdfViewPage({
    required this.report,
    required this.pupil,
    super.key,
  });

  @override
  State<CompetenceReportPdfViewPage> createState() =>
      _CompetenceReportPdfViewPageState();
}

class _CompetenceReportPdfViewPageState
    extends State<CompetenceReportPdfViewPage> {
  File? _generatedFile;

  @override
  void dispose() {
    if (_generatedFile?.existsSync() ?? false) {
      _generatedFile!.delete();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: CompetenceReportPdfGenerator.generateCompetenceReportPdf(
        pupil: widget.pupil,
        report: widget.report,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          _log.severe(
            'Failed to generate competence report PDF',
            snapshot.error,
          );
          return Scaffold(
            appBar: const GenericAppBar(
              iconData: Icons.picture_as_pdf,
              title: 'Kriterienzeugnis PDF',
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text('Fehler beim Erstellen des PDFs'),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.error.toString(),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Zurück'),
                  ),
                ],
              ),
            ),
          );
        }
        if (!snapshot.hasData) {
          return const Scaffold(
            appBar: GenericAppBar(
              iconData: Icons.picture_as_pdf,
              title: 'Kriterienzeugnis PDF',
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('PDF wird erstellt...'),
                ],
              ),
            ),
          );
        }
        final file = snapshot.data!;
        _generatedFile = file;
        _log.info('Opening PDF view for file: ${file.path}');
        return Scaffold(
          appBar: const GenericAppBar(
            iconData: Icons.picture_as_pdf,
            title: 'Kriterienzeugnis PDF',
          ),
          body: PdfPreview(
            actionBarTheme: PdfActionBarTheme(
              backgroundColor: AppColors.backgroundColor,
              iconColor: Colors.white,
              textStyle: const TextStyle(color: Colors.white),
            ),
            allowSharing: true,
            allowPrinting: true,
            canChangePageFormat: false,
            canChangeOrientation: false,
            canDebug: false,
            useActions: true,
            scrollViewDecoration: const BoxDecoration(color: Colors.grey),
            pdfPreviewPageDecoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            onPrinted: (context) {
              if (context.mounted) Navigator.of(context).pop();
            },
            build: (format) => file.readAsBytes(),
            actions: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (context.mounted) Navigator.of(context).pop();
                },
              ),
              IconButton(
                icon: const Icon(Icons.zoom_in),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => PdfZoomableImage(file: file),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class PdfZoomableImage extends StatelessWidget {
  final File file;
  const PdfZoomableImage({required this.file, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(title: 'PDF Zoom', iconData: Icons.zoom_in),
      body: PdfViewer.file(file.path),
      bottomNavigationBar: const GenericBottomNavBar(),
    );
  }
}

class CompetenceReportPdfGenerator {
  static Future<File> generateCompetenceReportPdf({
    required PupilProxy pupil,
    required CompetenceReport report,
  }) async {
    final schoolData = di<SchoolDataMainManager>().schoolData.value;
    if (schoolData == null) {
      throw Exception('Schuldaten fehlen. Bitte zuerst Schuldaten anlegen.');
    }
    final semester =
        report.schoolSemester ??
        di<SchoolCalendarManager>().schoolSemesters.value.firstWhereOrNull(
          (s) => s.id == report.schoolSemesterId,
        );
    if (semester == null) {
      throw Exception('Semester für das Zeugnis konnte nicht geladen werden.');
    }

    final reportItems = CompetenceReportItemHelper.getReportItemsForReport(
      report,
    );
    final checks = report.competenceReportChecks ?? [];
    final checkByCompetenceId = {for (final c in checks) c.competenceId: c};

    final sections = _buildSections(reportItems, checkByCompetenceId);
    final missedHours = AttendanceHelper.missedHoursforSemesterOrSchoolyear(
      pupil,
    );

    final regularData = await rootBundle.load(
      'assets/fonts/Roboto-Regular.ttf',
    );
    final boldData = await rootBundle.load('assets/fonts/Roboto-Bold.ttf');
    final fontRegular = pw.Font.ttf(regularData);
    final fontBold = pw.Font.ttf(boldData);

    pw.MemoryImage? sealImage;
    final sealData = di<SchoolDataMainManager>().officialSealImage.value;
    if (sealData != null) {
      sealImage = pw.MemoryImage(sealData.buffer.asUint8List());
    }

    final checkboxData = await rootBundle.load(
      'assets/images/support_categories_icons/checkbox.png',
    );
    final growthOneData = await rootBundle.load(
      'assets/images/growth_icons/growth_1-4.png',
    );
    final growthTwoData = await rootBundle.load(
      'assets/images/growth_icons/growth_2-4.png',
    );
    final growthThreeData = await rootBundle.load(
      'assets/images/growth_icons/growth_3-4.png',
    );
    final growthFourData = await rootBundle.load(
      'assets/images/growth_icons/growth_4-4.png',
    );
    final checkboxCheckData = await rootBundle.load(
      'assets/images/support_categories_icons/checkbox_check.png',
    );
    final growthOneImage = pw.MemoryImage(growthOneData.buffer.asUint8List());
    final growthTwoImage = pw.MemoryImage(growthTwoData.buffer.asUint8List());
    final growthThreeImage = pw.MemoryImage(
      growthThreeData.buffer.asUint8List(),
    );
    final growthFourImage = pw.MemoryImage(growthFourData.buffer.asUint8List());
    final checkboxImage = pw.MemoryImage(checkboxData.buffer.asUint8List());
    final checkboxCheckImage = pw.MemoryImage(
      checkboxCheckData.buffer.asUint8List(),
    );

    final pdf = pw.Document();
    di<NotificationService>().setHeavyLoadingValue(true);

    try {
      final halfYearLabel = semester.isFirst ? '1. Halbjahr' : '2. Halbjahr';
      final schoolYear = semester.schoolYear;
      final schoolName = schoolData.officialName;
      final pupilName = '${pupil.firstName} ${pupil.lastName}';

      final firstPageContent = CompetenceReportPdfPage1.buildFirstPageContent(
        schoolData: schoolData,
        pupil: pupil,
        halfYearLabel: halfYearLabel,
        schoolYear: schoolYear,
        missedHours: missedHours,
        fontRegular: fontRegular,
        fontBold: fontBold,
        sealImage: sealImage,
      );

      // Build flat list of section block widgets and their heights (subsection-level).
      final allBlockWidgets = <pw.Widget>[];
      final allBlockHeights = <double>[];
      for (var s = 0; s < sections.length; s++) {
        final section = sections[s];
        final widgets = CompetenceReportPdfPage1.sectionBlockWidgets(
          section,
          fontRegular,
          fontBold,
          checkboxImage,
          checkboxCheckImage,
          growthOneImage,
          growthTwoImage,
          growthThreeImage,
          growthFourImage,
          isLastSection: s == sections.length - 1,
        );
        final heights = _sectionBlockHeights(section, s == sections.length - 1);
        assert(
          widgets.length == heights.length,
          'sectionBlockWidgets and _sectionBlockHeights must match',
        );
        allBlockWidgets.addAll(widgets);
        allBlockHeights.addAll(heights);
      }

      // Placement simulation: insert NewPage() only before a block that would not fit.
      double remaining = _pageUsableHeight - _firstPageContentHeight;
      final insertNewPageBefore = List<bool>.filled(
        allBlockWidgets.length,
        false,
      );
      for (var i = 0; i < allBlockHeights.length; i++) {
        final blockHeight = allBlockHeights[i];
        if (blockHeight > remaining) {
          insertNewPageBefore[i] = true;
          remaining = _pageUsableHeight - blockHeight;
        } else {
          remaining -= blockHeight;
        }
      }

      final sectionWidgets = <pw.Widget>[];
      for (var i = 0; i < allBlockWidgets.length; i++) {
        if (insertNewPageBefore[i]) {
          sectionWidgets.add(pw.NewPage());
        }
        sectionWidgets.add(allBlockWidgets[i]);
      }

      final signaturesContent = CompetenceReportPdfPage5.buildSignaturesContent(
        schoolData: schoolData,
        pupil: pupil,
        semester: semester,

        fontRegular: fontRegular,
        fontBold: fontBold,
      );

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.only(
            top: 24,
            bottom: 24,
            left: 1.2 * PdfPageFormat.cm,
            right: 40,
          ),
          header: (pw.Context context) => context.pageNumber == 1
              ? pw.SizedBox.shrink()
              : pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 8),
                  child: CompetenceReportPdfHelpers.buildZeugnisPageHeader(
                    schoolName: schoolName,
                    pupilName: pupilName,
                    pageNumber: context.pageNumber,
                    totalPages: context.pagesCount,
                    font: fontRegular,
                  ),
                ),
          build: (pw.Context context) => [
            firstPageContent,
            ...sectionWidgets,
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: signaturesContent,
            ),
          ],
        ),
      );
    } finally {
      di<NotificationService>().setHeavyLoadingValue(false);
    }

    final directory = await getApplicationDocumentsDirectory();
    final fileName =
        'Kriterienzeugnis_${pupil.firstName}_${pupil.lastName}_${DateTime.now().formatDateForUser()}.pdf';
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    _log.info('Competence report PDF generated: ${file.path}');
    return file;
  }

  static List<ReportSectionData> _buildSections(
    List<CompetenceReportItem> items,
    Map<int, CompetenceReportCheck> checkByCompetenceId,
  ) {
    int compareItems(CompetenceReportItem a, CompetenceReportItem b) {
      if (a.order != null && b.order != null) {
        return a.order!.compareTo(b.order!);
      }
      if (a.order != null) return -1;
      if (b.order != null) return 1;
      return a.publicId.compareTo(b.publicId);
    }

    final roots = items.where((i) => i.parentItem == null).toList()
      ..sort(compareItems);
    final sections = <ReportSectionData>[];

    for (final root in roots) {
      final directChildren =
          items.where((i) => i.parentItem == root.publicId).toList()
            ..sort(compareItems);

      final subsections = <ReportSubsection>[];
      final allLeafIds = <int>{};

      void addLeavesUnder(int parentId, List<ZeugnisCriterionRow> outRows) {
        final children = items.where((i) => i.parentItem == parentId).toList()
          ..sort(compareItems);
        for (final c in children) {
          final hasChildren = items.any((i) => i.parentItem == c.publicId);
          if (hasChildren) {
            addLeavesUnder(c.publicId, outRows);
          } else {
            allLeafIds.add(c.publicId);
            final check = checkByCompetenceId[c.publicId];
            final achievement = check?.achievement ?? 0;
            outRows.add(
              ZeugnisCriterionRow(predicate: c.name, achievement: achievement),
            );
          }
        }
      }

      if (directChildren.isEmpty) {
        final hasChildren = items.any((i) => i.parentItem == root.publicId);
        if (!hasChildren) {
          final check = checkByCompetenceId[root.publicId];
          final achievement = check?.achievement ?? 0;
          subsections.add(
            ReportSubsection(
              subsectionTitle: null,
              rows: [
                ZeugnisCriterionRow(
                  predicate: root.name,
                  achievement: achievement,
                ),
              ],
            ),
          );
          allLeafIds.add(root.publicId);
        } else {
          final rows = <ZeugnisCriterionRow>[];
          addLeavesUnder(root.publicId, rows);
          if (rows.isNotEmpty) {
            subsections.add(
              ReportSubsection(subsectionTitle: null, rows: rows),
            );
          }
        }
      } else {
        final directLeafRows = <ZeugnisCriterionRow>[];
        for (final child in directChildren) {
          final hasChildren = items.any((i) => i.parentItem == child.publicId);
          final rows = <ZeugnisCriterionRow>[];
          if (hasChildren) {
            addLeavesUnder(child.publicId, rows);
            subsections.add(
              ReportSubsection(subsectionTitle: child.name, rows: rows),
            );
          } else {
            allLeafIds.add(child.publicId);
            final check = checkByCompetenceId[child.publicId];
            final achievement = check?.achievement ?? 0;
            directLeafRows.add(
              ZeugnisCriterionRow(
                predicate: child.name,
                achievement: achievement,
              ),
            );
          }
        }
        if (directLeafRows.isNotEmpty) {
          subsections.add(
            ReportSubsection(subsectionTitle: null, rows: directLeafRows),
          );
        }
      }

      String weitereHinweise = 'Keine.';
      for (final id in allLeafIds) {
        final check = checkByCompetenceId[id];
        if (check != null && check.comment.isNotEmpty) {
          weitereHinweise = check.comment;
          break;
        }
      }

      sections.add(
        ReportSectionData(
          title: root.name,
          subsections: subsections,
          weitereHinweise: weitereHinweise,
        ),
      );
    }
    return sections;
  }
}

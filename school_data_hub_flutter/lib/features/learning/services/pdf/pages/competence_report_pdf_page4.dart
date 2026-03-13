import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school_data_hub_flutter/features/learning/services/pdf/competence_report_pdf_generator.dart';
import 'package:school_data_hub_flutter/features/learning/services/pdf/competence_report_pdf_helpers.dart';
import 'package:school_data_hub_flutter/features/learning/services/pdf/pdf_widgets/competence_report_criteria_table.dart';

/// Page 4: Header and continued section blocks.
class CompetenceReportPdfPage4 {
  CompetenceReportPdfPage4._();

  static pw.Page build({
    required int pageNumber,
    required int totalPages,
    required String schoolName,
    required String pupilName,
    required List<ReportSectionData> sections,
    required pw.Font fontRegular,
    required pw.Font fontBold,
    required pw.MemoryImage checkboxImage,
    required pw.MemoryImage checkboxCheckImage,
    required pw.MemoryImage growthOneImage,
    required pw.MemoryImage growthTwoImage,
    required pw.MemoryImage growthThreeImage,
    required pw.MemoryImage growthFourImage,
  }) {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(24),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            CompetenceReportPdfHelpers.buildZeugnisPageHeader(
              schoolName: schoolName,
              pupilName: pupilName,
              pageNumber: pageNumber,
              totalPages: totalPages,
              font: fontRegular,
            ),
            pw.SizedBox(height: 8),
            pw.Divider(color: PdfColors.black, thickness: 0.5),
            pw.SizedBox(height: 12),
            ...sections.expand(
              (s) => _sectionBlock(
                s,
                fontRegular,
                fontBold,
                checkboxImage,
                checkboxCheckImage,
                growthOneImage,
                growthTwoImage,
                growthThreeImage,
                growthFourImage,
              ),
            ),
          ],
        );
      },
    );
  }

  static List<pw.Widget> _sectionBlock(
    ReportSectionData section,
    pw.Font fontRegular,
    pw.Font fontBold,
    pw.MemoryImage checkboxImage,
    pw.MemoryImage checkboxCheckImage,
    pw.MemoryImage growthOneImage,
    pw.MemoryImage growthTwoImage,
    pw.MemoryImage growthThreeImage,
    pw.MemoryImage growthFourImage,
  ) {
    return [
      pw.Text(section.title, style: pw.TextStyle(font: fontBold, fontSize: 11)),
      pw.SizedBox(height: 4),
      CompetenceReportCriteriaTable.build(
        rows: section.criteriaRows,
        fontRegular: fontRegular,
        checkboxImage: checkboxImage,
        checkboxCheckImage: checkboxCheckImage,
        growthOneImage: growthOneImage,
        growthTwoImage: growthTwoImage,
        growthThreeImage: growthThreeImage,
        growthFourImage: growthFourImage,
      ),
      pw.SizedBox(height: 4),
      pw.Text(
        'Weitere Hinweise: ${section.weitereHinweise}',
        style: pw.TextStyle(font: fontRegular, fontSize: 10),
      ),
      pw.SizedBox(height: 12),
    ];
  }
}

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/pdf_helpers.dart'
    as common_pdf;
import 'package:school_data_hub_flutter/features/learning/competence_report/services/pdf/competence_report_pdf_generator.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

/// Page 1: School header, Zeugnis title, pupil block, missed hours, first section blocks.
class CompetenceReportPdfPage1 {
  CompetenceReportPdfPage1._();

  static pw.Page build({
    required SchoolData schoolData,
    required PupilProxy pupil,
    required SchoolSemester semester,
    required String halfYearLabel,
    required String schoolYear,
    required ({int missed, int unexcused}) missedHours,
    required List<ReportSectionData> sections,
    required pw.Font fontRegular,
    required pw.Font fontBold,
    required pw.MemoryImage? sealImage,
    required pw.MemoryImage checkboxImage,
    required pw.MemoryImage checkboxCheckImage,
    required pw.MemoryImage growthOneImage,
    required pw.MemoryImage growthTwoImage,
    required pw.MemoryImage growthThreeImage,
    required pw.MemoryImage growthFourImage,
  }) {
    final schoolName = schoolData.officialName;
    final pupilName = '${pupil.firstName} ${pupil.lastName}';

    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.only(
        top: 24,
        bottom: 24,
        left: 1.2 * PdfPageFormat.cm,
        right: 40,
      ),
      build: (pw.Context context) {
        return pw.Stack(
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                  child: pw.Text(
                    schoolName,
                    style: pw.TextStyle(font: fontBold, fontSize: 20),
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Center(
                  child: schoolData.address.isNotEmpty
                      ? pw.Text(
                          '${schoolData.address}, ${schoolData.zipCode} ${schoolData.city}',
                          style: pw.TextStyle(font: fontRegular, fontSize: 9),
                        )
                      : pw.SizedBox.shrink(),
                ),
                pw.Center(
                  child: pw.Text(
                    'Schulnr.: ${schoolData.schoolNumber}',
                    style: pw.TextStyle(font: fontRegular, fontSize: 10),
                  ),
                ),
                pw.SizedBox(height: 30),
                pw.Center(
                  child: pw.Text(
                    'Zeugnis Klasse ${pupil.schoolGrade}',
                    style: pw.TextStyle(font: fontBold, fontSize: 18),
                  ),
                ),
                pw.Center(
                  child: pw.Text(
                    halfYearLabel,
                    style: pw.TextStyle(font: fontRegular, fontSize: 12),
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  children: [
                    pw.Text(
                      'für ',
                      style: pw.TextStyle(font: fontRegular, fontSize: 10),
                    ),
                    pw.SizedBox(width: 20),
                    pw.Expanded(
                      child: pw.Text(
                        pupilName,
                        style: pw.TextStyle(font: fontRegular, fontSize: 10),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 6),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Row(
                      children: [
                        pw.Text(
                          'geb. ',
                          style: pw.TextStyle(font: fontRegular, fontSize: 10),
                        ),
                        pw.SizedBox(width: 12),
                        pw.Text(
                          common_pdf.CommonPdfHelpers.formatDate(
                            pupil.birthday,
                          ),
                          style: pw.TextStyle(font: fontRegular, fontSize: 10),
                        ),
                      ],
                    ),

                    pw.SizedBox(width: 12),
                    pw.Text(
                      'Klasse ${pupil.group}',
                      style: pw.TextStyle(font: fontRegular, fontSize: 10),
                    ),
                    pw.SizedBox(width: 12),
                    pw.Text(
                      'Schuljahr $schoolYear',
                      style: pw.TextStyle(font: fontRegular, fontSize: 10),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Divider(
                  height: 8,
                  color: PdfColors.black,
                  thickness: 0.5,
                  indent: 0,
                  endIndent: 0,
                ),
                pw.Center(
                  child: pw.Text(
                    tightBounds: true,
                    'Versäumte Stunden:  ${missedHours.missed},  davon unentschuldigt  ${missedHours.unexcused}  Stunden',
                    style: pw.TextStyle(font: fontRegular, fontSize: 10),
                  ),
                ),
                pw.Divider(
                  height: 8,
                  color: PdfColors.black,
                  thickness: 0.5,
                  indent: 0,
                  endIndent: 0,
                ),

                pw.SizedBox(height: 14),
                ...sections.asMap().entries.expand(
                  (e) => _sectionBlock(
                    e.value,
                    fontRegular,
                    fontBold,
                    checkboxImage,
                    checkboxCheckImage,
                    isLastSection: e.key == sections.length - 1,
                  ),
                ),
              ],
            ),
            if (sealImage != null)
              pw.Positioned(
                top: 0,
                right: 0,
                child: pw.Image(sealImage, width: 70, height: 70),
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
    pw.MemoryImage checkboxCheckImage, {
    required bool isLastSection,
  }) {
    const boxSize = 30.0;
    bool isChecked(int columnIndex, int achievement) {
      if (achievement == 0) return true;
      return achievement == columnIndex + 1;
    }

    final widgets = <pw.Widget>[
      pw.Text(section.title, style: pw.TextStyle(font: fontBold, fontSize: 11)),
      pw.SizedBox(height: 4),
    ];

    for (final sub in section.subsections) {
      if (sub.subsectionTitle != null && sub.subsectionTitle!.isNotEmpty) {
        widgets.add(
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 6, bottom: 10),
            child: pw.Text(
              sub.subsectionTitle!,
              style: pw.TextStyle(font: fontBold, fontSize: 10),
            ),
          ),
        );
      }
      if (sub.rows.isEmpty) continue;
      widgets.add(
        pw.Table(
          columnWidths: {
            0: const pw.FlexColumnWidth(4),
            1: const pw.FixedColumnWidth(boxSize + 4),
            2: const pw.FixedColumnWidth(boxSize + 4),
            3: const pw.FixedColumnWidth(boxSize + 4),
            4: const pw.FixedColumnWidth(boxSize + 4),
          },
          border: pw.TableBorder.all(color: PdfColors.black, width: 0.5),
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey200),
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text(
                    'Ihr Kind…',
                    style: pw.TextStyle(font: fontRegular, fontSize: 10),
                  ),
                ),
                _tableHeaderCell('1', fontBold),
                _tableHeaderCell('2', fontBold),
                _tableHeaderCell('3', fontBold),
                _tableHeaderCell('4', fontBold),
              ],
            ),
            ...sub.rows.map(
              (row) => pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text(
                      row.predicate,
                      style: pw.TextStyle(font: fontRegular, fontSize: 9),
                    ),
                  ),
                  _checkboxCell(
                    isChecked(0, row.achievement),
                    checkboxImage,
                    checkboxCheckImage,
                    boxSize,
                  ),
                  _checkboxCell(
                    isChecked(1, row.achievement),
                    checkboxImage,
                    checkboxCheckImage,
                    boxSize,
                  ),
                  _checkboxCell(
                    isChecked(2, row.achievement),
                    checkboxImage,
                    checkboxCheckImage,
                    boxSize,
                  ),
                  _checkboxCell(
                    isChecked(3, row.achievement),
                    checkboxImage,
                    checkboxCheckImage,
                    boxSize,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
      widgets.add(pw.SizedBox(height: 4));
    }

    const minHeight = 48.0;
    const fixedHeight = 56.0;
    const padding = 6.0;

    final hinweiseContent = pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black, width: 0.5),
      ),
      padding: const pw.EdgeInsets.all(padding),
      height: isLastSection ? null : fixedHeight,
      alignment: pw.Alignment.topLeft,
      child: pw.Text(
        'Weitere Hinweise: ${section.weitereHinweise}',
        style: pw.TextStyle(font: fontRegular, fontSize: 10),
      ),
    );

    final hinweiseBox = isLastSection
        ? pw.Expanded(
            child: pw.ConstrainedBox(
              constraints: const pw.BoxConstraints(minHeight: minHeight),
              child: hinweiseContent,
            ),
          )
        : hinweiseContent;

    widgets.add(hinweiseBox);
    if (!isLastSection) {
      widgets.add(pw.SizedBox(height: 12));
    }
    return widgets;
  }

  static pw.Widget _tableHeaderCell(String label, pw.Font fontBold) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(4),
      child: pw.Center(
        child: pw.Text(label, style: pw.TextStyle(font: fontBold, fontSize: 9)),
      ),
    );
  }

  static pw.Widget _checkboxCell(
    bool checked,
    pw.MemoryImage checkboxImage,
    pw.MemoryImage checkboxCheckImage,
    double size,
  ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(2),
      child: pw.Center(
        child: pw.SizedBox(
          height: 10,
          child: pw.Image(
            checked ? checkboxCheckImage : checkboxImage,
            width: size,
            height: size,
          ),
        ),
      ),
    );
  }
}

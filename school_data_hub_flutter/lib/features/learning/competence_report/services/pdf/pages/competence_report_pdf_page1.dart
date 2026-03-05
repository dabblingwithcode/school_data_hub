import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/pdf_helpers.dart'
    as common_pdf;
import 'package:school_data_hub_flutter/features/learning/competence_report/services/pdf/competence_report_pdf_generator.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/services/pdf/pdf_widgets/competence_report_criteria_table.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

/// Page 1: School header, Zeugnis title, pupil block, missed hours, first section blocks.
/// Also used by MultiPage: [buildFirstPageContent], [sectionBlockWidgets] for flow layout.
class CompetenceReportPdfPage1 {
  CompetenceReportPdfPage1._();

  /// First-page content for MultiPage: school header, then Zeugnis Klasse through missed hours. Seal overlay optional.
  static pw.Widget buildFirstPageContent({
    required SchoolData schoolData,
    required PupilProxy pupil,
    required String halfYearLabel,
    required String schoolYear,
    required ({int missed, int unexcused}) missedHours,
    required pw.Font fontRegular,
    required pw.Font fontBold,
    pw.MemoryImage? sealImage,
  }) {
    final pupilName = '${pupil.firstName} ${pupil.lastName}';
    final content = pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Center(
          child: pw.Text(
            schoolData.officialName,
            style: pw.TextStyle(font: fontBold, fontSize: 20),
          ),
        ),
        schoolData.extraName != null && schoolData.extraName!.isNotEmpty
            ? pw.Center(
                child: pw.Text(
                  schoolData.extraName!,
                  style: pw.TextStyle(font: fontBold, fontSize: 10),
                ),
              )
            : pw.SizedBox.shrink(),
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
                  common_pdf.CommonPdfHelpers.formatDate(pupil.birthday),
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
      ],
    );
    if (sealImage == null) return content;
    return pw.Stack(
      children: [
        content,
        pw.Positioned(
          top: 0,
          right: 0,
          child: pw.Image(sealImage, width: 70, height: 70),
        ),
      ],
    );
  }

  /// Returns subsection-level widgets for one section (for MultiPage flow).
  /// Keeps section title with first following content (wrapped so MultiPage won't split them).
  /// When all subsections have no rows, one table is used for the whole section.
  static List<pw.Widget> sectionBlockWidgets(
    ReportSectionData section,
    pw.Font fontRegular,
    pw.Font fontBold,
    pw.MemoryImage checkboxImage,
    pw.MemoryImage checkboxCheckImage,
    pw.MemoryImage growthOneImage,
    pw.MemoryImage growthTwoImage,
    pw.MemoryImage growthThreeImage,
    pw.MemoryImage growthFourImage, {
    required bool isLastSection,
  }) {
    final bool allSubsectionsEmpty = section.subsections.every(
      (s) => s.rows.isEmpty,
    );

    final subsectionBlocks = <pw.Widget>[];
    if (allSubsectionsEmpty && section.subsections.isNotEmpty) {
      // One table for the whole section: one row per subsection (predicate = subsection title).
      final rows = section.subsections
          .map(
            (s) => ZeugnisCriterionRow(
              predicate: s.subsectionTitle?.trim().isNotEmpty == true
                  ? s.subsectionTitle!
                  : section.title,
              achievement: 0,
            ),
          )
          .toList();
      subsectionBlocks.add(
        CompetenceReportCriteriaTable.build(
          rows: rows,
          fontRegular: fontRegular,
          checkboxImage: checkboxImage,
          checkboxCheckImage: checkboxCheckImage,
          growthOneImage: growthOneImage,
          growthTwoImage: growthTwoImage,
          growthThreeImage: growthThreeImage,
          growthFourImage: growthFourImage,
        ),
      );
      subsectionBlocks.add(pw.SizedBox(height: 4));
    } else {
      for (final sub in section.subsections) {
        final subChildren = <pw.Widget>[];
        if (sub.subsectionTitle != null && sub.subsectionTitle!.isNotEmpty) {
          subChildren.add(
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 6, bottom: 5),
              child: pw.Text(
                sub.subsectionTitle!,
                style: pw.TextStyle(font: fontBold, fontSize: 10),
              ),
            ),
          );
        }
        subChildren.add(
          CompetenceReportCriteriaTable.build(
            rows: sub.rows,
            fontRegular: fontRegular,
            checkboxImage: checkboxImage,
            checkboxCheckImage: checkboxCheckImage,
            growthOneImage: growthOneImage,
            growthTwoImage: growthTwoImage,
            growthThreeImage: growthThreeImage,
            growthFourImage: growthFourImage,
          ),
        );
        subChildren.add(pw.SizedBox(height: 4));
        subsectionBlocks.add(
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: subChildren,
          ),
        );
      }
    }

    const fixedHeight = 56.0;
    const padding = 6.0;
    final hinweiseContent = pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black, width: 0.5),
      ),
      padding: const pw.EdgeInsets.all(padding),
      height: fixedHeight,
      alignment: pw.Alignment.topLeft,
      child: pw.Text(
        section.weitereHinweise,
        style: pw.TextStyle(font: fontRegular, fontSize: 10),
      ),
    );
    final hinweiseBlock = pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Weitere Hinweise:',
          style: pw.TextStyle(font: fontBold, fontSize: 8),
        ),
        pw.SizedBox(height: 4),
        hinweiseContent,
      ],
    );

    final sectionTitle = pw.Text(
      section.title,
      style: pw.TextStyle(font: fontBold, fontSize: 11),
    );
    final titleSpacing = pw.SizedBox(height: 4);

    // Rule: section title must not be separated from following subsection title or table.
    // Wrap in Container so MultiPage treats this as one unit (Column alone can span and split).
    final list = <pw.Widget>[];
    if (subsectionBlocks.isNotEmpty) {
      final sectionTitleWithFirst = pw.Container(
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [sectionTitle, titleSpacing, subsectionBlocks.first],
        ),
      );
      list.add(sectionTitleWithFirst);
      list.addAll(subsectionBlocks.skip(1));
    } else {
      list.add(
        pw.Container(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [sectionTitle, titleSpacing, hinweiseBlock],
          ),
        ),
      );
    }
    if (subsectionBlocks.isNotEmpty) {
      list.add(hinweiseBlock);
    }
    if (!isLastSection) list.add(pw.SizedBox(height: 12));
    return list;
  }

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
    final schoolExtraName = schoolData.extraName;
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
                schoolExtraName != null
                    ? pw.Center(
                        child: pw.Text(
                          schoolExtraName,
                          style: pw.TextStyle(font: fontBold, fontSize: 10),
                        ),
                      )
                    : pw.SizedBox.shrink(),
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
                  (e) => sectionBlockWidgets(
                    e.value,
                    fontRegular,
                    fontBold,
                    checkboxImage,
                    checkboxCheckImage,
                    growthOneImage,
                    growthTwoImage,
                    growthThreeImage,
                    growthFourImage,
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
}

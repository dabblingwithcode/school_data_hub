import 'package:flutter_it/flutter_it.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/pdf_helpers.dart'
    as common_pdf;
import 'package:school_data_hub_flutter/features/learning/competence_report/services/pdf/competence_report_pdf_helpers.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/school/domain/school_data_manager.dart';

/// Page 5: Bemerkungen, Konferenzbeschluss, Wiederbeginn, Klassenleitung, Schulleitung (with seal), Ort und Datum, parent signature.
/// [buildSignaturesContent] is used inside MultiPage as flow content.
class CompetenceReportPdfPage5 {
  CompetenceReportPdfPage5._();

  /// Signatures block for MultiPage flow (Bemerkungen through parent signature line).
  static List<pw.Widget> buildSignaturesContent({
    required SchoolData schoolData,
    required PupilProxy pupil,
    required SchoolSemester semester,

    required pw.Font fontRegular,
    required pw.Font fontBold,
  }) {
    return [
      pw.Text(
        'Bemerkungen:',
        style: pw.TextStyle(font: fontBold, fontSize: 11),
      ),
      pw.SizedBox(height: 6),
      pw.Container(
        width: double.infinity,
        padding: const pw.EdgeInsets.all(6),
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.black, width: 0.5),
        ),
        child: pw.Text(
          '',
          style: pw.TextStyle(font: fontRegular, fontSize: 10),
        ),
      ),
      pw.SizedBox(height: 10),
      if (semester.reportConferenceDate != null)
        pw.Text(
          'Konferenzbeschluss vom ${common_pdf.CommonPdfHelpers.formatDate(semester.reportConferenceDate!)}',
          style: pw.TextStyle(font: fontRegular, fontSize: 10),
        ),
      if (semester.reportConferenceDate != null) pw.SizedBox(height: 4),
      pw.Text(
        'Wiederbeginn des Unterrichts am …',
        style: pw.TextStyle(font: fontRegular, fontSize: 10),
      ),
      pw.SizedBox(height: 20),
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Klassenleitung',
                  style: pw.TextStyle(font: fontRegular, fontSize: 10),
                ),
                pw.SizedBox(height: 2),
                pw.Text(
                  pupil.groupTutor ?? '',
                  style: pw.TextStyle(font: fontRegular, fontSize: 12),
                ),
                pw.SizedBox(height: 24),
                pw.Container(height: 0.5, color: PdfColors.black),
              ],
            ),
          ),
          pw.SizedBox(width: 24),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Schulleitung',
                  style: pw.TextStyle(font: fontRegular, fontSize: 10),
                ),

                pw.SizedBox(height: 2),
                pw.Text(
                  di<SchoolDataMainManager>().schoolData.value?.principalName ??
                      '',
                  style: pw.TextStyle(font: fontRegular, fontSize: 12),
                ),
                pw.SizedBox(height: 24),
                pw.Container(height: 0.5, color: PdfColors.black),
              ],
            ),
          ),
        ],
      ),
      pw.SizedBox(height: 24),
      pw.Text(
        'Ort und Datum',
        style: pw.TextStyle(font: fontRegular, fontSize: 10),
      ),
      pw.SizedBox(height: 8),
      pw.Text(
        '${schoolData.city ?? ""}, ${semester.reportSignedDate != null ? common_pdf.CommonPdfHelpers.formatDate(semester.reportSignedDate!) : "…………."}',
        style: pw.TextStyle(font: fontRegular, fontSize: 10),
      ),
      pw.SizedBox(height: 16),
      pw.Text(
        'Unterschrift eines/einer Erziehungsberechtigten',
        style: pw.TextStyle(font: fontRegular, fontSize: 10),
      ),
      pw.SizedBox(height: 20),
      pw.Container(height: 0.5, color: PdfColors.black),
    ];
  }

  static pw.Page build({
    required SchoolData schoolData,
    required PupilProxy pupil,
    required SchoolSemester semester,
    pw.MemoryImage? sealImage,
    required pw.Font fontRegular,
    required pw.Font fontBold,
    required int totalPages,
  }) {
    final schoolName = schoolData.officialName;
    final pupilName = '${pupil.firstName} ${pupil.lastName}';

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
              pageNumber: totalPages,
              totalPages: totalPages,
              font: fontRegular,
            ),
            pw.SizedBox(height: 8),
            pw.Divider(color: PdfColors.black, thickness: 0.5),
            pw.SizedBox(height: 14),
            ...buildSignaturesContent(
              schoolData: schoolData,
              pupil: pupil,
              semester: semester,

              fontRegular: fontRegular,
              fontBold: fontBold,
            ),
          ],
        );
      },
    );
  }
}

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/pdf/pdf_helpers.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

/// Page 4: Notes and Signatures.
class PdfPage4 {
  PdfPage4._();

  static pw.Page build({
    required LearningSupportPlan plan,
    required PupilProxy pupil,
    required pw.Font fontRegular,
    required pw.Font fontBold,
    required String location,
    required pw.MemoryImage checkboxImage,
    required pw.MemoryImage checkboxCheckImage,
  }) {
    // Decrypt encrypted comment once for the PDF
    final decryptedComment = plan.comment != null
        ? customEncrypter.decryptString(plan.comment!)
        : '';

    return pw.Page(
      pageFormat: PdfPageFormat.a4.landscape,
      margin: const pw.EdgeInsets.all(20),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            PdfHelpers.buildTemplateHeader(
              pupil: pupil,
              plan: plan,
              pageNumber: 4,
              fontRegular: fontRegular,
            ),
            pw.SizedBox(height: 4),
            pw.Divider(color: PdfColors.black, thickness: 0.5),
            pw.SizedBox(height: 6),

            // 1. Ergänzende Hinweise und Absprachen
            pw.Text(
              'Ergänzende Hinweise und Absprachen',
              style: pw.TextStyle(font: fontBold, fontSize: 10),
            ),
            pw.SizedBox(height: 4),
            pw.Expanded(
              flex: 3,
              child: pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(6),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: 0.5),
                ),
                child: pw.Text(
                  decryptedComment,
                  style: pw.TextStyle(font: fontRegular, fontSize: 9),
                ),
              ),
            ),
            pw.SizedBox(height: 8),

            // 2. Informationen an beteiligte Personen
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black, width: 0.5),
              ),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Container(
                      padding: const pw.EdgeInsets.all(6),
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          right: pw.BorderSide(
                            color: PdfColors.black,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Informationen an beteiligte Personen',
                            style: pw.TextStyle(font: fontBold, fontSize: 9),
                          ),
                          pw.SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(6),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Die Information erfolgt durch',
                            style: pw.TextStyle(font: fontBold, fontSize: 9),
                          ),
                          pw.SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 8),

            // 3. Verantwortlich für die Dokumentation
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(6),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black, width: 0.5),
              ),
              child: pw.Row(
                children: [
                  pw.Text(
                    'Verantwortlich für die Dokumentation:',
                    style: pw.TextStyle(font: fontBold, fontSize: 9),
                  ),
                  pw.SizedBox(width: 10),
                  PdfHelpers.checkboxWidget(
                    checked: false,
                    label: 'Klassenlehrer*in',
                    checkboxImage: checkboxImage,
                    checkboxCheckImage: checkboxCheckImage,
                    fontSize: 8,
                    font: fontRegular,
                  ),

                  pw.SizedBox(width: 10),
                  PdfHelpers.checkboxWidget(
                    checked: false,
                    label: 'Sonderpädagogische Lehrkraft',
                    checkboxImage: checkboxImage,
                    checkboxCheckImage: checkboxCheckImage,
                    fontSize: 8,
                    font: fontRegular,
                  ),

                  pw.SizedBox(width: 10),
                  PdfHelpers.checkboxWidget(
                    checked: false,
                    label: 'Sozialpädagogische Fachkraft',
                    checkboxImage: checkboxImage,
                    checkboxCheckImage: checkboxCheckImage,
                    fontSize: 8,
                    font: fontRegular,
                  ),

                  pw.SizedBox(width: 10),
                  PdfHelpers.checkboxWidget(
                    checked: false,
                    label: 'andere (bitte angeben)',
                    checkboxImage: checkboxImage,
                    checkboxCheckImage: checkboxCheckImage,
                    fontSize: 8,
                    font: fontRegular,
                  ),
                  pw.SizedBox(width: 5),
                  PdfHelpers.fillField(
                    font: fontRegular,
                    width: 100,
                    fontSize: 8,
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Text(
              '$location, ${PdfHelpers.formatDate(plan.createdAt)}',
              style: pw.TextStyle(font: fontRegular, fontSize: 12),
            ),
            pw.SizedBox(height: 8),
            // 4. Signature block (4 columns)
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                _buildSignatureColumn(
                  '',
                  'Klassenlehrer*in',
                  fontRegular,
                  fontBold,
                ),
                pw.SizedBox(width: 20),
                _buildSignatureColumn(
                  '',
                  'Sonderpäd. Lehrkraft',
                  fontRegular,
                  fontBold,
                ),
                pw.SizedBox(width: 20),
                _buildSignatureColumn(
                  '',
                  'Schulleitung',
                  fontRegular,
                  fontBold,
                ),
                pw.SizedBox(width: 20),
                _buildSignatureColumn('', 'Eltern', fontRegular, fontBold),
              ],
            ),
          ],
        );
      },
    );
  }

  static pw.Widget _buildSignatureColumn(
    String topLabel,
    String role,
    pw.Font fontRegular,
    pw.Font fontBold,
  ) {
    return pw.Expanded(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          if (topLabel.isNotEmpty)
            pw.Text(
              topLabel,
              style: pw.TextStyle(font: fontRegular, fontSize: 8),
            ),
          if (topLabel.isNotEmpty) pw.SizedBox(height: 4),
          pw.Text(role, style: pw.TextStyle(font: fontBold, fontSize: 9)),
          pw.Text(
            'Unterschrift',
            style: pw.TextStyle(font: fontRegular, fontSize: 8),
          ),
          pw.SizedBox(height: 20),
          pw.Container(height: 0.5, color: PdfColors.black),
        ],
      ),
    );
  }
}

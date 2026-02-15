import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/pdf/pdf_helpers.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

/// Page 1: Pupil Info and Plan Metadata.
class PdfPage1 {
  PdfPage1._();

  static pw.Page build({
    required LearningSupportPlan plan,
    required PupilProxy pupil,
    required pw.Font fontRegular,
    required pw.Font fontBold,
  }) {
    final supportLevel = pupil.latestSupportLevel?.level;
    final lernjahr = PdfHelpers.calculateLernjahr(pupil);
    final schoolYear = plan.schoolSemester?.schoolYear ?? '';
    final semester = plan.schoolSemester;

    return pw.Page(
      pageFormat: PdfPageFormat.a4.landscape,
      margin: const pw.EdgeInsets.all(20),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // ── Title ──
            pw.Center(
              child: pw.Text(
                'GGS Hermannstraße Stolberg',
                style: pw.TextStyle(
                  font: fontBold,
                  fontSize: 11,
                  fontStyle: pw.FontStyle.italic,
                ),
              ),
            ),
            pw.SizedBox(height: 6),

            // ── 1. Name + Birthday ──
            pw.Container(
              padding: const pw.EdgeInsets.all(6),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black, width: 0.5),
              ),
              child: pw.Row(
                children: [
                  pw.Text(
                    'Name des Kindes:',
                    style: pw.TextStyle(font: fontBold, fontSize: 9),
                  ),
                  pw.SizedBox(width: 4),
                  PdfHelpers.fillField(
                    text: '${pupil.firstName} ${pupil.lastName}',
                    font: fontRegular,
                  ),
                  pw.SizedBox(width: 20),
                  pw.Text(
                    'Geb.-Datum:',
                    style: pw.TextStyle(font: fontBold, fontSize: 9),
                  ),
                  pw.SizedBox(width: 4),
                  PdfHelpers.fillField(
                    text: PdfHelpers.formatDate(pupil.birthday),
                    font: fontRegular,
                    width: 80,
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 2),

            // ── 2. Förderplan Nr. + metadata ──
            pw.Container(
              padding: const pw.EdgeInsets.all(6),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black, width: 0.5),
              ),
              child: pw.Row(
                children: [
                  pw.Text(
                    'Förderplan Nr.:',
                    style: pw.TextStyle(font: fontBold, fontSize: 9),
                  ),
                  pw.SizedBox(width: 4),
                  PdfHelpers.fillField(
                    text: plan.number?.toString() ?? plan.planId,
                    font: fontRegular,
                    width: 40,
                  ),
                  pw.SizedBox(width: 10),
                  pw.Text(
                    'vom:',
                    style: pw.TextStyle(font: fontBold, fontSize: 9),
                  ),
                  pw.SizedBox(width: 4),
                  PdfHelpers.fillField(
                    text: PdfHelpers.formatDate(plan.createdAt),
                    font: fontRegular,
                    width: 70,
                  ),
                  pw.SizedBox(width: 10),
                  pw.Text(
                    'Schuljahr',
                    style: pw.TextStyle(font: fontBold, fontSize: 9),
                  ),
                  PdfHelpers.fillField(
                    text: schoolYear,
                    font: fontRegular,
                    width: 30,
                  ),

                  pw.SizedBox(width: 10),
                  pw.Text(
                    'Schulbesuchsjahr:',
                    style: pw.TextStyle(font: fontBold, fontSize: 9),
                  ),
                  pw.SizedBox(width: 4),
                  PdfHelpers.fillField(
                    text: PdfHelpers.calculateSchulbesuchsjahr(pupil)
                        .toString(),
                    font: fontRegular,
                    width: 30,
                  ),
                  pw.SizedBox(width: 10),
                  pw.Text(
                    'Klasse:',
                    style: pw.TextStyle(font: fontBold, fontSize: 9),
                  ),
                  pw.SizedBox(width: 4),
                  PdfHelpers.fillField(
                    text: pupil.group,
                    font: fontRegular,
                    width: 40,
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 2),

            // ── 3. Plan type checkboxes + support codes (side by side) ──
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black, width: 0.5),
              ),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Left: checkboxes
                  pw.Expanded(
                    flex: 3,
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
                            '${PdfHelpers.checkbox(supportLevel == 1)} Individueller Förderplan (FE I)',
                            style: pw.TextStyle(font: fontRegular, fontSize: 8),
                          ),
                          pw.Text(
                            '   falls Schriftform gewünscht',
                            style: pw.TextStyle(font: fontRegular, fontSize: 7),
                          ),
                          pw.SizedBox(height: 4),
                          pw.Text(
                            '${PdfHelpers.checkbox(supportLevel == 2)} Individuell erweiterter Förderplan [FE II]',
                            style: pw.TextStyle(font: fontRegular, fontSize: 8),
                          ),
                          pw.Text(
                            '   z.B. LRS, Rechenschwäche, AD(H)S, Hochbegabung',
                            style: pw.TextStyle(font: fontRegular, fontSize: 7),
                          ),
                          pw.SizedBox(height: 4),
                          pw.Text(
                            '${PdfHelpers.checkbox(supportLevel == 3)} Förderplan gemäß AO-SF § 21(7) mit sonder-',
                            style: pw.TextStyle(font: fontRegular, fontSize: 8),
                          ),
                          pw.Text(
                            '   pädagogischer Unterstützung (FE III)',
                            style: pw.TextStyle(font: fontRegular, fontSize: 8),
                          ),
                          pw.SizedBox(height: 3),
                          pw.Row(
                            children: [
                              pw.SizedBox(width: 16),
                              pw.Text(
                                'O mit Bescheid vom',
                                style: pw.TextStyle(
                                  font: fontRegular,
                                  fontSize: 8,
                                ),
                              ),
                              pw.SizedBox(width: 4),
                              PdfHelpers.fillField(
                                font: fontRegular,
                                width: 80,
                                fontSize: 8,
                              ),
                            ],
                          ),
                          pw.SizedBox(height: 2),
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(left: 16),
                            child: pw.Text(
                              'O ohne Bescheid',
                              style: pw.TextStyle(
                                font: fontRegular,
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Right: support codes
                  pw.Expanded(
                    flex: 2,
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(6),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.SizedBox(height: 4),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildCodeBox('LE', pupil.specialNeeds, fontBold),
                              _buildCodeBox(
                                'ESE',
                                pupil.specialNeeds,
                                fontBold,
                              ),
                              _buildCodeBox('SQ', pupil.specialNeeds, fontBold),
                              _buildCodeBox(
                                'KME',
                                pupil.specialNeeds,
                                fontBold,
                              ),
                              _buildCodeBox('GE', pupil.specialNeeds, fontBold),
                              _buildCodeBox('SE', pupil.specialNeeds, fontBold),
                              _buildCodeBox('HK', pupil.specialNeeds, fontBold),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 2),

            // ── 4. Phone + Contacts ──
            pw.Container(
              padding: const pw.EdgeInsets.all(6),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black, width: 0.5),
              ),
              child: pw.Row(
                children: [
                  pw.Text(
                    'Tel.:',
                    style: pw.TextStyle(font: fontBold, fontSize: 9),
                  ),
                  pw.SizedBox(width: 4),
                  PdfHelpers.fillField(font: fontRegular, width: 100),
                  pw.SizedBox(width: 10),
                  pw.Text(
                    'Tel.mobil:',
                    style: pw.TextStyle(font: fontBold, fontSize: 9),
                  ),
                  pw.SizedBox(width: 4),
                  PdfHelpers.fillField(font: fontRegular, width: 100),
                  pw.SizedBox(width: 10),
                  pw.Text(
                    'weitere Kontaktdaten:',
                    style: pw.TextStyle(font: fontBold, fontSize: 9),
                  ),
                  pw.SizedBox(width: 4),
                  PdfHelpers.fillField(font: fontRegular),
                ],
              ),
            ),
            pw.SizedBox(height: 2),

            // ── 5. Personnel ──
            pw.Container(
              padding: const pw.EdgeInsets.all(6),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black, width: 0.5),
              ),
              child: pw.Row(
                children: [
                  pw.Text(
                    'Sozialpäd. Fachkraft:',
                    style: pw.TextStyle(font: fontBold, fontSize: 9),
                  ),
                  pw.SizedBox(width: 4),
                  PdfHelpers.fillField(
                    text: PdfHelpers.resolveUserName(plan.socialPedagogue),
                    font: fontRegular,
                  ),
                  pw.SizedBox(width: 10),
                  pw.Text(
                    'Klassenlehrer*in:',
                    style: pw.TextStyle(font: fontBold, fontSize: 9),
                  ),
                  pw.SizedBox(width: 4),
                  PdfHelpers.fillField(
                    text: PdfHelpers.resolveUserName(pupil.groupTutor),
                    font: fontRegular,
                  ),
                  pw.SizedBox(width: 10),
                  pw.Text(
                    'SoL.:',
                    style: pw.TextStyle(font: fontBold, fontSize: 9),
                  ),
                  pw.SizedBox(width: 4),
                  PdfHelpers.fillField(font: fontRegular, width: 100),
                ],
              ),
            ),
            pw.SizedBox(height: 2),

            // ── 6. Beteiligte + Stärken (side by side) ──
            pw.Expanded(
              child: pw.Container(
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
                              'Weitere beteiligte\nPersonen und\nOrganisationen',
                              style: pw.TextStyle(font: fontBold, fontSize: 8),
                            ),
                            pw.SizedBox(height: 4),
                            pw.Text(
                              plan.proffesionalsInvolved ?? '',
                              style: pw.TextStyle(
                                font: fontRegular,
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(
                              children: [
                                for (int i = 0; i < 6; i++) ...[
                                  pw.Container(
                                    width: 10,
                                    height: 10,
                                    decoration: const pw.BoxDecoration(
                                      color: PdfColors.amber,
                                      shape: pw.BoxShape.circle,
                                    ),
                                  ),
                                  if (i < 5) pw.SizedBox(width: 4),
                                ],
                                pw.SizedBox(width: 10),
                                pw.Text(
                                  ' Stärken',
                                  style: pw.TextStyle(
                                    font: fontBold,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 4),
                            pw.Text(
                              plan.strengthsDescription ?? '',
                              style: pw.TextStyle(
                                font: fontRegular,
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            pw.SizedBox(height: 2),

            // ── 7. Problematik ──
            pw.Expanded(
              child: pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(6),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: 0.5),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      children: [
                        pw.Text(
                          'Problematik',
                          style: pw.TextStyle(font: fontBold, fontSize: 10),
                        ),
                        pw.SizedBox(width: 6),
                        pw.Text(
                          '[2-3 Zielschwerpunkte]',
                          style: pw.TextStyle(font: fontRegular, fontSize: 8),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      plan.problemsDescription ?? '',
                      style: pw.TextStyle(font: fontRegular, fontSize: 8),
                    ),
                  ],
                ),
              ),
            ),
            pw.SizedBox(height: 2),

            // ── 8. Sprachbiografie ──
            pw.Container(
              padding: const pw.EdgeInsets.all(6),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black, width: 0.5),
              ),
              child: pw.Row(
                children: [
                  pw.Text(
                    'Sprachbiografie',
                    style: pw.TextStyle(font: fontBold, fontSize: 9),
                  ),
                  pw.SizedBox(width: 10),
                  pw.Text(
                    '${PdfHelpers.checkbox(lernjahr == 1)} 1. Lernjahr Deutsch',
                    style: pw.TextStyle(font: fontRegular, fontSize: 8),
                  ),
                  pw.SizedBox(width: 8),
                  pw.Text(
                    '${PdfHelpers.checkbox(lernjahr == 2)} 2. Lernjahr Deutsch',
                    style: pw.TextStyle(font: fontRegular, fontSize: 8),
                  ),
                  pw.SizedBox(width: 8),
                  pw.Text(
                    '${PdfHelpers.checkbox(lernjahr == 3)} 3. Lernjahr Deutsch',
                    style: pw.TextStyle(font: fontRegular, fontSize: 8),
                  ),
                  pw.SizedBox(width: 8),
                  pw.Text(
                    '${PdfHelpers.checkbox(lernjahr == 4)} >3. Lernjahr Deutsch',
                    style: pw.TextStyle(font: fontRegular, fontSize: 8),
                  ),
                  pw.Spacer(),
                  pw.Text(
                    'Herkunftssprache:',
                    style: pw.TextStyle(font: fontBold, fontSize: 9),
                  ),
                  pw.SizedBox(width: 4),
                  PdfHelpers.fillField(
                    text: pupil.language,
                    font: fontRegular,
                    width: 100,
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 6),

            // ── Footer ──
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Stand ${PdfHelpers.formatDate(plan.createdAt)}  ${pupil.firstName} ${pupil.lastName}, Förderplan SJ',
                  style: pw.TextStyle(font: fontRegular, fontSize: 8),
                ),
                pw.Text(
                  'Seite 1 von 4',
                  style: pw.TextStyle(font: fontRegular, fontSize: 8),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  static pw.Widget _buildCodeBox(
    String code,
    String? specialNeeds,
    pw.Font font,
  ) {
    final isActive =
        specialNeeds != null &&
        specialNeeds.toUpperCase().contains(code.toUpperCase());
    return pw.Container(
      width: 28,
      height: 22,
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black, width: 0.5),
        color: isActive ? PdfColors.grey300 : null,
      ),
      child: pw.Center(
        child: pw.Text(
          code,
          style: pw.TextStyle(
            font: font,
            fontSize: 7,
            fontWeight: isActive ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/pdf/pdf_helpers.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

/// Page 1: Pupil Info and Plan Metadata.
class PdfPage1 {
  PdfPage1._();

  static pw.Page build({
    required LearningSupportPlan plan,
    required SchoolData schoolData,
    required PupilProxy pupil,
    required pw.Font fontRegular,
    required pw.Font fontBold,
  }) {
    final supportLevel = pupil.latestSupportLevel?.level;
    final lernjahr = PdfHelpers.calculateLernjahr(pupil);
    final schoolYear = plan.schoolSemester?.schoolYear ?? '';
    final semester = plan.schoolSemester;

    // Decrypt encrypted fields once for the PDF
    final decryptedStrengths = plan.strengthsDescription != null
        ? customEncrypter.decryptString(plan.strengthsDescription!)
        : '';
    final decryptedProblems = plan.problemsDescription != null
        ? customEncrypter.decryptString(plan.problemsDescription!)
        : '';

    return pw.Page(
      pageFormat: PdfPageFormat.a4.landscape,
      margin: const pw.EdgeInsets.all(20),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // ── Title ──
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  schoolData.officialName,
                  style: pw.TextStyle(
                    font: fontBold,
                    fontSize: 15,
                    fontStyle: pw.FontStyle.italic,
                  ),
                ),
                pw.Text(
                  'Schulnr.: ${schoolData.schoolNumber}',
                  style: pw.TextStyle(
                    font: fontRegular,
                    fontSize: 10,
                    fontStyle: pw.FontStyle.italic,
                  ),
                ),
                pw.Text(
                  'Förderplan',
                  style: pw.TextStyle(
                    font: fontBold,
                    fontSize: 15,
                    fontStyle: pw.FontStyle.italic,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 2),
            // ── 1. Name + Birthday ──
            pw.Container(
              padding: const pw.EdgeInsets.all(6),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black, width: 0.5),
                //  borderRadius: pw.BorderRadius.circular(4),
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
            pw.SizedBox(height: 3),

            // ── 2. Förderplan Nr. + metadata ──
            pw.Container(
              padding: const pw.EdgeInsets.all(6),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black, width: 0.5),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Row(
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
                    ],
                  ),
                  pw.Row(
                    children: [
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
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text(
                        'Schuljahr:',
                        style: pw.TextStyle(font: fontBold, fontSize: 9),
                      ),
                      pw.SizedBox(width: 4),
                      PdfHelpers.fillField(
                        text: schoolYear,
                        font: fontRegular,
                        width: 70,
                      ),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text(
                        'Schulbesuchsjahr:',
                        style: pw.TextStyle(font: fontBold, fontSize: 9),
                      ),
                      pw.SizedBox(width: 4),
                      PdfHelpers.fillField(
                        text: PdfHelpers.calculateSchulbesuchsjahr(
                          pupil,
                        ).toString(),
                        font: fontRegular,
                        width: 30,
                      ),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text(
                        'Jahrgang:',
                        style: pw.TextStyle(font: fontBold, fontSize: 9),
                      ),
                      pw.SizedBox(width: 4),
                      PdfHelpers.fillField(
                        text: pupil.schoolGrade.name,
                        font: fontRegular,
                        width: 30,
                      ),
                    ],
                  ),
                  pw.Row(
                    children: [
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
                ],
              ),
            ),
            pw.SizedBox(height: 3),

            // ── 3. Plan type checkboxes + support codes ──
            pw.Container(
              padding: const pw.EdgeInsets.all(6),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black, width: 0.5),
              ),
              child: pw.Column(
                children: [
                  // Checkboxes row
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Column(
                        children: [
                          pw.Text(
                            '${PdfHelpers.checkbox(supportLevel == 1)}  Individueller Förderplan (FE I)',
                            style: pw.TextStyle(font: fontRegular, fontSize: 8),
                          ),
                          pw.Text(
                            '   falls Schriftform gewünscht',
                            style: pw.TextStyle(font: fontRegular, fontSize: 6),
                          ),
                        ],
                      ),
                      pw.Column(
                        children: [
                          pw.Text(
                            '${PdfHelpers.checkbox(supportLevel == 2)}  Individuell erweiterter Förderplan [FE II]',
                            style: pw.TextStyle(font: fontRegular, fontSize: 8),
                          ),
                          pw.Text(
                            'z.B. LRS, Rechenschwäche, AD(H)S, Hochbegabung',
                            style: pw.TextStyle(font: fontRegular, fontSize: 6),
                          ),
                        ],
                      ),
                      pw.Column(
                        children: [
                          pw.Text(
                            '${PdfHelpers.checkbox(supportLevel == 3)}  Förderplan gemäß AO-SF § 21(7) mit sonder-',
                            style: pw.TextStyle(font: fontRegular, fontSize: 8),
                          ),
                          pw.Text(
                            'pädagogischer Unterstützung (FE III)',
                            style: pw.TextStyle(font: fontRegular, fontSize: 8),
                          ),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Row(
                            children: [
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
                          pw.Text(
                            'O ohne Bescheid',
                            style: pw.TextStyle(font: fontRegular, fontSize: 8),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 6),
                  // Support codes row
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Text(
                        'Förderschwerpunkt(e):',
                        style: pw.TextStyle(font: fontBold, fontSize: 9),
                      ),
                      pw.SizedBox(width: 6),
                      _buildCodeBox('LE', pupil.specialNeeds, fontBold),
                      pw.SizedBox(width: 6),
                      _buildCodeBox('ESE', pupil.specialNeeds, fontBold),
                      pw.SizedBox(width: 6),
                      _buildCodeBox('SQ', pupil.specialNeeds, fontBold),
                      pw.SizedBox(width: 6),
                      _buildCodeBox('KME', pupil.specialNeeds, fontBold),
                      pw.SizedBox(width: 6),
                      _buildCodeBox('GE', pupil.specialNeeds, fontBold),
                      pw.SizedBox(width: 6),
                      _buildCodeBox('SE', pupil.specialNeeds, fontBold),
                      pw.SizedBox(width: 6),
                      _buildCodeBox('HK', pupil.specialNeeds, fontBold),
                      pw.SizedBox(width: 6),
                    ],
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 3),

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
            pw.SizedBox(height: 3),

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
                    'Sonderpäd. Fachkraft:',
                    style: pw.TextStyle(font: fontBold, fontSize: 9),
                  ),
                  pw.SizedBox(width: 4),
                  PdfHelpers.fillField(
                    text: PdfHelpers.resolveUserName(plan.specialNeedsTeacher),
                    font: fontRegular,
                    width: 100,
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 3),

            // ── 6. Beteiligte ──
            pw.Expanded(
              flex: 1,
              child: pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(6),
                decoration: const pw.BoxDecoration(
                  border: pw.Border(
                    top: pw.BorderSide(color: PdfColors.black, width: 0.5),
                    left: pw.BorderSide(color: PdfColors.black, width: 0.5),
                    right: pw.BorderSide(color: PdfColors.black, width: 0.5),
                  ),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Weitere beteiligte Personen und Organisationen',
                      style: pw.TextStyle(font: fontBold, fontSize: 8),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      plan.proffesionalsInvolved ?? '',
                      style: pw.TextStyle(font: fontRegular, fontSize: 8),
                    ),
                  ],
                ),
              ),
            ),
            pw.SizedBox(height: 3),
            // ── 7. Stärken ──
            pw.Expanded(
              flex: 3,
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
                          'Stärken',
                          style: pw.TextStyle(font: fontBold, fontSize: 10),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      decryptedStrengths,
                      style: pw.TextStyle(font: fontRegular, fontSize: 8),
                    ),
                  ],
                ),
              ),
            ),
            pw.SizedBox(height: 3),

            // ── 8. Problematik ──
            pw.Expanded(
              flex: 3,
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
                      decryptedProblems,
                      style: pw.TextStyle(font: fontRegular, fontSize: 8),
                    ),
                  ],
                ),
              ),
            ),
            pw.SizedBox(height: 3),

            // ── 9. Sprachbiografie ──
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
            fontSize: 10,
            fontWeight: isActive ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

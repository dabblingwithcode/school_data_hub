import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/pdf/pdf_helpers.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

/// Page 1: Pupil Info and Plan Metadata.
class PdfPage1 {
  PdfPage1._();

  static pw.Page build({
    required LearningSupportPlan plan,
    required SchoolData schoolData,
    required PupilProxy pupil,
    required pw.Font fontRegular,
    required pw.Font fontBold,
    required pw.MemoryImage checkboxImage,
    required pw.MemoryImage checkboxCheckImage,
    required pw.MemoryImage strengthImage,
  }) {
    final supportLevel = pupil.latestSupportLevel?.level;
    final lernjahr = PdfHelpers.calculateLernjahr(pupil);
    final schoolYear = plan.schoolSemester?.schoolYear ?? '';

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
            pw.SizedBox(height: 4),
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
                          PdfHelpers.checkboxWidget(
                            checked: supportLevel == 1,
                            label: 'Individueller Förderplan (FE I)',
                            checkboxImage: checkboxImage,
                            checkboxCheckImage: checkboxCheckImage,
                            font: fontRegular,
                            fontSize: 9,
                          ),
                          pw.Text(
                            '   falls Schriftform gewünscht',
                            style: pw.TextStyle(font: fontRegular, fontSize: 6),
                          ),
                        ],
                      ),
                      pw.Column(
                        children: [
                          PdfHelpers.checkboxWidget(
                            checked: supportLevel == 2,
                            label: 'Individuell erweiterter Förderplan (FE II)',
                            checkboxImage: checkboxImage,
                            checkboxCheckImage: checkboxCheckImage,
                            font: fontRegular,
                            fontSize: 9,
                          ),
                          pw.Text(
                            'z.B. LRS, Rechenschwäche, AD(H)S, Hochbegabung',
                            style: pw.TextStyle(font: fontRegular, fontSize: 6),
                          ),
                        ],
                      ),
                      pw.Column(
                        children: [
                          PdfHelpers.checkboxWidget(
                            checked: supportLevel == 3,
                            label: 'Förderplan gemäß AO-SF § 21(7) mit sonder-',
                            checkboxImage: checkboxImage,
                            checkboxCheckImage: checkboxCheckImage,
                            font: fontRegular,
                            fontSize: 9,
                          ),
                          pw.Text(
                            'pädagogischer Unterstützung (FE III)',
                            style: pw.TextStyle(font: fontRegular, fontSize: 9),
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
                                  fontSize: 9,
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
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Row(
                    children: [
                      pw.Text(
                        'Sozialpäd. Fachkraft:',
                        style: pw.TextStyle(font: fontBold, fontSize: 9),
                      ),
                      pw.SizedBox(width: 4),
                      PdfHelpers.fillField(
                        text: PdfHelpers.resolveUserName(plan.socialPedagogue),
                        font: fontRegular,
                        width: 120,
                      ),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text(
                        'Klassenlehrer*in:',
                        style: pw.TextStyle(font: fontBold, fontSize: 9),
                      ),
                      pw.SizedBox(width: 4),
                      PdfHelpers.fillField(
                        text: PdfHelpers.resolveUserName(pupil.groupTutor),
                        font: fontRegular,
                        width: 120,
                      ),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text(
                        'Sonderpäd. Fachkraft:',
                        style: pw.TextStyle(font: fontBold, fontSize: 9),
                      ),
                      pw.SizedBox(width: 4),
                      PdfHelpers.fillField(
                        text: PdfHelpers.resolveUserName(
                          plan.specialNeedsTeacher,
                        ),
                        font: fontRegular,
                        width: 120,
                      ),
                    ],
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
                        pw.Image(strengthImage, width: 18, height: 20),
                        pw.SizedBox(width: 5),
                        pw.Text(
                          'Stärken',
                          style: pw.TextStyle(font: fontBold, fontSize: 20),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      decryptedStrengths,
                      style: pw.TextStyle(font: fontRegular, fontSize: 11),
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
                          style: pw.TextStyle(font: fontBold, fontSize: 20),
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
                      style: pw.TextStyle(font: fontRegular, fontSize: 11),
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
                    style: pw.TextStyle(font: fontBold, fontSize: 12),
                  ),
                  pw.SizedBox(width: 10),
                  PdfHelpers.checkboxWidget(
                    checked: lernjahr == 1,
                    label: '1. Lernjahr Deutsch',
                    checkboxImage: checkboxImage,
                    checkboxCheckImage: checkboxCheckImage,
                    font: fontRegular,
                  ),
                  pw.SizedBox(width: 8),
                  PdfHelpers.checkboxWidget(
                    checked: lernjahr == 2,
                    label: '2. Lernjahr Deutsch',
                    checkboxImage: checkboxImage,
                    checkboxCheckImage: checkboxCheckImage,
                    font: fontRegular,
                  ),
                  pw.SizedBox(width: 8),
                  PdfHelpers.checkboxWidget(
                    checked: lernjahr == 3,
                    label: '3. Lernjahr Deutsch',
                    checkboxImage: checkboxImage,
                    checkboxCheckImage: checkboxCheckImage,
                    font: fontRegular,
                  ),
                  pw.SizedBox(width: 8),
                  PdfHelpers.checkboxWidget(
                    checked: lernjahr == 4,
                    label: '>3. Lernjahr Deutsch',
                    checkboxImage: checkboxImage,
                    checkboxCheckImage: checkboxCheckImage,
                    font: fontRegular,
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
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
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
    final parts = specialNeeds?.split('*');
    final upperCode = code.toUpperCase();
    final isActive =
        parts != null &&
        (parts.first.toUpperCase() == upperCode ||
            parts.last.toUpperCase() == upperCode);
    return pw.Container(
      width: 40,
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
            fontSize: 15,
            fontWeight: isActive ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter_it/flutter_it.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/pdf/pdf_helpers.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

/// Page 3: Goals Detail Table.
class PdfPage3 {
  PdfPage3._();

  static pw.Page build({
    required LearningSupportPlan plan,
    required PupilProxy pupil,
    required List<SupportCategory> supportCategories,
    required pw.Font fontRegular,
    required pw.Font fontBold,
  }) {
    // Build status lookup for "Ist-Stand" column
    // Statuses live on the pupil, not on the plan object. Filter for this plan.
    final statusMap = <int, SupportCategoryStatus>{};
    final allStatuses = pupil.supportCategoryStatuses;
    if (allStatuses != null) {
      for (final status in allStatuses) {
        if (status.learningSupportPlanId == plan.id) {
          statusMap[status.supportCategoryId] = status;
        }
      }
    }

    final goals = pupil.supportGoals ?? [];

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
              pageNumber: 3,
              fontRegular: fontRegular,
            ),
            pw.SizedBox(height: 4),
            pw.Divider(color: PdfColors.black, thickness: 0.5),
            pw.SizedBox(height: 4),

            // Goals table
            pw.Expanded(
              child: pw.Table(
                border: pw.TableBorder.all(color: PdfColors.black, width: 0.5),
                columnWidths: const {
                  0: pw.FlexColumnWidth(8),
                  1: pw.FlexColumnWidth(10),
                  2: pw.FlexColumnWidth(20),
                  3: pw.FlexColumnWidth(20),
                  4: pw.FlexColumnWidth(25),
                  5: pw.FlexColumnWidth(17),
                },
                children: [
                  // Header row
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.grey200,
                    ),
                    children: [
                      PdfHelpers.tableHeaderCell('Datum', fontBold),
                      PdfHelpers.tableHeaderCell('Bereich', fontBold),
                      PdfHelpers.tableHeaderCell(
                        '\u201EIst-Stand\u201C: Stärken, Bedürfnisse, Probleme\ndes / der Schülers/in',
                        fontBold,
                      ),
                      PdfHelpers.tableHeaderCell(
                        '\u201EDas will ich noch lernen\u201C\nTeilaspekte der Zielschwerpunkte',
                        fontBold,
                      ),
                      PdfHelpers.tableHeaderCell2TextStyles(
                        text1:
                            '\u201EDas kann mir dabei helfen\u201C - Schulische Fördermethoden\n ',
                        font1: fontBold,
                        text2:
                            'Innerhalb/ausßerhalb des Klassenverbandes, Fördermaterialien bzw. \u2013programme, Absprachen mit Eltern / anderen Diensten',
                        font2: fontRegular,
                      ),

                      PdfHelpers.tableHeaderCell(
                        '\u201EDas hat sich verbessert\u201C\nErgebnis der Förderung',
                        fontBold,
                      ),
                    ],
                  ),
                  // Data rows
                  ...goals.map((goal) {
                    final category = supportCategories
                        .where((c) => c.categoryId == goal.supportCategoryId)
                        .firstOrNull;
                    final categoryName = category?.name ?? 'Unbekannt';
                    final rootCategoryName = category != null
                        ? di<SupportCategoryManager>()
                              .getRootSupportCategory(category.id!)
                              .name
                        : 'Unbekannt';
                    final status = statusMap[goal.supportCategoryId];
                    final istStand = status?.comment ?? '';
                    final achievedText = goal.goalChecks != null
                        ? goal.goalChecks!
                              .map(
                                (check) =>
                                    ('${check.comment} (${check.createdAt.formatDateForUser()} von ${check.createdBy})'),
                              )
                              .join('\n')
                        : '';

                    return pw.TableRow(
                      children: [
                        PdfHelpers.tableDataCell(
                          PdfHelpers.formatDate(goal.createdAt),
                          fontRegular,
                        ),
                        PdfHelpers.tableDataCell(
                          '$rootCategoryName\n$categoryName',
                          fontRegular,
                        ),
                        PdfHelpers.tableDataCell(istStand, fontRegular),
                        PdfHelpers.tableDataCell(goal.description, fontRegular),
                        PdfHelpers.tableDataCell(goal.strategies, fontRegular),
                        PdfHelpers.tableDataCell(achievedText, fontRegular),
                      ],
                    );
                  }),
                  // If no goals, add an empty row for the form feel
                  if (goals.isEmpty)
                    pw.TableRow(
                      children: [
                        for (int i = 0; i < 6; i++)
                          PdfHelpers.tableDataCell(
                            '',
                            fontRegular,
                            minHeight: 80,
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

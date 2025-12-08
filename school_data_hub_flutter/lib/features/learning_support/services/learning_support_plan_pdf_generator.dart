import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_helper.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('LearningSupportPlanPdfGenerator');

class LearningSupportPlanPdfGenerator {
  static SchoolCalendarManager get _schoolCalendarManager =>
      di<SchoolCalendarManager>();
  static Future<File> generateLearningSupportPlanPdf({
    required LearningSupportPlan plan,
    required PupilProxy pupil,
    required List<SupportCategory> supportCategories,
  }) async {
    final data = await rootBundle.load('assets/foreground_windows.png');
    final imageBytes = data.buffer.asUint8List();
    final image = pw.MemoryImage(imageBytes);

    // Load fonts - using default fonts for now
    final fontRegular = pw.Font.helvetica();
    final fontBold = pw.Font.helveticaBold();

    final pdf = pw.Document();

    di<NotificationService>().setHeavyLoadingValue(true);

    try {
      // Page 1: Main learning support plan information
      pdf.addPage(
        _buildMainPage(
          image: image,
          plan: plan,
          pupil: pupil,
          fontRegular: fontRegular,
          fontBold: fontBold,
        ),
      );

      // Page 2: Support category statuses overview
      pdf.addPage(
        _buildSupportCategoriesPage(
          image: image,
          plan: plan,
          pupil: pupil,
          supportCategories: supportCategories,
          fontRegular: fontRegular,
          fontBold: fontBold,
        ),
      );

      // Page 3: Detailed support statuses and goals
      pdf.addPage(
        _buildSupportDetailsPage(
          image: image,
          plan: plan,
          pupil: pupil,
          supportCategories: supportCategories,
          fontRegular: fontRegular,
          fontBold: fontBold,
        ),
      );
    } finally {
      di<NotificationService>().setHeavyLoadingValue(false);
    }

    // Get the proper directory for saving files
    final directory = await getApplicationDocumentsDirectory();
    final fileName =
        "Förderplan_${pupil.firstName}_${pupil.lastName}_${DateTime.now().formatDateForUser()}.pdf";
    final file = File('${directory.path}/$fileName');

    await file.writeAsBytes(await pdf.save());
    _log.info('Learning Support Plan PDF generated: ${file.path}');
    return file;
  }

  static pw.Page _buildMainPage({
    required pw.MemoryImage image,
    required LearningSupportPlan plan,
    required PupilProxy pupil,
    required pw.Font fontRegular,
    required pw.Font fontBold,
  }) {
    final currentSemester = _schoolCalendarManager.currentSemester.value;

    return pw.Page(
      pageFormat: PdfPageFormat.a4.landscape,
      margin: const pw.EdgeInsets.all(20),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Header with school name
            pw.Text(
              'GGS Hermannstraße Stolberg',
              style: pw.TextStyle(
                fontSize: 12,
                font: fontRegular,
                color: PdfColors.grey600,
              ),
            ),
            pw.SizedBox(height: 20),

            // Title
            pw.Center(
              child: pw.Text(
                'FÖRDERPLAN',
                style: pw.TextStyle(
                  fontSize: 24,
                  font: fontBold,
                  color: PdfColors.black,
                ),
              ),
            ),
            pw.SizedBox(height: 30),

            // Main Information Section (First Block)
            _buildMainInfoSection(
              plan,
              pupil,
              currentSemester,
              fontRegular,
              fontBold,
            ),
            pw.SizedBox(height: 20),

            // Förderplan Type Section (Second Block)
            _buildForderplanTypeSection(plan, fontRegular, fontBold),
            pw.SizedBox(height: 20),

            // Contact and Support Codes Section (Third Block)
            _buildContactSection(pupil, fontRegular, fontBold),
            pw.SizedBox(height: 20),

            // Personnel Section (Fourth Block)
            _buildPersonnelSection(plan, pupil, fontRegular, fontBold),
            pw.SizedBox(height: 20),

            // Weitere Beteiligte Section (Fifth Block)
            if (plan.proffesionalsInvolved?.isNotEmpty ?? false)
              _buildWeitereBeteiligteSection(plan, fontRegular, fontBold),
            pw.SizedBox(height: 20),

            // Stärken Section (Sixth Block)
            if (plan.strengthsDescription?.isNotEmpty ?? false)
              _buildStaerkenSection(plan, fontRegular, fontBold),
            pw.SizedBox(height: 20),

            // Problematik Section (Seventh Block)
            if (plan.problemsDescription?.isNotEmpty ?? false)
              _buildProblematikSection(plan, fontRegular, fontBold),
            pw.SizedBox(height: 20),

            // Sprachbiografie Section (Eighth Block)
            _buildSprachbiografieSection(pupil, fontRegular, fontBold),

            // Footer
            pw.Spacer(),
            _buildFooter(fontRegular),
          ],
        );
      },
    );
  }

  static pw.Page _buildSupportCategoriesPage({
    required pw.MemoryImage image,
    required LearningSupportPlan plan,
    required PupilProxy pupil,
    required List<SupportCategory> supportCategories,
    required pw.Font fontRegular,
    required pw.Font fontBold,
  }) {
    return pw.Page(
      pageFormat: PdfPageFormat.a4.landscape,
      margin: const pw.EdgeInsets.all(20),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(image, 'Förderbereiche', 2, 3, fontRegular, fontBold),
            pw.SizedBox(height: 20),

            // Title
            pw.Center(
              child: pw.Text(
                'FÖRDERBEREICHE',
                style: pw.TextStyle(
                  fontSize: 24,
                  font: fontBold,
                  color: PdfColors.black,
                ),
              ),
            ),
            pw.SizedBox(height: 30),

            // Support Categories Overview
            _buildSection(
              'Übersicht der Förderbereiche',
              [
                pw.Text(
                  'Im Folgenden werden die verschiedenen Förderbereiche aufgelistet, die für dieses Kind relevant sind:',
                  style: pw.TextStyle(font: fontRegular),
                ),
                pw.SizedBox(height: 15),
                ...supportCategories.map(
                  (category) =>
                      _buildCategoryItem(category, fontRegular, fontBold),
                ),
              ],
              fontRegular,
              fontBold,
            ),

            pw.SizedBox(height: 20),

            // Status Legend
            _buildSection(
              'Legende der Status-Symbole',
              [
                _buildLegendItem('✓', 'Erreicht', fontRegular, fontBold),
                _buildLegendItem('○', 'In Bearbeitung', fontRegular, fontBold),
                _buildLegendItem('✗', 'Nicht erreicht', fontRegular, fontBold),
                _buildLegendItem('-', 'Nicht bewertet', fontRegular, fontBold),
              ],
              fontRegular,
              fontBold,
            ),

            // Footer
            pw.Spacer(),
            _buildFooter(fontRegular),
          ],
        );
      },
    );
  }

  static pw.Page _buildSupportDetailsPage({
    required pw.MemoryImage image,
    required LearningSupportPlan plan,
    required PupilProxy pupil,
    required List<SupportCategory> supportCategories,
    required pw.Font fontRegular,
    required pw.Font fontBold,
  }) {
    return pw.Page(
      pageFormat: PdfPageFormat.a4.landscape,
      margin: const pw.EdgeInsets.all(20),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(image, 'Förderdetails', 3, 3, fontRegular, fontBold),
            pw.SizedBox(height: 20),

            // Title
            pw.Center(
              child: pw.Text(
                'FÖRDERDETAILS',
                style: pw.TextStyle(
                  fontSize: 24,
                  font: fontBold,
                  color: PdfColors.black,
                ),
              ),
            ),
            pw.SizedBox(height: 30),

            // Support Category Statuses
            if (pupil.supportCategoryStatuses?.isNotEmpty ?? false) ...[
              _buildSection(
                'Förderbereich-Status',
                [
                  ...pupil.supportCategoryStatuses!.map(
                    (status) => _buildStatusDetail(
                      status,
                      supportCategories,
                      fontRegular,
                      fontBold,
                    ),
                  ),
                ],
                fontRegular,
                fontBold,
              ),
              pw.SizedBox(height: 20),
            ],

            // Support Goals
            if (pupil.supportGoals?.isNotEmpty ?? false) ...[
              _buildSection(
                'Förderziele',
                [
                  ...pupil.supportGoals!.map(
                    (goal) => _buildGoalDetail(
                      goal,
                      supportCategories,
                      fontRegular,
                      fontBold,
                    ),
                  ),
                ],
                fontRegular,
                fontBold,
              ),
            ],

            // Footer
            pw.Spacer(),
            _buildFooter(fontRegular),
          ],
        );
      },
    );
  }

  static pw.Widget _buildHeader(
    pw.MemoryImage image,
    String title,
    int pageNumber,
    int totalPages,
    pw.Font fontRegular,
    pw.Font fontBold,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Row(
              children: [
                pw.Image(image, width: 30, height: 30),
                pw.SizedBox(width: 10),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Schuldaten Hub',
                      style: pw.TextStyle(fontSize: 16, font: fontBold),
                    ),
                    pw.Text(
                      title,
                      style: pw.TextStyle(fontSize: 10, font: fontRegular),
                    ),
                  ],
                ),
              ],
            ),
            pw.Text(
              'Seite $pageNumber von $totalPages',
              style: pw.TextStyle(fontSize: 10, font: fontRegular),
            ),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Container(
          width: double.infinity,
          height: 1,
          decoration: const pw.BoxDecoration(color: PdfColors.grey600),
        ),
      ],
    );
  }

  static pw.Widget _buildSection(
    String title,
    List<pw.Widget> children,
    pw.Font fontRegular,
    pw.Font fontBold,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 16,
            font: fontBold,
            color: PdfColors.black,
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Container(
          width: double.infinity,
          height: 1,
          decoration: const pw.BoxDecoration(color: PdfColors.grey400),
        ),
        pw.SizedBox(height: 10),
        ...children,
      ],
    );
  }

  static pw.Widget _buildCategoryItem(
    SupportCategory category,
    pw.Font fontRegular,
    pw.Font fontBold,
  ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Row(
        children: [
          pw.Container(
            width: 12,
            height: 12,
            decoration: pw.BoxDecoration(
              color: PdfColor.fromInt(
                LearningSupportHelper.getRootSupportCategoryColor(
                  category,
                ).toARGB32(),
              ),
              shape: pw.BoxShape.circle,
            ),
          ),
          pw.SizedBox(width: 10),
          pw.Expanded(
            child: pw.Text(
              category.name,
              style: pw.TextStyle(font: fontRegular),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildLegendItem(
    String symbol,
    String description,
    pw.Font fontRegular,
    pw.Font fontBold,
  ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 5),
      child: pw.Row(
        children: [
          pw.SizedBox(
            width: 20,
            child: pw.Text(
              symbol,
              style: pw.TextStyle(font: fontBold, fontSize: 14),
            ),
          ),
          pw.Text(description, style: pw.TextStyle(font: fontRegular)),
        ],
      ),
    );
  }

  static pw.Widget _buildStatusDetail(
    SupportCategoryStatus status,
    List<SupportCategory> categories,
    pw.Font fontRegular,
    pw.Font fontBold,
  ) {
    final category = categories
        .where((c) => c.categoryId == status.supportCategoryId)
        .firstOrNull;
    final categoryName = category?.name ?? 'Unbekannter Bereich';

    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 15),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            children: [
              pw.Container(
                width: 12,
                height: 12,
                decoration: pw.BoxDecoration(
                  color: category != null
                      ? PdfColor.fromInt(
                          LearningSupportHelper.getRootSupportCategoryColor(
                            category,
                          ).toARGB32(),
                        )
                      : PdfColors.grey,
                  shape: pw.BoxShape.circle,
                ),
              ),
              pw.SizedBox(width: 10),
              pw.Expanded(
                child: pw.Text(
                  categoryName,
                  style: pw.TextStyle(font: fontBold, fontSize: 14),
                ),
              ),
              pw.Text(
                _getStatusSymbol(status.score),
                style: pw.TextStyle(font: fontBold, fontSize: 16),
              ),
            ],
          ),
          if (status.comment.isNotEmpty) ...[
            pw.SizedBox(height: 5),
            pw.Padding(
              padding: const pw.EdgeInsets.only(left: 22),
              child: pw.Text(
                status.comment,
                style: pw.TextStyle(font: fontRegular, fontSize: 10),
              ),
            ),
          ],
        ],
      ),
    );
  }

  static pw.Widget _buildGoalDetail(
    SupportGoal goal,
    List<SupportCategory> categories,
    pw.Font fontRegular,
    pw.Font fontBold,
  ) {
    final category = categories
        .where((c) => c.categoryId == goal.supportCategoryId)
        .firstOrNull;
    final categoryName = category?.name ?? 'Unbekannter Bereich';

    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 15),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            children: [
              pw.Container(
                width: 12,
                height: 12,
                decoration: pw.BoxDecoration(
                  color: category != null
                      ? PdfColor.fromInt(
                          LearningSupportHelper.getRootSupportCategoryColor(
                            category,
                          ).toARGB32(),
                        )
                      : PdfColors.grey,
                  shape: pw.BoxShape.circle,
                ),
              ),
              pw.SizedBox(width: 10),
              pw.Expanded(
                child: pw.Text(
                  categoryName,
                  style: pw.TextStyle(font: fontBold, fontSize: 12),
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 5),
          pw.Padding(
            padding: const pw.EdgeInsets.only(left: 22),
            child: pw.Text(
              goal.description,
              style: pw.TextStyle(font: fontRegular, fontSize: 11),
            ),
          ),
          if (goal.strategies.isNotEmpty) ...[
            pw.SizedBox(height: 3),
            pw.Padding(
              padding: const pw.EdgeInsets.only(left: 22),
              child: pw.Text(
                'Strategien: ${goal.strategies}',
                style: pw.TextStyle(
                  font: fontRegular,
                  fontSize: 10,
                  color: PdfColors.grey700,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  static String _getStatusSymbol(int score) {
    switch (score) {
      case 1:
        return '✓'; // Achieved
      case 2:
        return '○'; // In Progress
      case 3:
        return '✗'; // Not Achieved
      default:
        return '-'; // Not Evaluated
    }
  }

  static pw.Widget _buildFooter(pw.Font fontRegular) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          'Stand 1.8.2022 Name des Kindes, Förderplan SJ',
          style: pw.TextStyle(fontSize: 8, font: fontRegular),
        ),
        pw.Text(
          'Seite 1 von 4',
          style: pw.TextStyle(fontSize: 8, font: fontRegular),
        ),
      ],
    );
  }

  // New section building methods for template layout

  static pw.Widget _buildMainInfoSection(
    LearningSupportPlan plan,
    PupilProxy pupil,
    dynamic currentSemester,
    pw.Font fontRegular,
    pw.Font fontBold,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Left Column
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Text(
                      'Name des Kindes:',
                      style: pw.TextStyle(font: fontBold),
                    ),
                    pw.SizedBox(width: 5),
                    pw.Expanded(
                      child: pw.Container(
                        height: 20,
                        decoration: const pw.BoxDecoration(
                          border: pw.Border(
                            bottom: pw.BorderSide(color: PdfColors.black),
                          ),
                        ),
                        child: pw.Text(
                          '${pupil.firstName} ${pupil.lastName}',
                          style: pw.TextStyle(font: fontRegular),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  children: [
                    pw.Text(
                      'Förderplan Nr.:',
                      style: pw.TextStyle(font: fontBold),
                    ),
                    pw.SizedBox(width: 5),
                    pw.Container(
                      width: 80,
                      height: 20,
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          bottom: pw.BorderSide(color: PdfColors.black),
                        ),
                      ),
                      child: pw.Text(
                        plan.planId,
                        style: pw.TextStyle(font: fontRegular),
                      ),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Text('vom:', style: pw.TextStyle(font: fontBold)),
                    pw.SizedBox(width: 5),
                    pw.Expanded(
                      child: pw.Container(
                        height: 20,
                        decoration: const pw.BoxDecoration(
                          border: pw.Border(
                            bottom: pw.BorderSide(color: PdfColors.black),
                          ),
                        ),
                        child: pw.Text(
                          '${plan.createdAt.day}.${plan.createdAt.month}.${plan.createdAt.year}',
                          style: pw.TextStyle(font: fontRegular),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          pw.SizedBox(width: 20),
          // Right Column
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Text('Geb.-Datum:', style: pw.TextStyle(font: fontBold)),
                    pw.SizedBox(width: 5),
                    pw.Expanded(
                      child: pw.Container(
                        height: 20,
                        decoration: const pw.BoxDecoration(
                          border: pw.Border(
                            bottom: pw.BorderSide(color: PdfColors.black),
                          ),
                        ),
                        child: pw.Text(
                          '${pupil.birthday.day}.${pupil.birthday.month}.${pupil.birthday.year}',
                          style: pw.TextStyle(font: fontRegular),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  children: [
                    pw.Text(
                      'Schuljahr 20',
                      style: pw.TextStyle(font: fontBold),
                    ),
                    pw.Container(
                      width: 30,
                      height: 20,
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          bottom: pw.BorderSide(color: PdfColors.black),
                        ),
                      ),
                      child: pw.Text(
                        currentSemester != null
                            ? '${currentSemester.schoolYear}'
                            : '',
                        style: pw.TextStyle(font: fontRegular),
                      ),
                    ),
                    pw.Text(' /', style: pw.TextStyle(font: fontBold)),
                    pw.Expanded(
                      child: pw.Container(
                        height: 20,
                        decoration: const pw.BoxDecoration(
                          border: pw.Border(
                            bottom: pw.BorderSide(color: PdfColors.black),
                          ),
                        ),
                        child: pw.Text(
                          currentSemester != null
                              ? (currentSemester.isFirst ? '1' : '2')
                              : '',
                          style: pw.TextStyle(font: fontRegular),
                        ),
                      ),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Text(
                      'Schulbesuchsjahr:',
                      style: pw.TextStyle(font: fontBold),
                    ),
                    pw.SizedBox(width: 5),
                    pw.Container(
                      width: 50,
                      height: 20,
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          bottom: pw.BorderSide(color: PdfColors.black),
                        ),
                      ),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Text('Klasse:', style: pw.TextStyle(font: fontBold)),
                    pw.SizedBox(width: 5),
                    pw.Container(
                      width: 50,
                      height: 20,
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          bottom: pw.BorderSide(color: PdfColors.black),
                        ),
                      ),
                      child: pw.Text(
                        pupil.group,
                        style: pw.TextStyle(font: fontRegular),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildForderplanTypeSection(
    LearningSupportPlan plan,
    pw.Font fontRegular,
    pw.Font fontBold,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            children: [
              pw.Text('☐', style: const pw.TextStyle(fontSize: 16)),
              pw.SizedBox(width: 5),
              pw.Text(
                'Individueller Förderplan (FE I) falls Schriftform gewünscht',
                style: pw.TextStyle(font: fontRegular),
              ),
            ],
          ),
          pw.SizedBox(height: 8),
          pw.Row(
            children: [
              pw.Text('☐', style: const pw.TextStyle(fontSize: 16)),
              pw.SizedBox(width: 5),
              pw.Text(
                'Individuell erweiterter Förderplan [FE II]',
                style: pw.TextStyle(font: fontRegular),
              ),
            ],
          ),
          pw.SizedBox(height: 4),
          pw.Padding(
            padding: const pw.EdgeInsets.only(left: 20),
            child: pw.Text(
              'z.B. LRS, Rechenschwäche, AD(H)S, Hochbegabung',
              style: pw.TextStyle(fontSize: 10, font: fontRegular),
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Row(
            children: [
              pw.Text('☐', style: const pw.TextStyle(fontSize: 16)),
              pw.SizedBox(width: 5),
              pw.Text(
                'Förderplan gemäß AO-SF § 21(7) mit sonderpädagogischer Unterstützung (FE III)',
                style: pw.TextStyle(font: fontRegular),
              ),
            ],
          ),
          pw.SizedBox(height: 8),
          pw.Row(
            children: [
              pw.SizedBox(width: 20),
              pw.Text('☐', style: const pw.TextStyle(fontSize: 16)),
              pw.SizedBox(width: 5),
              pw.Text(
                'mit Bescheid vom',
                style: pw.TextStyle(font: fontRegular),
              ),
              pw.SizedBox(width: 5),
              pw.Container(
                width: 100,
                height: 20,
                decoration: const pw.BoxDecoration(
                  border: pw.Border(
                    bottom: pw.BorderSide(color: PdfColors.black),
                  ),
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 4),
          pw.Row(
            children: [
              pw.SizedBox(width: 20),
              pw.Text('☐', style: const pw.TextStyle(fontSize: 16)),
              pw.SizedBox(width: 5),
              pw.Text('ohne Bescheid', style: pw.TextStyle(font: fontRegular)),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildContactSection(
    PupilProxy pupil,
    pw.Font fontRegular,
    pw.Font fontBold,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Left Side (Contact Info)
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Text('Tel.:', style: pw.TextStyle(font: fontBold)),
                    pw.SizedBox(width: 5),
                    pw.Expanded(
                      child: pw.Container(
                        height: 20,
                        decoration: const pw.BoxDecoration(
                          border: pw.Border(
                            bottom: pw.BorderSide(color: PdfColors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  children: [
                    pw.Text('Tel.mobil:', style: pw.TextStyle(font: fontBold)),
                    pw.SizedBox(width: 5),
                    pw.Expanded(
                      child: pw.Container(
                        height: 20,
                        decoration: const pw.BoxDecoration(
                          border: pw.Border(
                            bottom: pw.BorderSide(color: PdfColors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          pw.SizedBox(width: 20),
          // Right Side (Codes and Additional Contacts)
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  children: [
                    _buildCodeBox('LE', fontBold),
                    _buildCodeBox('ESE', fontBold),
                    _buildCodeBox('SQ', fontBold),
                    _buildCodeBox('KME', fontBold),
                    _buildCodeBox('GE', fontBold),
                    _buildCodeBox('SE', fontBold),
                    _buildCodeBox('HK', fontBold),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  children: [
                    pw.Text(
                      'weitere Kontaktdaten:',
                      style: pw.TextStyle(font: fontBold),
                    ),
                    pw.SizedBox(width: 5),
                    pw.Expanded(
                      child: pw.Container(
                        height: 20,
                        decoration: const pw.BoxDecoration(
                          border: pw.Border(
                            bottom: pw.BorderSide(color: PdfColors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildCodeBox(String text, pw.Font font) {
    return pw.Container(
      width: 25,
      height: 20,
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black),
      ),
      child: pw.Center(
        child: pw.Text(text, style: pw.TextStyle(font: font, fontSize: 10)),
      ),
    );
  }

  static pw.Widget _buildPersonnelSection(
    LearningSupportPlan plan,
    PupilProxy pupil,
    pw.Font fontRegular,
    pw.Font fontBold,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black),
      ),
      child: pw.Row(
        children: [
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Sozialpäd. Fachkraft:',
                  style: pw.TextStyle(font: fontBold),
                ),
                pw.SizedBox(height: 5),
                pw.Container(
                  height: 20,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(color: PdfColors.black),
                    ),
                  ),
                  child: pw.Text(
                    plan.socialPedagogue ?? '',
                    style: pw.TextStyle(font: fontRegular),
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(width: 20),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Klassenlehrer*in:',
                  style: pw.TextStyle(font: fontBold),
                ),
                pw.SizedBox(height: 5),
                pw.Container(
                  height: 20,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(color: PdfColors.black),
                    ),
                  ),
                  child: pw.Text(
                    pupil.groupTutor ?? '',
                    style: pw.TextStyle(font: fontRegular),
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(width: 20),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Sol.:', style: pw.TextStyle(font: fontBold)),
                pw.SizedBox(height: 5),
                pw.Container(
                  height: 20,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(color: PdfColors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildWeitereBeteiligteSection(
    LearningSupportPlan plan,
    pw.Font fontRegular,
    pw.Font fontBold,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Center(
            child: pw.Text(
              'Weitere beteiligte Personen und Organisationen',
              style: pw.TextStyle(font: fontBold),
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Container(
            width: double.infinity,
            height: 80,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.black),
            ),
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(
                plan.proffesionalsInvolved ?? '',
                style: pw.TextStyle(font: fontRegular),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildStaerkenSection(
    LearningSupportPlan plan,
    pw.Font fontRegular,
    pw.Font fontBold,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            children: [
              pw.Text('😊', style: const pw.TextStyle(fontSize: 16)),
              pw.SizedBox(width: 5),
              pw.Text(
                'Stärken',
                style: pw.TextStyle(font: fontBold, fontSize: 16),
              ),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Container(
            width: double.infinity,
            height: 80,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.black),
            ),
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(
                plan.strengthsDescription ?? '',
                style: pw.TextStyle(font: fontRegular),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildProblematikSection(
    LearningSupportPlan plan,
    pw.Font fontRegular,
    pw.Font fontBold,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Problematik',
            style: pw.TextStyle(font: fontBold, fontSize: 16),
          ),
          pw.Text(
            '[2-3 Zielschwerpunkte]',
            style: pw.TextStyle(font: fontRegular, fontSize: 12),
          ),
          pw.SizedBox(height: 10),
          pw.Container(
            width: double.infinity,
            height: 80,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.black),
            ),
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(
                plan.problemsDescription ?? '',
                style: pw.TextStyle(font: fontRegular),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildSprachbiografieSection(
    PupilProxy pupil,
    pw.Font fontRegular,
    pw.Font fontBold,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Sprachbiografie', style: pw.TextStyle(font: fontBold)),
          pw.SizedBox(width: 20),
          pw.Row(
            children: [
              pw.Text('☐', style: const pw.TextStyle(fontSize: 16)),
              pw.SizedBox(width: 5),
              pw.Text(
                '1. Lernjahr Deutsch',
                style: pw.TextStyle(font: fontRegular),
              ),
              pw.SizedBox(width: 10),
              pw.Text('☐', style: const pw.TextStyle(fontSize: 16)),
              pw.SizedBox(width: 5),
              pw.Text(
                '2. Lernjahr Deutsch',
                style: pw.TextStyle(font: fontRegular),
              ),
              pw.SizedBox(width: 10),
              pw.Text('☐', style: const pw.TextStyle(fontSize: 16)),
              pw.SizedBox(width: 5),
              pw.Text(
                '3. Lernjahr Deutsch',
                style: pw.TextStyle(font: fontRegular),
              ),
              pw.SizedBox(width: 10),
              pw.Text('☐', style: const pw.TextStyle(fontSize: 16)),
              pw.SizedBox(width: 5),
              pw.Text(
                '>3. Lernjahr Deutsch',
                style: pw.TextStyle(font: fontRegular),
              ),
            ],
          ),
          pw.Spacer(),
          pw.Row(
            children: [
              pw.Text('Herkunftssprache:', style: pw.TextStyle(font: fontBold)),
              pw.SizedBox(width: 5),
              pw.Container(
                width: 100,
                height: 20,
                decoration: const pw.BoxDecoration(
                  border: pw.Border(
                    bottom: pw.BorderSide(color: PdfColors.black),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LearningSupportPlanPdfViewPage extends StatefulWidget {
  final File pdfFile;
  const LearningSupportPlanPdfViewPage({required this.pdfFile, super.key});

  @override
  State<LearningSupportPlanPdfViewPage> createState() =>
      _LearningSupportPlanPdfViewPageState();
}

class _LearningSupportPlanPdfViewPageState
    extends State<LearningSupportPlanPdfViewPage> {
  @override
  void dispose() {
    // Ensure the file is deleted when the widget is disposed
    // This handles all cases where the page is popped/closed
    if (widget.pdfFile.existsSync()) {
      widget.pdfFile.delete();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(
        iconData: Icons.picture_as_pdf,
        title: 'Förderplan PDF',
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
          // File will be deleted in dispose(), no need to delete here
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        },
        build: (format) => widget.pdfFile.readAsBytes(),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // File will be deleted in dispose(), no need to delete here
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}

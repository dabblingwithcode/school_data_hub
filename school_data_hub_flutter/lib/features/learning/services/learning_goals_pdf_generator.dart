import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/pupil_proxy_competence_ext.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/enums.dart';
import 'package:school_data_hub_flutter/features/school/domain/school_data_manager.dart';

final _log = Logger('LearningGoalsPdfGenerator');

class LearningGoalsPdfGenerator {
  /// Generates a PDF for the learning goals list of filtered pupils
  static Future<File> generateLearningGoalsPdf({
    required List<PupilProxy> pupils,
  }) async {
    // Use school logo if available, otherwise fall back to default asset
    final logoData = di<SchoolDataMainManager>().logoImage.value;
    final Uint8List imageBytes;
    if (logoData != null) {
      imageBytes = logoData.buffer.asUint8List();
    } else {
      final data = await rootBundle.load('assets/foreground_windows.png');
      imageBytes = data.buffer.asUint8List();
    }
    final image = pw.MemoryImage(imageBytes);

    // Load Grundschrift font from assets (per pdf package: pw.Font.ttf(ByteData))
    final fontData = await rootBundle.load('assets/fonts/grundschrift.ttf');
    final fontGrundschrift = pw.Font.ttf(fontData);
    final fontRegular = fontGrundschrift;
    final fontBold = fontGrundschrift;

    final pdf = pw.Document();

    di<NotificationManager>().setHeavyLoadingValue(true);

    // Sort pupils by name
    final sortedPupils = List<PupilProxy>.from(pupils);
    sortedPupils.sort((a, b) {
      final lastNameCompare = a.lastName.compareTo(b.lastName);
      if (lastNameCompare != 0) return lastNameCompare;
      return a.firstName.compareTo(b.firstName);
    });

    // Filter pupils who have competence goals
    final pupilsWithGoals = sortedPupils
        .where((p) => (p.competenceGoals).isNotEmpty)
        .toList();

    if (pupilsWithGoals.isEmpty) {
      // If no pupils with goals, create one page with message
      pdf.addPage(
        _buildEmptyPage(
          image: image,
          fontRegular: fontRegular,
          fontBold: fontBold,
          totalPupils: sortedPupils.length,
        ),
      );
    } else {
      // Build continuous pages with all pupils' goals
      pdf.addPage(
        pw.MultiPage(
          margin: const pw.EdgeInsets.all(20),
          header: (context) => pw.Column(
            children: [
              _buildHeader(
                image,
                context.pageNumber,
                context.pagesCount,
                fontRegular,
                fontBold,
              ),
              pw.SizedBox(height: 15),
            ],
          ),
          footer: (context) => _buildFooter(fontRegular),
          build: (context) => [
            _buildContinuousGoalsList(
              pupils: pupilsWithGoals,
              fontRegular: fontRegular,
              fontBold: fontBold,
            ),
          ],
        ),
      );
    }

    di<NotificationManager>().setHeavyLoadingValue(false);

    // Get the proper directory for saving files
    final directory = await getApplicationDocumentsDirectory();
    final fileName =
        "Lernziele_${DateTime.now().formatDateForUser().replaceAll(' ', '_')}.pdf";
    final file = File('${directory.path}/$fileName');

    await file.writeAsBytes(await pdf.save());
    _log.info('PDF generated: ${file.path}');
    return file;
  }

  /// Builds an empty page when no pupils have goals
  static pw.Page _buildEmptyPage({
    required pw.MemoryImage image,
    required pw.Font fontRegular,
    required pw.Font fontBold,
    required int totalPupils,
  }) {
    return pw.Page(
      margin: const pw.EdgeInsets.all(20),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildHeader(image, 1, 1, fontRegular, fontBold),
            pw.SizedBox(height: 15),
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(20),
              child: pw.Center(
                child: pw.Text(
                  'Keine Lernziele für die $totalPupils ausgewählten Schüler:innen vorhanden',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontStyle: pw.FontStyle.italic,
                    font: fontRegular,
                  ),
                ),
              ),
            ),
            pw.Spacer(),
            _buildFooter(fontRegular),
          ],
        );
      },
    );
  }

  /// Builds a summary page with overview statistics
  // static pw.Page _buildSummaryPage({
  //   required pw.MemoryImage image,
  //   required List<PupilProxy> pupils,
  //   required pw.Font fontRegular,
  //   required pw.Font fontBold,
  // }) {
  //   return pw.Page(
  //     margin: const pw.EdgeInsets.all(20),
  //     build: (pw.Context context) {
  //       return pw.Column(
  //         crossAxisAlignment: pw.CrossAxisAlignment.start,
  //         children: [
  //           // Header
  //           _buildHeader(image, 1, 1, fontRegular, fontBold),
  //           pw.SizedBox(height: 15),

  //           // Overall Statistics
  //           _buildOverallStatistics(
  //             pupils: pupils,
  //             fontRegular: fontRegular,
  //             fontBold: fontBold,
  //           ),
  //           pw.SizedBox(height: 20),

  //           // Summary table
  //           pw.Expanded(
  //             child: _buildSummaryTable(pupils, fontRegular, fontBold),
  //           ),

  //           // Footer
  //           _buildFooter(fontRegular),
  //         ],
  //       );
  //     },
  //   );
  // }

  // /// Builds a detailed page for a specific pupil showing all their learning goals
  // static pw.Page _buildPupilDetailPage({
  //   required pw.MemoryImage image,
  //   required PupilProxy pupil,
  //   required List<CompetenceGoal> competenceGoals,
  //   required int pageNumber,
  //   required int totalPages,
  //   required pw.Font fontRegular,
  //   required pw.Font fontBold,
  // }) {
  //   return pw.Page(
  //     margin: const pw.EdgeInsets.all(20),
  //     build: (pw.Context context) {
  //       return pw.Column(
  //         crossAxisAlignment: pw.CrossAxisAlignment.start,
  //         children: [
  //           // Header with pupil info
  //           // _buildPupilDetailHeader(
  //           //   image,
  //           //   pupil,
  //           //   pageNumber,
  //           //   totalPages,
  //           //   fontRegular,
  //           //   fontBold,
  //           // ),
  //           // pw.SizedBox(height: 15),

  //           // Pupil statistics
  //           // _buildPupilStatistics(pupil, fontRegular, fontBold),
  //           // pw.SizedBox(height: 12),

  //           // Pupil info row (name, group, grade, date) at start of learning goals list
  //           _buildPupilInfoRow(pupil, fontRegular, fontBold),
  //           pw.SizedBox(height: 4),

  //           // Detailed goals list
  //           pw.Expanded(
  //             child: _buildDetailedGoalsTable(
  //               competenceGoals,
  //               fontRegular,
  //               fontBold,
  //             ),
  //           ),

  //           // Footer
  //           _buildFooter(fontRegular),
  //         ],
  //       );
  //     },
  //   );
  // }

  /// Builds the page header
  static pw.Widget _buildHeader(
    pw.MemoryImage image,
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
                      di<SchoolDataMainManager>()
                              .schoolData
                              .value
                              ?.officialName ??
                          'Schuldaten Hub',
                      style: pw.TextStyle(fontSize: 16, font: fontBold),
                    ),
                    pw.Text(
                      'Lernziele',
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
        pw.SizedBox(height: 10),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Lernziele Übersicht',
                    style: pw.TextStyle(fontSize: 20, font: fontBold),
                  ),
                ],
              ),
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(
                  'Erstellt am: ${DateTime.now().formatDateForUser()}',
                  style: pw.TextStyle(fontSize: 10, font: fontRegular),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// Builds overall statistics for all pupils
  // static pw.Widget _buildOverallStatistics({
  //   required List<PupilProxy> pupils,
  //   required pw.Font fontRegular,
  //   required pw.Font fontBold,
  // }) {
  //   // Calculate totals
  //   int totalGoals = 0;
  //   int achievedGoals = 0;
  //   Map<int, int> goalsBySubject = {};

  //   for (var pupil in pupils) {
  //     final goals = pupil.competenceGoals ?? [];
  //     totalGoals += goals.length;

  //     for (var goal in goals) {
  //       // Count achieved goals (score > 0)
  //       if (goal.score != null && goal.score! > 0) {
  //         achievedGoals++;
  //       }

  //       // Count by subject
  //       final rootCompetence = di<CompetenceManager>().findRootCompetenceById(
  //         goal.competenceId,
  //       );
  //       final rootId = rootCompetence.publicId;
  //       goalsBySubject[rootId] = (goalsBySubject[rootId] ?? 0) + 1;
  //     }
  //   }

  //   return pw.Container(
  //     padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
  //     decoration: pw.BoxDecoration(
  //       border: pw.Border.all(color: PdfColors.grey400),
  //       borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
  //       color: PdfColors.grey100,
  //     ),
  //     child: pw.Column(
  //       crossAxisAlignment: pw.CrossAxisAlignment.start,
  //       children: [
  //         pw.Text(
  //           'Gesamtstatistik:',
  //           style: pw.TextStyle(fontSize: 14, font: fontBold),
  //         ),
  //         pw.SizedBox(height: 8),
  //         pw.Row(
  //           mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
  //           children: [
  //             _buildStatItem(
  //               'Schüler:innen',
  //               pupils.length,
  //               fontRegular,
  //               fontBold,
  //             ),
  //             _buildStatItem('Lernziele', totalGoals, fontRegular, fontBold),
  //             _buildStatItem('Erreicht', achievedGoals, fontRegular, fontBold),
  //             _buildStatItem(
  //               'Offen',
  //               totalGoals - achievedGoals,
  //               fontRegular,
  //               fontBold,
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  /// Builds summary table with all pupils
  // static pw.Widget _buildSummaryTable(
  //   List<PupilProxy> pupils,
  //   pw.Font fontRegular,
  //   pw.Font fontBold,
  // ) {
  //   if (pupils.isEmpty) {
  //     return pw.Container(
  //       width: double.infinity,
  //       padding: const pw.EdgeInsets.all(20),
  //       child: pw.Center(
  //         child: pw.Text(
  //           'Keine Schüler:innen mit Lernzielen',
  //           style: pw.TextStyle(
  //             fontSize: 14,
  //             fontStyle: pw.FontStyle.italic,
  //             font: fontRegular,
  //           ),
  //         ),
  //       ),
  //     );
  //   }

  //   return pw.Table(
  //     border: pw.TableBorder.all(color: PdfColors.grey400),
  //     columnWidths: const {
  //       0: pw.FixedColumnWidth(30), // Nr.
  //       1: pw.FlexColumnWidth(3), // Name
  //       2: pw.FixedColumnWidth(50), // Gesamt
  //       3: pw.FixedColumnWidth(50), // Erreicht
  //       4: pw.FixedColumnWidth(50), // Offen
  //       5: pw.FlexColumnWidth(2), // Fächer
  //     },
  //     children: [
  //       // Header row
  //       pw.TableRow(
  //         decoration: const pw.BoxDecoration(color: PdfColors.grey200),
  //         children: [
  //           _buildTableCell('Nr.', fontRegular, fontBold, isHeader: true),
  //           _buildTableCell('Name', fontRegular, fontBold, isHeader: true),
  //           _buildTableCell('Gesamt', fontRegular, fontBold, isHeader: true),
  //           _buildTableCell('Erreicht', fontRegular, fontBold, isHeader: true),
  //           _buildTableCell('Offen', fontRegular, fontBold, isHeader: true),
  //           _buildTableCell('Fächer', fontRegular, fontBold, isHeader: true),
  //         ],
  //       ),
  //       // Data rows
  //       ...pupils.asMap().entries.map((entry) {
  //         final index = entry.key + 1;
  //         final pupil = entry.value;
  //         final goals = pupil.competenceGoals ?? [];
  //         final achieved = goals.where((g) => g.score != null && g.score! > 0);
  //         final subjects = _getSubjectsSummary(goals);

  //         return pw.TableRow(
  //           children: [
  //             _buildTableCell(index.toString(), fontRegular, fontBold),
  //             _buildTableCell(
  //               '${pupil.firstName} ${pupil.lastName}',
  //               fontRegular,
  //               fontBold,
  //             ),
  //             _buildTableCell(goals.length.toString(), fontRegular, fontBold),
  //             _buildTableCell(
  //               achieved.length.toString(),
  //               fontRegular,
  //               fontBold,
  //             ),
  //             _buildTableCell(
  //               (goals.length - achieved.length).toString(),
  //               fontRegular,
  //               fontBold,
  //               isBold: goals.length - achieved.length > 0,
  //             ),
  //             _buildTableCell(subjects, fontRegular, fontBold),
  //           ],
  //         );
  //       }),
  //     ],
  //   );
  // }

  /// Gets a summary of subjects for a pupil's goals
  // static String _getSubjectsSummary(List<CompetenceGoal> goals) {
  //   Map<String, int> subjectCounts = {};

  //   for (var goal in goals) {
  //     final rootCompetence = di<CompetenceManager>().findRootCompetenceById(
  //       goal.competenceId,
  //     );
  //     final shortName = _getShortName(rootCompetence.publicId);
  //     subjectCounts[shortName] = (subjectCounts[shortName] ?? 0) + 1;
  //   }

  //   return subjectCounts.entries.map((e) => '${e.key}:${e.value}').join(', ');
  // }

  /// Gets short name for a root competence
  static String _getShortName(int rootCompetenceId) {
    final competence = di<CompetenceManager>().findCompetenceById(
      rootCompetenceId,
    );
    final type = RootCompetenceType.stringToValue[competence.name];
    switch (type) {
      case RootCompetenceType.math:
        return 'MA';
      case RootCompetenceType.german:
        return 'DE';
      case RootCompetenceType.science:
        return 'SU';
      case RootCompetenceType.english:
        return 'EN';
      case RootCompetenceType.art:
        return 'KU';
      case RootCompetenceType.music:
        return 'MU';
      case RootCompetenceType.sport:
        return 'SP';
      case RootCompetenceType.religion:
        return 'RE';
      case RootCompetenceType.socialAndWorkSkills:
        return 'AV';
      case RootCompetenceType.motherLanguage:
        return 'SV';
      case RootCompetenceType.daz:
        return 'DaZ';
      default:
        return competence.name.length > 3
            ? competence.name.substring(0, 3).toUpperCase()
            : competence.name.toUpperCase();
    }
  }

  /// Builds header for pupil detail page
  // static pw.Widget _buildPupilDetailHeader(
  //   pw.MemoryImage image,
  //   PupilProxy pupil,
  //   int pageNumber,
  //   int totalPages,
  //   pw.Font fontRegular,
  //   pw.Font fontBold,
  // ) {
  //   return pw.Column(
  //     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //     children: [
  //       pw.Row(
  //         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //         children: [
  //           pw.Row(
  //             children: [
  //               pw.Image(image, width: 30, height: 30),
  //               pw.SizedBox(width: 10),
  //               pw.Column(
  //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                 children: [
  //                   pw.Text(
  //                     di<SchoolDataMainManager>()
  //                             .schoolData
  //                             .value
  //                             ?.officialName ??
  //                         'Schuldaten Hub',
  //                     style: pw.TextStyle(fontSize: 16, font: fontBold),
  //                   ),
  //                   pw.Text(
  //                     'Lernziele Detail',
  //                     style: pw.TextStyle(fontSize: 10, font: fontRegular),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //           pw.Text(
  //             'Seite $pageNumber von $totalPages',
  //             style: pw.TextStyle(fontSize: 10, font: fontRegular),
  //           ),
  //         ],
  //       ),
  //       pw.SizedBox(height: 10),
  //       pw.Container(
  //         width: double.infinity,
  //         height: 1,
  //         decoration: const pw.BoxDecoration(color: PdfColors.grey600),
  //       ),
  //       pw.SizedBox(height: 10),
  //       pw.Row(
  //         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //         children: [
  //           pw.Expanded(
  //             child: pw.Column(
  //               crossAxisAlignment: pw.CrossAxisAlignment.start,
  //               children: [
  //                 pw.Text(
  //                   '${pupil.firstName} ${pupil.lastName}',
  //                   style: pw.TextStyle(fontSize: 20, font: fontBold),
  //                 ),
  //                 pw.SizedBox(height: 3),
  //                 pw.Text(
  //                   'Schüler-ID: ${pupil.pupilId}',
  //                   style: pw.TextStyle(fontSize: 10, font: fontRegular),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           pw.Text(
  //             'Erstellt am: ${DateTime.now().formatDateForUser()}',
  //             style: pw.TextStyle(fontSize: 10, font: fontRegular),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  // /// Builds statistics for a specific pupil
  // static pw.Widget _buildPupilStatistics(
  //   PupilProxy pupil,
  //   pw.Font fontRegular,
  //   pw.Font fontBold,
  // ) {
  //   final goals = pupil.competenceGoals ?? [];
  //   final achieved = goals.where((g) => g.score != null && g.score! > 0).length;

  //   // Group by subject
  //   Map<String, int> subjectCounts = {};
  //   for (var goal in goals) {
  //     final rootCompetence = di<CompetenceManager>().findRootCompetenceById(
  //       goal.competenceId,
  //     );
  //     final shortName = _getShortName(rootCompetence.publicId);
  //     subjectCounts[shortName] = (subjectCounts[shortName] ?? 0) + 1;
  //   }

  //   return pw.Container(
  //     padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  //     decoration: pw.BoxDecoration(
  //       border: pw.Border.all(color: PdfColors.grey400),
  //       borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
  //       color: PdfColors.grey100,
  //     ),
  //     child: pw.Row(
  //       mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
  //       children: [
  //         _buildStatItem('Gesamt', goals.length, fontRegular, fontBold),
  //         _buildStatItem('Erreicht', achieved, fontRegular, fontBold),
  //         _buildStatItem(
  //           'Offen',
  //           goals.length - achieved,
  //           fontRegular,
  //           fontBold,
  //         ),
  //         pw.Column(
  //           children: [
  //             pw.Text(
  //               subjectCounts.entries
  //                   .map((e) => '${e.key}:${e.value}')
  //                   .join(' '),
  //               style: pw.TextStyle(fontSize: 10, font: fontBold),
  //             ),
  //             pw.Text(
  //               'nach Fach',
  //               style: pw.TextStyle(fontSize: 9, font: fontRegular),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  /// Builds a single row with pupil name (bold), group, grade and date at the
  /// beginning of the learning goals list. Uses same font size as table rows.
  static pw.Widget _buildPupilInfoRow(
    PupilProxy pupil,
    pw.Font fontRegular,
    pw.Font fontBold,
  ) {
    const double fontSize = 9;
    return pw.Column(
      children: [
        pw.Row(
          children: [
            pw.Text(
              '${pupil.firstName} ${pupil.lastName}',
              style: pw.TextStyle(fontSize: fontSize, font: fontBold),
            ),
            pw.SizedBox(width: 12),
            pw.Text(
              pupil.group,
              style: pw.TextStyle(fontSize: fontSize, font: fontRegular),
            ),
            pw.SizedBox(width: 12),
            pw.Text(
              pupil.schoolGrade.name,
              style: pw.TextStyle(fontSize: fontSize, font: fontRegular),
            ),
            pw.Spacer(),
            pw.Text(
              DateTime.now().formatDateForUser(),
              style: pw.TextStyle(fontSize: fontSize, font: fontRegular),
            ),
          ],
        ),

        pw.Row(
          children: [
            pw.Text(
              'MEINE LERNZIELE',
              style: pw.TextStyle(fontSize: 12, font: fontBold),
            ),
          ],
        ),
      ],
    );
  }

  /// Builds a continuous list with all pupils' goals
  static pw.Widget _buildContinuousGoalsList({
    required List<PupilProxy> pupils,
    required pw.Font fontRegular,
    required pw.Font fontBold,
  }) {
    final List<pw.Widget> widgets = [];

    for (var pupil in pupils) {
      final competenceGoals = pupil.competenceGoals;
      if (competenceGoals.isEmpty) continue;

      // Sort goals by competence
      final sortedGoals = List<CompetenceGoal>.from(competenceGoals);
      sortedGoals.sort((a, b) {
        final rootA = di<CompetenceManager>().findRootCompetenceById(
          a.competenceId,
        );
        final rootB = di<CompetenceManager>().findRootCompetenceById(
          b.competenceId,
        );
        return rootA.name.compareTo(rootB.name);
      });

      // Add pupil info row
      widgets.add(_buildPupilInfoRow(pupil, fontRegular, fontBold));
      widgets.add(pw.SizedBox(height: 4));

      // Add goals table for this pupil
      widgets.add(_buildDetailedGoalsTable(sortedGoals, fontRegular, fontBold));

      // Add spacing between pupils
      widgets.add(pw.SizedBox(height: 12));
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: widgets,
    );
  }

  /// Builds detailed goals table for a pupil
  static pw.Widget _buildDetailedGoalsTable(
    List<CompetenceGoal> competenceGoals,
    pw.Font fontRegular,
    pw.Font fontBold,
  ) {
    if (competenceGoals.isEmpty) {
      return pw.Container(
        width: double.infinity,
        padding: const pw.EdgeInsets.all(20),
        child: pw.Center(
          child: pw.Text(
            'Keine Lernziele vorhanden',
            style: pw.TextStyle(
              fontSize: 14,
              fontStyle: pw.FontStyle.italic,
              font: fontRegular,
            ),
          ),
        ),
      );
    }

    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey400),
      columnWidths: const {
        0: pw.FixedColumnWidth(45), // Fach
        1: pw.FlexColumnWidth(4), // Beschreibung
        2: pw.FlexColumnWidth(2), // Strategien
      },
      children: [
        // Header row

        // Data rows
        ...competenceGoals.asMap().entries.map((entry) {
          final goal = entry.value;
          final rootCompetence = di<CompetenceManager>().findRootCompetenceById(
            goal.competenceId,
          );
          final shortName = _getShortName(rootCompetence.publicId);
          final strategies = goal.strategies?.join(', ') ?? '';

          return pw.TableRow(
            children: [
              _buildTableCell(shortName, fontRegular, fontBold),
              _buildTableCell(goal.description, fontRegular, fontBold),
              _buildTableCell(strategies, fontRegular, fontBold),
            ],
          );
        }),
      ],
    );
  }

  /// Builds a stat item widget
  // static pw.Widget _buildStatItem(
  //   String label,
  //   int value,
  //   pw.Font fontRegular,
  //   pw.Font fontBold,
  // ) {
  //   return pw.Column(
  //     children: [
  //       pw.Text(
  //         value.toString(),
  //         style: pw.TextStyle(fontSize: 14, font: fontBold),
  //       ),
  //       pw.Text(label, style: pw.TextStyle(fontSize: 9, font: fontRegular)),
  //     ],
  //   );
  // }

  /// Builds a table cell widget
  static pw.Widget _buildTableCell(
    String text,
    pw.Font fontRegular,
    pw.Font fontBold, {
    bool isHeader = false,
    bool isBold = false,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(4),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: isHeader ? 10 : 9,
          font: isHeader || isBold ? fontBold : fontRegular,
        ),
        textAlign: isHeader ? pw.TextAlign.center : pw.TextAlign.left,
        softWrap: true,
      ),
    );
  }

  static pw.Widget _buildFooter(pw.Font fontRegular) {
    return pw.Column(
      children: [
        pw.Container(
          width: double.infinity,
          height: 1,
          decoration: const pw.BoxDecoration(color: PdfColors.grey600),
        ),
        pw.SizedBox(height: 5),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'Schuldaten Hub - Lernziele',
              style: pw.TextStyle(fontSize: 8, font: fontRegular),
            ),
            pw.Text(
              'Erstellt am: ${DateTime.now().formatDateForUser()}',
              style: pw.TextStyle(fontSize: 8, font: fontRegular),
            ),
          ],
        ),
      ],
    );
  }
}

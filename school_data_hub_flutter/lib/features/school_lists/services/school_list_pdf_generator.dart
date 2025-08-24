import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_helper_functions.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('SchoolListPdfGenerator');
final _schoolListManager = di<SchoolListManager>();

class SchoolListPdfGenerator {
  static Future<File> generateSchoolListPdf({
    required SchoolList schoolList,
    required List<PupilProxy> pupils,
  }) async {
    final data = await rootBundle.load('assets/foreground_windows.png');
    final imageBytes = data.buffer.asUint8List();
    final image = pw.MemoryImage(imageBytes);

    // Load Unicode-supporting fonts
    final fontRegular = await PdfGoogleFonts.robotoRegular();
    final fontBold = await PdfGoogleFonts.robotoBold();

    final pdf = pw.Document();

    // Get statistics
    final Map<String, int> stats =
        SchoolListHelper.schoolListStatsForGivenPupils(schoolList, pupils);

    // Get pupil entries with details
    final List<_PupilEntryData> pupilEntries = [];
    final pupilEntriesProxy = _schoolListManager
        .getPupilEntriesProxyFromSchoolList(schoolList.id!);

    for (PupilProxy pupil in pupils) {
      for (var pupilEntryProxy in pupilEntriesProxy.pupilEntries.values) {
        if (pupilEntryProxy.pupilEntry.pupilId == pupil.pupilId) {
          pupilEntries.add(
            _PupilEntryData(pupil: pupil, entry: pupilEntryProxy.pupilEntry),
          );
          break;
        }
      }
    }

    // Sort pupils by group, then by first name
    pupilEntries.sort((a, b) {
      final groupComparison = a.pupil.group.compareTo(b.pupil.group);
      if (groupComparison != 0) return groupComparison;
      return a.pupil.firstName.compareTo(b.pupil.firstName);
    });

    // Configuration for pagination
    const int maxPupilsFirstPage = 24;
    const int maxPupilsPerPage = 26;
    // Calculate total pages
    int totalPages;
    if (pupilEntries.length <= maxPupilsFirstPage) {
      totalPages = 1;
    } else {
      final remainingPupils = pupilEntries.length - maxPupilsFirstPage;
      totalPages = 1 + (remainingPupils / maxPupilsPerPage).ceil();
    }
    di<NotificationService>().setHeavyLoadingValue(true);
    if (totalPages == 0) {
      // If no pupils, still create one page
      pdf.addPage(
        _buildPage(
          image: image,
          schoolList: schoolList,
          stats: stats,
          pupils: [],
          pageNumber: 1,
          totalPages: 1,
          totalPupils: 0,
          startIndex: 0,
          fontRegular: fontRegular,
          fontBold: fontBold,
        ),
      );
    } else {
      // Create pages with pupils
      int currentIndex = 0;

      for (int page = 1; page <= totalPages; page++) {
        final int pupilsOnThisPage =
            page == 1 ? maxPupilsFirstPage : maxPupilsPerPage;
        final endIndex = (currentIndex + pupilsOnThisPage).clamp(
          0,
          pupilEntries.length,
        );

        // Skip empty pages
        if (currentIndex >= pupilEntries.length) {
          break;
        }

        final pupilsOnPage = pupilEntries.sublist(currentIndex, endIndex);

        pdf.addPage(
          _buildPage(
            image: image,
            schoolList: schoolList,
            stats: stats,
            pupils: pupilsOnPage,
            pageNumber: page,
            totalPages: totalPages,
            totalPupils: pupilEntries.length,
            startIndex: currentIndex,
            fontRegular: fontRegular,
            fontBold: fontBold,
          ),
        );

        currentIndex = endIndex;
      }
    }
    di<NotificationService>().setHeavyLoadingValue(false);
    // Get the proper directory for saving files
    final directory = await getApplicationDocumentsDirectory();
    final fileName =
        "Schulliste_${schoolList.name}_${DateTime.now().formatForUser()}.pdf";
    final file = File('${directory.path}/$fileName');

    await file.writeAsBytes(await pdf.save());
    _log.info('PDF generated: ${file.path}');
    return file;
  }

  static pw.Page _buildPage({
    required pw.MemoryImage image,
    required SchoolList schoolList,
    required Map<String, int> stats,
    required List<_PupilEntryData> pupils,
    required int pageNumber,
    required int totalPages,
    required int totalPupils,
    required int startIndex,
    required pw.Font fontRegular,
    required pw.Font fontBold,
  }) {
    try {
      return pw.Page(
        margin: const pw.EdgeInsets.all(20),
        build: (pw.Context context) {
          try {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header
                _buildHeader(
                  image,
                  schoolList,
                  pageNumber,
                  totalPages,
                  fontRegular,
                  fontBold,
                ),
                pw.SizedBox(height: 15),

                // Statistics (only on first page)
                if (pageNumber == 1) ...[
                  _buildStatistics(stats, totalPupils, fontRegular, fontBold),
                  pw.SizedBox(height: 12),
                ],

                // Pupils table
                _buildPupilsTable(pupils, startIndex, fontRegular, fontBold),

                // Footer
                pw.Spacer(),
                _buildFooter(schoolList, fontRegular),
              ],
            );
          } catch (e) {
            // Return a simple error page
            return pw.Column(
              children: [
                pw.Text('Error building page $pageNumber: $e'),
                pw.Spacer(),
                pw.Text('Page $pageNumber of $totalPages'),
              ],
            );
          }
        },
      );
    } catch (e) {
      // Return a minimal page
      return pw.Page(
        build:
            (context) =>
                pw.Center(child: pw.Text('Error on page $pageNumber: $e')),
      );
    }
  }

  static pw.Widget _buildHeader(
    pw.MemoryImage image,
    SchoolList schoolList,
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
                      'Schulliste',
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
                    schoolList.name,
                    style: pw.TextStyle(fontSize: 20, font: fontBold),
                  ),
                  pw.SizedBox(height: 5),
                  pw.Text(
                    schoolList.description,
                    style: pw.TextStyle(fontSize: 12, font: fontRegular),
                  ),
                ],
              ),
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Row(
                  children: [
                    pw.Text(
                      'Erstellt von: ',
                      style: pw.TextStyle(fontSize: 10, font: fontRegular),
                    ),
                    pw.Text(
                      schoolList.createdBy,
                      style: pw.TextStyle(fontSize: 10, font: fontBold),
                    ),
                  ],
                ),
                pw.SizedBox(height: 2),
                pw.Row(
                  children: [
                    pw.Text(
                      'Sichtbarkeit: ',
                      style: pw.TextStyle(fontSize: 10, font: fontRegular),
                    ),
                    pw.Text(
                      schoolList.public ? 'Öffentlich' : 'Privat',
                      style: pw.TextStyle(fontSize: 10, font: fontBold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildStatistics(
    Map<String, int> stats,
    int totalPupils,
    pw.Font fontRegular,
    pw.Font fontBold,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
      ),
      child: pw.Row(
        children: [
          pw.Text(
            'Statistik:',
            style: pw.TextStyle(fontSize: 12, font: fontBold),
          ),
          pw.SizedBox(width: 15),
          pw.Expanded(
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Gesamt', totalPupils, fontRegular, fontBold),
                _buildStatItem('Ja', stats['yes'] ?? 0, fontRegular, fontBold),
                _buildStatItem('Nein', stats['no'] ?? 0, fontRegular, fontBold),
                _buildStatItem(
                  'Offen',
                  stats['null'] ?? 0,
                  fontRegular,
                  fontBold,
                ),
                _buildStatItem(
                  'Kommentare',
                  stats['comment'] ?? 0,
                  fontRegular,
                  fontBold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildStatItem(
    String label,
    int value,
    pw.Font fontRegular,
    pw.Font fontBold,
  ) {
    return pw.Column(
      children: [
        pw.Text(
          value.toString(),
          style: pw.TextStyle(fontSize: 14, font: fontBold),
        ),
        pw.Text(label, style: pw.TextStyle(fontSize: 9, font: fontRegular)),
      ],
    );
  }

  static pw.Widget _buildPupilsTable(
    List<_PupilEntryData> pupils,
    int startIndex,
    pw.Font fontRegular,
    pw.Font fontBold,
  ) {
    try {
      if (pupils.isEmpty) {
        return pw.Container(
          width: double.infinity,
          padding: const pw.EdgeInsets.all(20),
          child: pw.Center(
            child: pw.Text(
              'Keine Schüler:innen in dieser Liste',
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
          0: pw.FixedColumnWidth(30), // Nr. - increased to fit 3-digit numbers
          1: pw.FlexColumnWidth(3), // Name
          2: pw.FixedColumnWidth(25), // Status
          3: pw.FixedColumnWidth(40), // Gruppe
          4: pw.FixedColumnWidth(35), // Klasse
          5: pw.FlexColumnWidth(4), // Kommentar
          6: pw.FlexColumnWidth(2), // Erstellt von
        },
        children: [
          // Header row
          pw.TableRow(
            decoration: const pw.BoxDecoration(color: PdfColors.grey200),
            children: [
              _buildTableCell('Nr.', fontRegular, fontBold, isHeader: true),
              _buildTableCell('Name', fontRegular, fontBold, isHeader: true),
              _buildTableCell('Status', fontRegular, fontBold, isHeader: true),
              _buildTableCell('Gruppe', fontRegular, fontBold, isHeader: true),
              _buildTableCell('Klasse', fontRegular, fontBold, isHeader: true),
              _buildTableCell(
                'Kommentar',
                fontRegular,
                fontBold,
                isHeader: true,
              ),
              _buildTableCell(
                'Erstellt von',
                fontRegular,
                fontBold,
                isHeader: true,
              ),
            ],
          ),
          // Data rows
          ...pupils.asMap().entries.map((entry) {
            final index = startIndex + entry.key + 1;
            final pupilData = entry.value;

            try {
              return pw.TableRow(
                children: [
                  _buildTableCell(index.toString(), fontRegular, fontBold),
                  _buildTableCell(
                    '${pupilData.pupil.firstName} ${pupilData.pupil.lastName}',
                    fontRegular,
                    fontBold,
                  ),
                  _buildTableCell(
                    _getStatusText(pupilData.entry.status),
                    fontRegular,
                    fontBold,
                  ),
                  _buildTableCell(pupilData.pupil.group, fontRegular, fontBold),
                  _buildTableCell(
                    pupilData.pupil.schoolGrade.name,
                    fontRegular,
                    fontBold,
                  ),
                  _buildTableCell(
                    pupilData.entry.comment ?? '',
                    fontRegular,
                    fontBold,
                  ),
                  _buildTableCell(
                    pupilData.entry.entryBy ?? '',
                    fontRegular,
                    fontBold,
                  ),
                ],
              );
            } catch (e) {
              // Return a row with error info
              return pw.TableRow(
                children: [
                  _buildTableCell(index.toString(), fontRegular, fontBold),
                  _buildTableCell(
                    'ERROR: Row ${entry.key}',
                    fontRegular,
                    fontBold,
                  ),
                  _buildTableCell('ERROR', fontRegular, fontBold),
                  _buildTableCell('ERROR', fontRegular, fontBold),
                  _buildTableCell('ERROR', fontRegular, fontBold),
                  _buildTableCell('ERROR', fontRegular, fontBold),
                  _buildTableCell('ERROR', fontRegular, fontBold),
                ],
              );
            }
          }).toList(),
        ],
      );
    } catch (e) {
      return pw.Container(
        padding: const pw.EdgeInsets.all(20),
        child: pw.Text(
          'Error building table: $e',
          style: pw.TextStyle(font: fontRegular),
        ),
      );
    }
  }

  static pw.Widget _buildTableCell(
    String text,
    pw.Font fontRegular,
    pw.Font fontBold, {
    bool isHeader = false,
  }) {
    // Truncate text if it's too long to prevent overflow issues
    String displayText = text;
    if (!isHeader && text.length > 25) {
      displayText = '${text.substring(0, 22)}...';
    }

    return pw.Container(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Text(
        displayText,
        style: pw.TextStyle(
          fontSize: isHeader ? 11 : 10,
          font: isHeader ? fontBold : fontRegular,
        ),
        overflow: pw.TextOverflow.clip, // Clip text that's still too long
      ),
    );
  }

  static String _getStatusText(bool? status) {
    if (status == null) return '?';
    return status ? '✓' : '✗';
  }

  static pw.Widget _buildFooter(SchoolList schoolList, pw.Font fontRegular) {
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
              'Liste ID: ${schoolList.listId}',
              style: pw.TextStyle(fontSize: 8, font: fontRegular),
            ),
            pw.Text(
              'Erstellt am: ${DateTime.now().formatForUser()}',
              style: pw.TextStyle(fontSize: 8, font: fontRegular),
            ),
          ],
        ),
      ],
    );
  }
}

class _PupilEntryData {
  final PupilProxy pupil;
  final PupilListEntry entry;

  _PupilEntryData({required this.pupil, required this.entry});
}

class SchoolListPdfViewPage extends StatefulWidget {
  final File pdfFile;
  const SchoolListPdfViewPage({required this.pdfFile, super.key});

  @override
  State<SchoolListPdfViewPage> createState() => _SchoolListPdfViewPageState();
}

class _SchoolListPdfViewPageState extends State<SchoolListPdfViewPage> {
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
        iconData: Icons.list_alt_rounded,
        title: 'Schulliste PDF',
      ),
      body: PdfPreview(
        actionBarTheme: const PdfActionBarTheme(
          backgroundColor: AppColors.backgroundColor,
          iconColor: Colors.white,
          textStyle: TextStyle(color: Colors.white),
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

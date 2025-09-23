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
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_helper_functions.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/models/attendance_values.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('AttendancePdfGenerator');
final _attendanceManager = di<AttendanceManager>();
final _notificationService = di<NotificationService>();

class AttendancePdfGenerator {
  /// Generates a PDF for the attendance list of a specific date
  static Future<File> generateAttendancePdf({
    required DateTime date,
    required List<PupilProxy> pupils,
  }) async {
    final data = await rootBundle.load('assets/foreground_windows.png');
    final imageBytes = data.buffer.asUint8List();
    final image = pw.MemoryImage(imageBytes);

    // Load Unicode-supporting fonts
    final fontRegular = await PdfGoogleFonts.robotoRegular();
    final fontBold = await PdfGoogleFonts.robotoBold();

    final pdf = pw.Document();

    _notificationService.setHeavyLoadingValue(true);

    // Configuration for pagination
    const int maxPupilsPerPage = 24;
    final int totalPages = (pupils.length / maxPupilsPerPage).ceil();

    if (pupils.isEmpty) {
      // If no pupils, still create one page
      pdf.addPage(
        _buildPage(
          image: image,
          date: date,
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
        final endIndex = (currentIndex + maxPupilsPerPage).clamp(
          0,
          pupils.length,
        );

        // Skip empty pages
        if (currentIndex >= pupils.length) {
          break;
        }

        final pupilsOnPage = pupils.sublist(currentIndex, endIndex);

        pdf.addPage(
          _buildPage(
            image: image,
            date: date,
            pupils: pupilsOnPage,
            pageNumber: page,
            totalPages: totalPages,
            totalPupils: pupils.length,
            startIndex: currentIndex,
            fontRegular: fontRegular,
            fontBold: fontBold,
          ),
        );

        currentIndex = endIndex;
      }
    }

    _notificationService.setHeavyLoadingValue(false);

    // Get the proper directory for saving files
    final directory = await getApplicationDocumentsDirectory();
    final fileName =
        "Anwesenheitsliste_${date.formatForUser().replaceAll(' ', '_')}.pdf";
    final file = File('${directory.path}/$fileName');

    await file.writeAsBytes(await pdf.save());
    _log.info('PDF generated: ${file.path}');
    return file;
  }

  static pw.Page _buildPage({
    required pw.MemoryImage image,
    required DateTime date,
    required List<PupilProxy> pupils,
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
                  date,
                  pageNumber,
                  totalPages,
                  fontRegular,
                  fontBold,
                ),
                pw.SizedBox(height: 15),

                // Statistics (only on first page)
                if (pageNumber == 1) ...[
                  _buildStatistics(totalPupils, fontRegular, fontBold),
                  pw.SizedBox(height: 12),
                ],

                // Pupils table
                pw.Expanded(
                  child: _buildAttendanceTable(
                    pupils,
                    startIndex,
                    date,
                    fontRegular,
                    fontBold,
                  ),
                ),

                // Footer
                _buildFooter(date, fontRegular),
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
    DateTime date,
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
                      'Anwesenheitsliste',
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
                    'Anwesenheitsliste',
                    style: pw.TextStyle(fontSize: 20, font: fontBold),
                  ),
                  pw.SizedBox(height: 5),
                  pw.Text(
                    '${_getWeekdayName(date)}, ${date.formatForUser()}',
                    style: pw.TextStyle(fontSize: 12, font: fontRegular),
                  ),
                ],
              ),
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(
                  'Erstellt am: ${DateTime.now().formatForUser()}',
                  style: pw.TextStyle(fontSize: 10, font: fontRegular),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildStatistics(
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

  static pw.Widget _buildAttendanceTable(
    List<PupilProxy> pupils,
    int startIndex,
    DateTime targetDate,
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
          0: pw.FixedColumnWidth(30), // Nr.
          1: pw.FlexColumnWidth(3), // Name
          2: pw.FixedColumnWidth(60), // Status
          3: pw.FixedColumnWidth(50), // Entschuldigt
          4: pw.FixedColumnWidth(50), // Kontakt
          5: pw.FixedColumnWidth(50), // Abgeholt
          6: pw.FlexColumnWidth(2), // Kommentar
        },
        children: [
          // Header row
          pw.TableRow(
            decoration: const pw.BoxDecoration(color: PdfColors.grey200),
            children: [
              _buildTableCell('Nr.', fontRegular, fontBold, isHeader: true),
              _buildTableCell('Name', fontRegular, fontBold, isHeader: true),
              _buildTableCell('Status', fontRegular, fontBold, isHeader: true),
              _buildTableCell('Entsch.', fontRegular, fontBold, isHeader: true),
              _buildTableCell('Kontakt', fontRegular, fontBold, isHeader: true),
              _buildTableCell(
                'Abgeholt',
                fontRegular,
                fontBold,
                isHeader: true,
              ),
              _buildTableCell(
                'Kommentar',
                fontRegular,
                fontBold,
                isHeader: true,
              ),
            ],
          ),
          // Data rows
          ...pupils.asMap().entries.map((entry) {
            final index = startIndex + entry.key + 1;
            final pupil = entry.value;
            final attendanceInfo = _getAttendanceInfo(pupil, targetDate);

            try {
              return pw.TableRow(
                children: [
                  _buildTableCell(index.toString(), fontRegular, fontBold),
                  _buildTableCell(
                    '${pupil.firstName} ${pupil.lastName}',
                    fontRegular,
                    fontBold,
                  ),
                  _buildTableCell(
                    _getStatusText(attendanceInfo),
                    fontRegular,
                    fontBold,
                  ),
                  _buildTableCell(
                    attendanceInfo.unexcusedValue ? 'Ja' : 'Nein',
                    fontRegular,
                    fontBold,
                    isBold: attendanceInfo.unexcusedValue,
                  ),
                  _buildTableCell(
                    _getContactedText(attendanceInfo),
                    fontRegular,
                    fontBold,
                  ),
                  _buildTableCell(
                    attendanceInfo.returnedValue ? 'Ja' : 'Nein',
                    fontRegular,
                    fontBold,
                  ),
                  _buildTableCell(
                    attendanceInfo.commentValue ?? '',
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
    bool isBold = false,
  }) {
    // Truncate text if it's too long to prevent overflow issues
    String displayText = text;
    if (!isHeader && text.length > 25) {
      displayText = '${text.substring(0, 22)}...';
    }

    return pw.Container(
      padding: const pw.EdgeInsets.all(4),
      child: pw.Text(
        displayText,
        style: pw.TextStyle(
          fontSize: isHeader ? 10 : 9,
          font: isHeader || isBold ? fontBold : fontRegular,
        ),
        textAlign: isHeader ? pw.TextAlign.center : pw.TextAlign.left,
        overflow: pw.TextOverflow.clip, // Clip text that's still too long
      ),
    );
  }

  /// Gets attendance information for a pupil
  static AttendanceValues _getAttendanceInfo(
    PupilProxy pupil,
    DateTime targetDate,
  ) {
    final missedSchooldaysList = _attendanceManager
        .getPupilMissedSchooldaysProxy(pupil.pupilId);
    final missedSchoolday = missedSchooldaysList.missedSchooldays.firstWhere(
      (element) => element.schoolday?.schoolday.isSameDate(targetDate) ?? false,
      orElse:
          () => MissedSchoolday(
            missedType: MissedType.notSet,
            unexcused: false,
            contacted: ContactedType.notSet,
            returned: false,
            writtenExcuse: false,
            createdBy: '',
            schooldayId: 0,
            pupilId: pupil.pupilId,
          ),
    );

    return AttendanceHelper.getAttendanceValues(missedSchoolday);
  }

  /// Gets the status text for display
  static String _getStatusText(AttendanceValues attendanceInfo) {
    switch (attendanceInfo.missedTypeValue) {
      case MissedType.notSet:
        return 'Anwesend';
      case MissedType.missed:
        return 'Fehlend';
      case MissedType.late:
        return 'Verspätet';
      case MissedType.home:
        return 'Früh gegangen';
    }
  }

  /// Gets the contacted status text
  static String _getContactedText(AttendanceValues attendanceInfo) {
    switch (attendanceInfo.contactedTypeValue) {
      case ContactedType.notSet:
        return '-';
      case ContactedType.contacted:
        return 'Kontaktiert';
      case ContactedType.calledBack:
        return 'Rückruf';
      case ContactedType.notReached:
        return 'Nicht erreicht';
    }
  }

  static String _getWeekdayName(DateTime date) {
    const weekdays = [
      'Montag',
      'Dienstag',
      'Mittwoch',
      'Donnerstag',
      'Freitag',
      'Samstag',
      'Sonntag',
    ];
    return weekdays[date.weekday - 1];
  }

  static pw.Widget _buildFooter(DateTime date, pw.Font fontRegular) {
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
              'Datum: ${date.formatForUser()}',
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

class AttendancePdfViewPage extends StatefulWidget {
  final File pdfFile;
  const AttendancePdfViewPage({required this.pdfFile, super.key});

  @override
  State<AttendancePdfViewPage> createState() => _AttendancePdfViewPageState();
}

class _AttendancePdfViewPageState extends State<AttendancePdfViewPage> {
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
        title: 'Anwesenheitsliste PDF',
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

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/pdf/learning_support_plan_pdf_generator.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/widgets/timetable_utils.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';

final _log = Logger('TimetablePdfGenerator');

/// Fixed grid time range: 07:50–16:00, every 15 minutes.
const int _gridDayStartMinutes = (7 * 60) + 50; // 07:50
const int _gridDayEndMinutes = 16 * 60; // 16:00
const int _timeStepMinutes = 15;

/// Parses "HH:MM" to minutes since midnight. Returns null on invalid input.
int? _timeToMinutes(String time) {
  final parts = time.split(':');
  if (parts.length != 2) return null;
  final h = int.tryParse(parts[0]);
  final m = int.tryParse(parts[1]);
  if (h == null || m == null || h < 0 || h > 23 || m < 0 || m > 59) return null;
  return h * 60 + m;
}

/// Generates a timetable PDF in horizontal A3 format, one day per page.
/// Grid: time on the left (every 15 minutes), classrooms on top. Printed even if empty.
class TimetablePdfGenerator {
  /// Generates a PDF for the given [timetableManager].
  /// Returns the saved file. Uses A3 landscape, one page per weekday (Mon–Fri).
  /// Grid is always printed (time every 15 min, classroom columns); empty grid if no data.
  static Future<File> generateTimetablePdf({
    required TimetableManager timetableManager,
  }) async {
    final timetable = timetableManager.activeTimetable;
    final timetableSlots = timetableManager.timetableSlots.value;
    final classrooms = timetableManager.classrooms.value;

    // Fixed whole grid: 07:50–16:00, every 15 minutes.
    final startMinutes = _gridDayStartMinutes;
    final endMinutes = _gridDayEndMinutes;

    final timeLabels = <String>[];
    for (var m = startMinutes; m < endMinutes; m += _timeStepMinutes) {
      final h = m ~/ 60;
      final min = m % 60;
      timeLabels.add(
        '${h.toString().padLeft(2, '0')}:${min.toString().padLeft(2, '0')}',
      );
    }
    final timeMinutesList = List.generate(
      timeLabels.length,
      (i) => startMinutes + i * _timeStepMinutes,
    );

    // Classroom column headers: room code only (saves space)
    final roomHeaders = classrooms.isEmpty
        ? <String>['–']
        : classrooms.map((r) => r.roomCode).toList();
    final roomIds = classrooms.isEmpty
        ? <int?>[null]
        : classrooms.map((r) => r.id as int?).toList();

    final fontRegular = await PdfGoogleFonts.robotoRegular();
    final fontBold = await PdfGoogleFonts.robotoBold();

    final pdf = pw.Document();
    final weekdays = Weekday.values;
    final totalPages = weekdays.length;
    final slotIdToSlot = {for (final s in timetableSlots) s.id!: s};
    final scheduledLessons = timetableManager.scheduledLessons.value;

    di<NotificationService>().setHeavyLoadingValue(true);
    try {
      for (var pageIndex = 0; pageIndex < weekdays.length; pageIndex++) {
        final weekday = weekdays[pageIndex];
        pdf.addPage(
          _buildRoomTimeGridDayPage(
            pageFormat: PdfPageFormat.a3.landscape,
            timetableName: timetable?.name ?? 'Stundenplan',
            weekday: weekday,
            timeLabels: timeLabels,
            timeMinutesList: timeMinutesList,
            roomHeaders: roomHeaders,
            roomIds: roomIds,
            slotIdToSlot: slotIdToSlot,
            scheduledLessons: scheduledLessons,
            pageNumber: pageIndex + 1,
            totalPages: totalPages,
            fontRegular: fontRegular,
            fontBold: fontBold,
          ),
        );
      }

      final directory = await getApplicationDocumentsDirectory();
      final fileName =
          'Stundenplan_${timetable?.name ?? "Export"}_${DateTime.now().toIso8601String().substring(0, 10)}.pdf';
      final file = File('${directory.path}/$fileName');
      await file.writeAsBytes(await pdf.save());
      _log.info('Timetable PDF generated: ${file.path}');
      return file;
    } finally {
      di<NotificationService>().setHeavyLoadingValue(false);
    }
  }

  static pw.Page _buildRoomTimeGridDayPage({
    required PdfPageFormat pageFormat,
    required String timetableName,
    required Weekday weekday,
    required List<String> timeLabels,
    required List<int> timeMinutesList,
    required List<String> roomHeaders,
    required List<int?> roomIds,
    required Map<int, TimetableSlot> slotIdToSlot,
    required List<ScheduledLesson> scheduledLessons,
    required int pageNumber,
    required int totalPages,
    required pw.Font fontRegular,
    required pw.Font fontBold,
  }) {
    const margin = 28.0;
    final usableWidth = pageFormat.width - 2 * margin;
    final usableHeight = pageFormat.height - 2 * margin;

    const headerHeight = 36.0;
    const timeColumnWidth = 48.0;
    final dataWidth = usableWidth - timeColumnWidth;
    final dataHeight = usableHeight - headerHeight;

    final rowCount = timeLabels.length;
    final colCount = roomHeaders.length;
    final rowHeight = rowCount > 0 ? dataHeight / rowCount : 12.0;
    final cellWidth = colCount > 0 ? dataWidth / colCount : dataWidth;

    return pw.Page(
      pageFormat: pageFormat,
      margin: const pw.EdgeInsets.all(margin),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  '$timetableName – ${TimetableUtils.getWeekdayName(weekday)}',
                  style: pw.TextStyle(font: fontBold, fontSize: 14),
                ),
                pw.Text(
                  'Seite $pageNumber von $totalPages',
                  style: pw.TextStyle(font: fontRegular, fontSize: 9),
                ),
              ],
            ),
            pw.SizedBox(height: 8),
            pw.Expanded(
              child: pw.Table(
                border: pw.TableBorder.all(
                  color: PdfColors.grey400,
                  width: 0.5,
                ),
                columnWidths: {
                  0: pw.FixedColumnWidth(timeColumnWidth),
                  for (var i = 0; i < colCount; i++)
                    i + 1: pw.FixedColumnWidth(cellWidth),
                },
                children: [
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.grey200,
                    ),
                    verticalAlignment: pw.TableCellVerticalAlignment.middle,
                    children: [
                      pw.Container(
                        height: rowHeight * 0.8,
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.symmetric(
                          horizontal: 2,
                          vertical: 2,
                        ),
                        child: pw.Text(
                          'Zeit',
                          style: pw.TextStyle(font: fontBold, fontSize: 7),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      ...roomHeaders.map(
                        (h) => pw.Container(
                          height: rowHeight * 0.8,
                          alignment: pw.Alignment.center,
                          padding: const pw.EdgeInsets.symmetric(
                            horizontal: 2,
                            vertical: 2,
                          ),
                          child: pw.FittedBox(
                            child: pw.Text(
                              h,
                              style: pw.TextStyle(font: fontBold, fontSize: 8),
                              textAlign: pw.TextAlign.center,
                              maxLines: 2,
                              overflow: pw.TextOverflow.clip,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...List.generate(timeLabels.length, (rowIndex) {
                    final timeLabel = timeLabels[rowIndex];
                    final timeMin = timeMinutesList[rowIndex];
                    return pw.TableRow(
                      verticalAlignment: pw.TableCellVerticalAlignment.middle,
                      children: [
                        pw.Container(
                          height: rowHeight,
                          alignment: pw.Alignment.center,
                          padding: const pw.EdgeInsets.all(2),
                          child: pw.Text(
                            timeLabel,
                            style: pw.TextStyle(font: fontRegular, fontSize: 6),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        ...List.generate(colCount, (colIndex) {
                          final roomId = colIndex < roomIds.length
                              ? roomIds[colIndex]
                              : null;
                          final lessons = _lessonsAtTimeAndRoom(
                            weekday: weekday,
                            timeMinutes: timeMin,
                            roomId: roomId,
                            scheduledLessons: scheduledLessons,
                            slotIdToSlot: slotIdToSlot,
                          );
                          final lesson = lessons.isNotEmpty
                              ? lessons.first
                              : null;
                          return pw.Container(
                            height: rowHeight,
                            padding: const pw.EdgeInsets.all(2),
                            child: _buildRoomCellContent(
                              lesson: lesson,
                              rowHeight: rowHeight,
                              fontRegular: fontRegular,
                              fontBold: fontBold,
                            ),
                          );
                        }),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  /// Lessons in [scheduledLessons] that are in [roomId] and whose slot contains [timeMinutes] on [weekday].
  static List<ScheduledLesson> _lessonsAtTimeAndRoom({
    required Weekday weekday,
    required int timeMinutes,
    required int? roomId,
    required List<ScheduledLesson> scheduledLessons,
    required Map<int, TimetableSlot> slotIdToSlot,
  }) {
    if (roomId == null) return [];
    final result = <ScheduledLesson>[];
    for (final lesson in scheduledLessons) {
      if (lesson.roomId != roomId) continue;
      final slot = slotIdToSlot[lesson.scheduledAtId];
      if (slot == null || slot.day != weekday) continue;
      final startM = _timeToMinutes(slot.startTime);
      final endM = _timeToMinutes(slot.endTime);
      if (startM == null || endM == null) continue;
      if (timeMinutes >= startM && timeMinutes < endM) result.add(lesson);
    }
    return result;
  }

  static pw.Widget _buildRoomCellContent({
    required ScheduledLesson? lesson,
    required double rowHeight,
    required pw.Font fontRegular,
    required pw.Font fontBold,
  }) {
    if (lesson == null) {
      return pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.grey300, width: 0.3),
        ),
      );
    }

    final subjectName = lesson.subject?.name ?? '–';
    final teacherLabel = _teacherLabel(lesson);
    final groupName = lesson.lessonGroup?.name ?? '–';
    final fontSize = (rowHeight / 5).clamp(4.0, 8.0);

    return pw.Container(
      decoration: pw.BoxDecoration(
        color: PdfColors.white,
        border: pw.Border.all(color: PdfColors.grey400, width: 0.3),
      ),
      padding: const pw.EdgeInsets.symmetric(horizontal: 2, vertical: 1),
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          pw.Text(
            subjectName,
            style: pw.TextStyle(font: fontBold, fontSize: fontSize),
            maxLines: 1,
            overflow: pw.TextOverflow.clip,
          ),
          if (teacherLabel != null && teacherLabel.isNotEmpty)
            pw.Text(
              teacherLabel,
              style: pw.TextStyle(font: fontRegular, fontSize: fontSize - 0.5),
              maxLines: 1,
              overflow: pw.TextOverflow.clip,
            ),
          pw.Text(
            groupName,
            style: pw.TextStyle(font: fontRegular, fontSize: fontSize - 0.5),
            maxLines: 1,
            overflow: pw.TextOverflow.clip,
          ),
        ],
      ),
    );
  }

  static String? _teacherLabel(ScheduledLesson lesson) {
    try {
      final userManager = di<UserManager>();
      final users = userManager.users.value;
      final main = users.where((u) => u.id == lesson.mainTeacherId).firstOrNull;
      if (main?.userInfo?.fullName != null &&
          main!.userInfo!.fullName!.isNotEmpty) {
        return main.userInfo!.fullName;
      }
      if (main?.userInfo?.userName != null &&
          main!.userInfo!.userName!.isNotEmpty) {
        return main.userInfo!.userName;
      }
    } catch (_) {}
    return null;
  }
}

/// Full-screen PDF preview for a generated timetable PDF.
/// Deletes the file on dispose.
class TimetablePdfViewPage extends StatefulWidget {
  const TimetablePdfViewPage({super.key, required this.pdfFile});

  final File pdfFile;

  @override
  State<TimetablePdfViewPage> createState() => _TimetablePdfViewPageState();
}

class _TimetablePdfViewPageState extends State<TimetablePdfViewPage> {
  @override
  void dispose() {
    if (widget.pdfFile.existsSync()) {
      widget.pdfFile.deleteSync();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(
        iconData: Icons.picture_as_pdf,
        title: 'Stundenplan PDF',
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
          if (context.mounted) Navigator.of(context).pop();
        },
        build: (_) => widget.pdfFile.readAsBytes(),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (context.mounted) Navigator.of(context).pop();
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => PdfZoomableImage(file: widget.pdfFile),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

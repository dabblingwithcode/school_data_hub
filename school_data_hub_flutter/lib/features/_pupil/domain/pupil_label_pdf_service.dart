import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/school/domain/school_data_manager.dart';

final _log = Logger('PupilLabelPdfService');

/// Generates AVERY 5759-format label sheets (70×36 mm, 3 columns × 8 rows on
/// A4) for a list of pupils.
///
/// Each label shows:
/// - top-left: school grade
/// - centered-left: learning group (prominent)
/// - centered-right: first name + last-name initial (prominent)
/// - left side: QR code with base64-encoded internalId
class PupilLabelPdfService {
  // Label dimensions in mm → converted to PDF points (1 mm ≈ 2.8346 pt).
  static const double _labelWidthMm = 70;
  static const double _labelHeightMm = 36;
  static const double _labelWidth = _labelWidthMm * PdfPageFormat.mm;
  static const double _labelHeight = _labelHeightMm * PdfPageFormat.mm;

  static const int _columns = 3;
  static const int _rows = 8;
  static const int _labelsPerPage = _columns * _rows;

  // A4 usable area: 210 × 297 mm.  Labels occupy 210 × 288 mm.
  // Vertical remainder = 297 - 288 = 9 mm → split as top/bottom margins.
  static const double _topMargin = 4.5 * PdfPageFormat.mm;
  static const double _leftMargin = 0.0;

  /// Generates the label PDF and returns the written [File].
  static Future<File> generateLabelsPdf(List<PupilProxy> pupils) async {
    final fontData = await rootBundle.load('assets/fonts/grundschrift.ttf');
    final font = pw.Font.ttf(fontData);

    final pdf = pw.Document();
    final totalPages = (pupils.length / _labelsPerPage).ceil();

    for (var page = 0; page < totalPages; page++) {
      final startIndex = page * _labelsPerPage;
      final endIndex = (startIndex + _labelsPerPage).clamp(0, pupils.length);
      final pagePupils = pupils.sublist(startIndex, endIndex);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.zero,
          build: (context) => _buildPage(pagePupils, font),
        ),
      );
    }

    final directory = await getApplicationDocumentsDirectory();
    final fileName = 'Etiketten_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    _log.info(
      'Label PDF generated: ${file.path} '
      '(${pupils.length} labels, $totalPages pages)',
    );
    return file;
  }

  static pw.Widget _buildPage(List<PupilProxy> pupils, pw.Font font) {
    final rows = <pw.TableRow>[];

    for (var row = 0; row < _rows; row++) {
      final cells = <pw.Widget>[];
      for (var col = 0; col < _columns; col++) {
        final index = row * _columns + col;
        if (index < pupils.length) {
          cells.add(_buildLabel(pupils[index], font));
        } else {
          cells.add(pw.SizedBox(width: _labelWidth, height: _labelHeight));
        }
      }
      rows.add(
        pw.TableRow(children: cells),
      ); // ignore: prefer_const_constructors
    }

    return pw.Padding(
      padding: pw.EdgeInsets.only(top: _topMargin, left: _leftMargin),
      child: pw.Table(children: rows),
    );
  }

  static pw.Widget _buildLabel(PupilProxy pupil, pw.Font font) {
    final abbreviatedName = '${pupil.firstName} ${pupil.lastName[0]}.';
    final group = pupil.group;
    final grade = pupil.schoolGrade.name;
    final schoolName =
        '${di<SchoolDataMainManager>().schoolData.value?.name} ${di<SchoolDataMainManager>().schoolData.value?.city}';
    final qrData = base64Url.encode(utf8.encode(pupil.internalId.toString()));

    const qrSize = 10.0 * PdfPageFormat.mm;
    const padding = 2.0 * PdfPageFormat.mm;

    return pw.Container(
      width: _labelWidth,
      height: _labelHeight,
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400, width: 0.5),
      ),
      padding: const pw.EdgeInsets.all(padding),
      child: pw.Stack(
        children: [
          // QR code – top left
          pw.Positioned(
            top: 0,
            left: 0,
            child: pw.Padding(
              padding: const pw.EdgeInsets.only(left: 5),
              child: pw.BarcodeWidget(
                barcode: pw.Barcode.qrCode(),
                data: qrData,
                width: qrSize,
                height: qrSize,
              ),
            ),
          ),
          // School grade – top right
          pw.Positioned(
            top: 0,
            right: 0,
            child: pw.Text(grade, style: pw.TextStyle(font: font, fontSize: 8)),
          ),

          // Learning group – bottom left
          pw.Positioned(
            bottom: 0,
            left: 0,
            child: pw.Padding(
              padding: const pw.EdgeInsets.only(left: 5),
              child: pw.Text(
                group,
                style: pw.TextStyle(
                  font: font,
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ),

          // Name – centered right
          pw.Positioned.fill(
            child: pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Padding(
                padding: const pw.EdgeInsets.only(right: 4),
                child: pw.Text(
                  abbreviatedName,
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.right,
                ),
              ),
            ),
          ),
          // School name – bottom right
          pw.Positioned(
            bottom: 0,
            right: 0,
            child: pw.Padding(
              padding: const pw.EdgeInsets.only(right: 4),
              child: pw.Text(
                schoolName,
                style: pw.TextStyle(font: font, fontSize: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

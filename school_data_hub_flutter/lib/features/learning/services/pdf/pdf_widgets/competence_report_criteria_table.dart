import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school_data_hub_flutter/features/learning/services/pdf/competence_report_pdf_generator.dart';

/// Reusable criteria table: predicate column + 4 achievement checkbox columns.
/// Used on competence report pages 1–4.
class CompetenceReportCriteriaTable {
  CompetenceReportCriteriaTable._();

  static const double _boxSize = 10.0;

  static bool _isChecked(int columnIndex, int achievement) {
    if (achievement == 0) return true;
    return achievement == columnIndex + 1;
  }

  static pw.Widget build({
    required List<ZeugnisCriterionRow> rows,
    required pw.Font fontRegular,
    required pw.MemoryImage checkboxImage,
    required pw.MemoryImage checkboxCheckImage,
    required pw.MemoryImage growthOneImage,
    required pw.MemoryImage growthTwoImage,
    required pw.MemoryImage growthThreeImage,
    required pw.MemoryImage growthFourImage,
  }) {
    return pw.Table(
      columnWidths: {
        0: const pw.FlexColumnWidth(4),
        1: const pw.FixedColumnWidth(_boxSize + 20),
        2: const pw.FixedColumnWidth(_boxSize + 20),
        3: const pw.FixedColumnWidth(_boxSize + 20),
        4: const pw.FixedColumnWidth(_boxSize + 20),
      },
      border: pw.TableBorder.all(color: PdfColors.black, width: 0.5),
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey200),
          verticalAlignment: pw.TableCellVerticalAlignment.bottom,
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(4),
              child: pw.Text(
                'Ihr Kind…',
                style: pw.TextStyle(font: fontRegular, fontSize: 10),
              ),
            ),
            _tableHeaderCell(growthOneImage),
            _tableHeaderCell(growthTwoImage),
            _tableHeaderCell(growthThreeImage),
            _tableHeaderCell(growthFourImage),
          ],
        ),
        ...rows.map(
          (row) => pw.TableRow(
            verticalAlignment: pw.TableCellVerticalAlignment.full,
            children: [
              pw.SizedBox(
                height: 15,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(3),
                  child: pw.Text(
                    row.predicate,
                    style: pw.TextStyle(font: fontRegular, fontSize: 10),
                  ),
                ),
              ),

              _checkboxCell(
                _isChecked(0, row.achievement),
                checkboxImage,
                checkboxCheckImage,
              ),
              _checkboxCell(
                _isChecked(1, row.achievement),
                checkboxImage,
                checkboxCheckImage,
              ),
              _checkboxCell(
                _isChecked(2, row.achievement),
                checkboxImage,
                checkboxCheckImage,
              ),
              _checkboxCell(
                _isChecked(3, row.achievement),
                checkboxImage,
                checkboxCheckImage,
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _tableHeaderCell(pw.MemoryImage growthImage) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: pw.Center(child: pw.Image(growthImage, width: 20, height: 20)),
    );
  }

  static pw.Widget _checkboxCell(
    bool checked,
    pw.MemoryImage checkboxImage,
    pw.MemoryImage checkboxCheckImage,
  ) {
    return pw.SizedBox(
      height: _boxSize + 4,
      child: pw.Padding(
        padding: const pw.EdgeInsets.all(2),
        child: pw.Center(
          child: pw.Image(
            checked ? checkboxCheckImage : checkboxImage,
            width: _boxSize,
            height: _boxSize,
          ),
        ),
      ),
    );
  }
}

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Shared PDF helpers used by multiple PDF generators (learning_support,
/// competence_report, attendance, etc.). Feature-specific helpers stay in
/// their feature's pdf folder.
class CommonPdfHelpers {
  CommonPdfHelpers._();

  static String formatDate(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}.${dt.month.toString().padLeft(2, '0')}.${dt.year}';
  }

  /// Checkbox character: filled square if checked, empty square if not.
  static String checkbox(bool checked) => checked ? 'X' : '0';

  /// Build a standard underlined fill field.
  /// When [text] is non-empty the underline is omitted and plain text is
  /// returned so it aligns vertically with adjacent label text.
  static pw.Widget fillField({
    String text = '',
    pw.Font? font,
    double? width,
    double height = 16,
    double fontSize = 12,
  }) {
    if (text.isNotEmpty) {
      final textWidget = pw.Text(
        text,
        style: pw.TextStyle(font: font, fontSize: fontSize),
      );
      return width != null
          ? pw.SizedBox(width: width, child: textWidget)
          : pw.Expanded(child: textWidget);
    }
    final child = pw.Container(
      height: height,
      width: width,
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: PdfColors.black, width: 0.5),
        ),
      ),
    );
    return width != null ? child : pw.Expanded(child: child);
  }

  /// Build a generic page header: school name (left) | center text | "Seite X von Y" (right).
  static pw.Widget buildGenericPageHeader({
    required String schoolName,
    required String centerText,
    required int pageNumber,
    required int totalPages,
    required pw.Font font,
    double fontSize = 9,
  }) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          schoolName,
          style: pw.TextStyle(font: font, fontSize: fontSize),
        ),
        pw.Text(
          centerText,
          style: pw.TextStyle(font: font, fontSize: fontSize),
        ),
        pw.Text(
          'Seite $pageNumber von $totalPages',
          style: pw.TextStyle(font: font, fontSize: fontSize),
        ),
      ],
    );
  }

  /// Table header cell.
  static pw.Widget tableHeaderCell(String text, pw.Font fontBold) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(4),
      child: pw.Text(text, style: pw.TextStyle(font: fontBold, fontSize: 7)),
    );
  }

  static pw.Widget tableHeaderCell2TextStyles({
    required String text1,
    required pw.Font font1,
    required String text2,
    required pw.Font font2,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(4),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(text1, style: pw.TextStyle(font: font1, fontSize: 7)),
          pw.Text(text2, style: pw.TextStyle(font: font2, fontSize: 6)),
        ],
      ),
    );
  }

  /// Table data cell.
  static pw.Widget tableDataCell(
    String text,
    pw.Font fontRegular, {
    double minHeight = 0,
  }) {
    return pw.Container(
      constraints: pw.BoxConstraints(minHeight: minHeight),
      padding: const pw.EdgeInsets.all(4),
      child: pw.Text(text, style: pw.TextStyle(font: fontRegular, fontSize: 7)),
    );
  }

  /// Checkbox widget for PDF forms.
  static pw.Widget checkboxWidget({
    required bool checked,
    required String label,
    required pw.MemoryImage checkboxImage,
    required pw.MemoryImage checkboxCheckImage,
    required pw.Font font,
    double fontSize = 8,
  }) {
    return pw.Row(
      mainAxisSize: pw.MainAxisSize.min,
      children: [
        pw.Image(
          checked ? checkboxCheckImage : checkboxImage,
          width: fontSize + 2,
          height: fontSize + 2,
        ),
        pw.SizedBox(width: 3),
        pw.Text(
          label,
          style: pw.TextStyle(font: font, fontSize: fontSize),
        ),
      ],
    );
  }
}

import 'package:logging/logging.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_helper.dart';

final _log = Logger('PdfHelpers');

/// Shared helpers used by all PDF page builders.
class PdfHelpers {
  PdfHelpers._();

  /// Resolve a userName to the user's fullName via UserHelper.
  /// Falls back to the raw value if the user is not found.
  static String resolveUserName(String? userName) {
    if (userName == null || userName.isEmpty) return '';
    final user = UserHelper.getUserByUserName(userName);
    _log.info('Resolved userName: $userName to ${user?.userInfo?.fullName}');
    return user?.userInfo?.fullName ?? userName;
  }

  /// Calculate "Lernjahr Deutsch" (1..4 where 4 means >3).
  /// Returns null if the pupil is not a migration pupil.
  static int? calculateLernjahr(PupilProxy pupil) {
    final migrationEnd = pupil.migrationSupportEnds;
    if (migrationEnd == null) {
      return null;
    }
    final years = DateTime.now().difference(pupil.pupilSince).inDays ~/ 365;
    if (years <= 0) return 1;
    if (years >= 4) return 4; // >3
    return years;
  }

  /// Calculate the "Schulbesuchsjahr" from the pupil's school grade,
  /// adding one extra year if the pupil was held back.
  static int calculateSchulbesuchsjahr(PupilProxy pupil) {
    int base;
    switch (pupil.schoolGrade) {
      case SchoolGrade.E1:
        base = 1;
      case SchoolGrade.E2:
        base = 2;
      case SchoolGrade.E3:
        base = 3;
      case SchoolGrade.K3:
        base = 3;
      case SchoolGrade.K4:
        base = 4;
    }
    if (pupil.schoolyearHeldBackAt != null) base += 1;
    return base;
  }

  /// Background color for PDF growth icons, matching AppColors.growthIconColor.
  static PdfColor getGrowthIconBackgroundColor(int score) {
    return switch (score) {
      1 => const PdfColor.fromInt(0xFFFF8C00),
      2 => const PdfColor.fromInt(0xFFFFD700),
      3 => const PdfColor.fromInt(0xFFD9F23A),
      4 => const PdfColor.fromInt(0xFF84B94F),
      _ => PdfColors.grey,
    };
  }

  static String getStatusSymbol(int score) {
    switch (score) {
      case 1:
        return '\u2713'; // ✓ Achieved
      case 2:
        return '\u25CB'; // ○ In Progress
      case 3:
        return '\u2717'; // ✗ Not Achieved
      default:
        return '-';
    }
  }

  static PdfColor getScoreColor(int score) {
    switch (score) {
      case 1:
        return PdfColors.green;
      case 2:
        return PdfColors.orange;
      case 3:
        return PdfColors.red;
      default:
        return PdfColors.grey;
    }
  }

  static String formatDate(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}.${dt.month.toString().padLeft(2, '0')}.${dt.year}';
  }

  /// Checkbox character: filled square if checked, empty square if not.
  /// Uses geometric shapes that Roboto renders cleanly.
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
    // Filled: plain text, no underline
    if (text.isNotEmpty) {
      final textWidget = pw.Text(
        text,
        style: pw.TextStyle(font: font, fontSize: fontSize),
      );
      return width != null
          ? pw.SizedBox(width: width, child: textWidget)
          : pw.Expanded(child: textWidget);
    }
    // Empty: underlined placeholder for hand-writing
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

  /// Build the template header line for every page.
  static pw.Widget buildTemplateHeader({
    required PupilProxy pupil,
    required LearningSupportPlan plan,
    required int pageNumber,
    required pw.Font fontRegular,
  }) {
    final schoolYear = plan.schoolSemester?.schoolYear ?? '';
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          'GGS Hermannstraße Stolberg',
          style: pw.TextStyle(font: fontRegular, fontSize: 9),
        ),
        pw.Text(
          'Stand ${formatDate(plan.createdAt)} ${pupil.firstName} ${pupil.lastName}, Förderplan SJ $schoolYear    Seite $pageNumber von 4',
          style: pw.TextStyle(font: fontRegular, fontSize: 9),
        ),
      ],
    );
  }

  /// Table header cell used on Page 3.
  static pw.Widget tableHeaderCell(String text, pw.Font fontBold) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(4),
      child: pw.Text(text, style: pw.TextStyle(font: fontBold, fontSize: 7)),
    );
  }

  /// Table data cell used on Page 3.
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
}

/// Internal helper class for flattened category tree items.
class CategoryTreeItem {
  final SupportCategory category;
  final int depth;
  const CategoryTreeItem({required this.category, required this.depth});
}

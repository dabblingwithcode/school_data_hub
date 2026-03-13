import 'package:pdf/widgets.dart' as pw;
import 'package:school_data_hub_flutter/common/services/pdf_helpers.dart' as common;

/// Zeugnis (competence report) specific PDF layout helpers. Uses
/// [common.CommonPdfHelpers] for generic helpers.
class CompetenceReportPdfHelpers {
  CompetenceReportPdfHelpers._();

  /// Build the Zeugnis page header: school name | "Zeugnis von {pupilName}" | Seite X von Y.
  static pw.Widget buildZeugnisPageHeader({
    required String schoolName,
    required String pupilName,
    required int pageNumber,
    required int totalPages,
    required pw.Font font,
    double fontSize = 9,
  }) {
    final centerText = 'Zeugnis von $pupilName';
    return common.CommonPdfHelpers.buildGenericPageHeader(
      schoolName: schoolName,
      centerText: centerText,
      pageNumber: pageNumber,
      totalPages: totalPages,
      font: font,
      fontSize: fontSize,
    );
  }
}

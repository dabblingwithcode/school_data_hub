import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/pdf_helpers.dart'
    as common;
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_helper.dart';
import 'package:school_data_hub_flutter/features/school/domain/school_data_manager.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_helper.dart';

final _log = Logger('PdfHelpers');

/// Learning-support (Förderplan) specific PDF helpers. Generic helpers are
/// in [common.CommonPdfHelpers].
class PdfHelpers {
  PdfHelpers._();

  // --- Delegations to common (so existing callers keep using PdfHelpers.*) ---
  static String formatDate(DateTime dt) =>
      common.CommonPdfHelpers.formatDate(dt);
  static String checkbox(bool checked) =>
      common.CommonPdfHelpers.checkbox(checked);
  static pw.Widget fillField({
    String text = '',
    pw.Font? font,
    double? width,
    double height = 16,
    double fontSize = 12,
  }) => common.CommonPdfHelpers.fillField(
    text: text,
    font: font,
    width: width,
    height: height,
    fontSize: fontSize,
  );
  static pw.Widget tableHeaderCell(String text, pw.Font fontBold) =>
      common.CommonPdfHelpers.tableHeaderCell(text, fontBold);
  static pw.Widget tableHeaderCell2TextStyles({
    required String text1,
    required pw.Font font1,
    required String text2,
    required pw.Font font2,
  }) => common.CommonPdfHelpers.tableHeaderCell2TextStyles(
    text1: text1,
    font1: font1,
    text2: text2,
    font2: font2,
  );
  static pw.Widget tableDataCell(
    String text,
    pw.Font fontRegular, {
    double minHeight = 0,
  }) => common.CommonPdfHelpers.tableDataCell(
    text,
    fontRegular,
    minHeight: minHeight,
  );
  static pw.Widget checkboxWidget({
    required bool checked,
    required String label,
    required pw.MemoryImage checkboxImage,
    required pw.MemoryImage checkboxCheckImage,
    required pw.Font font,
    double fontSize = 8,
  }) => common.CommonPdfHelpers.checkboxWidget(
    checked: checked,
    label: label,
    checkboxImage: checkboxImage,
    checkboxCheckImage: checkboxCheckImage,
    font: font,
    fontSize: fontSize,
  );

  // --- Förderplan-specific helpers ---

  static String resolveUserName(String? userName) {
    if (userName == null || userName.isEmpty) return '';
    final user = UserHelper.getUserByUserName(userName);
    _log.info('Resolved userName: $userName to ${user?.userInfo?.fullName}');
    return user?.userInfo?.fullName ?? userName;
  }

  static int? calculateLernjahr(PupilProxy pupil) {
    return PupilProxyHelper.calculateLernjahr(pupil);
  }

  static int calculateSchulbesuchsjahr(PupilProxy pupil) {
    return PupilProxyHelper.calculateSchulbesuchsjahr(pupil);
  }

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
        return '\u2713';
      case 2:
        return '\u25CB';
      case 3:
        return '\u2717';
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

  /// Build the template header line for every Förderplan page.
  static pw.Widget buildTemplateHeader({
    required PupilProxy pupil,
    required LearningSupportPlan plan,
    required int pageNumber,
    required pw.Font fontRegular,
  }) {
    final schoolName =
        di<SchoolDataMainManager>().schoolData.value!.officialName;
    final centerText =
        'Förderplan Nr. ${plan.number}  |  ${pupil.firstName} ${pupil.lastName}  |  Stand ${formatDate(plan.createdAt)}';
    return common.CommonPdfHelpers.buildGenericPageHeader(
      schoolName: schoolName,
      centerText: centerText,
      pageNumber: pageNumber,
      totalPages: 4,
      font: fontRegular,
    );
  }
}

/// Internal helper class for flattened category tree items.
class CategoryTreeItem {
  final SupportCategory category;
  final int depth;
  const CategoryTreeItem({required this.category, required this.depth});
}

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_helper.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/pdf/pdf_helpers.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

/// Page 2: Support Category Status Grid.
class PdfPage2 {
  PdfPage2._();

  static pw.Page build({
    required LearningSupportPlan plan,
    required PupilProxy pupil,
    required List<SupportCategory> supportCategories,
    required pw.Font fontRegular,
    required pw.Font fontBold,
  }) {
    // Build status lookup: categoryId -> SupportCategoryStatus
    final statusMap = <int, SupportCategoryStatus>{};
    if (plan.supportCategoryStatuses != null) {
      for (final status in plan.supportCategoryStatuses!) {
        statusMap[status.supportCategoryId] = status;
      }
    }

    // Find root categories (parentCategory == null)
    final roots =
        supportCategories.where((c) => c.parentCategory == null).toList();

    return pw.Page(
      pageFormat: PdfPageFormat.a4.landscape,
      margin: const pw.EdgeInsets.all(20),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            PdfHelpers.buildTemplateHeader(
              pupil: pupil,
              plan: plan,
              pageNumber: 2,
              fontRegular: fontRegular,
            ),
            pw.SizedBox(height: 4),
            pw.Divider(color: PdfColors.black, thickness: 0.5),
            pw.SizedBox(height: 4),

            // Category grid
            pw.Expanded(
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < roots.length; i++) ...[
                    pw.Expanded(
                      child: _buildCategoryColumn(
                        root: roots[i],
                        allCategories: supportCategories,
                        statusMap: statusMap,
                        fontRegular: fontRegular,
                        fontBold: fontBold,
                      ),
                    ),
                    if (i < roots.length - 1)
                      pw.Container(
                        width: 0.5,
                        color: PdfColors.black,
                      ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  /// Build one column of the category grid for a single root category.
  static pw.Widget _buildCategoryColumn({
    required SupportCategory root,
    required List<SupportCategory> allCategories,
    required Map<int, SupportCategoryStatus> statusMap,
    required pw.Font fontRegular,
    required pw.Font fontBold,
  }) {
    // Determine header label prefix
    final isLernbereich =
        root.name.contains('Deutsch') || root.name.contains('Mathematik');
    final headerPrefix = isLernbereich ? 'Lernbereich' : 'Entwicklungsbereich';

    // Get root color
    final rootColor = PdfColor.fromInt(
      LearningSupportHelper.getRootSupportCategoryColor(root).toARGB32(),
    );

    // Collect flattened tree items
    final items = <CategoryTreeItem>[];
    _collectCategoryTree(
      parentId: root.categoryId,
      allCategories: allCategories,
      depth: 0,
      items: items,
    );

    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black, width: 0.5),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Header
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(4),
            color: rootColor,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  headerPrefix,
                  style: pw.TextStyle(
                    font: fontBold,
                    fontSize: 7,
                    color: PdfColors.white,
                  ),
                ),
                pw.Text(
                  root.name,
                  style: pw.TextStyle(
                    font: fontBold,
                    fontSize: 7,
                    color: PdfColors.white,
                  ),
                ),
              ],
            ),
          ),
          // Body items
          ...items.map((item) {
            final hasChildren = allCategories
                .any((c) => c.parentCategory == item.category.categoryId);
            final status = statusMap[item.category.categoryId];
            final prefix = hasChildren ? '' : '- ';
            final indent = item.depth * 6.0;

            return pw.Padding(
              padding: pw.EdgeInsets.only(left: 2 + indent, top: 1, bottom: 1),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Text(
                      '$prefix${item.category.name}',
                      style: pw.TextStyle(
                        font: hasChildren ? fontBold : fontRegular,
                        fontSize: 6,
                      ),
                    ),
                  ),
                  if (status != null)
                    pw.Container(
                      width: 6,
                      height: 6,
                      margin: const pw.EdgeInsets.only(right: 2, top: 1),
                      decoration: pw.BoxDecoration(
                        color: PdfHelpers.getScoreColor(status.score),
                        shape: pw.BoxShape.circle,
                      ),
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  /// Recursively collect categories into a flat list with depth info.
  static void _collectCategoryTree({
    required int parentId,
    required List<SupportCategory> allCategories,
    required int depth,
    required List<CategoryTreeItem> items,
  }) {
    final children =
        allCategories.where((c) => c.parentCategory == parentId).toList();
    for (final child in children) {
      items.add(CategoryTreeItem(category: child, depth: depth));
      _collectCategoryTree(
        parentId: child.categoryId,
        allCategories: allCategories,
        depth: depth + 1,
        items: items,
      );
    }
  }
}

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_helper.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/pdf/pdf_helpers.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

/// Page 2: Support Category Status Grid.
class PdfPage2 {
  PdfPage2._();

  /// Preload the growth icon PNGs (scores 1-4) as MemoryImages for the PDF.
  static Future<Map<int, pw.MemoryImage>> _loadGrowthIcons() async {
    final icons = <int, pw.MemoryImage>{};
    for (int score = 1; score <= 4; score++) {
      final data = await rootBundle.load(
        'assets/images/growth_icons/growth_$score-4.png',
      );
      icons[score] = pw.MemoryImage(data.buffer.asUint8List());
    }
    return icons;
  }

  static Future<pw.Page> build({
    required LearningSupportPlan plan,
    required PupilProxy pupil,
    required List<SupportCategory> supportCategories,
    required pw.Font fontRegular,
    required pw.Font fontBold,
  }) async {
    // Preload growth icons
    final growthIcons = await _loadGrowthIcons();

    // Build status lookup: categoryId -> SupportCategoryStatus
    // Statuses live on the pupil, not on the plan object. Filter for this plan.
    final statusMap = <int, SupportCategoryStatus>{};
    final allStatuses = pupil.supportCategoryStatuses;
    if (allStatuses != null) {
      for (final status in allStatuses) {
        if (status.learningSupportPlanId == plan.id) {
          statusMap[status.supportCategoryId] = status;
        }
      }
    }

    // Find root categories (parentCategory == null)
    // Only include categories marked as printable
    final printableCategories = supportCategories
        .where((c) => c.printable == true)
        .toList();

    final roots = printableCategories
        .where((c) => c.parentCategory == null)
        .toList();

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
                        allCategories: printableCategories,
                        statusMap: statusMap,
                        growthIcons: growthIcons,
                        fontRegular: fontRegular,
                        fontBold: fontBold,
                      ),
                    ),
                    if (i < roots.length - 1)
                      pw.Container(width: 0.5, color: PdfColors.black),
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
    required Map<int, pw.MemoryImage> growthIcons,
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
                    fontSize: 8,
                    color: PdfColors.white,
                  ),
                ),
                pw.Text(
                  root.name,
                  style: pw.TextStyle(
                    font: fontBold,
                    fontSize: 8,
                    color: PdfColors.white,
                  ),
                ),
              ],
            ),
          ),
          // Body items
          for (int idx = 0; idx < items.length; idx++) ...[
            () {
              final item = items[idx];
              final hasChildren = allCategories.any(
                (c) => c.parentCategory == item.category.categoryId,
              );
              final status = statusMap[item.category.categoryId];
              // Level 2 categories (depth 0) are always bold
              final isBold = item.depth == 0 || hasChildren;
              final prefix = isBold ? '' : '- ';
              final indent = item.depth * 6.0;

              final hasStatus =
                  status != null && growthIcons[status.score] != null;

              final row = pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Expanded(
                    child: pw.Text(
                      '$prefix${item.category.name}',
                      style: pw.TextStyle(
                        font: isBold ? fontBold : fontRegular,
                        fontSize: 9,
                      ),
                    ),
                  ),
                  if (hasStatus)
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 4),
                      child: pw.Image(
                        growthIcons[status!.score]!,
                        width: 16,
                        height: 16,
                      ),
                    ),
                ],
              );

              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Add vertical space before bold categories (not the first)
                  if (isBold && idx > 0) pw.SizedBox(height: 7),
                  pw.Padding(
                    padding: pw.EdgeInsets.only(
                      left: 2 + indent,
                      top: 1,
                      bottom: 1,
                      right: 2,
                    ),
                    child: hasStatus
                        ? pw.Container(
                            padding: const pw.EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                color: PdfColors.grey400,
                                width: 0.5,
                              ),
                              borderRadius: const pw.BorderRadius.all(
                                pw.Radius.circular(4),
                              ),
                            ),
                            child: row,
                          )
                        : row,
                  ),
                ],
              );
            }(),
          ],
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
    final children = allCategories
        .where((c) => c.parentCategory == parentId)
        .toList();
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

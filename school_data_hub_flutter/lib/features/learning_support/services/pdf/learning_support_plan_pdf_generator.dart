import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/pdf/pages/pdf_page1.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/pdf/pages/pdf_page2.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/pdf/pages/pdf_page3.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/pdf/pages/pdf_page4.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/school/domain/school_data_manager.dart';

final _log = Logger('LearningSupportPlanPdfGenerator');

class LearningSupportPlanPdfGenerator {
  static Future<File> generateLearningSupportPlanPdf({
    required LearningSupportPlan plan,
    required PupilProxy pupil,
    required List<SupportCategory> supportCategories,
  }) async {
    final regularData = await rootBundle.load(
      'assets/fonts/Roboto-Regular.ttf',
    );
    final boldData = await rootBundle.load('assets/fonts/Roboto-Bold.ttf');
    final fontRegular = pw.Font.ttf(regularData);
    final fontBold = pw.Font.ttf(boldData);
    final schoolData = di<SchoolDataMainManager>().schoolData.value!;
    final pdf = pw.Document();

    di<NotificationService>().setHeavyLoadingValue(true);

    try {
      // Page 1: Pupil info and plan metadata
      pdf.addPage(
        PdfPage1.build(
          plan: plan,
          pupil: pupil,
          schoolData: schoolData,
          fontRegular: fontRegular,
          fontBold: fontBold,
        ),
      );

      // Page 2: Support category status grid
      pdf.addPage(
        await PdfPage2.build(
          plan: plan,
          pupil: pupil,
          supportCategories: supportCategories,
          fontRegular: fontRegular,
          fontBold: fontBold,
        ),
      );

      // Page 3: Goals detail table
      pdf.addPage(
        PdfPage3.build(
          plan: plan,
          pupil: pupil,
          supportCategories: supportCategories,
          fontRegular: fontRegular,
          fontBold: fontBold,
        ),
      );

      // Page 4: Notes and signatures
      pdf.addPage(
        PdfPage4.build(
          plan: plan,
          pupil: pupil,
          fontRegular: fontRegular,
          fontBold: fontBold,
        ),
      );
    } finally {
      di<NotificationService>().setHeavyLoadingValue(false);
    }

    final directory = await getApplicationDocumentsDirectory();
    final fileName =
        "Förderplan_${pupil.firstName}_${pupil.lastName}_${DateTime.now().formatDateForUser()}.pdf";
    final file = File('${directory.path}/$fileName');

    await file.writeAsBytes(await pdf.save());
    _log.info('Learning Support Plan PDF generated: ${file.path}');
    return file;
  }
}

// =============================================================================
// PDF View Page
// =============================================================================

class LearningSupportPlanPdfViewPage extends StatefulWidget {
  final File pdfFile;
  const LearningSupportPlanPdfViewPage({required this.pdfFile, super.key});

  @override
  State<LearningSupportPlanPdfViewPage> createState() =>
      _LearningSupportPlanPdfViewPageState();
}

class _LearningSupportPlanPdfViewPageState
    extends State<LearningSupportPlanPdfViewPage> {
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
        iconData: Icons.picture_as_pdf,
        title: 'Förderplan PDF',
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

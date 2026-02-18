import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdfrx/pdfrx.dart';
import 'package:printing/printing.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_bottom_nav_bar_no_filter.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/pdf/pages/pdf_page1.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/pdf/pages/pdf_page2.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/pdf/pages/pdf_page3.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/pdf/pages/pdf_page4.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/school/domain/school_data_manager.dart';

final _log = Logger('LearningSupportPlanPdfGenerator');

// =============================================================================
// PDF View Page
// =============================================================================

class LearningSupportPlanPdfViewPage extends StatefulWidget {
  final LearningSupportPlan plan;
  final PupilProxy pupil;
  final List<SupportCategory> supportCategories;
  const LearningSupportPlanPdfViewPage({
    required this.plan,
    required this.pupil,
    required this.supportCategories,
    super.key,
  });

  @override
  State<LearningSupportPlanPdfViewPage> createState() =>
      _LearningSupportPlanPdfViewPageState();
}

class _LearningSupportPlanPdfViewPageState
    extends State<LearningSupportPlanPdfViewPage> {
  File? _generatedFile;

  @override
  void dispose() {
    // Ensure the file is deleted when the widget is disposed
    if (_generatedFile?.existsSync() ?? false) {
      _generatedFile!.delete();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: LearningSupportPlanPdfGenerator.generateLearningSupportPlanPdf(
        plan: widget.plan,
        pupil: widget.pupil,
        supportCategories: widget.supportCategories,
      ),
      builder: (context, snapshot) {
        // Show error state
        if (snapshot.hasError) {
          _log.severe('Failed to generate PDF', snapshot.error);
          return Scaffold(
            appBar: const GenericAppBar(
              iconData: Icons.picture_as_pdf,
              title: 'Förderplan PDF',
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text('Fehler beim Erstellen des PDFs'),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.error.toString(),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Zurück'),
                  ),
                ],
              ),
            ),
          );
        }

        // Show loading state
        if (!snapshot.hasData) {
          return const Scaffold(
            appBar: GenericAppBar(
              iconData: Icons.picture_as_pdf,
              title: 'Förderplan PDF',
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('PDF wird erstellt...'),
                ],
              ),
            ),
          );
        }

        // PDF is ready
        final file = snapshot.data!;
        _generatedFile = file;
        _log.info('Opening PDF view for file: ${file.path}');

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
            build: (format) => file.readAsBytes(),
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
              IconButton(
                icon: const Icon(Icons.zoom_in),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PdfZoomableImage(file: file),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class PdfZoomableImage extends StatelessWidget {
  final File file;
  const PdfZoomableImage({required this.file, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(title: 'PDF Zoom', iconData: Icons.zoom_in),
      body: PdfViewer.file(file.path),
      bottomNavigationBar: const GenericBottomNavBarNoFilter(),
    );
  }
}

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

    // Load checkbox images for Page 1
    final checkboxData = await rootBundle.load(
      'assets/images/support_categories_icons/checkbox.png',
    );
    final checkboxCheckData = await rootBundle.load(
      'assets/images/support_categories_icons/checkbox_check.png',
    );
    final strengthEmojiData = await rootBundle.load(
      'assets/images/support_categories_icons/strength.png',
    );
    final checkboxImage = pw.MemoryImage(checkboxData.buffer.asUint8List());
    final checkboxCheckImage = pw.MemoryImage(
      checkboxCheckData.buffer.asUint8List(),
    );
    final strengthEmoji = pw.MemoryImage(
      strengthEmojiData.buffer.asUint8List(),
    );

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
          checkboxImage: checkboxImage,
          checkboxCheckImage: checkboxCheckImage,
          strengthImage: strengthEmoji,
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
          checkboxCheckImage: checkboxCheckImage,
          checkboxImage: checkboxImage,
          plan: plan,
          pupil: pupil,
          fontRegular: fontRegular,
          fontBold: fontBold,
          location: schoolData.city!,
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

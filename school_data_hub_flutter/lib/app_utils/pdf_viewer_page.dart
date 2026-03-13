import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:printing/printing.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';

final _log = Logger('PdfViewerPage');

class PdfViewerPage extends StatefulWidget {
  final Future<File> Function() pdfGenerator;
  final String title;
  final IconData iconData;
  final bool showZoomButton;

  const PdfViewerPage({
    required this.pdfGenerator,
    this.title = 'PDF Vorschau',
    this.iconData = Icons.picture_as_pdf,
    this.showZoomButton = false,
    super.key,
  });

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  File? _generatedFile;

  @override
  void dispose() {
    if (_generatedFile?.existsSync() ?? false) {
      _generatedFile!.delete();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: widget.pdfGenerator(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          _log.severe('Failed to generate PDF', snapshot.error);
          return Scaffold(
            appBar: GenericAppBar(
              iconData: widget.iconData,
              title: widget.title,
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

        if (!snapshot.hasData) {
          return Scaffold(
            appBar: GenericAppBar(
              iconData: widget.iconData,
              title: widget.title,
            ),
            body: const Center(
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

        final file = snapshot.data!;
        _generatedFile = file;
        _log.info('Opening PDF view for file: ${file.path}');

        return Scaffold(
          appBar: GenericAppBar(
            iconData: widget.iconData,
            title: widget.title,
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
              if (context.mounted) Navigator.of(context).pop();
            },
            build: (format) => file.readAsBytes(),
            actions: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (context.mounted) Navigator.of(context).pop();
                },
              ),
              if (widget.showZoomButton)
                IconButton(
                  icon: const Icon(Icons.zoom_in),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => _PdfZoomableImage(file: file),
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

class _PdfZoomableImage extends StatelessWidget {
  final File file;
  const _PdfZoomableImage({required this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(title: 'PDF Zoom', iconData: Icons.zoom_in),
      body: PdfViewer.file(file.path),
      bottomNavigationBar: const GenericBottomNavBar(),
    );
  }
}

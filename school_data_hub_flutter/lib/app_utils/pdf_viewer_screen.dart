import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:printing/printing.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

final _log = Logger('PdfViewerScreen');

class PdfViewerScreen extends StatefulWidget {
  final Future<File> Function() pdfGenerator;
  final String title;
  final IconData iconData;
  final bool showZoomButton;

  const PdfViewerScreen({
    required this.pdfGenerator,
    this.title = 'PDF Vorschau',
    this.iconData = Icons.picture_as_pdf,
    this.showZoomButton = false,
    super.key,
  });

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
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
    final style = Style.of(context);
    return FutureBuilder<File>(
      future: widget.pdfGenerator(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          _log.severe('Failed to generate PDF', snapshot.error);
          return Scaffold(
            appBar: AppHeader(
              iconData: widget.iconData,
              title: widget.title,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: style.colors.error),
                  SizedBox(height: Style.spacing.lg),
                  const Text('Fehler beim Erstellen des PDFs'),
                  SizedBox(height: Style.spacing.sm),
                  Text(
                    snapshot.error.toString(),
                    style: context.typography.bodySmall
                        .withColor(style.colors.mutedForeground),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Style.spacing.lg),
                  Button(
                    onPressed: () => Navigator.of(context).pop(),
                    label: 'Zurück',
                  ),
                ],
              ),
            ),
          );
        }

        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppHeader(
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
          appBar: AppHeader(
            iconData: widget.iconData,
            title: widget.title,
          ),
          body: PdfPreview(
            actionBarTheme: PdfActionBarTheme(
              backgroundColor: style.colors.accent,
              iconColor: style.colors.background,
              textStyle: TextStyle(color: style.colors.background),
            ),
            allowSharing: true,
            allowPrinting: true,
            canChangePageFormat: false,
            canChangeOrientation: false,
            canDebug: false,
            useActions: true,
            scrollViewDecoration: BoxDecoration(
              color: style.colors.mutedForeground,
            ),
            pdfPreviewPageDecoration: BoxDecoration(
              color: style.colors.background,
              boxShadow: [
                BoxShadow(
                  color: style.colors.foreground.withValues(alpha: 0.26),
                  offset: const Offset(0, 2),
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
      appBar: const AppHeader(title: 'PDF Zoom', iconData: Icons.zoom_in),
      body: PdfViewer.file(file.path),
      bottomNavigationBar: const ActionBar(),
    );
  }
}

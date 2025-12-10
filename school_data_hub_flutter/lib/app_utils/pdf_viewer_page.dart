import 'dart:io';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';

class PdfViewerPage extends StatelessWidget {
  final File pdfFile;
  const PdfViewerPage({required this.pdfFile, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(
        iconData: Icons.print_rounded,
        title: 'Pdf Vorschau',
      ),

      body: PdfPreview(
        actionBarTheme: PdfActionBarTheme(
          backgroundColor: AppColors.backgroundColor,
          iconColor: Colors.white,
          textStyle: const TextStyle(color: Colors.white),
        ),
        allowSharing: false,
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,
        // actions: [Icon(Icons.download)],
        onPrinted: (context) {
          pdfFile.delete();
          if (context.mounted) {
            Navigator.of(context).pop();
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          }
        },
        build: (format) => pdfFile.readAsBytes(),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              pdfFile.delete();
              if (context.mounted) {
                Navigator.of(context).pop();
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              }
            },
          ),
        ],
      ),
    );
  }
}

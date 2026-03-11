import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school_data_hub_flutter/features/user/domain/batch_create_result.dart';

/// Generates a PDF with staff credentials (Kürzel, Name, E-Mail, Passwort) for printing.
class StaffCredentialsPdfService {
  StaffCredentialsPdfService._();

  static const int _credentialsPerPage = 12;

  /// Returns PDF as bytes for use with [Printing.layoutPdf] or [PdfPreview].
  static Future<List<int>> generatePdfBytes(
    List<StaffCredentialEntry> credentials,
  ) async {
    if (credentials.isEmpty) return [];
    final pdf = pw.Document();
    final totalPages = (credentials.length / _credentialsPerPage).ceil();

    for (var pageIndex = 0; pageIndex < totalPages; pageIndex++) {
      final start = pageIndex * _credentialsPerPage;
      final end = (start + _credentialsPerPage).clamp(0, credentials.length);
      final pageEntries = credentials.sublist(start, end);

      pdf.addPage(
        pw.Page(
          margin: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          build: (pw.Context context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Zugangsdaten – Benutzerimport',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                'Seite ${pageIndex + 1} von $totalPages',
                style: const pw.TextStyle(fontSize: 10),
              ),
              pw.SizedBox(height: 12),
              ...pageEntries.map(_buildCredentialCard),
            ],
          ),
        ),
      );
    }

    return pdf.save();
  }

  static pw.Widget _buildCredentialCard(StaffCredentialEntry e) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 12),
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 1),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            children: [
              pw.Text(
                'Kürzel: ',
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(e.userName, style: const pw.TextStyle(fontSize: 10)),
              pw.SizedBox(width: 16),
              pw.Text(
                'Name: ',
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  e.fullName,
                  style: const pw.TextStyle(fontSize: 10),
                  overflow: pw.TextOverflow.clip,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            'E-Mail: ${e.email}',
            style: const pw.TextStyle(fontSize: 10),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            'Passwort: ${e.password}',
            style: pw.TextStyle(
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// Generates PDF and writes to a temporary file. Caller may delete after use.
  static Future<File?> generatePdfFile(
    List<StaffCredentialEntry> credentials,
  ) async {
    final bytes = await generatePdfBytes(credentials);
    if (bytes.isEmpty) return null;
    final dir = await getTemporaryDirectory();
    final file = File(
      '${dir.path}/staff_credentials_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
    await file.writeAsBytes(bytes);
    return file;
  }
}

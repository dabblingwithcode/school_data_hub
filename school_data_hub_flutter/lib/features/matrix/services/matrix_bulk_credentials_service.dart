import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:logging/logging.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_user.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('MatrixBulkCredentialsService');

class MatrixBulkCredentialsService {
  static Future<File?> generateBulkCredentials({
    required String matrixDomain,
    required List<MatrixUser> selectedUsers,
    required bool isStaff,
    required Function(String) onProgress,
    required Function(String) onError,
  }) async {
    try {
      final matrixPolicyManager = di<MatrixPolicyManager>();
      final matrixUserManager = matrixPolicyManager.users;
      final List<Map<String, dynamic>> userCredentials = [];

      // Step 1: Reset passwords for all selected users sequentially
      for (int i = 0; i < selectedUsers.length; i++) {
        final user = selectedUsers[i];
        onProgress(
          'Passwort wird zurückgesetzt für ${user.displayName} (${i + 1}/${selectedUsers.length})',
        );

        try {
          final password = await matrixUserManager.resetPassword(user);
          if (password != null) {
            userCredentials.add({'user': user, 'password': password});
            _log.info(
              'Password reset successful for user: ${user.displayName}',
            );
          } else {
            onError(
              'Fehler beim Zurücksetzen des Passworts für ${user.displayName}',
            );
          }
        } catch (e) {
          onError(
            'Fehler beim Zurücksetzen des Passworts für ${user.displayName}: $e',
          );
          _log.severe(
            'Error resetting password for user ${user.displayName}: $e',
          );
        }
      }

      if (userCredentials.isEmpty) {
        onError('Keine Benutzer erfolgreich zurückgesetzt');
        return null;
      }

      // Step 2: Generate PDF with all credentials
      onProgress('PDF wird generiert...');
      _log.info('Starting PDF generation for ${userCredentials.length} users');

      final pdfFile = await _generateBulkCredentialsPdf(
        matrixDomain: matrixDomain,
        userCredentials: userCredentials,
        isStaff: isStaff,
      );

      if (pdfFile != null) {
        _log.info('PDF generated successfully: ${pdfFile.path}');
        onProgress('PDF erfolgreich generiert');
        return pdfFile;
      } else {
        _log.severe('PDF generation failed - returned null');
        onError('PDF-Generierung fehlgeschlagen');
        return null;
      }
    } catch (e) {
      onError('Fehler bei der Bulk-Credentials-Generierung: $e');
      _log.severe('Error in bulk credentials generation: $e');
      return null;
    }
  }

  static Future<File> _generateBulkCredentialsPdf({
    required String matrixDomain,
    required List<Map<String, dynamic>> userCredentials,
    required bool isStaff,
  }) async {
    try {
      _log.info('Loading image asset for PDF generation');
      final data = await rootBundle.load('assets/hermannpost_button.png');
      final imageBytes = data.buffer.asUint8List();
      final image = pw.MemoryImage(imageBytes);
      final pdf = pw.Document();

      final String domain = matrixDomain
          .replaceAll("https://", "")
          .replaceAll("/", "");

      _log.info(
        'Domain for PDF: $domain, Users: ${userCredentials.length}, Staff: $isStaff',
      );

      // Calculate how many pages we need
      final int credentialsPerPage = 18;
      final int totalPages = (userCredentials.length / credentialsPerPage)
          .ceil();

      _log.info(
        'Creating $totalPages pages with $credentialsPerPage credentials per page',
      );

      for (int pageIndex = 0; pageIndex < totalPages; pageIndex++) {
        final int startIndex = pageIndex * credentialsPerPage;
        final int endIndex = (startIndex + credentialsPerPage).clamp(
          0,
          userCredentials.length,
        );
        final List<Map<String, dynamic>> pageCredentials = userCredentials
            .sublist(startIndex, endIndex);

        _log.info(
          'Adding page ${pageIndex + 1} with ${pageCredentials.length} credentials',
        );

        pdf.addPage(
          pw.Page(
            margin: const pw.EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ), // Reduced horizontal margins for bigger cards
            build: (pw.Context context) => _buildCredentialsPage(
              image: image,
              pageCredentials: pageCredentials,
              domain: domain,
              isStaff: isStaff,
              pageNumber: pageIndex + 1,
              totalPages: totalPages,
            ),
          ),
        );
      }

      _log.info('Saving PDF document');
      final bytes = await pdf.save();
      _log.info('PDF saved, size: ${bytes.length} bytes');

      final file = File(
        "HP_bulk_credentials_${DateTime.now().millisecondsSinceEpoch}.pdf",
      );
      await file.writeAsBytes(bytes);

      _log.info('PDF file created at: ${file.path}');
      return file;
    } catch (e) {
      _log.severe('Error in PDF generation: $e');
      rethrow;
    }
  }

  static pw.Widget _buildCredentialsPage({
    required pw.MemoryImage image,
    required List<Map<String, dynamic>> pageCredentials,
    required String domain,
    required bool isStaff,
    required int pageNumber,
    required int totalPages,
  }) {
    return pw.Column(
      children: [
        // Header with logo and page info only
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Text(
              'Seite $pageNumber von $totalPages',
              style: const pw.TextStyle(fontSize: 10),
            ),
          ],
        ),
        pw.SizedBox(height: 5),

        // Credentials Grid (3x4 layout)
        ..._buildCredentialsGrid(
          pageCredentials: pageCredentials,
          domain: domain,
          isStaff: isStaff,
          image: image,
        ),
      ],
    );
  }

  static List<pw.Widget> _buildCredentialsGrid({
    required List<Map<String, dynamic>> pageCredentials,
    required String domain,
    required bool isStaff,
    required pw.MemoryImage image,
  }) {
    final List<pw.Widget> gridWidgets = [];

    // Create 6 rows (since 3x6 = 18 cards per page)
    for (int row = 0; row < 6; row++) {
      final List<pw.Widget> rowWidgets = [];

      // Create 3 columns
      for (int col = 0; col < 3; col++) {
        final int index = row * 3 + col;

        if (index < pageCredentials.length) {
          final credential = pageCredentials[index];
          final user = credential['user'] as MatrixUser;
          final password = credential['password'] as String;

          rowWidgets.add(
            pw.Expanded(
              child: _buildCredentialCard(
                user: user,
                password: password,
                domain: domain,
                isStaff: isStaff,
                image: image,
              ),
            ),
          );
        } else {
          // Empty space to maintain grid layout
          rowWidgets.add(pw.Expanded(child: pw.SizedBox()));
        }

        // Add spacing between columns
        if (col < 2) {
          rowWidgets.add(pw.SizedBox(width: 20));
        }
      }

      gridWidgets.add(pw.Row(children: rowWidgets));

      // Add spacing between rows
      if (row < 5) {
        gridWidgets.add(pw.SizedBox(height: 12));
      }
    }

    return gridWidgets;
  }

  static pw.Widget _buildCredentialCard({
    required MatrixUser user,
    required String password,
    required String domain,
    required bool isStaff,
    required pw.MemoryImage image,
  }) {
    // TODO: This is hardcoded, needs to be reviewed
    final String matrixId = user.id!
        .replaceAll("@", "")
        .replaceAll(":hermannschule.de", "");
    String qrPassword = password.substring(0, password.length - 4);
    String pin = password.substring(password.length - 4);
    final String qrCodeData = "$matrixId:$domain*$qrPassword";
    final String encryptedQrCodeData = customEncrypter.encryptMatrixString(
      qrCodeData,
    );

    return pw.Container(
      padding: const pw.EdgeInsets.all(4),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 1),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
      ),
      child: pw.Row(
        children: [
          // Left column with all the content
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header with icon and title (left-aligned like in existing file)
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                mainAxisSize: pw.MainAxisSize.max,
                children: [
                  pw.Image(image, width: 20, height: 20),
                  pw.SizedBox(width: 6),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Matrix-Zugangsdaten',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        'gut aufbewahren!',
                        style: pw.TextStyle(
                          fontSize: 9,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 4),
              pw.Row(
                children: [
                  pw.SizedBox(width: 2),
                  pw.Text(
                    user.displayName,
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: pw.TextOverflow.clip,
                  ),
                ],
              ),

              pw.SizedBox(height: 4),

              pw.Row(
                children: [
                  pw.SizedBox(width: 2),
                  // QR Code
                  pw.BarcodeWidget(
                    data: encryptedQrCodeData,
                    width: 52,
                    height: 52,
                    barcode: pw.Barcode.qrCode(),
                    drawText: false,
                  ),
                  pw.SizedBox(width: 25),
                  pw.Text(
                    'PIN: $pin',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  // Dotted line for safety separation
                ],
              ),
              pw.SizedBox(height: 4),

              // Creation date inside the card
              pw.Center(
                child: pw.Text(
                  'Erstellt: ${DateTime.now().formatDateForUser()}',
                  style: const pw.TextStyle(fontSize: 9),
                ),
              ),
            ],
          ),
          pw.SizedBox(width: 5),
          // TODO: This is hardcoded, needs to be reviewed
          // pw.Column(
          //   children: [
          //     pw.Container(
          //       width: 1,
          //       height: 90,
          //       decoration: const pw.BoxDecoration(
          //         border: pw.Border(left: pw.BorderSide(width: 0.5)),
          //       ),
          //     ),
          //   ],
          // ),
          // Vertical line separator
          // pw.Container(
          //   width: 1,
          //   height: 80,
          //   decoration: const pw.BoxDecoration(
          //     border: pw.Border(left: pw.BorderSide(width: 0.5)),
          //   ),
          // ),

          // PIN positioned within card boundaries

          // Right column with rotated PIN
        ],
      ),
    );
  }
}

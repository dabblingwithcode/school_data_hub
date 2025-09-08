import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:logging/logging.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_user.dart';

final _log = Logger('MatrixCredentialsPrinter');

class MatrixCredentialsPrinter {
  static Future<File> printMatrixCredentials({
    required String matrixDomain,
    required MatrixUser matrixUser,
    required String password,
    required bool isStaff,
  }) async {
    final data = await rootBundle.load('assets/hermannpost_button.png');

    final imageBytes = data.buffer.asUint8List();

    final image = pw.MemoryImage(imageBytes);

    final pdf = pw.Document();

    final String matrixId = matrixUser.id!
        .replaceAll("@", "")
        .replaceAll(":hermannschule.de", "");

    String qrPassword = password.substring(0, password.length - 4);

    String pin = password.substring(password.length - 4);

    final String domain = matrixDomain
        .replaceAll("https://", "")
        .replaceAll("/", "");
    final String qrCodeData = "$matrixId:$domain*$qrPassword";

    _log.info('QR Code Data: $qrCodeData');

    final String encryptedQrCodeData = customEncrypter.encryptMatrixString(
      qrCodeData,
    );

    pdf.addPage(
      pw.Page(
        build:
            (pw.Context context) => pw.Center(
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Image(image, width: 40, height: 40),
                            // pw.SizedBox(width: 10),
                            pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              children: [
                                pw.Text(
                                  'Hermannpost',
                                  style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.Text(
                                  'Zugangsdaten - gut aufbewahren!',
                                  style: pw.TextStyle(
                                    fontSize: 8,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          matrixUser.displayName,
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.BarcodeWidget(
                              data: encryptedQrCodeData,
                              width: 60,
                              height: 60,
                              barcode: pw.Barcode.qrCode(),
                              drawText: false,
                            ),
                            pw.SizedBox(width: 10),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceAround,
                              children: [
                                pw.Text(
                                  'PIN: $pin',
                                  style: pw.TextStyle(
                                    fontSize: 14,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(height: 32),
                                pw.Text(
                                  'Erstellt am ${DateTime.now().formatForUser()}',
                                  style: const pw.TextStyle(fontSize: 9),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (isStaff) ...[
                          pw.SizedBox(height: 10),
                          pw.Row(
                            children: [
                              pw.Text(
                                'Passwort:',
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(width: 5),
                              pw.Text(
                                password,
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  pw.Expanded(child: pw.Column(children: [])),
                ],
              ),
            ),
      ),
    );

    final file = File("HP_credentials_${matrixUser.displayName}.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}

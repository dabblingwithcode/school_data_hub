import 'dart:math' show pi;
import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;
import 'package:school_data_hub_flutter/features/matrix/users/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/models/matrix_user_relationship.dart';

/// ISO/IEC 7810 ID-1 credit card size (85.6 × 53.98 mm) in pt (72 pt per 25.4 mm).
const double _cardWidthPt = 85.6 * 72 / 25.4;
const double _cardHeightPt = 53.98 * 72 / 25.4;

/// One credential card for PDF, sized to print as a credit card.
/// Key image appears next to the QR code. Used by [MatrixCredentialsPrinter] and bulk/MultiPage flows.
class MatrixCredentialsCard {
  static pw.Widget build({
    required pw.MemoryImage logoImage,
    required MatrixUser matrixUser,
    required String qrCredentials,
    required String pin,
    required String creationDate,
    required String password,
    required MatrixUserRelationship? userRelationship,
    required ByteData userIcon,
    pw.MemoryImage? keyImage,
  }) {
    // Sizes chosen to fill credit card (≈243×153 pt) almost completely.
    const double logoSize = 34;
    const double qrSize = 56;
    const double keySize = 50;
    const double padding = 10;

    // Key rotated 90° to the right (clockwise = -π/2).
    final keyWidget = keyImage != null
        ? pw.Transform.rotate(
            angle: -pi / 2,
            child: pw.Image(keyImage, width: keySize, height: keySize),
          )
        : null;

    final qrRowChildren = <pw.Widget>[
      pw.BarcodeWidget(
        data: qrCredentials,
        width: qrSize,
        height: qrSize,
        barcode: pw.Barcode.qrCode(),
        drawText: false,
      ),
      pw.SizedBox(width: padding),
      if (keyWidget != null) ...[keyWidget, pw.SizedBox(width: padding)],
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          pw.Text(
            'Erstellt am $creationDate',
            style: const pw.TextStyle(fontSize: 8),
          ),
        ],
      ),
    ];

    final content = pw.Padding(
      padding: const pw.EdgeInsets.all(padding),
      child: pw.Column(
        mainAxisSize: pw.MainAxisSize.min,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.Image(logoImage, width: logoSize, height: logoSize),
              pw.SizedBox(width: padding),
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Hermannpost',
                    style: pw.TextStyle(
                      fontSize: 16,
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
          pw.SizedBox(height: 8),
          pw.Text(
            matrixUser.displayName,
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            maxLines: 1,
            overflow: pw.TextOverflow.clip,
          ),
          pw.SizedBox(height: 8),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisSize: pw.MainAxisSize.min,
            children: qrRowChildren,
          ),
          ...[
            pw.SizedBox(height: 10),
            pw.Row(
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Text(
                  'Passwort:',
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(width: 8),
                pw.Text(
                  password,
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: pw.TextOverflow.clip,
                ),
              ],
            ),
          ],
        ],
      ),
    );

    // PIN rotated 90° to the left (counter-clockwise = π/2), on the right end of the card.
    final rotatedPin = pw.Transform.rotate(
      angle: pi / 2,
      child: pw.Text(
        'PIN: $pin',
        style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
      ),
    );

    return pw.SizedBox(
      width: _cardWidthPt,
      height: _cardHeightPt,
      child: pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(width: 0.5),
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
        ),
        alignment: pw.Alignment.topLeft,
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            pw.Expanded(child: content),
            pw.Center(
              child: pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 6),
                child: rotatedPin,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

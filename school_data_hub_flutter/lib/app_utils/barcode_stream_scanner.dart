import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:watch_it/watch_it.dart';

class BarcodeStreamScanner extends StatefulWidget {
  const BarcodeStreamScanner({super.key});

  @override
  State<BarcodeStreamScanner> createState() => _BarcodeStreamScannerState();
}

class _BarcodeStreamScannerState extends State<BarcodeStreamScanner> {
  final MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
  );
  final _pupilIdentityManager = di<PupilIdentityManager>();

  int _counter = 0;
  final List<String> _scannedQrCodes = [];
  String _lastProcessedQrCode = '';

  Widget _buildBarcodeStream() {
    return StreamBuilder<BarcodeCapture>(
      stream: controller.barcodes,
      builder: (context, snapshot) {
        final barcodes = snapshot.data?.barcodes;

        if (barcodes == null || barcodes.isEmpty) {
          return const Center(
            child: Text(
              'Gerät während des Scanvorgangs leicht  nach vorne und hinten bewegen, damit die Codes besser erkannt werden.',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          );
        }
        final String? newQrCode = barcodes.last.rawValue;
        if (newQrCode != null) {
          if (_lastProcessedQrCode == '' || _lastProcessedQrCode != newQrCode) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                _scannedQrCodes.add(newQrCode);
                _counter++;
                _lastProcessedQrCode = newQrCode;
              });
            });
          }
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: barcodes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Gescannte codes: $_counter',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: ElevatedButton(
                      style: AppStyles.cancelButtonStyle,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "ABBRECHEN",
                        style: AppStyles.buttonTextStyle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: ElevatedButton(
                      style: AppStyles.successButtonStyle,
                      onPressed: () {
                        unawaited(
                          _pupilIdentityManager
                              .updatePupilIdentitiesFromEncryptedSource(
                                _scannedQrCodes,
                              ),
                        );

                        //  unawaited(locator<PupilManager>().fetchAllPupils());
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "SCAN BEENDEN",
                        style: AppStyles.buttonTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(
        iconData: Icons.qr_code_scanner_rounded,
        title: 'QR-Code-Stream scannen',
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            errorBuilder: (context, error) {
              return Center(
                child: Text(
                  'Error: $error',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            },
            fit: BoxFit.contain,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 150,
              color: Colors.black.withAlpha((0.4 * 255).toInt()),
              child: _buildBarcodeStream(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await controller.dispose();
  }
}

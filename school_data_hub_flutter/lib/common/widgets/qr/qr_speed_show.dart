import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:school_data_hub_flutter/theme/app_colors.dart';
import 'package:school_data_hub_flutter/theme/styles.dart';

class QrCodeSpeedShow extends StatefulWidget {
  final List<Map<String, Object>> qrMaps;

  const QrCodeSpeedShow({super.key, required this.qrMaps});

  @override
  QrCodeSpeedShowState createState() => QrCodeSpeedShowState();
}

class QrCodeSpeedShowState extends State<QrCodeSpeedShow> {
  late Timer _timer;
  int _currentIndex = -1;
  int _countdown = 5; // Set the initial countdown value
  bool _countdownFinished = false;
  int _milliseconds = 1000; // Set the initial timer interval
  bool _isLastCode = false; // Check if the last code is shown
  bool _timerRunning = true;
  late Map<String, int> _pupilNumbers;
  late Map<String, String> _qrMap;
  @override
  void initState() {
    super.initState();
    _pupilNumbers = widget.qrMaps[0] as Map<String, int>;
    _qrMap = widget.qrMaps[1] as Map<String, String>;
    startTimer(_milliseconds);
  }

  void startTimer(int milliseconds) {
    _timer = Timer.periodic(Duration(milliseconds: milliseconds), (timer) {
      setState(() {
        _countdown = _countdown > 0 ? _countdown - 1 : _countdown;
        if (_countdown == 0) {
          // Cancel the current timer

          if (_countdownFinished != true) {
            _countdownFinished = true;
            _timer.cancel();
            _milliseconds = 1100; // Set the qr carousel interval
            startTimer(_milliseconds);
          } // Start a new timer with the new interval
          if (!_isLastCode) {
            _currentIndex = (_currentIndex + 1) % _qrMap.values.length;
            if (_currentIndex == _qrMap.values.length - 1) _isLastCode = true;
          } else {
            _timer.cancel();
            _timerRunning = false;
          }
        }
        // Stop the timer when the Container is shown
        if (_currentIndex == _qrMap.length - 1) {
          _isLastCode = true;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Alle QR-Ids (Autoplay)',
            style: AppStyles.appBarTextStyle),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: _countdown > 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Die Codes erscheinen in...',
                    style: TextStyle(fontSize: 16),
                  ),
                  const Gap(20),
                  Text(
                    _countdown.toString(),
                    style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900]),
                  ),
                  const Gap(20),
                  const Text(
                    'Halten Sie Ihr Gerät in Scanmodus bereit...',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          : Center(
              child: _timerRunning == true //_currentIndex != _qrMap.length
                  ? ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Column(
                        children: [
                          const Gap(20),
                          SizedBox(
                            child: Row(
                              children: [
                                const Gap(20),
                                Text(_qrMap.keys.elementAt(_currentIndex),
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center),
                                const Spacer(),
                                Text(
                                    '${(_currentIndex + 1).toString()}/${_qrMap.entries.length}',
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center),
                                const Gap(20),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: QrImageView(
                              size: mediaQuery.size.height * 0.75,
                              data: _qrMap.values.elementAt(_currentIndex),
                              version: QrVersions.auto,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(children: [
                      const Gap(20),
                      Text(
                        '${_qrMap.entries.length} Codes wurden angezeigt!',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Gap(5),
                      const Text(
                        'Überprüfen Sie diese Zahlen:',
                        style: TextStyle(fontSize: 20),
                      ),
                      const Gap(5),
                      Text(
                        'Insgesamt: ${_pupilNumbers.values.reduce((a, b) => a + b).toString()}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Gap(10),
                      for (var key in _pupilNumbers.keys)
                        Text(
                          '$key: ${_pupilNumbers[key].toString()}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      const Gap(20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('fertig'),
                      ),
                    ]),
            ),
    );
  }
}

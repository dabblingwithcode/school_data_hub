import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:logging/logging.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('PupilIdentityStreamPage');

class PupilIdentityStreamPage extends StatefulWidget {
  final PupilIdentityStreamRole role;
  final String? encryptedData;
  final String? importedChannelName;
  final List<int>? selectedPupilIds;

  PupilIdentityStreamPage({
    Key? key,
    required this.role,
    this.encryptedData,
    this.importedChannelName,
    this.selectedPupilIds,
  }) : super(key: key);

  @override
  State<PupilIdentityStreamPage> createState() =>
      _PupilIdentityStreamPageState();
}

class _PupilIdentityStreamPageState extends State<PupilIdentityStreamPage> {
  final _client = di<Client>();
  @override
  void initState() {
    super.initState();
    if (widget.role == PupilIdentityStreamRole.sender) {
      // generate random channel name for sender
      channelName = const Uuid().v4().substring(0, 12);
    } else if (widget.importedChannelName != null) {
      // use provided channel name for receiver
      channelName = widget.importedChannelName!;
    } else {
      // fallback: generate a random channel for receiver that didn't get a channel name
      channelName = const Uuid().v4().substring(0, 12);
    }
    _setupConnection();
  }

  late final String channelName;
  bool isConnected = false;
  bool isProcessing = false;
  bool isCompleted = false;
  String statusMessage = '';
  StreamSubscription<PupilIdentityDto>? subscription;

  Future<void> _setupConnection() async {
    setState(() {
      isProcessing = true;
      statusMessage = widget.role == PupilIdentityStreamRole.sender
          ? 'Warte auf Verbindung des Empfängers...'
          : 'Verbindung zum Sender herstellen...';
    });

    try {
      // If we're a sender, we need to generate encrypted data if not provided
      String? dataToSend = widget.encryptedData;
      if (widget.role == PupilIdentityStreamRole.sender &&
          dataToSend == null &&
          widget.selectedPupilIds != null) {
        dataToSend = await di<PupilIdentityManager>()
            .generatePupilIdentitiesQrData(widget.selectedPupilIds!);
      }

      subscription =
          await di<PupilIdentityManager>().encryptedPupilIdsStreamSubscription(
        channelName: channelName,
        role: widget.role,
        encryptedPupilIds: dataToSend,
      );
      if (widget.role == PupilIdentityStreamRole.receiver) {
        _log.info('Receiver is sending request for encrypted pupil identities');
        _client.pupilIdentityStream.sendPupilIdentityMessage(
          channelName,
          PupilIdentityDto(type: 'request', value: ''),
        );
      }

      setState(() {
        isConnected = true;
        statusMessage = widget.role == PupilIdentityStreamRole.sender
            ? 'Verbunden! Warte auf Empfänger-Anfrage...'
            : 'Verbunden! Daten werden empfangen...';
      });
    } catch (e) {
      setState(() {
        statusMessage = 'Fehler bei der Verbindung: $e';
        isProcessing = false;
      });
    }
  }

  void _completeTransfer() {
    setState(() {
      isProcessing = false;
      isCompleted = true;
      statusMessage = widget.role == PupilIdentityStreamRole.sender
          ? 'Datenübertragung abgeschlossen!'
          : 'Schülerdaten wurden erfolgreich empfangen!';
    });

    subscription?.cancel();
  }

  void _cancelTransfer() {
    subscription?.cancel();
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(
        title: widget.role == PupilIdentityStreamRole.sender
            ? 'Schülerdaten senden'
            : 'Schülerdaten empfangen',
        iconData: Icons.data_exploration,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Connection code display
            Card(
              color: AppColors.backgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Verbindungscode',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Gap(8),
                    if (widget.role == PupilIdentityStreamRole.sender)
                      RepaintBoundary(
                        child: QrImageView(
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.white,
                          data: channelName,
                          version: QrVersions.auto,
                        ),
                      ),
                    Text(
                      channelName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Gap(16),
                    if (widget.role == PupilIdentityStreamRole.sender)
                      Text(
                        'Teile diesen Code mit dem ${widget.role == PupilIdentityStreamRole.sender ? 'Empfänger' : 'Sender'}',
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            ),

            const Gap(1),

            // Status indicators
            _buildStatusIndicator(
              'Verbindung',
              isConnected,
            ),
            _buildStatusIndicator(
              'Datenübertragung',
              isProcessing && isConnected,
            ),
            _buildStatusIndicator(
              'Abgeschlossen',
              isCompleted,
            ),

            const Gap(32),

            // Status message
            Text(
              statusMessage,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const Gap(32),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _cancelTransfer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Abbrechen',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    debugger();
                    await _client.pupilIdentityStream.sendPupilIdentityMessage(
                      channelName,
                      PupilIdentityDto(type: 'request', value: ''),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Anfordern',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                if (isCompleted)
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentColor,
                    ),
                    child: const Text(
                      'Fertig',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(String label, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? AppColors.accentColor : Colors.grey.shade300,
            ),
            child: isActive
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : null,
          ),
          const Gap(16),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: isActive ? AppColors.accentColor : Colors.black54,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:logging/logging.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('PupilIdentityStreamPage');

class PupilIdentityStreamPage extends WatchingWidget {
  final _notificationService = di<NotificationService>();
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

  final _client = di<Client>();

  late final String channelName;

  @override
  Widget build(BuildContext context) {
    StreamSubscription<PupilIdentityDto>? _encryptedPupilIdsSubscription;

    final isConnected =
        createOnce<ValueNotifier<bool>>(() => ValueNotifier(false));

    final isProcessing =
        createOnce<ValueNotifier<bool>>(() => ValueNotifier(false));

    final isCompleted =
        createOnce<ValueNotifier<bool>>(() => ValueNotifier(false));

    final statusMessage =
        createOnce<ValueNotifier<String>>(() => ValueNotifier(''));

    void _completeTransfer() {
      isProcessing.value = false;
      isCompleted.value = true;
      statusMessage.value = role == PupilIdentityStreamRole.sender
          ? 'Datenübertragung abgeschlossen!'
          : 'Schülerdaten wurden erfolgreich empfangen!';

      _encryptedPupilIdsSubscription?.cancel();
    }

    Future<void> _setupConnection() async {
      isProcessing.value = true;
      statusMessage.value = role == PupilIdentityStreamRole.sender
          ? 'Warte auf Verbindung des Empfängers...'
          : 'Verbindung zum Sender herstellen...';

      try {
        // If we're a sender, we need to generate encrypted data if not provided
        String? dataToSend = encryptedData;
        if (role == PupilIdentityStreamRole.sender &&
            dataToSend == null &&
            selectedPupilIds != null) {
          dataToSend = await di<PupilIdentityManager>()
              .generatePupilIdentitiesQrData(selectedPupilIds!);
        }

        _encryptedPupilIdsSubscription = await di<PupilIdentityManager>()
            .encryptedPupilIdsStreamSubscription(
          channelName: channelName,
          role: role,
          encryptedPupilIds: dataToSend,
          onConnected: () {
            isConnected.value = true;
            if (role == PupilIdentityStreamRole.sender) {
              statusMessage.value = 'Verbunden! Warte auf Empfänger...';
            } else {
              statusMessage.value = 'Verbunden! Sende Anfrage...';
            }
            _log.info(
                'Connection established for channel: $channelName with role: $role');
          },
          onStatusUpdate: (message) {
            statusMessage.value = message;
            _log.info('Status update: $message');
          },
          onCompleted: () {
            isCompleted.value = true;
            isProcessing.value = false;
            statusMessage.value = role == PupilIdentityStreamRole.sender
                ? 'Datenübertragung abgeschlossen!'
                : 'Schülerdaten wurden erfolgreich empfangen!';
            _log.info(
              'Data transfer completed for channel: $channelName with role: $role',
            );
          },
        );

        if (role == PupilIdentityStreamRole.receiver) {
          _log.info(
              'Receiver is sending request for encrypted pupil identities');
          _client.pupilIdentityStream.sendPupilIdentityMessage(
            channelName,
            PupilIdentityDto(
                type: 'request',
                value:
                    'TEST ${di<HubSessionManager>().user!.userInfo!.userName!}'),
          );
        }

        statusMessage.value = role == PupilIdentityStreamRole.sender
            ? 'Verbunden! Warte auf Empfänger-Anfrage...'
            : 'Verbunden! Daten werden empfangen...';
      } catch (e) {
        statusMessage.value = 'Fehler bei der Verbindung: ${e.toString()}';
      }
    }

    callOnce((context) {
      if (role == PupilIdentityStreamRole.sender) {
        // generate random channel name for sender
        channelName = const Uuid().v4().substring(0, 12);
      } else if (importedChannelName != null) {
        // use provided channel name for receiver
        channelName = importedChannelName!;
      } else {
        _notificationService.showInformationDialog(
          '''Etwas hat mit dem Übertragungskanal nicht funktioniert.
          
          Bitte die Seite verlassen und es erneut versuchen.''',
        );
        return;
      }
      _setupConnection();
    }, dispose: () {
      _encryptedPupilIdsSubscription?.cancel();
    });

    void _cancelTransfer() {
      _encryptedPupilIdsSubscription?.cancel();
      Navigator.of(context).pop();
    }

    final isConnectedValue = watch(isConnected).value;
    final isProcessingValue = watch(isProcessing).value;
    final isCompletedValue = watch(isCompleted).value;
    final statusMessageValue = watch(statusMessage).value;

    return Scaffold(
      appBar: GenericAppBar(
        title: role == PupilIdentityStreamRole.sender
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
                    if (role == PupilIdentityStreamRole.sender)
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
                    if (role == PupilIdentityStreamRole.sender)
                      Text(
                        'Teile diesen Code mit dem ${role == PupilIdentityStreamRole.sender ? 'Empfänger' : 'Sender'}',
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
            _statusIndicators(
              'Verbindung',
              isConnectedValue,
            ),
            _statusIndicators(
              'Datenübertragung',
              isProcessingValue && isConnectedValue,
            ),
            _statusIndicators(
              'Abgeschlossen',
              isCompletedValue,
            ),

            const Gap(32),

            // Status message
            Text(
              statusMessageValue,
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
                if (isCompleted.value)
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

  Widget _statusIndicators(String label, bool isActive) {
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

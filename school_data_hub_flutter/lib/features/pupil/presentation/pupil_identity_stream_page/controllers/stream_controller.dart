import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_identity_stream_page/models/stream_state.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_identity_stream_page/utils/stream_utils.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('StreamController');
final _notificationService = di<NotificationService>();

class PupilIdentityStreamController {
  final PupilIdentityStreamRole role;
  final String? encryptedData;
  final List<int>? selectedPupilIds;
  final String? importedChannelName;
  late String channelName;

  // Controller creates and owns the state
  late final PupilIdentityStreamState state;
  StreamSubscription<PupilIdentityDto>? _subscription;

  Timer? _rejectionTimer;

  // Callbacks for UI interactions
  final Function(String userName) onConfirmationRequired;
  final Function(int totalCount, int newCount) onTransferCompleted;
  final Function(bool wasAutoRejected) onRejectionReceived;
  final Function()? onSenderShutdown;

  PupilIdentityStreamController({
    required this.role,
    this.encryptedData,
    this.selectedPupilIds,
    this.importedChannelName,
    required this.onConfirmationRequired,
    required this.onTransferCompleted,
    required this.onRejectionReceived,
    this.onSenderShutdown,
  }) {
    // Controller creates and owns the state
    state = PupilIdentityStreamState();
    channelName = importedChannelName ?? StreamUtils.generateConnectionCode();

    // Auto-start the connection when controller is created if we have an imported channel name
    if (importedChannelName != null &&
        role == PupilIdentityStreamRole.receiver) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        setupConnection();
      });
    } else if (role == PupilIdentityStreamRole.sender) {
      // Auto-start sender connection
      SchedulerBinding.instance.addPostFrameCallback((_) {
        setupConnection();
      });
    }
  }

  /// Complete a transfer and update state
  void completeTransfer() {
    state.streamState.isProcessing.value = false;
    state.streamState.isCompleted.value = true;
    state.streamState.isTransmitting.value = false;
    _notificationService.setHeavyLoadingValue(false);

    // For sender, record the successful transfer
    if (role == PupilIdentityStreamRole.sender &&
        state.streamState.receiverUserName.value.isNotEmpty) {
      state.transferState.transferCounter.value += 1;
      // TODO: here we must use a datetime sent by the sender
      final now = DateTime.now();
      final dateStr =
          '${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
      state.transferState.transferHistory.value = [
        '${state.streamState.receiverUserName.value} - $dateStr',
        ...state.transferState.transferHistory.value,
      ];

      // Remove from active transfers
      final updatedActiveTransfers = Set<String>.from(
        state.receiverState.activeTransfers.value,
      );
      updatedActiveTransfers.remove(state.streamState.receiverUserName.value);
      state.receiverState.activeTransfers.value = updatedActiveTransfers;
    }

    state.streamState.statusMessage.value =
        role == PupilIdentityStreamRole.sender
        ? 'Datenübertragung abgeschlossen!'
        : 'Schülerdaten wurden erfolgreich empfangen!';

    // Only cancel subscription for receiver, sender should stay connected
    if (role == PupilIdentityStreamRole.receiver) {
      _subscription?.cancel();
    }
  }

  /// Reset sender state for new requests
  void resetSenderForNewRequest() {
    if (role == PupilIdentityStreamRole.sender) {
      state.streamState.receiverJoined.value = false;
      state.streamState.receiverUserName.value = '';
      state.streamState.requestReceived.value = false;
      state.streamState.isTransmitting.value = false;
      _notificationService.setHeavyLoadingValue(false);
      state.streamState.isCompleted.value = false;
      state.streamState.statusMessage.value =
          'Bereit für neue Übertragung. Warte auf Empfänger...';
    }
  }

  /// Handle confirmation of a user request
  Future<void> confirmUserRequest(String userName) async {
    // Add to active transfers and remove from pending requests
    state.receiverState.activeTransfers.value = {
      ...state.receiverState.activeTransfers.value,
      userName,
    };
    final updatedPendingRequests = Map<String, DateTime>.from(
      state.receiverState.pendingRequests.value,
    );
    updatedPendingRequests.remove(userName);
    state.receiverState.pendingRequests.value = updatedPendingRequests;

    // Send confirmation to specific receiver
    await di<Client>().pupilIdentity.sendPupilIdentityMessage(
      channelName,
      PupilIdentityDto(type: 'confirmed', value: userName),
    );
  }

  /// Handle rejection of a user request
  Future<void> rejectUserRequest(String userName) async {
    // Add to rejected users list
    state.receiverState.rejectedUsers.value = {
      ...state.receiverState.rejectedUsers.value,
      userName,
    };

    // Remove from pending requests and connected receivers
    final updatedPendingRequests = Map<String, DateTime>.from(
      state.receiverState.pendingRequests.value,
    );
    updatedPendingRequests.remove(userName);
    state.receiverState.pendingRequests.value = updatedPendingRequests;

    final updatedConnectedReceivers = Set<String>.from(
      state.receiverState.connectedReceivers.value,
    );
    updatedConnectedReceivers.remove(userName);
    state.receiverState.connectedReceivers.value = updatedConnectedReceivers;

    // Send rejection message to specific receiver
    await _sendRejectionMessage(userName, isAutoRejection: false);
  }

  /// Clear rejected users list
  void clearRejectedUsers() {
    state.receiverState.rejectedUsers.value = {};
  }

  /// Send rejection message with retry logic for reliability
  Future<void> _sendRejectionMessage(
    String userName, {
    bool isAutoRejection = false,
  }) async {
    final rejectionValue = isAutoRejection ? 'auto:$userName' : userName;
    int retryCount = 0;
    const maxRetries = 3;
    const retryDelay = Duration(milliseconds: 100);

    while (retryCount < maxRetries) {
      try {
        _log.info(
          'Sending rejection message to $userName (attempt ${retryCount + 1})',
        );
        await di<Client>().pupilIdentity.sendPupilIdentityMessage(
          channelName,
          PupilIdentityDto(type: 'rejected', value: rejectionValue),
        );
        _log.info('Rejection message sent successfully to $userName');
        return; // Success, exit retry loop
      } catch (e) {
        retryCount++;
        _log.warning(
          'Failed to send rejection message to $userName (attempt $retryCount): $e',
        );

        if (retryCount < maxRetries) {
          await Future.delayed(retryDelay);
        } else {
          _log.severe(
            'Failed to send rejection message to $userName after $maxRetries attempts',
          );
        }
      }
    }
  }

  /// Setup the stream connection
  Future<void> setupConnection() async {
    _log.info('Setting up connection for role: $role, channel: $channelName');
    state.streamState.isProcessing.value = true;
    state.streamState.statusMessage.value =
        role == PupilIdentityStreamRole.sender
        ? 'Warte auf Verbindung des Empfängers...'
        : 'Verbindung zum Sender herstellen...';

    try {
      // If we're a sender, we need to generate encrypted data if not provided
      String? dataToSend = encryptedData;
      if (role == PupilIdentityStreamRole.sender &&
          dataToSend == null &&
          selectedPupilIds != null) {
        _log.info(
          'Generating encrypted data for ${selectedPupilIds!.length} pupils',
        );
        dataToSend = await di<PupilIdentityManager>()
            .generatePupilIdentitiesQrData(selectedPupilIds!);
      }

      _log.info('Creating stream subscription...');
      _subscription = await di<PupilIdentityManager>()
          .encryptedPupilIdsStreamSubscription(
            channelName: channelName,
            role: role,
            encryptedPupilIds: dataToSend,
            onConnected: () => _handleConnected(),
            onStatusUpdate: (message) => _handleStatusUpdate(message),
            onCompleted: () => _handleCompleted(),
            onReceiverJoined: (userName) => _handleReceiverJoined(userName),
            onReceiverLeft: (userName) => _handleReceiverLeft(userName),
            onRequestReceived: (userName) => _handleRequestReceived(userName),
            onRequestConfirmed: () => _handleRequestConfirmed(),
            onRequestRejected: (wasAutoRejected) =>
                _handleRequestRejected(wasAutoRejected),
            onDataReceived: (newCount, totalCount) =>
                _handleDataReceived(newCount, totalCount),
            onShouldPopPage: () => _handleShouldPopPage(),
            onSenderShutdown: (message) => _handleSenderShutdown(message),
          );
    } catch (e) {
      state.streamState.statusMessage.value =
          'Fehler bei der Verbindung: ${e.toString()}';
    }
  }

  /// Handle connection established
  void _handleConnected() {
    _log.info('onConnected callback triggered for role: $role');
    state.streamState.isConnected.value = true;
    if (role == PupilIdentityStreamRole.sender) {
      state.streamState.statusMessage.value =
          'Verbunden! Warte auf Empfänger...';
    } else {
      state.streamState.statusMessage.value =
          'Verbunden! Sende Beitritts-Information und Datenanfrage...';
      // Receiver automatically sends joined message AND request when connected
      _sendReceiverMessages();
    }
    _log.info(
      'Connection established for channel: $channelName with role: $role',
    );
  }

  /// Send receiver join and request messages
  void _sendReceiverMessages() {
    _log.info('Receiver sending joined message and data request...');

    // First send joined message
    di<Client>().pupilIdentity
        .sendPupilIdentityMessage(
          channelName,
          PupilIdentityDto(
            type: 'joined',
            value: di<HubSessionManager>().user!.userInfo!.userName!,
          ),
        )
        .then((_) {
          _log.info(
            'Joined message sent successfully, waiting before sending request...',
          );
          // Wait a bit longer to allow for auto-rejection to be processed
          return Future.delayed(const Duration(milliseconds: 300));
        })
        .then((_) {
          // Check if we're still connected (might have been auto-rejected)
          if (!state.streamState.isConnected.value) {
            _log.info(
              'Connection lost (likely auto-rejected), not sending request',
            );
            return Future<void>.value();
          }

          _log.info('Sending data request...');
          // Send data request
          return di<Client>().pupilIdentity.sendPupilIdentityMessage(
            channelName,
            PupilIdentityDto(
              type: 'request',
              value: di<HubSessionManager>().user!.userInfo!.userName!,
            ),
          );
        })
        .then((_) {
          if (state.streamState.isConnected.value) {
            _log.info('Data request sent successfully');
            state.streamState.requestSent.value = true;
            state.streamState.statusMessage.value =
                'Datenanfrage gesendet. Warte auf Bestätigung...';

            // Start a timeout to detect if we're being ignored (possibly banned)
            _startRejectionTimeout();
          }
        })
        .catchError((error) {
          _log.severe('Error in receiver flow: $error');
          if (state.streamState.isConnected.value) {
            state.streamState.statusMessage.value =
                'Fehler beim Senden: $error';
          }
        });
  }

  /// Start a timeout to detect if receiver is being ignored (possibly banned)
  void _startRejectionTimeout() {
    _rejectionTimer?.cancel(); // Cancel any existing timer
    _rejectionTimer = Timer(const Duration(seconds: 10), () {
      // If we haven't received any response after 10 seconds, assume we might be banned
      if (state.streamState.isConnected.value &&
          state.streamState.requestSent.value &&
          !state.streamState.isTransmitting.value) {
        _log.warning(
          'No response received within timeout, connection might be rejected silently',
        );
        state.streamState.statusMessage.value =
            'Keine Antwort vom Sender. Möglicherweise wurden Sie abgelehnt.';

        // Optionally trigger rejection handling
        // _handleRequestRejected(true); // Assume auto-rejection due to timeout
      }
    });
  }

  /// Handle status updates
  void _handleStatusUpdate(String message) {
    state.streamState.statusMessage.value = message;
    _log.info('Status update: $message');
  }

  /// Handle transfer completion
  void _handleCompleted() {
    completeTransfer();
    // Reset sender for new requests after a short delay
    if (role == PupilIdentityStreamRole.sender) {
      Future.delayed(const Duration(seconds: 3), () {
        resetSenderForNewRequest();
      });
    }
    _log.info(
      'Data transfer completed for channel: $channelName with role: $role',
    );
  }

  /// Handle receiver joined
  void _handleReceiverJoined(String userName) {
    _log.info('onReceiverJoined callback triggered with userName: $userName');

    // Check if user was previously rejected
    if (state.receiverState.rejectedUsers.value.contains(userName)) {
      _log.info('User $userName was previously rejected, auto-rejecting');
      // Send auto-rejection message immediately, with retries for reliability
      _sendRejectionMessage(userName, isAutoRejection: true);
      return;
    }

    // Add to connected receivers
    state.receiverState.connectedReceivers.value = {
      ...state.receiverState.connectedReceivers.value,
      userName,
    };

    state.streamState.receiverJoined.value = true;
    state.streamState.receiverUserName.value = userName;
    state.streamState.statusMessage.value =
        'Empfänger $userName ist beigetreten! Warte auf Datenanfrage...';
  }

  /// Handle receiver left
  void _handleReceiverLeft(String userName) {
    _log.info('Receiver $userName left the stream');

    // Remove from connected receivers
    final updatedConnectedReceivers = Set<String>.from(
      state.receiverState.connectedReceivers.value,
    );
    updatedConnectedReceivers.remove(userName);
    state.receiverState.connectedReceivers.value = updatedConnectedReceivers;

    // Remove from pending requests if any
    final updatedPendingRequests = Map<String, DateTime>.from(
      state.receiverState.pendingRequests.value,
    );
    updatedPendingRequests.remove(userName);
    state.receiverState.pendingRequests.value = updatedPendingRequests;

    // Remove from active transfers if any
    final updatedActiveTransfers = Set<String>.from(
      state.receiverState.activeTransfers.value,
    );
    updatedActiveTransfers.remove(userName);
    state.receiverState.activeTransfers.value = updatedActiveTransfers;

    // Update status message and reset completion state if needed
    if (updatedConnectedReceivers.isEmpty) {
      // No receivers left - reset to standby state
      resetSenderForNewRequest();
      _log.info('Reset to standby state - no receivers connected');
    } else {
      // Other receivers still connected
      state.streamState.statusMessage.value =
          'Empfänger $userName hat die Verbindung beendet. ${updatedConnectedReceivers.length} Empfänger verbunden.';
    }
  }

  /// Handle request received
  void _handleRequestReceived(String userName) {
    // Check if user was previously rejected
    if (state.receiverState.rejectedUsers.value.contains(userName)) {
      _log.info(
        'User $userName was previously rejected, auto-rejecting request',
      );
      // Send auto-rejection message with retry logic
      _sendRejectionMessage(userName, isAutoRejection: true);
      return;
    }

    // Add to pending requests with timestamp
    final updatedPendingRequests = Map<String, DateTime>.from(
      state.receiverState.pendingRequests.value,
    );
    updatedPendingRequests[userName] = DateTime.now();
    state.receiverState.pendingRequests.value = updatedPendingRequests;

    state.streamState.requestReceived.value = true;

    // Auto-confirm if enabled
    if (state.streamState.autoConfirmEnabled.value) {
      _log.info(
        'Auto-confirm enabled, automatically confirming transfer for $userName',
      );
      confirmUserRequest(userName);
    } else {
      onConfirmationRequired.call(userName);
    }
  }

  /// Handle request confirmed
  void _handleRequestConfirmed() {
    _rejectionTimer?.cancel(); // Cancel timeout since we got a response
    state.streamState.isTransmitting.value = true;
    _notificationService.setHeavyLoadingValue(true);
    state.streamState.statusMessage.value =
        'Bestätigung erhalten. Sende Daten...';
  }

  /// Handle request rejected
  void _handleRequestRejected(bool wasAutoRejected) {
    _rejectionTimer?.cancel(); // Cancel timeout since we got a response
    // For receiver - update connection state and show rejection dialog
    state.streamState.isConnected.value = false;
    state.streamState.isProcessing.value = false;
    onRejectionReceived.call(wasAutoRejected);
  }

  /// Handle data received
  void _handleDataReceived(int newCount, int totalCount) {
    // Show success dialog for receiver
    onTransferCompleted.call(totalCount, newCount);
  }

  /// Handle should pop page
  void _handleShouldPopPage() {
    // This callback is now handled by the success dialog
    // The dialog will close both itself and the page
  }

  void _handleSenderShutdown(String message) {
    _log.info('Sender shutdown received: $message');
    // Call the callback to notify the UI
    onSenderShutdown?.call();
  }

  /// Cancel transfer and cleanup
  void cancelTransfer() {
    _subscription?.cancel();
  }

  /// Dispose resources
  void dispose() {
    // Cancel the rejection timeout timer
    _rejectionTimer?.cancel();

    // If receiver is leaving, send close message before disposing
    if (role == PupilIdentityStreamRole.receiver &&
        state.streamState.isConnected.value) {
      // We do NOT send a close message here because it causes the sender to think
      // the receiver left intentionally, while we might just be navigating away
      // or the widget is being rebuilt. The sender handles disconnects gracefully.
      // If we really want to signal "leaving", we should do it in stopStream()
      // which is called on explicit exit actions.
    }

    _subscription?.cancel();
    state.dispose(); // Controller owns and disposes the state
  }

  // Additional methods needed by the UI
  void startStream() {
    // Initialize stream connection for both sender and receiver
    setupConnection();
  }

  void stopStream() async {
    // If sender is shutting down, notify all receivers
    if (role == PupilIdentityStreamRole.sender &&
        state.streamState.isConnected.value) {
      try {
        // Send shutdown message to all connected receivers
        await di<Client>().pupilIdentity.sendPupilIdentityMessage(
          channelName,
          PupilIdentityDto(
            type: 'shutdown',
            value: 'Sender hat den Stream beendet',
          ),
        );
        _log.info('Sent shutdown message to all receivers');

        // Wait a brief moment to ensure message is sent
        await Future.delayed(const Duration(milliseconds: 200));
      } catch (e) {
        _log.warning('Failed to send shutdown message: $e');
      }
    }

    // If receiver is leaving, send close message to notify sender
    if (role == PupilIdentityStreamRole.receiver &&
        state.streamState.isConnected.value) {
      try {
        await di<Client>().pupilIdentity.sendPupilIdentityMessage(
          channelName,
          PupilIdentityDto(
            type: 'close',
            value:
                di<HubSessionManager>().user?.userInfo?.userName ?? 'Unknown',
          ),
        );
        _log.info('Sent close message to sender before leaving');
      } catch (e) {
        _log.warning('Failed to send close message: $e');
      }
    }

    _rejectionTimer?.cancel();
    _subscription?.cancel();
    // state.streamState.isConnected.value = false;
    //state.streamState.isProcessing.value = false;
  }

  void setChannelName(String newChannelName) {
    channelName = newChannelName;
  }

  void confirmTransfer(String receiverName) {
    // Use the existing confirmUserRequest method
    confirmUserRequest(receiverName);
  }

  void rejectTransfer(String receiverName) {
    // Use the existing rejectUserRequest method
    rejectUserRequest(receiverName);
  }

  /// Set auto-confirm enabled state
  void setAutoConfirmEnabled(bool enabled) {
    state.streamState.autoConfirmEnabled.value = enabled;
  }
}

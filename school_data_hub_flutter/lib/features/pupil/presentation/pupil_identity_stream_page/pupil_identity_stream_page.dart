import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/enums.dart';
import 'package:signals/signals_flutter.dart';
import 'package:watch_it/watch_it.dart';

import 'controllers/stream_controller.dart';
// Import our modular components
import 'models/stream_state.dart';
import 'utils/stream_utils.dart';
import 'widgets/action_buttons.dart';
import 'widgets/connection_code_display.dart';
import 'widgets/dialogs/rejection_dialog.dart';
import 'widgets/dialogs/success_dialog.dart';
import 'widgets/receiver_card.dart';
import 'widgets/rejected_requests.dart';
import 'widgets/status_indicators/connection_status.dart';
import 'widgets/transfer_history.dart';

OverlayEntry? _receiverStatusOverlay;

class PupilIdentityStreamPage extends WatchingWidget {
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
  Widget build(BuildContext context) {
    // Initialize controller (which creates and owns the state)
    final controller = createOnce<PupilIdentityStreamController>(() {
      final ctrl = PupilIdentityStreamController(
        role: role,
        encryptedData: encryptedData,
        importedChannelName: importedChannelName,
        selectedPupilIds: selectedPupilIds,
        onConfirmationRequired: (receiverName) {
          // No dialog needed - confirmation is handled directly in ReceiverCard buttons
          // This callback is now just for logging/tracking purposes
        },
        onTransferCompleted: (totalPupils, newPupils) {
          _hideReceiverStatusOverlay();
          _showSuccessDialog(context, totalPupils, newPupils);
        },
        onRejectionReceived: (wasAutoRejected) {
          _hideReceiverStatusOverlay();
          _showRejectionDialog(context, wasAutoRejected: wasAutoRejected);
        },
        onSenderShutdown: () => _handleSenderShutdown(context),
      );
      return ctrl;
    }, dispose: (controller) => controller.dispose());

    final state = controller.state;

    final isConnected = state.streamState.isConnected.watch(context);
    final isProcessing = state.streamState.isProcessing.watch(context);
    final receivers = state.receiverState.connectedReceivers.watch(context);
    final pendingRequests = state.receiverState.pendingRequests.watch(context);
    final activeTransfers = state.receiverState.activeTransfers.watch(context);
    final transferHistory = state.transferState.transferHistory.watch(context);
    final transferCounter = state.transferState.transferCounter.watch(context);
    final rejectedUsers = state.receiverState.rejectedUsers.watch(context);
    final receiverJoined = state.streamState.receiverJoined.watch(context);
    final requestSent = state.streamState.requestSent.watch(context);
    final isTransmitting = state.streamState.isTransmitting.watch(context);
    final autoConfirmEnabled = state.streamState.autoConfirmEnabled.watch(
      context,
    );

    // Update overlay when receiver-related signals change
    if (role == PupilIdentityStreamRole.receiver) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateReceiverOverlay(
          context,
          controller,
          receiverJoined,
          requestSent,
          isTransmitting,
        );
      });
    }

    return Scaffold(
      appBar: const GenericAppBar(
        iconData: Icons.people,
        title: 'Schülerdaten-Übertragung',
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Connection Status
                        ConnectionStatus(
                          isConnected: isConnected,
                          isProcessing: isProcessing,
                          statusMessage: state.streamState.statusMessage.value,
                        ),
                        const Gap(16),
                        if (role == PupilIdentityStreamRole.sender) ...[
                          _buildSenderTopSection(
                            context,
                            state,
                            controller,
                            isConnected,
                            autoConfirmEnabled,
                          ),
                          const Gap(16),
                          _buildSenderScrollableContent(
                            context,
                            state,
                            controller,
                            receivers,
                            pendingRequests,
                            activeTransfers,
                            transferHistory,
                            transferCounter,
                            rejectedUsers,
                          ),
                        ] else ...[
                          _buildReceiverScrollableContent(
                            context,
                            state,
                            controller,
                            receiverJoined,
                            requestSent,
                            isTransmitting,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const Gap(16),
                // Action Buttons stay visible
                _buildActionButtons(
                  context,
                  state,
                  controller,
                  isConnected,
                  activeTransfers,
                  isProcessing,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSenderTopSection(
    BuildContext context,
    PupilIdentityStreamState state,
    PupilIdentityStreamController controller,
    bool isConnected,
    bool autoConfirmEnabled,
  ) {
    if (!isConnected) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        ConnectionCodeDisplay(
          channelName: controller.channelName,
          description: 'Teilen Sie diesen Code mit dem Empfänger',
        ),
        const Gap(16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Checkbox(
                  value: autoConfirmEnabled,
                  onChanged: (value) {
                    controller.setAutoConfirmEnabled(value ?? false);
                  },
                ),
                const Expanded(
                  child: Text(
                    'Übertragungen automatisch bestätigen',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSenderScrollableContent(
    BuildContext context,
    PupilIdentityStreamState state,
    PupilIdentityStreamController controller,
    Set<String> receivers,
    Map<String, DateTime> pendingRequests,
    Set<String> activeTransfers,
    List<String> transferHistory,
    int transferCounter,
    Set<String> rejectedUsers,
  ) {
    return Column(
      children: [
        // Connected Receivers Management
        _buildReceiversSection(
          context,
          receivers,
          pendingRequests,
          activeTransfers,
          controller,
        ),

        // Transfer History
        TransferHistoryWidget(
          transferHistory: transferHistory,
          transferCounter: transferCounter,
        ),

        const Gap(16),

        // Rejected Requests
        RejectedRequestsWidget(
          rejectedUsers: rejectedUsers,
          onClearRejected: rejectedUsers.isNotEmpty
              ? () => controller.clearRejectedUsers()
              : null,
        ),
      ],
    );
  }

  Widget _buildReceiverScrollableContent(
    BuildContext context,
    PupilIdentityStreamState state,
    PupilIdentityStreamController controller,
    bool joined,
    bool requestSent,
    bool isTransmitting,
  ) {
    // Overlay management is now handled by registerHandler calls
    return const Column(
      children: [
        // Overlay will be shown instead of inline content
      ],
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    PupilIdentityStreamState state,
    PupilIdentityStreamController controller,
    bool isConnected,
    Set<String> activeTransfers,
    bool isProcessing,
  ) {
    return StreamActionButtons(
      isConnected: isConnected,
      hasActiveTransfers: activeTransfers.isNotEmpty,
      isProcessing: isProcessing,
      onStartStream: role == PupilIdentityStreamRole.sender
          ? () => controller.startStream()
          : () => _showConnectionDialog(context, controller),
      onStopStream: () {
        controller.stopStream();
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildReceiversSection(
    BuildContext context,
    Set<String> receivers,
    Map<String, DateTime> pendingRequests,
    Set<String> activeTransfers,
    PupilIdentityStreamController controller,
  ) {
    if (receivers.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Warten auf Empfänger...',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verbundene Empfänger (${receivers.length})',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Gap(8),
        ...receivers.map((receiverName) {
          ReceiverStatus status;
          if (activeTransfers.contains(receiverName)) {
            status = ReceiverStatus.transferring;
          } else if (pendingRequests.containsKey(receiverName)) {
            status = ReceiverStatus.requested;
          } else {
            status = ReceiverStatus.confirmed;
          }

          // TODO: switch to override confirmation
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ReceiverCard(
              receiverName: receiverName,
              status: status,
              isAnyTransferInProgress: activeTransfers.isNotEmpty,
              onConfirm: status == ReceiverStatus.requested
                  ? () => controller.confirmTransfer(receiverName)
                  : null,
              onReject: status == ReceiverStatus.requested
                  ? () => controller.rejectTransfer(receiverName)
                  : null,
            ),
          );
        }).toList(),
      ],
    );
  }

  void _updateReceiverOverlay(
    BuildContext context,
    PupilIdentityStreamController controller,
    bool joined,
    bool requestSent,
    bool isTransmitting,
  ) {
    if (joined || requestSent || isTransmitting) {
      _showReceiverStatusOverlay(
        context,
        controller,
        joined,
        requestSent,
        isTransmitting,
      );
    } else {
      _hideReceiverStatusOverlay();
    }
  }

  void _showReceiverStatusOverlay(
    BuildContext context,
    PupilIdentityStreamController controller,
    bool joined,
    bool requestSent,
    bool isTransmitting,
  ) {
    if (_receiverStatusOverlay != null) {
      return; // Overlay is already shown
    }

    _receiverStatusOverlay = OverlayEntry(
      builder: (context) => Material(
        color: Colors.black54,
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(20),
            child: Container(
              width: 350,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isTransmitting)
                    const Column(
                      children: [
                        CircularProgressIndicator(),
                        Gap(16),
                        Text(
                          'Daten werden übertragen...',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(8),
                        Text(
                          'Bitte warten Sie, bis die Übertragung abgeschlossen ist.',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  else if (joined)
                    const Column(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 48),
                        Gap(16),
                        Text(
                          'Mit Sender verbunden',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(8),
                        Text(
                          'Warten auf Datenübertragung vom Sender.',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  else if (requestSent)
                    const Column(
                      children: [
                        CircularProgressIndicator(),
                        Gap(16),
                        Text(
                          'Anfrage gesendet',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(8),
                        Text(
                          'Warten auf Bestätigung vom Sender.',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  const Gap(20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.stopStream();
                        _hideReceiverStatusOverlay();
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Stream beenden'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_receiverStatusOverlay!);
  }

  void _hideReceiverStatusOverlay() {
    _receiverStatusOverlay?.remove();
    _receiverStatusOverlay = null;
  }

  // Dialog Methods
  Future<void> _showSuccessDialog(
    BuildContext context,
    int totalPupils,
    int newPupils,
  ) async {
    await SuccessDialog.show(context, newPupils, totalPupils);
  }

  Future<void> _showRejectionDialog(
    BuildContext context, {
    bool wasAutoRejected = false,
  }) async {
    await RejectionDialog.show(context, wasAutoRejected: wasAutoRejected);
  }

  Future<void> _handleSenderShutdown(BuildContext context) async {
    _hideReceiverStatusOverlay();
    await _showSenderShutdownDialog(context);
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  Future<void> _showSenderShutdownDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.info, color: Colors.orange),
              SizedBox(width: 8),
              Text('Stream beendet'),
            ],
          ),
          content: const Text(
            'Der Sender hat den Stream beendet. Die Verbindung wurde geschlossen.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showConnectionDialog(
    BuildContext context,
    PupilIdentityStreamController controller,
  ) async {
    // This would typically show a dialog to enter connection code
    // For now, we'll use the imported channel name or generate one
    final code = importedChannelName ?? StreamUtils.generateConnectionCode();
    controller.setChannelName(code);
    controller.startStream();
  }
}

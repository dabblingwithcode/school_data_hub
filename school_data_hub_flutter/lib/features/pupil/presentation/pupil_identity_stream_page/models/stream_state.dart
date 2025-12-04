import 'package:flutter/foundation.dart';

/// Model representing the state of the pupil identity stream
class StreamState {
  final ValueNotifier<bool> isConnected;
  final ValueNotifier<bool> isProcessing;
  final ValueNotifier<bool> isCompleted;
  final ValueNotifier<String> statusMessage;
  final ValueNotifier<bool> receiverJoined;
  final ValueNotifier<String> receiverUserName;
  final ValueNotifier<bool> requestReceived;
  final ValueNotifier<bool> requestSent;
  final ValueNotifier<bool> isTransmitting;
  final ValueNotifier<bool> autoConfirmEnabled;

  StreamState()
    : isConnected = ValueNotifier(false),
      isProcessing = ValueNotifier(false),
      isCompleted = ValueNotifier(false),
      statusMessage = ValueNotifier(''),
      receiverJoined = ValueNotifier(false),
      receiverUserName = ValueNotifier(''),
      requestReceived = ValueNotifier(false),
      requestSent = ValueNotifier(false),
      isTransmitting = ValueNotifier(false),
      autoConfirmEnabled = ValueNotifier(false);

  void dispose() {
    isConnected.dispose();
    isProcessing.dispose();
    isCompleted.dispose();
    statusMessage.dispose();
    receiverJoined.dispose();
    receiverUserName.dispose();
    requestReceived.dispose();
    requestSent.dispose();
    isTransmitting.dispose();
    autoConfirmEnabled.dispose();
  }
}

/// Model representing transfer statistics and history
class TransferState {
  final ValueNotifier<int> transferCounter;
  final ValueNotifier<List<String>> transferHistory;

  TransferState()
    : transferCounter = ValueNotifier(0),
      transferHistory = ValueNotifier([]);

  void dispose() {
    transferCounter.dispose();
    transferHistory.dispose();
  }
}

/// Model representing multi-receiver management state
class ReceiverManagementState {
  final ValueNotifier<Set<String>> connectedReceivers;
  final ValueNotifier<Map<String, DateTime>> pendingRequests;
  final ValueNotifier<Set<String>> activeTransfers;
  final ValueNotifier<Set<String>> rejectedUsers;

  ReceiverManagementState()
    : connectedReceivers = ValueNotifier({}),
      pendingRequests = ValueNotifier({}),
      activeTransfers = ValueNotifier({}),
      rejectedUsers = ValueNotifier({});

  void dispose() {
    connectedReceivers.dispose();
    pendingRequests.dispose();
    activeTransfers.dispose();
    rejectedUsers.dispose();
  }
}

/// Combined state model for the entire stream page
class PupilIdentityStreamState {
  final StreamState streamState;
  final TransferState transferState;
  final ReceiverManagementState receiverState;

  PupilIdentityStreamState()
    : streamState = StreamState(),
      transferState = TransferState(),
      receiverState = ReceiverManagementState();

  void dispose() {
    streamState.dispose();
    transferState.dispose();
    receiverState.dispose();
  }
}

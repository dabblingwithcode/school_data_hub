import 'package:signals/signals_flutter.dart';

/// Model representing the state of the pupil identity stream
class StreamState {
  final Signal<bool> isConnected;
  final Signal<bool> isProcessing;
  final Signal<bool> isCompleted;
  final Signal<String> statusMessage;
  final Signal<bool> receiverJoined;
  final Signal<String> receiverUserName;
  final Signal<bool> requestReceived;
  final Signal<bool> requestSent;
  final Signal<bool> isTransmitting;
  final Signal<bool> autoConfirmEnabled;

  StreamState()
    : isConnected = signal(false),
      isProcessing = signal(false),
      isCompleted = signal(false),
      statusMessage = signal(''),
      receiverJoined = signal(false),
      receiverUserName = signal(''),
      requestReceived = signal(false),
      requestSent = signal(false),
      isTransmitting = signal(false),
      autoConfirmEnabled = signal(false);

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
  final Signal<int> transferCounter;
  final Signal<List<String>> transferHistory;

  TransferState()
    : transferCounter = signal(0),
      transferHistory = signal(<String>[]);

  void dispose() {
    transferCounter.dispose();
    transferHistory.dispose();
  }
}

/// Model representing multi-receiver management state
class ReceiverManagementState {
  final Signal<Set<String>> connectedReceivers;
  final Signal<Map<String, DateTime>> pendingRequests;
  final Signal<Set<String>> activeTransfers;
  final Signal<Set<String>> rejectedUsers;

  ReceiverManagementState()
    : connectedReceivers = signal(<String>{}),
      pendingRequests = signal(<String, DateTime>{}),
      activeTransfers = signal(<String>{}),
      rejectedUsers = signal(<String>{});

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

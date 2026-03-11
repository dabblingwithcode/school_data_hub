import 'dart:async';
import 'dart:convert';

import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_identity_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_identity_stream_crypto.dart';

// enum PupilIdentityDtoType { request, data, ok }

class PupilIdentityStream {
  StreamSubscription<PupilIdentityDto>? _encryptedPupilIdsSubscription;
  Timer? _retryTimer;
  bool _retryScheduled = false;
  bool _isPrivateStream = false;
  PupilIdentitySession? _session;

  final Logger _log = Logger('PupilIdentityStream');

  StreamSubscription<PupilIdentityDto> encryptedPupilIdsStreamSubscription({
    required String channelName,
    required PupilIdentityStreamRole role,
    String? encryptedPupilIds,
    required void Function() onConnected,
    required void Function(String message) onStatusUpdate,
    required void Function() onCompleted,
    void Function(String userName)? onReceiverJoined,
    void Function(String userName)? onReceiverConnecting,
    void Function(String userName)? onReceiverLeft,
    void Function(String userName)? onRequestReceived,
    void Function()? onRequestConfirmed,
    void Function(bool wasAutoRejected)? onRequestRejected,
    void Function()? onShouldPopPage,
    void Function(String message)? onSenderShutdown,
    void Function(int newCount, int totalCount)? onDataReceived,
    PupilIdentityStreamCrypto? crypto,
    void Function(PupilIdentitySession session)? onSessionReady,
  }) {
    final notificationService = di<NotificationService>();

    _log.info(
      '[${role.name.toUpperCase()}]: Stream OPENING for channel=$channelName',
    );
    final client = di<Client>();
    _log.info(
      '[${role.name.toUpperCase()}]: starting encryptedPupilIdsStreamSubscription',
    );
    _retryTimer?.cancel();
    _retryTimer = null;
    _retryScheduled = false;
    _encryptedPupilIdsSubscription?.cancel();
    _encryptedPupilIdsSubscription = null;

    final controller = StreamController<PupilIdentityDto>.broadcast();
    final currentSourceHolder = <StreamSubscription<PupilIdentityDto>?>[null];

    void onSourceDone() {
      _log.info(
        '[${role.name.toUpperCase()}]: Stream CLOSED (source ended: remote or server closed)',
      );
      notificationService.showSnackBar(
        NotificationType.success,
        'Verbindung zum Client geschlossen.',
      );
    }

    void onSourceError(Object error) {
      final errorString = error.toString();
      _log.severe('Error in pupil identity stream: $error');
      if (error is ServerpodClientUnauthorized ||
          (error is ServerpodClientException && error.statusCode == 401)) {
        currentSourceHolder[0]?.cancel();
        currentSourceHolder[0] = null;
        controller.close();
        _log.info(
          '[${role.name.toUpperCase()}]: Stream CLOSED (unauthorized 401)',
        );
        // Stream ends; UI should rely on sign-out flow and not assume subscription is still active.
        di<HubSessionManager>().signOutDevice();
        return;
      }
      if (errorString.contains('Netzwerkverbindung abgelehnt')) {
        notificationService.showInformationDialog(
          'Der Server konnte nicht gefunden werden. Bitte überprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.',
        );
      } else {
        _log.severe(
          '[${role.name.toUpperCase()}]: Error in pupil identity stream: $errorString',
        );
      }
      if (_retryScheduled) return;
      _retryScheduled = true;
      _retryTimer?.cancel();
      _retryTimer = Timer(const Duration(seconds: 1), () {
        _retryTimer = null;
        _retryScheduled = false;
        currentSourceHolder[0]?.cancel();
        currentSourceHolder[0] = null;
        _isPrivateStream = false;
        _session = null;
        _log.warning(
          '[${role.name.toUpperCase()}]: Stream RETRY (reconnecting source for channel=$channelName)',
        );
        currentSourceHolder[0] = client.pupilIdentity
            .streamEncryptedPupilIds(channelName)
            .listen(
              (e) => controller.add(e),
              onError: onSourceError,
              onDone: onSourceDone,
            );
      });
    }

    HandshakeResult? pendingHandshakeResult;

    Future<bool> handleHandshakePhase(HandshakeMessage handshake) async {
      if (handshake.type == 'handshake_init' &&
          role == PupilIdentityStreamRole.receiver) {
        final identityPub = handshake.identityPubKeyBase64 != null
            ? base64.decode(handshake.identityPubKeyBase64!)
            : null;
        if (identityPub != null &&
            await crypto!.verifyHandshake(
              channelName,
              handshake,
              identityPub,
            )) {
          final response = await crypto.createHandshakeResponse(
            channelName,
            handshake,
          );
          _log.info(
            '[RECEIVER]: handshake_init verified, sending handshake_response',
          );
          final currentUser =
              di<HubSessionManager>().user?.userInfo?.userName ?? '';
          await client.pupilIdentity.sendPupilIdentityMessage(
            channelName,
            PupilIdentityDto(
              sender: currentUser,
              type: 'handshake_response',
              value: response.message.toJson(),
            ),
          );
          final session = await crypto.completeSession(
            response.myEphemeralPrivateBytes,
            response.myEphemeralPublicBytes,
            handshake.pubKeyBase64,
          );
          currentSourceHolder[0]?.cancel();
          _session = session;
          onSessionReady!(session);
          _isPrivateStream = true;
          _log.info(
            '[RECEIVER]: Stream switched to PRIVATE (streamId=${session.privateStreamId.substring(0, session.privateStreamId.length > 12 ? 12 : session.privateStreamId.length)}...)',
          );
          currentSourceHolder[0] = client.pupilIdentity
              .streamEncryptedPupilIds(session.privateStreamId)
              .listen(
                (e) => controller.add(e),
                onError: onSourceError,
                onDone: onSourceDone,
              );
          return true;
        }
        if (identityPub != null) {
          _log.severe(
            '[${role.name.toUpperCase()}]: Handshake signature verification failed; possible MitM. Ignoring handshake_init.',
          );
        }
      } else if (handshake.type == 'handshake_response' &&
          role == PupilIdentityStreamRole.sender) {
        _log.info(
          '[SENDER]: received handshake_response (pendingHandshakeResult ${pendingHandshakeResult != null ? "set" : "null"})',
        );
        if (pendingHandshakeResult == null) {
          _log.warning(
            '[SENDER]: Ignoring handshake_response: no pending handshake (init may not have completed yet).',
          );
          return false;
        }
        if (handshake.identityPubKeyBase64 == null) {
          _log.severe(
            '[${role.name.toUpperCase()}]: handshake_response missing identity key; rejecting.',
          );
          return false;
        }
        final identityPub = base64.decode(handshake.identityPubKeyBase64!);
        _log.info('[SENDER]: verifying handshake_response with crypto...');
        final ok = await crypto!.verifyHandshake(
          channelName,
          handshake,
          identityPub,
        );
        if (!ok) {
          _log.severe(
            '[${role.name.toUpperCase()}]: Handshake response verification failed; possible MitM. Ignoring handshake_response.',
          );
          return false;
        }
        final session = await crypto.completeSession(
          pendingHandshakeResult!.myEphemeralPrivateBytes,
          pendingHandshakeResult!.myEphemeralPublicBytes,
          handshake.pubKeyBase64,
        );
        pendingHandshakeResult = null;
        currentSourceHolder[0]?.cancel();
        _session = session;
        _log.info(
          '[SENDER]: session ready, private stream active (streamId=${session.privateStreamId.substring(0, session.privateStreamId.length > 12 ? 12 : session.privateStreamId.length)}...)',
        );
        onSessionReady!(session);
        _isPrivateStream = true;
        _log.info(
          '[SENDER]: Stream switched to PRIVATE (streamId=${session.privateStreamId.substring(0, session.privateStreamId.length > 12 ? 12 : session.privateStreamId.length)}...)',
        );
        currentSourceHolder[0] = client.pupilIdentity
            .streamEncryptedPupilIds(session.privateStreamId)
            .listen(
              (e) => controller.add(e),
              onError: onSourceError,
              onDone: onSourceDone,
            );
        return true;
      }
      return false;
    }

    Future<void> processSenderEvent(PupilIdentityDto eventForDispatch) async {
      final eventSender = eventForDispatch.sender;
      switch (eventForDispatch.type) {
        case 'receiver_presence':
          // Receiver announced presence on public channel (before handshake)
          if (onReceiverConnecting != null) {
            onReceiverConnecting(eventSender);
          }
          onStatusUpdate('Empfänger $eventSender verbindet...');
          // Re-send handshake_init so receiver gets it (they may have subscribed after first send)
          if (crypto != null &&
              onSessionReady != null &&
              !_isPrivateStream &&
              role == PupilIdentityStreamRole.sender) {
            try {
              final currentUser =
                  di<HubSessionManager>().user?.userInfo?.userName ?? '';
              if (currentUser.isNotEmpty) {
                final r = await crypto.createHandshakeInit(channelName);
                pendingHandshakeResult = r;
                await client.pupilIdentity.sendPupilIdentityMessage(
                  channelName,
                  PupilIdentityDto(
                    sender: currentUser,
                    type: 'handshake_init',
                    value: r.message.toJson(),
                  ),
                );
                _log.info(
                  '[SENDER]: Re-sent handshake_init after receiver_presence',
                );
              }
            } catch (e, st) {
              _log.warning('Handshake init (after presence) failed: $e', e, st);
            }
          }
          break;
        case 'joined':
          // Receiver joined the stream
          if (onReceiverJoined != null) {
            onReceiverJoined(eventSender);
          }
          onStatusUpdate(
            'Empfänger $eventSender ist der Übertragung beigetreten.',
          );
          break;
        case 'request':
          // Receiver requests data
          if (onRequestReceived != null) {
            onRequestReceived(eventSender);
          }
          onStatusUpdate(
            'Empfänger $eventSender hat Daten angefordert. Warten auf Bestätigung...',
          );
          break;
        case 'confirmed':
          // Ignore confirmations sent by ourselves to avoid double sending
          final currentUser = di<HubSessionManager>().user?.userInfo?.userName;
          if (eventSender == currentUser) {
            _log.fine(
              '[${role.name.toUpperCase()}] [${eventForDispatch.type}] from $eventSender: Ignoring self-confirmation message.',
            );
            break;
          }

          // Check if confirmation is for a specific user
          final targetUser = eventForDispatch.value.isNotEmpty
              ? eventForDispatch.value
              : null;

          // Validate user session before sending data

          if (currentUser == null || currentUser.isEmpty) {
            _log.severe(
              '[${role.name.toUpperCase()}]: Cannot send data - username is null or empty',
            );
            break;
          }

          final sendChannel = _isPrivateStream && _session != null
              ? _session!.privateStreamId
              : channelName;
          if (targetUser == null) {
            // Legacy: no targeting, proceed for any receiver
            if (onRequestConfirmed != null) {
              onRequestConfirmed();
            }
            onStatusUpdate('Sende Daten...');
            String dataValue = encryptedPupilIds ?? '';
            if (_session != null) {
              dataValue = await _session!.encryptValueAsync(dataValue);
            }
            await client.pupilIdentity.sendPupilIdentityMessage(
              sendChannel,
              PupilIdentityDto(
                sender: currentUser,
                dataTimeStamp: di<EnvManager>().activeEnv?.lastIdentitiesUpdate,
                type: 'data',
                value: dataValue,
              ),
            );
            onStatusUpdate('Daten gesendet. Warte auf Bestätigung...');
          } else {
            // Targeted: send data to specific user
            if (onRequestConfirmed != null) {
              onRequestConfirmed();
            }
            _log.info(
              '[${role.name.toUpperCase()}] [${eventForDispatch.type}] from $eventSender: Sending data to $targetUser',
            );
            onStatusUpdate('Sende Daten an $targetUser...');
            // Wire format: single session-encrypted string userName:payload; receiver splits on first colon.
            String targetedValue = '$targetUser:${encryptedPupilIds ?? ''}';
            if (_session != null) {
              targetedValue = await _session!.encryptValueAsync(targetedValue);
            }
            await client.pupilIdentity.sendPupilIdentityMessage(
              sendChannel,
              PupilIdentityDto(
                sender: currentUser,
                type: 'data',
                dataTimeStamp: di<EnvManager>().activeEnv?.lastIdentitiesUpdate,
                value: targetedValue,
              ),
            );
            onStatusUpdate(
              'Daten an $targetUser gesendet. Warte auf Bestätigung...',
            );
          }
          break;
        case 'ok':
          onCompleted();
          onStatusUpdate('Datenübertragung erfolgreich abgeschlossen!');
          _log.info(
            '[${role.name.toUpperCase()}]: Receiver acknowledged the data.',
          );
          break;
        case 'rejected':
          onStatusUpdate('Anfrage wurde vom Sender abgelehnt.');
          _log.info(
            '[${role.name.toUpperCase()}] [${eventForDispatch.type}] from $eventSender: Request was rejected by sender',
          );
          break;
        case 'close':
          // Receiver left the stream
          _log.info(
            '[${role.name.toUpperCase()}] [${eventForDispatch.type}] from $eventSender: Receiver ${eventForDispatch.value} left the stream',
          );
          onStatusUpdate(
            'Empfänger ${eventForDispatch.value} hat die Verbindung beendet.',
          );
          if (onReceiverLeft != null) {
            onReceiverLeft(eventForDispatch.value);
          }
          break;
      }
    }

    Future<void> processReceiverEvent(PupilIdentityDto eventForDispatch) async {
      final eventSender = eventForDispatch.sender;
      switch (eventForDispatch.type) {
        case 'rejected':
          // Check if rejection is targeted to this user
          String targetUser = eventForDispatch.value;
          bool isAutoRejection = false;

          // Check if this is an auto-rejection (prefixed with 'auto:')
          if (targetUser.startsWith('auto:')) {
            isAutoRejection = true;
            targetUser = targetUser.substring(5); // Remove 'auto:' prefix
          }

          final currentUserName =
              di<HubSessionManager>().user?.userInfo?.userName;

          if (targetUser.isEmpty || targetUser == currentUserName) {
            onStatusUpdate('Anfrage wurde vom Sender abgelehnt.');
            if (onRequestRejected != null) {
              onRequestRejected(isAutoRejection);
            }
            _log.info(
              '[${role.name.toUpperCase()}] [${eventForDispatch.type}] from $eventSender: Request was rejected by sender (auto: $isAutoRejection)',
            );

            // Close the connection to kick the receiver off the stream
            currentSourceHolder[0]?.cancel();
            currentSourceHolder[0] = null;
          }
          // If rejection is for another user, ignore it
          break;
        case 'confirmed':
          // Sender confirmed the request; data will follow
          onStatusUpdate('Bestätigung erhalten. Empfange Daten...');
          if (onRequestConfirmed != null) {
            onRequestConfirmed();
          }
          _log.info(
            '[${role.name.toUpperCase()}] [${eventForDispatch.type}] from $eventSender: Request confirmed by sender',
          );
          break;
        case 'data':
          // Check if data is targeted to this user
          final currentUserName =
              di<HubSessionManager>().user?.userInfo?.userName;

          String actualData = eventForDispatch.value;

          // Wire format: userName:payload (session-decrypted); split on first colon to get target and payload.
          if (eventForDispatch.value.contains(':')) {
            final parts = eventForDispatch.value.split(':');
            if (parts.length >= 2) {
              final targetUser = parts[0];
              if (targetUser != currentUserName) {
                // Data is not for this user, ignore it
                _log.info(
                  '[${role.name.toUpperCase()}] [${eventForDispatch.type}] from $eventSender: Data received for $targetUser, ignoring as current user is $currentUserName',
                );
                break;
              }
              // Extract actual data after removing target prefix
              actualData = parts.sublist(1).join(':');
            }
          }

          onStatusUpdate(
            'Verschlüsselte Schülerdaten empfangen. Verarbeite...',
          );
          _log.info(
            '[${role.name.toUpperCase()}] [${eventForDispatch.type}] from $eventSender: Received encrypted pupil identities dated on ${eventForDispatch.dataTimeStamp}.',
          );

          try {
            final beforeCount =
                di<PupilIdentityManager>().pupilIdentities.length;

            // final dataUpdateIsUpToDate = event.dataTimeStamp!.isAfter(
            //   di<EnvManager>().activeEnv!.lastIdentitiesUpdate!,
            // );

            _log.info('''Received newer pupil identities:
                      Timestamp: ${eventForDispatch.dataTimeStamp}
                      Last identities update: ${di<EnvManager>().activeEnv!.lastIdentitiesUpdate}
                      ''');
            // if (!dataUpdateIsUpToDate) {
            //   // Send confirmation
            //   await _client.pupilIdentity.sendPupilIdentityMessage(
            //     channelName,
            //     PupilIdentityDto(
            //       sender: di<HubSessionManager>()
            //           .user!
            //           .userInfo!
            //           .userName!,
            //       type: 'ok',
            //       value: '',
            //     ),
            //   );

            //   onCompleted();
            //   onStatusUpdate('Schülerdaten sind veraltet!');
            //   _encryptedPupilIdsSubscription!.cancel();
            //   if (onRequestRejected != null) {
            //     onRequestRejected(false);
            //   }
            //   _notificationService.showInformationDialog(
            //     'Schülerdaten sind veraltet und wurden nicht verarbeitet.',
            //   );

            //   return;
            // }
            await di<PupilIdentityManager>()
                .updatePupilIdentitiesFromEncryptedText(
                  eventForDispatch.dataTimeStamp!,
                  actualData,
                );
            final afterCount =
                di<PupilIdentityManager>().pupilIdentities.length;
            final newCount = afterCount - beforeCount;
            // Set the last identities update to the received data time stamp
            di<EnvManager>().updateActiveEnv(
              lastIdentitiesUpdate: eventForDispatch.dataTimeStamp?.toUtc(),
            );

            // Validate user session before sending confirmation
            final confirmUser =
                di<HubSessionManager>().user?.userInfo?.userName;
            if (confirmUser == null || confirmUser.isEmpty) {
              _log.severe(
                '[${role.name.toUpperCase()}]: Cannot send confirmation - username is null or empty',
              );
              break;
            }

            // Send confirmation
            final sendChannel = _isPrivateStream && _session != null
                ? _session!.privateStreamId
                : channelName;
            await client.pupilIdentity.sendPupilIdentityMessage(
              sendChannel,
              PupilIdentityDto(sender: confirmUser, type: 'ok', value: ''),
            );

            onCompleted();
            onStatusUpdate(
              'Schülerdaten erfolgreich empfangen und verarbeitet!',
            );

            // Call the data received callback with count information
            if (onDataReceived != null) {
              onDataReceived(newCount, afterCount);
            } else if (onShouldPopPage != null) {
              // Fallback: if no data received callback, use the old pop page callback
              onShouldPopPage();
            }

            currentSourceHolder[0]?.cancel();
          } catch (e) {
            _log.severe(
              '[${role.name.toUpperCase()}] [${eventForDispatch.type}] from $eventSender: Error processing received data: $e',
            );
            onStatusUpdate('Fehler beim Verarbeiten der Daten: $e');
          }
          break;
        case 'shutdown':
          // Sender has shut down the stream
          _log.info(
            '[${role.name.toUpperCase()}] [${eventForDispatch.type}] from $eventSender: Sender has shut down the stream',
          );
          onStatusUpdate('Der Sender hat den Stream beendet.');
          if (onSenderShutdown != null) {
            onSenderShutdown(eventForDispatch.value);
          }
          // Close the connection
          currentSourceHolder[0]?.cancel();
          currentSourceHolder[0] = null;
          break;
      }
    }

    late void Function(PupilIdentityDto) handleEvent;
    handleEvent = (PupilIdentityDto event) async {
      final eventSender = event.sender;

      if (eventSender.isEmpty) {
        _log.severe(
          '[${role.name.toUpperCase()}]: Received event with NULL/EMPTY sender! '
          'Type: ${event.type}, Value: ${event.value}. Skipping malformed event.',
        );
        return;
      }

      _log.info(
        '[${role.name.toUpperCase()}]: [${event.type}] Received event from $eventSender',
      );

      final rawValue = event.value as dynamic;
      String eventValue = rawValue is String ? rawValue : jsonEncode(rawValue);
      if (_isPrivateStream && _session != null && eventValue.isNotEmpty) {
        final decrypted = await _session!.decryptValueAsync(eventValue);
        if (decrypted != null) {
          eventValue = decrypted;
        } else {
          _log.warning(
            '[${role.name.toUpperCase()}]: Skipping event with failed decryption on private stream',
          );
          return;
        }
      }

      if (crypto != null && onSessionReady != null && !_isPrivateStream) {
        final handshake = HandshakeMessage.fromJson(eventValue);
        if (handshake == null) {
          _log.fine(
            '[${role.name.toUpperCase()}]: handshake phase: event type=${event.type}, could not parse value as HandshakeMessage',
          );
        } else if (await handleHandshakePhase(handshake)) {
          return;
        }
      }

      final eventForDispatch = PupilIdentityDto(
        sender: event.sender,
        type: event.type,
        dataTimeStamp: event.dataTimeStamp,
        value: eventValue,
      );

      switch (role) {
        case PupilIdentityStreamRole.sender:
          await processSenderEvent(eventForDispatch);
          break;
        case PupilIdentityStreamRole.receiver:
          await processReceiverEvent(eventForDispatch);
          break;
      }
    };

    currentSourceHolder[0] = client.pupilIdentity
        .streamEncryptedPupilIds(channelName)
        .listen(
          (e) => controller.add(e),
          onError: onSourceError,
          onDone: onSourceDone,
        );

    final processingSub = controller.stream.listen(handleEvent);

    if (crypto != null &&
        onSessionReady != null &&
        role == PupilIdentityStreamRole.sender) {
      scheduleMicrotask(() async {
        try {
          final currentUser =
              di<HubSessionManager>().user?.userInfo?.userName ?? '';
          if (currentUser.isEmpty) return;
          final r = await crypto.createHandshakeInit(channelName);
          pendingHandshakeResult = r;
          await client.pupilIdentity.sendPupilIdentityMessage(
            channelName,
            PupilIdentityDto(
              sender: currentUser,
              type: 'handshake_init',
              value: r.message.toJson(),
            ),
          );
        } catch (e, st) {
          _log.warning('Handshake init failed: $e', e, st);
        }
      });
    }

    // Call onConnected immediately after subscription is established
    _log.info(
      '[${role.name.toUpperCase()}]: Stream OPENED (subscription established for channel=$channelName)',
    );
    onConnected();

    Future<void> onWrapperCancel() async {
      _log.info(
        '[${role.name.toUpperCase()}]: Stream DISPOSING (subscription cancelled, channel=$channelName)',
      );
      await currentSourceHolder[0]?.cancel();
      currentSourceHolder[0] = null;
      await controller.close();
    }

    return _StreamSubscriptionWrapper<PupilIdentityDto>(
      processingSub,
      onWrapperCancel,
    );
  }
}

/// Wraps a [StreamSubscription] and runs [onCancel] when [cancel] is called,
/// so the current Serverpod source and controller can be cleaned up.
class _StreamSubscriptionWrapper<T> implements StreamSubscription<T> {
  _StreamSubscriptionWrapper(this._inner, this._onCancel);

  final StreamSubscription<T> _inner;
  final Future<void> Function() _onCancel;

  @override
  Future<void> cancel() async {
    await _onCancel();
    await _inner.cancel();
  }

  @override
  Future<E> asFuture<E>([E? futureValue]) => _inner.asFuture<E>(futureValue);

  @override
  void onData(void Function(T data)? handleData) => _inner.onData(handleData);

  @override
  void onError(Function? onError) => _inner.onError(onError);

  @override
  void onDone(void Function()? onDone) => _inner.onDone(onDone);

  @override
  bool get isPaused => _inner.isPaused;

  @override
  void pause([Future<void>? resumeSignal]) => _inner.pause(resumeSignal);

  @override
  void resume() => _inner.resume();
}

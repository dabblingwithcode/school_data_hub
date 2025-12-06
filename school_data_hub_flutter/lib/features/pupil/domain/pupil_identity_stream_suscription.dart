import 'dart:async';

import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:watch_it/watch_it.dart';

// enum PupilIdentityDtoType { request, data, ok }

class PupilIdentityStream {
  StreamSubscription<PupilIdentityDto>? _encryptedPupilIdsSubscription;

  final Logger _log = Logger('PupilIdentityStream');

  StreamSubscription<PupilIdentityDto> encryptedPupilIdsStreamSubscription({
    required String channelName,
    required PupilIdentityStreamRole role,
    String? encryptedPupilIds,
    required Function() onConnected,
    required Function(String message) onStatusUpdate,
    required Function() onCompleted,
    Function(String userName)? onReceiverJoined, // New callback
    Function(String userName)?
    onReceiverLeft, // New callback for receiver leaving
    Function(String userName)? onRequestReceived, // New callback
    Function()? onRequestConfirmed, // New callback
    Function(bool wasAutoRejected)?
    onRequestRejected, // New callback for rejection
    Function()? onShouldPopPage, // New callback for receiver
    Function(String message)?
    onSenderShutdown, // New callback for sender shutdown
    Function(int newCount, int totalCount)?
    onDataReceived, // New callback for showing success info
  }) {
    final _notificationService = di<NotificationService>();

    _log.info(
      'encryptedPupilIdsStreamSubscription called with channelName: $channelName and role: $role',
    );
    final _client = di<Client>();
    _log.info('starting encryptedPupilIdsStreamSubscription');
    // just in case we have a previous subscription, we cancel it first
    _encryptedPupilIdsSubscription?.cancel();
    _encryptedPupilIdsSubscription = _client.pupilIdentity
        .streamEncryptedPupilIds(channelName)
        .listen(
          (PupilIdentityDto event) async {
            _log.info('Received event: [${event.type}] from ${event.sender}');
            final eventSender = event.sender;
            switch (role) {
              //- Stream behavior for sender role
              case PupilIdentityStreamRole.sender:
                // - Handle the event based on its type
                switch (event.type) {
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
                    // Check if confirmation is for a specific user
                    final targetUser = event.value.isNotEmpty
                        ? event.value
                        : null;
                    if (targetUser == null) {
                      // Legacy: no targeting, proceed for any receiver
                      if (onRequestConfirmed != null) {
                        onRequestConfirmed();
                      }
                      onStatusUpdate('Sende Daten...');
                      await _client.pupilIdentity.sendPupilIdentityMessage(
                        channelName,
                        PupilIdentityDto(
                          sender:
                              di<HubSessionManager>().user!.userInfo!.userName!,
                          dataTimeStamp:
                              di<EnvManager>().activeEnv?.lastIdentitiesUpdate,
                          type: 'data',
                          value: encryptedPupilIds ?? '',
                        ),
                      );
                      onStatusUpdate(
                        'Daten gesendet. Warte auf Bestätigung...',
                      );
                    } else {
                      // Targeted: send data to specific user
                      if (onRequestConfirmed != null) {
                        onRequestConfirmed();
                      }
                      onStatusUpdate('Sende Daten an $targetUser...');
                      await _client.pupilIdentity.sendPupilIdentityMessage(
                        channelName,
                        PupilIdentityDto(
                          sender:
                              di<HubSessionManager>().user!.userInfo!.userName!,
                          type: 'data',
                          dataTimeStamp:
                              di<EnvManager>().activeEnv?.lastIdentitiesUpdate,
                          value: '$targetUser:${encryptedPupilIds ?? ''}',
                        ),
                      );
                      onStatusUpdate(
                        'Daten an $targetUser gesendet. Warte auf Bestätigung...',
                      );
                    }
                    break;
                  case 'ok':
                    onCompleted();
                    onStatusUpdate(
                      'Datenübertragung erfolgreich abgeschlossen!',
                    );
                    _log.info('Receiver acknowledged the data');
                    break;
                  case 'rejected':
                    onStatusUpdate('Anfrage wurde vom Sender abgelehnt.');
                    _log.info('Request was rejected by sender');
                    break;
                  case 'close':
                    // Receiver left the stream
                    _log.info('Receiver ${event.value} left the stream');
                    onStatusUpdate(
                      'Empfänger ${event.value} hat die Verbindung beendet.',
                    );
                    if (onReceiverLeft != null) {
                      onReceiverLeft(event.value);
                    }
                    break;
                }
                break;
              //- Stream behavior for receiver role
              case PupilIdentityStreamRole.receiver:
                switch (event.type) {
                  case 'rejected':
                    // Check if rejection is targeted to this user
                    String targetUser = event.value;
                    bool isAutoRejection = false;

                    // Check if this is an auto-rejection (prefixed with 'auto:')
                    if (targetUser.startsWith('auto:')) {
                      isAutoRejection = true;
                      targetUser = targetUser.substring(
                        5,
                      ); // Remove 'auto:' prefix
                    }

                    final currentUserName =
                        di<HubSessionManager>().user?.userInfo?.userName;

                    if (targetUser.isEmpty || targetUser == currentUserName) {
                      onStatusUpdate('Anfrage wurde vom Sender abgelehnt.');
                      if (onRequestRejected != null) {
                        onRequestRejected(isAutoRejection);
                      }
                      _log.info(
                        'Request was rejected by sender (auto: $isAutoRejection)',
                      );

                      // Close the connection to kick the receiver off the stream
                      _encryptedPupilIdsSubscription?.cancel();
                      _encryptedPupilIdsSubscription = null;
                    }
                    // If rejection is for another user, ignore it
                    break;
                  case 'data':
                    // Check if data is targeted to this user
                    final currentUserName =
                        di<HubSessionManager>().user?.userInfo?.userName;

                    String actualData = event.value;

                    if (event.value.contains(':')) {
                      final parts = event.value.split(':');
                      if (parts.length >= 2) {
                        final targetUser = parts[0];
                        if (targetUser != currentUserName) {
                          // Data is not for this user, ignore it
                          _log.info(
                            'Data received for $targetUser, ignoring as current user is $currentUserName',
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
                      'Received encrypted pupil identities dated on ${event.dataTimeStamp}.',
                    );

                    try {
                      final beforeCount =
                          di<PupilIdentityManager>().pupilIdentities.length;

                      // final dataUpdateIsUpToDate = event.dataTimeStamp!.isAfter(
                      //   di<EnvManager>().activeEnv!.lastIdentitiesUpdate!,
                      // );

                      _log.info('''Received newer pupil identities:
                      Timestamp: ${event.dataTimeStamp}
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
                            event.dataTimeStamp!,
                            actualData,
                          );
                      final afterCount =
                          di<PupilIdentityManager>().pupilIdentities.length;
                      final newCount = afterCount - beforeCount;
                      // Set the last identities update to the received data time stamp
                      di<EnvManager>().updateActiveEnv(
                        lastIdentitiesUpdate: event.dataTimeStamp?.toUtc(),
                      );

                      // Send confirmation
                      await _client.pupilIdentity.sendPupilIdentityMessage(
                        channelName,
                        PupilIdentityDto(
                          sender:
                              di<HubSessionManager>().user!.userInfo!.userName!,
                          type: 'ok',
                          value: '',
                        ),
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

                      _encryptedPupilIdsSubscription!.cancel();
                    } catch (e) {
                      _log.severe('Error processing received data: $e');
                      onStatusUpdate('Fehler beim Verarbeiten der Daten: $e');
                    }
                    break;
                  case 'shutdown':
                    // Sender has shut down the stream
                    _log.info('Sender has shut down the stream');
                    onStatusUpdate('Der Sender hat den Stream beendet.');
                    if (onSenderShutdown != null) {
                      onSenderShutdown(event.value);
                    }
                    // Close the connection
                    _encryptedPupilIdsSubscription?.cancel();
                    _encryptedPupilIdsSubscription = null;
                    break;
                }
            }
          },
          onError: (error) async {
            final errorString = error.toString();
            _log.severe('Error in pupil identity stream: $error');
            if (error.toString().contains('Unauthorized')) {
              _encryptedPupilIdsSubscription!.cancel();
              return di<HubSessionManager>().signOutDevice();
            } else if (error.toString().contains(
              'Netzwerkverbindung abgelehnt',
            )) {
              // TODO: Implement server not responding
              //- This is very buggy
              _notificationService.showInformationDialog(
                'Der Server konnte nicht gefunden werden. Bitte überprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.',
              );
            } else {
              _log.severe('Error in pupil identity stream: $errorString');
              // _notificationService.showSnackBar(
              //   NotificationType.error,
              //   'Ein unbekannter Fehler ist aufgetreten: $errorString',
              // );
            }
            // retry the subscription after a delay
            await Future.delayed(const Duration(seconds: 1));
            _encryptedPupilIdsSubscription!.cancel();
            encryptedPupilIdsStreamSubscription(
              channelName: channelName,
              role: role,
              encryptedPupilIds: encryptedPupilIds,
              onConnected: onConnected,
              onStatusUpdate: onStatusUpdate,
              onCompleted: onCompleted,
              onReceiverJoined: onReceiverJoined,
              onRequestReceived: onRequestReceived,
              onRequestConfirmed: onRequestConfirmed,
              onRequestRejected: onRequestRejected,
              onShouldPopPage: onShouldPopPage,
              onDataReceived: onDataReceived,
              onSenderShutdown: onSenderShutdown,
            );
          },
          onDone: () {
            _notificationService.showSnackBar(
              NotificationType.success,
              'Verbindung zum Client geschlossen.',
            );
          },
        );

    // Call onConnected immediately after subscription is established
    _log.info(
      'Stream subscription established for channel: $channelName with role: $role',
    );
    onConnected();

    return _encryptedPupilIdsSubscription!;
  }
}

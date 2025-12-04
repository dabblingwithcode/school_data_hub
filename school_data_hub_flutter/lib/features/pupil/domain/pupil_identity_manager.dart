import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/app_utils/extensions/datetime_extensions.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/common/data/file_upload_service.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/data/pupil_data_api_service.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_selector_filters.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_helper_functions.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

enum PupilIdentityStreamRole { sender, receiver }

class PupilIdentityManager {
  final _notificationService = di<NotificationService>();

  final _mainMenuBottomNavManager = di<BottomNavManager>();

  final _log = Logger('PupilIdentityManager');

  final secureStorageKey = di<EnvManager>().storageKeyForPupilIdentities;

  Map<int, PupilIdentity> _pupilIdentities = {};

  //-TODO URGENT: add a value notifier for the last update value
  //- add endpoint to get the value from the server
  //- compare values and notify if the local value is older than the server value

  final _groups = ValueNotifier<Set<String>>({});
  ValueListenable<Set<String>> get groups => _groups;

  StreamSubscription<PupilIdentityDto>? _encryptedPupilIdsSubscription;

  // List<int> get availablePupilIds => _pupilIdentities.keys.toList();

  List<int> get availablePupilIds {
    _log.info(
      'getter returning [${_pupilIdentities.keys.length}] available pupil ids',
    );
    return _pupilIdentities.keys.toList();
  }

  PupilIdentity? getPupilIdentityByInternalId(int internalId) {
    if (_pupilIdentities.containsKey(internalId) == false) {
      _notificationService.showInformationDialog(
        '''Die Schülerdaten mit der ID $internalId konnten nicht gefunden werden.
          
          Bitte überprüfen Sie die ID und versuchen Sie es erneut.''',
      );
      return null;
    }
    return _pupilIdentities[internalId]!;
  }

  Future<PupilIdentityManager> init() async {
    await getPupilIdentitiesForEnv();
    return this;
  }

  /// Re-initializes the manager for a new environment
  /// This should be called when switching environments
  Future<void> reinitializeForNewEnvironment() async {
    _log.info('Re-initializing PupilIdentityManager for new environment');

    // Clear old environment data
    _pupilIdentities.clear();
    _groups.value = {};

    // Load data for the new environment
    await getPupilIdentitiesForEnv();

    _log.info(
      'PupilIdentityManager re-initialized for environment: ${di<EnvManager>().activeEnv?.serverName}',
    );
  }

  /// Checks if the manager is ready for the current environment
  bool get isReadyForCurrentEnvironment {
    return di<EnvManager>().activeEnv != null && _pupilIdentities.isNotEmpty;
  }

  void dispose() {
    _groups.dispose();
    _pupilIdentities.clear();
    _log.info('PupilIdentityManager disposed');
  }

  Future<void> deleteAllPupilIdentities() async {
    await HubSecureStorage().remove(secureStorageKey);
    _pupilIdentities.clear();

    di<PupilsFilter>().clearFilteredPupils();
    di<PupilManager>().clearData();
  }

  void clearPupilIdentities() {
    _pupilIdentities.clear();
    return;
  }

  Future<void> getPupilIdentitiesForEnv() async {
    final activeEnv = di<EnvManager>().activeEnv!;

    final Map<int, PupilIdentity> pupilIdentities =
        await PupilIdentityHelper.readPupilIdentitiesFromStorage(
          secureStorageKey: secureStorageKey,
        );

    _pupilIdentities.clear();
    _pupilIdentities = pupilIdentities;
    if (pupilIdentities.isEmpty) {
      _log.warning(
        'No stored pupil identities found for ${activeEnv.serverName}',
      );
    } else {
      _log.info(
        '${pupilIdentities.length} Pupil identities for [${activeEnv.serverName}] loaded from secure storage: ${_pupilIdentities.length}',
      );
    }

    _groups.value = _pupilIdentities.values.map((e) => e.group).toSet();

    // We check now if the identities are outdated

    final lastIdentitiesUpdate = await PupilDataApiService()
        .fetchLastIdentitiesUpdate();
    if (lastIdentitiesUpdate != null &&
        activeEnv.lastIdentitiesUpdate != null) {
      if (lastIdentitiesUpdate.isAfter(activeEnv.lastIdentitiesUpdate!)) {
        _notificationService.showInformationDialog(
          'Die Schülerdaten sind veraltet. Die neueste Version ist vom $lastIdentitiesUpdate! Bitte aktualisieren Sie die Schülerdaten.',
        );
      } else {
        _log.info('Pupil identities are up to date.');
      }
    } else {
      _log.warning('No last identities update found in the server.');
    }
    return;
  }

  Future<void> updatePupilIdentitiesFromEncryptedSource(
    List<String> encryptedCodes,
  ) async {
    // We need the decrypted information as a string with line breaks.
    // Since every string in the list of the argument i an encrypted code,
    // we need to decrypt them and aggregate them to a string with line breaks
    // in which every line will be a pupil identity.
    String decryptedString = '';
    for (String code in encryptedCodes) {
      decryptedString += '${customEncrypter.decryptString(code)}\n';
    }

    updatePupilIdentitiesFromUnencryptedSource(
      identitiesInStringLines: decryptedString,
    );
  }

  Future<void> updatePupilIdentitiesFromUnencryptedSource({
    required String identitiesInStringLines,
  }) async {
    late final String? decryptedIdentitiesAsString;

    // If the string is imported in windows, it comes from a .txt file and it's not encrypted
    decryptedIdentitiesAsString = identitiesInStringLines;

    // The pupils in the string are separated by a '\n' - let's split them apart
    List<String> splittedPupilIdentities = decryptedIdentitiesAsString.split(
      '\n',
    );
    // The properties are separated by commas, let's build the PupilIdentity objects with them

    bool updateGroupFilters = false;

    for (String data in splittedPupilIdentities) {
      if (data != '') {
        List<String> pupilIdentityValues = data.split(',');
        final newPupilIdentity =
            PupilIdentityHelper.decodePupilIdentityFromStringList(
              pupilIdentityValues,
            );

        // TODO: fix this
        if (PupilProxy.groupFilters.any(
              (filter) =>
                  (filter as GroupFilter).name == newPupilIdentity.group,
            ) ==
            false) {
          updateGroupFilters = true;
        }
        //- add the new pupil to the pupilIdentities map
        _pupilIdentities[newPupilIdentity.id] = newPupilIdentity;
      }
    }

    await writePupilIdentitiesToStorage();

    if (updateGroupFilters) {
      final availableGroups = _pupilIdentities.values
          .map((e) => e.group)
          .toSet();
      _groups.value = availableGroups;
      di<PupilsFilter>().populateGroupFilters(availableGroups.toList());
    }
    await di<EnvManager>().updateActiveEnv(
      lastIdentitiesUpdate: DateTime.now().toUtc(),
    );
    di<PupilManager>().fetchAllPupils();
    _mainMenuBottomNavManager.setBottomNavPage(0);
  }

  Future<void> writePupilIdentitiesToStorage() async {
    final Map<String, Map<String, dynamic>> jsonMap = _pupilIdentities.map(
      (key, value) => MapEntry(key.toString(), value.toJson()),
    );

    final jsonPupilIdentitiesAsString = json.encode(jsonMap);
    await HubSecureStorage().setString(
      secureStorageKey,
      jsonPupilIdentitiesAsString,
    );
    _log.info(
      'Pupil identities written to secure storage with key $secureStorageKey',
    );
  }

  Future<void> updateBackendPupilsWithSchoolPupilIdentitySource(
    String textFileContent,
  ) async {
    // The pupils in the string are separated by a line break - let's split them out
    List<String> splittedPupilIdentities = textFileContent.split('\n');
    // Wer prepare a string with the pupils that are going to be updated later in the server
    String pupilListTxtFileContentForBackendUpdate = '';
    // The properties are separated by commas, let's build the pupilbase objects with them
    List<PupilIdentity> importedPupilIdentityList = [];

    for (String data in splittedPupilIdentities) {
      if (data != '') {
        List<String> pupilIdentityValues = data.split(',');

        PupilIdentity pupilIdentity =
            PupilIdentityHelper.decodePupilIdentityFromStringList(
              pupilIdentityValues,
            );

        importedPupilIdentityList.add(pupilIdentity);

        final bool ogsStatus = pupilIdentityValues[14] == 'OFFGANZ'
            ? true
            : false;

        final idAndOgsStatus =
            '${int.parse(pupilIdentityValues[0])},$ogsStatus';

        pupilListTxtFileContentForBackendUpdate += '$idAndOgsStatus\n';
      }
    }
    // We have the latest dataset from the school database.
    // Now let's update the pupils in the server with a txt file
    // First we generate a txt file with updatedPupils
    // The server will automatically archive pupils that are not in the list,
    // update the ones that are in the list,
    // and create the ones that are not in the server.

    final textFile = File('temp.txt')
      ..writeAsStringSync(pupilListTxtFileContentForBackendUpdate);

    final fileResponse = await ClientFileUpload.uploadFile(
      textFile,
      ServerStorageFolder.temp,
    );
    if (fileResponse.success == false) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Die Datei konnte nicht hochgeladen werden!',
      );
      return;
    }
    final List<PupilData>? updatedPupilDataRepository =
        await PupilDataApiService().updateBackendPupilsDatabase(
          filePath: fileResponse.path!,
        );
    if (updatedPupilDataRepository == null) {
      return;
    }
    for (PupilData pupil in updatedPupilDataRepository) {
      di<PupilManager>().updatePupilProxyWithPupilData(pupil);
    }
    // We don't need the temp file any more, let's delete it
    textFile.delete();

    for (PupilIdentity element in importedPupilIdentityList) {
      _pupilIdentities[element.id] = element;
    }

    await writePupilIdentitiesToStorage();
    // This is the new reference data for all the clients to adopt.
    // We need to update the active environment and the backend with the new last identities update.
    final newLastIdentitiesUpdate = DateTime.now().toUtc();
    await di<EnvManager>().updateActiveEnv(
      lastIdentitiesUpdate: newLastIdentitiesUpdate,
    );
    await PupilDataApiService().updateLastIdentitiesUpdate(
      newLastIdentitiesUpdate,
    );
    await di<PupilManager>().fetchAllPupils();

    _notificationService.showSnackBar(
      NotificationType.success,
      '${_pupilIdentities.length} Schülerdaten wurden aktualisiert!',
    );

    _mainMenuBottomNavManager.setBottomNavPage(0);

    return;
  }

  Future<void> fetchLastIdentitiesUpdate() async {
    final lastUpdate = await PupilDataApiService().fetchLastIdentitiesUpdate();
    if (lastUpdate == null) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Die letzte Aktualisierung konnte nicht geladen werden',
      );
      return;
    }
    _notificationService.showSnackBar(
      NotificationType.success,
      'Letzte Aktualisierung: ${lastUpdate.formatDateForUser()}',
    );
  }

  Future<String> generateEncryptedPupilIdentitiesTransferString(
    List<int> internalIds,
  ) async {
    String transferString = '';
    for (int internalId in internalIds) {
      PupilIdentity pupilIdentity = _pupilIdentities[internalId]!;
      final migrationSupportEnds = pupilIdentity.migrationSupportEnds != null
          ? pupilIdentity.migrationSupportEnds!.formatDateForJson()
          : '';
      // We need
      final specialNeeds = pupilIdentity.specialNeeds ?? '';
      final family = pupilIdentity.family ?? '';

      final String pupilIdentityString =
          [
            pupilIdentity.id.toString(),
            pupilIdentity.firstName,
            pupilIdentity.lastName,
            pupilIdentity.group,
            pupilIdentity.groupTutor,
            pupilIdentity.schoolGrade,
            specialNeeds,
            '', // this is a placeholder for the second special needs field in the administrative data source
            pupilIdentity.gender,
            pupilIdentity.language,
            family,
            pupilIdentity.birthday.formatDateForJson(),
            migrationSupportEnds,
            pupilIdentity.pupilSince.formatDateForJson(),
            pupilIdentity.afterSchoolCare ? 'OFFGANZ' : '',
            pupilIdentity.religion ?? '',
            pupilIdentity.religionLessonsSince?.formatDateForJson() ?? '',
            pupilIdentity.religionLessonsCancelledAt?.formatDateForJson() ?? '',
            pupilIdentity.familyLanguageLessonsSince?.formatDateForJson() ?? '',
            pupilIdentity.leavingDate?.formatDateForJson() ?? '',
          ].join(',') +
          ',\n';
      transferString = transferString + pupilIdentityString;
    }
    final encryptedString = customEncrypter.encryptString(transferString);
    return encryptedString;
  }

  Future<String> deleteOrphanPupilIdentities(
    List<int> toBeDeletedPupilIds,
  ) async {
    List<String> toBeDeletedPupilIdentities = [];

    for (int id in toBeDeletedPupilIds) {
      toBeDeletedPupilIdentities.add(
        '${_pupilIdentities[id]!.firstName} ${_pupilIdentities[id]!.lastName}, ${_pupilIdentities[id]!.group}',
      );

      _pupilIdentities.remove(id);
    }

    writePupilIdentitiesToStorage();

    _log.info(
      ' ${toBeDeletedPupilIds.length} pupils are not in the database any more and wer deleted.',
    );

    return toBeDeletedPupilIdentities.join('\n');
  }

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
                      final beforeCount = _pupilIdentities.length;
                      final dataUpdateIsUpToDate = event.dataTimeStamp!.isAfter(
                        di<EnvManager>().activeEnv!.lastIdentitiesUpdate!,
                      );

                      _log.info('''Received newer pupil identities:
                      Timestamp: ${event.dataTimeStamp}
                      Last identities update: ${di<EnvManager>().activeEnv!.lastIdentitiesUpdate}
                      ''');
                      if (!dataUpdateIsUpToDate) {
                        // Send confirmation
                        await _client.pupilIdentity.sendPupilIdentityMessage(
                          channelName,
                          PupilIdentityDto(
                            sender: di<HubSessionManager>()
                                .user!
                                .userInfo!
                                .userName!,
                            type: 'ok',
                            value: '',
                          ),
                        );

                        onCompleted();
                        onStatusUpdate('Schülerdaten sind veraltet!');
                        _encryptedPupilIdsSubscription!.cancel();
                        if (onRequestRejected != null) {
                          onRequestRejected(false);
                        }
                        _notificationService.showInformationDialog(
                          'Schülerdaten sind veraltet und wurden nicht verarbeitet.',
                        );

                        return;
                      }
                      await updatePupilIdentitiesFromEncryptedSource([
                        actualData,
                      ]);
                      final afterCount = _pupilIdentities.length;
                      final newCount = afterCount - beforeCount;
                      // Set the last identities update to the received data time stamp
                      di<EnvManager>().updateActiveEnv(
                        lastIdentitiesUpdate: event.dataTimeStamp,
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

enum PupilIdentityDtoType { request, data, ok }

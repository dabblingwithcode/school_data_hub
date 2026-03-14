import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:school_data_hub_flutter/core/client/hub_stream_service.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_authorizations/data/authorization_api_service.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

final _log = Logger('AuthorizationManager');

class AuthorizationManager with ChangeNotifier {
  final _notificationService = di<NotificationManager>();

  final _authorizationApiService = AuthorizationApiService();

  final _hubSessionManager = di<HubSessionManager>();

  final _cacheManager = di<DefaultCacheManager>();

  ValueListenable<List<Authorization>> get authorizations => _authorizations;

  final _authorizations = ValueNotifier<List<Authorization>>([]);

  Map<int, Authorization> _authorizationsMap = {};

  final Map<String, ValueListenable<PupilAuthorization?>>
  _pupilAuthListenables = {};

  StreamSubscription<dynamic>? _hubSubscription; // ignore: unused_field

  AuthorizationManager();

  @override
  void dispose() {
    _authorizations.dispose();
    _authorizationsMap.clear();
    _pupilAuthListenables.clear();
    super.dispose();
    return;
  }

  Future<AuthorizationManager> init() async {
    _log.info('Authorizations are being fetched');
    await fetchAuthorizations();
    _hubSubscription = di<HubStreamService>().events.listen(_onHubEvent);
    return this;
  }

  void _onHubEvent(dynamic event) {
    if (event is Authorization) {
      upsertFromStream(event);
    } else if (event is HubDeleteEvent &&
        event.objectType == HubObjectType.authorization) {
      deleteFromStream(event.id);
    } else if (event is HubReconnected) {
      fetchAuthorizations();
    } else if (event is HubSelectiveReconnect) {
      if (event.changedTypes.contains(HubObjectType.authorization)) {
        fetchAuthorizations();
      }
    }
  }

  void upsertFromStream(Authorization authorization) {
    final merged = _mergeAuthorizationFromStream(authorization);
    _updateAuthsInCollections([merged]);
  }

  /// Preserves existing [PupilAuthorization.file] when the stream payload has
  /// [PupilAuthorization.fileId] but [PupilAuthorization.file] is null, so
  /// the hub document image stays visible after upsert (see schoolday events).
  Authorization _mergeAuthorizationFromStream(Authorization incoming) {
    final existing = _authorizationsMap[incoming.id!];
    if (existing == null || incoming.authorizedPupils == null) {
      return incoming;
    }
    final mergedPupilAuths = <PupilAuthorization>[];
    final existingPupilAuths = existing.authorizedPupils ?? [];
    for (final pa in incoming.authorizedPupils!) {
      if (pa.fileId != null && pa.file == null) {
        final existingPa = existingPupilAuths
            .where((e) => e.pupilId == pa.pupilId)
            .firstOrNull;
        if (existingPa != null && existingPa.file != null) {
          mergedPupilAuths.add(pa.copyWith(file: existingPa.file));
          continue;
        }
      }
      mergedPupilAuths.add(pa);
    }
    return incoming.copyWith(authorizedPupils: mergedPupilAuths);
  }

  void deleteFromStream(int id) {
    if (_authorizationsMap.containsKey(id)) {
      _authorizationsMap.remove(id);
      _removePupilAuthListenablesForAuth(id);
      _authorizations.value = _authorizationsMap.values.toList();
      notifyListeners();
    }
  }

  void clearData() {
    _authorizations.value = [];
    _authorizationsMap = {};
    _pupilAuthListenables.clear();
  }

  static PupilAuthorization? _extractPupilAuth(
    List<Authorization> list,
    int authorizationId,
    int pupilId,
  ) {
    final auth = list.where((a) => a.id == authorizationId).firstOrNull;
    if (auth == null || auth.authorizedPupils == null) return null;
    return auth.authorizedPupils!
        .where((pa) => pa.pupilId == pupilId)
        .firstOrNull;
  }

  void _removePupilAuthListenablesForAuth(int authId) {
    _pupilAuthListenables.removeWhere((key, _) => key.startsWith('$authId-'));
  }

  /// Returns a [ValueListenable] that notifies only when this pupil's
  /// authorization changes. Cached per (authorizationId, pupilId).
  ValueListenable<PupilAuthorization?> watchPupilAuthorization(
    int authorizationId,
    int pupilId,
  ) {
    final key = '$authorizationId-$pupilId';
    return _pupilAuthListenables.putIfAbsent(
      key,
      () => _authorizations.select(
        (list) => _extractPupilAuth(list, authorizationId, pupilId),
      ),
    );
  }

  void _updateAuthsInCollections(List<Authorization> authorizations) {
    for (var authorization in authorizations) {
      _authorizationsMap[authorization.id!] = authorization;
    }
    _authorizations.value = _authorizationsMap.values.toList();
  }

  void _updatePupilAuthInCollections(PupilAuthorization pupilAuth) {
    final authId = pupilAuth.authorizationId;
    final authorization = _authorizationsMap[authId]!;
    final List<PupilAuthorization> pupilAuths = List.from(
      authorization.authorizedPupils!,
    );
    final index = pupilAuths.indexWhere(
      (element) => element.pupilId == pupilAuth.pupilId,
    );
    if (index != -1) {
      pupilAuths[index] = pupilAuth;
    } else {
      pupilAuths.add(pupilAuth);
    }
    _authorizationsMap[authId] = authorization.copyWith(
      authorizedPupils: pupilAuths,
    );
    _authorizations.value = _authorizationsMap.values.toList();
  }

  Future<void> fetchAuthorizations() async {
    final authorizations = await _authorizationApiService.fetchAuthorizations();
    if (authorizations == null) {
      return;
    }
    _updateAuthsInCollections(authorizations);
    _log.info('${authorizations.length} authorizations fetched');
    return;
  }

  Future<void> postAuthorizationWithPupils(
    String name,
    String description,
    List<int> pupilIds,
  ) async {
    final createdBy = _hubSessionManager.userName;
    final Authorization? authorization = await _authorizationApiService
        .postAuthorizationWithPupils(name, description, createdBy!, pupilIds);
    if (authorization == null) {
      return;
    }
    _authorizationsMap[authorization.id!] = authorization;
    _authorizations.value = _authorizationsMap.values.toList();

    _notificationService.showSnackBar(
      NotificationType.success,
      'Einwilligung erstellt',
    );

    return;
  }

  Future<void> updateAuthorization({
    required int authId,
    String? name,
    String? description,
    ({MemberOperation operation, List<int> pupilIds})? membersToUpdate,
  }) async {
    final updatedAuth = await ClientHelper.apiCall(
      call: () => _authorizationApiService.updateAuthorization(
        authId,
        name,
        description,
        membersToUpdate,
      ),
    );
    if (updatedAuth == null) {
      return;
    }
    _updateAuthsInCollections([updatedAuth]);
    _notificationService.showSnackBar(
      NotificationType.success,
      'Einwilligung geändert',
    );

    return;
  }

  Future<void> deleteAuthorization(int authId) async {
    final confirm = await _authorizationApiService.deleteAuthorization(authId);
    if (confirm == null) {
      return;
    }
    _authorizationsMap.remove(authId);
    _removePupilAuthListenablesForAuth(authId);
    _authorizations.value = _authorizationsMap.values.toList();

    _notificationService.showSnackBar(
      NotificationType.success,
      'Einwilligung gelöscht',
    );

    return;
  }

  Future<void> updatePupilAuthorization({
    required int pupilId,
    required int authorizationId,
    ({bool? value})? status,
    String? comment,
  }) async {
    final pupilAuth = _authorizationsMap[authorizationId]!.authorizedPupils!
        .where((element) => element.pupilId == pupilId)
        .first;
    final pupilAuthUpdate = pupilAuth.copyWith(
      status: status != null ? status.value : pupilAuth.status,
      comment: comment ?? pupilAuth.comment,
    );
    final updatedPupilAuth = await _authorizationApiService
        .updatePupilAuthorization(pupilAuthUpdate);
    if (updatedPupilAuth == null) {
      return;
    }
    _updatePupilAuthInCollections(updatedPupilAuth);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Einwilligung geändert',
    );

    return;
  }

  Future<void> addFileToPupilAuthorization(File file, int pupilAuthId) async {
    final encryptedFile = await customEncrypter.encryptFile(file);
    final createdBy = _hubSessionManager.userName;
    final pupilAuth = await _authorizationApiService
        .addFileToPupilAuthorization(pupilAuthId, encryptedFile, createdBy!);
    if (pupilAuth == null) {
      return;
    }
    _updatePupilAuthInCollections(pupilAuth);

    return;
  }

  Future<void> removeFileFromPupilAuthorization(
    int authId,
    String cacheKey,
  ) async {
    final pupilAuth = await _authorizationApiService
        .removeFileFromPupilAuthorization(authId);
    if (pupilAuth == null) {
      return;
    }
    _updatePupilAuthInCollections(pupilAuth);
    _cacheManager.removeFile(cacheKey);

    return;
  }

  //- diese Funktion hat keinen API-Call
  Authorization getAuthorization(int authId) {
    final Authorization authorizations = _authorizations.value
        .where((element) => element.id == authId)
        .first;

    return authorizations;
  }

  //- diese Funktion hat keinen API-Call
  // PupilAuthorization getPupilAuthorization(
  //   int pupilId,
  //   String authId,
  // ) {

  //   final PupilAuthorization pupilAuthorization = locator<AuthorizationManager>().
  //       .where((element) => element.originAuthorization == authId)
  //       .first;

  //   return pupilAuthorization;
  // }

  //- diese Funktion hat keinen API-Call
  // List<PupilProxy> getPupilsInAuthorization(
  //   String authorizationId,
  // ) {
  //   final List<PupilProxy> listedPupils = locator<PupilManager>()
  //       .allPupils
  //       .where((pupil) => pupil.authorizations!.any((authorization) =>
  //           authorization.originAuthorization == authorizationId))
  //       .toList();

  //   return listedPupils;
  // }

  //- diese Funktion hat keinen API-Call
  List<PupilProxy> getListedPupilsInAuthorization(
    int authorizationId,
    List<PupilProxy> filteredPupils,
  ) {
    final Authorization authorization = _authorizationsMap[authorizationId]!;
    final List<PupilProxy> listedPupils = filteredPupils
        .where(
          (pupil) => authorization.authorizedPupils!.any(
            (authorization) => authorization.authorizationId == authorizationId,
          ),
        )
        .toList();

    return listedPupils;
  }
}

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/authorizations/data/authorization_api_service.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:watch_it/watch_it.dart';

final _notificationService = di<NotificationService>();
final _authorizationApiService = AuthorizationApiService();
final _serverpodSessionManager = di<ServerpodSessionManager>();
final _cacheManager = di<DefaultCacheManager>();

class AuthorizationManager with ChangeNotifier {
  ValueListenable<List<Authorization>> get authorizations => _authorizations;

  final _authorizations = ValueNotifier<List<Authorization>>([]);

  Map<int, Authorization> _authorizationsMap = {};

  AuthorizationManager();

  Future<AuthorizationManager> init() async {
    _notificationService.showSnackBar(
        NotificationType.success, 'Einwilligungen werden geladen');
    await fetchAuthorizations();
    return this;
  }

  void clearData() {
    _authorizations.value = [];
    _authorizationsMap = {};
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
    final List<PupilAuthorization> pupilAuths =
        List.from(authorization.authorizedPupils!);
    final index = pupilAuths
        .indexWhere((element) => element.pupilId == pupilAuth.pupilId);
    if (index != -1) {
      pupilAuths[index] = pupilAuth;
    } else {
      pupilAuths.add(pupilAuth);
    }
    _authorizationsMap[authId] =
        authorization.copyWith(authorizedPupils: pupilAuths);
    _authorizations.value = _authorizationsMap.values.toList();
  }

  Future<void> fetchAuthorizations() async {
    final authorizations = await _authorizationApiService.fetchAuthorizations();

    _updateAuthsInCollections(authorizations);
    _notificationService.showSnackBar(NotificationType.success,
        '${authorizations.length} Einwilligungen geladen');

    return;
  }

  Future<void> postAuthorizationWithPupils(
    String name,
    String description,
    List<int> pupilIds,
  ) async {
    final createdBy = _serverpodSessionManager.userName;
    final Authorization authorization = await _authorizationApiService
        .postAuthorizationWithPupils(name, description, createdBy!, pupilIds);

    _authorizationsMap[authorization.id!] = authorization;
    _authorizations.value = _authorizationsMap.values.toList();

    _notificationService.showSnackBar(
        NotificationType.success, 'Einwilligung erstellt');

    return;
  }

  Future<void> updateAuthorization(
      {required int authId,
      String? name,
      String? description,
      ({
        MemberOperation operation,
        List<int> pupilIds
      })? membersToUpdate}) async {
    final updatedAuth = await ClientHelper.apiCall(
        call: () => _authorizationApiService.updateAuthorization(
            authId, name, description, membersToUpdate));

    _updateAuthsInCollections([updatedAuth]);
    _notificationService.showSnackBar(
        NotificationType.success, 'Einwilligung geändert');

    return;
  }

  Future<void> deleteAuthorization(int authId) async {
    final confirm = await _authorizationApiService.deleteAuthorization(authId);
    if (!confirm) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Einwilligung konnte nicht gelöscht werden');
      return;
    }
    _authorizationsMap.remove(authId);

    _authorizations.value = _authorizationsMap.values.toList();

    _notificationService.showSnackBar(
        NotificationType.success, 'Einwilligung gelöscht');

    return;
  }

  Future<void> updatePupilAuthorization(
      int pupilId, int authorizationId, bool? status, String? comment) async {
    final pupilAuth = _authorizationsMap[authorizationId]!
        .authorizedPupils!
        .where((element) => element.pupilId == pupilId)
        .first;
    final pupilAuthUpdate = pupilAuth.copyWith(
      status: status ?? pupilAuth.status,
      comment: comment ?? pupilAuth.comment,
    );
    final updatedPupilAuth = await _authorizationApiService
        .updatePupilAuthorization(pupilAuthUpdate);
    _updatePupilAuthInCollections(updatedPupilAuth);

    _notificationService.showSnackBar(
        NotificationType.success, 'Einwilligung geändert');

    return;
  }

  Future<void> addFileToPupilAuthorization(
    File file,
    int pupilAuthId,
  ) async {
    final encryptedFile = await customEncrypter.encryptFile(file);
    final createdBy = _serverpodSessionManager.userName;
    final pupilAuth = await _authorizationApiService
        .addFileToPupilAuthorization(pupilAuthId, encryptedFile, createdBy!);
    _updatePupilAuthInCollections(pupilAuth);

    return;
  }

  Future<void> removeFileFromPupilAuthorization(
    int authId,
    String cacheKey,
  ) async {
    final pupilAuth =
        await _authorizationApiService.removeFileFromPupilAuthorization(authId);
    _updatePupilAuthInCollections(pupilAuth);
    _cacheManager.removeFile(cacheKey);

    return;
  }

  //- diese Funktion hat keinen API-Call
  Authorization getAuthorization(
    int authId,
  ) {
    final Authorization authorizations =
        _authorizations.value.where((element) => element.id == authId).first;

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
        .where((pupil) => authorization.authorizedPupils!.any((authorization) =>
            authorization.authorizationId == authorizationId))
        .toList();

    return listedPupils;
  }
}

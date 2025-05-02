import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/domain/models/enums.dart';
import 'package:schuldaten_hub/common/services/api/api_settings.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_service.dart';
import 'package:schuldaten_hub/features/authorizations/domain/models/authorization.dart';
import 'package:schuldaten_hub/features/pupil/domain/models/pupil_proxy.dart';

class AuthorizationManager {
  ValueListenable<List<Authorization>> get authorizations => _authorizations;

  final _authorizations = ValueNotifier<List<Authorization>>([]);
  Map<String, Authorization> _authorizationsMap = {};

  AuthorizationManager();

  Future<AuthorizationManager> init() async {
    notificationService.showSnackBar(
        NotificationType.success, 'Einwilligungen werden geladen');
    await fetchAuthorizations();
    return this;
  }

  final notificationService = locator<NotificationService>();
  final authorizationApiService = AuthorizationApiService();

  void clearData() {
    _authorizations.value = [];
    _authorizationsMap = {};
  }

  Future<void> fetchAuthorizations() async {
    final authorizations = await authorizationApiService.fetchAuthorizations();

    notificationService.showSnackBar(NotificationType.success,
        '${authorizations.length} Einwilligungen geladen');

    _authorizations.value = authorizations;
    _authorizationsMap = {
      for (var authorization in authorizations)
        authorization.authorizationId: authorization
    };
    return;
  }

  Future<void> postAuthorizationWithPupils(
    String name,
    String description,
    List<int> pupilIds,
  ) async {
    final Authorization authorization = await authorizationApiService
        .postAuthorizationWithPupils(name, description, pupilIds);

    _authorizationsMap[authorization.authorizationId] = authorization;
    _authorizations.value = _authorizationsMap.values.toList();

    notificationService.showSnackBar(
        NotificationType.success, 'Einwilligung erstellt');

    return;
  }

  Future<void> deleteAuthorization(String authId) async {
    final confirm = await authorizationApiService.deleteAuthorization(authId);
    if (!confirm) {
      notificationService.showSnackBar(
          NotificationType.error, 'Einwilligung konnte nicht gelöscht werden');
      return;
    }
    _authorizationsMap.remove(authId);

    _authorizations.value = _authorizationsMap.values.toList();

    notificationService.showSnackBar(
        NotificationType.success, 'Einwilligung gelöscht');

    return;
  }

  Future<void> postPupilAuthorization(int pupilId, String authId) async {
    final Authorization authorization =
        await authorizationApiService.postPupilAuthorization(pupilId, authId);
    _authorizationsMap[authorization.authorizationId] = authorization;
    _authorizations.value = _authorizationsMap.values.toList();

    notificationService.showSnackBar(
        NotificationType.success, 'Einwilligung erstellt');
    return;
  }

  // Add pupils to an existing authorization
  Future<void> postPupilAuthorizations(
    List<int> pupilIds,
    String authId,
  ) async {
    final Authorization authorization =
        await authorizationApiService.postPupilAuthorizations(pupilIds, authId);

    _authorizationsMap[authorization.authorizationId] = authorization;
    _authorizations.value = _authorizationsMap.values.toList();

    notificationService.showSnackBar(
        NotificationType.success, 'Einwilligungen erstellt');
    return;
  }

  Future<void> deletePupilAuthorization(
    int pupilId,
    String authId,
  ) async {
    final Authorization authorization =
        await authorizationApiService.deletePupilAuthorization(pupilId, authId);

    _authorizationsMap[authorization.authorizationId] = authorization;
    _authorizations.value = _authorizationsMap.values.toList();

    notificationService.showSnackBar(
        NotificationType.success, 'Einwilligung gelöscht');
    return;
  }

  Future<void> updatePupilAuthorizationProperty(
      int pupilId, String listId, bool? value, String? comment) async {
    final Authorization authorization = await authorizationApiService
        .updatePupilAuthorizationProperty(pupilId, listId, value, comment);

    _authorizationsMap[authorization.authorizationId] = authorization;
    _authorizations.value = _authorizationsMap.values.toList();

    notificationService.showSnackBar(
        NotificationType.success, 'Einwilligung geändert');

    return;
  }

  Future<void> postAuthorizationFile(
    File file,
    int pupilId,
    String authId,
  ) async {
    final Authorization authorization = await authorizationApiService
        .postAuthorizationFile(file, pupilId, authId);

    _authorizationsMap[authorization.authorizationId] = authorization;
    _authorizations.value = _authorizationsMap.values.toList();

    notificationService.showSnackBar(
        NotificationType.success, 'Datei hochgeladen');

    return;
  }

  Future<void> deleteAuthorizationFile(
    int pupilId,
    String authId,
    String cacheKey,
  ) async {
    final Authorization responsePupil = await authorizationApiService
        .deleteAuthorizationFile(pupilId, authId, cacheKey);

    _authorizationsMap[responsePupil.authorizationId] = responsePupil;
    _authorizations.value = _authorizationsMap.values.toList();

    notificationService.showSnackBar(
        NotificationType.success, 'Einwilligungsdatei gelöscht');

    return;
  }

  //- diese Funktion hat keinen API-Call
  Authorization getAuthorization(
    String authId,
  ) {
    final Authorization authorizations = _authorizations.value
        .where((element) => element.authorizationId == authId)
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
    String authorizationId,
    List<PupilProxy> filteredPupils,
  ) {
    final Authorization authorization = _authorizationsMap[authorizationId]!;
    final List<PupilProxy> listedPupils = filteredPupils
        .where((pupil) => authorization.authorizedPupils.any((authorization) =>
            authorization.originAuthorization == authorizationId))
        .toList();

    return listedPupils;
  }
}

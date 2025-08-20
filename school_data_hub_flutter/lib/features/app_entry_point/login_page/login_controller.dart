import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/env/models/env.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/loading_page.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/login_page/login_page.dart';
import 'package:watch_it/watch_it.dart';

final _envManager = di<EnvManager>();
final _client = di<Client>();
final _notificationService = di<NotificationService>();

class Login extends WatchingStatefulWidget {
  const Login({super.key});

  @override
  LoginController createState() => LoginController();
}

class LoginController extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late Map<String, Env> envs;
  late Env? activeEnv;
  String selectedEnv = '';

  @override
  initState() {
    super.initState();
    if (_envManager.envIsReady.value) {
      envs = _envManager.envs;
      activeEnv = _envManager.activeEnv!;
      selectedEnv = activeEnv!.serverName;
    } else {
      envs = {};
      activeEnv = null;
    }
  }

  void deleteEnv() {
    _envManager.deleteEnv();
    setState(() {
      envs = _envManager.envs;
      activeEnv = _envManager.activeEnv!;
      selectedEnv = activeEnv!.serverName;
    });
    return;
  }

  void changeEnv(String? envName) {
    setState(() {
      selectedEnv = envName!;
      _envManager.activateEnv(envName: envName);
    });
  }

  scanCredentials(BuildContext context) async {
    final locale = AppLocalizations.of(context)!;
    final String? scanResponse =
        await qrScanner(context: context, overlayText: locale.scanAccessCode);
    if (scanResponse != null) {
      final loginData = await json.decode(scanResponse);
      final String username = loginData['username'];
      final String password = loginData['password'];

      attemptLogin(username: username, password: password);
    } else {
      _notificationService.showSnackBar(
          NotificationType.warning, locale.scanAborted);

      return;
    }
  }

  scanEnv(BuildContext context) async {
    final locale = AppLocalizations.of(context)!;
    final String? scanResponse =
        await qrScanner(context: context, overlayText: locale.scanSchoolId);
    if (scanResponse != null) {
      _envManager.importNewEnv(scanResponse);
      setState(() {
        envs = _envManager.envs;
        activeEnv = _envManager.activeEnv!;
        selectedEnv = activeEnv!.serverName;
      });
      return;
    } else {
      _notificationService.showSnackBar(
          NotificationType.warning, 'Keine Daten gescannt');
      return;
    }
  }

  List<DropdownMenuItem<String>> get envDropdownItems {
    return envs.keys
        .map((String key) => DropdownMenuItem<String>(
              value: key,
              child: Text(key),
            ))
        .toList();
  }

  Future<void> loginWithTextCredentials() async {
    final String username = usernameController.text;
    final String password = passwordController.text;
    await attemptLogin(username: username, password: password);
  }

  Future<void> attemptLogin(
      {required String username, required String password}) async {
    try {
      final authResponse = await _client.auth.login(username, password,
          DeviceInfo(deviceId: '1', deviceName: 'Test device'));

      if (authResponse.response.success) {
        _notificationService.showSnackBar(
            NotificationType.success, 'Erfolgreich eingeloggt!');
        await di<HubSessionManager>().registerSignedInUser(
          authResponse.response.userInfo!,
          authResponse.response.keyId!,
          authResponse.response.key!,
        );

        /// Don't forget to set the flag in [EnvManager] to false
        /// to get to the login screen.
        _envManager.setUserAuthenticatedOnlyByHubSessionManager(true);
        return;
      } else {
        _notificationService.showInformationDialog(
            'Login fehlgeschlagen: ${authResponse.response.failReason}');

        return;
      }
    } catch (e) {
      _notificationService.showInformationDialog('Fehler beim Einloggen: $e');
      return;
    }
  }

  Future<void> importEnvFromTxt() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      String rawTextResult = await file.readAsString();
      _envManager.importNewEnv(rawTextResult);
      setState(() {
        envs = _envManager.envs;
        activeEnv = _envManager.activeEnv!;
        selectedEnv = activeEnv!.serverName;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: di.allReady(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return LoginPage(controller: this);
        } else {
          return const LoadingPage();
        }
      },
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/env/models/env.dart';
import 'package:school_data_hub_flutter/core/env/utils/env_utils.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/loading_page.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/login_page/login_page.dart';
import 'package:watch_it/watch_it.dart';

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
    if (di<EnvManager>().envIsReady.value) {
      envs = di<EnvManager>().envs;
      activeEnv = di<EnvManager>().activeEnv!;
      selectedEnv = activeEnv!.name;
    } else {
      envs = {};
      activeEnv = null;
    }
  }

  void deleteEnv() {
    di<EnvManager>().deleteEnv();
    setState(() {
      envs = di<EnvManager>().envs;
      activeEnv = di<EnvManager>().activeEnv!;
      selectedEnv = activeEnv!.name;
    });
    return;
  }

  void changeEnv(String? envName) {
    setState(() {
      selectedEnv = envName!;
      di<EnvManager>().activateEnv(envName: envName);
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
      di<NotificationService>()
          .showSnackBar(NotificationType.warning, locale.scanAborted);

      return;
    }
  }

  scanEnv(BuildContext context) async {
    final locale = AppLocalizations.of(context)!;
    final String? scanResponse =
        await qrScanner(context: context, overlayText: locale.scanSchoolId);
    if (scanResponse != null) {
      di<EnvManager>().importNewEnv(scanResponse);
      setState(() {
        envs = di<EnvManager>().envs;
        activeEnv = di<EnvManager>().activeEnv!;
        selectedEnv = activeEnv!.name;
      });
      return;
    } else {
      di<NotificationService>()
          .showSnackBar(NotificationType.warning, 'Keine Daten gescannt');
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
    final authResponse = await di<Client>().auth.login(username, password,
        DeviceInfo(deviceId: '1', deviceName: 'Test device'));

    if (authResponse.success) {
      di<NotificationService>()
          .showSnackBar(NotificationType.success, 'Erfolgreich eingeloggt!');
      await di<ServerpodSessionManager>().registerSignedInUser(
        authResponse.userInfo!,
        authResponse.keyId!,
        authResponse.key!,
      );

      /// Don't forget to set the flag in [EnvManager] to false
      /// to get to the login screen.
      di<EnvManager>().setUserAuthenticated(true);
    } else {
      di<NotificationService>().showSnackBar(NotificationType.error,
          'Login fehlgeschlagen: ${authResponse.failReason}');
    }
  }

  Future<void> importEnvFromTxt() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      String rawTextResult = await file.readAsString();
      di<EnvManager>().importNewEnv(rawTextResult);
      setState(() {
        envs = di<EnvManager>().envs;
        activeEnv = di<EnvManager>().activeEnv!;
        selectedEnv = activeEnv!.name;
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

  Future<void> generateSchoolKeys(BuildContext context) async {
    final serverName = await shortTextfieldDialog(
        context: context,
        title: 'Servername',
        labelText: 'Servername',
        hintText: 'Geben Sie dem Server einen Namen');
    if (serverName == null || serverName.isEmpty) {
      return;
    }
    final serverUrl = await shortTextfieldDialog(
        context: context,
        title: 'Server URL',
        labelText: 'Server URL',
        hintText: 'Geben Sie die URL des Servers ein');
    if (serverUrl == null || serverUrl.isEmpty) {
      return;
    }
    await EnvUtils.generateNewEnvKeys(
        serverName: serverName, serverUrl: serverUrl);

    di<NotificationService>().showSnackBar(
        NotificationType.success, 'Schulschlüssel erfolgreich generiert');
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

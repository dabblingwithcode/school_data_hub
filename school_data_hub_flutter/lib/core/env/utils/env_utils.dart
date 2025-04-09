import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:watch_it/watch_it.dart';

final _notificationService = di<NotificationService>();

class EnvUtils {
  static Future<void> generateNewEnvKeys(
      {required String serverUrl, required String serverName}) async {
    String generateRandomUtf8StringOfLength(int length) {
      const chars =
          'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
      final random = math.Random.secure();
      return List.generate(
          length, (index) => chars[random.nextInt(chars.length)]).join();
    }

    final key = generateRandomUtf8StringOfLength(32);

    final iv = generateRandomUtf8StringOfLength(16);

    final String schoolKey = jsonEncode(
        {"server": serverName, "key": key, "iv": iv, "server_url": serverUrl});

    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      // Save the file in the selected directory
      final schoolKeyFile =
          File('$selectedDirectory/school_key_$serverName.txt');
      await schoolKeyFile.writeAsString(schoolKey);
    } else {
      _notificationService.showSnackBar(
          NotificationType.error, 'Aktion abgebrochen');
    }
    return;
  }

  static Future<({String deviceId, String deviceName})>
      getDeviceNameAndId() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isWindows) {
      final windowsInfo = await deviceInfo.windowsInfo;
      return (
        deviceName: windowsInfo.computerName,
        deviceId: windowsInfo.deviceId
      );
    } else if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return (
        deviceName: androidInfo.model,
        deviceId: androidInfo.id,
      );
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return (
        deviceName: iosInfo.name,
        deviceId: iosInfo.modelName,
      );
    } else {
      return (
        deviceId: 'Unknown Device',
        deviceName: 'Unknown Device',
      );
    }
  }
}

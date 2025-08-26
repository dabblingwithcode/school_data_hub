import 'dart:developer';

import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

Future<void> storeUserDevice({
  required Session session,
  required int userInfoId,
  required int authId,
  required UserDevice user,
}) async {
  // Find existing device
  var existingDevice = await UserDevice.db.findFirstRow(
    session,
    where: (t) =>
        t.userInfoId.equals(userInfoId) & t.deviceId.equals(user.deviceId),
  );

  if (existingDevice != null) {
    // Update existing device with new auth key
    existingDevice.lastLogin = DateTime.now().toUtc();
    existingDevice.isActive = true;
    existingDevice.authId = authId;
    await UserDevice.db.updateRow(session, existingDevice);
  } else {
    // Create new device entry
    var userDevice = UserDevice(
      userInfoId: userInfoId,
      deviceId: user.deviceId,
      deviceName: user.deviceName,
      lastLogin: DateTime.now().toUtc(),
      isActive: true,
      authId: authId,
    );
    final newDeviceInDatabase =
        await UserDevice.db.insertRow(session, userDevice);
    log('New device created: ${newDeviceInDatabase.deviceId}');
    log('User ID: ${newDeviceInDatabase.userInfoId}');
  }
}

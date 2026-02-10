import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

Future<List<UserDevice>> getUserDevices(Session session, int userInfoId) async {
  final devices = await UserDevice.db.find(
    session,
    where: (t) => t.userInfoId.equals(userInfoId),
    orderBy: (t) => t.lastLogin,
    orderDescending: true,
  );
  return (devices);
}

/// Fetches devices for multiple userInfoIds in parallel. Returns a map of
/// userInfoId -> list of devices (by lastLogin desc).
Future<Map<int, List<UserDevice>>> getUserDevicesByUserInfoIds(
  Session session,
  List<int> userInfoIds,
) async {
  if (userInfoIds.isEmpty) return {};
  final ids = userInfoIds.toSet().toList();
  final results = await Future.wait(
    ids.map((id) => getUserDevices(session, id)),
  );
  return Map.fromIterables(ids, results);
}

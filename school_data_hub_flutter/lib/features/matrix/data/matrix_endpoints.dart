class MatrixEndpoints {
  // synapse admin API: [https://element-hq.github.io/synapse/latest/usage/administration/admin_api/index.html]
  // synapse admin user API: [https://element-hq.github.io/synapse/latest/admin_api/user_admin_api.html]
  //- PUT POLICY

//**- USER

  //- PUT USER
  String createMatrixUser(String userId) {
    return '_synapse/admin/v2/users/$userId';
  }

  //- DELETE USER
  String deleteMatrixUser(String userId) {
    return '_synapse/admin/v2/users/$userId/deactivate';
  }

//- PUT

//- CREATE ROOM

  static const String createRoom = '_matrix/client/v3/createRoom';
// https://spec.matrix.org/v1.10/client-server-api/#creation

// -XPOST -d '{
//   "creation_content": {
//     "m.federate": false
//   },
//   "name": "Testraum",
//   "preset": "private_chat",
//   "room_alias_name": "testraum",
//   "topic": "Das ist ein Testraum"
// }' "https://post.hermannschule.de/_matrix/client/v3/createRoom"

//- GET MEDIA
// https://spec.matrix.org/v1.10/client-server-api/#get_matrixmediav3downloadservernamemediaid
// GET /_matrix/media/v3/download/{serverName}/{mediaId}
  //- GET ROOM NAME
  // String fetchRoomName(String roomId) {
  //   return '_synapse/admin/v1/rooms/$roomId';
  // }
  String fetchRoomName(String roomId) {
    return '_matrix/client/v3/rooms/$roomId/state/m.room.name';
    //return '_synapse/admin/v1/rooms/$roomId/state';
  }

  String fetchRoomPowerLevels(String roomId) {
    return '_matrix/client/v3/rooms/$roomId/state/m.room.power_levels';
  }

  //- PUT ROOM POWER LEVELS
  String putRoomPowerLevels(String roomId) {
    return '_matrix/client/v3/rooms/$roomId/state/m.room.power_levels';
  }

  String setRoomPowerLevels(String roomId) {
    return '_matrix/client/v3/rooms/$roomId/state/m.room.power_levels';
  }
//- curl --header "Authorization: Bearer $accessToken"
//-X PUT -d '{"ban": 50,"events":
// - {"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100,"m.space.child":50,"m.room.topic":50,"m.room.pinned_events":50,"m.reaction":50,"m.room.redaction":0,"org.matrix.msc3401.call":50,"org.matrix.msc3401.call.member":50,"im.vector.modular.widgets":50,"io.element.voice_broadcast_info":50},"events_default": 50,"invite": 50,"kick": 50,"notifications": {"room": 20},"redact": 50,"state_default": 50,"users": {"@mxcorporal:hermannschule.de": 100},"users_default": 0}'
// - "https://post.hermannschule.de/_matrix/client/v3/rooms/%21hcFshNfUbzzoRDXmKe%3Ahermannschule.de/state/m.room.power_levels/"
}

// import 'dart:convert';
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:school_data_hub_flutter/common/services/notification_service.dart';
// import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_helper_functions.dart';
// import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
// import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_room.dart';
// import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_user.dart';
// import 'package:school_data_hub_flutter/features/matrix/domain/models/policy.dart';
// import 'package:school_data_hub_flutter/features/matrix/services/api/api_client.dart';
// import 'package:school_data_hub_flutter/features/matrix/services/api/api_settings.dart';
// import 'package:watch_it/watch_it.dart';

// enum MatrixAuthType { matrix, corporal }

// enum ChatTypePreset {
//   public('public_chat'),
//   private('private_chat'),
//   trustedPrivate('trusted_private_chat'),
//   ;

//   final String value;
//   const ChatTypePreset(this.value);
// }

// final _matrixPolicyManager = di<MatrixPolicyManager>();

// final _notificationService = di<NotificationService>();

// class MatrixApiService {
//   final _apiClient = ApiClient(Dio());

//   String _matrixUrl;
//   String _matrixToken;
//   String _corporalToken;
//   MatrixApiService({
//     required String matrixUrl,
//     required String matrixToken,
//     required String corporalToken,
//   })  : _matrixUrl = matrixUrl,
//         _matrixToken = matrixToken,
//         _corporalToken = corporalToken {
//     _apiClient.setApiOptions(
//         tokenKey: Token.matrix, token: 'Bearer $_matrixToken');
//     _apiClient.setApiOptions(
//         tokenKey: Token.corporal, token: 'Bearer $_corporalToken');
//   }

//   void setMatrixEnvironmentValues(
//       {required String url,
//       required String matrixToken,
//       required String policyToken}) {
//     _matrixUrl = url;
//     _matrixToken = matrixToken;
//     _corporalToken = policyToken;
//     return;
//   }

//   // Options _requestOptions({required MatrixAuthType authType}) {
//   //   final token =
//   //       authType == MatrixAuthType.matrix ? _matrixToken : _corporalToken;

//   //   return Options(headers: {'Authorization': 'Bearer $token'});
//   // }

//   Future<Policy?> fetchMatrixPolicy() async {
//     final response = await _apiClient.get(
//       '$_matrixUrl/_matrix/corporal/policy',
//       options: _apiClient.corporalOptions,
//     );

//     if (response.statusCode != 200) {
//       _notificationService.showSnackBar(
//           NotificationType.error, 'Fehler: status code ${response.statusCode}');
//       throw ApiException('Fehler beim Laden der Policy', response.statusCode);
//     }
//     final Policy policy = Policy.fromJson(response.data['policy']);
//     _notificationService.showSnackBar(
//         NotificationType.success, 'Matrix-Räumeverwaltung geladen');

//     return policy;
//   }

// //- CREATE ROOM
// // curl --header "Authorization: Bearer <token>" XPOST -d '{
// // "creation_content": {"m.federate": false},
// // "is_direct": false, "name": "TestraumNeu3",  "preset": "private_chat",
// // "room_alias_name": "testraum3", "topic": "Das ist ein Testraum", "visibility": "private",
// // "power_level_content_override": {
// // "ban": 50,
// //       "events": {
// //         "m.room.name": 50,
// //         "m.room.power_levels": 100,
// //         "m.room.history_visibility": 100,
// //         "m.room.canonical_alias": 50,
// //         "m.room.avatar": 50,
// //         "m.room.tombstone": 100,
// //         "m.room.server_acl": 100,
// //         "m.room.encryption": 100,
// //         "m.space.child": 50,
// //         "m.room.topic": 50,
// //         "m.room.pinned_events": 50,
// //         "m.reaction": 65,
// //         "m.room.redaction": 0,
// //         "org.matrix.msc3401.call": 50,
// //         "org.matrix.msc3401.call.member": 50,
// //         "im.vector.modular.widgets": 50,
// //         "io.element.voice_broadcast_info": 50
// //       },
// //       "events_default": 25,
// //       "invite": 100,
// //       "kick": 100,
// //       "notifications": {"room": 20},
// //       "redact": 50,
// //       "state_default": 50,
// //       "users": { "@mxcorporal:hermannschule.de": 100},
// //       "users_default": 0}

// // }' "https://post.hermannschule.de/_matrix/client/v3/createRoom"

// //- https://spec.matrix.org/v1.10/client-server-api/#creation

// // XPOST -d '{
// //   "creation_content": {
// //     "m.federate": false
// //   },
// // "is_direct": false,
// //   "name": "Testraum",
// //   "preset": "private_chat",
// //   "room_alias_name": "testraum",
// //   "topic": "Das ist ein Testraum",
// //    "visibility": "private"
// // }' "https://post.hermannschule.de/_matrix/client/v3/createRoom"

//   static const String _createRoom = '/_matrix/client/v3/createRoom';

//   Future<MatrixRoom?> createMatrixRoom(
//       {required String name,
//       required String topic,
//       required ChatTypePreset chatTypePreset,
//       String? aliasName}) async {
//     MatrixRoom? room;
//     //- API: https://spec.matrix.org/latest/client-server-api/#create-room
//     final data = jsonEncode({
//       "creation_content": {"m.federate": false},
//       "is_direct": false,
//       "name": name,
//       "preset": "private_chat",
//       if (aliasName != null) "room_alias_name": aliasName,
//       "topic": topic,
//       "visibility": 'private',
//       "power_level_content_override": {
//         "users": {"${di<MatrixPolicyManager>().matrixAdmin}": 100},
//         "events": {"m.room.name": 50},
//         "users_default": 0,
//         "events_default": 50,
//         "state_default": 50,
//         "ban": 100,
//         "kick": 100,
//         "invite": 100,
//         "redact": 50
//       }
//     });

//     final Response response = await _apiClient.post(
//       '$_matrixUrl$_createRoom',
//       data: data,
//       options: _apiClient.matrixOptions,
//     );
//     if (response.statusCode == 200) {
//       // extract the value of "room_id" out of the response
//       final String roomId = response.data['room_id'];
//       room = await fetchAdditionalRoomInfos(roomId);
//     }

//     return room;
//   }

//   //- GET ROOMS

//   // Future<List<MatrixRoom>?> fetchMatrixRooms() async {
//   //   List<MatrixRoom> rooms = [];
//   //   // use a custom client with the right token to fetch the policy
//   //   _dioClient.setCustomDioClientOptions(
//   //       baseUrl: _matrixUrl,
//   //       tokenKey: 'Authorization',
//   //       token: 'Bearer $_synapseToken');

//   //   notificationService.showSnackBar(
//   //       NotificationType.success, 'Matrix-Räume werden geladen...');

//   //   for (String roomId in policy.managedRoomIds) {
//   //     MatrixRoom namedRoom = await _fetchAdditionalRoomInfos(roomId);
//   //     rooms.add(namedRoom);
//   //   }
//   // }

//   //- PUT POLICY

//   static const String _putMatrixPolicy = '/_matrix/corporal/policy';

//   Future<void> putMatrixPolicy() async {
//     final File policyFile = await MatrixPolicyHelper.generatePolicyJsonFile();
//     final bytes = policyFile.readAsBytesSync();

//     final Response response = await _apiClient.put(
//       '$_matrixUrl$_putMatrixPolicy',
//       data: bytes,
//       options: _apiClient.corporalOptions,
//     );
//     //delete file, we don't need it anymore
//     // policyFile.deleteSync();
//     if (response.statusCode != 200) {
//       _notificationService.showSnackBar(
//           NotificationType.error, 'Fehler: status code ${response.statusCode}');
//       throw ApiException('Fehler beim Setzen der Policy', response.statusCode);
//     }

//     _notificationService.showSnackBar(
//         NotificationType.success, 'Policy erfolgreich gesetzt');

//     return;
//   }

//   //**- MATRIX USER

//   //- PUT MATRIX USER
//   String _createMatrixUser(String userId) {
//     return '/_synapse/admin/v2/users/$userId';
//   }

//   Future<MatrixUser?> createNewMatrixUser({
//     required String matrixId,
//     required String displayName,
//     required String password,
//   }) async {
//     final data = jsonEncode({
//       "user_id": matrixId,
//       "password": password,
//       "admin": false,
//       "displayname": displayName,
//       "threepids": [],
//       "avatar_url": ""
//     });

// // Add before your PUT request
//     print('Matrix API Request:');
//     print('URL: $_matrixUrl${_createMatrixUser(matrixId)}');
//     print('Data: $data');
//     print('Headers: ${_apiClient.matrixOptions.headers}');

//     final Response response = await _apiClient.put(
//       '$_matrixUrl${_createMatrixUser(matrixId)}',
//       data: data,
//       options: _apiClient.matrixOptions,
//     );
//     // statuscode 201 means: User created
//     if (!(response.statusCode == 201 || response.statusCode == 200)) {
//       _notificationService.showSnackBar(
//           NotificationType.error, 'Fehler: status code ${response.statusCode}');
//       throw ApiException(
//           'Fehler beim Erstellen des Benutzers', response.statusCode);
//     }
//     final MatrixUser newUser = MatrixUser(
//       id: matrixId,
//       displayName: displayName,
//       joinedRooms: [],
//       active: true,
//       authType: "passthrough",
//     );
//     if (response.statusCode == 201) {
//       _notificationService.showSnackBar(
//           NotificationType.success, 'Benutzer erstellt');
//     }
//     if (response.statusCode == 200) {
//       _notificationService.showSnackBar(
//           NotificationType.success, 'Deaktivierter Benutzer reaktiviert');
//     }

//     return newUser;
//   }

//   //- DELETE USER
//   String _deleteMatrixUser(String userId) {
//     // return '/_synapse/admin/v2/users/$userId/deactivate';
//     return '/_synapse/admin/v1/deactivate/$userId';
//   }

//   Future<bool> deleteMatrixUser(String userId) async {
//     final data = jsonEncode({
//       "erase": true,
//     });
//     final Response response = await _apiClient.post(
//       '$_matrixUrl${_deleteMatrixUser(userId)}',
//       data: data,
//       options: _apiClient.matrixOptions,
//     );

//     if (response.statusCode != 200) {
//       _notificationService.showSnackBar(
//           NotificationType.error, 'Fehler: status code ${response.statusCode}');

//       return false;
//     }

//     return true;
//   }

//   String _resetPassword(String userId) {
//     return '/_synapse/admin/v1/reset_password/$userId';
//   }

//   Future<bool> resetPassword(
//       {required String userId,
//       required String newPassword,
//       bool? logoutDevices}) async {
//     final data = jsonEncode({
//       "new_password": newPassword,
//       "logout_devices": logoutDevices,
//     });

//     final Response response = await _apiClient.post(
//       '$_matrixUrl${_resetPassword(userId)}',
//       data: data,
//       options: _apiClient.matrixOptions,
//     );

//     if (response.statusCode != 200) {
//       _notificationService.showSnackBar(
//           NotificationType.error, 'Fehler: status code ${response.statusCode}');

//       return false;
//     }

//     return true;
//   }

//   //- GET USER
//   String _fetchMatrixUser(String userId) {
//     return '/_synapse/admin/v2/users/$userId';
//   }

//   Future<MatrixUser?> fetchMatrixUserById(String userId) async {
//     final Response response = await _apiClient.get(
//       '$_matrixUrl${_fetchMatrixUser(userId)}',
//       options: _apiClient.matrixOptions,
//     );

//     if (response.statusCode == 200) {
//       final MatrixUser user = MatrixUser.fromJson(response.data);

//       return user;
//     }

//     return null;
//   }

// //- PUT

// //- GET MEDIA
// // https://spec.matrix.org/v1.10/client-server-api/#get_matrixmediav3downloadservernamemediaid
// // GET /_matrix/media/v3/download/{serverName}/{mediaId}
//   //- GET ROOM NAME
//   // String fetchRoomName(String roomId) {
//   //   return '_synapse/admin/v1/rooms/$roomId';
//   // }
//   String _fetchRoomName(String roomId) {
//     return '/_matrix/client/v3/rooms/$roomId/state/m.room.name';
//     //return '_synapse/admin/v1/rooms/$roomId/state';
//   }

//   String _fetchRoomPowerLevelsUrl(String roomId) {
//     return '/_matrix/client/v3/rooms/$roomId/state/m.room.power_levels';
//   }

//   Future<MatrixRoom> fetchAdditionalRoomInfos(String roomId) async {
//     String? name;
//     int? powerLevelReactions;
//     int? eventsDefault;
//     List<RoomAdmin>? roomAdmins;

//     // First API call
//     final responseRoomSPowerLevels = await _apiClient.get(
//       // ignore: unnecessary_string_interpolations
//       '$_matrixUrl${_fetchRoomPowerLevelsUrl(roomId)}',
//       options: _apiClient.matrixOptions,
//     );

//     if (responseRoomSPowerLevels.statusCode == 200) {
//       powerLevelReactions =
//           responseRoomSPowerLevels.data['events']['m.reaction'] ?? 0;
//       eventsDefault = responseRoomSPowerLevels.data['events_default'] ?? 0;

//       if (responseRoomSPowerLevels.data['users'] is Map<String, dynamic>) {
//         final usersMap =
//             responseRoomSPowerLevels.data['users'] as Map<String, dynamic>;
//         roomAdmins = usersMap.keys
//             .map(
//                 (userId) => RoomAdmin(id: userId, powerLevel: usersMap[userId]))
//             .toList();
//       }
//     }
//     // if (roomId == '!RHMRhueGNUwEHjoMkm:hermannschule.de') {
//     //   debugger();
//     // }
//     // Second API call
//     final responseRoomName = await _apiClient.get(
//       // ignore: unnecessary_string_interpolations
//       '$_matrixUrl${_fetchRoomName(roomId)}',
//       options: _apiClient.matrixOptions,
//     );

//     if (responseRoomName.statusCode == 200) {
//       name = responseRoomName.data['name'] ?? 'No Room Name';
//     }

//     MatrixRoom roomWithAdditionalInfos = MatrixRoom(
//       id: roomId,
//       name: name,
//       powerLevelReactions: powerLevelReactions,
//       eventsDefault: eventsDefault,
//       roomAdmins: roomAdmins,
//     );

//     return roomWithAdditionalInfos;
//   }

//   //- PUT ROOM POWER LEVELS
//   String _putRoomPowerLevels(String roomId) {
//     // ensure that ! and : are properly coded for the url
//     final roomIdforUrl = roomId.replaceAllMapped(
//       RegExp(r'[!:]'),
//       (match) {
//         switch (match.group(0)) {
//           case '!':
//             return '%21';
//           case ':':
//             return '%3A';
//           default:
//             return match.group(0)!;
//         }
//       },
//     );
//     return '/_matrix/client/v3/rooms/$roomIdforUrl/state/m.room.power_levels';
//   }

//   Future<MatrixRoom> changeRoomPowerLevels(
//       {required String roomId,
//       RoomAdmin? newRoomAdmin,
//       String? removeAdminWithId,
//       int? eventsDefault,
//       int? reactions}) async {
//     List<RoomAdmin> adminPowerLevels = [];

//     Map<String, dynamic> adminPowerLevelsMap = {};

//     final matrixRoom = _matrixPolicyManager.getRoomById(roomId);
// // We make sure that the instance admin has admin power level in the room
//     adminPowerLevels = matrixRoom.roomAdmins ??
//         [RoomAdmin(id: _matrixPolicyManager.matrixAdmin!, powerLevel: 100)];

//     if (newRoomAdmin != null) {
//       adminPowerLevels.add(newRoomAdmin);
//     }
//     if (removeAdminWithId != null) {
//       adminPowerLevels.removeWhere((admin) => admin.id == removeAdminWithId);
//     }

//     for (RoomAdmin admin in adminPowerLevels) {
//       adminPowerLevelsMap[admin.id] = admin.powerLevel;
//     }

//     final data = jsonEncode({
//       "ban": 50,
//       "events": {
//         "m.room.name": 50,
//         "m.room.power_levels": 100,
//         "m.room.history_visibility": 100,
//         "m.room.canonical_alias": 50,
//         "m.room.avatar": 50,
//         "m.room.tombstone": 100,
//         "m.room.server_acl": 100,
//         "m.room.encryption": 100,
//         "m.space.child": 50,
//         "m.room.topic": 50,
//         "m.room.pinned_events": 50,
//         "m.reaction": reactions ?? matrixRoom.powerLevelReactions,
//         "m.room.redaction": 0,
//         "org.matrix.msc3401.call": 50,
//         "org.matrix.msc3401.call.member": 50,
//         "im.vector.modular.widgets": 50,
//         "io.element.voice_broadcast_info": 50
//       },
//       "events_default": eventsDefault ?? matrixRoom.eventsDefault,
//       "invite": 50,
//       "kick": 50,
//       "notifications": {"room": 20},
//       "redact": 50,
//       "state_default": 50,
//       "users": adminPowerLevelsMap,
//       "users_default": 0
//     });

//     final Response response = await _apiClient.put(
//       '$_matrixUrl${_putRoomPowerLevels(roomId)}',
//       data: data,
//       options: _apiClient.matrixOptions,
//     );

//     if (response.statusCode != 200) {
//       _notificationService.showSnackBar(
//           NotificationType.error, 'Fehler: status code ${response.statusCode}');
//       throw ApiException(
//           'Fehler beim Setzen der Power Levels', response.statusCode);
//     }

//     final MatrixRoom room = await fetchAdditionalRoomInfos(roomId);

//     return room;
//   }
// }

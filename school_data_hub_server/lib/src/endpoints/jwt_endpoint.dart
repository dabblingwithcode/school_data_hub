// import 'package:school_data_hub_server/src/auth/custom_auth.dart';
// import 'package:serverpod/serverpod.dart';
// import 'package:serverpod_auth_server/serverpod_auth_server.dart';

// class JwtEndpoint extends Endpoint {
//   @override
//   bool get requireLogin => true;

//   Future<JwtResponse> getNewJwt(Session session) async {
//     try {
//       @override

//       // final jwt = JWT.verify(
//           //   refreshToken,
//           //   SecretKey('your-refresh-token-secret'),
//           // );

//           // final userId = jwt.payload['userId'] as int?;

//           // if (userId == null) {
//           //   return RefreshResponse(
//           //       success: false, message: 'Invalid refresh token');
//           // }

//           // Check if user still exists and is active
//           final authInfo = await session.authenticated;
//       if (authInfo == null) {
//         return JwtResponse(success: false, message: 'User not authenticated');
//       }
//       final userId = authInfo.userId;
//       final user = await session.db.findById<UserInfo>(userId);

//       if (user == null) {
//         return JwtResponse(success: false, message: 'User not found');
//       }

//       // Generate new access token
//       final userScopes = authInfo.scopes;
//       final newAccessToken = generateJwtToken(
//         userId,
//         scopes: userScopes.map((scope) => scope.name!).toSet(),
//         expiry: Duration(hours: 1),
//       );

//       return JwtResponse(
//         success: true,
//         accessToken: newAccessToken,
//       );
//     } catch (e) {
//       return JwtResponse(success: false, message: 'Invalid refresh token');
//     }
//   }
// }

// class JwtResponse {
//   final bool success;
//   final String? accessToken;
//   final String? message;

//   JwtResponse({
//     this.success = false,
//     this.accessToken,
//     this.message,
//   });

//   Map<String, dynamic> toJson() => {
//         'success': success,
//         'accessToken': accessToken,
//         'message': message,
//       };
// }

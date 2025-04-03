// import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
// import 'package:serverpod/serverpod.dart';

// Future<AuthenticationInfo?> customAuthenticationHandler(
//     Session session, String token) async {
//   try {
//     // Remove 'Bearer ' prefix if present
//     if (token.startsWith('Bearer ')) {
//       token = token.substring(7);
//     }

//     // Verify and decode the JWT token
//     final jwt = JWT.verify(
//       token,
//       SecretKey(
//           'your-secret-key'), // Use a secure secret key, preferably from environment variables
//     );

//     // Extract user ID and scopes from the payload
//     final payload = jwt.payload;
//     final userId = payload['userId'] as int?;
//     final scopesList = payload['scopes'] as List<dynamic>?;

//     if (userId == null) return null;

//     // Convert scope strings to Scope objects
//     final scopes =
//         scopesList?.map((scope) => Scope(scope.toString())).toSet() ??
//             <Scope>{};

//     // Return authentication info
//     return AuthenticationInfo(userId, scopes);
//   } catch (e) {
//     // Token verification failed
//     session.log('JWT verification failed: $e');
//     return null;
//   }
// }

// String generateJwtToken(int userId,
//     {Set<String> scopes = const {},
//     Duration expiry = const Duration(days: 7)}) {
//   // Create a JWT
//   final jwt = JWT(
//     {
//       'userId': userId,
//       'scopes': scopes.toList(),
//       // Add additional claims as needed
//       'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000, // Issued at time
//     },
//     issuer: 'your-app-name',
//   );

//   // Sign the JWT
//   return jwt.sign(
//     SecretKey('your-secret-key'), // Use a secure secret key
//     expiresIn: expiry, // Token expiry time
//   );
// }

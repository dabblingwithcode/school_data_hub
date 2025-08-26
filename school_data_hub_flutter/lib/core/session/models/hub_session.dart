// class HubSession {
//   final String? username;
//   final String? publicId;

//   final bool? isAdmin;
//   final String? role;
//   final int? credit;
//   final int? timeUnits;
//   final String? contact;
//   final String? tutoring;

//   HubSession({
//     this.username,
//     this.publicId,
//     this.isAdmin,
//     this.role,
//     this.credit,
//     this.timeUnits,
//     this.contact,
//     this.tutoring,
//   });

//   HubSession copyWith({
//     String? server,
//     String? username,
//     String? publicId,
//     String? jwt,
//     bool? isAdmin,
//     String? role,
//     int? credit,
//     int? timeUnits,
//     String? contact,
//     String? tutoring,
//   }) =>
//       HubSession(
//         username: username ?? this.username,
//         publicId: publicId ?? this.publicId,
//         isAdmin: isAdmin ?? this.isAdmin,
//         role: role ?? this.role,
//         credit: credit ?? this.credit,
//         timeUnits: timeUnits ?? this.timeUnits,
//         contact: contact ?? this.contact,
//         tutoring: tutoring ?? this.tutoring,
//       );

//   factory HubSession.fromJson(final Map<String, dynamic> json) => HubSession(
//         username: json["name"],
//         publicId: json["public_id"],
//         isAdmin: json["admin"],
//         role: json["role"],
//         credit: json["credit"],
//         timeUnits: json["time_units"],
//         contact: json["contact"],
//         tutoring: json["tutoring"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": username,
//         "public_id": publicId,
//         "admin": isAdmin,
//         "role": role,
//         "credit": credit,
//         "time_units": timeUnits,
//         "contact": contact,
//         "tutoring": tutoring,
//       };
// }

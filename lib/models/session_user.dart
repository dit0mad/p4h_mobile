

// import 'package:p4h_mobile/appstate/user/user_state.dart';

// class SessionUser extends UserStatus {
//   final int id;
//   final String username;
//   final int canvasId;
//   final String email;
//   final String name;
//   final String school;
//   final String phone;

//   const SessionUser(
//       {required this.id,
//       required this.username,
//       required this.canvasId,
//       required this.email,
//       required this.name,
//       required this.phone,
//       required this.school});

//   factory SessionUser.fromJson(Map<String, dynamic> data) {
//     final id = data['id'] ?? 'empty';
//     final username = data['username'] ?? 'username';
//     final canvasId = data['canvasId'] ?? 'canvasId';
//     final email = data['email'] ?? 'email';
//     final phone = data['phone'] ?? 'phone';
//     final name = data['name'] ?? 'name';
//     final school = data['school'] ?? 'school';
//     return SessionUser(
//         id: id,
//         username: username,
//         canvasId: canvasId,
//         email: email,
//         phone: phone,
//         name: name,
//         school: school);
//   }

//   SessionUser copyWith({
//     required final canvasId,
//     required final isActive,
//     required final isAnonymous,
//     required final isAuthenticated,
//     required final uuid,
//   }) =>
//       SessionUser(
//           id: id,
//           username: username,
//           canvasId: canvasId,
//           email: email,
//           phone: phone,
//           name: name,
//           school: school);

//   // Map<String, dynamic> toJson() => {
//   //      'id':id,
//   //      'use'
//   //     };
// }

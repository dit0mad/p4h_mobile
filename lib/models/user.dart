import 'package:p4h_mobile/appstate/user/user_state.dart';

class User extends UserStatus {
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      canvasID: json["canvasId"],
      bio: json['bio'],
      email: json['email'],
      id: json['id'],
      name: json['name'],
      username: json['name'],
      location: json['location'],
      school: json['school'],
      phone: json['phone'],
    );
  }

  final String? bio;
  final int canvasID;
  final String email;
  final int id;
  final String? location;
  final String name;
  final String? phone;
  final String? school;
  final String username;

  final bool loggedIn;

  const User({
    this.bio,
    required this.canvasID,
    required this.email,
    required this.id,
    this.location,
    required this.name,
    this.phone,
    this.school,
    required this.username,
    this.loggedIn = false,
  });

  User get userState => this;

  User copyWith({
    final String? bio,
    final int? canvasID,
    final String? email,
    final int? id,
    final String? location,
    final String? name,
    final String? phone,
    final String? school,
    final String? username,
    final bool? loggedIn,
  }) {
    return User(
      canvasID: canvasID ?? this.canvasID,
      email: email ?? this.email,
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      phone: phone ?? this.phone,
      school: school ?? this.school,
      bio: bio ?? this.bio,
      username: username ?? this.username,
      loggedIn: loggedIn ?? this.loggedIn,
    );
  }
}
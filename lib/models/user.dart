import 'dart:convert';

import 'package:p4h_mobile/appstate/user/user_state_old.dart';
import 'package:p4h_mobile/models/resource.dart';
import 'package:p4h_mobile/models/user_post.dart';
import 'package:p4h_mobile/services/http_service.dart';

class UserSuccess extends UserStatus {
  factory UserSuccess.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserSuccess(
      canvasID: json["canvasId"],
      bio: json['bio'],
      email: json['email'],
      id: json['id'],
      name: json['name'],
      username: json['name'],
      location: json['location'],
      school: json['school'],
      phone: json['phone'],
      profilePic: json['profilePic'],
    );
  }

  final StoreCookie cookie;

  final String? bio;
  final int canvasID;
  final String email;
  final int id;
  final String? location;
  final String name;
  final String? phone;
  final String? school;
  final String username;
  final String? profilePic;

  final bool loggedIn;

  final List<UserPost> userPost;

  final List<UserResourceResponseSuccess> resources;

  const UserSuccess({
    this.cookie = StoreCookie.nothing,
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
    this.userPost = const [],
    this.resources = const [],
    this.profilePic,
  });

  UserSuccess get userState => this;

  UserSuccess copyWith({
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
    final StoreCookie? cookie,
    final List<UserPost>? userPost,
    final List<UserResourceResponseSuccess>? resources,
    final String? profilePic,
  }) {
    return UserSuccess(
      cookie: cookie ?? this.cookie,
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
      userPost: userPost ?? this.userPost,
      resources: resources ?? this.resources,
      profilePic: profilePic ?? this.profilePic,
    );
  }
}

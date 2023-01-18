import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:p4h_mobile/appstate/nagivation/nav_state.dart';
import 'package:p4h_mobile/models/session_user.dart';
import 'package:p4h_mobile/models/user_post.dart';
import 'package:p4h_mobile/screens/dashboard.dart';
import 'package:p4h_mobile/services/database.dart';

class User extends UserStatus {
  final String? userName;
  final String? password;
  final bool loggedIn;

  const User({
    this.userName,
    this.password,
    this.loggedIn = false,
  });

  User get userState => this;

  User copyWith({
    final String? userName,
    final String? password,
    final bool? loggedIn,
  }) {
    return User(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      loggedIn: loggedIn ?? this.loggedIn,
    );
  }
}

class UserStateProvider extends ChangeNotifier {
  User? user;
  final List<UserPost> userPost = [];
  final NavgiationState navstate;

  set userpost(up) => userPost.add(up);

//initial state emptyUser;
  UserStateProvider({
    required this.navstate,
    this.user = const User(userName: 'e'),
  });

  void getResources() {
    Database().getResources();
  }

  void login(String username, String password) async {
    final userResponse = await Database().login(username, password);

    if (userResponse is SessionUser) {
      // print(userResponse.name);

      final user2 = user!.copyWith(
        userName: userResponse.name,
        password: password,
        loggedIn: true,
      );

      user = user!.copyWith(
        userName: user2.userName,
      );

      navstate.pushReplacementRoute(
        const MaterialPage(
          child: Material(
            child: Dashboard(),
          ),
        ),
      );

      notifyListeners();

      print(user!.userName);
      return;
    }

    if (userResponse is EmptyUser) {
      throw UnimplementedError('empty user');
    }
  }

  void addComment(UserPost comment) {
    // List<UserPost> up = [];
  }
}

abstract class UserStatus {
  const UserStatus();
}

class EmptyUser extends UserStatus {
  const EmptyUser();
}

import 'package:flutter/widgets.dart';
import 'package:p4h_mobile/models/session_user.dart';
import 'package:p4h_mobile/services/database.dart';

class User {
  final String userName;
  final String password;
  final bool loggedIn;

  User({
    required this.userName,
    required this.password,
    this.loggedIn = false,
  });

  User get userState => this;

  //change state with copywith;

  User copyWith({
    required final String userName,
    required final String password,
    final bool loggedIn = false,
  }) =>
      User(
        userName: userName,
        password: password,
        loggedIn: loggedIn,
      );
}

class UserStateProvider extends ChangeNotifier {
  final User? user;

//initial state emptyUser;
  UserStateProvider({
    this.user,
  });

  void login(String username, String password) async {
    try{
      final userResponse = await Database().login(username, password);
      

    if (userResponse is UserFetchSuccess) {}
    
  }
  catch (error) {
      throw error;
    }
    }
}

abstract class UserStatus {
  const UserStatus();
}

class EmptyUser extends UserStatus {
  const EmptyUser();
}

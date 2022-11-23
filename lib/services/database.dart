import 'package:p4h_mobile/appstate/user_state.dart';
import 'package:http/http.dart' as http;
import 'package:p4h_mobile/models/session_user.dart';

class Database {
  void getUser() {
    //api call
  }

  void getPosts(String userID) {}

  void getResources() {}

  Future<UserInfoFetchStatus> login(String username, String password) async {
    final url = Uri.parse(
        "https://virtserver.swaggerhub.com/lcundiff/P4hTeach/1.0.0/login?usernameyasantham=&password=");

    //user response can be yes or no

    final response = await http.post(
      url,
    );

    if (response.statusCode == 200) {
      // SessionUser user = SessionUser.fromJson(response.body);
      // UserFetchSuccess(user: user);

      print(response.body);
    }

    print(response.statusCode);
    return UserFetchError();
  }
}

abstract class UserInfoFetchStatus {
  const UserInfoFetchStatus();
}

class UserFetchSuccess extends UserInfoFetchStatus {
  final SessionUser user;
  const UserFetchSuccess({required this.user});
}

class UserFetchError extends UserInfoFetchStatus {}

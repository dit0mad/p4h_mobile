import 'dart:convert';

import 'package:p4h_mobile/appstate/user/user_state.dart';
import 'package:http/http.dart' as http;
import 'package:p4h_mobile/models/session_user.dart';

class Database {
  void getUser() {
    //api call
  }

  void getPosts(String userID) {}

  void getResources() async {
    final url = Uri.parse(
        "https://virtserver.swaggerhub.com/lcundiff/P4hTeach/1.0.0/resources");

    final response = await http.get(
      url,
    );

    // print(response.body);
  }

  Future<UserStatus> login(String username, String password) async {
    final url = Uri.parse("https://p4hteach.org/api/login");

    var map = new Map<String, dynamic>();

    map['username'] = username;
    map['password'] = password;

    http.Response response = await http.post(
      url,
      body: map,
    );

//    if (response.statusCode == 200) {
    //throw error for username not

    return SessionUser(
        id: 1,
        username: username,
        canvasId: 1,
        email: 'ditto@email.com',
        name: 'ditto',
        phone: '34',
        school: 'school');

    // final decodedResponse = jsonDecode(response.body);

    // final resolvedUser = SessionUser.fromJson(decodedResponse);

    // return resolvedUser;
    // }

    // print(response.statusCode);

    // return const EmptyUser();
  }
}

import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:p4h_mobile/appstate/user/user_state.dart';
import 'package:p4h_mobile/models/user.dart';
import 'package:p4h_mobile/models/user_post.dart';

const String url = 'https://p4hteach.org/api/';

const session =
    'session=.eJwdzrkNwzAMAMBdWLsQzUeSlwkoPkhaO66C7B4gN8F94FFnXk843uedGzxeAQcwZlRz7kPUvC2hynBqNolLesao3Ad3C9NEmuKhvJAyeE6REt2REDmWj-ZdssvySJIwQxmps_lClbLKoSlzrBkNxc3MGRU2uK88_xn8_gCFWi--.ZFlKBg.02xRvyD3mdKEjLtEyH8Q3LGeWHo';

class HttpService {
  Future<UserPostSuccess> getAnnouncements() async {
    final resolveUri = Uri.parse('https://p4hteach.org/api/announcements');

    try {
      final response = await http.get(
        headers: {
          'Content-Type': 'application/json',
          'Cookie': session,
        },
        resolveUri,
      );

      final List<dynamic> result = json.decode(response.body);

      final resolvedPost =
          result.map((final e) => UserPost.fromJson(e)).toList();

      return UserPostSuccess(userPosts: resolvedPost);
    } catch (e) {
      throw EmptyUserError(e: e.toString());
    }
  }

  Future deletePost(int postID) async {
    final resolveUri = Uri.parse('https://p4hteach.org/api/post/$postID');

    //final response = Dio().deleteUri(resolveUri);

    try {
      final response = await http.delete(
        headers: {
          'Content-Type': 'application/json',
          'Cookie': session,
        },
        resolveUri,
      );
      print(response.statusCode);
    } catch (e) {
      throw UnimplementedError(e.toString());
    }
  }

  Future<UserPostResponse> postComment(String postID) async {
    final resolvedUri = Uri.parse('https://p4hteach.org/api/comment/$postID');

    try {
      final response = await Dio().postUri(resolvedUri,
          data: {'text': 'Test comment from p4hMobile'},
          options: Options(
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
              'Cookie': session,
            },
          ));

      print(response.data);
      return const UserPostSuccess(userPosts: []);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserPostResponse> createPost(String id) async {
    //TODO@ proper return types.
    final resolveUri = Uri.parse('https://p4hteach.org/api/post/1');

    try {
      final response = await Dio().postUri(resolveUri,
          data: {'text': 'Test post from p4hMobile'},
          options: Options(
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
              'Cookie': session,
            },
          ));

      print(response);

      return const UserPostSuccess(userPosts: []);
    } catch (e) {
      throw Exception(e);
    }
  }

  void getUser() {}

  Future<UserPostResponse> getPosts(String userID) async {
    final resolveUri = Uri.parse('https://p4hteach.org/api/posts/$userID');

    try {
      final response = await http.get(
        headers: {
          'Content-Type': 'application/json',
          'Cookie': session,
        },
        resolveUri,
      );

      final List<dynamic> result = json.decode(response.body);

      final resolvedPost =
          result.map((final e) => UserPost.fromJson(e)).toList();

      return UserPostSuccess(userPosts: resolvedPost);
    } catch (e) {
      throw EmptyUserError(e: e.toString());
    }
  }

  void getResources() async {
    const resolveUri = '$url' 'resources';

    try {
      final response = await http.get(
        headers: {'Content-Type': 'application/json', 'Cookie': session},
        Uri.parse(resolveUri),
      );

      print(response.body);
    } catch (e) {
      print(e);
    }

    // final decodedResponse = jsonDecode(response.body);

    // print(decodedResponse);
  }

  Future<UserStatus> login(String username, String password) async {
    final url = Uri.parse("https://p4hteach.org/api/login");

    Map<String, dynamic> map = {};

    map['username'] = 'lcundiff';
    map['password'] = 'password2';

    http.Response response = await http.post(
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      url,
      body: map,
    );

    try {
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);

        final resolvedUser = User.fromJson(decodedResponse);

        return resolvedUser;
      }
    } catch (e) {
      throw EmptyUserError(e: e.toString());
    }

    return EmptyUser(e: e.toString());
  }

  Future<void> logOut() async {
    final url = Uri.parse("https://p4hteach.org/api/logout");

    http.Response response = await http.post(
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      url,
    );

    try {
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);

        final resolvedUser = User.fromJson(decodedResponse);

        const rq = RequestType.get;

       

        print(response.body);

        return;
      }
    } catch (e) {
      throw EmptyUserError(e: e.toString());
    }
  }
}

class RequestType {
  final String _value;

  const RequestType._string(this._value);

  static const RequestType get = RequestType._string('GET');
  static const RequestType put = RequestType._string('PUT');
  static const RequestType patch = RequestType._string('PATCH');
  static const RequestType post = RequestType._string('POST');
  static const RequestType delete = RequestType._string('DELETE');
}

import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:p4h_mobile/appstate/user/user_state.dart';
import 'package:p4h_mobile/models/user_post.dart';

const String url = 'https://p4hteach.org/api/';

const session =
    'session=.eJwdzjEOwzAIQNG7MGcwNhjIZSIbg9o1aaaqd2_V-UtP_w1HnnE9YH-dd2xwPBfsoM042bVG5d6J-iKalJWzLVnWYlAjn51rwWk0foELmaIkC5OyKCZKmW2mZV3C6pilNxSbOqqTLuPhXeKn6KDe2D2ISrVcHLDBfcX5n8HPF6nTLXc.ZB3qFA.prGRL8PcsqLxbmMZbCub2FOOaeU; Path=/; HttpOnly';

class HttpService {
  Future deletePost(int postID) async {
    final resolveUri = Uri.parse('https://p4hteach.org/api/post/$postID');

    // final response = Dio().deleteUri(resolveUri);

    try {
      final response = await http.delete(
        headers: {
          'Content-Type': 'application/json',
          'Cookie': session,
        },
        resolveUri,
      );
    } catch (e) {
      throw UnimplementedError(e.toString());
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

  Future<UserPostResponse> getPosts() async {
    final resolveUri = Uri.parse('https://p4hteach.org/api/posts');

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

    return const UserPostFailedResponse();
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

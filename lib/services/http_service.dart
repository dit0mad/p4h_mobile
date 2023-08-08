import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:p4h_mobile/appstate/user/user_state.dart';
import 'package:p4h_mobile/models/resource.dart';
import 'package:p4h_mobile/models/user.dart';
import 'package:p4h_mobile/models/user_post.dart';
import 'package:p4h_mobile/services/rocket_chat_auth_response.dart';
import 'package:path_provider/path_provider.dart';

const String url = 'https://p4hteach.org/api/';

class HttpService {
  late StoreCookie? cookie;

  HttpService({this.cookie});

  HttpService copyWith({
    final StoreCookie? cookie,
  }) {
    return HttpService(
      cookie: cookie ?? this.cookie,
    );
  }

  Future<RocketChatAuthResponse> getRocketChatAuth(StoreCookie cookie) async {
    final resolveUri = Uri.parse('https://p4hteach.org/api/rocket/token');

    try {
      final response = await http.get(
        headers: {
          'Content-Type': 'application/json',
          'Cookie': cookie.cookie,
        },
        resolveUri,
      );

      final Map<String, dynamic> result = json.decode(response.body);

      final authResponse = RocketChatAuthResponse.fromJson(result);

      return authResponse;
    } catch (e) {
      throw EmptyUserError(e: e.toString());
    }
  }

  Future<UserPostSuccess> getAnnouncements() async {
    final resolveUri = Uri.parse('https://p4hteach.org/api/announcements');

    try {
      final response = await http.get(
        headers: {
          'Content-Type': 'application/json',
          'Cookie': cookie!.cookie,
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
          'Cookie': cookie!.cookie,
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
              'Cookie': cookie!.cookie,
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
              'Cookie': cookie!.cookie,
            },
          ));

      print(response);

      return const UserPostSuccess(userPosts: []);
    } catch (e) {
      throw Exception(e);
    }
  }

  void getUser() {}

  Future<UserPostResponse> getPosts(int userID) async {
    final resolveUri = Uri.parse('https://p4hteach.org/api/posts/$userID');

    try {
      final response = await http.get(
        headers: {
          'Content-Type': 'application/json',
          'Cookie': cookie!.cookie,
        },
        resolveUri,
      );

      final List<dynamic> result = json.decode(response.body);

      final resolvedPost =
          result.map((final e) => UserPost.fromJson(e)).toList();

      return UserPostSuccess(userPosts: resolvedPost);
    } catch (e) {
      return const UserPostFailedResponse();
    }
  }

  Future<UserResourceResponse?> getResources() async {
    const resolveUri = '$url' 'resources';

    try {
      final response = await http.get(
        headers: {'Content-Type': 'application/json', 'Cookie': cookie!.cookie},
        Uri.parse(resolveUri),
      );

      final List<dynamic> result = json.decode(response.body);

      final resources =
          result.map((e) => UserResourceResponseSuccess.fromJson(e)).toList();

      final resolved = ResourcesResponse(resource: resources);

      return resolved;
    } catch (e) {
      return const UserResourceResponseFailure();
    }
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

        //i need to store the cookie and check if it has expired or not. store seprate maybe?

        cookie = StoreCookie(cookie: response.headers['set-cookie']!);

        //dispatch an action to save cookie
        final resolvedUser = UserSuccess.fromJson(
          decodedResponse,
        );

        final s = resolvedUser.copyWith(cookie: cookie);

        return s;
      }
    } catch (e) {
      return InvalidLoginInfo();
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

        final resolvedUser = UserSuccess.fromJson(decodedResponse);

        print(response.body);

        return;
      }
    } catch (e) {
      throw EmptyUserError(e: e.toString());
    }
  }

  Future<String> downloadFile(String fileId) async {
    final url = Uri.parse("https://p4hteach.org/resources/download/file_10-1");
    http.Response response = await http.get(
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      url,
    );
    try {
      if (response.statusCode == 200) {
        // Get the app's external storage directory
        Directory appDir =
            await getApplicationDocumentsDirectory(); // Or use getApplicationDocumentsDirectory() for internal storage

        // Create the file path where the downloaded file will be saved
        String filePath = '${appDir.path}/lessasons.txt';

        // Write the file content to the specified file path

        File file = File(filePath);

        final v = response.bodyBytes.buffer;
        await file.writeAsBytes(v.asUint8List(response.bodyBytes.offsetInBytes,
            response.bodyBytes.lengthInBytes));
        // var documentDirectory = await getApplicationDocumentsDirectory();
        // var firstPath = documentDirectory.path + "/images";
        // var filePathAndName = '${documentDirectory.path}/images/pic.jpg';
        // //comment out the next three lines to prevent the image from being saved
        // //to the device to show that it's coming from the internet
        // await Directory(firstPath).create(recursive: true); // <-- 1
        // File file2 = File(filePathAndName); // <-- 2
        // file2.writeAsBytesSync(response.bodyBytes);

        // final de = filePathAndName;

        print(filePath);

        return filePath;
      }
      return '';
    } catch (e) {
      return e.toString();
    }
  }
}

// class RequestType {
//   final String _value;

//   const RequestType._string(this._value);

//   static const RequestType get = RequestType._string('GET');
//   static const RequestType put = RequestType._string('PUT');
//   static const RequestType patch = RequestType._string('PATCH');
//   static const RequestType post = RequestType._string('POST');
//   static const RequestType delete = RequestType._string('DELETE');
// }

class StoreCookie {
  final String cookie;

  const StoreCookie._string(this.cookie);

  static const StoreCookie nothing = StoreCookie._string('nothing');
  StoreCookie({required this.cookie});
}

class HttpRepo {
  final _httpService = HttpService();

  Future<UserStatus> login(String username, String password) async {
    final resp = await _httpService.login(username, password);

    if (resp is UserSuccess) {
      final allresp = await Future.wait([
        _httpService.getPosts(resp.id),
        _httpService.getResources(),
      ]);

      final resp1 = allresp[0] as UserPostResponse;
      final resp2 = allresp[1] as UserResourceResponse;

      if (resp1 is UserPostSuccess && resp2 is ResourcesResponse) {
        return resp.copyWith(
          userPost: resp1.userPosts,
          resources: resp2.resource,
        );
      }
    }

    return resp;
  }

  Future<UserPostResponse> getPosts(int userID) async {
    return await _httpService.getPosts(userID);
  }

  Future downloadFile(String fileId) async {
    return _httpService.downloadFile(fileId);
  }
}

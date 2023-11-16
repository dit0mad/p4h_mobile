import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:open_file_plus/open_file_plus.dart';
import 'package:p4h_mobile/appstate/user/user_state.dart';
import 'package:p4h_mobile/models/progress_model.dart';
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

  Future<UserResourceResponse> getResourceFolder(int folderID) async {
    final resolveUri = '$url' 'resources/$folderID';

    try {
      final response = await http.get(
        headers: {'Content-Type': 'application/json', 'Cookie': cookie!.cookie},
        Uri.parse(resolveUri),
      );

      final List<dynamic> result = json.decode(response.body);

      final resources =
          result.map((e) => UserResourceFolderResponse.fromJson(e)).toList();

      final resolved = ResourcesFolderIdResponse(resources: resources);

      return resolved;
    } catch (e) {
      throw const UserResourceResponseFailure();
    }
  }

  Future<UserStatus> login(String username, String password) async {
    final url = Uri.parse("https://p4hteach.org/api/login");

    Map<String, dynamic> map = {};

    map['username'] = username;
    map['password'] = password;

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

        final resolvedUser = UserSuccess.fromJson(
          decodedResponse,
        );

        final s = resolvedUser.copyWith(cookie: cookie);

        return s;
      }
    } catch (e) {
      return InvalidLoginInfo(error: e.toString());
    }

    return InvalidLoginInfo(error: response.reasonPhrase!);
  }

  Future<UserStatus> logOut() async {
    final url = Uri.parse("https://p4hteach.org/api/logout");

    http.Response response = await http.post(
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      url,
    );

    try {
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);

        final resolvedUser = UserSuccess.fromJson(decodedResponse);

        return resolvedUser;
      }
      return EmptyUser(e: e.toString());
    } catch (e) {
      throw EmptyUserError(e: e.toString());
    }
  }

  Future<String> getFilePath(String fileName) async {
    final Directory? tempDir;

    if (Platform.isIOS) {
      tempDir = await getApplicationSupportDirectory();
    } else if (Platform.isAndroid) {
      tempDir = await getApplicationDocumentsDirectory();
    } else {
      tempDir = await getApplicationSupportDirectory();
    }

    return '${tempDir.path}/$fileName';
  }

  Future<String> downloadFile(int fileId, String fileName) async {
    //TODO @yasantha rename to https://p4hteach.org/resources/download/$fileNam

    final url = "https://p4hteach.org/resources/download/file_13-2";

    // Create the file path where the downloaded file will be saved

    final path = await getFilePath(fileName);

    await Dio().download(url, path);

    final file = File(path);

    await OpenFile.open(file.path);

    return file.path;
  }

  Future<MyProgressStatus> getProgress(int profileID) async {
    const url = 'https://p4hteach.org/api/profile/1/progress';

    try {
      final response = await http.get(
        headers: {
          'Content-Type': 'application/json',
          'Cookie': cookie!.cookie,
        },
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        final List<dynamic> decode = jsonDecode(response.body);

        final resolved = decode.map((e) => MyProgress.fromJson(e));

        return MyProgressSuccess(myProgress: resolved);
      }

      return MyProgresError();
    } catch (e) {
      rethrow;
    }
  }
}

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

  Future<UserResourceResponse> gotoResourceFolder(int folderID) async {
    return await _httpService.getResourceFolder(folderID);
  }

  Future downloadFile({
    required int fileId,
    required String fileName,
    required DownloadType type,
  }) async {
    return _httpService.downloadFile(fileId, fileName);
  }

  Future<Iterable<MyProgress>> getProgress() async {
    final result = await _httpService.getProgress(1);

    if (result is MyProgressSuccess) {
      return result.myProgress;
    }

    throw e;
  }
}

abstract class DownloadType {}

class Notes extends DownloadType {}

class Picture extends DownloadType {}

class Other extends DownloadType {}

abstract class DownloadService<DownloadType> {
  bool shouldMiddlewareApply() => true;
}

class DownloadLesson<DownloadType> extends DownloadService {
  @override
  bool shouldMiddlewareApply() {
    if (DownloadType is Notes) return true;
    return false;
  }

  //if type is notes apply it\
}

final DownloadLesson dw = DownloadLesson<Notes>();

import 'package:flutter/material.dart';
import 'package:p4h_mobile/appstate/actions_bloc/actions.dart';
import 'package:p4h_mobile/appstate/user/reducer.dart';
import 'package:p4h_mobile/models/user.dart';
import 'package:p4h_mobile/models/user_post.dart';
import 'package:p4h_mobile/screens/dashboard.dart';
import 'package:p4h_mobile/services/http_service.dart';
import 'package:p4h_mobile/services/rocket_chat_auth_response.dart';

class UserState {
  final UserSuccess? user;
  final List<UserPost> _userPost;
  // final NavigationStateProvider? navstate;
  final List<UserPost> _announcements;

  UserState({
    //this.navstate,
    this.user,
    List<UserPost> userPost = const [],
    List<UserPost> announcements = const [],
  })  : _userPost = userPost,
        _announcements = announcements;

  UserState copyWith({
    final UserSuccess? user,
    final List<UserPost>? userPost,
    List<UserPost>? announcements = const [],
  }) {
    return UserState(
      // navstate: navstate,
      user: user ?? this.user,
      userPost: userPost ?? _userPost,
      announcements: announcements ?? _announcements,
    );
  }
}

class UserStateProvider extends ChangeNotifier {
  UserState? userState;

  UserSuccess? user;
  List<UserPost> _userPost;
  List<UserPost> _announcements;
  //final NavigationStateProvider navstate;
  final bool userPostLoading = true;

  Iterable<UserPost> get getUserposts => _userPost.reversed;
  Iterable<UserPost> get getAnnouncements => _announcements;

  bool isLoading = false;

  late final HttpService httpService = HttpService();

//initial state emptyUser;

  UserStateProvider({
    this.userState,
    //required this.navstate,
    this.user,
    List<UserPost> userPost = const [],
    List<UserPost> announcements = const [],
  })  : _userPost = userPost,
        _announcements = announcements;

  void getResources() {
    httpService.getResources();
  }

  void configureRocketChatAuth(final RocketChatAuthResponse res) {
    final tokenID = res.authToken;
  }

  Future getRocketChatAuth(StoreCookie cookie) async {
    final res = await httpService.getRocketChatAuth(cookie);

    configureRocketChatAuth(res);
  }

  Future getPosts() async {
    final postResponse = await httpService.getPosts(user!.id);
    final ann = await httpService.getAnnouncements();

    if (postResponse is UserPostSuccess) {
      _userPost = postResponse.userPosts;
      notifyListeners();
    }

    _announcements = ann.userPosts;
    notifyListeners();
  }

  void login(
    String username,
    String password,
  ) async {
    isLoading = true;
    notifyListeners();
    final userResponse = await httpService.login(username, password);

    //we wait for a user type and if we get it, we need to fire an action to retireve other information
    //such as userposts and resources,
    //my thought is to create another class which takes in action and gives a response.
    if (userResponse is InvalidLoginInfo) {
      isLoading = false;
      notifyListeners();
    }

    if (userResponse is UserSuccess) {
      final resolved = UserSuccess(
          cookie: userResponse.cookie,
          canvasID: userResponse.canvasID,
          email: userResponse.email,
          id: userResponse.id,
          name: userResponse.name,
          username: username);

      user = resolved;

      // userState = userState!.copyWith(user: user);

      await getRocketChatAuth(userResponse.cookie);
      await getPosts();

      isLoading = false;

      //after loging in we need to get userposts to populate.
      //we can hit another method to retrieve

      // navstate.pushReplacementRoute(
      const MaterialPage(
        child: Material(
          child: Dashboard(),
        ),
      );
      // );
      notifyListeners();
      return;
    }

    if (userResponse is EmptyUserError) {
      isLoading = false;
      notifyListeners();
      throw UnimplementedError('empty user');
    }
  }

  void addComment(String comment, int id) async {
    //add comment where userpost equal the id of the post/

    final action = AddCommentAttempt(
      comment: comment,
      id: id,
    );

    final nextState = postReducer(action, _userPost);

    _userPost = nextState;

    //then do server stuff

    notifyListeners();
  }

  void addPost(String post) async {
    //TODO @yasantha : handle this via request repsonse actions. if successs

    final userPost = UserPost(
      message: post,
      user: user,
      comments: [],
      id: 69,
    );

    final action = AddPostAttempt(
      post: post,
      user: user!,
    );

    final nextState = postReducer(action, _userPost);

    _userPost = nextState;

    final response = await httpService
      ..createPost('1');
    notifyListeners();
  }

  void delete(int postID) async {
    final nextState = postReducer(
      DeletePostAttempt(postID: postID),
      _userPost,
    );

    _userPost = nextState;
    notifyListeners();
    final response = await httpService
      ..deletePost(postID);
  }
}

abstract class PostActionReducer extends BaseAction {
  const PostActionReducer();
}

class DeletePostAttempt extends PostActionReducer {
  final int postID;

  DeletePostAttempt({
    required this.postID,
  });
}

class AddPostAttempt extends BaseAction {
  final String post;

  final UserSuccess user;

  const AddPostAttempt({
    required this.post,
    required this.user,
  });
}

class AddCommentAttempt extends BaseAction {
  final String comment;
  final int id;

  const AddCommentAttempt({
    required this.comment,
    required this.id,
  });
}

abstract class UserStatus extends RepresentableError {
  const UserStatus();
}

class EmptyUserState extends UserStatus {
  const EmptyUserState();
}

abstract class RepresentableError {
  const RepresentableError();
}

class InvalidLoginInfo extends UserStatus {
  String errorText;

  InvalidLoginInfo({required this.errorText});

  @override
  String toString() {
    return errorText;
  }
}

class EmptyUser extends UserStatus {
  final String e;
  const EmptyUser({required this.e});

  String get message => e;

  @override
  String toString() {
    return message;
  }
}

class EmptyUserError extends RepresentableError {
  final String e;
  const EmptyUserError({required this.e});

  String get message => e;

  @override
  String toString() {
    return message;
  }
}

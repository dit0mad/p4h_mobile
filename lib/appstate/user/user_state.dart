import 'package:flutter/material.dart';
import 'package:p4h_mobile/appstate/nagivation/nav_state.dart';
import 'package:p4h_mobile/appstate/user/reducer.dart';
import 'package:p4h_mobile/models/comment.dart';
import 'package:p4h_mobile/models/user.dart';
import 'package:p4h_mobile/models/user_post.dart';
import 'package:p4h_mobile/screens/dashboard.dart';
import 'package:p4h_mobile/services/http_service.dart';

class UserState {
  final User? user;
  final List<UserPost> _userPost;
  final NavigationStateProvider? navstate;
  final List<UserPost> _announcements;

  UserState({
    this.navstate,
    this.user,
    List<UserPost> userPost = const [],
    List<UserPost> announcements = const [],
  })  : _userPost = userPost,
        _announcements = announcements;

  UserState copyWith({
    final User? user,
    final List<UserPost>? userPost,
    List<UserPost>? announcements = const [],
  }) {
    return UserState(
      navstate: navstate,
      user: user ?? this.user,
      userPost: userPost ?? _userPost,
      announcements: announcements ?? _announcements,
    );
  }
}

class UserStateProvider extends ChangeNotifier {
  UserState? userState;

  User? user;
  List<UserPost> _userPost;
  List<UserPost> _announcements;
  final NavigationStateProvider navstate;
  final bool userPostLoading = true;

  Iterable<UserPost> get getUserposts => _userPost.reversed;
  Iterable<UserPost> get getAnnouncements => _announcements;

//initial state emptyUser;

  UserStateProvider({
    this.userState,
    required this.navstate,
    this.user,
    List<UserPost> userPost = const [],
    List<UserPost> announcements = const [],
  })  : _userPost = userPost,
        _announcements = announcements;

  UserStateProvider copyWith({
    final User? user,
    final List<UserPost>? userPost,
    final UserState? userState,
  }) {
    return UserStateProvider(
      userState: userState ?? this.userState,
      navstate: navstate,
      user: user ?? this.user,
    );
  }

  void getResources() {
    HttpService().getResources();
  }

  Future getPosts() async {
    final postResponse = await HttpService().getPosts(user!.id.toString());
    final ann = await HttpService().getAnnouncements();

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
    final userResponse = await HttpService().login(username, password);

    //we wait for a user type and if we get it, we need to fire an action to retireve other information
    //such as userposts and resources,
    //my thought is to create another class which takes in action and gives a response.

    if (userResponse is User) {
      final resolved = User(
          canvasID: userResponse.canvasID,
          email: userResponse.email,
          id: userResponse.id,
          name: userResponse.name,
          username: username);

      user = resolved;

      userState = userState!.copyWith(user: user);

      await getPosts();

      //after loging in we need to get userposts to populate.
      //we can hit another method to retrieve

      navstate.pushReplacementRoute(
        const MaterialPage(
          child: Material(
            child: Dashboard(),
          ),
        ),
      );
      notifyListeners();
      return;
    }

    if (userResponse is EmptyUserError) {
      //TODO: @yasantha empty user error
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

    final response = await HttpService().createPost('1');
    notifyListeners();
  }

  void delete(int postID) async {
    final nextState = postReducer(
      DeletePostAttempt(postID: postID),
      _userPost,
    );

    _userPost = nextState;
    notifyListeners();
    final response = await HttpService().deletePost(postID);
  }
}

abstract class BaseAction {
  const BaseAction();
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

  final User user;

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

abstract class RepresentableError {
  const RepresentableError();
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

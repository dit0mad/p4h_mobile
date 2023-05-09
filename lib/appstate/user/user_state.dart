import 'package:flutter/material.dart';
import 'package:p4h_mobile/appstate/nagivation/nav_state.dart';
import 'package:p4h_mobile/models/user_post.dart';
import 'package:p4h_mobile/view/screens/dashboard.dart';
import 'package:p4h_mobile/services/http_service.dart';

class User extends UserStatus {
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      canvasID: json["canvasId"],
      bio: json['bio'],
      email: json['email'],
      id: json['id'],
      name: json['name'],
      username: json['name'],
      location: json['location'],
      school: json['school'],
      phone: json['phone'],
    );
  }

  final String? bio;
  final int canvasID;
  final String email;
  final int id;
  final String? location;
  final String name;
  final String? phone;
  final String? school;
  final String username;

  final bool loggedIn;

  const User({
    this.bio,
    required this.canvasID,
    required this.email,
    required this.id,
    this.location,
    required this.name,
    this.phone,
    this.school,
    required this.username,
    this.loggedIn = false,
  });

  User get userState => this;

  User copyWith({
    final String? bio,
    final int? canvasID,
    final String? email,
    final int? id,
    final String? location,
    final String? name,
    final String? phone,
    final String? school,
    final String? username,
    final bool? loggedIn,
  }) {
    return User(
      canvasID: canvasID ?? this.canvasID,
      email: email ?? this.email,
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      phone: phone ?? this.phone,
      school: school ?? this.school,
      bio: bio ?? this.bio,
      username: username ?? this.username,
      loggedIn: loggedIn ?? this.loggedIn,
    );
  }
}

class UserState {
  User? user;
  List<UserPost>? _userPost;

  UserState();
}

class UserStateProvider extends ChangeNotifier {
  //final UserState userState;

  User? user;
  List<UserPost> _userPost;
  List<UserPost> _announcements;
  final NavgiationState navstate;
  final bool userPostLoading = true;

  Iterable<UserPost> get getUserposts => _userPost.reversed;
  Iterable<UserPost> get getAnnouncements => _announcements;

//initial state emptyUser;

  UserStateProvider({
    required this.navstate,
    this.user,
    List<UserPost> userPost = const [],
    List<UserPost> announcements = const [],
  })  : _userPost = userPost,
        _announcements = announcements;

  UserStateProvider copyWith({
    final User? user,
    final List<UserPost>? userPost,
  }) {
    return UserStateProvider(
      navstate: navstate,
      user: user ?? this.user,
    );
  }

  void getResources() {
    HttpService().getResources();
  }

  Future getPosts() async {
    final postResponse = await HttpService().getPosts();
    final ann = await HttpService().getAnnouncements();

    if (postResponse is UserPostSuccess) {
      _userPost = postResponse.userPosts;
      notifyListeners();
    }

    _announcements = ann.userPosts;
    notifyListeners();
  }

  void login(String username, String password) async {
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

      await getPosts();

      //after loging in we need to get userposts to populate.
      //we can hit another method to retrieve

      navstate.pushPageRoute(
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

  void addComment(UserPost comment) {}

  void addPost(String post) async {
    //TODO @yasantha : handle this via request repsonse actions. if successs

    final userPost = UserPost(
      message: post,
      user: user!,
      comments: [],
      id: 69,
    );

    final action = AddPostAttempt(
      post: post,
      state: _userPost,
      user: user!,
    );

    final nextState = postReducer(action);

    _userPost = nextState;

    //final response = await HttpService().createPost('1');
    notifyListeners();
  }

  void delete(int postID) async {
    final nextState = postReducer(
      DeletePostAttempt(
        postID: postID,
        state: _userPost,
      ),
    );

    _userPost = nextState;
    notifyListeners();
    // final response = await HttpService().deletePost(postID);
  }
}

postReducer(Action action) {
  if (action is DeletePostAttempt) {
    final nextState = action.state.where(
      (element) => element.id != action.postID,
    );

    return nextState.toList();
  }

  if (action is AddPostAttempt) {
    final nextState = [
      ...action.state,
      UserPost(
        message: action.post,
        user: action.user,
        comments: [],
        id: 69,
      ),
    ];

    return nextState;
  }
}

abstract class Action {
  const Action();
}

abstract class PostActionReducer extends Action {
  final List<UserPost> state;

  const PostActionReducer({required this.state});
}

class DeletePostAttempt extends PostActionReducer {
  final int postID;

  DeletePostAttempt({
    required this.postID,
    required super.state,
  });
}

class AddPostAttempt extends Action {
  final String post;
  final List<UserPost> state;
  final User user;

  const AddPostAttempt({
    required this.post,
    required this.state,
    required this.user,
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

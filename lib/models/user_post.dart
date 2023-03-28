import 'package:p4h_mobile/appstate/user/user_state.dart';

abstract class UserPostResponse {
  const UserPostResponse();
}

class UserPostSuccess extends UserPostResponse {
  final List<UserPost> userPosts;

  const UserPostSuccess({required this.userPosts});
}

class UserPostFailedResponse extends UserPostResponse {
  const UserPostFailedResponse();
}

class UserPost extends UserPostResponse {
  final int? id;
  final User? user;
  final String? title;
  final String? postedAt;
  final List<Comment>? comments;
  final List? files;
  final String message;

  const UserPost({
    this.id,
    this.user,
    this.title,
    this.postedAt,
    this.comments,
    this.files,
    required this.message,
  });

  UserPost copyWith({
    final int? id,
    final User? user,
    final String? title,
    final String? postedAt,
    final List<Comment>? comments,
    final List? files,
    final String message = '',
  }) {
    return UserPost(
      comments: comments ?? this.comments,
      files: files ?? this.files,
      id: id ?? this.id,
      postedAt: postedAt ?? this.postedAt,
      title: title ?? this.title,
      user: user ?? this.user,
      message: message,
    );
  }

  factory UserPost.fromJson(Map<String, dynamic>? data) {
    if (data == null) {
      throw UnimplementedError('userpost from json error');
    }

    final Map<String, dynamic> commentParent = data['comments'];

    final List commentValue = commentParent.entries.first.value;

    final id = data['id'];
    final user = User.fromJson(data['user']);
    final title = data['title'];
    final postedAt = data['posted_at'];
    final comments =
        commentValue.map((final comment) => Comment.fromJson(comment)).toList();
    final files = data['files'];
    final message = data['message'];

    return UserPost(
      id: id,
      user: user,
      title: title,
      postedAt: postedAt,
      comments: comments,
      files: files,
      message: message,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user,
        'title': title,
        'postedAt': postedAt,
        'comments': comments,
        'files': files,
      };
}

class Comment {
  int id;
  String message;
  String name;
  User user;

  Comment(
      {required this.id,
      required this.message,
      required this.name,
      required this.user});

  factory Comment.fromJson(Map<String, dynamic>? data) {
    if (data == null) {
      throw UnimplementedError('userpost from json error');
    }

    final id = data['id'];
    final message = data['message'];
    final name = data['name'];
    final user = User.fromJson(data['author']);

    return Comment(
      id: id,
      user: user,
      message: message,
      name: name,
    );
  }
}

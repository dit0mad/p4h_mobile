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
  final User? profileUser;
  final String? username;
  final String? image;

  final String? postedAt;
  final List<Comment>? comments;
  final List? files;
  final String message;

  const UserPost({
    this.id,
    this.image,
    this.profileUser,
    this.username,
    this.postedAt,
    this.comments,
    this.files,
    required this.message,
  });

  UserPost copyWith({
    final int? id,
    final User? profileUser,
    final String? username,
    final String? image,
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
      profileUser: profileUser ?? this.profileUser,
      username: username ?? this.username,
      image: image ?? this.image,
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
    final profileUser = User.fromJson(data['profileUser']);
    final image = data['img'];
    final username = data['postUsername'];
    final postedAt = data['postedAt'];
    final comments =
        commentValue.map((final comment) => Comment.fromJson(comment)).toList();
    final files = data['files'];
    final message = data['message'];

    return UserPost(
      id: id,
      profileUser: profileUser,
      image: image,
      username: username,
      postedAt: postedAt,
      comments: comments,
      files: files,
      message: message,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'postUsername': username,
        'profileUser': profileUser,
        'img': image,
        'postedAt': postedAt,
        'comments': comments,
        'files': files,
        'message': message
      };
}

class Comment {
  int id;
  String message;
  String postedAt;
  String updatedAt;
  String name;
  User user;

  Comment(
      {required this.id,
      required this.message,
      required this.postedAt,
      required this.updatedAt,
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
    final postedAt = data['postedAt'];
    final updatedAt = data['updated_at'];

    return Comment(
      id: id,
      user: user,
      message: message,
      name: name,
      postedAt: postedAt,
      updatedAt: updatedAt,
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'author': user,
        ' message': message,
        'name': name,
        'postedAt': postedAt,
        'updated_at': updatedAt,
      };
}

import 'package:p4h_mobile/models/comment.dart';
import 'package:p4h_mobile/models/user.dart';

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
    final String? message,
  }) {
    return UserPost(
      comments: comments ?? this.comments,
      files: files ?? this.files,
      id: id ?? this.id,
      postedAt: postedAt ?? this.postedAt,
      title: title ?? this.title,
      user: user ?? this.user,
      message: message ?? this.message,
    );
  }

  factory UserPost.fromJson(Map<String, dynamic>? data) {
    if (data == null) {
      throw UnimplementedError('userpost from json error');
    }

    final Map<String, dynamic> commentParent = data['comments'];

    final List commentValue = commentParent.entries.first.value;

    final id = data['id'];
    final user = User.fromJson(data['profileUser']);
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

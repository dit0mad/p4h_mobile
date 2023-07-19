import 'package:p4h_mobile/models/user.dart';

class Comment {
  final String message;
  final String? postedAt;
  final String? name;
  final UserSuccess? author;

  Comment({
    required this.message,
    this.postedAt,
    this.name,
    this.author,
  });

  factory Comment.fromJson(Map<String, dynamic>? data) {
    if (data == null) {
      throw UnimplementedError('userpost from json error');
    }

    final message = data['message'];
    final postedAt = data['postedAt'];
    final name = data['name'];
    final author = UserSuccess.fromJson(data['author']);

    return Comment(
      message: message,
      postedAt: postedAt,
      name: name,
      author: author,
    );
  }
}

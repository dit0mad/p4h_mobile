class UserPost {
  final double? id;
  final String? userName;
  final String? title;
  final DateTime? postedAt;
  final List<UserPost?>? comments;
  final List? files;

  const UserPost({
    this.id,
    this.userName,
    this.title,
    this.postedAt,
    this.comments,
    this.files,
  });

  factory UserPost.fromJson(Map<String, dynamic> data) {
    final id = data['id'];
    final userName = data['userName'];
    final title = data['title'];
    final postedAt = data['postedAt'];
    final comments = data['comments'];
    final files = data['files'];

    return UserPost(
        id: id,
        userName: userName,
        title: title,
        postedAt: postedAt,
        comments: comments,
        files: files);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userName': userName,
        'title': title,
        'postedAt': postedAt,
        'comments': comments,
        'files': files,
      };
}

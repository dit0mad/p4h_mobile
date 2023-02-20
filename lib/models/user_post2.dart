// To parse this JSON data, do
//
//     final userPost = userPostFromJson(jsonString);

import 'dart:convert';

List<UserPost> userPostFromJson(String str) => List<UserPost>.from(json.decode(str).map((x) => UserPost.fromJson(x)));

String userPostToJson(List<UserPost> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserPost {
    UserPost({
        required this.comments,
        required this.userName,
        required this.id,
        required this.title,
        required this.postedAt,
    });

    List<Comment> comments;
    String userName;
    String id;
    String title;
    DateTime postedAt;

    factory UserPost.fromJson(Map<String, dynamic> json) => UserPost(
        comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
        userName: json["user_name"],
        id: json["id"],
        title: json["title"],
        postedAt: DateTime.parse(json["posted_at"]),
    );

    Map<String, dynamic> toJson() => {
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "user_name": userName,
        "id": id,
        "title": title,
        "posted_at": postedAt.toIso8601String(),
    };
}

class Comment {
    Comment({
        required this.updatedAt,
        required this.title,
    });

    DateTime updatedAt;
    String title;

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        updatedAt: DateTime.parse(json["updated_at"]),
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "updated_at": updatedAt.toIso8601String(),
        "title": title,

         
    };
}

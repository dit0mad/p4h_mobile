import 'package:flutter/material.dart';
import 'package:p4h_mobile/constants.dart';
import 'package:p4h_mobile/models/user_post.dart';
import 'package:p4h_mobile/screens/profile_screen/profile_main.dart';

class PostWidget extends StatefulWidget {
  final UserPost userPost;

  const PostWidget({
    super.key,
    required this.userPost,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool showComments = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.black),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CircleAvatar(
                    backgroundColor: Colors.greenAccent[400],
                    radius: 40,
                    backgroundImage: const NetworkImage(
                        'https://lh3.googleusercontent.com/a-/AAuE7mChgTiAe-N8ibcM3fB_qvGdl2vQ9jvjYv0iOOjB=s96-c'),
                  ),
                ), //C

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userPost.user!.name,
                          style: subtitle6,
                        ),
                        Text(
                          widget.userPost.postedAt.toString(),
                          style: subtitle7,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.userPost.image != null)
                    Image.memory(widget.userPost.image),
                  Text(widget.userPost.message),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => setState(() {
                            showComments = !showComments;
                          }),
                          child: Container(
                              padding: const EdgeInsets.all(
                                11.0,
                              ),
                              decoration: const BoxDecoration(
                                color: mainAppColor1,
                              ),
                              child: const Text(
                                'Comment',
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(
                          child: Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (showComments)
            CommentSection(
              userPost: widget.userPost,
            ),
          const Divider(
            thickness: 3,
          )
        ],
      ),
    );
  }
}

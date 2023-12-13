import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4h_mobile/appstate/user_bloc/user__state_bloc.dart';
import 'package:p4h_mobile/constants.dart';
import 'package:p4h_mobile/models/comment.dart';
import 'package:p4h_mobile/models/user_post.dart';
import 'package:p4h_mobile/screens/loading_screen.dart';
import 'package:p4h_mobile/screens/profile_screen/my_resources.dart';
import 'package:p4h_mobile/screens/profile_screen/profile_header.dart';
import 'package:p4h_mobile/screens/profile_screen/search_profile.dart';
import 'package:p4h_mobile/screens/profile_screen/post_widget.dart';
import 'package:p4h_mobile/screens/profile_screen/write_post_widget.dart';

class ProfileState extends StatefulWidget {
  const ProfileState({super.key});

  @override
  State<ProfileState> createState() => _ProfileStateState();
}

class _ProfileStateState extends State<ProfileState> {
  late final TextEditingController postController = TextEditingController();
  late final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    postController.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserStateBloc, UserState>(builder: (
      context,
      state,
    ) {
      if (state is UserStateSuccess) {
        final userState = state;
        return Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                children: [
                  ProfileHeader(
                    state: userState,
                  ),
                  const MyResources(),
                  const SearchProfile(),
                  const WritePostHereWidget(),
                  const Divider(
                    height: 15,
                    thickness: 3,
                  ),
                  ...state.userPost.map((final post) => PostWidget(
                        userPost: post,
                      )),
                ],
              ),
            ),
          ),
        );
      }

      if (state is UserStateError) {
        return Text(state.error);
      }
      return const LoadingScreen(
        text: "Loading Profile",
      );
    });
  }
}

class CommentSection extends StatelessWidget {
  final UserPost userPost;
  const CommentSection({
    super.key,
    required this.userPost,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PostCommentField(),
        if (userPost.comments!.isNotEmpty)
          ...userPost.comments!.map((e) => CommentWidget(
                comment: e,
              )),
      ],
    );
  }
}

class PostCommentField extends StatefulWidget {
  const PostCommentField({super.key});

  @override
  State<PostCommentField> createState() => _PostCommentFieldState();
}

class _PostCommentFieldState extends State<PostCommentField> {
  final postCommentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLines: null,
              onTapOutside: ((event) {
                FocusScope.of(context).unfocus();
              }),
              controller: postCommentController,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
                contentPadding:
                    EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                hintText: 'Comment...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(13.0), // Adjust padding as needed
                foregroundColor: Colors.white,
                backgroundColor: mainAppColor1, // Text color
              ),
              onPressed: () {},
              child: const Text(
                'Pos',
              )),
        )
      ],
    );
  }
}

class CommentWidget extends StatelessWidget {
  final Comment comment;
  const CommentWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  radius: 25,
                  backgroundImage: const NetworkImage(
                      'https://lh3.googleusercontent.com/a-/AAuE7mChgTiAe-N8ibcM3fB_qvGdl2vQ9jvjYv0iOOjB=s96-c'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.author!.name,
                        style: subtitle6,
                      ),
                      Text(
                        comment.postedAt.toString(),
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
            child: Text(comment.message),
          ),
        ),
      ],
    );
  }
}

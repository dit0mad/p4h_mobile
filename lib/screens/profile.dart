import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p4h_mobile/appstate/user_bloc/user__state_bloc.dart' as ub;
import 'package:p4h_mobile/appstate/user_bloc/user__state_bloc.dart';
import 'package:p4h_mobile/appstate/user_bloc/user_state_events.dart';
import 'package:p4h_mobile/constants.dart';
import 'package:p4h_mobile/models/user_post.dart';
import 'package:p4h_mobile/services/http_service.dart';
import 'package:p4h_mobile/widgets/build_divider.dart';
import 'package:p4h_mobile/widgets/custom_text_field.dart';
import 'package:p4h_mobile/widgets/login_text_field.dart';

import '../widgets/build_button.dart';

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
    final userProvider = context.read<ub.UserStateBloc>();

    return BlocBuilder<ub.UserStateBloc, ub.UserState>(
        builder: (context, state) {
      if (state is ub.UserStateSuccess) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Column(
              children: [
                CustomTextField(
                  hintText: 'Search Prowfil Pos',
                  fieldSize: 40,
                  controller: searchController,
                ),
                const Divider(
                  height: 6,
                  thickness: 3,
                ),
                const ProfileHeader(),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 5,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, top: 5),
                            decoration: BoxDecoration(
                              color: searchBarColor,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5)),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.camera,
                                    color: mainAppColor1,
                                    size: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Text(
                                      'Mwen Foto/Videyo',
                                      style: subtitle9,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.only(right: 10, top: 5),
                            decoration: BoxDecoration(
                              color: searchBarColor,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    (Icons.contact_page),
                                    color: mainAppColor1,
                                    size: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Text(
                                      'Mwen Dokiman',
                                      style: subtitle9,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 4,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: searchBarColor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Write post here ...',
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            hintStyle: subtitle4,
                          ),
                          keyboardType: TextInputType.multiline,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          ButtonBuild(
                              color: mainAppColor1,
                              buttonText: 'post',
                              onPress: () {
                                userProvider
                                    .add(const DownloadFile(fileId: ''));
                                // userProvider.add(
                                //   AddPost(
                                //     post: postController.text,
                                //   ),
                                // );

                                // postController.clear();
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 15,
                  thickness: 3,
                ),
                ...state.userPost.map((e) => Expanded(
                      flex: 0,
                      child: PostWidget(
                        userPost: e,
                      ),
                    )),
              ],
            ),
          ),
        );
      }
      return Ink();
    });
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<ub.UserStateBloc>();

    final state = userProvider.state as UserStateSuccess;

    return Container(
      margin: const EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: CircleAvatar(
              backgroundColor: Colors.greenAccent[400],
              radius: 40,
              backgroundImage: const NetworkImage(
                  'https://lh3.googleusercontent.com/a-/AAuE7mChgTiAe-N8ibcM3fB_qvGdl2vQ9jvjYv0iOOjB=s96-c'),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(state.userSrate.name, style: subtitle6),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Admin',
                style: subtitle7,
              ),
              Text(
                'I work for P4H Global',
                style: subtitle8,
              ),
            ],
          ),
          Column(
            children: [
              const SizedBox(
                height: 22,
              ),
              ButtonBuild(
                color: mainAppColor1,
                buttonText: 'pwogre mwen',
                onPress: () {
                  HttpService().getAnnouncements();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final UserPost userPost;

  const PostWidget({
    super.key,
    required this.userPost,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ub.UserStateBloc, ub.UserState>(
      builder: (context, state) {
        state as UserStateSuccess;
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
                              state.userSrate.name,
                              style: subtitle6,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.timelapse,
                                  color: Colors.grey.shade800,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  userPost.postedAt.toString(),
                                  style: subtitle7,
                                ),
                              ],
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
                child: Column(
                  children: [
                    if (userPost.image != null) Image.memory(userPost.image),
                    Text(userPost.message),
                  ],
                ),
              ),

              if (userPost.comments!.isNotEmpty)
                ...userPost.comments!
                    .map((e) => Flexible(child: Text(e.message))),
              //TODO: implement collapsible comment

              Flexible(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: ButtonBuild(
                          color: mainAppColor2,
                          buttonText: 'Comment',
                          onPress: () {
                            // userProvider.addComment('test cimment', userPost.id!);
                          },
                        ),
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: mainAppColor1),
                          onPressed: () => context
                              .read<UserStateBloc>()
                              .add(DeletePost(id: 69)),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.grey.shade300,
                          ),
                          label: const Text('Delete'))
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 3,
              )
            ],
          ),
        );
      },
    );
  }
}

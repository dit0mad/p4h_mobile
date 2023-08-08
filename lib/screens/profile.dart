import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p4h_mobile/appstate/user_bloc/user__state_bloc.dart' as ub;
import 'package:p4h_mobile/appstate/user_bloc/user__state_bloc.dart';
import 'package:p4h_mobile/appstate/user_bloc/user_state_events.dart';
import 'package:p4h_mobile/constants.dart';
import 'package:p4h_mobile/models/user_post.dart';
import 'package:p4h_mobile/services/http_service.dart';
import 'package:p4h_mobile/widgets/text_field.dart';

class ProfileState extends StatefulWidget {
  const ProfileState({super.key});

  @override
  State<ProfileState> createState() => _ProfileStateState();
}

class _ProfileStateState extends State<ProfileState> {
  late final TextEditingController postController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    postController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<ub.UserStateBloc>();

    return BlocBuilder<ub.UserStateBloc, ub.UserState>(
        builder: (context, state) {
      if (state is ub.UserStateSuccess) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ProfileHeader(),
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.only(left: 2),
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.camera,
                                    color: mainAppColor1,
                                    size: 50,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Mwen Foto \n or Videyo',
                                      style: TextStyle(fontSize: 15),
                                      textAlign: TextAlign.center,
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
                            margin: const EdgeInsets.only(right: 2),
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    (Icons.contact_page),
                                    color: mainAppColor1,
                                    size: 50,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Mwen \n Dokiman',
                                      style: TextStyle(fontSize: 15),
                                      textAlign: TextAlign.center,
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
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: postController,
                          decoration: const InputDecoration(
                            hintText: 'Write Post Here',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                        ),
                      ),
                      Flexible(
                          flex: 0,
                          child: TextButton(
                              onPressed: () {
                                userProvider
                                    .add(const DownloadFile(fileId: ''));
                                // userProvider.add(
                                //   AddPost(
                                //     post: postController.text,
                                //   ),
                                // );

                                // postController.clear();
                              },
                              child: const Text('POST')))
                    ],
                  ),
                ),
                Flexible(
                  child: Ink(
                    color: Colors.blue,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 1.0, left: 4),
                            child: Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: const Text(
                                'Prowfil Pos',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 3,
                          child: CustomSearchField(
                              hintText: 'Search Prowfil', fieldSize: 30),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
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

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 8),
        child: Row(
          children: [
            Flexible(
              child: CircleAvatar(
                backgroundColor: Colors.greenAccent[400],
                radius: 40,
                backgroundImage: const NetworkImage(
                    'https://lh3.googleusercontent.com/a-/AAuE7mChgTiAe-N8ibcM3fB_qvGdl2vQ9jvjYv0iOOjB=s96-c'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.userSrate.name,
                    style: const TextStyle(fontSize: 17),
                  ),
                  const Text(
                    'Admin',
                    style: TextStyle(fontSize: 14),
                  ),
                  const Text(
                    'I work for P4H Global',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(foregroundColor: mainAppColor1),
                child: const Text('pwogre mwen'),
                onPressed: () {
                  HttpService().getAnnouncements();
                },
              ),
            ),
          ],
        ),
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
                      padding: const EdgeInsets.only(left: 5),
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
                            Text(state.userSrate.name),
                            Row(
                              children: [
                                const Icon(
                                  Icons.timelapse,
                                  size: 20,
                                ),
                                Text(
                                  userPost.postedAt.toString(),
                                  style: const TextStyle(fontSize: 17),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: mainAppColor1),
                      onPressed: () {
                        // userProvider.addComment('test cimment', userPost.id!);
                      },
                      child: const Text('Comment'),
                    ),
                    ElevatedButton.icon(
                        onPressed: () => context
                            .read<UserStateBloc>()
                            .add(DeletePost(id: 69)),
                        icon: const Icon(Icons.delete),
                        label: const Text('Delete'))
                  ],
                ),
              ),
              const Divider(
                thickness: 5,
              )
            ],
          ),
        );
      },
    );
  }
}

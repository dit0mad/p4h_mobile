import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p4h_mobile/appstate/user/user_state.dart';
import 'package:p4h_mobile/constants.dart';
import 'package:p4h_mobile/widgets/text_field.dart';
import 'package:provider/provider.dart';

class ProfileState extends StatelessWidget {
  const ProfileState({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserStateProvider>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        TextEditingController().clear();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Ink(
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 8),
                child: Row(
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
                            Text(
                              userProvider.user!.userName!,
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
                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: mainAppColor1),
                          child: const Text('pwogre mwen'),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            child: Ink(
              color: Colors.pink,
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
                      padding: const EdgeInsets.only(bottom: 1.0, left: 4),
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
                      child: CustomTextField(
                          hintText: 'Search Prowfil', fieldSize: 30))
                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: 1,
          ),
          const Flexible(child: CommentWidget()),
          const CommentWidget(),
        ],
      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                    children: const [
                      Text(
                        '2:11',
                        style: TextStyle(fontSize: 17),
                      ),
                      Text(
                        '03/07/2019',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Text('Felisitasyon soti P4H'),
          //TODO: implement collapsible comment
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: mainAppColor1),
                onPressed: () {},
                child: const Text('Comment'),
              ),
            ],
          ),
          const Divider(
            thickness: 5,
          )
        ],
      ),
    );
  }
}

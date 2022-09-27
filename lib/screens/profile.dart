import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p4h_mobile/constants.dart';
import 'package:p4h_mobile/widgets/text_field.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

@override
void initState() {
  //super.initState();
  print('building');
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
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
                      children: const [
                        Text(
                          'Berthrude Albert',
                          style: TextStyle(fontSize: 17),
                        ),
                        Text(
                          'Admin',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
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
                      style: ElevatedButton.styleFrom(primary: mainAppColor1),

                      // style: ,
                      child: const Text('pwogre mwen'),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
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
              Expanded(
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
        Row(
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
                        fontSize: 15,
                        color: Colors.red,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            const Expanded(
                flex: 3,
                child:
                    CustomTextField(hintText: 'Search Prowfil', fieldSize: 30))
          ],
        ),
        const Divider(
          color: Colors.black,
          thickness: 1,
        ),
        const CommentWidget(),
        const CommentWidget(),
      ],
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
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: mainAppColor1),
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

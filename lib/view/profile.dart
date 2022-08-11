import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 100,
            color: Colors.blue,
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
                            'I work for P4h Global',
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
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.green;
                              return Colors.red; // Use the component's default.
                            },
                          ),
                        ),
                        // style: ,
                        child: Text('pwogre mwen'),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 100,
            color: Colors.red,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      print('touched');
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 2),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.green,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: const [
                            Icon(
                              (Icons.camera_alt),
                              color: Colors.black,
                              size: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
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
                      margin: EdgeInsets.only(right: 2),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.green,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: const [
                            Icon(
                              (Icons.contact_page),
                              color: Colors.black,
                              size: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
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
          Container(
            height: 50,
            color: Colors.yellow,
          ),
          Container(
            height: 250,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

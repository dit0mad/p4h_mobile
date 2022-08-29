import 'package:flutter/material.dart';
import 'package:p4h_mobile/screens/profile.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        Searchbar(
          size: 500,
        ),
        MessageCardWidget(),
        MessageCardWidget(),
        MessageCardWidget(),
        MessageCardWidget(),
      ],
    );
  }
}

class MessageCardWidget extends StatelessWidget {
  const MessageCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            width: 400,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: CircleAvatar(
                          backgroundColor: Colors.greenAccent[400],
                          radius: 40,
                          backgroundImage: const NetworkImage(
                              'https://lh3.googleusercontent.com/a-/AAuE7mChgTiAe-N8ibcM3fB_qvGdl2vQ9jvjYv0iOOjB=s96-c'),
                        ),
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
                const Text('Felisitasyon soti P4H \n adfsadasdad \n'),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20),
              height: 60,
              width: 80,
              color: Color.fromARGB(255, 219, 39, 39),
              child: Text(
                textAlign: TextAlign.center,
                'Messaj',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              height: 60,
              width: 80,
              color: Color.fromARGB(255, 13, 55, 103),
              child: Text(
                textAlign: TextAlign.center,
                'Rele',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            )
          ],
        ),
      ],
    );
  }
}

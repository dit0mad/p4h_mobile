import 'package:flutter/material.dart';
import 'package:p4h_mobile/constants.dart';

class MessageCardWidget extends StatelessWidget {
  const MessageCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            width: 400,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 5),
                      child: CircleAvatar(
                        backgroundColor: Colors.greenAccent[400],
                        radius: 40,
                        backgroundImage: const NetworkImage(
                            'https://lh3.googleusercontent.com/a-/AAuE7mChgTiAe-N8ibcM3fB_qvGdl2vQ9jvjYv0iOOjB=s96-c'),
                      ),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              height: 60,
              width: 80,
              color: mainAppColor1,
              child: const Text(
                'Messaj',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              height: 60,
              width: 80,
              color: mainAppColor2,
              child: const Text(
                'Rele',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            )
          ],
        ),
      ],
    );
  }
}

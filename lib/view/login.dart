import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SizedBox(
            height: height,
            width: width,
            child: Column(
              children: [
                Center(
                    child: Text(
                  'P4H Chat',
                  style: Theme.of(context).textTheme.headline1,
                )),
                const SizedBox(
                  height: 15,
                ),
                Center(
                    child: Text(
                  textAlign: TextAlign.center,
                  'Ouvri sesyon an',
                  style: Theme.of(context).textTheme.bodyText1,
                )),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        // Red border with the width is equal to 5
                        border: Border.all(width: 0.5, color: Colors.black38),
                      ),
                      width: 260,
                      child: const TextField(
                        decoration: InputDecoration(
                          labelText: "Non",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.black12,
                      width: 260,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Telefon",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: width * 0.9,
                  child: Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {}, child: const Text('Kontinye'))),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    Center(
                        child: Text(
                      textAlign: TextAlign.center,
                      'Enformaysyon sou \n Profile',
                      style: Theme.of(context).textTheme.bodyText1,
                    )),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                        child: Text(
                      'Mete non ak telefon ou anwo a',
                      style: Theme.of(context).textTheme.bodyText2,
                    )),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                    onPressed: () {}, child: const Text('Adminstrate')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

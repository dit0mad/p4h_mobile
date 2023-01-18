import 'package:flutter/material.dart';
import 'package:p4h_mobile/appstate/user/user_state.dart';
import 'package:p4h_mobile/screens/dashboard.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = 'Discussion Screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final userProvider = Provider.of<UserStateProvider>(context);

    final username = userProvider.user?.userName;

    return SafeArea(
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
                      border: Border.all(width: 0.5, color: Colors.black38),
                    ),
                    width: 260,
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: "Non",
                      ),
                      controller: userNameController,
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
                      controller: passWordController,
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
                        onPressed: ()  {
                          userProvider.login(
                              userNameController.text, passWordController.text);
                        },
                        child: const Text('Kontinye'),
                      ),
                    ),
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
                onPressed: () {},
                child: const Text('testdata'),
              ),
              username != null ? Text(username) : const Text('data'),
            ],
          ),
        ),
      ),
    );
  }
}

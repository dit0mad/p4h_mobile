import 'package:flutter/material.dart';
import 'package:p4h_mobile/appstate/user/user_state.dart';
import 'package:p4h_mobile/constants.dart';

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

    final username = userProvider.user?.name;

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            children: [
              Center(child: Text('P4H Chat', style: headlineStyle1)),
              const SizedBox(
                height: 15,
              ),
              Center(
                  child: Text(
                textAlign: TextAlign.center,
                'Ouvri sesyon an',
                style: bodyText1,
              )),
              const SizedBox(
                height: 35,
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                    child: TextField(
                      decoration:
                          kInputTextFieldDecoration.copyWith(labelText: 'Non'),
                      controller: userNameController,
                    ),
                  ),
                 
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                    child: TextFormField(
                      decoration: kInputTextFieldDecoration.copyWith(
                          labelText: 'Telefon'),
                      controller: passWordController,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: mainAppColor2, elevation: 10),
                            onPressed: () {
                              userProvider.login(
                                  userNameController.text, passWordController.text);
                            },
                            child: Text('Kontinye',style: buttonTitle,),
                          ),
                        ),
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
                    'Enformaysyon sou Profile',
                    style: bodyText1,
                  )),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                      child: Text(
                    'Mete non ak telefon ou anwo a',
                    style: bodyText2,
                  )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                 style: ElevatedButton.styleFrom(
                            backgroundColor: mainAppColor2, elevation: 10),
                onPressed: () {},
                child:  Text('Testdata',style: buttonTitle,),
              ),
              username != null ? Text(username) : Text('Data',style: bodyText2,),
            ],
          ),
        ),
      ),
    );
  }
}

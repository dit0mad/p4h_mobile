import 'package:flutter/material.dart';
import 'package:p4h_mobile/appstate/user_state.dart';
import 'package:p4h_mobile/models/http_exception.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = 'Discussion Screen';
  

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;


  final userNameController = TextEditingController();
  final passWordController = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: const Text('An Error Occured'),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                    onPressed: (() {
                      Navigator.of(context).pop();
                    }),
                    child: const Text('Okay'))
              ],
            )));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
     Provider.of<UserStateProvider>(context).login(userNameController.text,passWordController.text);
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Could not authenticate you.Please try again later.';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // final userProvider = Provider.of<UserStateProvider>(context);

    // final name = userProvider.user!.userName;

    // if (userProvider.user!.userName != null) {
    //   return Ink(
    //     child: Text(name),
    //   );
    // }

    return SafeArea(
      child: Form(
        key: _formKey,
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
                        child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Nom",
                            ),
                            controller: userNameController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter username';
                              }
                              if (!value.endsWith('@yahoo.com') &&
                                  !value.endsWith('@gmail.com') &&
                                  !value.endsWith('@co.uk')) {
                                return 'Invalid username';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                             
                            }),
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
                          obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter password';
                      }
                      if (value.length < 6) {
                        return 'Password is too short';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      
                    },
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
                                onPressed: _submit,
                                // userProvider.login(userNameController.text,passWordController.text);
                                child: const Text('Kontinye'))),
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
      ),
    );
  }
}

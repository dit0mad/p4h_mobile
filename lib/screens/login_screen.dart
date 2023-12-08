import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4h_mobile/appstate/user/user_state_old.dart' as us;
import 'package:p4h_mobile/appstate/user_bloc/user__state_bloc.dart';
import 'package:p4h_mobile/appstate/user_bloc/user_state_events.dart';
import 'package:p4h_mobile/widgets/build_button.dart';
import 'package:p4h_mobile/widgets/build_logo.dart';

import '../constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = 'Discussion Screen';

  @override
  Widget build(BuildContext context) {
    return const LoginForm();
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    passWordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    void validateUserInfo() {
      if (userNameController.text.isNotEmpty &&
          passWordController.text.isNotEmpty) {
        context.read<UserStateBloc>().add(
              UserLoginEvent(
                password: passWordController.text,
                username: userNameController.text,
              ),
            );
      }
    }

    return BlocBuilder<UserStateBloc, UserState>(
      builder: (BuildContext context, UserState state) {
        if (state is UserInitial) {
          final invalidUserError =
              state.loginErrors.whereType<us.InvalidUserName>().firstOrNull;
          final invalidPassWordError =
              state.loginErrors.whereType<us.InvalidPassword>().firstOrNull;

          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    SizedBox(height: height * .01),
                    Center(
                        child: Text(
                      'P4H Chat',
                      style: headlineStyle1,
                    )),
                    SizedBox(height: height * .02),
                    SizedBox(
                      height: height * 0.2,
                      child: const Logo(),
                    ),
                    SizedBox(height: height * .02),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Ouvri sesyon an',
                        style: bodyText1,
                      ),
                    ),
                    if (invalidUserError != null)
                      Text(invalidUserError.basicDescription()),
                    if (invalidPassWordError != null)
                      Text(invalidPassWordError.basicDescription()),
                    const FormItself(),
                    SizedBox(height: height * .03),
                    Center(
                      child: Text(
                        'Enformaysyon sou Profile',
                        style: bodyText1,
                      ),
                    ),
                    SizedBox(height: height * .01),
                    Center(
                      child: Text(
                        'Mete non ak telefon ou anwo a',
                        style: bodyText2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (state is UserStateLoading) {
          return Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Fetching Information', style: subtitle2),
              const CircularProgressIndicator(),
            ],
          ));
        }

        // if (state is UserStateError) {
        //   return Center(child: const Text('Invalid Password'));
        // }

        return const CircularProgressIndicator();
      },
    );
  }
}

class FormItself extends StatefulWidget {
  const FormItself({Key? key}) : super(key: key);

  @override
  State<FormItself> createState() => _FormItselfState();
}

class _FormItselfState extends State<FormItself> {
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userNameController.dispose();
    passWordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void submitForm() {
      if (_formKey.currentState!.validate()) {
        context.read<UserStateBloc>().add(ClearLoginErrors());
        context.read<UserStateBloc>().add(
              UserLoginEvent(
                password: passWordController.text,
                username: userNameController.text,
              ),
            );
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            height: 60,
            margin: const EdgeInsets.symmetric(horizontal: 25),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
              color: Colors.black12,
            ),
            child: TextFormField(
              onTapOutside: ((event) {
                FocusScope.of(context).unfocus();
              }),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                labelText: 'Non',
              ),
              controller: userNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Username Cannot Be Empty';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 60,
            margin: const EdgeInsets.symmetric(horizontal: 25),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
              color: Colors.black12,
            ),
            child: TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                labelText: 'Telefon',
              ),
              controller: passWordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password Cannot Be Empty';
                }
                return null;
              },
            ),
          ),
          SubmitButton(
            callback: () => submitForm(),
          ),
        ],
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final VoidCallback callback;
  const SubmitButton({
    super.key,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonBuild(
      color: mainAppColor2,
      buttonText: 'Kontinye',
      onPress: () {
        callback();
      },
    );
  }
}

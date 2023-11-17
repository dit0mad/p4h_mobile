import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4h_mobile/appstate/user_bloc/user__state_bloc.dart';
import 'package:p4h_mobile/appstate/user_bloc/user_state_events.dart';
import 'package:p4h_mobile/widgets/build_button.dart';
import 'package:p4h_mobile/widgets/build_logo.dart';
import '../constants.dart';
import '../widgets/login_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = 'Discussion Screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserStateBloc, UserState>(
      builder: (BuildContext context, UserState state) {
        //put state in provider/
        if (state is UserInitial) {
          return const LoginForm();
        }

        if (state is UserStateLoading) {
          return const LoadingScreen(
            text: "Authenticating",
          );
        }

        if (state is UserStateError) {
          return Center(child: Text(state.error));
        }

        return const LoadingScreen(
          text: "Error",
        );
      },
    );
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

    return BlocBuilder<UserStateBloc, UserState>(
      builder: (BuildContext context, UserState state) {
        if (state is UserInitial) {
          return SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SizedBox(
                height: height,
                width: width,
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
                    Center(
                        child: Text(
                      'Ouvri sesyon an',
                      style: bodyText1,
                    )),
                    SizedBox(height: height * .04),
                    LoginTextField(
                      controller: userNameController,
                      text: 'Non',
                    ),
                    SizedBox(height: height * .01),
                    LoginTextField(
                      controller: passWordController,
                      text: 'Telefon',
                    ),
                    SizedBox(height: height * .04),
                    SizedBox(
                      height: height * .05,
                      width: width * 0.8,
                      child: ButtonBuild(
                        color: mainAppColor2,
                        buttonText: 'Kontinye',
                        onPress: () {
                          context.read<UserStateBloc>().add(
                                UserLoginEvent(
                                  password: passWordController.text,
                                  userName: userNameController.text,
                                ),
                              );
                        },
                      ),
                    ),
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

        if (state is UserStateError) {
          return const Text('Invalid Password');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}

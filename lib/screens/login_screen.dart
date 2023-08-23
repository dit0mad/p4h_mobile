import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4h_mobile/appstate/user_bloc/user__state_bloc.dart';
import 'package:p4h_mobile/appstate/user_bloc/user_state_events.dart';
import '../constants.dart';
import '../widgets/login_text_field.dart';

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
                    const SizedBox(
                      height: 10,
                    ),
                    Center(child: Text('P4H Chat', style: headlineStyle1)),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        height: height * 0.2,
                        width: width,
                        child: const Image(
                            image: AssetImage('assets/images/p4h.png'))),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Text(
                      'Ouvri sesyon an',
                      style: bodyText1,
                    )),
                    const SizedBox(
                      height: 30,
                    ),
                    LoginTextField(
                      controller: userNameController,
                      text: 'Non',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    LoginTextField(
                      controller: passWordController,
                      text: 'Telefon',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 50,
                      width: width * 0.7,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: mainAppColor2, elevation: 20),
                        onPressed: () {
                          context.read<UserStateBloc>().add(UserLoginEvent(
                                password: passWordController.text,
                                userName: userNameController.text,
                              ));
                        },
                        child: Text(
                          'Kontinye',
                          style: buttonTitle,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Center(
                        child:
                            Text('Enformaysyon sou Profile', style: bodyText1)),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                        child: Text('Mete non ak telefon ou anwo a',
                            style: bodyText2)),
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

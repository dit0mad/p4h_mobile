import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4h_mobile/appstate/user_bloc/user__state_bloc.dart';
import 'package:p4h_mobile/appstate/user_bloc/user_state_events.dart';
import 'package:p4h_mobile/widgets/build_button.dart';
import 'package:p4h_mobile/widgets/build_logo.dart';
import '../constants.dart';
import 'loading_screen.dart';

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
        context.read<UserStateBloc>().add(
              UserLoginEvent(
                password: passWordController.text,
                userName: userNameController.text,
              ),
            );
      }
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
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
              callback: submitForm,
            ),
          ],
        ),
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

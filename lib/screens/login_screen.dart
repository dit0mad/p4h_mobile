import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4h_mobile/appstate/user_bloc/user__state_bloc.dart';
import 'package:p4h_mobile/appstate/user_bloc/user_state_events.dart';
import 'package:p4h_mobile/widgets/loading_screen.dart';

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
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Widget button = Row(
      children: [
        const Expanded(child: SizedBox()),
        Flexible(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {
              context.read<UserStateBloc>().add(UserLoginEvent(
                    password: passWordController.text,
                    userName: userNameController.text,
                  ));
            },
            child: const Text('Kontinye'),
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );

    Widget footer = Column(
      children: [
        Center(
            child: Text(
          textAlign: TextAlign.center,
          'Enformaysyon sou \n Profile',
          style: Theme.of(context).textTheme.bodyLarge,
        )),
        const SizedBox(
          height: 15,
        ),
        Center(
            child: Text(
          'Mete non ak telefon ou anwo a',
          style: Theme.of(context).textTheme.bodyMedium,
        )),
      ],
    );

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Center(
                child: Text(
              textAlign: TextAlign.center,
              'P4H Chat',
              style: Theme.of(context).textTheme.bodyLarge,
            )),
            Form(
                userNameController: userNameController,
                passWordController: passWordController),
            button,
            footer,
          ],
        ),
      ),
    );
  }
}

class Form extends StatelessWidget {
  const Form({
    super.key,
    required this.userNameController,
    required this.passWordController,
  });

  final TextEditingController userNameController;
  final TextEditingController passWordController;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Telefon",
            ),
            controller: passWordController,
          ),
        ),
      ],
    );
  }
}

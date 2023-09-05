import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4h_mobile/appstate/user_bloc/user__state_bloc.dart';
import 'package:p4h_mobile/appstate/user_bloc/user_state_events.dart';

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
                      height: 15,
                    ),
                    Center(
                        child: Text(
                      textAlign: TextAlign.center,
                      'Ouvri sesyon an',
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            border:
                                Border.all(width: 0.5, color: Colors.black38),
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
                              onPressed: () {
                                context
                                    .read<UserStateBloc>()
                                    .add(UserLoginEvent(
                                      password: passWordController.text,
                                      userName: userNameController.text,
                                    ));
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
                    ),
                    const SizedBox(
                      height: 25,
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
              Text(
                'Fetching Information',
                style: Theme.of(context).textTheme.bodySmall,
              ),
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

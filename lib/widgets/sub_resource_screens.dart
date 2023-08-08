import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4h_mobile/appstate/user_bloc/user__state_bloc.dart';
import 'package:p4h_mobile/appstate/user_bloc/user_state_events.dart';
import 'package:p4h_mobile/constants.dart';
import 'build_card.dart';
import 'build_divider.dart';
import 'text_field.dart';

class SubResourceScreens extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;

  const SubResourceScreens({
    Key? key,
    required this.text1,
    required this.text2,
    required this.text3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Column(
            children: [
              const CustomSearchField(
                hintText: 'Search Resous',
                fieldSize: 40,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: BuildCard(
                      icon: Icons.download,
                      fillColor: mainFillColor,
                      titleText: text1,
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 70,
                      color: mainAppColor2,
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        child: Text(
                          'View',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const BuildDivider(),
              BlocBuilder<UserStateBloc, UserState>(builder: (
                context,
                state,
              ) {
                final userProvider = context.read<UserStateBloc>();

                return Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: BuildCard(
                        icon: Icons.download,
                        fillColor: mainFillColor,
                        titleText: 'download',
                        onPressed: () {
                          userProvider.add(const Download());
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 70,
                        color: const Color(0XFF153760),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          child: Text(
                            'View',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
              const BuildDivider(),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: BuildCard(
                      icon: Icons.download,
                      fillColor: mainFillColor,
                      titleText: text3,
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 70,
                      color: const Color(0XFF153760),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        child: Text(
                          'View',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              BlocBuilder<UserStateBloc, UserState>(
                builder: (context, state) {
                  if (state is UserStateSuccess) {
                    final image = state.image;

                    return image == null
                        ? Ink()
                        : SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.file(File(state.image!)));
                  }
                  return Ink();
                },
              ),
              const BuildDivider(),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'dart:io';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4h_mobile/appstate/actions_bloc/action_bloc.dart';
import 'package:p4h_mobile/appstate/actions_bloc/actions.dart';
import 'package:p4h_mobile/appstate/nav_bloc/nav_bloc.dart';
import 'package:p4h_mobile/appstate/nav_bloc/nav_events.dart';
import 'package:p4h_mobile/appstate/user_bloc/user__state_bloc.dart';
import 'package:p4h_mobile/appstate/user_bloc/user_state_events.dart';
import 'package:p4h_mobile/constants.dart';
import 'build_card.dart';
import 'build_divider.dart';

class SubResourceScreenLoading extends StatelessWidget {
  const SubResourceScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(builder: (context, state) {
      return const Center(child: CircularProgressIndicator());
    });
  }
}

class SubResourceScreenSuccess extends StatelessWidget {
  const SubResourceScreenSuccess({Key? key}) : super(key: key);

// class SubResourceScreens extends StatelessWidget {
//   const SubResourceScreens({
//     Key? key,
//   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActionListenerBloc, BaseAction>(
      builder: (context, action) {
        // preffered way of listening to actions so we can pause the whole app kinda vibes.

        if (action is LoadingAction) {
          return const Center(child: CircularProgressIndicator());
        }

        if (action is BaseActionSuccess) {
          return BlocBuilder<UserStateBloc, UserState>(builder: (
            final context,
            final state,
          ) {
            final nextState = state as UserStateSuccess;

            final resourseList = nextState.resourceFolder!;

            return Column(
              children: [
                // const CustomSearchField(
                //   hintText: 'Search Resous',
                //   fieldSize: 40,
                // ),
                Column(
                  children: [
                    ...resourseList.resources.map(
                      (e) => Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: BuildCard(
                              icon: Icons.download,
                              fillColor: mainFillColor,
                              titleText: e.display,
                              onPressed: () {
                                BlocProvider.of<UserStateBloc>(context)
                                    .add(Download(
                                  fileID: e.id,
                                  fileName: e.display,
                                ));
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 70,
                              color: mainAppColor2,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                child: Text(
                                  'View',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const BuildDivider(),
                const Expanded(child: DownloadedFile()),
                const TemporaryBackButton(),
              ],
            );
          });
        }

        return Ink();
      },
    );
  }
}

class TemporaryBackButton extends StatelessWidget {
  const TemporaryBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Ink(
            width: 100,
            decoration: BoxDecoration(color: Colors.red, border: Border.all()),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                BlocProvider.of<NavigationBloc>(context).add(
                  PopRoute(
                    target: Target.resourceStack,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class DownloadedFile extends StatelessWidget {
  const DownloadedFile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserStateBloc, UserState>(
      builder: (context, state) {
        if (state is UserStateSuccess) {
          final image = state.filePath;

          return image == null ? Ink() : const FilePreview();
        }
        return Ink(
          color: Colors.green,
        );
      },
    );
  }
}

class FilePreview extends StatelessWidget {
  const FilePreview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserStateBloc, UserState>(builder: (context, state) {
      state as UserStateSuccess;
      return SizedBox(
          height: 200,
          width: 200,
          child: Image.file(
            File(state.filePath!),
          ));
    });
  }
}

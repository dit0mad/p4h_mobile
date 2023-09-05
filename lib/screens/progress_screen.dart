import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4h_mobile/appstate/nav_bloc/nav_bloc.dart';
import 'package:p4h_mobile/appstate/nav_bloc/nav_events.dart';
import 'package:p4h_mobile/appstate/user_bloc/user__state_bloc.dart';
import 'package:p4h_mobile/appstate/user_bloc/user_state_events.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              BlocProvider.of<NavigationBloc>(context).add(
                PopRoute(target: Target.mainStack),
              );
            },
          ),
          automaticallyImplyLeading: true,
        ),
        body: BlocBuilder<UserStateBloc, UserState>(builder: (
          context,
          state,
        ) {
          if (state is UserStateLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final nextState = state as UserStateSuccess;

          final progress = nextState.progress;

          return Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...progress.map((e) => Ink(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Expanded(child: Text(e.name)),
                            Checkbox(
                              value: e.hasSubmission,
                              onChanged: (value) => '',
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text('Upload Submission'))
                          ],
                        ),
                      ))
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

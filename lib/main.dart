import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:p4h_mobile/appstate/actions_bloc/action_bloc.dart';
import 'package:p4h_mobile/appstate/actions_bloc/actions.dart';
import 'package:p4h_mobile/appstate/nav_bloc/nav_bloc.dart';
import 'package:p4h_mobile/appstate/nav_bloc/nav_events.dart';
import 'package:p4h_mobile/appstate/user_bloc/user__state_bloc.dart';
import 'package:p4h_mobile/navobserver.dart';
import 'package:p4h_mobile/screens/dashboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const P4HBlocObserver();
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => UserStateBloc(),
      ),
      BlocProvider(
        create: (_) => NavigationBloc(),
      ),
      BlocProvider(
        create: (_) => ActionListenerBloc(
          bloc: _.read<NavigationBloc>(),
          userStateBloc: _.read<UserStateBloc>(),
        ),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      home: const Mediator(),
    );
  }
}

class Mediator extends StatelessWidget {
  const Mediator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserStateBloc, UserState>(
        listener: (context, state) {
//@yasantha
          //pushes when login is success. can be moved to an action listener
          if (state is UserStatePush) {
            BlocProvider.of<NavigationBloc>(context).add(
              const PopToRootPushPageRoute(
                target: Target.mainStack,
                page: MaterialPage(
                  name: 'dashboard',
                  child: Dashboard(),
                ),
              ),
            );
          }
        },
        child: const NavigationBuilder(),
      ),
    );
  }
}

class NavigationBuilder extends StatelessWidget {
  const NavigationBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        final bloc = BlocProvider.of<NavigationBloc>(context);

        final stack = bloc.state.mainStack.length;

        if (stack.isEqual(1)) {
          //TODO @yasantha:     // terminate all peacefully;

          exit(0);
        }

        bloc.add(PopRoute(target: Target.mainStack));
      },
      child: Scaffold(
        body: BlocBuilder<ActionListenerBloc, BaseAction>(
            builder: (context, state) {
          if (state is LoadingAction) {
            return const Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Loading"),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          }
          return BlocBuilder<NavigationBloc, NavigationStackState>(
            builder: (BuildContext context, NavigationStackState state) {
              return Navigator(
                key: mainNavigatorKey,
                onPopPage: (final Route<dynamic> route, final dynamic result) {
                  return route.didPop(result);
                },
                pages: [
                  ...state.mainStack,
                  ...state.modalStack.nonNulls,
                ],
              );
            },
          );
        }),
      ),
    );
  }
}

final GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> resourceNavigatorKey =
    GlobalKey<NavigatorState>();

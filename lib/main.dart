import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4h_mobile/appstate/nav_bloc/nav_bloc.dart';
import 'package:p4h_mobile/appstate/nav_bloc/nav_events.dart';
import 'package:p4h_mobile/appstate/user_bloc/user__state_bloc.dart';
import 'package:p4h_mobile/navobserver.dart';
import 'package:p4h_mobile/screens/dashboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const WeatherBlocObserver();
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => UserStateBloc(),
      ),
      BlocProvider(
        create: (_) => NavigationBloc(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Mediator(),
    );
  }
}

class Mediator extends StatelessWidget {
  const Mediator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserStateBloc, UserState>(
      listener: (context, state) {
        if (state is UserStatePush) {
          BlocProvider.of<NavigationBloc>(context).add(
            const PopToRootPushPageRoute(
              target: Target.mainStack,
              page: MaterialPage(
                name: 'dashboard',
                child: Material(
                  child: Dashboard(),
                ),
              ),
            ),
          );
        }
      },
      child: const NavigationBuilder(),
    );
  }
}

class NavigationBuilder extends StatelessWidget {
  const NavigationBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, MainStackState>(
      builder: (BuildContext context, MainStackState state) {
        return Navigator(
          key: mainNavigatorKey,
          onPopPage: (final Route<dynamic> route, final dynamic result) {
            return route.didPop(result);
          },
          pages: [
            ...state.mainStack,
          ],
        );
      },
    );
  }
}

final GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> resourceNavigatorKey =
    GlobalKey<NavigatorState>();

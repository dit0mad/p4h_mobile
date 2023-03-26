import 'package:flutter/material.dart';
import 'package:p4h_mobile/appstate/nagivation/nav_state.dart';
import 'package:p4h_mobile/appstate/user/user_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NavgiationState(),
        ),
        ChangeNotifierProxyProvider<NavgiationState, UserStateProvider>(
          create: (_) => UserStateProvider(
            navstate: NavgiationState(),
          ),
          update: (BuildContext context, value, UserStateProvider? previous) {
            return UserStateProvider(
              navstate: value,
              user: previous?.user,
              userPost: previous!.getUserposts.toList(),
            );
          },
          child: const MyApp(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final navStateProvider = Provider.of<NavgiationState>(context);
    final stack = navStateProvider.mainStack;

    return MaterialApp(
        title: 'P4H',
        theme: ThemeData(
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              color: Color.fromARGB(255, 6, 50, 88),
              fontSize: 35,
              fontWeight: FontWeight.w800,
            ),
            bodyLarge: TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
            bodyMedium: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            titleMedium: TextStyle(
              color: Color(0XFF6E6E6E),
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
            titleSmall: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        home: Navigator(
          pages: [...stack],
          onPopPage: (route, result) => route.didPop(result),
        ));
  }
}

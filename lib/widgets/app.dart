import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../appstate/nagivation/nav_state.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final navStateProvider = Provider.of<NavgiationState>(context);
    final stack = navStateProvider.mainStack;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'P4H',
        home: Navigator(
          pages: [...stack],
          onPopPage: (route, result) => route.didPop(result),
        ));
  }
}
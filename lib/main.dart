import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../appstate/nagivation/nav_state.dart';
import '../appstate/user/user_state.dart';
import 'widgets/app.dart';



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
              announcements: previous.getAnnouncements.toList(),
            );
          },
          child: const MyApp(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}



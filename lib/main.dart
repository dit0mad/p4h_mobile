import 'package:flutter/material.dart';
import 'package:p4h_mobile/screens/dashboard.dart';
import 'package:p4h_mobile/screens/discussion.dart';
import 'package:p4h_mobile/screens/resource_screens/lesson_plan_screen.dart';
import 'package:p4h_mobile/screens/resource_screens/photo_screen.dart';
import 'package:p4h_mobile/screens/resource_screens/resource_screen.dart';
import 'package:p4h_mobile/screens/resource_screens/video_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: const TextTheme(
            headline1: TextStyle(
              color: Color.fromARGB(255, 6, 50, 88),
              fontSize: 35,
              fontWeight: FontWeight.w800,
            ),
            bodyText1: TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
            bodyText2: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            subtitle1: TextStyle(
              color: Color(0XFF6E6E6E),
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
            subtitle2: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        home: const Scaffold(
          body: Dashboard(),
        ),
        routes: {
          Dashboard.routeName: (ctx) => const Dashboard(),
          LessonPlanScreen.routeName: (ctx) => const LessonPlanScreen(),
          VideoScreen.routeName: (ctx) => const VideoScreen(),
          PhotoScreen.routeName: (ctx) => const PhotoScreen(),
          ResourceScreen.routeName: (ctx) => const ResourceScreen(),
          DiscussionScreen.routeName: (ctx) => const DiscussionScreen()
        });
  }
}

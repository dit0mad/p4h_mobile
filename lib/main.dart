import 'package:flutter/material.dart';
import 'package:p4h_mobile/view/dashboard.dart';

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
        ),
      ),
      home: const Scaffold(body: Dashboard()),
    );
  }
}

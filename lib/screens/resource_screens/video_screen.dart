import 'package:flutter/material.dart';
import 'package:p4h_mobile/screens/resource_screens/course_file_screen.dart';

class VideoScreen extends ResourceScreenNavigator {
  static const routeName = 'Video Screen';
  const VideoScreen({Key? key}) : super(key: key);

  @override
  Widget get child => Material(
        child: PopScope(
          onPopInvoked: (didPop) async => false,
          child: Container(),
        ),
      );
}

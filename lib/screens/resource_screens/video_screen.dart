import 'package:flutter/material.dart';
import 'package:p4h_mobile/widgets/sub_resource_screens.dart';

class VideoScreen extends StatelessWidget {
  static const routeName = 'Video Screen';
  const VideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SubResourceScreens(
      text1: 'Videyo.mp3',
      text2: 'Videyo2.mp3',
      text3: 'Videyo3.mp3',
    );
  }
}

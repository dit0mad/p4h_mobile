import 'package:flutter/material.dart';
import 'package:p4h_mobile/widgets/sub_resource_screens.dart';

class LessonPlanScreen extends StatelessWidget {
  static const routeName = 'Lesson Plan Screen';
  const LessonPlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: WillPopScope(
        onWillPop: () async => false,
        child: const SubResourceScreens(),
      ),
    );
  }
}

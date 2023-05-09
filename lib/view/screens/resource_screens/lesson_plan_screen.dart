import 'package:flutter/material.dart';
import 'package:p4h_mobile/widgets/sub_resource_screens.dart';

class LessonPlanScreen extends StatelessWidget {
  static const routeName = 'Lesson Plan Screen';
  const LessonPlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SubResourceScreens(
      text1: 'Dokiman.txt',
      text2: 'Dokiman2.docx',
      text3: 'Dokiman.pdf',
    );
  }
}

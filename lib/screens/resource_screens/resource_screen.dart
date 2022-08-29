import 'package:flutter/material.dart';
import 'package:p4h_mobile/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p4h_mobile/screens/resource_screens/lesson_plan_screen.dart';
import 'package:p4h_mobile/screens/resource_screens/photo_screen.dart';
import 'package:p4h_mobile/screens/resource_screens/video_screen.dart';
import '../../widgets/custom_build_card.dart';
import '../../widgets/custom_build_divider.dart';

class ResourceScreen extends StatelessWidget {
  static const routeName = 'Resource Screen';
  const ResourceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Column(
            children: [
              const CustomTextField(),
              BuildCard(
                icon: FontAwesomeIcons.book,
                titleText: 'Lesson Plans',
                subTitleText: 'Documents to help everyday teaching.',
                onPressed: () {
                  Navigator.pushNamed(context,LessonPlanScreen.routeName);
                },
                iconColor: mainIconColor,
              ),
              const BuildDivider(),
              BuildCard(
                icon: FontAwesomeIcons.video,
                titleText: 'Videyo',
                subTitleText: 'Instructional Videos.',
                onPressed: () {
                   Navigator.pushNamed(context,VideoScreen.routeName);
                },
                iconColor: mainIconColor,
              ),
              const BuildDivider(),
              BuildCard(
                icon: FontAwesomeIcons.camera,
                titleText: 'Foto',
                subTitleText: 'Instructional Videos.',
                onPressed: () {
                   Navigator.pushNamed(context,PhotoScreen.routeName);
                },
                iconColor: mainIconColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Container(
        height: 40,
        child: TextFormField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: const Color(0XFFE4E4E5),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none),
            labelText: 'Search Resous',
          ),
        ),
      ),
    );
  }
}

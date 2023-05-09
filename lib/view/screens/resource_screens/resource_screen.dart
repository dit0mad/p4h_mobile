import 'package:flutter/material.dart';
import 'package:p4h_mobile/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p4h_mobile/view/screens/resource_screens/lesson_plan_screen.dart';
import 'package:p4h_mobile/view/screens/resource_screens/photo_screen.dart';
import 'package:p4h_mobile/view/screens/resource_screens/video_screen.dart';
import '../../../widgets/build_card.dart';
import '../../../widgets/build_divider.dart';
import '../../../widgets/text_field.dart';

class ResourceScreen extends StatelessWidget {
  static const routeName = 'Resource Screen';
  const ResourceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 1),
      child: Column(
        children: [
          const CustomTextField(hintText: 'Search Resous',fieldSize: 40,),
        
          BuildCard(
            icon: FontAwesomeIcons.book,
            titleText: 'Lesson Plans',
            subTitleText: 'Documents to help everyday teaching.',
            onPressed: () {
              Navigator.pushNamed(context, LessonPlanScreen.routeName);
            },
            iconColor: mainIconColor,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: BuildDivider(),
          ),
          BuildCard(
            icon: FontAwesomeIcons.video
            ,
            titleText: 'Videyo',
            subTitleText: 'Instructional Videos.',
            onPressed: () {
              Navigator.pushNamed(context, VideoScreen.routeName);
            },
            iconColor: mainIconColor,
          ),
         const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: BuildDivider(),
          ),
          BuildCard(
            icon:  FontAwesomeIcons.camera,
            titleText: 'Foto',
            subTitleText: 'Instructional Videos.',
            onPressed: () {
              Navigator.pushNamed(context, PhotoScreen.routeName);
            },
            iconColor: mainIconColor,
          ),
        ],
      ),
    );
  }
}



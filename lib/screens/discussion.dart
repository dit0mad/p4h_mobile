import 'package:flutter/material.dart';
import 'package:p4h_mobile/screens/profile.dart';

class DiscussionScreen extends StatelessWidget {
  static const routeName = 'Discussion Screen';
  const DiscussionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Searchbar(
                size: 200,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
                child: Icon(
              Icons.video_call,
              color: Colors.redAccent,
              size: 50,
            )),
            VerticalDivider(
              color: Colors.redAccent, width: 10, //width space of divider
              thickness: 3, //thickness of divier line
              indent: 10, //Spacing at the top of divider.
              endIndent: 10, //Spacing at the bottom of divider.
            ),
            Expanded(
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.redAccent,
                size: 50,
              ),
            ),
            Expanded(
              child: Icon(
                (Icons.contact_page),
                color: Colors.redAccent,
                size: 50,
              ),
            ),
          ],
        ),
        const CommentWidget(),
      ],
    );
  }
}

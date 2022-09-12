import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p4h_mobile/constants.dart';
import 'package:p4h_mobile/screens/profile.dart';
import 'package:p4h_mobile/widgets/build_divider.dart';
import '../widgets/text_field.dart';

class DiscussionScreen extends StatelessWidget {
  static const routeName = 'Discussion Screen';
  const DiscussionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: EdgeInsets.zero,
          child: Row(
            children: const [
              Expanded(
                flex: 4,
                child: CustomTextField(
                  hintText: 'Search Diskisyon',
                  fieldSize: 30,
                ),
              ),
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 10,
                  ))
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.zero,
          child: Row(
            children: [
              const Expanded(
                flex: 4,
                child: CustomTextField(
                  hintText: 'Diskisyon Pos',
                  fieldSize: 30,
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Icon(FontAwesomeIcons.globe,size: 20, color: mainAppColor1),)
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            children: [
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.video,
                    color: mainIconColor,
                    size: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Videyo',
                      style: subtitle4,
                    ),
                  )
                ],
              ),
              const Expanded(
                  child: SizedBox(
                      height: 50,
                      child: VerticalDivider(
                        color: Colors.grey,
                        thickness: 1,
                      ))),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.camera,
                    color: mainIconColor,
                    size: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Foto',
                      style: subtitle4,
                    ),
                  )
                ],
              ),
              const Expanded(
                  child: SizedBox(
                      height: 50,
                      child: VerticalDivider(
                        color: Colors.grey,
                        thickness: 1,
                      ))),
              Row(
                children: [
                  Icon(
                    (Icons.contact_page),
                    color: mainIconColor,
                    size: 50,
                  ),
                  Text(
                    'Dokiman',
                    style: subtitle4,
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: const BuildDivider()),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(child: CommentWidget()),
               Icon(FontAwesomeIcons.globe,color: mainAppColor1,size: 20,)

            ],
             
          ),
          
        ),
        const Divider(
            thickness: 5,
          )
      ],
    );
  }
}

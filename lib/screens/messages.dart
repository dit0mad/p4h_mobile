import 'package:flutter/material.dart';
import 'package:p4h_mobile/widgets/build_divider.dart';
import '../widgets/message_card.dart';
import '../widgets/text_field.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CustomTextField(
          hintText: 'Search',
          fieldSize: 40,
        ),
        MessageCardWidget(),
        BuildDivider(),
        MessageCardWidget(),
        BuildDivider(),
        MessageCardWidget(),
        BuildDivider(),
        MessageCardWidget(),
        BuildDivider(),
      ],
    );
  }
}

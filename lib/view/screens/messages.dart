import 'package:flutter/material.dart';
import 'package:p4h_mobile/appstate/user/user_state.dart';
import 'package:provider/provider.dart';
import '../../widgets/text_field.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserStateProvider>(context);

    print('printing from message :(');
    return Column(
      children: [
        const CustomTextField(
          hintText: 'Search',
          fieldSize: 40,
        ),
        ...userProvider.getAnnouncements.map((e) => Text(e.message)),
      ],
    );
  }
}

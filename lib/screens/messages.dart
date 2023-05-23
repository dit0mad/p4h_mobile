import 'package:flutter/material.dart';
import 'package:p4h_mobile/appstate/user/user_state.dart';
import 'package:p4h_mobile/screens/rocketchat.dart';
import 'package:provider/provider.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserStateProvider>(context);

    return const RocketChatScreen();
  }
}

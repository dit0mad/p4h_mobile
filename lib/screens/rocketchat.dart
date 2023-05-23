import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RocketChatScreen extends StatefulWidget {
  const RocketChatScreen({Key? key}) : super(key: key);

  @override
  State<RocketChatScreen> createState() => _RocketChatScreenState();
}

class _RocketChatScreenState extends State<RocketChatScreen> {
  late final WebViewController controller;

  //login via token each user/
  //master admin password.

  //api/rocket/token/$tokenID

  // sees that im logged in and send a token back.

  //loggin in thru i frame

  @override
  void initState() {
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://messaging.p4hteach.org/home'),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    //content window

    return WebViewWidget(
      controller: controller,
    );
  }
}

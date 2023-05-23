import 'package:flutter/material.dart';
import 'package:p4h_mobile/appstate/nagivation/nav_reducer.dart';
import 'package:p4h_mobile/appstate/user/user_state.dart';

abstract class NavigationAction extends BaseAction {
  const NavigationAction();
}

class PushPageRoute extends NavigationAction {
  final Target target;
  final MaterialPage page;
  const PushPageRoute({required this.target, required this.page});
}

import 'package:flutter/material.dart';

// abstract class NavigationAction extends BaseAction {
//   const NavigationAction();
// }

// class PushPageRoute extends NavigationAction {
//   final Target target;
//   final MaterialPage page;
//   const PushPageRoute({required this.target, required this.page});
// }

class Target {
  final String _value;

  String get value => _value;

  const Target._string(this._value);

  static const Target mainStack = Target._string('mainStack');
  static const Target loggedIn = Target._string('loggedIn');
  static const Target resourceStack = Target._string('resource');
}

sealed class NavigationEvent {
  final Target target;
  final MaterialPage page;
  const NavigationEvent({required this.page, required this.target});
}

final class PushPageRoute extends NavigationEvent {
  const PushPageRoute({
    required super.page,
    required super.target,
  });
}

final class PopToRootPushPageRoute extends NavigationEvent {
  const PopToRootPushPageRoute({
    required super.page,
    required super.target,
  });
}

import 'package:flutter/material.dart';
import 'package:p4h_mobile/appstate/actions_bloc/actions.dart';

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
  // final MaterialPage? page;

  MaterialPage get pages;
  BaseAction? get sideEffect;
  const NavigationEvent({required this.target});
}

class PushPageRoute extends NavigationEvent {
  final MaterialPage page;
  const PushPageRoute({
    required this.page,
    required super.target,
  });

  @override
  MaterialPage get pages => page;

  @override
  BaseAction? get sideEffect => throw UnimplementedError();
}

class PopToRootPushPageRoute extends NavigationEvent {
  final MaterialPage page;
  const PopToRootPushPageRoute({
    required this.page,
    required super.target,
  });

  @override
  MaterialPage get pages => page;

  @override
  BaseAction? get sideEffect => throw UnimplementedError();
}

class PopRoute extends NavigationEvent {
  PopRoute({required super.target});

  @override
  MaterialPage get pages => throw UnimplementedError();

  @override
  BaseAction? get sideEffect => throw UnimplementedError();
}

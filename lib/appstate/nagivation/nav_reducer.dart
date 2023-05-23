import 'package:flutter/material.dart';
import 'package:p4h_mobile/appstate/nagivation/actions.dart';

List<MaterialPage> reducer(
  final NavigationAction action,
  final List<MaterialPage> state,
  final Target target,
) {
  if (action is PushPageRoute && target == action.target) {
    final nextMainStack = [...state, action.page];
    return nextMainStack;
  }

  return state;
}

class Target {
  final String _value;

  @override
  String get value => _value;

  const Target._string(this._value);
  Target._unknown(this._value);
  @override
  String get name => _value;

  static const Target mainStack = Target._string('mainStack');
  static const Target loggedIn = Target._string('loggedIn');
}

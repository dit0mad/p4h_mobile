import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:p4h_mobile/appstate/nav_bloc/nav_events.dart';

abstract class BaseAction {
  const BaseAction();
}

abstract class BaseActionSuccess extends BaseAction {
  const BaseActionSuccess();
}

class InitialAction extends BaseActionSuccess {
  const InitialAction();
}

class LoadingAction extends BaseAction {
  const LoadingAction();
}

class ActionSucess extends BaseAction {
  const ActionSucess();
}

class NavigateToLessenPlanScreen extends BaseAction {
  final Widget mp;
  final Target target;
  final int folderID;

  const NavigateToLessenPlanScreen({
    required this.mp,
    required this.target,
    required this.folderID,
  });
}

class NavigateToLessenPlanScreenSuccess extends BaseActionSuccess {
  const NavigateToLessenPlanScreenSuccess();
}

class GoToMyProgress extends BaseAction {}

class GoToMyProgress200 extends BaseAction {}

class InitConnectivity extends BaseAction {}

class UpdateConnectionState extends BaseAction {
  final ConnectivityResult result;

  const UpdateConnectionState({required this.result});
}

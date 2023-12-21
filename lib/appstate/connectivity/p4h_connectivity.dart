import 'dart:async';
import 'dart:developer' as developer;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:p4h_mobile/appstate/actions_bloc/action_bloc.dart';
import 'package:p4h_mobile/appstate/actions_bloc/actions.dart';

class P4HConnectivity {
  late ActionListenerBloc actionBloc;

  P4HConnectivity._privateConstructor();

  static final P4HConnectivity _instance =
      P4HConnectivity._privateConstructor();

  factory P4HConnectivity({required ActionListenerBloc actionBloc}) {
    return _instance..actionBloc = actionBloc;
  }

  final _connectivity = Connectivity();

  Future<ConnectivityResult> initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();

      _connectivity.onConnectivityChanged.listen((event) {
        actionBloc.add(UpdateConnectionState(
          result: event,
        ));
      });

      return result;
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return ConnectivityResult.none;
    }
  }
}

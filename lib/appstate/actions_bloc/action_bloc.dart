import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4h_mobile/appstate/actions_bloc/actions.dart';
import 'package:p4h_mobile/appstate/connectivity/p4h_connectivity.dart';
import 'package:p4h_mobile/appstate/nav_bloc/nav_bloc.dart';
import 'package:p4h_mobile/appstate/nav_bloc/nav_events.dart';
import 'package:p4h_mobile/appstate/user_bloc/user__state_bloc.dart';
import 'package:p4h_mobile/appstate/user_bloc/user_state_events.dart';
import 'package:p4h_mobile/models/resource.dart';
import 'package:p4h_mobile/screens/progress_screen.dart';
import 'package:p4h_mobile/services/http_service.dart';

import 'dart:developer' as developer;

//this class is implemented to purely listen for actions and perform side effects.
//specially in the case of routing or http service.
//the plan is to have a bloc to catch sideeffect actions or require something to happen before
//going to the next state;
//my prob was to download some resources and load state before navigation to a new page;
//bloc takes in a baseaction and emits failure or result<BaseAction>
//arguable almost all the bloc can be put here :/

class ActionListenerBloc extends Bloc<BaseAction, BaseAction> {
  final NavigationBloc bloc;
  final HttpRepo httpService;
  final UserStateBloc userStateBloc;

  ActionListenerBloc({
    required this.bloc,
    required this.userStateBloc,
  })  : httpService = userStateBloc.http,
        super(const InitialAction()) {
    on<UpdateConnectionState>((event, emit) {
      developer.log(event.result.name);
    });
    on<InitConnectivity>((event, emit) async {
      final result = await P4HConnectivity(actionBloc: this).initConnectivity();
    });
    on<GoToMyProgress>((event, emit) async {
      emit(const LoadingAction());

      bloc.add(const PushPageRoute(
        page: MaterialPage(
          name: 'progress:screen',
          child: ProgressScreen(),
        ),
        target: Target.mainStack,
      ));

      final nextState = userStateBloc.state as UserStateSuccess;
      final hasProgress = nextState.progress;

      if (hasProgress.isNotEmpty) {
        emit(const ActionSucess());
        return;
      }

      final result = await httpService.getProgress(nextState.userState.id);

      userStateBloc.add(
        GoToMyProgressSuccess(result: result),
      );

      emit(const ActionSucess());
    });
    on<NavigateToLessenPlanScreen>(
      (event, emit) async {
        userStateBloc.add(ClearUserResourceResponseError());

        final result = await httpService.gotoResourceFolder(event.folderID);

        if (result is UserResourceResponseFailure) {
          userStateBloc.add(AddError(errors: [result]));
        }

        if (result is ResourcesFolderIdResponse) {
          bloc.add(
            PushPageRoute(
                page: MaterialPage(
                  child: event.mp,
                ),
                target: event.target),
          );
          userStateBloc.add(SetResourceFolder(
            resourceFolderIdResponse: result,
          ));
        }

        emit(const NavigateToLessenPlanScreenSuccess());
      },
    );
  }
}

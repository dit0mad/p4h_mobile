import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4h_mobile/appstate/nav_bloc/nav_events.dart';
import 'package:p4h_mobile/screens/login_screen.dart';
import 'package:p4h_mobile/screens/resource_screens/lesson_plan_screen.dart';
import 'package:p4h_mobile/screens/resource_screens/resource_screen.dart';

const initStack = [
  MaterialPage(
    name: 'login',
    child: Material(
      child: LoginScreen(),
    ),
  ),
];

const resourceInit = [
  MaterialPage(
    name: 'resource',
    child: ResourceScreen(),
  ),
];

class NavigationBloc extends Bloc<NavigationEvent, MainStackState> {
  NavigationBloc()
      : super(
          const MainStackState(),
        ) {
    on<PopRoute>((event, emit) {
      final target = event.target;

      final nextState = navReducer(event, target, state);
      emit(nextState);
    });
    on<PushPageRoute>((event, emit) {
      final target = event.target;

      // final sideEffect = event.sideEffect;

      if (event.page is LessonPlanScreen) {
        print('yeah');
      }

      final nextState = navReducer(event, target, state);

      emit(nextState);
    });

    on<PopToRootPushPageRoute>((event, emit) {
      final target = event.target;

      final nextState = navReducer(event, target, state);

      emit(nextState);
    });
  }
}

class MainStackState {
  final List<MaterialPage> mainStack;
  final List<MaterialPage> resourceStack;

  const MainStackState({
    this.mainStack = initStack,
    this.resourceStack = resourceInit,
  });

  MainStackState copyWith({
    final List<MaterialPage>? mainStack,
    final List<MaterialPage>? resourceStack,
  }) =>
      MainStackState(
        mainStack: mainStack ?? this.mainStack,
        resourceStack: resourceStack ?? this.resourceStack,
      );
}

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material();
  }
}

MainStackState navReducer(
  final NavigationEvent event,
  final Target target,
  final MainStackState state,
) {
  if (target == Target.mainStack) {
    final nextStack = reduce(event, state.mainStack);

    final nextState = state.copyWith(
      mainStack: nextStack,
    );

    return nextState;
  }

  if (target == Target.resourceStack) {
    final nextStack = reduce(event, state.resourceStack);

    final nextState = state.copyWith(
      resourceStack: nextStack,
    );

    return nextState;
  }

  return state;
}

List<MaterialPage<dynamic>> reduce(
  final NavigationEvent event,
  final List<MaterialPage> stack,
) {
  if (event is PopRoute) {
    final next = stack.sublist(0, max(1, stack.length - 1));

    return next;
  }
  if (event is PopToRootPushPageRoute) {
    final next = [
      event.page,
    ];
    return next;
  }

  if (event is PushPageRoute) {
    final next = [
      ...stack,
      event.page,
    ];
    return next;
  }

  return stack;
}

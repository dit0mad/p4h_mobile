import 'package:flutter/material.dart';
import 'package:p4h_mobile/appstate/nagivation/actions.dart';
import 'package:p4h_mobile/appstate/nagivation/nav_reducer.dart';
import 'package:p4h_mobile/screens/login_screen.dart';

class NavigationStateProvider extends ChangeNotifier {
  //list of a stack with navs on it.
  //can be mnultiple list of stacks.

  //take list of route info and call method.

  List<MaterialPage> mainStack;
  List<MaterialPage> loggedIn;

  NavigationStateProvider({
    this.mainStack = const [...mainStackPages],
    this.loggedIn = const [],
  });

  NavigationStateProvider copyWith({
    final List<MaterialPage>? mainStack,
  }) {
    return NavigationStateProvider(
      mainStack: mainStack ?? this.mainStack,
    );
  }

  void pushPageRoute(MaterialPage page) {
    final action = PushPageRoute(target: Target.loggedIn, page: page);
    // final nextState = reducer(action, state, target)
    mainStack = [...mainStack, page];

    notifyListeners();
  }

  void pushReplacementRoute(MaterialPage page) {
    mainStack = [
      ...mainStack.sublist(1, mainStack.length - 1),
      page,
    ];

    notifyListeners();
  }
}

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

const mainStackPages = [
  MaterialPage(
      child: Material(
    child: EmptyPage(),
  )),
  MaterialPage(
    child: Material(
      child: LoginScreen(),
    ),
  ),
];

const loggedInPages = [
  MaterialPage(
      child: Material(
    child: EmptyPage(),
  )),
  MaterialPage(
    child: Material(
      child: LoginScreen(),
    ),
  ),
];

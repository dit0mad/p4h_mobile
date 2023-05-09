import 'package:flutter/material.dart';
import 'package:p4h_mobile/view/screens/login_screen.dart';

class NavgiationState extends ChangeNotifier {
  //list of a stack with navs on it.
  //can be mnultiple list of stacks.

  //take list of route info and call method.

  List<MaterialPage> mainStack;

  NavgiationState({
    this.mainStack = const [...pages],
  });

  NavgiationState copyWith({
    final List<MaterialPage>? mainStack,
  }) {
    return NavgiationState(
      mainStack: mainStack ?? this.mainStack,
    );
  }

  void pushPageRoute(MaterialPage page) {
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

const pages = [
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

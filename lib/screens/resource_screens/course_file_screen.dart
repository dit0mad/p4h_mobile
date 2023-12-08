import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4h_mobile/appstate/nav_bloc/nav_bloc.dart';
import 'package:p4h_mobile/appstate/nav_bloc/nav_events.dart';

abstract class ResourceScreenNavigator extends StatelessWidget {
  const ResourceScreenNavigator({
    super.key,
  });

  Widget get child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context
                .read<NavigationBloc>()
                .add(PopRoute(target: Target.resourceStack));
          },
        ),
      ),
      body: child,
    );
  }
}

class CourseFileScreen extends ResourceScreenNavigator {
  static const routeName = 'Lesson Plan Screen';
  const CourseFileScreen({
    super.key,
  });

  @override
  Widget get child => Material(
        child: PopScope(
          onPopInvoked: (didPop) async => false,
          child: Container(),
        ),
      );
}

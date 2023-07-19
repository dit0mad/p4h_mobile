import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p4h_mobile/appstate/nav_bloc/nav_bloc.dart';
import 'package:p4h_mobile/appstate/nav_bloc/nav_events.dart';
import 'package:p4h_mobile/appstate/user_bloc/user__state_bloc.dart';
import 'package:p4h_mobile/constants.dart';
import 'package:p4h_mobile/main.dart';
import 'package:p4h_mobile/screens/resource_screens/lesson_plan_screen.dart';
import 'package:p4h_mobile/screens/resource_screens/photo_screen.dart';
import 'package:p4h_mobile/screens/resource_screens/video_screen.dart';

import '../../widgets/build_card.dart';
import '../../widgets/text_field.dart';

const icons = [
  FontAwesomeIcons.book,
  FontAwesomeIcons.camera,
  FontAwesomeIcons.video
];

class ResourceScreenMediator extends StatelessWidget {
  const ResourceScreenMediator({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<NavigationBloc, MainStackState>(
      builder: (context, state) => Navigator(
        key: resourceNavigatorKey,
        onPopPage: (final Route<dynamic> route, final dynamic result) {
          return route.didPop(result);
        },
        pages: [
          ...state.resourceStack,
        ],
      ),
    );
  }
}

class ResourceScreen extends StatelessWidget {
  const ResourceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserStateBloc>();

    final navBloc = context.read<NavigationBloc>();

    final state = bloc.state as UserStateSuccess;

    final resources = state.user.resources;

    final theMap = Map.fromIterables(resources, icons);

    Widget page = Ink();

    void navigate(String name) {
      switch (name) {
        case 'notes':
          page = const LessonPlanScreen();

          break;
        case 'pictures':
          page = const PhotoScreen();
          break;
        case 'videos':
          page = const VideoScreen();
        default:
      }

      navBloc.add(PopToRootPushPageRoute(
        page: MaterialPage<StatelessWidget>(
          child: page,
        ),
        target: Target.resourceStack,
      ));
    }

    Widget one = Padding(
      padding: const EdgeInsets.only(top: 1),
      child: Column(
        children: [
          const CustomSearchField(
            hintText: 'Search Resous',
            fieldSize: 40,
          ),
          ...theMap.entries.map((e) => BuildCard(
                subTitleText: '${e.key.name} to help plan every day lessons',
                titleText: e.key.name,
                icon: e.value,
                onPressed: () {
                  navigate(e.key.name!);
                },
                iconColor: mainIconColor,
              )),
        ],
      ),
    );

    return BlocBuilder<UserStateBloc, UserState>(builder: (
      context,
      state,
    ) {
      if (state is UserStateSuccess) {
        return one;
      }
      return Ink();
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4h_mobile/appstate/actions_bloc/action_bloc.dart';
import 'package:p4h_mobile/appstate/actions_bloc/actions.dart';
import 'package:p4h_mobile/appstate/user_bloc/user__state_bloc.dart';
import 'package:p4h_mobile/constants.dart';
import 'package:p4h_mobile/services/http_service.dart';
import 'package:p4h_mobile/widgets/build_button.dart';

class ProfileHeader extends StatelessWidget {
  final UserStateSuccess state;
  const ProfileHeader({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: CircleAvatar(
              backgroundColor: Colors.greenAccent[400],
              radius: 40,
              backgroundImage: const NetworkImage(
                  'https://lh3.googleusercontent.com/a-/AAuE7mChgTiAe-N8ibcM3fB_qvGdl2vQ9jvjYv0iOOjB=s96-c'),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(state.userState.name, style: subtitle6),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Admin',
                style: subtitle7,
              ),
              Text(
                'I work for P4H Global',
                style: subtitle8,
              ),
            ],
          ),
          Column(
            children: [
              const SizedBox(
                height: 22,
              ),
              ButtonBuild(
                color: mainAppColor1,
                buttonText: 'pwogre mwen',
                onPress: () {
                  context.read<ActionListenerBloc>().add(GoToMyProgress());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

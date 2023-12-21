import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4h_mobile/appstate/actions_bloc/action_bloc.dart';
import 'package:p4h_mobile/appstate/actions_bloc/actions.dart';
import 'package:p4h_mobile/appstate/user_bloc/user__state_bloc.dart';
import 'package:p4h_mobile/constants.dart';
import 'package:p4h_mobile/widgets/build_button.dart';

class ProfileHeader extends StatelessWidget {
  final UserStateSuccess state;
  const ProfileHeader({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.read<UserStateBloc>().state as UserStateSuccess;

    Uint8List? decodedImg;

    final profilePic = state.userState.profilePic;

    if (profilePic != null) {
      decodedImg = base64.decode(state.userState.profilePic!);
    }

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
              backgroundImage: MemoryImage(decodedImg!),
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
                state.userState.bio ?? 'I work for P4H Global',
                style: subtitle8,
              ),
            ],
          ),
          const MyProgressWidget(),
        ],
      ),
    );
  }
}

class MyProgressWidget extends StatelessWidget {
  const MyProgressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

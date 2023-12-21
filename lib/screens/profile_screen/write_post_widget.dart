import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4h_mobile/appstate/nav_bloc/nav_bloc.dart';
import 'package:p4h_mobile/appstate/nav_bloc/nav_events.dart';
import 'package:p4h_mobile/appstate/user_bloc/user__state_bloc.dart';
import 'package:p4h_mobile/appstate/user_bloc/user_state_events.dart';
import 'package:p4h_mobile/constants.dart';

class UnstableNetworkModalPage extends Page {
  const UnstableNetworkModalPage() : super();

  @override
  Route createRoute(final BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Scaffold(
          body: Container(
            child: Text('hello'),
            color: Colors.red,
            height: 300,
            width: 400,
          ),
        );
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}

// class TicketNotFoundPage extends Page {
//   const TicketNotFoundPage({super.key});

//   @override
//   Route createRoute(final BuildContext context) {
//     return MaterialPageRoute(
//         settings: this,
//         builder: (
//           final BuildContext context,
//         ) {
//           return Ink(
//             child: Modal(
//               constraints: const BoxConstraints(
//                 maxHeight: 400,
//                 maxWidth: 380,
//               ),
//               barrierDismissible: true,
//               header: ModalHeader(
//                   dismissAction: PopRoute(target: Target.modalStack),
//                   title: const Text('Dismiss')),
//               body: const Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Spacer(),
//                   Flexible(
//                     child: Text('ticketNotFoundLabel'),
//                   ),
//                 ],
//               ),
//               buttonBar: ButtonBar(
//                   alignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         //@yasantha
//                         //  handler.cancelled(reduxHelpers);
//                       },
//                       child: const Text('cancelLabel'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         ;
//                       },
//                       child: const Text(''),
//                     ),
//                   ]),
//             ),
//           );
//         });
//   }
// }

class WritePostHereWidget extends StatefulWidget {
  const WritePostHereWidget({
    super.key,
  });

  @override
  State<WritePostHereWidget> createState() => _WritePostHereWidgetState();
}

class _WritePostHereWidgetState extends State<WritePostHereWidget> {
  late final TextEditingController postController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    postController.dispose();
  }

  void clearPost() {
    postController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<UserStateBloc>().state as UserStateSuccess;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: TextFormField(
              onTapOutside: ((event) {
                FocusScope.of(context).unfocus();
              }),
              controller: postController,
              decoration: InputDecoration(
                suffixIcon: InkWell(
                    onTap: () {
                      context.read<NavigationBloc>().add(const PushPageRoute(
                            page: UnstableNetworkModalPage(),
                            target: Target.modalStack,
                          ));
                    },
                    child: const Icon(Icons.upload)),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red, // Set your desired focus border color
                    width: 2.0, // Set your desired border width
                  ),
                ),
                hintText: 'Write Post Here',
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
          ),
          Flexible(
            flex: 0,
            child: TextButton(
              onPressed: () {
                clearPost();
                context.read<UserStateBloc>().add(
                      AddPost(
                        post: postController.text,
                        userID: state.userState.id,
                      ),
                    );
              },
              child: const Text(
                'POST',
                style: TextStyle(color: mainAppColor1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

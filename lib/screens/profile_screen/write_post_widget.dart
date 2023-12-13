import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4h_mobile/appstate/nav_bloc/nav_bloc.dart';
import 'package:p4h_mobile/appstate/nav_bloc/nav_events.dart';
import 'package:p4h_mobile/constants.dart';

class TicketNotFoundPage extends Page {
  const TicketNotFoundPage({super.key});

  @override
  Route createRoute(final BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (
          final BuildContext context,
        ) {
          return Ink(
            child: Modal(
              constraints: const BoxConstraints(
                maxHeight: 400,
                maxWidth: 380,
              ),
              barrierDismissible: true,
              header: ModalHeader(
                  dismissAction: PopRoute(target: Target.modalStack),
                  title: const Text('Dismiss')),
              body: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Flexible(
                    child: Text('ticketNotFoundLabel'),
                  ),
                ],
              ),
              buttonBar: ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        //@yasantha
                        //  handler.cancelled(reduxHelpers);
                      },
                      child: const Text('cancelLabel'),
                    ),
                    TextButton(
                      onPressed: () {
                        ;
                      },
                      child: const Text(''),
                    ),
                  ]),
            ),
          );
        });
  }
}

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

  @override
  Widget build(BuildContext context) {
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
                            page: TicketNotFoundPage(),
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
                postController.clear();
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

class ModalHeader extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final NavigationEvent? dismissAction;
  final VoidCallback? onCloseTapped;
  final Widget? backButton;

  const ModalHeader({
    Key? key,
    required this.title,
    this.dismissAction,
    this.onCloseTapped,
    this.backButton,
  })  : assert(!(dismissAction == null && onCloseTapped == null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final children = [
      if (backButton != null)
        Flexible(flex: 0, child: backButton!)
      else
        SizedBox(width: themeData.iconTheme.size ?? 24),
      Expanded(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: DefaultTextStyle(
            textAlign: TextAlign.center,
            style: themeData.textTheme.titleLarge!,
            child: title,
          ),
        ),
      ),
      CloseButton(
        color: themeData.colorScheme.primary,
        onPressed: onCloseTapped != null
            ? onCloseTapped!
            : () => (context.read<NavigationBloc>().add(
                  dismissAction!,
                )),
      ),
    ];

    return Ink(
      decoration: BoxDecoration(
        color: themeData.canvasColor,
        border: Border(
          bottom: BorderSide(color: themeData.dividerColor, width: 1.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: backButton != null
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: children,
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight / 2);
}

class Modal extends StatelessWidget {
  static const minWidth = 500.0;
  static const minHeight = 300.0;
  final ModalHeader header;
  final Widget body;
  final Widget? buttonBar;
  final bool extendBodyUnderBottom;
  final BoxConstraints? constraints;
  final bool barrierDismissible;
  final bool handleKeyboard;

  const Modal({
    Key? key,
    required this.header,
    required this.body,
    this.buttonBar,
    this.extendBodyUnderBottom = true,
    this.constraints,
    this.barrierDismissible = false,
    this.handleKeyboard = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final mqData = MediaQuery.of(context);

    return Padding(
      padding: handleKeyboard
          ? EdgeInsets.only(bottom: mqData.viewInsets.bottom)
          : EdgeInsets.zero,
      child: Stack(
        children: [
          if (barrierDismissible)
            ModalBarrier(onDismiss: header.onCloseTapped ?? () => ()),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints?.minWidth ?? minWidth,
                minHeight: constraints?.minWidth ?? minHeight,
                maxWidth: constraints?.maxWidth ?? double.infinity,
                maxHeight: constraints?.maxHeight ?? double.infinity,
              ),
              child: Material(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        flex: 0,
                        child:
                            Material(type: MaterialType.canvas, child: header)),
                    Flexible(flex: 1, child: body),
                    if (buttonBar != null)
                      Flexible(
                        flex: 0,
                        child: Material(
                          type: MaterialType.canvas,
                          color: themeData.colorScheme.surface,
                          child: Ink(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: themeData.dividerColor,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: buttonBar,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

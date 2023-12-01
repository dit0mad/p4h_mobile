import 'package:flutter/material.dart';
import 'package:p4h_mobile/constants.dart';

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
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red, // Set your desired focus border color
                    width: 2.0, // Set your desired border width
                  ),
                ),
                hintText: 'Write Post Here',
                border: OutlineInputBorder(
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

import 'package:flutter/material.dart';

class ButtonBuild extends StatelessWidget {
  final String buttonText;
  final Function onPress;
  final Color color;
  const ButtonBuild({
    super.key,
    required this.buttonText,
    required this.onPress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color),
        child: Text(
          buttonText,
        ),
        onPressed: () {
          onPress();
        });
  }
}

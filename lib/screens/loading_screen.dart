import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final String? text;

  static const optional = "Loading";

  const LoadingScreen({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text ?? optional,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const CircularProgressIndicator(),
      ],
    ));
  }
}

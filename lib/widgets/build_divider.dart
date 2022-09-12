import 'package:flutter/material.dart';

class BuildDivider extends StatelessWidget {
  const BuildDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Colors.grey,
      thickness: 2,
      height: 2,
    );
  }
}
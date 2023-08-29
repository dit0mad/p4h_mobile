import 'package:flutter/material.dart';

class BuildDivider extends StatelessWidget {
  const BuildDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 1,
      width: 350,
      child: Divider(
        color: Colors.grey,
        thickness: 1,
      ),
    );
  }
}

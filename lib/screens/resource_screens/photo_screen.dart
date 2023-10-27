import 'package:flutter/material.dart';
import 'package:p4h_mobile/widgets/sub_resource_screens.dart';

class PhotoScreen extends StatelessWidget {
  static const routeName = 'Photo Screen';
  const PhotoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: SubResourceScreens(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p4h_mobile/constants.dart';

class MyResources extends StatelessWidget {
  const MyResources({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: MwenFotoWidget(),
        ),
        Flexible(
          child: MwenDokimanWidget(),
        ),
      ],
    );
  }
}

abstract class MyResourcesBackground extends StatelessWidget {
  const MyResourcesBackground({super.key});

  EdgeInsets get paddingSizes;
  String get name;
  Icon get icon;
  Function get onTap;
  BorderRadiusGeometry get borderRadiusGeometry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: paddingSizes,
        decoration: BoxDecoration(
          color: searchBarColor,
          borderRadius: borderRadiusGeometry,
          border: Border.all(color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              icon,
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    name,
                    style: subtitle9,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MwenFotoWidget extends MyResourcesBackground {
  const MwenFotoWidget({super.key});

  static const String nameMwenFoto = 'Mwen Foto/Videyo';

  @override
  Icon get icon => const Icon(
        FontAwesomeIcons.camera,
        color: mainAppColor1,
        size: 40,
      );

  @override
  String get name => nameMwenFoto;

  @override
  EdgeInsets get paddingSizes => const EdgeInsets.only(left: 10, top: 5);

  @override
  Function get onTap => throw UnimplementedError();

  @override
  BorderRadiusGeometry get borderRadiusGeometry => const BorderRadius.only(
        topLeft: Radius.circular(5),
        bottomLeft: Radius.circular(5),
      );
}

class MwenDokimanWidget extends MyResourcesBackground {
  const MwenDokimanWidget({super.key});

  static const String mwenDokimanName = 'Mwen Dokiman';

  final iconMwenDokiman = const Icon(
    (Icons.contact_page),
    color: mainAppColor1,
    size: 43,
  );

  @override
  Icon get icon => iconMwenDokiman;

  @override
  String get name => mwenDokimanName;

  @override
  EdgeInsets get paddingSizes => const EdgeInsets.only(right: 10, top: 5);

  @override
  Function get onTap => throw UnimplementedError();

  @override
  BorderRadiusGeometry get borderRadiusGeometry => const BorderRadius.only(
        topRight: Radius.circular(5),
        bottomRight: Radius.circular(5),
      );
}

import 'package:flutter/material.dart';
import 'package:p4h_mobile/constants.dart';

class BuildCard extends StatelessWidget {
  final IconData icon;
  final String? titleText;
  final String? subTitleText;
  final Widget? trailingEnd;
  final VoidCallback onPressed;
  final Color? iconColor;
  final Color? fillColor;

  const BuildCard({
    Key? key,
    required this.icon,
    this.titleText,
    this.subTitleText,
    this.trailingEnd,
    required this.onPressed,
    this.iconColor,
    this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        margin: EdgeInsets.zero,
        color: fillColor != null ? mainFillColor : Colors.white,
        elevation: 0,
        child: ListTile(
          leading: Icon(
            icon,
            color: iconColor != null ? mainIconColor : subIconColor,
            size: 50,
          ),
          title: titleText != null
              ? Text(
                  titleText!,
                  style: subtitle1,
                )
              : const SizedBox(),
          subtitle: subTitleText != null
              ? Text(
                  subTitleText!,
                  style: subtitle3,
                )
              : const SizedBox(),
          trailing: trailingEnd != null ? trailingEnd! : const SizedBox(),
        ),
      ),
    );
  }
}

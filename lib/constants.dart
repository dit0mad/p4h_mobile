import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color mainAppColor = const Color(0XFFB82A2C);
Color mainIconColor = const Color(0XFFAE241A);
Color subIconColor = const Color(0XFF010101);
Color mainFillColor = const Color(0XFFE4E4E5);

TextStyle get headlineStyle1 {
  return const TextStyle(
    color: Color.fromARGB(255, 6, 50, 88),
    fontSize: 35,
    fontWeight: FontWeight.w800,
  );
}

TextStyle get headlineStyle2 {
  return const TextStyle(
    color: Color(0XFF22538F),
    fontSize: 35,
    fontWeight: FontWeight.w800,
    letterSpacing: 1,
  );
}

TextStyle get bodyText1 {
  return const TextStyle(
    color: Colors.black,
    fontSize: 26,
    fontWeight: FontWeight.w700,
  );
}

TextStyle get bodyText2 {
  return const TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
}

TextStyle get subtitle1 {
  return const TextStyle(
    color: Color(0XFF6E6E6E),
    fontSize: 18,
    fontWeight: FontWeight.w900,
  );
}

TextStyle get subtitle2 {
  return const TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );
}

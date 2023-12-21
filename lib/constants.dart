import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color mainAppColor1 = Color(0XFFB82A2C);
Color mainAppColor2 = const Color(0XFF183763);
Color mainIconColor = const Color(0XFFAE241A);
Color subIconColor = const Color(0XFF010101);
Color mainFillColor = const Color(0XFFE4E4E5);
Color searchBarColor = Colors.grey.shade300;

TextStyle get headlineStyle1 {
  return GoogleFonts.raleway(
    color: const Color(0XFF183763),
    fontSize: 50,
    fontWeight: FontWeight.bold,
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
  return GoogleFonts.roboto(
    color: Colors.black,
    fontSize: 26,
    fontWeight: FontWeight.w700,
  );
}

TextStyle get bodyText2 {
  return GoogleFonts.sourceSans3(
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

TextStyle get subtitle3 {
  return const TextStyle(
    color: Colors.grey,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
}

TextStyle get subtitle4 {
  return const TextStyle(
    color: Color(0XFF6E6E6E),
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );
}

TextStyle get subtitle5 {
  return const TextStyle(
    color: Color(0XFF6E6E6E),
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
}

TextStyle get subtitle6 {
  return GoogleFonts.raleway(
    color: mainAppColor2,
    fontSize: 18,
    fontWeight: FontWeight.w800,
  );
}

TextStyle get subtitle7 {
  return GoogleFonts.roboto(
    color: Colors.grey.shade600,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );
}

TextStyle get subtitle8 {
  return GoogleFonts.raleway(
    color: Colors.grey.shade900,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
}

TextStyle get subtitle9 {
  return GoogleFonts.raleway(
    color: Colors.grey.shade800,
    fontSize: 12,
    fontWeight: FontWeight.w800,
  );
}

TextStyle get buttonTitle {
  return GoogleFonts.lato(
    color: Colors.grey.shade300,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
}

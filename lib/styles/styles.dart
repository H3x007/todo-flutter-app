import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/controller/cubit.dart';

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    // ignore: prefer_const_constructors
    textStyle: TextStyle(
        fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.grey[400]),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    // ignore: prefer_const_constructors
    textStyle: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    // ignore: prefer_const_constructors
    textStyle: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
    // ignore: prefer_const_constructors
    textStyle: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: Colors.grey[600],
    ),
  );
}

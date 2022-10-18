import 'package:flutter/material.dart';

ThemeData lightTheme() => ThemeData(
      primarySwatch: Colors.blue,
      // ignore: prefer_const_constructors
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0.0,
        // ignore: prefer_const_constructors
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
    );

ThemeData darkTheme() => ThemeData(
      //primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Color(0xFF121212),
      brightness: Brightness.dark,
      // ignore: prefer_const_constructors
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF121212),
        elevation: 0.0,
        // ignore: prefer_const_constructors
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      hintColor: Colors.white,
    );

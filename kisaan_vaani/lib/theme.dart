import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.orange.shade700,
    secondary: Colors.black,
  )

);


ThemeData darkmode = ThemeData(
  brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Colors.black26,
      primary: Colors.orange.shade900,
      secondary: Colors.white,
    )

);
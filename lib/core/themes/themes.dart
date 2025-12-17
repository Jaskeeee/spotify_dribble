import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark()
);
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  iconTheme: IconThemeData(
    color: Colors.white,
    size:35
  ),
  textTheme: TextTheme(
    titleSmall: TextStyle()
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.white,
    secondary: Colors.grey.shade400,
    tertiary: Colors.grey.shade600
  )
);

final WindowButtonColors buttonColors = WindowButtonColors(
  iconNormal: Colors.white,
  mouseOver: Colors.white24,
  mouseDown: Colors.white30,
  iconMouseOver: Colors.white,
  iconMouseDown: Colors.white,
);
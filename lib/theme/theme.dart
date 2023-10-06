import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        background: Color(0xFFF4EBDF),
        primary: Color(0XFF3A5D3D),
        secondary: Color(0xFFFFA500),
        tertiary: Color(0xFF333333)));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: Color(0xFF2F4F4F),
        primary: Color(0xFF556B2F),
        secondary: Color(0xFFD2691E),
        tertiary: Color(0xFFCCCCCC)));

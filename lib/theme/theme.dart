// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        background: Color(0xFFF5F5F5),
        primary: Color(0xFF3B7A8C),
        secondary: Color(0xFFe74c3c),
        tertiary: Color(0xFF2c3e50)));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: Color(0xFF2c3e50),
        primary: Color(0xFF3498db),
        secondary: Color(0xFFe74c3c),
        tertiary: Color(0xFFecf0f1)));

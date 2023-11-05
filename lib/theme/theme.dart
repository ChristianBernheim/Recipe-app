// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        background: Color(0xFFF5F5F5),
        primary: Color(0xFF89A054),
        secondary: Color.fromARGB(255, 73, 86, 46),
        tertiary: Color.fromARGB(255, 26, 38, 21)));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: Color(0xFF333333),
        primary: Color(0xFF89A054),
        secondary: Color.fromARGB(255, 73, 86, 46),
        //primary: Color(0xFF3498db),
        //secondary: Color(0xFF9176FF)
        //secondary: Color.fromARGB(255, 91, 76, 255),
        tertiary: Color(0xFFecf0f1)));

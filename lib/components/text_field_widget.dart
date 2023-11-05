// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  TextFieldWidget({
    super.key,
    required this.labelText,
    this.obscureText,
    this.keyboardType,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType ?? TextInputType.text,
      style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
      cursorColor: Theme.of(context).colorScheme.tertiary,
      decoration: InputDecoration(
          filled: true,
          fillColor: Color(0x20FFFFFF),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.tertiary,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.secondary)),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
          )),
    );
  }
}

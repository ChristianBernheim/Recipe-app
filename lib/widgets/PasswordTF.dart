// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      style: TextStyle(
        color: Theme.of(context).colorScheme.tertiary,
      ),
      cursorColor: Theme.of(context).colorScheme.tertiary,
      decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFFFFFFF),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.tertiary)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
              )),
          labelText: "Password",
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
          )),
    );
  }
}

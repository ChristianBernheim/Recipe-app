// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
      cursorColor: Theme.of(context).colorScheme.tertiary,
      decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFFFFFFF),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.tertiary,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.secondary)),
          labelText: "Email",
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
          )),
    );
  }
}

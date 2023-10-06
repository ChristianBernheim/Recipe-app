// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/EmailTF.dart';
import 'package:recipe_app/widgets/PasswordTF.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Center(
                  child: Text(
                style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 35),
                "Sign up",
              )),
              EmailTextField(),
              SizedBox(
                height: 25,
              ),
              PasswordTextField(),
            ],
          ),
        ),
      ),
    );
  }
}

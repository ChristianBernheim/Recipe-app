// ignore_for_file: prefer_const_constructors, duplicate_ignore, file_names

import 'package:flutter/material.dart';
import 'package:recipe_app/screen/Register.dart';
import 'package:recipe_app/widgets/EmailTF.dart';
import 'package:recipe_app/widgets/PasswordTF.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ignore: prefer_const_constructors
                Center(
                    child: Text("Log in",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 35))),
                EmailTextField(),
                SizedBox(height: 20),
                PasswordTextField(),
                TextButton(
                    onPressed: () {},
                    child: Text('Forgot your password?',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 10))),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  },
                  child: Text('Login'),
                ),
                SizedBox(
                  height: 30,
                ),
                Text("You can also sign in with",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 15)),

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 70,
                        color: Theme.of(context).colorScheme.tertiary,
                        icon: Icon(
                          Icons.facebook_rounded,
                        ),
                        onPressed: () {
                          // Add your onPressed action here
                        },
                      ),
                      IconButton(
                        iconSize: 70,
                        color: Theme.of(context).colorScheme.tertiary,
                        icon: Icon(Icons.circle),
                        onPressed: () {
                          // Add your onPressed action here
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

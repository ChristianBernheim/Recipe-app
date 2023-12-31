import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/screen/main_logged_in_screen.dart';
import 'package:recipe_app/auth/welcome_screen.dart';

class Auth extends StatelessWidget {
  Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MainLoggedInScreen();
        } else {
          return WelcomeScreen();
        }
      },
    ));
  }
}

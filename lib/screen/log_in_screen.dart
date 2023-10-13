// ignore_for_file: prefer_const_constructors, duplicate_ignore, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/auth/main_page.dart';
import 'package:recipe_app/model/user.dart';
import 'package:recipe_app/services/auth_service.dart';
import 'package:recipe_app/services/firestore.dart';
import 'package:recipe_app/widgets/square_Tile.dart';
import 'package:recipe_app/widgets/text_field_widget.dart';
import 'package:recipe_app/widgets/title_tile.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future SignIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: prefer_const_constructors
              Center(child: TitleTile(title: "Log in")),
              TextFieldWidget(
                labelText: "Email",
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              SizedBox(height: 20),
              TextFieldWidget(
                labelText: "Password",
                obscureText: true,
                controller: _passwordController,
              ),
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
                  SignIn();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );
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

              Wrap(
                children: [
                  SquareTile(
                      imagePath: 'lib/image/google.png',
                      onTap: () => AuthService().signInWithGoogle()),
                  SizedBox(
                    width: 20,
                  ),
                  SquareTile(imagePath: 'lib/image/facebook.png', onTap: () {}),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

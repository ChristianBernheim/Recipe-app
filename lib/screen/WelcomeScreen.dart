// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:recipe_app/screen/LogIn.dart';
import 'package:recipe_app/screen/Register.dart';
import 'package:recipe_app/theme/theme_provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/image/Background.png"),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Welcome to Family Feast",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  Text(
                    "With Family Feast, you're not just discovering recipes, you're creating a legacy of flavors. Our unique rating system allows you and your loved ones to share your thoughts on each dish, turning every meal into a collective culinary adventure.",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text("Already have an account?",
                      style: TextStyle(color: Colors.white)),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme();
                    },
                    child: Text('Log in'),
                  ),
                  Text("You don't have a account?",
                      style: TextStyle(color: Colors.white)),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()),
                      );
                    },
                    child: Text('Register Account'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

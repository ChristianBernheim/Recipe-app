// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/material.dart';
import 'package:recipe_app/screen/sign%20up%20and%20in%20screen/log_in_screen.dart';
import 'package:recipe_app/screen/sign%20up%20and%20in%20screen/register_screen.dart';
import 'package:recipe_app/components/title_tile.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary
                  ]),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('lib/image/meal_mastermind_logo.png'),
                  Container(
                    padding: EdgeInsets.only(
                      top: 5,
                      left: 25,
                      right: 25,
                    ),
                    child: Column(
                      children: [
                        TitleTile(title: "Welcome to MealMastermind!"),
                        Center(
                          child: Text(
                            "Discover and collect recipes with your family, and even add your own! Easily create weekly food lists and get your grocery list automatically. Say goodbye to meal planning stress and hello to more free time!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text("Already have an account?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.tertiary),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogInScreen()),
                      );
                    },
                    child: Text('Log in'),
                  ),
                  Text("You don't have a account?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.tertiary),
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

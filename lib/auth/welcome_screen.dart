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
                  SizedBox(
                    height: 50,
                  ),
                  TitleTile(title: "Welcome to MealMastermind!"),
                  //Change to a RichText and fix the wat it looks
                  Text(
                    "Simplify your meal planning with our intuitive app. Discover new recipes, create weekly menus, and share your culinary adventures with your family. Say goodbye to mealtime stress and hello to delicious simplicity."
                    "Key Features:"
                    "Recipe Discovery: Explore a vast library of mouthwatering dishes from around the world."
                    "Customizable Menus: Plan your meals for the entire week in just a few clicks."
                    "Family Ratings: Get feedback from your loved ones and fine-tune your menu for everyone's taste."
                    "Grocery List Integration: Automatically generate shopping lists based on your chosen recipes."
                    "Start your culinary journey today with MealMastermind!",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text("Already have an account?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary),
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
                        backgroundColor: Theme.of(context).colorScheme.primary),
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

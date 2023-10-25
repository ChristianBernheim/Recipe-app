import 'package:flutter/material.dart';
import 'package:recipe_app/components/recipe_tile.dart';

class WeeklyFoodListScreen extends StatelessWidget {
  const WeeklyFoodListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
          child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Card(
            child: Column(
              children: [Text("Monday"), RecipeCard(title: "Korvstroganoff")],
            ),
          ),
          Card(
            child: Column(
              children: [
                Text("Thuesday"),
                RecipeCard(title: "Spagetti och köttfärssås")
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                Text("Wednesday"),
                RecipeCard(title: "Torsk, stuvadspent och potatis")
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                Text("Thursday"),
                RecipeCard(title: "Soppa och pannkakor")
              ],
            ),
          ),
          Card(
            child: Column(
              children: [Text("Friday"), RecipeCard(title: "Tacos")],
            ),
          ),
          Card(
            child: Column(
              children: [
                Text("Saturday"),
                RecipeCard(title: "Oxfilé, bea och pommes frites")
              ],
            ),
          ),
          Card(
            child: Column(
              children: [Text("Sunday"), RecipeCard(title: "Köttgryta")],
            ),
          )
        ],
      )),
    );
  }
}

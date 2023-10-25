// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:recipe_app/components/ingredient.dart';
import 'package:recipe_app/components/title_tile.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Image.asset(
                  "lib/image/food.jpg",
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(height: 10),
              TitleTile(title: "Recipe"),
              Divider(
                thickness: 3,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Text("Ingredients:",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 16)),
              Column(
                children: [
                  IngredientWidget(
                      title: "Mjöl", amount: 4, measurementUnit: " dl"),
                  IngredientWidget(
                      title: "Mjölk", amount: 100, measurementUnit: " dl"),
                  IngredientWidget(
                      title: "Socker", amount: 3, measurementUnit: " msk"),
                  IngredientWidget(
                      title: "Ägg", amount: 3, measurementUnit: " st"),
                  IngredientWidget(
                      title: "Smör", amount: 50, measurementUnit: " g"),
                ],
              ),
              Divider(
                thickness: 3,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Text("How to",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 16)),
              //Change Sort of Text widget here??
              Text(
                "Vispa ut mjölet i hälften av mjölken till en slät smet. Vispa i resterande mjölk, "
                "ägg och salt. Låt smeten svälla ca 10 min. Smält smör i en stekpanna och häll ner i smeten. Grädda tunna pannkakor.",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:recipe_app/components/ingredient_tile.dart';
import 'package:recipe_app/components/title_tile.dart';
import 'package:recipe_app/model/recipe.dart';
import 'package:recipe_app/model/ingredient_amount.dart';
import 'package:recipe_app/services/firestore_service.dart';

class RecipeScreen extends StatelessWidget {
  final String recipeId;
  final db = FireStoreService();
  RecipeScreen(this.recipeId);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RecipeModel>(
      stream: db.getRecipe(recipeId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Text('No data available');
        } else {
          RecipeModel recipe = snapshot.data!;
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    child: recipe.foodPicture != null
                        ? Image.network(
                            recipe.foodPicture!,
                            fit: BoxFit.fitWidth,
                          )
                        : Icon(
                            Icons.fastfood,
                            color: Theme.of(context).colorScheme.tertiary,
                            size: MediaQuery.of(context).size.height / 3,
                          ),
                  ),
                  SizedBox(height: 10),
                  TitleTile(title: recipe.title),
                  Text("Time to make: ${recipe.cookTime} min"),
                  Divider(
                    thickness: 1,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  Text(
                    "Ingredients:",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemCount: recipe.ingredients.length,
                        itemBuilder: (BuildContext context, int index) {
                          IngredientAmountModel ingredient =
                              recipe.ingredients[index];
                          return IngredientWidget(
                            title: ingredient.ingredientId,
                            amount: ingredient.amount,
                            measurementUnit: ingredient.unit,
                          );
                        },
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  Text(
                    "Method",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemCount: recipe.howToMethodList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Text(
                              "${index + 1}. ${recipe.howToMethodList[index]}");
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

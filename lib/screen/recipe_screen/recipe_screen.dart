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
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Container(
                        child: ListView.builder(
                      itemCount: recipe.ingredients.length,
                      itemBuilder: (BuildContext context, int index) {
                        IngredientAmountModel ingredient =
                            recipe.ingredients[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            left: 25,
                            right: 25,
                          ),
                          child: Container(
                            color: Theme.of(context)
                                .colorScheme
                                .tertiary
                                .withOpacity(0.1),
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                              left: 25,
                              right: 25,
                              bottom: 3,
                              top: 3,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    ingredient.ingredientId,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        "${ingredient.amount}",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${ingredient.unit}",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
                  ),
                  Divider(
                    thickness: 1,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  Text(
                    "Method",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(25),
                      child: ListView.builder(
                        itemCount: recipe.howToMethodList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 7),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1),
                              ),
                              child: Text(
                                  "${index + 1}. ${recipe.howToMethodList[index]}"),

                              //Add timer would be nice!
                            ),
                          );
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

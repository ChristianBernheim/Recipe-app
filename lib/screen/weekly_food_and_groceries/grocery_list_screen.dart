import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:recipe_app/components/grocery_tile.dart';
import 'package:recipe_app/components/ingredient_tile.dart';
import 'package:recipe_app/components/title_tile.dart';
import 'package:recipe_app/model/family.dart';
import 'package:recipe_app/model/ingredient_amount.dart';
import 'package:recipe_app/model/recipe.dart';
import 'package:recipe_app/model/user.dart';
import 'package:recipe_app/model/weekly_list.dart';
import 'package:recipe_app/screen/weekly_food_and_groceries/basic_goods_screen.dart';
import 'package:recipe_app/services/firestore_service.dart';

class GroceryListScreen extends StatefulWidget {
  GroceryListScreen({super.key});

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  User? authUser = FirebaseAuth.instance.currentUser;
  FireStoreService db = FireStoreService();
  List<IngredientAmountModel> ingredientsList = [];

  // void groceryPickedUp(bool? value, int index) {
  //   setState(() {
  //     ingredientsList[index][0] = !ingredientsList[index][0];
  //   });
  // }

  void addGroceriesToList() {
    showDialog(
        context: context,
        builder: (context) {
          return BasicGoodScreen();
        });
  }

  @override
  Widget build(BuildContext context) {
    int weeksBetween(DateTime from, DateTime to) {
      from = DateTime.utc(from.year, from.month, from.day);
      to = DateTime.utc(to.year, to.month, to.day);
      return (to.difference(from).inDays / 7).ceil();
    }

    DateTime now = DateTime.now();
    final firstJan = DateTime(now.year, 1, 1);
    final weekNumber = weeksBetween(firstJan, now);
    final weekString = weekNumber.toString();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: addGroceriesToList,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: IconTheme(
            data: new IconThemeData(
                color: Theme.of(context).colorScheme.background),
            child: new Icon(Icons.add)),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleTile(title: "Groceries"),
            StreamBuilder(
                stream: db.getUserStream(authUser!.email),
                builder: (context, userSnapshot) {
                  if (userSnapshot.hasError) {
                    print("Usersnapshot has error: $userSnapshot");
                    return Text("User:An error has occured");
                  } else if (userSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    UserModel user = userSnapshot.data!;
                    return StreamBuilder(
                        stream: db.getFamilyStream(user.familyId),
                        builder: (context, familySnapshot) {
                          if (familySnapshot.hasError) {
                            print("FamilySnapshot has error: $familySnapshot");
                            return const Text("Family: An error has occured");
                          } else if (familySnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            FamilyModel family = familySnapshot.data!;
                            return StreamBuilder(
                                stream:
                                    db.getWeeklyList(weekString, family.id!),
                                builder: (context, weeklyListSnapshot) {
                                  if (weeklyListSnapshot.hasError) {
                                    print(
                                        "WeeklyListSnapshot has error: $weeklyListSnapshot");
                                    return const Text(
                                        "WeeklyList:An error has occured");
                                  } else if (weeklyListSnapshot
                                          .connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    WeeklyListModel weeklyList =
                                        weeklyListSnapshot.data!;
                                    return StreamBuilder(
                                        stream: db.getCertainRecipesStream(
                                            weeklyList.recipesID!),
                                        builder: (context, recipeSnapshot) {
                                          if (recipeSnapshot.hasError) {
                                            print(
                                                "RecipeSnapshot has error: $recipeSnapshot");
                                            return const Text(
                                                "Recipe:An error has occured");
                                          } else if (recipeSnapshot
                                                  .connectionState ==
                                              ConnectionState.waiting) {
                                            return Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              alignment: Alignment.center,
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          } else {
                                            List<RecipeModel> recipes =
                                                recipeSnapshot.data!;

                                            for (var recipe in recipes) {
                                              for (var ingredient
                                                  in recipe.ingredients) {
                                                ingredientsList.add(ingredient);
                                              }
                                            }

                                            return Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  300,
                                              padding: EdgeInsets.all(25),
                                              child: Center(
                                                child: SizedBox(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: ListView.builder(
                                                      itemCount: ingredientsList
                                                          .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return GestureDetector(
                                                          onTap: () {},
                                                          child: Text(
                                                              ingredientsList[
                                                                      index]
                                                                  .ingredientId),
                                                        );
                                                      }),
                                                ),
                                              ),
                                            );
                                          }
                                        });
                                  }
                                });
                          }
                        });
                  }
                })
          ],
        ),
      ),
    );
  }
}

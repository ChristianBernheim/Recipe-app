import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  List<bool> pickedUpStatusList = [];
  bool groceryPickedUp = false;

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
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleTile(title: "Groceries"),
            StreamBuilder(
                stream: db.getUserStream(authUser!.email),
                builder: (context, userSnapshot) {
                  if (userSnapshot.hasError) {
                    print("Usersnapshot has error: $userSnapshot");
                    return Text("User: An error has occurred");
                  } else if (userSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 400,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    UserModel user = userSnapshot.data!;
                    if (user.familyId != null && user.familyId != "") {
                      return StreamBuilder(
                          stream: db.getFamilyStream(user.familyId),
                          builder: (context, familySnapshot) {
                            if (familySnapshot.hasError) {
                              print(
                                  "FamilySnapshot has error: $familySnapshot");
                              return const Text(
                                  "Family: An error has occurred");
                            } else if (familySnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height - 400,
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              FamilyModel? family = familySnapshot.data;
                              if (family == null) {
                                return Text(
                                    "You don't have a family. Go and create or join one.");
                              }
                              if (family.weeklyList != null &&
                                  family.weeklyList != "") {
                                return StreamBuilder(
                                    stream: db.getWeeklyList(
                                        weekString, family.id!),
                                    builder: (context, weeklyListSnapshot) {
                                      if (weeklyListSnapshot.hasError) {
                                        print(
                                            "WeeklyListSnapshot has error: $weeklyListSnapshot");
                                        return const Text(
                                            "WeeklyList: An error has occurred");
                                      } else if (weeklyListSnapshot
                                              .connectionState ==
                                          ConnectionState.waiting) {
                                        return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              400,
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(),
                                        );
                                      } else {
                                        WeeklyListModel? weeklyList =
                                            weeklyListSnapshot.data;
                                        if (weeklyList == null) {
                                          return Text(
                                              "You don't have a weekly list. Go and add one.");
                                        }
                                        return StreamBuilder(
                                            stream: db.getCertainRecipesStream(
                                                weeklyList.recipesID!),
                                            builder: (context, recipeSnapshot) {
                                              if (recipeSnapshot.hasError) {
                                                print(
                                                    "RecipeSnapshot has error: $recipeSnapshot");
                                                return const Text(
                                                    "Recipe: An error has occurred");
                                              } else if (recipeSnapshot
                                                      .connectionState ==
                                                  ConnectionState.waiting) {
                                                return Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height -
                                                      400,
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
                                                    bool isIngredientInList =
                                                        ingredientsList.any((item) =>
                                                            item.ingredientId ==
                                                            ingredient
                                                                .ingredientId);
                                                    if (!isIngredientInList) {
                                                      ingredientsList
                                                          .add(ingredient);
                                                      pickedUpStatusList
                                                          .add(groceryPickedUp);
                                                    }
                                                  }
                                                }

                                                ingredientsList.sort(
                                                  (a, b) => a.ingredientId
                                                      .compareTo(
                                                          b.ingredientId),
                                                );

                                                return Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height -
                                                      400,
                                                  padding: EdgeInsets.all(25),
                                                  child: SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height -
                                                            400,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: ListView.builder(
                                                        itemCount:
                                                            ingredientsList
                                                                .length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  pickedUpStatusList[
                                                                          index] =
                                                                      !pickedUpStatusList[
                                                                          index];
                                                                });
                                                              },
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 3,
                                                                        bottom:
                                                                            3),
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  top: 5,
                                                                  bottom: 5,
                                                                ),
                                                                color: pickedUpStatusList[
                                                                            index] !=
                                                                        false
                                                                    ? Colors
                                                                        .green
                                                                    : Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .tertiary
                                                                        .withOpacity(
                                                                            0.2),
                                                                child: Text(
                                                                  ingredientsList[
                                                                          index]
                                                                      .ingredientId,
                                                                  style:
                                                                      TextStyle(
                                                                    decoration: pickedUpStatusList[index] !=
                                                                            false
                                                                        ? TextDecoration
                                                                            .lineThrough
                                                                        : TextDecoration
                                                                            .none,
                                                                  ),
                                                                ),
                                                              ));
                                                        }),
                                                  ),
                                                );
                                              }
                                            });
                                      }
                                    });
                              } else {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height - 400,
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "You need to create a weekly list first.",
                                        textAlign: TextAlign.center,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Add logic to create a weekly list here
                                        },
                                        child: Text("Create a Weekly List"),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          });
                    } else {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 400,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "You need to create a family to have a grocery list.",
                              textAlign: TextAlign.center,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Add logic to create a family here
                              },
                              child: Text("Create a Family"),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                })
          ],
        ),
      ),
    );
  }
}

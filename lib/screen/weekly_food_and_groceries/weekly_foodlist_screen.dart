import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/components/title_tile.dart';
import 'package:recipe_app/components/weekly_food_tile.dart';
import 'package:recipe_app/model/recipe.dart';

import 'package:recipe_app/model/user.dart';
import 'package:recipe_app/screen/recipe_screen/recipe_screen.dart';
import 'package:recipe_app/screen/weekly_food_and_groceries/create_weekly_list_screen.dart';
import 'package:recipe_app/services/firestore_service.dart';

class WeeklyFoodListScreen extends StatelessWidget {
  WeeklyFoodListScreen({Key? key}) : super(key: key);

  final currentUser = FirebaseAuth.instance.currentUser;
  final db = FireStoreService();

  List<String> weekdayNames = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int currentDay = now.weekday;
    double initialScrollOffset = (currentDay - 1) * 200.0;

    ScrollController _scrollController =
        ScrollController(initialScrollOffset: initialScrollOffset);

    int weeksBetween(DateTime from, DateTime to) {
      from = DateTime.utc(from.year, from.month, from.day);
      to = DateTime.utc(to.year, to.month, to.day);
      return (to.difference(from).inDays / 7).ceil();
    }

    final firstJan = DateTime(now.year, 1, 1);
    final weekNumber = weeksBetween(firstJan, now);
    final weekString = weekNumber.toString();

    void createWeeklyFoodList(String week, String? familyId) {
      showDialog(
          context: context,
          builder: (context) {
            return CreateWeeklyList(week: week, familyId: familyId!);
          });
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        child: StreamBuilder<UserModel>(
          stream: db.getUserStream(currentUser!.email),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final user = snapshot.data!;
              if (user.familyId != null && user.familyId != "") {
                return StreamBuilder(
                  stream: db.getFamilyStream(user.familyId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final family = snapshot.data!;
                      if (family.weeklyList != null &&
                          family.weeklyList!.isNotEmpty) {
                        return StreamBuilder(
                            stream: db.getWeeklyList(weekString, family.id!),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final weeklyList = snapshot.data!;
                                return StreamBuilder<List<RecipeModel>>(
                                    stream: db.getCertainRecipesStream(
                                        weeklyList.recipesID!),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        print(
                                            "Error fetching recipes: ${snapshot.error}");
                                        return Text('Error: ${snapshot.error}');
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (snapshot.hasData) {
                                        var testrecipies = snapshot.data;
                                        print("test $testrecipies");
                                        return Scaffold(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .background,
                                          body: Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                child: TitleTile(
                                                  title: "Week $weekNumber",
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(25),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height -
                                                    140,
                                                child: ListView.builder(
                                                  controller: _scrollController,
                                                  itemCount:
                                                      snapshot.data!.length,
                                                  itemBuilder:
                                                      ((context, index) {
                                                    final weekRecipes =
                                                        snapshot.data!;
                                                    print(
                                                        "weekrecipies : $weekRecipes");
                                                    return Container(
                                                      decoration: currentDay ==
                                                              index + 1
                                                          ? BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary,
                                                                width: 2,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            )
                                                          : null,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      RecipeScreen(
                                                                          weekRecipes[index]
                                                                              .id!)));
                                                        },
                                                        child:
                                                            WeeklyFoodListTile(
                                                          weekday: weekdayNames[
                                                              index],
                                                          title:
                                                              weekRecipes[index]
                                                                  .title,
                                                          foodPicture:
                                                              weekRecipes[index]
                                                                  .foodPicture,
                                                          cookTime:
                                                              weekRecipes[index]
                                                                  .cookTime!,
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        print(
                                            "getWeeklyList1: ${snapshot.error}");
                                        return Text(
                                            "Opss... Something went wrong");
                                      } else {
                                        return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                          ),
                                        );
                                      }
                                    });
                              } else if (snapshot.hasError) {
                                print("getWeeklyList2: ${snapshot.error}");
                                return Text("Opss... Something went wrong");
                              } else {
                                return CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.tertiary,
                                );
                              }
                            });
                      } else {
                        return Scaffold(
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                          body: Container(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 2),
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              children: [
                                Text("You got no weekly list"),
                                ElevatedButton(
                                    onPressed: () {
                                      createWeeklyFoodList(
                                          weekString, family.id!);
                                    },
                                    child: Text("Create a list"))
                              ],
                            ),
                          ),
                        );
                      }
                    }
                    return CircularProgressIndicator();
                  },
                );
              } else {
                return Scaffold(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "You need to create a family to have a weekly List."),
                        ElevatedButton(
                          onPressed: () {
                            // Add the logic to create a family here
                          },
                          child: Text("Create a Family"),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

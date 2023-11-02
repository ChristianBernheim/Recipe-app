import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/components/title_tile.dart';
import 'package:recipe_app/model/family.dart';
import 'package:recipe_app/model/recipe.dart';
import 'package:recipe_app/model/weekly_list.dart';
import 'package:recipe_app/services/firestore_service.dart';

class CreateWeeklyList extends StatelessWidget {
  String week;
  String familyId;

  CreateWeeklyList({required this.week, required this.familyId, super.key});
  FireStoreService db = FireStoreService();
  List<RecipeModel> selectRandomRecipes(List<RecipeModel> recipes,
      {required int count}) {
    recipes.shuffle();
    return recipes.take(count).toList();
  }

  Future<void> createWeeklyListRandomFromAll(
      String week, String familyId) async {
    List<RecipeModel> allRecipes = [];
    allRecipes = await db.getAllRecipeFuture();

    // Randomly select a few recipes
    List<RecipeModel> selectedRecipes =
        selectRandomRecipes(allRecipes, count: 7);
    List<dynamic> recipeIds = [];
    for (var recipe in selectedRecipes) {
      recipeIds.add(recipe.id);
    }

    String weeklyListId = await db.createWeeklyList(
        WeeklyListModel(familyId: familyId, week: week, recipesID: recipeIds));

    FamilyModel family = await db.getFamilyStream(familyId).first;
    if (family.weeklyList == null) {
      family.weeklyList = [weeklyListId];
    } else {
      family.weeklyList!.add(weeklyListId);
    }

    // Update the family in Firestore
    await db.updateFamily(family);
  }

  createWeeklyListRandomFromFavorite(String week, String familyId) {}
  createWeeklyListManuallyFromAll(String week, String familyId) {}
  createWeeklyListManuallyFromFavorite(String week, String familyId) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            TitleTile(title: "Create weekly list"),
            Text("How do you want to create your weekly list?"),
            ElevatedButton(
                onPressed: () async {
                  createWeeklyListRandomFromAll(week, familyId);
                  Navigator.pop(context);
                },
                child: Text("Create random from all recipes")),
            ElevatedButton(
                onPressed: () {
                  createWeeklyListRandomFromFavorite(week, familyId);
                },
                child: Text("Create random from family favorite recipes")),
            ElevatedButton(
                onPressed: () {
                  createWeeklyListManuallyFromAll(week, familyId);
                },
                child: Text("Create manually from all recipes")),
            ElevatedButton(
                onPressed: () {
                  createWeeklyListRandomFromFavorite(week, familyId);
                },
                child: Text("Create manually from family favorite recipes")),
          ],
        ),
      ),
    );
  }
}

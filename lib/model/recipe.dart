import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/model/ingredient_amount.dart';
//Kunna ha kategorier delvis om det är vegenskt etc, eller allergier, eller om det är veckomat eller helgmat.

class RecipeModel {
  final String? id;
  String title;
  String userId;
  String? cookTime;
  List<IngredientAmountModel> ingredients;
  List<String> howToMethodList;
  String? foodPicture;

  RecipeModel({
    this.id,
    required this.userId,
    required this.title,
    this.cookTime,
    required this.ingredients,
    required this.howToMethodList,
    this.foodPicture,
  });

  Map<String, dynamic> toJson() {
    return {
      "Title": title,
      "UserId": userId,
      "CookTime": cookTime,
      "Ingredients": ingredients.map((e) => e.toJson()).toList(),
      "HowToMethodList": howToMethodList,
      "FoodPicture": foodPicture,
    };
  }

  factory RecipeModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return RecipeModel(
      id: document.id,
      userId: data["UserId"],
      title: data["Title"],
      cookTime: data["CookTime"] ?? "unknown",
      ingredients: (data["Ingredients"] as List<dynamic>)
          .map((e) => IngredientAmountModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      howToMethodList: data["HowToMethodList"] != null
          ? List<String>.from(data["HowToMethodList"])
          : [],
      foodPicture: data["FoodPicture"] ??
          "https://images.unsplash.com/photo-1517953720815-3ad3488a67f1?auto=format&fit=crop&q=80&w=2825&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    );
  }
}

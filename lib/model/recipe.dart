import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/model/ingredient.dart';

class RecipeModel {
  final String? id;
  String title;
  String userId;
  //Over all rating? Family rating(sambandstabell med familyId, recipeId, rating?)
  // String rating;
  String cookTime;
  bool public;
  List<Ingredient> ingredients;
  String howToText;
  String? foodPicture;

  RecipeModel({
    this.id,
    required this.userId,
    required this.title,
    // required this.rating,
    required this.cookTime,
    required this.public,
    required this.ingredients,
    required this.howToText,
    this.foodPicture,
  });

  toJson() {
    return {
      "Title": title,
      "UserId": userId,
      // "Rating": rating,
      "CookTime": cookTime,
      "Public": public,
      "Ingredients": ingredients,
      "HowToText": howToText,
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
      // rating: data["Rating"],
      cookTime: data["CookTime"],
      public: data["Public"],
      ingredients: data["Ingredients"],
      howToText: data["HowToText"],
      foodPicture: data["foodPicture"],
    );
  }
}

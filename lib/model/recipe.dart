import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeModel {
  final String? uId;
  String title;
  //Over all rating? Family rating(sambandstabell med familyId, recipeId, rating?)
  // String rating;
  String cookTime;
  bool public;
  //Måste vara en klass, ska innehålla namne, antal, måttenhet(Med en serch? ej för uppgiften?)
  List<String> ingredients;
  String howToText;
  String? foodPicture;

  RecipeModel({
    this.uId,
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
        uId: document.id,
        title: data["Title"],
        // rating: data["Rating"],
        cookTime: data["CookTime"],
        public: data["Public"],
        ingredients: data["Ingredients"],
        howToText: data["HowToText"],
        foodPicture: data["foodPicture"]);
  }
}

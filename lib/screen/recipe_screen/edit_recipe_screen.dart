import 'package:flutter/material.dart';
import 'package:recipe_app/services/firestore_service.dart';

class EditRecipeScreen extends StatelessWidget {
  final String recipeId;
  final db = FireStoreService();
  EditRecipeScreen(this.recipeId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        child: Text("edit  ${recipeId}"),
      )),
    );
  }
}

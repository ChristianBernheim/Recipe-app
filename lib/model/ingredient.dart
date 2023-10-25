import 'package:cloud_firestore/cloud_firestore.dart';

class IngredientModel {
  String? id;
  String name;

  IngredientModel({
    this.id,
    required this.name,
  });
  toJson() {
    return {
      "Name": name,
    };
  }

  factory IngredientModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return IngredientModel(
      id: document.id,
      name: data["Name"],
    );
  }
}

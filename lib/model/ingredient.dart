import 'package:cloud_firestore/cloud_firestore.dart';

class Ingredient {
  String? id;
  String name;
  double amount;
  String unit;

  Ingredient({
    this.id,
    required this.name,
    required this.amount,
    required this.unit,
  });
  toJson() {
    return {
      "Name": name,
      "Amount": amount,
      "Unit": unit,
    };
  }

  factory Ingredient.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Ingredient(
      id: document.id,
      name: data["Name"],
      amount: data["Amount"],
      unit: data["Unit"],
    );
  }
}

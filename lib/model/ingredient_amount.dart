import 'package:cloud_firestore/cloud_firestore.dart';

class IngredientAmountModel {
  String? id;
  String ingredientId;
  double amount;
  String unit;

  IngredientAmountModel({
    this.id,
    required this.ingredientId,
    required this.amount,
    required this.unit,
  });
  toJson() {
    return {
      "IngredientId": ingredientId,
      "Amount": amount,
      "Unit": unit,
    };
  }

  factory IngredientAmountModel.fromJson(Map<String, dynamic> data) {
    return IngredientAmountModel(
      ingredientId: data["IngredientId"],
      amount: data["Amount"],
      unit: data["Unit"],
    );
  }
}

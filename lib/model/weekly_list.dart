import 'package:cloud_firestore/cloud_firestore.dart';

class WeeklyListModel {
  final String? id;
  String familyId;
  String week;
  List<dynamic>? recipesID;

  WeeklyListModel({
    this.id,
    required this.familyId,
    required this.week,
    this.recipesID,
  });

  Map<String, dynamic> toJson() {
    return {
      "FamilyId": familyId,
      "Week": week,
      "RecipesID": recipesID,
    };
  }

  factory WeeklyListModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return WeeklyListModel(
      id: document.id,
      familyId: data["FamilyId"],
      week: data["Week"],
      recipesID: data["RecipesID"],
    );
  }
}

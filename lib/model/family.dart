import 'package:cloud_firestore/cloud_firestore.dart';

class FamilyModel {
  final String? id;
  String name;
  List? familyMembers;
  List? favoriteRecipes;

  FamilyModel({
    this.id,
    required this.name,
    this.familyMembers,
    this.favoriteRecipes,
  });

  toJson() {
    return {
      "Name": name,
      "FamilyMember": familyMembers,
      "FavoriteRecipes": favoriteRecipes,
    };
  }

  factory FamilyModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return FamilyModel(
      id: document.id,
      name: data["Name"],
      familyMembers: data["FamilyMembers"],
      favoriteRecipes: data["FavoriteRecipes"],
    );
  }
}

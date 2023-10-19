import 'package:cloud_firestore/cloud_firestore.dart';

class FamilyModel {
  final String? id;
  String name;
  List<dynamic>? familyMembersId;
  List<dynamic>? favoriteRecipesId;

  FamilyModel({
    this.id,
    required this.name,
    this.familyMembersId,
    this.favoriteRecipesId,
  });

  toJson() {
    return {
      "Name": name,
      "FamilyMemberId": familyMembersId,
      "FavoriteRecipesId": favoriteRecipesId,
    };
  }

  factory FamilyModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return FamilyModel(
      id: document.id,
      name: data["Name"],
      familyMembersId: data["FamilyMemberId"],
      favoriteRecipesId: data["FavoriteRecipesId"],
    );
  }
}

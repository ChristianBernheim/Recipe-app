import 'package:cloud_firestore/cloud_firestore.dart';

class FamilyModel {
  final String? id;
  String name;
  List<dynamic>? familyMembersId;
  List<dynamic>? favoriteRecipesId;
  List<dynamic>? weeklyList;

  FamilyModel(
      {this.id,
      required this.name,
      this.familyMembersId,
      this.favoriteRecipesId,
      this.weeklyList});

  Map<String, dynamic> toJson() {
    return {
      "Name": name,
      "FamilyMemberId": familyMembersId,
      "FavoriteRecipesId": favoriteRecipesId,
      "WeeklyList": weeklyList,
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
        weeklyList: data["WeeklyList"]);
  }
}

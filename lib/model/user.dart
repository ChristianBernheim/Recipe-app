import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/model/family.dart';

class UserModel {
  final String? uId;
  String userId;
  String firstname;
  String lastname;
  String gender;
  String birthday;
  String email;
  String? profilePicture;
  String? familyId;

  UserModel({
    this.uId,
    required this.userId,
    required this.firstname,
    required this.lastname,
    required this.gender,
    required this.birthday,
    required this.email,
    this.profilePicture,
    this.familyId,
  });

  toJson() {
    return {
      "UserId": userId,
      "Firstname": firstname,
      "Lastname": lastname,
      "Gender": gender,
      "Birthday": birthday,
      "Email": email,
      "ProfilePicture": profilePicture,
      "FamilyId": familyId
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        uId: document.id,
        userId: data["UserId"],
        firstname: data["Firstname"],
        lastname: data["Lastname"],
        gender: data["Gender"],
        birthday: data["Birthday"],
        email: data["Email"],
        profilePicture: data["ProfilePicture"],
        familyId: data["FamilyId"]);
  }
}

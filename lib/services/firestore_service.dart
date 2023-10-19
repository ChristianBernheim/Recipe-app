import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/model/family.dart';
import 'package:recipe_app/model/recipe.dart';
import 'package:recipe_app/model/user.dart';

class FireStoreService {
  /*********************** USER ***********************/
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  //CreateUser
  Future<void> createUser(UserModel user) async {
    await users.add(user.toJson());
  }

  //get the logged in user.
  Stream<UserModel> getUserStream(String? email) {
    var userRef = users.where("Email", isEqualTo: email);
    return userRef.snapshots().map((document) {
      var userData = document.docs.first;
      return UserModel.fromSnapshot(
          userData as DocumentSnapshot<Map<String, dynamic>>);
    });
  }

  Stream<List<UserModel>> getAllUsersInFamily(String? id) {
    return users.where("FamilyId", isEqualTo: id).snapshots().map(
        (uSnapshots) => uSnapshots.docs
            .map((e) => UserModel.fromSnapshot(
                e as DocumentSnapshot<Map<String, dynamic>>))
            .toList());
  }

/*********************** Family ***********************/
  CollectionReference familys = FirebaseFirestore.instance.collection("Family");
  //Create family
  Future<void> createFamily(FamilyModel family, UserModel user) async {
    await familys.add(family.toJson());
    user.familyId = familys.doc().id;
  }

//Get family for logged in user.
  Stream<FamilyModel> getFamilyStream(String? id) {
    var familyRef = familys.doc(id);
    return familyRef.snapshots().map((document) {
      return FamilyModel.fromSnapshot(
          document as DocumentSnapshot<Map<String, dynamic>>);
    });
  }

  /*********************** Recipe ***********************/
  CollectionReference recipies =
      FirebaseFirestore.instance.collection("Family");
  //Create family
  Future<void> createRecipe(RecipeModel recipe, UserModel user) async {
    await recipies.add(recipe.toJson());
  }

//Get family for logged in user.
  Stream<RecipeModel> getRecipe(String? id) {
    var recipeRef = recipies.doc(id);
    return recipeRef.snapshots().map((document) {
      return RecipeModel.fromSnapshot(
          document as DocumentSnapshot<Map<String, dynamic>>);
    });
  }
}

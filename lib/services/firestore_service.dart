import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/model/family.dart';
import 'package:recipe_app/model/ingredient_stuff.dart';
import 'package:recipe_app/model/recipe.dart';
import 'package:recipe_app/model/user.dart';
import 'package:recipe_app/model/ingredient.dart';

class FireStoreService {
  /*********************** USER ***********************/
  CollectionReference users = FirebaseFirestore.instance.collection("Users");

  Future<void> createUser(UserModel user) async {
    await users.add(user.toJson());
  }

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

  Future<void> updateUser(UserModel user) async {
    await users.doc(user.uId).update(user.toJson());
  }

  Future<void> deleteUser(String id) async {
    await users.doc(id).delete();
  }

  /*********************** Family ***********************/
  CollectionReference families =
      FirebaseFirestore.instance.collection("Family");

  Future<void> createFamily(FamilyModel family, UserModel user) async {
    var familyDocRef = await families.add(family.toJson());
    user.familyId = familyDocRef.id;
    await users.doc(user.uId).update({'FamilyId': user.familyId});
  }

  Stream<FamilyModel> getFamilyStream(String? id) {
    var familyRef = families.doc(id);
    return familyRef.snapshots().map((document) {
      return FamilyModel.fromSnapshot(
          document as DocumentSnapshot<Map<String, dynamic>>);
    });
  }

  Future<void> updateFamily(FamilyModel family) async {
    await families.doc(family.id).update(family.toJson());
  }

  Future<void> deleteFamily(String id) async {
    await families.doc(id).delete();
  }

  /*********************** Recipe ***********************/
  CollectionReference recipes =
      FirebaseFirestore.instance.collection("Recipes");

  Future<void> createRecipe(RecipeModel recipe) async {
    await recipes.add(recipe.toJson());
  }

  Stream<RecipeModel> getRecipe(String? id) {
    var recipeRef = recipes.doc(id);
    return recipeRef.snapshots().map((document) {
      return RecipeModel.fromSnapshot(
          document as DocumentSnapshot<Map<String, dynamic>>);
    });
  }

  Future<void> updateRecipe(RecipeModel recipe) async {
    await recipes.doc(recipe.id).update(recipe.toJson());
  }

  Future<void> deleteRecipe(String id) async {
    await recipes.doc(id).delete();
  }

  /*********************** Ingredient ***********************/
  CollectionReference ingredients =
      FirebaseFirestore.instance.collection("Ingredients");

  Future<DocumentReference> createIngredient(IngredientModel ingredient) async {
    return await ingredients.add(ingredient.toJson());
  }

  Stream<IngredientModel> getIngredient(String? id) {
    var ingredientRef = ingredients.doc(id);
    return ingredientRef.snapshots().map((document) {
      return IngredientModel.fromSnapshot(
          document as DocumentSnapshot<Map<String, dynamic>>);
    });
  }

  Stream<IngredientModel> getIngredientByName(String name) {
    var ingredientRef = ingredients.where('name', isEqualTo: name).limit(1);
    return ingredientRef.snapshots().map((querySnapshot) {
      var document = querySnapshot.docs.first;
      return IngredientModel.fromSnapshot(
          document as DocumentSnapshot<Map<String, dynamic>>);
    });
  }

  Future<void> updateIngredient(IngredientModel ingredient) async {
    await ingredients.doc(ingredient.id).update(ingredient.toJson());
  }

  Future<void> deleteIngredient(String id) async {
    await ingredients.doc(id).delete();
  }

  /*********************** IngredientAmount ***********************/
  CollectionReference ingredientAmountModel =
      FirebaseFirestore.instance.collection("IngredientAmount");

  Future<void> createIngredientAmount(
      IngredientAmountModel ingredientAmount) async {
    await ingredientAmountModel.add(ingredientAmount.toJson());
  }

  Stream<IngredientModel> getIngredientAmount(String? id) {
    var ingredientRef = ingredientAmountModel.doc(id);
    return ingredientRef.snapshots().map((document) {
      return IngredientModel.fromSnapshot(
          document as DocumentSnapshot<Map<String, dynamic>>);
    });
  }

  Future<void> updateIngredientAmount(
      IngredientAmountModel ingredientAmount) async {
    await ingredientAmountModel
        .doc(ingredientAmount.id)
        .update(ingredientAmount.toJson());
  }

  Future<void> deleteIngredientAmount(String id) async {
    await ingredientAmountModel.doc(id).delete();
  }
}

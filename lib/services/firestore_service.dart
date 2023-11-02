import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/model/family.dart';
import 'package:recipe_app/model/ingredient_amount.dart';
import 'package:recipe_app/model/recipe.dart';
import 'package:recipe_app/model/user.dart';
import 'package:recipe_app/model/ingredient.dart';
import 'package:recipe_app/model/weekly_list.dart';

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

  Stream<List<RecipeModel>> getAllRecipesStream() {
    var recipieS = recipes.snapshots().map((uSnapshots) {
      return uSnapshots.docs.map((doc) {
        return RecipeModel.fromSnapshot(
            doc as DocumentSnapshot<Map<String, dynamic>>);
      }).toList();
    });
    return recipieS;
  }

  Future<List<RecipeModel>> getAllRecipeFuture() async {
    List<RecipeModel> recipieList = [];
    var recipies = await recipes.get();
    for (var doc in recipies.docs) {
      recipieList.add(RecipeModel.fromSnapshot(
          doc as DocumentSnapshot<Map<String, dynamic>>));
    }
    return recipieList;
  }

  Stream<List<RecipeModel>> getCertainRecipesStream(List<dynamic> recipeIds) {
    if (recipeIds == null || recipeIds == [])
      print("null recept fan $recipeIds");
    var recipieS = recipes.snapshots().map((uSnapshots) {
      return uSnapshots.docs
          .map((doc) {
            return RecipeModel.fromSnapshot(
                doc as DocumentSnapshot<Map<String, dynamic>>);
          })
          .where((recipe) => recipeIds.contains(recipe.id))
          .toList();
    });
    print("recept eller type så: $recipieS");
    return recipieS;
  }

  Stream<List<RecipeModel>> getAllMyRecipesStream(String userId) {
    var recipeRef = recipes.where('UserId', isEqualTo: userId);
    return recipeRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return RecipeModel.fromSnapshot(
            doc as DocumentSnapshot<Map<String, dynamic>>);
      }).toList();
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

  Stream<List<IngredientModel>> getAllIngredients() {
    var ingredientsRef = ingredients.snapshots();
    return ingredientsRef.map((querySnapshot) {
      return querySnapshot.docs.map((document) {
        return IngredientModel.fromSnapshot(
            document as DocumentSnapshot<Map<String, dynamic>>);
      }).toList();
    });
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

  Future<List<IngredientModel>> getIngredientsByPartialName(
      String partialName) async {
    var ingredientsRef = await ingredients.get();
    var allIngredients = ingredientsRef.docs.map(
      (document) => IngredientModel.fromSnapshot(
        document as DocumentSnapshot<Map<String, dynamic>>,
      ),
    );

    return allIngredients
        .where((ingredient) =>
            ingredient.name.toLowerCase().contains(partialName.toLowerCase()))
        .toList();
  }

  Future<bool> doesIngredientExist(String ingredientName) async {
    try {
      QuerySnapshot querySnapshot = await ingredients
          .where('name', isEqualTo: ingredientName)
          .limit(1)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print("Error checking if ingredient exists: $e");
      return false; // Handle the error according to your application's needs
    }
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

  /*********************** Weekly List ***********************/
  CollectionReference weeklyLists =
      FirebaseFirestore.instance.collection("WeeklyList");

  Future<String> createWeeklyList(WeeklyListModel weeklyListModel) async {
    DocumentReference docRef = await weeklyLists.add(weeklyListModel.toJson());

    // Return the ID of the newly created document
    return docRef.id;
  }

  Stream<WeeklyListModel> getWeeklyList(String week, String familyId) {
    var weeklyListRef = weeklyLists
        .where("Week", isEqualTo: week)
        .where("FamilyId", isEqualTo: familyId);
    return weeklyListRef.snapshots().map(
      (snapshot) {
        print('QuerySnapshot docs: ${snapshot.docs.map((e) => e.id)}');
        return snapshot.docs.map((doc) {
          return WeeklyListModel.fromSnapshot(
              doc as DocumentSnapshot<Map<String, dynamic>>);
        }).first;
      },
    );
  }

  Future<void> updateWeeklyList(WeeklyListModel weeklyList) async {
    await weeklyLists.doc(weeklyList.id).update(weeklyList.toJson());
  }

  Future<void> deleteWeeklyList(String id) async {
    await weeklyLists.doc(id).delete();
  }
}

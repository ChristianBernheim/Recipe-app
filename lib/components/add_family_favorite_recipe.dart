import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/screen/home_screen.dart';
import 'package:recipe_app/screen/main_logged_in_screen.dart';
import 'package:recipe_app/screen/settings+profile_screen/family_screen.dart';
import 'package:recipe_app/services/firestore_service.dart';

class AddFamilyFavoriteRecipe extends StatelessWidget {
  final String recipeId;

  AddFamilyFavoriteRecipe(this.recipeId);
  final authUser = FirebaseAuth.instance.currentUser;
  final db = FireStoreService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: db.getUserStream(authUser!.email),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Error: ${snapshot.error}");
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          final user = snapshot.data;
          if (user!.familyId != null) {
            return StreamBuilder(
              stream: db.getFamilyStream(user.familyId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print("Error: ${snapshot.error}");
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  final family = snapshot.data;
                  if (family!.favoriteRecipesId == null) {
                    family.favoriteRecipesId = [];
                  }
                  if (!family!.favoriteRecipesId!.contains(recipeId)) {
                    family.favoriteRecipesId!.add(recipeId);
                    db.updateFamily(family);
                  }

                  return MainLoggedInScreen();
                }
              },
            );
          } else {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    "You don't have a family. Do you want to join or create a family?"),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FamilyScreen(),
                      ),
                    );
                  },
                  child: Text("Go to Family Page"),
                ),
              ],
            );
          }
        }
      },
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/components/add_family_favorite_recipe.dart';
import 'package:recipe_app/components/recipe_tile.dart';
import 'package:recipe_app/components/title_tile.dart';
import 'package:recipe_app/model/family.dart';
import 'package:recipe_app/model/recipe.dart';
import 'package:recipe_app/screen/recipe_screen/create_recipe_screen.dart';
import 'package:recipe_app/screen/recipe_screen/edit_recipe_screen.dart';
import 'package:recipe_app/screen/recipe_screen/recipe_screen.dart';
import 'package:recipe_app/screen/settings+profile_screen/family_screen.dart';
import 'package:recipe_app/services/firestore_service.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  final authUser = FirebaseAuth.instance.currentUser;
  final db = FireStoreService();
  var query;
  List<RecipeModel> allRecipes = [];
  List<RecipeModel> searchResults = [];
  List<String> familyAddRecipeList = [];
  void addToFamilyFavorites(BuildContext context, String recipeId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add to Family Favorites"),
          content: Text(
              "Are you sure you want to add this recipe to your family favorites?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddFamilyFavoriteRecipe(recipeId),
                  ),
                );
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  void searchRecipes(String query) {
    setState(() {
      searchResults.clear();
      for (RecipeModel recipe in allRecipes) {
        if (recipe.title.contains(query)) {
          searchResults.add(recipe);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateRecipeScreen()),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: TitleTile(title: "What do you want to cook today?"),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: TextField(
                          controller: searchController,
                          onChanged: (query) {
                            searchRecipes(query);
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.search),
                            hintText: "Search for recipes",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(Icons.tune),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Trending",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                StreamBuilder(
                  stream: db.getAllRecipesStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            allRecipes = snapshot.data!;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RecipeScreen(allRecipes[index].id!),
                                  ),
                                );
                              },
                              onLongPress: () {
                                addToFamilyFavorites(
                                    context, allRecipes[index].id!);
                              },
                              child: RecipeCard(
                                recipeImage: allRecipes[index].foodPicture,
                                title: allRecipes[index].title,
                                cookTime: allRecipes[index].cookTime,
                              ),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print("Error: ${snapshot.error}");
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Text('No recipes available');
                    }
                  },
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Family favorites",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                StreamBuilder(
                    stream: db.getUserStream(authUser!.email),
                    builder: ((context, snapshot) {
                      if (snapshot.hasError) {
                        print("Error: ${snapshot.error}");
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
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

                                if (family != null &&
                                    family.favoriteRecipesId != null &&
                                    family.favoriteRecipesId != "") {
                                  return StreamBuilder(
                                    stream: db.getCertainRecipesStream(
                                        family.favoriteRecipesId!),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        print(
                                            "Error fetching recipes: ${snapshot.error}");
                                        return Text('Error: ${snapshot.error}');
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (snapshot.hasData) {
                                        return Container(
                                          height: 200,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final familyRecipes =
                                                  snapshot.data!;

                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          RecipeScreen(
                                                              familyRecipes[
                                                                      index]
                                                                  .id!),
                                                    ),
                                                  );
                                                },
                                                child: RecipeCard(
                                                  recipeImage:
                                                      familyRecipes[index]
                                                          .foodPicture,
                                                  title: familyRecipes[index]
                                                      .title,
                                                  cookTime: familyRecipes[index]
                                                      .cookTime,
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      } else {
                                        return Text('No recipes available');
                                      }
                                    },
                                  );
                                } else {
                                  return Text(
                                      'No family favorite recipes available');
                                }
                              }
                            },
                          );
                        } else {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                  "You got no family, do you want to join or create a family?"),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FamilyScreen()),
                                    );
                                  },
                                  child: Text("Go to familypage"))
                            ],
                          );
                        }
                      }
                    })),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "My recipes",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                StreamBuilder(
                  stream: db.getAllMyRecipesStream(authUser!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data != [] && snapshot.data != null) {
                        print("Allrecipies testtest: ${snapshot.data}");
                        return Container(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              allRecipes = snapshot.data!;
                              print("Allrecipies testtest: $allRecipes");
                              return GestureDetector(
                                onTap: () {
                                  String? recipeId = allRecipes[index].id!;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditRecipeScreen(recipeId),
                                    ),
                                  );
                                },
                                child: RecipeCard(
                                  recipeImage: allRecipes[index].foodPicture,
                                  title: allRecipes[index].title,
                                  cookTime: allRecipes[index].cookTime,
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Text("You have not created any recipes.");
                      }
                    } else if (snapshot.hasError) {
                      print("Error: ${snapshot.error}");
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Text('No recipes available');
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

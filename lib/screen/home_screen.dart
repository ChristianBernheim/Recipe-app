// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, duplicate_ignore, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/screen/add_recipe_screen.dart';
import 'package:recipe_app/widgets/recipe_tile.dart';
import 'package:recipe_app/widgets/title_tile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddRecipeScreen()),
            );
          },
          backgroundColor: Theme.of(context).colorScheme.background,
          child: Icon(Icons.add),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.primary,
            ],
          )),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    alignment: Alignment.center,
                    child: TitleTile(title: "What do you want to cook today?")),
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
                            borderRadius: BorderRadius.circular(14)),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.search),
                            hintText: "Serch for recipes",
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
                          borderRadius: BorderRadius.circular(14)),
                      child: Icon(Icons.tune),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Family Favorites",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      RecipeCard(
                        title: "Title1",
                        description: "Description for Title1",
                      ),
                      RecipeCard(
                        title: "Title2",
                        description: "Description for Title2",
                      ),
                      RecipeCard(
                        title: "Title3",
                        description: "Description for Title3",
                      ),
                      RecipeCard(
                        title: "Title4",
                        description:
                            "Title2SD FASDLKJG ADNKFJL ADSGLKJ ADSLKFJN ADSLKFJN DSLKFN ADSJKLFN SADKLNF SADJKFN SDJAKLFN DSKJLF NDKJLSFN KSJFLN KJLFN",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Trending recepies",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      //Do on tap for all recipe card and go to recipe_screen with ID
                      RecipeCard(
                        //Instead of Title, descpr and picture need to get from api or db
                        title: "Title5",
                        description: "Description for Title5",
                      ),

                      RecipeCard(
                        title: "Title6",
                        description: "Description for Title6",
                      ),
                      RecipeCard(
                        title: "Title7",
                        description: "Description for Title7",
                      ),
                      RecipeCard(
                        title: "Title8",
                        description:
                            "Title8 Description is a bit longer than others.",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

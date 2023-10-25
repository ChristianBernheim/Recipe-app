import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/screen/recipe%20screen/create_recipe_screen.dart';
import 'package:recipe_app/components/recipe_tile.dart';
import 'package:recipe_app/components/title_tile.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  TextEditingController searchController = TextEditingController();
  List<RecipeCard> allRecipeCards = [
    RecipeCard(
      title: "Hawaiigratäng",
      description: "Description for Title1",
    ),
    RecipeCard(
      title: "Köttfärssås och spagetti",
      description: "Description for Title2",
    ),
    RecipeCard(
      title: "Köttbullar, gräddsås och potatis",
      description: "Description for Title3",
    ),
    RecipeCard(
      title: "Pannkakor",
      description:
          "Title2SD FASDLKJG ADNKFJL ADSGLKJ ADSLKFJN ADSLKFJN DSLKFN ADSJKLFN SADKLNF SADJKFN SDJAKLFN DSKJLF NDKJLSFN KSJFLN KJLFN",
    ),
    RecipeCard(
      title: "Pannbiff med lök",
      description: "Description for Title5",
    ),
    RecipeCard(
      title: "Kebab",
      description: "Description for Title6",
    ),
    RecipeCard(
      title: "Tacos",
      description: "Description for Title7",
    ),
    RecipeCard(
      title: "Kyckling och curryris",
      description: "ölöl",
    ),
  ];

  List<RecipeCard> displayedRecipeCards = [];

  @override
  void initState() {
    displayedRecipeCards = List.from(allRecipeCards);
    super.initState();
  }

  void searchRecipes(String query) {
    setState(() {
      displayedRecipeCards = allRecipeCards
          .where((recipe) =>
              recipe.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Theme.of(context).colorScheme.background,
                Theme.of(context).colorScheme.primary,
              ],
            ),
          ),
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
                          onChanged: searchRecipes,
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
                    "Search Results",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: displayedRecipeCards.map((recipe) {
                      return RecipeCard(
                        title: recipe.title,
                        description: recipe.description,
                      );
                    }).toList(),
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

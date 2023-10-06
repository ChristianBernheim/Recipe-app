// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, duplicate_ignore, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              const Color.fromARGB(255, 181, 203, 153),
              Color.fromARGB(255, 44, 108, 100),
            ],
          )),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  "My Favorite",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // ignore: sized_box_for_whitespace
                Container(
                  height: 200, // Adjust the height as needed
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
                Text(
                  "Last Checked Recipes",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 200, // Adjust the height as needed
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      //Do same for all
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            //Check up how to style this.
                            backgroundColor:
                                const Color.fromARGB(0, 255, 255, 255)),
                        onPressed: () {
                          //Gotopage for recipe with id for recipe
                        },
                        child: RecipeCard(
                          //Instead of Title, descpr and picture need to get from api or db
                          title: "Title5",
                          description: "Description for Title5",
                        ),
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

class RecipeCard extends StatelessWidget {
  final String title;
  final String description;

  const RecipeCard({required this.title, this.description = ""});

  @override
  Widget build(BuildContext context) {
    return Card(
      color:
          (Color.fromARGB(10, 255, 255, 255)), // Set the card background color
      margin: EdgeInsets.all(8.0),
      child: Container(
        width: 150, // Adjust the width as needed
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100, // Adjust the height for the image
              width: double.infinity,

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "lib/image/food.jpg",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  description,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

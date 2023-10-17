import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/screen/basic_goods_screen.dart';
import 'package:recipe_app/screen/home_screen.dart';
import 'package:recipe_app/components/grocery_tile.dart';
import 'package:recipe_app/components/title_tile.dart';

class GroceryListScreen extends StatefulWidget {
  GroceryListScreen({super.key});

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  List groceries = [
    [false, "Bananas", 4, "st"],
    [false, "Apples", 2, "st"],
    [false, "Mjölk", 4, "liter"],
    [false, "Mjöl", 1, "kg"],
    [false, "Pepsi", 2, "st"],
  ];

  void groceryPickedUp(bool? value, int index) {
    setState(() {
      groceries[index][0] = !groceries[index][0];
    });
  }

  void addGroceriesToList() {
    showDialog(
        context: context,
        builder: (context) {
          return BasicGoodScreen();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: addGroceriesToList,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: IconTheme(
            data: new IconThemeData(
                color: Theme.of(context).colorScheme.background),
            child: new Icon(Icons.add)),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleTile(title: "Groceries"),
              SizedBox(
                height: MediaQuery.of(context).size.height - 140,
                width: MediaQuery.of(context).size.width - 30,
                child: ListView.builder(
                    itemCount: groceries.length,
                    itemBuilder: (
                      BuildContext context,
                      int index,
                    ) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            groceryPickedUp(!groceries[index][0], index);
                          });
                        },
                        child: GroceryTile(
                            groceryPickedUp: groceries[index][0],
                            onChanged: (value) {
                              groceryPickedUp(value, index);
                            },
                            title: groceries[index][1],
                            amount: groceries[index][2],
                            unit: groceries[index][3]),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

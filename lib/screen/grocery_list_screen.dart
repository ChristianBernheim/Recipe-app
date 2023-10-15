import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/grocery_tile.dart';
import 'package:recipe_app/widgets/title_tile.dart';

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

  void checkBoxChange(bool? value, int index) {
    setState(() {
      groceries[index][0] = !groceries[index][0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        width: double.infinity,
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
                            checkBoxChange(!groceries[index][0], index);
                          });
                        },
                        child: GroceryTile(
                            groceryPickedUp: groceries[index][0],
                            onChanged: (value) {
                              checkBoxChange(value, index);
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
